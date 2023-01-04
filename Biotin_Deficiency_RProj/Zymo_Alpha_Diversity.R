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
metadata$Diet<-plyr::revalue(metadata$Diet, c("Control" ="CD", "BD"="BD","BD_supp"="CD"))
metadata$Diet <- factor(metadata$Diet, levels=c("CD","BD"))
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
  #data$Diet <- factor(data$Diet, levels=c("Control", "BD","BD_supp"))
  data$Collection <- factor(data$Collection, levels= c("Week0", "Week4","Week8","Week12"))
  #data$Timepoint <- plyr::revalue(data$Timepoint, c("Day0." = "Day 0", "Day7 " = "Day 7"))
  #data$Genotype_Timepoint <- factor(data$Genotype_Timepoint, levels = c("WT_Day0", "WT_Day7 ", "KO_Day0", "KO_Day7"))
  #graph plot
  ggplot(data=data,aes(x={{X}},y={{Y}}, fill=Diet)) + 
    geom_violin(alpha=0.25,position=position_dodge(width=75),size=1,color="black",draw_quantiles=c(0.5))+
    scale_fill_viridis_d()+ 
    #geom_line(aes(group = MouseID,color=Genotype),size=1)+
    geom_point(size=2,position=position_jitter(width=0.25),alpha=1)+
    theme_cowplot(16) +
    ylim(min,max) +
    theme(legend.position = "none")
  
}

### Make and store plots ---
max(stool$shannon)
Zymo_tranversestool<- generate_Zymo_adiv_plots(stool, Diet, shannon, 0,5.5) + facet_grid(~Collection)+
  xlab("")
Zymo_tranversestool
max(colon$shannon)
Zymo_intestines <- generate_Zymo_adiv_plots(colon, Diet,shannon,0,5.5)+ facet_grid(~Collection) +xlab("")
Zymo_intestines

max(stool$observed_otus)
Zymo_otus_tranversestool<- generate_Zymo_adiv_plots(stool, Diet, observed_otus, 0, 150) +facet_grid(~Collection)+
  xlab("")
Zymo_otus_tranversestool
max(colon$observed_otus)
Zymo_otus_intestines <- generate_Zymo_adiv_plots(colon, Diet,observed_otus,0,75) + facet_grid(~Collection) +xlab("")
Zymo_otus_intestines

### Alpha Diversity Stats ---
#stool
stool$Diet <-factor(stool$Diet, levels=c("CD", "BD"))
output <- lme(fixed= shannon ~ Collection*Diet, random = ~1|MouseID, data=stool)
summary(output)
output <- lme(fixed= observed_otus ~ Collection*Diet, random = ~1|MouseID, data=stool)
summary(output)
output <- lme(fixed= shannon ~ Collection+Diet, random = ~1|MouseID, data=stool)
summary(output)
output <- lme(fixed= observed_otus ~ Collection+Diet, random = ~1|MouseID, data=stool)
summary(output)

#control vs bd
stool_Week4 <- stool %>% filter(Diet!="BD_supp") %>% filter(Collection=="Week4")
stool_Week8 <- stool %>% filter(Diet!="BD_supp") %>% filter(Collection=="Week8")
stool_Week12 <- stool %>% filter(Diet!="BD_supp") %>% filter(Collection=="Week12")

t.test(shannon~Diet, stool_Week4)
t.test(shannon~Diet, stool_Week8)
t.test(shannon~Diet, stool_Week12)

t.test(observed_otus~Diet, stool_Week4)
t.test(observed_otus~Diet, stool_Week8)
t.test(observed_otus~Diet, stool_Week12)

#control vs bd_supp
stool_Week4 <- stool %>% filter(Diet!="BD") %>% filter(Collection=="Week4")
stool_Week8 <- stool %>% filter(Diet!="BD") %>% filter(Collection=="Week8")
stool_Week12 <- stool %>% filter(Diet!="BD") %>% filter(Collection=="Week12")

t.test(shannon~Diet, stool_Week4)
t.test(shannon~Diet, stool_Week8)
t.test(shannon~Diet, stool_Week12)

t.test(observed_otus~Diet, stool_Week4)
t.test(observed_otus~Diet, stool_Week8)
t.test(observed_otus~Diet, stool_Week12)

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

fig_zymo_def <- plot_grid(zymo_colon_rpca, Zymo_intestines, Zymo_otus_intestines, nrow=1, labels=c("C","D","E"))
fig_zymo_ghi <- plot_grid(zymo_stool_rpca, Zymo_tranversestool, Zymo_otus_tranversestool, nrow=1, labels=c("F","G","H"))
plot_grid(fig_zymo_abc, fig_zymo_def, nrow=2)
