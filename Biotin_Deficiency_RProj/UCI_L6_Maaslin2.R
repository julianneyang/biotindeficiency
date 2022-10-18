library(Maaslin2)
library(funrar)
library(dplyr)
library(ggplot2)
library(cowplot)
library(plyr)
setwd("C:/Users/Jacobs Laboratory/Documents/JCYang/Biotin Deficiency 2022 Final/")

### Run Maaslin2 and get table of relative abundances
# intestines ---
input_data <- read.csv("UCI/collapsed_ASV_tables/UCI L6 Tables - intestines_L6.csv", header=TRUE, row.names=1) # choose filtered non rarefied csv file

df_input_data <- as.data.frame(input_data)
df_input_data <- select(df_input_data, -c("taxonomy"))

transposed_input_data <- t(df_input_data)
transposed_input_data <- as.matrix(transposed_input_data) #taxa are now columns, samples are rows. 
df_relative_ASV <- make_relative(transposed_input_data)
df_relative_ASV <- as.data.frame(df_relative_ASV)
Relative_Abundance <- summarize_all(df_relative_ASV, mean)
Relative_Abundance <- as.data.frame(t(Relative_Abundance))

readr::write_rds(Relative_Abundance,"UCI/collapsed_ASV_tables/Relative_Abundance-intestines-L6.RDS")

input_metadata <-read.delim("UCI/UCI_metadata_analysis_nofood.tsv",sep="\t",header=TRUE, row.names=1) #mapping file

target <- colnames(df_input_data)
input_metadata = input_metadata[match(target, row.names(input_metadata)),]
target == row.names(input_metadata)

df_input_metadata<-input_metadata
df_input_metadata$MouseID <- factor(df_input_metadata$MouseID)
df_input_metadata$Genotype <- factor(df_input_metadata$Genotype, levels=c("WT","KO"))
sapply(df_input_metadata,levels)

fit_data = Maaslin2(input_data=df_input_data, input_metadata=df_input_metadata, output = "UCI/intestines_L6_Maaslin2_Genotype", fixed_effects = c("Genotype"),normalization="TSS", transform ="log",plot_heatmap = FALSE,plot_scatter = FALSE)

# stool ---
input_data <- read.csv("UCI/collapsed_ASV_tables/UCI L6 Tables - stool_L6.csv", header=TRUE, row.names=1) # choose filtered non rarefied csv file

df_input_data <- as.data.frame(input_data)
df_input_data <- select(df_input_data, -c("taxonomy"))

transposed_input_data <- t(df_input_data)
transposed_input_data <- as.matrix(transposed_input_data) #taxa are now columns, samples are rows. 
df_relative_ASV <- make_relative(transposed_input_data)
df_relative_ASV <- as.data.frame(df_relative_ASV)
Relative_Abundance <- summarize_all(df_relative_ASV, mean)
Relative_Abundance <- as.data.frame(t(Relative_Abundance))
readr::write_rds(Relative_Abundance,"UCI/collapsed_ASV_tables/Relative_Abundance-stool-L6.RDS")

input_metadata <-read.delim("UCI/UCI_metadata_analysis_nofood.tsv",sep="\t",header=TRUE, row.names=1) #mapping file
input_metadata$SampleID <- row.names(input_metadata)
input_metadata$Genotype<- factor(input_metadata$Genotype,levels=c("WT","KO"))
res.aov <- aov(weight~Timepoint*Genotype,input_metadata)
timepointANDgenotype<- as.data.frame(model.matrix(res.aov))
timepointANDgenotype$TimepointANDGenotype <- timepointANDgenotype$`TimepointDay7 :GenotypeKO`
timepointANDgenotype <- timepointANDgenotype %>% select("TimepointANDGenotype")
timepointANDgenotype$SampleID <- row.names(timepointANDgenotype)
input_metadata <- merge(input_metadata, timepointANDgenotype, by="SampleID")
write.csv(input_metadata, "")
row.names(input_metadata) <- input_metadata$SampleID

target <- colnames(df_input_data)
input_metadata = input_metadata[match(target, row.names(input_metadata)),]
target == row.names(input_metadata)

df_input_metadata<-input_metadata
df_input_metadata$MouseID <- factor(df_input_metadata$MouseID)
df_input_metadata$Genotype <- factor(df_input_metadata$Genotype, levels=c("WT","KO"))
df_input_metadata$Timepoint <- factor(df_input_metadata$Timepoint, levels=c("Day0", "Day7 "))
sapply(df_input_metadata,levels)

fit_data = Maaslin2(input_data=df_input_data, input_metadata=df_input_metadata, output = "UCI/stool_L6_Maaslin2_Timepoint_Genotype_1-MouseID", fixed_effects = c("Timepoint","Genotype"), random_effects=c("MouseID"),normalization="TSS", transform ="log",plot_heatmap = FALSE,plot_scatter = FALSE)
fit_data = Maaslin2(input_data=df_input_data, input_metadata=df_input_metadata, output = "UCI/stool_L6_Maaslin2_Timepoint_Genotype_TimepointANDGenotype_1-MouseID", fixed_effects = c("Timepoint","Genotype","TimepointANDGenotype"), random_effects=c("MouseID"),normalization="TSS", transform ="log",plot_heatmap = FALSE,plot_scatter = FALSE)

### Make a Dotplot ---
# intestines ---
data<-read.table("UCI/intestines_L6_Maaslin2_Genotype/significant_results.tsv", header=TRUE)
data <- data %>% filter(qval <0.05)
data$Phylum <- gsub(".*p__","",data$feature)
data$Phylum <- gsub("\\..*","",data$Phylum)
data$feature <- gsub(".*g__","",data$feature)

#append relative abundance data 
relA <- readRDS("UCI/collapsed_ASV_tables/Relative_Abundance-intestines-L6.RDS")
relA$feature <- row.names(relA)
relA$feature <- gsub(".*g__","",relA$feature)
relA$feature <- gsub("-",".",relA$feature)

relA$Relative_Abundance<-relA$V1

data<-merge(data,relA,by="feature")
max(data$Relative_Abundance)
min(data$Relative_Abundance)

#make graph
y = tapply(data$coef, data$feature, function(y) max(y))  # orders the genera by the highest fold change of any ASV in the genus; can change max(y) to mean(y) if you want to order genera by the average log2 fold change
y = sort(y, FALSE)   #switch to TRUE to reverse direction
data$feature= factor(as.character(data$feature), levels = names(y))
ggplot(data, aes(x = coef, y = feature, color = Phylum)) + 
  geom_point(aes(size = sqrt(Relative_Abundance))) + 
  scale_size_continuous(name="Relative Abundance",range = c(0.5,8),
                        limits=c(sqrt(0.0006),sqrt(0.15)),
                        breaks=c(sqrt(0.0001),sqrt(0.001),sqrt(0.01),sqrt(0.1)),
                        labels=c("0.0001","0.001","0.01","0.1")) + 
  geom_vline(xintercept = 0) + 
  xlab(label="Log2 Fold Change")+
  ylab(label=NULL)+
  theme_cowplot(12) +
  ggtitle("Enriched in WT     Enriched in KO") +
  theme(plot.title = element_text(hjust = 0.5)) +
  theme(legend.background = element_rect(fill="lightblue", size=0.5, linetype="solid")) 

# stool, Timepoint+Genotype ---
data<-read.table("UCI/stool_L6_Maaslin2_Timepoint_Genotype_1-MouseID/significant_results.tsv", header=TRUE)
data <- data %>% filter(qval <0.05)
data$Phylum <- gsub(".*p__","",data$feature)
data$Phylum <- gsub("\\..*","",data$Phylum)
data$feature <- gsub(".*g__","",data$feature)

#append relative abundance data 
relA <- readRDS("UCI/collapsed_ASV_tables/Relative_Abundance-stool-L6.RDS")
relA$feature <- row.names(relA)
relA$feature <- gsub(".*g__","",relA$feature)
relA$feature <- gsub("-",".",relA$feature)

relA$Relative_Abundance<-relA$V1

data<-merge(data,relA,by="feature")
max(data$Relative_Abundance)
min(data$Relative_Abundance)

#make graph
y = tapply(data$coef, data$feature, function(y) max(y))  # orders the genera by the highest fold change of any ASV in the genus; can change max(y) to mean(y) if you want to order genera by the average log2 fold change
y = sort(y, FALSE)   #switch to TRUE to reverse direction
data$feature= factor(as.character(data$feature), levels = names(y))
ggplot(data, aes(x = coef, y = feature, color = Phylum)) + 
  geom_point(aes(size = sqrt(Relative_Abundance))) + 
  scale_size_continuous(name="Relative Abundance",range = c(0.5,8),
                        limits=c(sqrt(0.0001),sqrt(0.15)),
                        breaks=c(sqrt(0.0001),sqrt(0.001),sqrt(0.01)),
                        labels=c("0.0001","0.001","0.01")) + 
  geom_vline(xintercept = 0) + 
  xlab(label="Log2 Fold Change")+
  ylab(label=NULL)+
  theme_cowplot(12) +
  ggtitle("Stool: Genus ~ Timepoint + Genotype") +
  theme(plot.title = element_text(hjust = 0.5)) +
  theme(legend.background = element_rect(fill="lightblue", size=0.5, linetype="solid")) 

# stool, Timepoint*Genotype ---
data<-read.table("UCI/stool_L6_Maaslin2_Timepoint_Genotype_TimepointANDGenotype_1-MouseID/all_results.tsv", header=TRUE)
data <- data %>% filter(qval <0.05)
data$Phylum <- gsub(".*p__","",data$feature)
data$Phylum <- gsub("\\..*","",data$Phylum)
data$feature <- gsub(".*g__","",data$feature)
# no features are significant