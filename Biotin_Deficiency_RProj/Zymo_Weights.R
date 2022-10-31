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
data<- read.csv("Zymo_2.0/Phenotypic_Data_Zymo.csv",header=T)
data$Diet<-factor(data$Diet, levels=c("Control", "BD","BD_supp"))
data$Collection <- factor(data$Collection, levels= c("Week0", "Week4","Week8", "Week12"))

diet_cols<- c("Control" = "black", "BD" = "red", "BD_supp"="blue")

ggplot(data, aes(x=Collection, y=Weight_Percent_of_Baseline, color=Diet)) + 
  scale_colour_manual(name="",values=diet_cols) +
  geom_line(aes(group=MouseID),lwd=1) +
  geom_point(size=3) +
  theme_cowplot(12) +
  labs(x="", y  ="% Baseline Body Weight") +
  theme(legend.position="top",legend.justification = "center") 

### Body Weight Stats ---
output <- lme(fixed= Weight_Percent_of_Baseline ~ Collection*Diet, random = ~1|MouseID, data=data)
summary(output)
output <- lme(fixed= Weight_Percent_of_Baseline ~ Collection+Diet, random = ~1|MouseID, data=data)
summary(output)
