library(Maaslin2)
library(funrar)
library(dplyr)
library(ggplot2)
library(cowplot)
library(plyr)
library(EnhancedVolcano)

setwd("C:/Users/Jacobs Laboratory/Documents/JCYang/Biotin Deficiency 2022 Final/")

### UCLA grab biotin biosynthesis ---
input_data <- read.csv("UCLA/pathway-table/UCLA PICRUST - ucla_pwy.csv", header=TRUE, row.names=1) # choose filtered non rarefied csv file
annotation <- input_data %>% select("description")
annotation$feature <- row.names(input_data)
df_input_data <- select(input_data, -c("description", "taxonomy"))

input_metadata <-read.delim("UCLA/starting_files/Metadata.tsv",sep="\t",header=TRUE, row.names=1)
input_metadata$SampleID <- row.names(input_metadata)
# Get datasets ---
samples <- input_metadata %>% filter(SampleType =="Stool_Pellet", SampleID %in% names(df_input_data)) %>% pull(SampleID)
stool_data <- df_input_data[,samples]

cecum_samples <- input_metadata %>% filter(SampleType =="adherent_cecum", SampleID %in% names(df_input_data)) %>% pull(SampleID)
cecum_data <- df_input_data[,cecum_samples]

# Make a density plot ---
cecum_data <- as.data.frame(t(cecum_data))
cecum_data <- cecum_data %>% select(c("BIOTIN-BIOSYNTHESIS-PWY"))
cecum_data$SampleID <- row.names(cecum_data)
cecum_data$Group<-revalue(cecum_data$Group, c("Control"="CD", "BD"="BD"))
cecum_data <- merge(cecum_data,input_metadata, by="SampleID")

cols <- c("BD"="red", "CD"="black")

ucla_cecum_biotin <- ggplot(cecum_data, aes(`BIOTIN-BIOSYNTHESIS-PWY`, fill = Group, colour = Group)) +
  geom_density(alpha = 0.5) + 
  theme_cowplot(16) +
  scale_x_log10()+ 
  scale_fill_manual(values=cols) +
  scale_color_manual(values=cols) +
  labs(title = "Biotin biosynthesis I",
       x = "log10(Abundance)") + 
  theme_cowplot(16) +
  theme(legend.background = element_rect(fill="lightblue", size=0.5, linetype="solid")) +
  theme(plot.title = element_text(hjust = 0.5)) + 
  theme(legend.position = "top", legend.justification = "center")+
  theme(legend.title=element_blank())

# Make a density plot for STool ---
cecum_data <- as.data.frame(t(stool_data))
cecum_data <- cecum_data %>% select(c("BIOTIN-BIOSYNTHESIS-PWY"))
cecum_data$SampleID <- row.names(cecum_data)
cecum_data <- merge(cecum_data,input_metadata, by="SampleID")
cecum_data$Group<-revalue(cecum_data$Group, c("Control"="CD", "BD"="BD"))
cols <- c("BD"="red", "CD"="black")

ucla_stool_biotin <- ggplot(cecum_data, aes(`BIOTIN-BIOSYNTHESIS-PWY`, fill = Group, colour = Group)) +
  geom_density(alpha = 0.5) + 
  theme_cowplot(16) +
  scale_x_log10()+ 
  scale_fill_manual(values=cols) +
  scale_color_manual(values=cols) +
  labs(title = "Biotin biosynthesis I",
       x = "log10(Abundance)") + 
  theme_cowplot(16) +
  theme(legend.background = element_rect(fill="lightblue", size=0.5, linetype="solid")) +
  theme(plot.title = element_text(hjust = 0.5)) + 
  theme(legend.position = "top", legend.justification = "center")+
  theme(legend.title=element_blank())


### UCI grab biotin biosynthesis ---
input_data <- read.csv("UCI/pathway-table/UCI Metacyc Table - uci_pwy.csv", header=TRUE, row.names=1) # choose filtered non rarefied csv file
annotation <- input_data %>% select("description")
annotation$feature <- row.names(input_data)
df_input_data <- select(input_data, -c("description", "taxonomy"))

input_metadata <-read.delim("UCI/starting_files/UCI_metadata_analysis_nofood.tsv",sep="\t",header=TRUE, row.names=1)
input_metadata$SampleID <- row.names(input_metadata)

# Get datasets ---
samples <- input_metadata %>% filter(Sample_type =="stool", SampleID %in% names(df_input_data)) %>% pull(SampleID)
stool_data <- df_input_data[,samples]

samples <- input_metadata %>% filter(Sample_type =="intestine", SampleID %in% names(df_input_data)) %>% pull(SampleID)
colon_data <- df_input_data[,samples]

# Make a density plot ---
colon_data <- as.data.frame(t(colon_data))
colon_data <- colon_data %>% select(c("BIOTIN-BIOSYNTHESIS-PWY"))
colon_data$SampleID <- row.names(colon_data)
colon_data <- merge(colon_data,input_metadata, by="SampleID")

cols <- c("KO"="red", "WT"="black")

uci_colon_biotin <- ggplot(colon_data, aes(`BIOTIN-BIOSYNTHESIS-PWY`, fill = Genotype, colour = Genotype)) +
  geom_density(alpha = 0.5) + 
  theme_cowplot(16) +
  scale_x_log10()+ 
  scale_fill_manual(values=cols) +
  scale_color_manual(values=cols) +
  labs(title = "Biotin biosynthesis I",
       x = "log10(Abundance)") + 
  theme_cowplot(16) +
  theme(legend.background = element_rect(fill="lightblue", size=0.5, linetype="solid")) +
  theme(plot.title = element_text(hjust = 0.5)) + 
  theme(legend.position = "top", legend.justification = "center")+
  theme(legend.title=element_blank())

first <- plot_grid(uci_colon_pwy, ucla_cecum_pwy, ucla_stool_pwy, ucla_stool_biotin, nrow=3, labels=c("A","B", "C"))
second <- plot_grid(uci_colon_biotin, ucla_cecum_biotin, NULL, nrow=3,align="hv", axis="tblr", labels=c("D", "E", ""))
dev.new(width=10, height=20)
plot_grid(first, second, axis="tblr", align="hv")

third<- plot_grid(ucla_cecum_pwy, ucla_cecum_biotin, 
                  ucla_stool_pwy, ucla_stool_biotin, 
                  uci_colon_pwy, uci_colon_biotin, nrow=3, labels=c("A","D","B","E","C","F"))
fourth <- plot_grid(uci_colon_pwy, uci_colon_biotin,  nrow=1, labels=c("C",""))

biotin_only <- plot_grid(ucla_cecum_biotin, 
                        ucla_stool_biotin, 
                        uci_colon_biotin, ncol=3)

dev.new(width=10, height=20)
third

dev.new(width=10, height=20)
fourth