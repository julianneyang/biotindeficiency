library(Maaslin2)
library(funrar)
library(dplyr)
library(ggplot2)
library(cowplot)
library(plyr)
library(EnhancedVolcano)

setwd("C:/Users/Jacobs Laboratory/Documents/JCYang/Biotin Deficiency 2022 Final/")

### Run Maaslin2 of pathways ---
input_data <- read.csv("UCLA/pathway-table/UCLA PICRUST - ucla_pwy.csv", header=TRUE, row.names=1) # choose filtered non rarefied csv file
annotation <- input_data %>% select("description")
annotation$feature <- row.names(input_data)
df_input_data <- select(input_data, -c("description", "taxonomy"))

input_metadata <-read.delim("UCLA/starting_files/Metadata.tsv",sep="\t",header=TRUE, row.names=1)
input_metadata$SampleID <- row.names(input_metadata)
# Get datasets ---
samples <- input_metadata %>% filter(SampleType =="Stool_Pellet", SampleID %in% names(df_input_data)) %>% pull(SampleID)
samples_data <- df_input_data[,samples]
write.csv(samples_data, "UCLA/pathway-table/stool_pwy.csv")

samples <- input_metadata %>% filter(SampleType =="SI_luminal", SampleID %in% names(df_input_data)) %>% pull(SampleID)
samples_data <- df_input_data[,samples]
write.csv(samples_data, "UCLA/pathway-table/SI_luminal.csv")

samples <- input_metadata %>% filter(SampleType =="SI_adherent", SampleID %in% names(df_input_data)) %>% pull(SampleID)
samples_data <- df_input_data[,samples]
write.csv(samples_data, "UCLA/pathway-table/SI_adherent.csv")

cecum_samples <- input_metadata %>% filter(SampleType =="adherent_cecum", SampleID %in% names(df_input_data)) %>% pull(SampleID)
df_input_data <- df_input_data[,cecum_samples]
write.csv(samples_data, "UCLA/pathway-table/cecum_pwy.csv")

### Run Maaslin2 and get table of relative abundances

run_Maaslin2 <- function(counts_filepath, metadata_filepath, subset_string) {
  #input_data <- read.csv("UCLA/collapsed_ASV_tables/L6 - Stool.csv", header=TRUE, row.names=1) # choose filtered non rarefied csv file
  input_data <- read.csv(counts_filepath, header=TRUE, row.names=1) # choose filtered non rarefied csv file
  
  
  df_input_data <- as.data.frame(input_data)
  
  input_metadata <-read.delim(metadata_filepath,sep="\t",header=TRUE, row.names=1)
  
  target <- colnames(df_input_data)
  input_metadata = input_metadata[match(target, row.names(input_metadata)),]
  target == row.names(input_metadata)
  
  df_input_metadata<-input_metadata
  df_input_metadata$Mouse.ID <- factor(df_input_metadata$Mouse.ID)
  df_input_metadata$Diet <- factor(df_input_metadata$Group, levels=c("Control","BD"))
  df_input_metadata$Sex <- factor(df_input_metadata$Sex)
  sapply(df_input_metadata,levels)
  
  ?Maaslin2
  fit_data = Maaslin2(input_data=df_input_data, 
                      input_metadata=df_input_metadata, 
                      output = paste0("UCLA/pathway-table/",subset_string,"_PWY_Maaslin2_Sex_Diet"), 
                      fixed_effects = c("Sex","Diet"),normalization="TSS", 
                      min_prevalence = 0.1875,
                      transform ="log",plot_heatmap = FALSE,plot_scatter = FALSE)
}

## Sex and Diet only 

# cecum 
run_Maaslin2("UCLA/pathway-table/cecum_pwy.csv","UCLA/starting_files/Metadata.tsv","Cecum")

# stool
run_Maaslin2("UCLA/pathway-table/stool_pwy.csv","UCLA/starting_files/Metadata.tsv","Stool")

# silum
run_Maaslin2("UCLA/pathway-table/SI_luminal.csv","UCLA/starting_files/Metadata.tsv","SI_luminal")

# simuc
run_Maaslin2("UCLA/pathway-table/SI_adherent.csv","UCLA/starting_files/Metadata.tsv","SI_adherent")

### Append annotations ---
# cecum --- 231 features
data<-read.table("UCLA/pathway-table/Cecum_PWY_Maaslin2_Sex_Diet/significant_results.tsv", header=TRUE)
data <- data %>% filter(metadata=="Diet")
testing<-data$feature
#append descriptors 
input_data <- read.csv("UCLA/pathway-table/UCLA PICRUST - ucla_pwy.csv", header=TRUE, row.names=1) # choose filtered non rarefied csv file
annotation <- input_data %>% select("description")
annotation$feature <- row.names(input_data)
annotation$feature <- gsub("-",".",annotation$feature)
annotation$feature <- gsub("\\+",".",annotation$feature)
annotation$feature <- gsub("3.HYDRO","X3.HYDRO",annotation$feature)
annotation$feature <- gsub("1CMET","X1CMET",annotation$feature)

data<-merge(data,annotation,by="feature")
testing2<-data$feature
c(setdiff(testing, testing2), setdiff(testing2, testing))

write.csv(data, "UCLA/pathway-table/cecum_significant_annotated_pwy.csv")

# stool --- 176 features
data<-read.table("UCLA/pathway-table/Stool_PWY_Maaslin2_Sex_Diet/significant_results.tsv", header=TRUE)
data <- data %>% filter(metadata=="Diet")
testing<-data$feature
#append descriptors 
input_data <- read.csv("UCLA/pathway-table/UCLA PICRUST - ucla_pwy.csv", header=TRUE, row.names=1) # choose filtered non rarefied csv file
annotation <- input_data %>% select("description")
annotation$feature <- row.names(input_data)
annotation$feature <- gsub("-",".",annotation$feature)
annotation$feature <- gsub("\\+",".",annotation$feature)
annotation$feature <- gsub("3.HYDRO","X3.HYDRO",annotation$feature)
annotation$feature <- gsub("1CMET","X1CMET",annotation$feature)

data<-merge(data,annotation,by="feature")
testing2<-data$feature
c(setdiff(testing, testing2), setdiff(testing2, testing))

write.csv(data, "UCLA/pathway-table/stool_significant_annotated_pwy.csv")

# SI luminal --- 48 significant features
data<-read.table("UCLA/pathway-table/SI_luminal_PWY_Maaslin2_Sex_Diet/significant_results.tsv", header=TRUE)
data <- data %>% filter(metadata=="Diet")
testing<-data$feature
#append descriptors 
input_data <- read.csv("UCLA/pathway-table/UCLA PICRUST - ucla_pwy.csv", header=TRUE, row.names=1) # choose filtered non rarefied csv file
annotation <- input_data %>% select("description")
annotation$feature <- row.names(input_data)
annotation$feature <- gsub("-",".",annotation$feature)
annotation$feature <- gsub("\\+",".",annotation$feature)
annotation$feature <- gsub("3.HYDRO","X3.HYDRO",annotation$feature)
annotation$feature <- gsub("1CMET","X1CMET",annotation$feature)

data<-merge(data,annotation,by="feature")
testing2<-data$feature
c(setdiff(testing, testing2), setdiff(testing2, testing))

write.csv(data, "UCLA/pathway-table/silum_significant_annotated_pwy.csv")

# SI mucosal --- 38 significant features
data<-read.table("UCLA/pathway-table/SI_adherent_PWY_Maaslin2_Sex_Diet/significant_results.tsv", header=TRUE)
data <- data %>% filter(metadata=="Diet")
testing<-data$feature
#append descriptors 
input_data <- read.csv("UCLA/pathway-table/UCLA PICRUST - ucla_pwy.csv", header=TRUE, row.names=1) # choose filtered non rarefied csv file
annotation <- input_data %>% select("description")
annotation$feature <- row.names(input_data)
annotation$feature <- gsub("-",".",annotation$feature)
annotation$feature <- gsub("\\+",".",annotation$feature)
annotation$feature <- gsub("3.HYDRO","X3.HYDRO",annotation$feature)
annotation$feature <- gsub("1CMET","X1CMET",annotation$feature)

data<-merge(data,annotation,by="feature")
testing2<-data$feature
c(setdiff(testing, testing2), setdiff(testing2, testing))

write.csv(data, "UCLA/pathway-table/simuc_significant_annotated_pwy.csv")

### Run Maaslin2 with histology ---
run_Maaslin2_histo <- function(counts_filepath, metadata_filepath, subset_string, select_string) {
  #input_data <- read.csv("UCLA/collapsed_ASV_tables/L6 - Stool.csv", header=TRUE, row.names=1) # choose filtered non rarefied csv file
  input_data <- read.csv(counts_filepath, header=TRUE, row.names=1) # choose filtered non rarefied csv file
  
  
  df_input_data <- as.data.frame(input_data)
  
  #input_metadata <-read.delim("UCLA/starting_files/Histo_Metadata.tsv",sep="\t",header=TRUE, row.names=1)
  
  input_metadata <-read.delim(metadata_filepath,sep="\t",header=TRUE, row.names=1)
  
  target <- colnames(df_input_data)
  input_metadata = input_metadata[match(target, row.names(input_metadata)),]
  print(target == row.names(input_metadata))
  
  df_input_metadata<-input_metadata
  df_input_metadata$Mouse.ID <- factor(df_input_metadata$Mouse.ID)
  df_input_metadata$Diet <- factor(df_input_metadata$Group, levels=c("Control","BD"))
  df_input_metadata$Sex <- factor(df_input_metadata$Sex)
  sapply(df_input_metadata,levels)
  
  if(select_string=="sex_diet_histo"){
    fit_data = Maaslin2(input_data=df_input_data, 
                        input_metadata=df_input_metadata, 
                        output = paste0("UCLA/pathway-table/",subset_string,"_PWY_Maaslin2_Sex_Diet_Histology"), 
                        fixed_effects = c("Sex","Diet", "Histology"),normalization="TSS", 
                        min_prevalence = 0.1875,
                        transform ="log",plot_heatmap = FALSE,plot_scatter = FALSE)
  }
  if(select_string=="sex_histo"){
    fit_data = Maaslin2(input_data=df_input_data, 
                        input_metadata=df_input_metadata, 
                        output = paste0("UCLA/pathway-table/",subset_string,"_PWY_Maaslin2_Sex_Histology"), 
                        fixed_effects = c("Sex", "Histology"),normalization="TSS", 
                        min_prevalence = 0.1875,
                        transform ="log",plot_heatmap = FALSE,plot_scatter = FALSE)
  }
  if(select_string=="histo"){
    fit_data = Maaslin2(input_data=df_input_data, 
                        input_metadata=df_input_metadata, 
                        output = paste0("UCLA/pathway-table/",subset_string,"_PWY_Maaslin2_Histology"), 
                        fixed_effects = c("Histology"),normalization="TSS", 
                        min_prevalence = 0.1875,
                        transform ="log",plot_heatmap = FALSE,plot_scatter = FALSE)
  }
}

# cecum - 0 significant features
run_Maaslin2_histo("UCLA/pathway-table/cecum_pwy.csv","UCLA/starting_files/Histo_Metadata.tsv","Cecum", "sex_diet_histo")
run_Maaslin2_histo("UCLA/pathway-table/cecum_pwy.csv","UCLA/starting_files/Histo_Metadata.tsv","Cecum", "sex_histo")

# stool - 0 significant features, biotin biosynthesis increased but has p=0.07
run_Maaslin2_histo("UCLA/pathway-table/stool_pwy.csv","UCLA/starting_files/Histo_Metadata.tsv","Stool", "sex_diet_histo")
run_Maaslin2_histo("UCLA/pathway-table/stool_pwy.csv","UCLA/starting_files/Histo_Metadata.tsv","Stool", "sex_histo")

# SI luminal - 0 significant features
run_Maaslin2_histo("UCLA/pathway-table/SI_luminal.csv","UCLA/starting_files/Histo_Metadata.tsv","SI_luminal", "sex_diet_histo")
run_Maaslin2_histo("UCLA/pathway-table/SI_luminal.csv","UCLA/starting_files/Histo_Metadata.tsv","SI_luminal", "sex_histo")

# SI adherent - 0 significant features
run_Maaslin2_histo("UCLA/pathway-table/SI_adherent.csv","UCLA/starting_files/Histo_Metadata.tsv","SI_adherent", "sex_diet_histo")
run_Maaslin2_histo("UCLA/pathway-table/SI_adherent.csv","UCLA/starting_files/Histo_Metadata.tsv","SI_adherent", "sex_histo")


### Make Volcano plot ---
## cecum --
data<-read.table("UCLA/pathway-table/Cecum_PWY_Maaslin2_Sex_Diet/all_results.tsv", header=TRUE)
data <- data %>% filter(metadata=="Diet" &qval<0.05)
annotation$feature <- gsub("-",".",annotation$feature)
data<-merge(data,annotation,by="feature")
ucla_cecum <- EnhancedVolcano(data,
                              lab = data$description,
                              x = 'coef',
                              y = 'qval',
                              title = 'BD vs. CD',
                              xlab = bquote(~Log[2]~ 'fold change'),
                              ylab = bquote(~Log[10]~ '(q-value)'),
                              pCutoff = 0.05,
                              FCcutoff = 1.0,
                              pointSize = 3.0,
                              labSize = 7.0,
                              labCol = 'black',
                              labFace = 'bold',
                              #boxedLabels = TRUE,
                              #parseLabels = TRUE,
                              legendLabels=c('NS.','Log2FC','q-value',
                                             'q-value & Log2FC'),
                              legendLabSize = 8,
                              legendIconSize = 3)

ucla_cecum_pwy <- ucla_cecum + 
  labs(title = "Colon: BD vs CD",
       subtitle = NULL,
       caption = "# Significant MetaCyc pathways: 231") + 
  theme_cowplot(20) +
  theme(legend.background = element_rect(fill="lightblue", size=0.5, linetype="solid")) +
  theme(plot.title = element_text(hjust = 0.5),
        plot.caption = element_text(size=20)) + 
  theme(legend.position = "top", legend.justification = "center")+
  theme(legend.title=element_blank()) +
  ylim(0,8)
ucla_cecum_pwy
## stool --
data<-read.table("UCLA/pathway-table/Stool_PWY_Maaslin2_Sex_Diet/all_results.tsv", header=TRUE)
data <- data %>% filter(metadata=="Diet")
annotation$feature <- gsub("-",".",annotation$feature)
data<-merge(data,annotation,by="feature")
ucla_stool <- EnhancedVolcano(data,
                              lab = data$description,
                              x = 'coef',
                              y = 'qval',
                              title = 'BD vs. CD',
                              xlab = bquote(~Log[2]~ 'fold change'),
                              ylab = bquote(~Log[10]~ '(q-value)'),
                              pCutoff = 0.05,
                              FCcutoff = 1.0,
                              pointSize = 3.0,
                              labSize = 7.0,
                              labCol = 'black',
                              labFace = 'bold',
                              #boxedLabels = TRUE,
                              #parseLabels = TRUE,
                              legendLabels=c('NS.','Log2FC','q-value',
                                             'q-value & Log2FC'),
                              legendLabSize = 8,
                              legendIconSize = 3)

ucla_stool_pwy <- ucla_stool + 
  labs(title = "Stool: BD vs CD",
       subtitle = NULL,
       caption = "# Significant MetaCyc pathways: 176") + 
  theme_cowplot(20) +
  theme(legend.background = element_rect(fill="lightblue", size=0.5, linetype="solid")) +
  theme(plot.title = element_text(hjust = 0.5),
        plot.caption = element_text(size=20)) + 
  theme(legend.position = "top", legend.justification = "center")+
  theme(legend.title=element_blank()) +
  ylim(0,6.5)
ucla_stool_pwy

## SI luminal  --
data<-read.table("UCLA/pathway-table/SI_luminal_PWY_Maaslin2_Sex_Diet/all_results.tsv", header=TRUE)
data <- data %>% filter(metadata=="Diet")
annotation$feature <- gsub("-",".",annotation$feature)
data<-merge(data,annotation,by="feature")
ucla_silum <- EnhancedVolcano(data,
                              lab = data$description,
                              x = 'coef',
                              y = 'qval',
                              title = 'BD vs. CD',
                              xlab = bquote(~Log[2]~ 'fold change'),
                              ylab = bquote(~Log[10]~ '(q-value)'),
                              pCutoff = 0.05,
                              FCcutoff = 1.0,
                              pointSize = 3.0,
                              labSize = 3.0,
                              labCol = 'black',
                              labFace = 'bold',
                              #boxedLabels = TRUE,
                              #parseLabels = TRUE,
                              legendLabels=c('NS.','Log2FC','q-value',
                                             'q-value & Log2FC'),
                              legendLabSize = 8,
                              legendIconSize = 3)

ucla_silum_pwy <- ucla_silum + 
  labs(title = "SI luminal: BD vs CD",
       subtitle = NULL,
       caption = "# Significant MetaCyc pathways: 48") + 
  theme_cowplot(16) +
  theme(legend.background = element_rect(fill="lightblue", size=0.5, linetype="solid")) +
  theme(plot.title = element_text(hjust = 0.5)) + 
  theme(legend.position = "top", legend.justification = "center")+
  theme(legend.title=element_blank()) +
  ylim(0,3)
ucla_silum_pwy

## SI mucosal  --
data<-read.table("UCLA/pathway-table/SI_adherent_PWY_Maaslin2_Sex_Diet/all_results.tsv", header=TRUE)
data <- data %>% filter(metadata=="Diet")
annotation$feature <- gsub("-",".",annotation$feature)
data<-merge(data,annotation,by="feature")
ucla_simuc <- EnhancedVolcano(data,
                              lab = data$description,
                              x = 'coef',
                              y = 'qval',
                              title = 'BD vs. CD',
                              xlab = bquote(~Log[2]~ 'fold change'),
                              ylab = bquote(~Log[10]~ '(q-value)'),
                              pCutoff = 0.05,
                              FCcutoff = 1.0,
                              pointSize = 3.0,
                              labSize = 3.0,
                              labCol = 'black',
                              labFace = 'bold',
                              #boxedLabels = TRUE,
                              #parseLabels = TRUE,
                              legendLabels=c('NS.','Log2FC','q-value',
                                             'q-value & Log2FC'),
                              legendLabSize = 8,
                              legendIconSize = 3)

ucla_simuc_pwy <- ucla_simuc + 
  labs(title = "SI mucosal: BD vs CD",
       subtitle = NULL,
       caption = "# Significant MetaCyc pathways: 38") + 
  theme_cowplot(16) +
  theme(legend.background = element_rect(fill="lightblue", size=0.5, linetype="solid")) +
  theme(plot.title = element_text(hjust = 0.5)) + 
  theme(legend.position = "top", legend.justification = "center")+
  theme(legend.title=element_blank()) +
  ylim(0,3)
ucla_simuc_pwy

dev.new(width=20,height=20)
plot_grid(ucla_silum_pwy, ucla_simuc_pwy, ucla_cecum_pwy, ucla_stool_pwy, nrow=2, ncol=2, axis="tblr", align="hc")