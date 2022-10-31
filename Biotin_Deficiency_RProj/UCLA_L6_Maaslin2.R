library(Maaslin2)
library(funrar)
library(dplyr)
library(ggplot2)
library(cowplot)
library(plyr)
setwd("C:/Users/Jacobs Laboratory/Documents/JCYang/Biotin Deficiency 2022 Final/")

### Read in histo phenotypic data and merge with metadata 
input_metadata <-read.delim("UCLA/starting_files/Metadata.tsv",sep="\t",header=TRUE, row.names=1) #mapping file
data<- read.csv("UCLA/Phenotypic_Data_UCLA.csv", header = TRUE)
data$Mouse.ID <- data$MouseID
data<-select(data,-c("Group", "MouseID"))
input_metadata <- merge(input_metadata,data,by="Mouse.ID")
row.names(input_metadata) <-input_metadata$Description

write.table(input_metadata, "UCLA/starting_files/Histo_Metadata.tsv", sep="\t")

### Run Maaslin2 and get table of relative abundances

run_Maaslin2 <- function(counts_filepath, metadata_filepath, subset_string) {
#input_data <- read.csv("UCLA/collapsed_ASV_tables/L6 - Stool.csv", header=TRUE, row.names=1) # choose filtered non rarefied csv file
input_data <- read.csv(counts_filepath, header=TRUE, row.names=1) # choose filtered non rarefied csv file


df_input_data <- as.data.frame(input_data)
df_input_data <- select(df_input_data, -c("taxonomy"))

transposed_input_data <- t(df_input_data)
transposed_input_data <- as.matrix(transposed_input_data) #taxa are now columns, samples are rows. 
df_relative_ASV <- make_relative(transposed_input_data)
df_relative_ASV <- as.data.frame(df_relative_ASV)
Relative_Abundance <- summarize_all(df_relative_ASV, mean)
Relative_Abundance <- as.data.frame(t(Relative_Abundance))

readr::write_rds(Relative_Abundance,paste0("UCLA/collapsed_ASV_tables/Relative_Abundance-",subset_string,"-L6.RDS"))

input_metadata <-read.delim(metadata_filepath,sep="\t",header=TRUE, row.names=1)

target <- colnames(df_input_data)
input_metadata = input_metadata[match(target, row.names(input_metadata)),]
target == row.names(input_metadata)

df_input_metadata<-input_metadata
df_input_metadata$Mouse.ID <- factor(df_input_metadata$Mouse.ID)
df_input_metadata$Diet <- factor(df_input_metadata$Group, levels=c("Control","BD"))
df_input_metadata$Sex <- factor(df_input_metadata$Sex)
sapply(df_input_metadata,levels)

?Maaslin2
fit_data = Maaslin2(input_data=df_input_data, 
                    input_metadata=df_input_metadata, 
                    output = paste0("UCLA/",subset_string,"_L6_Maaslin2_Sex_Diet"), 
                    fixed_effects = c("Sex","Diet"),normalization="TSS", 
                    min_prevalence = 0.1875,
                    transform ="log",plot_heatmap = FALSE,plot_scatter = FALSE)
}

## Sex and Diet only 

# stool 
run_Maaslin2("UCLA/collapsed_ASV_tables/L6 - Stool.csv","UCLA/starting_files/Metadata.tsv","Stool")

# cecum 
run_Maaslin2("UCLA/collapsed_ASV_tables/L6 - adherent_cecum.csv","UCLA/starting_files/Metadata.tsv","Cecum")

# SI adherent 
run_Maaslin2("UCLA/collapsed_ASV_tables/L6 - SI_adherent.csv","UCLA/starting_files/Metadata.tsv","SI_adherent")

# SI luminal
run_Maaslin2("UCLA/collapsed_ASV_tables/L6 - SI_luminal.csv","UCLA/starting_files/Metadata.tsv","SI_luminal")

## Sex, Diet, and Histo 
run_Maaslin2_histo <- function(counts_filepath, metadata_filepath, subset_string, select_string) {
  #input_data <- read.csv("UCLA/collapsed_ASV_tables/L6 - Stool.csv", header=TRUE, row.names=1) # choose filtered non rarefied csv file
  input_data <- read.csv(counts_filepath, header=TRUE, row.names=1) # choose filtered non rarefied csv file
  
  
  df_input_data <- as.data.frame(input_data)
  df_input_data <- select(df_input_data, -c("taxonomy"))
  
  #input_metadata <-read.delim("UCLA/starting_files/Histo_Metadata.tsv",sep="\t",header=TRUE, row.names=1)
  
  input_metadata <-read.delim(metadata_filepath,sep="\t",header=TRUE, row.names=1)
  
  target <- colnames(df_input_data)
  input_metadata = input_metadata[match(target, row.names(input_metadata)),]
  print(target == row.names(input_metadata))
  
  df_input_metadata<-input_metadata
  df_input_metadata$Mouse.ID <- factor(df_input_metadata$Mouse.ID)
  df_input_metadata$Diet <- factor(df_input_metadata$Group, levels=c("Control","BD"))
  df_input_metadata$Sex <- factor(df_input_metadata$Sex)
  sapply(df_input_metadata,levels)
  
  ?Maaslin2
  if(select_string=="sex_diet_histo"){
  fit_data = Maaslin2(input_data=df_input_data, 
                      input_metadata=df_input_metadata, 
                      output = paste0("UCLA/",subset_string,"_L6_Maaslin2_Sex_Diet_Histology"), 
                      fixed_effects = c("Sex","Diet", "Histology"),normalization="TSS", 
                      min_prevalence = 0.1875,
                      transform ="log",plot_heatmap = FALSE,plot_scatter = FALSE)
  }
  if(select_string=="sex_histo"){
    fit_data = Maaslin2(input_data=df_input_data, 
                        input_metadata=df_input_metadata, 
                        output = paste0("UCLA/",subset_string,"_L6_Maaslin2_Sex_Histology"), 
                        fixed_effects = c("Sex", "Histology"),normalization="TSS", 
                        min_prevalence = 0.1875,
                        transform ="log",plot_heatmap = FALSE,plot_scatter = FALSE)
  }
  if(select_string=="histo"){
    fit_data = Maaslin2(input_data=df_input_data, 
                        input_metadata=df_input_metadata, 
                        output = paste0("UCLA/",subset_string,"_L6_Maaslin2_Histology"), 
                        fixed_effects = c("Histology"),normalization="TSS", 
                        min_prevalence = 0.1875,
                        transform ="log",plot_heatmap = FALSE,plot_scatter = FALSE)
  }
}

# stool 
run_Maaslin2_histo("UCLA/collapsed_ASV_tables/L6 - Stool.csv","UCLA/starting_files/Histo_Metadata.tsv","Stool", "sex_diet_histo")
run_Maaslin2_histo("UCLA/collapsed_ASV_tables/L6 - Stool.csv","UCLA/starting_files/Histo_Metadata.tsv","Stool", "sex_histo")
run_Maaslin2_histo("UCLA/collapsed_ASV_tables/L6 - Stool.csv","UCLA/starting_files/Histo_Metadata.tsv","Stool", "histo")

# cecum 
run_Maaslin2_histo("UCLA/collapsed_ASV_tables/L6 - adherent_cecum.csv","UCLA/starting_files/Histo_Metadata.tsv","Cecum", "sex_diet_histo")
run_Maaslin2_histo("UCLA/collapsed_ASV_tables/L6 - adherent_cecum.csv","UCLA/starting_files/Histo_Metadata.tsv","Cecum", "sex_histo")
run_Maaslin2_histo("UCLA/collapsed_ASV_tables/L6 - adherent_cecum.csv","UCLA/starting_files/Histo_Metadata.tsv","Cecum", "histo")

# SI adherent 
run_Maaslin2_histo("UCLA/collapsed_ASV_tables/L6 - SI_adherent.csv","UCLA/starting_files/Histo_Metadata.tsv","SI_adherent", "sex_diet_histo")
run_Maaslin2_histo("UCLA/collapsed_ASV_tables/L6 - SI_adherent.csv","UCLA/starting_files/Histo_Metadata.tsv","SI_adherent", "sex_histo")
run_Maaslin2_histo("UCLA/collapsed_ASV_tables/L6 - SI_adherent.csv","UCLA/starting_files/Histo_Metadata.tsv","SI_adherent", "histo")

# SI luminal
run_Maaslin2_histo("UCLA/collapsed_ASV_tables/L6 - SI_luminal.csv","UCLA/starting_files/Histo_Metadata.tsv","SI_luminal", "sex_diet_histo")
run_Maaslin2_histo("UCLA/collapsed_ASV_tables/L6 - SI_luminal.csv","UCLA/starting_files/Histo_Metadata.tsv","SI_luminal", "sex_histo")
run_Maaslin2_histo("UCLA/collapsed_ASV_tables/L6 - SI_luminal.csv","UCLA/starting_files/Histo_Metadata.tsv","SI_luminal", "histo")

### Make a Dotplot: Sex and Diet  ---

phyla_colors <- c("#F8766D", "#A3A500", "#00BF7D", "#00B0F6", "#E76BF3")
names(phyla_colors)<-unique(data$Phylum)

readr::write_rds(phyla_colors, "UCLA/phylacolors.RDS")

# stool
data<-read.table("UCLA/Stool_L6_Maaslin2_Sex_Diet/significant_results.tsv", header=TRUE)
data <- data %>% filter(qval <0.05)
data <- data %>% filter(metadata=="Diet")
data$Phylum <- gsub(".*p__","",data$feature)
data$Phylum <- gsub("\\..*","",data$Phylum)
data$Family<- gsub(".*f__","",data$feature)
data$Family <- gsub("\\..*","",data$Family)
data$Genus<- gsub(".*g__","",data$feature)
#data$Genus <- gsub("\\..*","",data$Genus)
data <- data %>% mutate(feature = ifelse(data$Genus=="", paste(data$Family,"(f)"), data$Genus))

#append relative abundance data 
relA <- readRDS("UCLA/collapsed_ASV_tables/Relative_Abundance-stool-L6.RDS")
relA$feature <- row.names(relA)
relA$Family <- gsub(".*f__","",relA$feature)
relA$Family <- gsub("-",".",relA$Family)
relA$Family <- gsub(";.*","",relA$Family)
relA$Genus <- gsub(".*g__","",relA$feature)
relA$Genus <- gsub("-",".",relA$Genus)
relA<- relA %>% mutate(feature = ifelse(relA$Genus=="", paste(relA$Family,"(f)"), relA$Genus))
relA$Relative_Abundance<-relA$V1

data<-merge(data,relA,by="feature")
min(data$Relative_Abundance)
max(data$Relative_Abundance)
#make graph
y = tapply(data$coef, data$feature, function(y) max(y))  # orders the genera by the highest fold change of any ASV in the genus; can change max(y) to mean(y) if you want to order genera by the average log2 fold change
y = sort(y, FALSE)   #switch to TRUE to reverse direction
data$feature= factor(as.character(data$feature), levels = names(y))
ggplot(data, aes(x = coef, y = feature, color = Phylum)) + 
  geom_point(aes(size = sqrt(Relative_Abundance))) + 
  scale_size_continuous(name="Relative Abundance",range = c(0.5,8),
                        limits=c(sqrt(0.0001),sqrt(0.3)),
                        breaks=c(sqrt(0.0001),sqrt(0.001),sqrt(0.01),sqrt(0.1)),
                        labels=c("0.0001","0.001","0.01","0.1")) + 
  scale_color_manual(name="Phylum", values = phyla_colors)+
  geom_vline(xintercept = 0) + 
  xlab(label="Log2 Fold Change")+
  ylab(label=NULL)+
  theme_cowplot(12) +
  ggtitle("Stool: Genus ~ Sex + Diet") +
  theme(plot.title = element_text(hjust = 0.5)) +
  theme(legend.background = element_rect(fill="lightblue", size=0.5, linetype="solid")) 

# Cecum
data<-read.table("UCLA/Cecum_L6_Maaslin2_Sex_Diet/significant_results.tsv", header=TRUE)
data <- data %>% filter(qval <0.05)
data <- data %>% filter(metadata=="Diet")
data$Phylum <- gsub(".*p__","",data$feature)
data$Phylum <- gsub("\\..*","",data$Phylum)
data$Family<- gsub(".*f__","",data$feature)
data$Family <- gsub("\\..*","",data$Family)
data$Genus<- gsub(".*g__","",data$feature)
#data$Genus <- gsub("\\..*","",data$Genus)
data <- data %>% mutate(feature = ifelse(data$Genus=="", paste(data$Family,"(f)"), data$Genus))

#append relative abundance data 
relA <- readRDS("UCLA/collapsed_ASV_tables/Relative_Abundance-Cecum-L6.RDS")
relA$feature <- row.names(relA)
relA$Family <- gsub(".*f__","",relA$feature)
relA$Family <- gsub("-",".",relA$Family)
relA$Family <- gsub(";.*","",relA$Family)
relA$Genus <- gsub(".*g__","",relA$feature)
relA$Genus <- gsub("-",".",relA$Genus)
relA<- relA %>% mutate(feature = ifelse(relA$Genus=="", paste(relA$Family,"(f)"), relA$Genus))
relA$Relative_Abundance<-relA$V1

data<-merge(data,relA,by="feature")
min(data$Relative_Abundance)
max(data$Relative_Abundance)
#make graph
y = tapply(data$coef, data$feature, function(y) max(y))  # orders the genera by the highest fold change of any ASV in the genus; can change max(y) to mean(y) if you want to order genera by the average log2 fold change
y = sort(y, FALSE)   #switch to TRUE to reverse direction
data$feature= factor(as.character(data$feature), levels = names(y))
ggplot(data, aes(x = coef, y = feature, color = Phylum)) + 
  geom_point(aes(size = sqrt(Relative_Abundance))) + 
  scale_size_continuous(name="Relative Abundance",range = c(0.5,8),
                        limits=c(sqrt(0.0001),sqrt(0.3)),
                        breaks=c(sqrt(0.0001),sqrt(0.001),sqrt(0.01),sqrt(0.1)),
                        labels=c("0.0001","0.001","0.01","0.1")) + 
  scale_color_manual(name="Phylum", values = phyla_colors)+
  geom_vline(xintercept = 0) + 
  xlab(label="Log2 Fold Change")+
  ylab(label=NULL)+
  theme_cowplot(12) +
  ggtitle("Cecum: Genus ~ Sex + Diet") +
  theme(plot.title = element_text(hjust = 0.5)) +
  theme(legend.background = element_rect(fill="lightblue", size=0.5, linetype="solid")) 

# SI adherent
data<-read.table("UCLA/SI_adherent_L6_Maaslin2_Sex_Diet/significant_results.tsv", header=TRUE)
data <- data %>% filter(qval <0.05)
data <- data %>% filter(metadata=="Diet")
data$Phylum <- gsub(".*p__","",data$feature)
data$Phylum <- gsub("\\..*","",data$Phylum)
data$Order<- gsub(".*o__","",data$feature)
data$Order <- gsub("\\..*","",data$Order)
data$Family<- gsub(".*f__","",data$feature)
data$Family <- gsub("\\..*","",data$Family)
data$Genus<- gsub(".*g__","",data$feature)
#data$Genus <- gsub("\\..*","",data$Genus)
data <- data %>% mutate(feature1 = ifelse(data$Genus=="", paste(data$Family,"(f)"), data$Genus))
data <- data %>% mutate(feature = ifelse(data$feature1==" (f)", paste(data$Order,"(o)"), data$feature1))

#append relative abundance data 
relA <- readRDS("UCLA/collapsed_ASV_tables/Relative_Abundance-SI_adherent-L6.RDS")
relA$feature <- row.names(relA)
relA$Order <- gsub(".*o__","",relA$feature)
relA$Order <- gsub("-",".",relA$Order)
relA$Order <- gsub(";.*","",relA$Order)
relA$Family <- gsub(".*f__","",relA$feature)
relA$Family <- gsub("-",".",relA$Family)
relA$Family <- gsub(";.*","",relA$Family)
relA$Genus <- gsub(".*g__","",relA$feature)
relA$Genus <- gsub("-",".",relA$Genus)
relA<- relA %>% mutate(feature1 = ifelse(relA$Genus=="", paste(relA$Family,"(f)"), relA$Genus))
relA<- relA %>% mutate(feature = ifelse(relA$feature1==" (f)", paste(relA$Order,"(o)"), relA$feature1))
relA$Relative_Abundance<-relA$V1

data<-merge(data,relA,by="feature")
min(data$Relative_Abundance)
max(data$Relative_Abundance)
#make graph
y = tapply(data$coef, data$feature, function(y) max(y))  # orders the genera by the highest fold change of any ASV in the genus; can change max(y) to mean(y) if you want to order genera by the average log2 fold change
y = sort(y, FALSE)   #switch to TRUE to reverse direction
data$feature= factor(as.character(data$feature), levels = names(y))
ggplot(data, aes(x = coef, y = feature, color = Phylum)) + 
  geom_point(aes(size = sqrt(Relative_Abundance))) + 
  scale_size_continuous(name="Relative Abundance",range = c(0.5,8),
                        limits=c(sqrt(0.0001),sqrt(0.3)),
                        breaks=c(sqrt(0.0001),sqrt(0.001),sqrt(0.01),sqrt(0.1)),
                        labels=c("0.0001","0.001","0.01","0.1")) + 
  scale_color_manual(name="Phylum", values = phyla_colors)+
  geom_vline(xintercept = 0) + 
  xlab(label="Log2 Fold Change")+
  ylab(label=NULL)+
  theme_cowplot(12) +
  ggtitle("SI adherent: Genus ~ Sex + Diet") +
  theme(plot.title = element_text(hjust = 0.5)) +
  theme(legend.background = element_rect(fill="lightblue", size=0.5, linetype="solid")) 


# SI luminal
data<-read.table("UCLA/SI_luminal_L6_Maaslin2_Sex_Diet/significant_results.tsv", header=TRUE)
data <- data %>% filter(qval <0.05)
data <- data %>% filter(metadata=="Diet")
data$Phylum <- gsub(".*p__","",data$feature)
data$Phylum <- gsub("\\..*","",data$Phylum)
data$Order<- gsub(".*o__","",data$feature)
data$Order <- gsub("\\..*","",data$Order)
data$Family<- gsub(".*f__","",data$feature)
data$Family <- gsub("\\..*","",data$Family)
data$Genus<- gsub(".*g__","",data$feature)
#data$Genus <- gsub("\\..*","",data$Genus)
data <- data %>% mutate(feature1 = ifelse(data$Genus=="", paste(data$Family,"(f)"), data$Genus))
data <- data %>% mutate(feature = ifelse(data$feature1==" (f)", paste(data$Order,"(o)"), data$feature1))

#append relative abundance data 
relA <- readRDS("UCLA/collapsed_ASV_tables/Relative_Abundance-SI_luminal-L6.RDS")
relA$feature <- row.names(relA)
relA$Order <- gsub(".*o__","",relA$feature)
relA$Order <- gsub("-",".",relA$Order)
relA$Order <- gsub(";.*","",relA$Order)
relA$Family <- gsub(".*f__","",relA$feature)
relA$Family <- gsub("-",".",relA$Family)
relA$Family <- gsub(";.*","",relA$Family)
relA$Genus <- gsub(".*g__","",relA$feature)
relA$Genus <- gsub("-",".",relA$Genus)
relA<- relA %>% mutate(feature1 = ifelse(relA$Genus=="", paste(relA$Family,"(f)"), relA$Genus))
relA<- relA %>% mutate(feature = ifelse(relA$feature1==" (f)", paste(relA$Order,"(o)"), relA$feature1))
relA$Relative_Abundance<-relA$V1

data<-merge(data,relA,by="feature")
min(data$Relative_Abundance)
max(data$Relative_Abundance)
#make graph
y = tapply(data$coef, data$feature, function(y) max(y))  # orders the genera by the highest fold change of any ASV in the genus; can change max(y) to mean(y) if you want to order genera by the average log2 fold change
y = sort(y, FALSE)   #switch to TRUE to reverse direction
data$feature= factor(as.character(data$feature), levels = names(y))
ggplot(data, aes(x = coef, y = feature, color = Phylum)) + 
  geom_point(aes(size = sqrt(Relative_Abundance))) + 
  scale_size_continuous(name="Relative Abundance",range = c(0.5,8),
                        limits=c(sqrt(0.0001),sqrt(0.3)),
                        breaks=c(sqrt(0.0001),sqrt(0.001),sqrt(0.01),sqrt(0.1)),
                        labels=c("0.0001","0.001","0.01","0.1")) + 
  scale_color_manual(name="Phylum", values = phyla_colors)+
  geom_vline(xintercept = 0) + 
  xlab(label="Log2 Fold Change")+
  ylab(label=NULL)+
  theme_cowplot(12) +
  ggtitle("SI luminal: Genus ~ Sex + Diet") +
  theme(plot.title = element_text(hjust = 0.5)) +
  theme(legend.background = element_rect(fill="lightblue", size=0.5, linetype="solid")) 

### Make a Dotplot: Sex, Diet, and Histo  ---

# stool
data<-read.table("UCLA/Stool_L6_Maaslin2_Sex_Diet_Histology/all_results.tsv", header=TRUE)
data <- data %>% filter(qval <0.05)
data <- data %>% filter(metadata=="Histology") # 0 taxa 

data<-read.table("UCLA/Stool_L6_Maaslin2_Sex_Histology/significant_results.tsv", header=TRUE)
data <- data %>% filter(qval <0.05)
data <- data %>% filter(metadata=="Histology") # 0 taxa 

data<-read.table("UCLA/Stool_L6_Maaslin2_Histology/significant_results.tsv", header=TRUE)
data <- data %>% filter(qval <0.05)
data <- data %>% filter(metadata=="Histology") # 0 taxa 

# Cecum
data<-read.table("UCLA/Cecum_L6_Maaslin2_Sex_Diet_Histology/all_results.tsv", header=TRUE)
data <- data %>% filter(qval <0.05)
data <- data %>% filter(metadata=="Histology") # 0 taxa 

data<-read.table("UCLA/Cecum_L6_Maaslin2_Sex_Histology/significant_results.tsv", header=TRUE)
data <- data %>% filter(qval <0.05)
data <- data %>% filter(metadata=="Histology") # 4 taxa, Klebsiella, Ruminiclostridium_5, Lactobacillus, Lachnospiraceae

data<-read.table("UCLA/Cecum_L6_Maaslin2_Histology/significant_results.tsv", header=TRUE)
data <- data %>% filter(qval <0.05)
data <- data %>% filter(metadata=="Histology") # 2 taxa, Klebsiella and Ruminiclostridium_5

# SI adherent
data<-read.table("UCLA/SI_adherent_L6_Maaslin2_Sex_Diet_Histology/significant_results.tsv", header=TRUE)
data <- data %>% filter(qval <0.05)
data <- data %>% filter(metadata=="Histology") # 0 taxa

data<-read.table("UCLA/SI_adherent_L6_Maaslin2_Sex_Histology/significant_results.tsv", header=TRUE)
data <- data %>% filter(qval <0.05)
data <- data %>% filter(metadata=="Histology") # 0 taxa

data<-read.table("UCLA/SI_adherent_L6_Maaslin2_Histology/significant_results.tsv", header=TRUE)
data <- data %>% filter(qval <0.05)
data <- data %>% filter(metadata=="Histology") # 0 taxa 

# SI luminal
data<-read.table("UCLA/SI_luminal_L6_Maaslin2_Sex_Diet_Histology/significant_results.tsv", header=TRUE)
data <- data %>% filter(qval <0.05)
data <- data %>% filter(metadata=="Histology") # 0 taxa 

data<-read.table("UCLA/SI_luminal_L6_Maaslin2_Sex_Histology/significant_results.tsv", header=TRUE)
data <- data %>% filter(qval <0.05)
data <- data %>% filter(metadata=="Histology") # 1 taxa Catabacter

data<-read.table("UCLA/SI_luminal_L6_Maaslin2_Histology/significant_results.tsv", header=TRUE)
data <- data %>% filter(qval <0.05)
data <- data %>% filter(metadata=="Histology") # 1 taxa Catabacter
