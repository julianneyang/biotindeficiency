library(ggplot2)
library(vegan)
library(dplyr)
library(rlang)
library(cowplot)
library(viridis)
library(Microbiome.Biogeography)

setwd("C:/Users/Jacobs Laboratory/Documents/JCYang/Biotin Deficiency 2022 Final/")
here::i_am("Biotin_Deficiency_RProj/UCI_Beta_Diversity.R")

generate_UCI_longitudinal_pcoA_plots <- function(ordination_file, metadata, title, colorvariable,colorvector){
  data<-read.csv(ordination_file, header=FALSE)
  metadata <- read.delim(metadata, header=TRUE)

  #store PC1 and Pc2
  PC1<-data[5,1]
  PC1 <-round(as.numeric(PC1)*100, digits=1)
  PC2<-data[5,2]
  PC2 <-round(as.numeric(PC2)*100, digits=1)
  PC1 <-as.character(PC1)
  str_PC1<-paste0("PC 1 (", PC1,"%)")
  str_PC2<-paste0("PC 2 (", PC2, "%)")
  
  #edit dataframe
  data<-data[,1:4]
  data <- slice(data, 1:(n() - 4))     # Apply slice & n functions
  data<-data[-c(1,2,3,4,5,6,7,8,9),]
  
  #rename columns
  names(data)[names(data) == "V1"] <- "SampleID" 
  names(data)[names(data)=="V2"] <- "PC1" 
  names(data)[names(data)=="V3"] <- "PC2"
  names(data)[names(data)=="V4"] <- "PC3"
  # data$SampleID<-gsub(".","",data$SampleID)
  #append metadata
  intermediate<- (merge(data, metadata, by = 'SampleID'))
  data<- intermediate
  
  #declare factors
  data$Genotype<-factor(data$Genotype, levels=c("WT", "KO"))
  data <- data %>% arrange(Timepoint) 

  p<- ggplot(data, aes(x=PC1, y=PC2, colour={{colorvariable}},shape= Timepoint)) + 
    geom_point(size=3) + 
    scale_colour_manual(name="",values={{colorvector}}) +
    scale_shape_manual(name="", values=c(10,16)) +
    #scale_color_viridis_d()+
    xlab(str_PC1) +
    ylab(str_PC2) +
    theme_cowplot(16)+
    theme(legend.position="top",legend.justification = "center") +
    #geom_line(aes(group = MouseID),color="darkgrey", arrow = arrow(type = "closed",length=unit(0.075, "inches")))+
    #geom_point(aes(x = PC1, y = PC2, shape = Timepoint), size = 3) + 
    #geom_path(aes(x = PC1, y = PC2, group = MouseID), arrow = arrow(length = unit(0.55, "cm")))
    #coord_fixed(ratio=1/2)+
    labs(title= paste0({{title}})) 
  p
}

genotype_cols<- c("KO" = "red", "WT" = "black")
timepoint_cols<- c("Day0" = "red", "Day7 " = "black")

UCI_stool_rpca<- generate_UCI_longitudinal_pcoA_plots("UCI/beta_diversity/stool_pcoa.csv", "UCI/UCI_metadata_analysis_nofood.tsv", "Stool", Genotype,genotype_cols)+
  theme(legend.background = element_rect(fill="lightblue", size=0.5, linetype="solid")) +
  theme(plot.title = element_text(hjust = 0.5))
UCI_stool_rpca

stool_arrow_rpca<- generate_UCI_longitudinal_pcoA_plots("UCI/beta_diversity/stool_pcoa.csv", "UCI/UCI_metadata_analysis_nofood.tsv", "Stool", Genotype,genotype_cols)+
  theme(legend.background = element_rect(fill="lightblue", size=0.5, linetype="solid")) +
  theme(plot.title = element_text(hjust = 0.5)) +
  geom_line(aes(group = MouseID),color="darkgrey", arrow = arrow(type = "closed",length=unit(0.075, "inches")))+
  geom_point(aes(x = PC1, y = PC2, shape = Timepoint), size = 3) + 
  geom_path(aes(x = PC1, y = PC2, group = MouseID), arrow = arrow(length = unit(0.55, "cm")))
stool_arrow_rpca

generate_UCI_cs_pcoA_plots <- function(ordination_file, metadata, title, colorvariable,colorvector){
  data<-read.csv(ordination_file, header=FALSE)
  metadata <- read.delim(metadata, header=TRUE)
  
  #store PC1 and Pc2
  PC1<-data[5,1]
  PC1 <-round(as.numeric(PC1)*100, digits=1)
  PC2<-data[5,2]
  PC2 <-round(as.numeric(PC2)*100, digits=1)
  PC1 <-as.character(PC1)
  str_PC1<-paste0("PC 1 (", PC1,"%)")
  str_PC2<-paste0("PC 2 (", PC2, "%)")
  
  #edit dataframe
  data<-data[,1:4]
  data <- slice(data, 1:(n() - 4))     # Apply slice & n functions
  data<-data[-c(1,2,3,4,5,6,7,8,9),]
  
  #rename columns
  names(data)[names(data) == "V1"] <- "SampleID" 
  names(data)[names(data)=="V2"] <- "PC1" 
  names(data)[names(data)=="V3"] <- "PC2"
  names(data)[names(data)=="V4"] <- "PC3"
  # data$SampleID<-gsub(".","",data$SampleID)
  #append metadata
  intermediate<- (merge(data, metadata, by = 'SampleID'))
  data<- intermediate
  
  #declare factors
  data$Genotype<-factor(data$Genotype, levels=c("WT", "KO"))
  data <- data %>% arrange(Timepoint) 
  
  p<- ggplot(data, aes(x=PC1, y=PC2, colour={{colorvariable}})) + 
    geom_point(size=3) + 
    scale_colour_manual(name="",values={{colorvector}}) +
    #scale_color_viridis_d()+
    xlab(str_PC1) +
    ylab(str_PC2) +
    theme_cowplot(16)+
    theme(legend.position="top",legend.justification = "center") +
    #geom_line(aes(group = MouseID),color="darkgrey", arrow = arrow(type = "closed",length=unit(0.075, "inches")))+
    #geom_point(aes(x = PC1, y = PC2, shape = Timepoint), size = 3) + 
    #geom_path(aes(x = PC1, y = PC2, group = MouseID), arrow = arrow(length = unit(0.55, "cm")))+
    #coord_fixed(ratio=1/2)+
    labs(title= paste0({{title}})) 
  p
}
uci_intestine_rpca<- generate_UCI_cs_pcoA_plots("UCI/beta_diversity/intestine_pcoa.csv", "UCI/UCI_metadata_analysis_nofood.tsv", "Colon", Genotype,genotype_cols)+
  theme(legend.background = element_rect(fill="lightblue", size=0.5, linetype="solid")) +
  theme(plot.title = element_text(hjust = 0.5))

### Beta - Diversity Stats ---

# stool
metadata <-read.delim("UCI/UCI_metadata_analysis_nofood.tsv",sep="\t",header=TRUE, row.names=1) #mapping file
write.csv(metadata, "UCI/UCI_metadata_analysis_nofood.csv")

names(metadata)
permutewithin <- c("Timepoint")
subjectdata <- c("Genotype", "MouseID")

?Microbiome.Biogeography::run_repeated_PERMANOVA()
run_repeated_PERMANOVA("UCI/beta_diversity/dm_rpca_s6_min10000_stool_min_10000_Skupsky_UCI_ASV_nofood.qza.txt/distance-matrix.tsv",
                       "UCI/UCI_metadata_analysis_nofood.csv",
                       permute_columns_vector = permutewithin,
                       subject_metadata_vector = subjectdata)

# intestines
data.dist<-read.table(file ="UCI/beta_diversity/dm_rpca_s3_min10000_intestine_min_10000_Skupsky_UCI_ASV_nofood.qza.txt/distance-matrix.tsv")
metadata <- read.csv("UCI/UCI_metadata_analysis_nofood.csv", header=TRUE, row.names=1)


target <- row.names(data.dist)
metadata = metadata[match(target, row.names(metadata)),]
target == row.names(metadata)
data.dist <- as.dist(as(data.dist, "matrix"))

data.adonis=adonis(data.dist ~ Genotype, data=metadata, permutations=10000)
data.adonis$aov.tab
