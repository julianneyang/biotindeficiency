library(here)
library(tidyr)
library(dplyr)
library(ggplot2)
library(cowplot)
library(nlme)
library(ggpubr)
setwd("C:/Users/Jacobs Laboratory/Documents/JCYang/Biotin Deficiency 2022 Final/")
here::i_am("Biotin_Deficiency_RProj/UCLA_Weights_and_Calprotectin.R")

# Aggregate alppha diversity and metadata
data<- read.csv("UCLA/Phenotypic_Data_UCLA.csv", header = TRUE, row.names=1)

#declare order of variables
data$Diet <- factor(data$Group, levels=c("Control", "BD"))

#filter out weights
data <- data[-1,]
histo <- data[-13,]


#graph weights plot
ggplot(data=data,aes(x=Diet,y=X..Starting.weight, fill=Diet)) + 
  geom_violin(alpha=0.25,position=position_dodge(width=75),size=1,color="black",draw_quantiles=c(0.5))+
  scale_fill_viridis_d()+ 
  #geom_line(aes(group = MouseID,color=Genotype),size=1)+
  geom_point(size=2,position=position_jitter(width=0.25),alpha=1)+
  theme_cowplot(12) +
  theme(legend.position = "none")+
  labs(x="", y  ="% Baseline Body Weight") 
  
#graph histo plot
histo$Diet
histo$Histology<-as.numeric(histo$Histology)
ggplot(data=histo,aes(x=Diet,y=Histology, fill=Diet)) + 
  geom_violin(alpha=0.25,position=position_dodge(width=75),size=1,color="black",draw_quantiles=c(0.5))+
  scale_fill_viridis_d()+ 
  #geom_line(aes(group = MouseID,color=Genotype),size=1)+
  geom_point(size=2,position=position_jitter(width=0.25),alpha=1)+
  theme_cowplot(12) +
  theme(legend.position = "none")+
  labs(x="", y  ="Histology Score") 


### Make and store plots ---
compare <-c("Control","BD")
stool_adiv_shannon <- generate_UCLA_adiv_plots(stool, Diet, shannon, 0, 5) +
  stat_compare_means(comparisons = compare,method="wilcox", vjust=0.3,label="p.signif",step.increase=0.05)
stool_adiv_otus <- generate_UCLA_adiv_plots(stool, Diet, observed_otus, 0, 120) +
  stat_compare_means(comparisons = compare,method="wilcox", vjust=0.3,label="p.signif",step.increase=0.05)

cecum_adiv_shannon <- generate_UCLA_adiv_plots(cecum, Diet, shannon, 0, 5) +
  stat_compare_means(comparisons = compare,method="wilcox", vjust=0.3,label="p.signif",step.increase=0.05)
cecum_adiv_otus <- generate_UCLA_adiv_plots(cecum, Diet, observed_otus, 0, 120) +
  stat_compare_means(comparisons = compare,method="wilcox", vjust=0.3,label="p.signif",step.increase=0.05)

SImuc_adiv_shannon <- generate_UCLA_adiv_plots(SI_adherent, Diet, shannon, 0, 5) +
  stat_compare_means(comparisons = compare,method="wilcox", vjust=0.3,label="p.signif",step.increase=0.05)
SImuc_adiv_otus <- generate_UCLA_adiv_plots(SI_adherent, Diet, observed_otus, 0, 120) +
  stat_compare_means(comparisons = compare,method="wilcox", vjust=0.3,label="p.signif",step.increase=0.05)

SIlum_adiv_shannon <- generate_UCLA_adiv_plots(SI_luminal, Diet, shannon, 0, 5) +
  stat_compare_means(comparisons = compare,method="wilcox", vjust=0.3,label="p.signif",step.increase=0.05)
SIlum_adiv_otus <- generate_UCLA_adiv_plots(SI_luminal, Diet, observed_otus, 0, 120) +
  stat_compare_means(comparisons = compare,method="wilcox", vjust=0.3,label="p.signif",step.increase=0.05)

max(SI_luminal$observed_otus)

### Alpha Diversity Stats ---

#stool
t.test(shannon~Group,stool)
t.test(observed_otus~Group,stool)
wilcox.test(observed_otus~Group,stool)
wilcox.test(shannon~Group,stool)

#cecum
t.test(shannon~Group,cecum)
t.test(observed_otus~Group,cecum)
wilcox.test(observed_otus~Group,cecum)
wilcox.test(shannon~Group,cecum)

#SI adherent
t.test(shannon~Group,SI_adherent)
t.test(observed_otus~Group,SI_adherent)
wilcox.test(observed_otus~Group,SI_adherent)
wilcox.test(shannon~Group,SI_adherent)

#SI luminal
t.test(shannon~Group,SI_luminal)
t.test(observed_otus~Group,SI_luminal)
wilcox.test(observed_otus~Group,SI_luminal)
wilcox.test(shannon~Group,SI_luminal)
