library(here)
library(tidyr)
library(dplyr)
library(ggplot2)
library(cowplot)
library(nlme)
library(ggpubr)
setwd("C:/Users/Jacobs Laboratory/Documents/JCYang/Biotin Deficiency 2022 Final/")
here::i_am("Biotin_Deficiency_RProj/Zymo_Alpha_Diversity.R")

otus<- readr::read_delim("Zymo/alpha_diversity/alpha_ASV_table/otus_dir/alpha-diversity.tsv")
row.names(otus) <- otus$...1
shannon<-readr::read_delim("Zymo/alpha_diversity/alpha_ASV_table/shannon_dir/alpha-diversity.tsv")
stool$Timepoint <- stool$`Timepoint `
row.names(shannon) <- shannon$...1

data<- merge(otus,shannon, by="...1")
data$SampleID <- data$...1

metadata<- read.csv("Zymo/starting_files/Metadata.csv", header = TRUE, row.names=1)
metadata$SampleID <- row.names(metadata)
data_meta <- merge(data,metadata, by="SampleID")

### Split into stool and intestine datasets
# stool 
stool <- data_meta %>% dplyr::filter(SampleType == "Stool")

# intestine
colon <- data_meta %>% dplyr::filter(SampleType == "Colon")


### Function for plotting alpha diversity ---
generate_UCI_adiv_plots <- function(input_data, X, Y, min, max){
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
    scale_fill_viridis_d()+ +
    #geom_line(aes(group = MouseID,color=Genotype),size=1)+
    geom_point(size=2,position=position_jitter(width=0.25),alpha=1)+
    theme_cowplot(12) +
    ylim(min,max) +
    theme(legend.position = "none")
  
}

### Make and store plots ---
compare <-c(c("Control","BD"),c("Control","BD_supp")) 
Zymo_tranversestool<- generate_UCI_adiv_plots(stool, Collection, shannon, 4, 8) + 
  stat_compare_means(comparisons = compare,method="wilcox", vjust=0.3,label="p.signif",step.increase=0.05)
Zymo_longitudinalstool_lines <- generate_UCI_adiv_plots(stool, Timepoint, shannon, 0, 7) + facet_grid(~Genotype) 
ghintestines <- generate_UCI_adiv_plots(intestine, Genotype,shannon,0,7) +facet_grid(~Timepoint)

otus_tranversestool<- generate_UCI_adiv_plots(stool, Genotype, observed_otus, 0, 400) +facet_grid(~Timepoint)
otus_longitudinalstool_lines <- generate_UCI_adiv_plots(stool, Timepoint, observed_otus, 0, 400) + facet_grid(~Genotype) 
otus_longitudinalstool <- generate_UCI_adiv_plots(stool, Timepoint, observed_otus, 0, 400) + facet_grid(~Genotype) 
otus_intestines <- generate_UCI_adiv_plots(intestine, Genotype,observed_otus,0,400) +facet_grid(~Timepoint)

### Alpha Diversity Stats ---
#stool
stool$Genotype <-factor(stool$Genotype, levels=c("WT", "KO"))
output <- lme(fixed= shannon ~ Timepoint*Genotype, random = ~1|MouseID, data=stool)
summary(output)
output <- lme(fixed= observed_otus ~ Timepoint*Genotype, random = ~1|MouseID, data=stool)
summary(output)
output <- lme(fixed= shannon ~ Timepoint+Genotype, random = ~1|MouseID, data=stool)
summary(output)
output <- lme(fixed= observed_otus ~ Timepoint+Genotype, random = ~1|MouseID, data=stool)
summary(output)

stool_day0 <- stool %>% filter(Timepoint=="Day0")
stool_day7 <- stool %>% filter(Timepoint=="Day7 ")

wilcox.test(shannon~Genotype,stool_day0)
wilcox.test(shannon~Genotype,stool_day7)
wilcox.test(observed_otus~Genotype,stool_day0)
wilcox.test(observed_otus~Genotype,stool_day7)

t.test(shannon~Genotype,stool_day0)
t.test(shannon~Genotype,stool_day7)
t.test(observed_otus~Genotype,stool_day0)
t.test(observed_otus~Genotype,stool_day7)


#intestine
t.test(shannon~Genotype,intestine)
t.test(observed_otus~Genotype,intestine)
wilcox.test(observed_otus~Genotype,intestine)
wilcox.test(shannon~Genotype,intestine)
