library(here)
library(tidyr)
library(dplyr)
library(ggplot2)
library(cowplot)
library(nlme)
library(ggpubr)
setwd("C:/Users/Jacobs Laboratory/Documents/JCYang/Biotin Deficiency 2022 Final/")
here::i_am("Biotin_Deficiency_RProj/UCLA_Weights_and_Calprotectin.R")

# Read in pheno data
data<- read.csv("UCLA/starting_files/Phenotypic_Data_UCLA.csv", header = TRUE, row.names=1)

#declare order of variables
data$Diet <- factor(data$Group, levels=c("Control", "BD"))
data$Diet <- plyr::revalue(data$Diet, c("Control"="CD", "BD"="BD"))

#filter out weights
data <- data[-1,]
histo <- data[-13,]
calprotectin <- data %>% select(c(Diet,Calprotectin))
calprotectin <- na.omit(calprotectin)


#graph weights plot
cols <- c("CD"="black", "BD"="red")
ucla_bw <- ggplot(data=data,aes(x=Diet,y=X..Starting.weight, fill=Diet)) + 
  geom_violin(alpha=0.25,position=position_dodge(width=75),size=1,color="black",draw_quantiles=c(0.5))+
  scale_fill_manual(values=cols)+
  #geom_line(aes(group = MouseID,color=Genotype),size=1)+
  geom_point(size=2,position=position_jitter(width=0.25),alpha=1)+
  theme_cowplot(16) +
  theme(legend.position = "none")+
  labs(x="", y  ="% Baseline") +
  ggtitle("Body Weight") +
  theme(plot.title = element_text(hjust = 0.5)) 

dev.new(width=15, height=10)
ucla_bw
#graph histo plot
histo$Histology<-as.numeric(histo$Histology)
histo_plot <- ggplot(data=histo,aes(x=Diet,y=Histology, fill=Diet)) + 
  geom_violin(alpha=0.25,position=position_dodge(width=75),size=1,color="black",draw_quantiles=c(0.5))+
  scale_fill_manual(values=cols)+
  #geom_line(aes(group = MouseID,color=Genotype),size=1)+
  geom_point(size=2,position=position_jitter(width=0.25),alpha=1)+
  theme_cowplot(16) +
  theme(legend.position = "none")+
  labs(x="", y  ="Score")  +
  ggtitle("Histology") +
  theme(plot.title = element_text(hjust = 0.5)) 

dev.new(width=15, height=10)
histo_plot

#graph calprotectin plot
calpro <- ggplot(data=calprotectin,aes(x=Diet,y=Calprotectin, fill=Diet)) + 
  geom_violin(alpha=0.25,position=position_dodge(width=75),size=1,color="black",draw_quantiles=c(0.5))+
  scale_fill_manual(values=cols)+
  #geom_line(aes(group = MouseID,color=Genotype),size=1)+
  geom_point(size=2,position=position_jitter(width=0.25),alpha=1)+
  theme_cowplot(16) +
  theme(legend.position = "none")+
  labs(x="", y  ="Units") +
  ggtitle("Calprotectin") +
  theme(plot.title = element_text(hjust = 0.5)) 

dev.new(width=15, height=10)
calpro
dev.new(width=15, height=10)
figabcd<- plot_grid(ucla_bw,histo_plot,calpro,NULL,nrow=4,ncol=1, axis ="tblr", align="hv",
          labels =c("A", "B", "C", "D"))

plot_grid(figabcd, figefgh, ncol=2)
### Phenotype Stats ---

#Weight
t.test(X..Starting.weight~Group,data)
wilcox.test(X..Starting.weight~Group,data)

#Histology
t.test(Histology~Group,histo)
wilcox.test(Histology~Group,histo)

#Calprotectin
t.test(Calprotectin~Diet,calprotectin)
wilcox.test(Calprotectin~Diet,calprotectin)

