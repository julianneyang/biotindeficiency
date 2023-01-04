library(here)
library(tidyr)
library(dplyr)
library(ggplot2)
library(cowplot)
library(nlme)
library(ggpubr)
setwd("C:/Users/Jacobs Laboratory/Documents/JCYang/Biotin Deficiency 2022 Final/")
here::i_am("Biotin_Deficiency_RProj/Zymo_Weights.R")


# Body Weights UCI 
data<- read.csv("UCI/starting_files/Phenotypic_Data_UCI.csv",header=T)
metadata<- readr::read_delim("UCI/UCI_metadata_analysis_nofood.tsv")
data_meta <- merge(data,metadata, by="MouseID")
data_meta <- data_meta %>% select(c("MouseID","Genotype","Percent_baseline"))
data_meta <- unique(data_meta)

data_meta$Genotype <- factor(data_meta$Genotype, levels=c("WT","KO"))

cols<- c("WT" = "black", "KO" = "red")

uci_bw <- ggplot(data_meta, aes(x=Genotype, y=Percent_baseline, fill=Genotype)) + 
  geom_violin(alpha=0.25,position=position_dodge(width=.75),size=1,color="black",draw_quantiles=c(0.5))+
  scale_fill_manual(name="",values=cols) +
  geom_point(size=2,position=position_jitter(width=0.25),alpha=1)+
  labs(x="", y  ="% Baseline") +
  theme_cowplot(16) +
  ggtitle("Body Weight")+
  theme(legend.background = element_rect(fill="lightblue", size=0.5, linetype="solid")) +
  theme(plot.title = element_text(hjust = 0.5)) + 
  theme(legend.position = "top", legend.justification = "center")+
  theme(legend.title=element_blank()) +
  ylim(80,115)

### Body Weight Stats ---
t.test(Percent_baseline ~ Genotype, data_meta)
wilcox.test(Percent_baseline ~ Genotype, data_meta)

