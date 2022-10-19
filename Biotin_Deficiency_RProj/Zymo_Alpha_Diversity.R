library(here)
library(tidyr)
library(dplyr)
library(ggplot2)
library(cowplot)
library(nlme)
library(ggpubr)
setwd("C:/Users/Jacobs Laboratory/Documents/JCYang/Biotin Deficiency 2022 Final/")
here::i_am("Biotin_Deficiency_RProj/Zymo_Alpha_Diversity.R")

otus<- readr::read_delim("Zymo_2.0/alpha_diversity/alpha_ASV/otus_dir/alpha-diversity.tsv")
row.names(otus) <- otus$...1
shannon<-readr::read_delim("Zymo_2.0/alpha_diversity/alpha_ASV/shannon_dir/alpha-diversity.tsv")
row.names(shannon) <- shannon$...1

data<- merge(otus,shannon, by="...1")
data$SampleID <- data$...1

metadata<- read.delim("Zymo_2.0/starting_files/Metadata.tsv", header = TRUE, row.names=1)
metadata$SampleID <- row.names(metadata)
data_meta <- merge(data,metadata, by="SampleID")

### Split into stool and intestine datasets
# stool 
stool <- data_meta %>% dplyr::filter(SampleType == "Stool")

# intestine
colon <- data_meta %>% dplyr::filter(SampleType == "Colon")


### Function for plotting alpha diversity ---
generate_Zymo_adiv_plots <- function(input_data, X, Y, min, max){
  #read in files
  data <- as.data.frame(input_data)
  
  #declare order of variables
  data$Diet <- factor(data$Diet, levels=c("Control", "BD","BD_supp"))
  data$Collection <- factor(data$Collection, levels= c("Week0", "Week4","Week8","Week12"))
  #data$Timepoint <- plyr::revalue(data$Timepoint, c("Day0." = "Day 0", "Day7 " = "Day 7"))
  #data$Genotype_Timepoint <- factor(data$Genotype_Timepoint, levels = c("WT_Day0", "WT_Day7 ", "KO_Day0", "KO_Day7"))
  #graph plot
  ggplot(data=data,aes(x={{X}},y={{Y}}, fill=Diet)) + 
    geom_violin(alpha=0.25,position=position_dodge(width=75),size=1,color="black",draw_quantiles=c(0.5))+
    scale_fill_viridis_d()+ 
    #geom_line(aes(group = MouseID,color=Genotype),size=1)+
    geom_point(size=2,position=position_jitter(width=0.25),alpha=1)+
    theme_cowplot(12) +
    ylim(min,max) +
    theme(legend.position = "none")
  
}

### Make and store plots ---
compare <-c(c("Control","BD"),c("Control","BD_supp")) 
max(stool$shannon)
Zymo_tranversestool<- generate_Zymo_adiv_plots(stool, Diet, shannon, 0,5.5) + facet_grid(~Collection)+
  stat_compare_means(comparisons = compare,method="wilcox", vjust=0.3,label="p.signif",step.increase=0.05)
Zymo_tranversestool
max(colon$shannon)
Zymo_intestines <- generate_Zymo_adiv_plots(colon, Diet,shannon,0,5.5)
Zymo_intestines

max(stool$observed_otus)
Zymo_otus_tranversestool<- generate_Zymo_adiv_plots(stool, Diet, observed_otus, 0, 150) +facet_grid(~Collection)
Zymo_otus_tranversestool
max(colon$observed_otus)
Zymo_otus_intestines <- generate_Zymo_adiv_plots(colon, Diet,observed_otus,0,75) 
Zymo_otus_intestines

### Alpha Diversity Stats ---
#stool
stool$Diet <-factor(stool$Diet, levels=c("Control", "BD","BD_supp"))
output <- lme(fixed= shannon ~ Collection*Diet, random = ~1|MouseID, data=stool)
summary(output)
output <- lme(fixed= observed_otus ~ Collection*Diet, random = ~1|MouseID, data=stool)
summary(output)
output <- lme(fixed= shannon ~ Collection+Diet, random = ~1|MouseID, data=stool)
summary(output)
output <- lme(fixed= observed_otus ~ Collection+Diet, random = ~1|MouseID, data=stool)
summary(output)


#intestine
cvsbd <- colon %>% filter(Diet!="BD_supp")
t.test(shannon~Diet,cvsbd)
t.test(observed_otus~Diet,cvsbd)
wilcox.test(observed_otus~Diet,cvsbd)
wilcox.test(shannon~Diet,cvsbd)

cvsbds <- colon %>% filter(Diet!="BD")
t.test(shannon~Diet,cvsbds)
t.test(observed_otus~Diet,cvsbds)
wilcox.test(observed_otus~Diet,cvsbds)
wilcox.test(shannon~Diet,cvsbds)
