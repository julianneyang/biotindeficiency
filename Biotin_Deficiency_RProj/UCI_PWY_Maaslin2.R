library(Maaslin2)
library(funrar)
library(dplyr)
library(ggplot2)
library(cowplot)
library(plyr)
library(EnhancedVolcano)
setwd("C:/Users/Jacobs Laboratory/Documents/JCYang/Biotin Deficiency 2022 Final/")

### Run Maaslin2 of pathways 
input_data <- read.csv("UCI/pathway-table/UCI Metacyc Table - uci_pwy.csv", header=TRUE, row.names=1) # choose filtered non rarefied csv file

annotation <- input_data %>% select("description")
annotation$feature <- row.names(input_data)
df_input_data <- select(input_data, -c("description", "taxonomy"))


input_metadata <-read.delim("UCI/UCI_metadata_analysis_nofood.tsv",sep="\t",header=TRUE, row.names=1) #mapping file
input_metadata$SampleID <- row.names(input_metadata)
# Get intestine dataset ---
intestine_samples <- input_metadata %>% filter(Sample_type =="intestine", SampleID %in% names(df_input_data)) %>% pull(SampleID)
df_input_data <- df_input_data[,intestine_samples]

target <- colnames(df_input_data)
input_metadata = input_metadata[match(target, row.names(input_metadata)),]
target == row.names(input_metadata)

df_input_metadata<-input_metadata
df_input_metadata$MouseID <- factor(df_input_metadata$MouseID)
df_input_metadata$Genotype <- factor(df_input_metadata$Genotype, levels=c("WT","KO"))
sapply(df_input_metadata,levels)

fit_data = Maaslin2(input_data=df_input_data, input_metadata=df_input_metadata, 
                    output = "UCI/pathway-table/pwy_intestines_Maaslin2_Genotype", 
                    fixed_effects = c("Genotype"),
                    min_prevalence = 0.375,
                    normalization="TSS", transform ="log",plot_heatmap = FALSE,plot_scatter = FALSE)

# stool ---
input_data <- read.csv("UCI/pathway-table/UCI Metacyc Table - uci_pwy.csv", header=TRUE, row.names=1) # choose filtered non rarefied csv file

annotation <- input_data %>% select("description")
annotation$featureID <- row.names(input_data)
df_input_data <- select(input_data, -c("description", "taxonomy"))


input_metadata <-read.delim("UCI/UCI_metadata_analysis_nofood.tsv",sep="\t",header=TRUE, row.names=1) #mapping file
input_metadata$SampleID <- row.names(input_metadata)
input_metadata$Genotype<- factor(input_metadata$Genotype,levels=c("WT","KO"))
res.aov <- aov(weight~Timepoint*Genotype,input_metadata)
timepointANDgenotype<- as.data.frame(model.matrix(res.aov))
timepointANDgenotype$TimepointANDGenotype <- timepointANDgenotype$`TimepointDay7 :GenotypeKO`
timepointANDgenotype <- timepointANDgenotype %>% select("TimepointANDGenotype")
timepointANDgenotype$SampleID <- row.names(timepointANDgenotype)
input_metadata <- merge(input_metadata, timepointANDgenotype, by="SampleID")
row.names(input_metadata) <- input_metadata$SampleID

# Get stool dataset ---
stool_samples <- input_metadata %>% filter(Sample_type =="stool", SampleID %in% names(df_input_data)) %>% pull(SampleID)
df_input_data <- df_input_data[,stool_samples]

target <- colnames(df_input_data)
input_metadata = input_metadata[match(target, row.names(input_metadata)),]
target == row.names(input_metadata)

df_input_metadata<-input_metadata
df_input_metadata$MouseID <- factor(df_input_metadata$MouseID)
df_input_metadata$Genotype <- factor(df_input_metadata$Genotype, levels=c("WT","KO"))
df_input_metadata$Timepoint <- factor(df_input_metadata$Timepoint, levels=c("Day0", "Day7 "))
sapply(df_input_metadata,levels)

fit_data = Maaslin2(input_data=df_input_data, input_metadata=df_input_metadata, 
                    output = "UCI/pathway-table/pwy_stool_Maaslin2_Timepoint_Genotype_1-MouseID", 
                    fixed_effects = c("Timepoint","Genotype"), 
                    random_effects=c("MouseID"),
                    min_prevalence = 0.375,
                    normalization="TSS", transform ="log",plot_heatmap = FALSE,plot_scatter = FALSE)
fit_data = Maaslin2(input_data=df_input_data, input_metadata=df_input_metadata, 
                    output = "UCI/pathway-table/pwy_stool_Maaslin2_Timepoint_Genotype_TimepointANDGenotype_1-MouseID", 
                    fixed_effects = c("Timepoint","Genotype","TimepointANDGenotype"), 
                    min_prevalence = 0.375,
                    random_effects=c("MouseID"),
                    normalization="TSS", transform ="log",plot_heatmap = FALSE,plot_scatter = FALSE)

### Make a Barplot ---
# intestines ---
data<-read.table("UCI/pathway-table/pwy_intestines_Maaslin2_Genotype/significant_results.tsv", header=TRUE)
data <- data %>% filter(qval <0.05)

#append descriptors 
annotation$feature <- gsub("-",".",annotation$feature)
data<-merge(data,annotation,by="feature")

write.csv(data, "UCI/pathway-table/intestines_significant_annotated_features.csv")


# stool, Timepoint + Genotype ---
data<-read.table("UCI/pathway-table/pwy_stool_Maaslin2_Timepoint_Genotype_1-MouseID/all_results.tsv", header=TRUE)
data <- data %>% filter(qval <0.05)

#append descriptors 
annotation$feature <- gsub("-",".",annotation$feature)
data<-merge(data,annotation,by="feature")
#No significant features

# stool, Timepoint*Genotype ---
data<-read.table("UCI/pathway-table/pwy_stool_Maaslin2_Timepoint_Genotype_TimepointANDGenotype_1-MouseID/significant_results.tsv", header=TRUE)
data <- data %>% filter(qval <0.05)

### Make Volcano plot ---
data<-read.table("UCI/pathway-table/pwy_intestines_Maaslin2_Genotype/all_results.tsv", header=TRUE)
annotation$feature <- gsub("-",".",annotation$feature)
annotation$feature <- gsub("/",".",annotation$feature)
data<-merge(data,annotation,by="feature")
uci_colon <- EnhancedVolcano(data,
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

uci_colon_pwy <- uci_colon + labs(title = "Colon: KO vs WT",
                                 subtitle = NULL,
                                 caption = "# Significant MetaCyc pathways: 97") + 
  theme_cowplot(20) +
  theme(legend.background = element_rect(fill="lightblue", size=0.5, linetype="solid")) +
  theme(plot.title = element_text(hjust = 0.5),
        plot.caption = element_text(size=20)) + 
  theme(legend.position = "top", legend.justification = "center")+
  theme(legend.title=element_blank()) +
  ylim(0,3)
uci_colon_pwy

plot_grid(ucla_cecum_ec, uci_colon_ec, nrow=1, labels=c("A","B"))

#No significant features