library(here)
library(tidyr)
library(dplyr)
library(ggplot2)
library(cowplot)
library(nlme)
library(ggpubr)
setwd("C:/Users/Jacobs Laboratory/Documents/JCYang/Biotin Deficiency 2022 Final/")
here::i_am("Biotin_Deficiency_RProj/Zymo_Weights.R")


# Body Weights Zymo 
data<- read.csv("Zymo_2.0/starting_files/Phenotypic_Data_Zymo.csv",header=T)
data$Diet<-plyr::revalue(data$Diet, c("Control" ="CD", "BD"="BD","BD_supp"="CD"))
data$Diet <- factor(data$Diet, levels=c("CD","BD"))
data$Collection <- factor(data$Collection, levels= c("Week0", "Week4","Week8", "Week12"))

diet_cols<- c("CD" = "black", "BD" = "red")

zymo_bw <- ggplot(data, aes(x=Collection, y=Weight_Percent_of_Baseline, color=Diet)) + 
  scale_colour_manual(name="",values=diet_cols) +
  geom_line(aes(group=MouseID),lwd=1) +
  geom_point(size=3) +
  labs(x="", y  ="% Baseline Body Weight") +
  theme_cowplot(16) +
  ggtitle("Body Weight")+
  theme(legend.background = element_rect(fill="lightblue", size=0.5, linetype="solid")) +
  theme(plot.title = element_text(hjust = 0.5)) + 
  theme(legend.position = "top", legend.justification = "center")+
  theme(legend.title=element_blank()) 

### Body Weight Stats ---
output <- lme(fixed= Weight_Percent_of_Baseline ~ Collection*Diet, random = ~1|MouseID, data=data)
summary(output)
output <- lme(fixed= Weight_Percent_of_Baseline ~ Collection+Diet, random = ~1|MouseID, data=data)
summary(output)

fig_zymo_abc <- plot_grid(zymo_bw,NULL,NULL, nrow=1, labels=c("A","B",""))
