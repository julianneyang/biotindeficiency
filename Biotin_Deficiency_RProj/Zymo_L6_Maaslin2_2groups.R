library(Maaslin2)
library(funrar)
library(dplyr)
library(ggplot2)
library(cowplot)
library(plyr)
setwd("C:/Users/Jacobs Laboratory/Documents/JCYang/Biotin Deficiency 2022 Final/")

### Run Maaslin2 and get table of relative abundances
# Colon ---
input_data <- read.csv("Zymo_2.0/collapsed_ASV_tables/L6 - Colon.csv", header=TRUE, row.names=1) # choose filtered non rarefied csv file

df_input_data <- as.data.frame(input_data)
df_input_data <- select(df_input_data, -c("taxonomy"))

transposed_input_data <- t(df_input_data)
transposed_input_data <- as.matrix(transposed_input_data) #taxa are now columns, samples are rows. 
df_relative_ASV <- make_relative(transposed_input_data)
df_relative_ASV <- as.data.frame(df_relative_ASV)
Relative_Abundance <- summarize_all(df_relative_ASV, mean)
Relative_Abundance <- as.data.frame(t(Relative_Abundance))

readr::write_rds(Relative_Abundance,"Zymo_2.0/collapsed_ASV_tables/Relative_Abundance-colon-L6.RDS")

input_metadata <-read.delim("Zymo_2.0/starting_files/Metadata_2groups.tsv",sep="\t",header=TRUE, row.names=1) #mapping file

target <- colnames(df_input_data)
input_metadata = input_metadata[match(target, row.names(input_metadata)),]
target == row.names(input_metadata)

df_input_metadata<-input_metadata
df_input_metadata$MouseID <- factor(df_input_metadata$MouseID)
df_input_metadata$Diet <- factor(df_input_metadata$Diet, levels=c("CD","BD"))
sapply(df_input_metadata,levels)

?Maaslin2
fit_data = Maaslin2(input_data=df_input_data, 
                    input_metadata=df_input_metadata, 
                    output = "Zymo_2.0/2groups_Colon_L6_Maaslin2_Diet", 
                    fixed_effects = c("Diet"),normalization="TSS", 
                    min_prevalence = 0.273,
                    transform ="log",plot_heatmap = FALSE,plot_scatter = FALSE)

# stool ---
input_data <- read.csv("Zymo_2.0/collapsed_ASV_tables/L6 - Stool.csv", header=TRUE, row.names=1) # choose filtered non rarefied csv file

df_input_data <- as.data.frame(input_data)
df_input_data <- select(df_input_data, -c("taxonomy"))

input_metadata <-read.delim("Zymo_2.0/starting_files/Metadata_2groups.tsv",sep="\t",header=TRUE, row.names=1) #mapping file
input_metadata$SampleID <- row.names(input_metadata)
#split into weeks - run the appropriate section
week4_samples <- input_metadata %>% filter(Collection =="Week4", SampleID %in% names(df_input_data)) %>% pull(SampleID)
df_input_data <- df_input_data[,week4_samples]
#Week8-
week8_samples <- input_metadata %>% filter(Collection =="Week8", SampleID %in% names(df_input_data)) %>% pull(SampleID)
df_input_data <- df_input_data[,week8_samples]
#Week12-
week12_samples <- input_metadata %>% filter(Collection =="Week12", SampleID %in% names(df_input_data)) %>% pull(SampleID)
df_input_data <- df_input_data[,week12_samples]

transposed_input_data <- t(df_input_data)
transposed_input_data <- as.matrix(transposed_input_data) #taxa are now columns, samples are rows. 
df_relative_ASV <- make_relative(transposed_input_data)
df_relative_ASV <- as.data.frame(df_relative_ASV)
Relative_Abundance <- summarize_all(df_relative_ASV, mean)
Relative_Abundance <- as.data.frame(t(Relative_Abundance))
readr::write_rds(Relative_Abundance,"Zymo_2.0/collapsed_ASV_tables/Relative_Abundance-stool-L6.RDS")

target <- colnames(df_input_data)
input_metadata = input_metadata[match(target, row.names(input_metadata)),]
target == row.names(input_metadata)

df_input_metadata<-input_metadata
df_input_metadata$MouseID <- factor(df_input_metadata$MouseID)
df_input_metadata$Diet <- factor(df_input_metadata$Diet, levels=c("CD","BD"))
df_input_metadata$Collection <- factor(df_input_metadata$Collection, levels=c("Week0", "Week4","Week8","Week12"))
sapply(df_input_metadata,levels)

#Week4
fit_data = Maaslin2(input_data=df_input_data, input_metadata=df_input_metadata, 
                    output = "Zymo_2.0/Wk4_2groups_stool_L6_Maaslin2_Diet", 
                    fixed_effects = c("Diet"), 
                    min_prevalence=0.273,
                    normalization="TSS", transform ="log",plot_heatmap = FALSE,plot_scatter = FALSE)
#Week8
fit_data = Maaslin2(input_data=df_input_data, input_metadata=df_input_metadata, 
                    output = "Zymo_2.0/Wk8_2groups_stool_L6_Maaslin2_Diet", 
                    fixed_effects = c("Diet"), 
                    min_prevalence=0.273,
                    normalization="TSS", transform ="log",plot_heatmap = FALSE,plot_scatter = FALSE)
#Week12
fit_data = Maaslin2(input_data=df_input_data, input_metadata=df_input_metadata, 
                    output = "Zymo_2.0/Wk12_2groups_stool_L6_Maaslin2_Diet", 
                    fixed_effects = c("Diet"), 
                    min_prevalence=0.273,
                    normalization="TSS", transform ="log",plot_heatmap = FALSE,plot_scatter = FALSE)

### Make a Dotplot ---
# intestines: 6 genera significant---
data<-read.table("Zymo_2.0/2groups_Colon_L6_Maaslin2_Diet/significant_results.tsv", header=TRUE)
data <- data %>% filter(qval <0.05)
data$Phylum <- gsub(".*p__","",data$feature)
data$Phylum <- gsub("\\..*","",data$Phylum)
data$feature <- gsub(".*g__","",data$feature)

#append relative abundance data 
relA <- readRDS("Zymo_2.0/collapsed_ASV_tables/Relative_Abundance-colon-L6.RDS")
relA$feature <- row.names(relA)
relA$feature <- gsub(".*g__","",relA$feature)
relA$feature <- gsub("-",".",relA$feature)

relA$Relative_Abundance<-relA$V1

data<-merge(data,relA,by="feature")
max(data$Relative_Abundance)
min(data$Relative_Abundance)

#make graph
phyla<- c("Actinobacteria"="#E76BF3", "Bacteroidetes"="#00BF7D","Firmicutes"="#A3A500","Verrucomicrobia" ="#F8766D", "Proteobacteria" ="#00B0F6")
y = tapply(data$coef, data$feature, function(y) max(y))  # orders the genera by the highest fold change of any ASV in the genus; can change max(y) to mean(y) if you want to order genera by the average log2 fold change
y = sort(y, FALSE)   #switch to TRUE to reverse direction
data$feature= factor(as.character(data$feature), levels = names(y))
zymo_colon_dat<-ggplot(data, aes(x = coef, y = feature, color = Phylum)) + 
  geom_point(aes(size = sqrt(Relative_Abundance))) + 
  scale_size_continuous(name="",range = c(0.5,8),
                        limits=c(sqrt(0.0004),sqrt(0.15)),
                        breaks=c(sqrt(0.0001),sqrt(0.001),sqrt(0.01),sqrt(0.1)),
                        labels=c("0.0001","0.001","0.01","0.1")) + 
  scale_color_manual(name="", values = phyla)+
  geom_vline(xintercept = 0) + 
  xlab(label="")+
  ylab(label=NULL)+
  theme_cowplot(16) +
  ggtitle("Colon") +
  theme(plot.title = element_text(hjust = 0.5)) +
  theme(legend.background = element_rect(fill="lightblue", size=0.5, linetype="solid")) +
  theme(legend.position = "top", legend.justification = "center")+
  guides(colour = guide_legend(nrow = 5),size=guide_legend(nrow=3))

# stool, week4 ---
data<-read.table("Zymo_2.0/Wk4_2groups_stool_L6_Maaslin2_Diet/all_results.tsv", sep="\t",header=TRUE)
data <- data %>% filter(qval <0.05)
data <- data %>% filter(metadata=="Diet")
data$Phylum <- gsub(".*p__","",data$feature)
data$Phylum <- gsub("\\..*","",data$Phylum)
data$Order<- gsub(".*o__","",data$feature)
data$Order <- gsub("\\..*","",data$Order)
data$Family<- gsub(".*f__","",data$feature)
data$Family <- gsub("\\.g.*","",data$Family)
data$Genus<- gsub(".*g__","",data$feature)
#data$Genus <- gsub("\\..*","",data$Genus)
data <- data %>% mutate(feature1 = ifelse(data$Genus=="NA", paste(data$Family,"(f)"), data$Genus))
data <- data %>% mutate(feature = ifelse(data$feature1=="NA (f)", paste(data$Order,"(o)"), data$feature1))

#append relative abundance data 
relA <- readRDS("Zymo_2.0/collapsed_ASV_tables/Relative_Abundance-stool-L6.RDS")
relA$feature <- row.names(relA)
relA$Order <- gsub(".*o__","",relA$feature)
relA$Order <- gsub("-",".",relA$Order)
relA$Order <- gsub(";.*","",relA$Order)
relA$Family <- gsub(".*f__","",relA$feature)
relA$Family <- gsub("-",".",relA$Family)
relA$Family <- gsub(" ",".",relA$Family)
relA$Family <- gsub(";.*","",relA$Family)
relA$Genus <- gsub(".*g__","",relA$feature)
relA$Genus <- gsub("-",".",relA$Genus)
relA<- relA %>% mutate(feature1 = ifelse(relA$Genus=="NA", paste(relA$Family,"(f)"), relA$Genus))
relA<- relA %>% mutate(feature = ifelse(relA$feature1=="NA (f)", paste(relA$Order,"(o)"), relA$feature1))
relA$Relative_Abundance<-relA$V1

data<-merge(data,relA,by="feature")
min(data$Relative_Abundance)
max(data$Relative_Abundance)


#make graph
y = tapply(data$coef, data$feature, function(y) max(y))  # orders the genera by the highest fold change of any ASV in the genus; can change max(y) to mean(y) if you want to order genera by the average log2 fold change
y = sort(y, FALSE)   #switch to TRUE to reverse direction
data$feature= factor(as.character(data$feature), levels = names(y))
data$coef <- as.numeric(data$coef)
zymo_stool_w4_dat <- ggplot(data, aes(x = coef, y = feature, color = Phylum)) + 
  geom_point(aes(size = sqrt(Relative_Abundance))) + 
  scale_size_continuous(name="Relative Abundance",range = c(0.5,8),
                        limits=c(sqrt(0.0001),sqrt(0.42)),
                        breaks=c(sqrt(0.0001),sqrt(0.01),sqrt(0.1)),
                        labels=c("0.0001","0.01","0.1")) + 
  scale_color_manual(name="Phylum", values = w4_phyla)+
  geom_vline(xintercept = 0) + 
  xlab(label="Log2 Fold Change")+
  ylab(label=NULL)+
  theme_cowplot(16) +
  ggtitle("Stool: Week 4") +
  theme(plot.title = element_text(hjust = 0.5)) +
  theme(legend.position ="none") +
  scale_x_continuous(labels = scales::label_number(accuracy = 1))

# stool, week 8 ---
data<-read.table("Zymo_2.0/Wk8_2groups_stool_L6_Maaslin2_Diet/significant_results.tsv", header=TRUE)
data <- data %>% filter(qval <0.05)
data$Phylum <- gsub(".*p__","",data$feature)
data$Phylum <- gsub("\\..*","",data$Phylum)
data$Order<- gsub(".*o__","",data$feature)
data$Order <- gsub("\\..*","",data$Order)
data$Family<- gsub(".*f__","",data$feature)
data$Family <- gsub("\\.g.*","",data$Family)
data$Genus<- gsub(".*g__","",data$feature)
#data$Genus <- gsub("\\..*","",data$Genus)
data <- data %>% mutate(feature1 = ifelse(data$Genus=="NA", paste(data$Family,"(f)"), data$Genus))
data <- data %>% mutate(feature = ifelse(data$feature1=="NA (f)", paste(data$Order,"(o)"), data$feature1))

#append relative abundance data 
relA <- readRDS("Zymo_2.0/collapsed_ASV_tables/Relative_Abundance-stool-L6.RDS")
relA$feature <- row.names(relA)
relA$Order <- gsub(".*o__","",relA$feature)
relA$Order <- gsub("-",".",relA$Order)
relA$Order <- gsub(";.*","",relA$Order)
relA$Family <- gsub(".*f__","",relA$feature)
relA$Family <- gsub("-",".",relA$Family)
relA$Family <- gsub(" ",".",relA$Family)
relA$Family <- gsub(";.*","",relA$Family)
relA$Genus <- gsub(".*g__","",relA$feature)
relA$Genus <- gsub("-",".",relA$Genus)
relA<- relA %>% mutate(feature1 = ifelse(relA$Genus=="NA", paste(relA$Family,"(f)"), relA$Genus))
relA<- relA %>% mutate(feature = ifelse(relA$feature1=="NA (f)", paste(relA$Order,"(o)"), relA$feature1))
relA$Relative_Abundance<-relA$V1

data<-merge(data,relA,by="feature")
min(data$Relative_Abundance)
max(data$Relative_Abundance)


#make graph
w8_phyla<- c("Bacteroidetes"="#00BF7D","Firmicutes"="#A3A500","Proteobacteria" ="#00B0F6") 

y = tapply(data$coef, data$feature, function(y) max(y))  # orders the genera by the highest fold change of any ASV in the genus; can change max(y) to mean(y) if you want to order genera by the average log2 fold change
y = sort(y, FALSE)   #switch to TRUE to reverse direction
data$feature= factor(as.character(data$feature), levels = names(y))
zymo_stool_w8_dat <-ggplot(data, aes(x = coef, y = feature, color = Phylum)) + 
  geom_point(aes(size = sqrt(Relative_Abundance))) + 
  scale_size_continuous(name="Relative Abundance",range = c(0.5,8),
                        limits=c(sqrt(0.0001),sqrt(0.42)),
                        breaks=c(sqrt(0.0001),sqrt(0.01),sqrt(0.1)),
                        labels=c("0.0001","0.01","0.1")) + 
  scale_color_manual(name="Phylum", values = w8_phyla)+
  geom_vline(xintercept = 0) + 
  xlab(label="Log2 Fold Change")+
  ylab(label=NULL)+
  theme_cowplot(16) +
  ggtitle("Stool: Week 8") +
  theme(plot.title = element_text(hjust = 0.5)) +
  theme(legend.position ="none")


# stool, week 12 ---
data<-read.table("Zymo_2.0/Wk12_2groups_stool_L6_Maaslin2_Diet/significant_results.tsv", header=TRUE)
data <- data %>% filter(qval <0.05)
data$Phylum <- gsub(".*p__","",data$feature)
data$Phylum <- gsub("\\..*","",data$Phylum)
data$Order<- gsub(".*o__","",data$feature)
data$Order <- gsub("\\..*","",data$Order)
data$Family<- gsub(".*f__","",data$feature)
data$Family <- gsub("\\.g.*","",data$Family)
data$Genus<- gsub(".*g__","",data$feature)
#data$Genus <- gsub("\\..*","",data$Genus)
data <- data %>% mutate(feature1 = ifelse(data$Genus=="NA", paste(data$Family,"(f)"), data$Genus))
data <- data %>% mutate(feature = ifelse(data$feature1=="NA (f)", paste(data$Order,"(o)"), data$feature1))

#append relative abundance data 
relA <- readRDS("Zymo_2.0/collapsed_ASV_tables/Relative_Abundance-stool-L6.RDS")
relA$feature <- row.names(relA)
relA$Order <- gsub(".*o__","",relA$feature)
relA$Order <- gsub("-",".",relA$Order)
relA$Order <- gsub(";.*","",relA$Order)
relA$Family <- gsub(".*f__","",relA$feature)
relA$Family <- gsub("-",".",relA$Family)
relA$Family <- gsub(" ",".",relA$Family)
relA$Family <- gsub(";.*","",relA$Family)
relA$Genus <- gsub(".*g__","",relA$feature)
relA$Genus <- gsub("-",".",relA$Genus)
relA<- relA %>% mutate(feature1 = ifelse(relA$Genus=="NA", paste(relA$Family,"(f)"), relA$Genus))
relA<- relA %>% mutate(feature = ifelse(relA$feature1=="NA (f)", paste(relA$Order,"(o)"), relA$feature1))
relA$Relative_Abundance<-relA$V1

data<-merge(data,relA,by="feature")
min(data$Relative_Abundance)
max(data$Relative_Abundance)


#make graph
w12_phyla<- c("Actinobacteria"="#E76BF3", "Bacteroidetes"="#00BF7D","Firmicutes"="#A3A500","Verrucomicrobia" ="#F8766D", "Proteobacteria" ="#00B0F6") 

y = tapply(data$coef, data$feature, function(y) max(y))  # orders the genera by the highest fold change of any ASV in the genus; can change max(y) to mean(y) if you want to order genera by the average log2 fold change
y = sort(y, FALSE)   #switch to TRUE to reverse direction
data$feature= factor(as.character(data$feature), levels = names(y))
zymo_stool_w12_dat <-ggplot(data, aes(x = coef, y = feature, color = Phylum)) + 
  geom_point(aes(size = sqrt(Relative_Abundance))) + 
  scale_size_continuous(name="",range = c(0.5,8),
                        limits=c(sqrt(0.0001),sqrt(0.42)),
                        breaks=c(sqrt(0.0001),sqrt(0.01),sqrt(0.1)),
                        labels=c("0.0001","0.01","0.1")) + 
  scale_color_manual(name="", values = w12_phyla)+
  geom_vline(xintercept = 0) + 
  xlab(label="Log2 Fold Change")+
  ylab(label=NULL)+
  theme_cowplot(16) +
  ggtitle("Stool: Week 12") +
  theme(plot.title = element_text(hjust = 0.5)) +
  theme(legend.position = "none")
  #theme(legend.background = element_rect(fill="lightblue", size=0.5, linetype="solid")) +
  #theme(legend.position = "top", legend.justification = "center")+
  #guides(colour = guide_legend(nrow = 3),size=guide_legend(nrow=3))
fig_zymo_jkl <- plot_grid(zymo_colon_dat, zymo_stool_w4_dat,zymo_stool_w8_dat,zymo_stool_w12_dat,nrow=1,
          labels=c("I","J","K","L"))
dev.new(width=10,height=10)
plot_grid(fig_zymo_abc, fig_zymo_def, nrow=2)
dev.new(width=10,height=10)
plot_grid(fig_zymo_ghi, fig_zymo_jkl, nrow=2)
