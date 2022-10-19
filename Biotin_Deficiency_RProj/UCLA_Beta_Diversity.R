library(ggplot2)
library(vegan)
library(dplyr)
library(rlang)
library(cowplot)
library(viridis)
library(Microbiome.Biogeography)

setwd("C:/Users/Jacobs Laboratory/Documents/JCYang/Biotin Deficiency 2022 Final/")
here::i_am("Biotin_Deficiency_RProj/UCLA_Beta_Diversity.R")

generate_UCLA_cs_pcoA_plots <- function(ordination_file, metadata, title, colorvariable,colorvector){
  data<-read.csv(ordination_file, header=FALSE)
  metadata <- read.delim(metadata, header=TRUE,row.names = 1)
  metadata$SampleID<-row.names(metadata)
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
  data$Diet<-data$Group
  data$Diet<-factor(data$Diet, levels=c("Control", "BD"))
  
  p<- ggplot(data, aes(x=PC1, y=PC2, colour={{colorvariable}})) + 
    geom_point(size=3) + 
    scale_colour_manual(name="",values={{colorvector}}) +
    #scale_color_viridis_d()+
    xlab(str_PC1) +
    ylab(str_PC2) +
    theme_cowplot(12)+
    theme(legend.position="top",legend.justification = "center") +
    #geom_text(nudge_y = .05) +
    #geom_line(aes(group = MouseID),color="darkgrey", arrow = arrow(type = "closed",length=unit(0.075, "inches")))+
    #geom_point(aes(x = PC1, y = PC2, shape = Timepoint), size = 3) + 
    #geom_path(aes(x = PC1, y = PC2, group = MouseID), arrow = arrow(length = unit(0.55, "cm")))+
    #coord_fixed(ratio=1/2)+
    labs(title= paste0({{title}})) 
  p
}
diet_cols <- c("Control"="black", "BD"="red")
ucla_stool_rpca<- generate_UCLA_cs_pcoA_plots("UCLA/beta_diversity/RPCA - Stool_Pellet.csv", "UCLA/starting_files/Metadata.tsv", "Stool", Diet,diet_cols)+
  theme(legend.background = element_rect(fill="lightblue", size=0.5, linetype="solid")) +
  theme(plot.title = element_text(hjust = 0.5))
ucla_cecum_rpca<- generate_UCLA_cs_pcoA_plots("UCLA/beta_diversity/RPCA - adherent_cecum.csv", "UCLA/starting_files/Metadata.tsv", "Cecum", Diet,diet_cols)+
  theme(legend.background = element_rect(fill="lightblue", size=0.5, linetype="solid")) +
  theme(plot.title = element_text(hjust = 0.5))
ucla_si_adherent_rpca<- generate_UCLA_cs_pcoA_plots("UCLA/beta_diversity/RPCA - SI_adherent.csv", "UCLA/starting_files/Metadata.tsv", "SI Mucosal", Diet,diet_cols)+
  theme(legend.background = element_rect(fill="lightblue", size=0.5, linetype="solid")) +
  theme(plot.title = element_text(hjust = 0.5))
ucla_si_luminal_rpca<- generate_UCLA_cs_pcoA_plots("UCLA/beta_diversity/RPCA - SI_luminal.csv", "UCLA/starting_files/Metadata.tsv", "SI Luminal", Diet,diet_cols)+
  theme(legend.background = element_rect(fill="lightblue", size=0.5, linetype="solid")) +
  theme(plot.title = element_text(hjust = 0.5))

### Beta - Diversity Stats ---
# stool
data.dist<-read.table(file ="UCLA/beta_diversity/dm_rpca_s3_min10000_Stool_Pellet_ASV.qza.txt/distance-matrix.tsv")
metadata <- read.delim("UCLA/starting_files/Metadata.tsv", header=TRUE, row.names=1)


target <- row.names(data.dist)
metadata = metadata[match(target, row.names(metadata)),]
target == row.names(metadata)
data.dist <- as.dist(as(data.dist, "matrix"))

data.adonis=adonis(data.dist ~ Sex+Group, data=metadata, permutations=10000)
data.adonis$aov.tab

# cecum
data.dist<-read.table(file ="UCLA/beta_diversity/dm_rpca_s3_min10000_adherent_cecum_ASV.qza.txt/distance-matrix.tsv")
metadata <- read.delim("UCLA/starting_files/Metadata.tsv", header=TRUE, row.names=1)


target <- row.names(data.dist)
metadata = metadata[match(target, row.names(metadata)),]
target == row.names(metadata)
data.dist <- as.dist(as(data.dist, "matrix"))

data.adonis=adonis(data.dist ~ Group, data=metadata, permutations=10000)
data.adonis$aov.tab

# SI adherent
data.dist<-read.table(file ="UCLA/beta_diversity/dm_rpca_s3_min10000_SI_adherent_ASV.qza.txt/distance-matrix.tsv")
metadata <- read.delim("UCLA/starting_files/Metadata.tsv", header=TRUE, row.names=1)

target <- row.names(data.dist)
metadata = metadata[match(target, row.names(metadata)),]
target == row.names(metadata)
data.dist <- as.dist(as(data.dist, "matrix"))

data.adonis=adonis(data.dist ~ Group, data=metadata, permutations=10000)
data.adonis$aov.tab

# SI luminal
data.dist<-read.table(file ="UCLA/beta_diversity/dm_rpca_s3_min10000_SI_luminal_ASV.qza.txt/distance-matrix.tsv")
metadata <- read.delim("UCLA/starting_files/Metadata.tsv", header=TRUE, row.names=1)

target <- row.names(data.dist)
metadata = metadata[match(target, row.names(metadata)),]
target == row.names(metadata)
data.dist <- as.dist(as(data.dist, "matrix"))

data.adonis=adonis(data.dist ~ Group, data=metadata, permutations=10000)
data.adonis$aov.tab
