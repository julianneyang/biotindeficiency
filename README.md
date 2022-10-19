# biotindeficiency
Scripts used in biotin deficiency project

### Three datasets used in this project
The institution refers to the institution that created the sequencing libraries.
- UCI "Host deficiency"(2020)
  - Contains data from WT and Biotin Receptor KO mice at Day 0 and Day 7
- Zymo "Biotin-deficient diets and supplementation" (2019)
  - Contains data from mice on biotin deficient diet (BD), control diet (CD), and biotin-deficient diet with biotin supplementation (BD_supp)
- UCLA "Biotin-deficient diet and the microbiome at different sites"
  - Contains cross-sectional data from mice on biotin deficient diet and control diet, 
  
### Preprocessing Details
##### UCI "Host Deficiency"
- Used UCI's ASV table (preprocessed with DADA2 in QIIME) - lacked raw FASTQ files
- Used Silva v132 trained on 16S for species assignment

##### Zymo 2.0 "Biotin-deficient diets and supplementation"
- Used Zymo's ASV table (preprocessed with DADA2 in QIIME) - did not know error modeling parameters
- v3v4 sequencing was done so could not use Silva classifier

##### UCLA "Biotin-deficient diet and the microbiome at different sites"
- Truncation 220,150 forward, reverse
- DADA2 in R library(dada2)
- Used Silva v132 trained on 16S for species assignment

