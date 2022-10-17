################## Assign Taxonomy to unhash QIIME sequences ########################
#Project: Biotin Deficiency 9-26-2022 "Re-assigning UCI rep-seqs"
library(dada2)

setwd("C:/Users/Jacobs Laboratory/Documents/JCYang/Biotin Deficiency 2022 Final/UCI_Host_Deficiency/")
set.seed(100) # Initialize random number generator for reproducibility

# Export your rep-seqs.fna file output from deblur denoise-16S
taxa <- assignTaxonomy("export_rep-seqs.qza/dna-sequences.fasta", "C:/Users/Jacobs Laboratory/Desktop/silva_nr_v132_train_set.fa.gz", multithread=TRUE)  # update directory with the deblur all.seqs.fa output file and with the most recent Silva 99% OTU database  
taxa <- addSpecies(taxa, "C:/Users/Jacobs Laboratory/Desktop/silva_species_assignment_v132.fa.gz")
taxa[is.na(taxa)] <- ""
taxonomy<-paste("k__",taxa[,1],"; ","p__",taxa[,2],"; ","c__",taxa[,3],"; ","o__",taxa[,4],"; ","f__",taxa[,5],"; ","g__",taxa[,6],"; ","s__",taxa[,7],sep="")
taxonomy <- as.data.frame(taxonomy)
output<-cbind(taxa, taxonomy)
write.csv(output, "UCI_taxonomy_assignments.csv")

## Rename dna-sequences.fasta to dna-sequences-fasta.txt
# Split rep-seqs FASTA file into two columns (so you have the QIIME gibberish in column A and the ASV sequence in column B)
library(dplyr)
library(tidyr)
fasta<- read.table("export_rep-seqs.qza/dna-sequences-fasta.txt")
fasta2<-fasta %>% separate(V1, c("ASV","QIIME_sequence"), sep = "([>])")
fasta2[fasta2==""]<-NA

ASV <- fasta2$ASV
fasta3 <- data.frame(ASV)
fasta3 <-as.data.frame(fasta3[-1,])
QIIME_seqs <- data.frame(fasta2$QIIME_sequence)
QIIME_seqs <- data.frame(QIIME_seqs[-(nrow(QIIME_seqs)),])  
names(QIIME_seqs)
fasta3$QIIME_seqs<- QIIME_seqs$QIIME_seqs...nrow.QIIME_seqs..... #modify the number to be the number of the last row
finalfasta<-na.omit(fasta3)
write.csv(finalfasta, "UCI_aligned_dna_sequences.csv")
