library(Maaslin2)
library(funrar)
library(dplyr)
library(ggplot2)
library(cowplot)
library(plyr)
library(EnhancedVolcano)

setwd("C:/Users/Jacobs Laboratory/Documents/JCYang/Biotin Deficiency 2022 Final/")

### Run Maaslin2 of pathways 
input_data <- read.csv("UCLA/pathway-table/UCLA PICRUST - ucla_ec.csv", header=TRUE, row.names=1) # choose filtered non rarefied csv file
annotation <- input_data %>% select("description")
annotation$feature <- row.names(input_data)
df_input_data <- select(input_data, -c("description", "taxonomy"))

input_metadata <-read.delim("UCLA/starting_files/Metadata.tsv",sep="\t",header=TRUE, row.names=1)
input_metadata$SampleID <- row.names(input_metadata)
# Get datasets ---
cecum_samples <- input_metadata %>% filter(SampleType =="adherent_cecum", SampleID %in% names(df_input_data)) %>% pull(SampleID)
df_input_data <- df_input_data[,cecum_samples]
write.csv(df_input_data, "UCLA/pathway-table/cecum_ec.csv")

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
                      output = paste0("UCLA/pathway-table/",subset_string,"_EC_Maaslin2_Sex_Diet"), 
                      fixed_effects = c("Sex","Diet"),normalization="TSS", 
                      min_prevalence = 0.1875,
                      transform ="log",plot_heatmap = FALSE,plot_scatter = FALSE)
}

## Sex and Diet only 

# cecum 
run_Maaslin2("UCLA/pathway-table/cecum_ec.csv","UCLA/starting_files/Metadata.tsv","Cecum")


### Append annotations ---
# intestines ---
data<-read.table("UCLA/Cecum_EC_Maaslin2_Sex_Diet/significant_results.tsv", header=TRUE)
data <- data %>% filter(metadata=="Diet" & qval <0.05)

# append descriptors 
annotation$feature <- gsub(":",".",annotation$feature)
data<-merge(data,annotation,by="feature")

write.csv(data, "UCLA/pathway-table/cecum_significant_annotated_ec.csv")

# Make Volcano plot 
data<-read.table("UCLA/pathway-table/Cecum_EC_Maaslin2_Sex_Diet/all_results.tsv", header=TRUE)
data <- data %>% filter(metadata=="Diet")
annotation$feature <- gsub(":",".",annotation$feature)
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
                labSize = 4.0,
                labCol = 'black',
                labFace = 'bold',
                #boxedLabels = TRUE,
                #parseLabels = TRUE,
                legendLabels=c('NS.','Log2FC','q-value',
                               'q-value & Log2FC'),
                legendLabSize = 8,
                legendIconSize = 3)

ucla_cecum_ec <- ucla_cecum + labs(title = "Cecum: BD vs CD",
                  subtitle = NULL,
                  caption = "# Significant EC: 873") + 
  theme_cowplot(16) +
  theme(legend.background = element_rect(fill="lightblue", size=0.5, linetype="solid")) +
  theme(plot.title = element_text(hjust = 0.5)) + 
  theme(legend.position = "top", legend.justification = "center")+
  theme(legend.title=element_blank()) +
  ylim(0,10)
ucla_cecum_ec 
