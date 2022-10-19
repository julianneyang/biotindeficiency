library(ggplot2)
library(vegan)
library(dplyr)
library(rlang)
library(cowplot)
library(viridis)
library(Microbiome.Biogeography)

setwd("C:/Users/Jacobs Laboratory/Documents/JCYang/Biotin Deficiency 2022 Final/")
here::i_am("Biotin_Deficiency_RProj/Zymo_Beta_Diversity.R")

generate_Zymo_longitudinal_pcoA_plots <- function(ordination_file, metadata, title, colorvariable,colorvector){
  data<-read.csv(ordination_file, header=FALSE)
  metadata <- read.delim(metadata, header=TRUE,row.names=1)
  metadata$SampleID <- row.names(metadata)
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
  data$Diet<-factor(data$Diet, levels=c("Control", "BD","BD_supp"))
  data$Collection <- factor(data$Collection, levels= c("Week0", "Week4","Week8", "Week12"))
  data <- data %>% arrange(Collection) 
  
  p<- ggplot(data, aes(x=PC1, y=PC2, colour={{colorvariable}},shape= Collection)) + 
    geom_point(size=3) + 
    scale_colour_manual(name="",values={{colorvector}}) +
    scale_shape_manual(name="", values=c(10,16,17,18)) +
    #scale_color_viridis_d()+
    xlab(str_PC1) +
    ylab(str_PC2) +
    theme_cowplot(12)+
    theme(legend.position="top",legend.justification = "center") +
    #geom_line(aes(group = MouseID),color="darkgrey", arrow = arrow(type = "closed",length=unit(0.075, "inches")))+
    #geom_point(aes(x = PC1, y = PC2, shape = Timepoint), size = 3) + 
    #geom_path(aes(x = PC1, y = PC2, group = MouseID), arrow = arrow(length = unit(0.55, "cm"))) +
  #coord_fixed(ratio=1/2)+
    labs(title= paste0({{title}})) 
  p
}
metadata<- read.delim("Zymo_2.0/starting_files/Metadata.tsv", header = TRUE,row.names=1)
names(metadata)
metadata$Diet
metadata$Collection <- factor(metadata$Collection)
diet_cols<- c("Control" = "black", "BD" = "red", "BD_supp"="blue")


zymo_arrow_stool_rpca<- generate_Zymo_longitudinal_pcoA_plots("Zymo_2.0/beta_diversity/RPCA - stool.csv", "Zymo_2.0/starting_files/Metadata.tsv", "Stool", Diet,diet_cols)+
  theme(legend.background = element_rect(fill="lightblue", size=0.5, linetype="solid")) +
  theme(plot.title = element_text(hjust = 0.5)) +
  geom_line(aes(group = MouseID),color="darkgrey", arrow = arrow(type = "closed",length=unit(0.075, "inches")))+
  geom_point(aes(x = PC1, y = PC2, shape = Collection), size = 3) + 
  geom_path(aes(x = PC1, y = PC2, group = MouseID), arrow = arrow(length = unit(0.55, "cm"))) 
zymo_arrow_stool_rpca

zymo_stool_rpca<- generate_Zymo_longitudinal_pcoA_plots("Zymo_2.0/beta_diversity/RPCA - stool.csv", "Zymo_2.0/starting_files/Metadata.tsv", "Stool", Diet,diet_cols)+
  theme(legend.background = element_rect(fill="lightblue", size=0.5, linetype="solid")) +
  theme(plot.title = element_text(hjust = 0.5))
zymo_stool_rpca
generate_Zymo_cs_pcoA_plots <- function(ordination_file, metadata, title, colorvariable,colorvector){
  data<-read.csv(ordination_file, header=FALSE)
  metadata <- read.delim(metadata, header=TRUE,row.names=1)
  metadata$SampleID <- row.names(metadata)
  
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
  data$Diet<-factor(data$Diet, levels=c("Control", "BD","BD_supp"))
  
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
zymo_colon_rpca<- generate_Zymo_cs_pcoA_plots("Zymo_2.0/beta_diversity/RPCA - colon.csv", "Zymo_2.0/starting_files/Metadata.tsv", "Colon", Diet,diet_cols)+
  theme(legend.background = element_rect(fill="lightblue", size=0.5, linetype="solid")) +
  theme(plot.title = element_text(hjust = 0.5))
zymo_colon_rpca

### Beta - Diversity Stats ---

# stool
metadata <-read.delim("Zymo_2.0/starting_files/Metadata.tsv",sep="\t",header=TRUE, row.names=1) #mapping file
write.csv(metadata, "Zymo_2.0/starting_files/Metadata.csv")
names(metadata)
permutewithin <- c("Collection")
subjectdata <- c("Diet", "MouseID")

?Microbiome.Biogeography::run_repeated_PERMANOVA()
run_repeated_PERMANOVA("Zymo_2.0/beta_diversity/dm_rpca_s12_min10000_Stool_ASV.qza.txt/distance-matrix.tsv",
                       "Zymo_2.0/starting_files/Metadata.csv",
                       permute_columns_vector = permutewithin,
                       subject_metadata_vector = subjectdata)

# intestines
data.dist<-read.table(file ="Zymo_2.0/beta_diversity/dm_rpca_s3_min10000_Colon_ASV.qza.txt/distance-matrix.tsv")
metadata <- read.csv("Zymo_2.0/starting_files/Metadata.csv", header=TRUE, row.names=1)


target <- row.names(data.dist)
metadata = metadata[match(target, row.names(metadata)),]
target == row.names(metadata)
data.dist <- as.dist(as(data.dist, "matrix"))

data.adonis=adonis(data.dist ~ Diet, data=metadata, permutations=10000)
data.adonis$aov.tab
