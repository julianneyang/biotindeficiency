### Collapse taxa on unfiltered ASV table
```shell
(qiime2-2019.10) qiime2@qiime2core2019-10:/media/sf_ZhouYi/Shared_Folder/Julianne_SLCCre/Biotin Deficiency 2022 Final/UCI/SampleType_Subsets$ bash ../../../scripts/collapse-taxa.sh intestine_min_10000_Skupsky_UCI_ASV_nofood.qza ../starting_files/taxonomy.qza
Saved FeatureTable[Frequency] to: L1_intestine_min_10000_Skupsky_UCI_ASV_nofood.qza
Saved FeatureTable[Frequency] to: L2_intestine_min_10000_Skupsky_UCI_ASV_nofood.qza
Saved FeatureTable[Frequency] to: L3_intestine_min_10000_Skupsky_UCI_ASV_nofood.qza
Saved FeatureTable[Frequency] to: L4_intestine_min_10000_Skupsky_UCI_ASV_nofood.qza
Saved FeatureTable[Frequency] to: L5_intestine_min_10000_Skupsky_UCI_ASV_nofood.qza
Saved FeatureTable[Frequency] to: L6_intestine_min_10000_Skupsky_UCI_ASV_nofood.qza
Saved FeatureTable[Frequency] to: L7_intestine_min_10000_Skupsky_UCI_ASV_nofood.qza
(qiime2-2019.10) qiime2@qiime2core2019-10:/media/sf_ZhouYi/Shared_Folder/Julianne_SLCCre/Biotin Deficiency 2022 Final/UCI/SampleType_Subsets$ bash ../../../scripts/collapse-taxa.sh stool_min_10000_Skupsky_UCI_ASV_nofood.qza ../starting_files/taxonomy.qza
Saved FeatureTable[Frequency] to: L1_stool_min_10000_Skupsky_UCI_ASV_nofood.qza
Saved FeatureTable[Frequency] to: L2_stool_min_10000_Skupsky_UCI_ASV_nofood.qza
Saved FeatureTable[Frequency] to: L3_stool_min_10000_Skupsky_UCI_ASV_nofood.qza
Saved FeatureTable[Frequency] to: L4_stool_min_10000_Skupsky_UCI_ASV_nofood.qza
Saved FeatureTable[Frequency] to: L5_stool_min_10000_Skupsky_UCI_ASV_nofood.qza
Saved FeatureTable[Frequency] to: L6_stool_min_10000_Skupsky_UCI_ASV_nofood.qza
Saved FeatureTable[Frequency] to: L7_stool_min_10000_Skupsky_UCI_ASV_nofood.qza

```
```shell
(qiime2-2019.10) qiime2@qiime2core2019-10:/media/sf_ZhouYi/Shared_Folder/Julianne_SLCCre/Biotin Deficiency 2022 Final/UCI$ bash ../../scripts/1-qiime-tools-import.sh Skupsky_UCI_ASV_nofood.tsv 
Enter filepath to tsv containing ASV count data Skupsky_UCI_ASV_nofood.tsv
Imported Skupsky_UCI_ASV_nofood.biom as BIOMV210Format to Skupsky_UCI_ASV_nofood.qza


(qiime2-2019.10) qiime2@qiime2core2019-10:/media/sf_ZhouYi/Shared_Folder/Julianne_SLCCre/Biotin Deficiency 2022 Final/UCI$ bash ../../scripts/2-all-filtering.sh Skupsky_UCI_ASV_nofood.qza 10000 9
Enter input filepath for qza table Skupsky_UCI_ASV_nofood.qza
Enter the minimum number of reads a sample must have in order to be retained 10000
Enter minimum number of samples a taxon must be observed in to be retained 9
Enter the output name for your new qza file with low sequencing depth samples discarded
Saved FeatureTable[Frequency] to: min_10000_Skupsky_UCI_ASV_nofood.qza
Enter the output name for qza file with low depth samples discarded and prevalence filtered taxa
Saved FeatureTable[Frequency] to: s9_min10000_Skupsky_UCI_ASV_nofood.qza

(qiime2-2019.10) qiime2@qiime2core2019-10:/media/sf_ZhouYi/Shared_Folder/Julianne_SLCCre/Biotin Deficiency 2022 Final/UCI$ bash ../../scripts/collapse-taxa.sh s9_min10000_Skupsky_UCI_ASV_nofood.qza taxonomy.qza
Saved FeatureTable[Frequency] to: L1_s9_min10000_Skupsky_UCI_ASV_nofood.qza
Saved FeatureTable[Frequency] to: L2_s9_min10000_Skupsky_UCI_ASV_nofood.qza
Saved FeatureTable[Frequency] to: L3_s9_min10000_Skupsky_UCI_ASV_nofood.qza
Saved FeatureTable[Frequency] to: L4_s9_min10000_Skupsky_UCI_ASV_nofood.qza
Saved FeatureTable[Frequency] to: L5_s9_min10000_Skupsky_UCI_ASV_nofood.qza
Saved FeatureTable[Frequency] to: L6_s9_min10000_Skupsky_UCI_ASV_nofood.qza
Saved FeatureTable[Frequency] to: L7_s9_min10000_Skupsky_UCI_ASV_nofood.qza
(qiime2-2019.10) qiime2@qiime2core2019-10:/media/sf_ZhouYi/Shared_Folder/Julianne_SLCCre/Biotin Deficiency 2022 Final/UCI$ bash ../../scripts/groupsamples.sh Skupsky_UCI_ASV_nofood.qza UCI_metadata_analysis_nofood.tsv Genotype_Timepoint
Call bash groupsamples.sh asv-table.qza metadata-file metadata-column
Saved FeatureTable[Frequency] to: groupby_Genotype_Timepoint_Skupsky_UCI_ASV_nofood.qza
(qiime2-2019.10) qiime2@qiime2core2019-10:/media/sf_ZhouYi/Shared_Folder/Julianne_SLCCre/Biotin Deficiency 2022 Final/UCI$ bash ../../scripts/taxabarplot.sh groupby_Genotype_Timepoint_Skupsky_UCI_ASV_nofood.qza taxonomy.qza Genotype_Timepoint_metadata.tsv 
Call bash taxabarplot.sh table taxonomy metadata
Saved Visualization to: barplot_groupby_Genotype_Timepoint_Skupsky_UCI_ASV_nofood.qza_dir.qzv
(qiime2-2019.10) qiime2@qiime2core2019-10:/media/sf_ZhouYi/Shared_Folder/Julianne_SLCCre/Biotin Deficiency 2022 Final/UCI$ mkdir collapsed_ASV_tables
(qiime2-2019.10) qiime2@qiime2core2019-10:/media/sf_ZhouYi/Shared_Folder/Julianne_SLCCre/Biotin Deficiency 2022 Final/UCI$ mv L*_* collapsed_ASV_tables/
(qiime2-2019.10) qiime2@qiime2core2019-10:/media/sf_ZhouYi/Shared_Folder/Julianne_SLCCre/Biotin Deficiency 2022 Final/UCI$ cd collapsed_ASV_tables/
(qiime2-2019.10) qiime2@qiime2core2019-10:/media/sf_ZhouYi/Shared_Folder/Julianne_SLCCre/Biotin Deficiency 2022 Final/UCI/collapsed_ASV_tables$ for file in *; do bash ../../../scripts/4-qiime-tools-export.sh $file;done
Takes qza input file as input and cranks out tsv and summary.txt file L1_s9_min10000_Skupsky_UCI_ASV_nofood.qza
Exported L1_s9_min10000_Skupsky_UCI_ASV_nofood.qza as BIOMV210DirFmt to directory export_L1_s9_min10000_Skupsky_UCI_ASV_nofood
Takes qza input file as input and cranks out tsv and summary.txt file L2_s9_min10000_Skupsky_UCI_ASV_nofood.qza
Exported L2_s9_min10000_Skupsky_UCI_ASV_nofood.qza as BIOMV210DirFmt to directory export_L2_s9_min10000_Skupsky_UCI_ASV_nofood
Takes qza input file as input and cranks out tsv and summary.txt file L3_s9_min10000_Skupsky_UCI_ASV_nofood.qza
Exported L3_s9_min10000_Skupsky_UCI_ASV_nofood.qza as BIOMV210DirFmt to directory export_L3_s9_min10000_Skupsky_UCI_ASV_nofood
Takes qza input file as input and cranks out tsv and summary.txt file L4_s9_min10000_Skupsky_UCI_ASV_nofood.qza
Exported L4_s9_min10000_Skupsky_UCI_ASV_nofood.qza as BIOMV210DirFmt to directory export_L4_s9_min10000_Skupsky_UCI_ASV_nofood
Takes qza input file as input and cranks out tsv and summary.txt file L5_s9_min10000_Skupsky_UCI_ASV_nofood.qza
Exported L5_s9_min10000_Skupsky_UCI_ASV_nofood.qza as BIOMV210DirFmt to directory export_L5_s9_min10000_Skupsky_UCI_ASV_nofood
Takes qza input file as input and cranks out tsv and summary.txt file L6_s9_min10000_Skupsky_UCI_ASV_nofood.qza
Exported L6_s9_min10000_Skupsky_UCI_ASV_nofood.qza as BIOMV210DirFmt to directory export_L6_s9_min10000_Skupsky_UCI_ASV_nofood
Takes qza input file as input and cranks out tsv and summary.txt file L7_s9_min10000_Skupsky_UCI_ASV_nofood.qza
Exported L7_s9_min10000_Skupsky_UCI_ASV_nofood.qza as BIOMV210DirFmt to directory export_L7_s9_min10000_Skupsky_UCI_ASV_nofood
(qiime2-2019.10) qiime2@qiime2core2019-10:/media/sf_ZhouYi/Shared_Folder/Julianne_SLCCre/Biotin Deficiency 2022 Final/UCI/collapsed_ASV_tables$ cd ..
(qiime2-2019.10) qiime2@qiime2core2019-10:/media/sf_ZhouYi/Shared_Folder/Julianne_SLCCre/Biotin Deficiency 2022 Final/UCI$ bash ../../scripts/4-qiime-tools-export.sh s9_min10000_Skupsky_UCI_ASV_nofood.qza 
Takes qza input file as input and cranks out tsv and summary.txt file s9_min10000_Skupsky_UCI_ASV_nofood.qza
Exported s9_min10000_Skupsky_UCI_ASV_nofood.qza as BIOMV210DirFmt to directory export_s9_min10000_Skupsky_UCI_ASV_nofood
(qiime2-2019.10) qiime2@qiime2core2019-10:/media/sf_ZhouYi/Shared_Folder/Julianne_SLCCre/Biotin Deficiency 2022 Final/UCI$ bash ../../scripts/4-qiime-tools-export.sh min_10000_Skupsky_UCI_ASV_nofood.qza 
Takes qza input file as input and cranks out tsv and summary.txt file min_10000_Skupsky_UCI_ASV_nofood.qza
Exported min_10000_Skupsky_UCI_ASV_nofood.qza as BIOMV210DirFmt to directory export_min_10000_Skupsky_UCI_ASV_nofood
(qiime2-2019.10) qiime2@qiime2core2019-10:/media/sf_ZhouYi/Shared_Folder/Julianne_SLCCre/Biotin Deficiency 2022 Final/UCI$ bash ../../scripts/rarefy_alpha_diversity.sh min_10000_Skupsky_UCI_ASV_nofood.qza 76382
Call bash rarefy_alpha_diversity.sh table.qza sampling_depth_integer
Saved FeatureTable[Frequency] to: d76382_min_10000_Skupsky_UCI_ASV_nofood.qza
Saved SampleData[AlphaDiversity] to: alpha_min_10000_Skupsky_UCI_ASV_nofood/shannon.qza
Saved SampleData[AlphaDiversity] to: alpha_min_10000_Skupsky_UCI_ASV_nofood/chao1.qza
Saved SampleData[AlphaDiversity] to: alpha_min_10000_Skupsky_UCI_ASV_nofood/otus.qza
Saved SampleData[AlphaDiversity] to: alpha_min_10000_Skupsky_UCI_ASV_nofood/pielou_e.qza
Exported chao1.qza as AlphaDiversityDirectoryFormat to directory chao1_dir
Exported otus.qza as AlphaDiversityDirectoryFormat to directory otus_dir
Exported pielou_e.qza as AlphaDiversityDirectoryFormat to directory pielou_e_dir
Exported shannon.qza as AlphaDiversityDirectoryFormat to directory shannon_dir

```

### Filter ASV table by intestines (cross- sectional) or stool (longitudinal)
```shell
(qiime2-2019.10) qiime2@qiime2core2019-10:/media/sf_ZhouYi/Shared_Folder/Julianne_SLCCre/Biotin Deficiency 2022 Final/UCI$ bash ../../scripts/filter-ASV-by-metadata.sh min_10000_Skupsky_UCI_ASV_nofood.qza UCI_metadata_analysis_nofood.tsv Sample_type intestine
Enter filepath to the .qza table min_10000_Skupsky_UCI_ASV_nofood.qza
Enter filepath to the metadata file in tsv format UCI_metadata_analysis_nofood.tsv
Enter the column name by which to subset the data Sample_type
Enter the value in the column by which to subset the data intestine
Saved FeatureTable[Frequency] to: intestine_min_10000_Skupsky_UCI_ASV_nofood.qza
(qiime2-2019.10) qiime2@qiime2core2019-10:/media/sf_ZhouYi/Shared_Folder/Julianne_SLCCre/Biotin Deficiency 2022 Final/UCI$ bash ../../scripts/filter-ASV-by-metadata.sh min_10000_Skupsky_UCI_ASV_nofood.qza UCI_metadata_analysis_nofood.tsv Sample_type stool
Enter filepath to the .qza table min_10000_Skupsky_UCI_ASV_nofood.qza
Enter filepath to the metadata file in tsv format UCI_metadata_analysis_nofood.tsv
Enter the column name by which to subset the data Sample_type
Enter the value in the column by which to subset the data stool
Saved FeatureTable[Frequency] to: stool_min_10000_Skupsky_UCI_ASV_nofood.qza
```
### Prevalence to 3 mice within each dataset
```shell
(qiime2-2019.10) qiime2@qiime2core2019-10:/media/sf_ZhouYi/Shared_Folder/Julianne_SLCCre/Biotin Deficiency 2022 Final/UCI$ bash ../../scripts/2-all-filtering.sh stool_min_10000_Skupsky_UCI_ASV_nofood.qza 10000 6
Enter input filepath for qza table stool_min_10000_Skupsky_UCI_ASV_nofood.qza
Enter the minimum number of reads a sample must have in order to be retained 10000
Enter minimum number of samples a taxon must be observed in to be retained 6
Enter the output name for your new qza file with low sequencing depth samples discarded
Saved FeatureTable[Frequency] to: min_10000_stool_min_10000_Skupsky_UCI_ASV_nofood.qza
Enter the output name for qza file with low depth samples discarded and prevalence filtered taxa
Saved FeatureTable[Frequency] to: s6_min10000_stool_min_10000_Skupsky_UCI_ASV_nofood.qza
(qiime2-2019.10) qiime2@qiime2core2019-10:/media/sf_ZhouYi/Shared_Folder/Julianne_SLCCre/Biotin Deficiency 2022 Final/UCI$ bash ../../scripts/2-all-filtering.sh intestine_min_10000_Skupsky_UCI_ASV_nofood.qza 10000 3
Enter input filepath for qza table intestine_min_10000_Skupsky_UCI_ASV_nofood.qza
Enter the minimum number of reads a sample must have in order to be retained 10000
Enter minimum number of samples a taxon must be observed in to be retained 3
Enter the output name for your new qza file with low sequencing depth samples discarded
Saved FeatureTable[Frequency] to: min_10000_intestine_min_10000_Skupsky_UCI_ASV_nofood.qza
Enter the output name for qza file with low depth samples discarded and prevalence filtered taxa
Saved FeatureTable[Frequency] to: s3_min10000_intestine_min_10000_Skupsky_UCI_ASV_nofood.qza
```
### Perform Robust Aitchison PCA
```shell
(qiime2-2019.10) qiime2@qiime2core2019-10:/media/sf_ZhouYi/Shared_Folder/Julianne_SLCCre/Biotin Deficiency 2022 Final/UCI$ bash ../../scripts/rpca.sh s3_min10000_intestine_min_10000_Skupsky_UCI_ASV_nofood.qza 
Enter filepath of filtered ASV table.qza file s3_min10000_intestine_min_10000_Skupsky_UCI_ASV_nofood.qza
This will perform Robust Aitchison PCA on a count matrix
Saved PCoAResults % Properties('biplot') to: biplot_rpca_s3_min10000_intestine_min_10000_Skupsky_UCI_ASV_nofood.qza
Saved DistanceMatrix to: dm_rpca_s3_min10000_intestine_min_10000_Skupsky_UCI_ASV_nofood.qza
Saved PCoAResults to: pcoa_rpca_s3_min10000_intestine_min_10000_Skupsky_UCI_ASV_nofood.qza
Exported pcoa_rpca_s3_min10000_intestine_min_10000_Skupsky_UCI_ASV_nofood.qza as OrdinationDirectoryFormat to directory pcoa_rpca_s3_min10000_intestine_min_10000_Skupsky_UCI_ASV_nofood.qza.txt
Exported dm_rpca_s3_min10000_intestine_min_10000_Skupsky_UCI_ASV_nofood.qza as DistanceMatrixDirectoryFormat to directory dm_rpca_s3_min10000_intestine_min_10000_Skupsky_UCI_ASV_nofood.qza.txt
(qiime2-2019.10) qiime2@qiime2core2019-10:/media/sf_ZhouYi/Shared_Folder/Julianne_SLCCre/Biotin Deficiency 2022 Final/UCI$ bash ../../scripts/rpca.sh s6_min10000_stool_min_10000_Skupsky_UCI_ASV_nofood.qza 
Enter filepath of filtered ASV table.qza file s6_min10000_stool_min_10000_Skupsky_UCI_ASV_nofood.qza
This will perform Robust Aitchison PCA on a count matrix
Saved PCoAResults % Properties('biplot') to: biplot_rpca_s6_min10000_stool_min_10000_Skupsky_UCI_ASV_nofood.qza
Saved DistanceMatrix to: dm_rpca_s6_min10000_stool_min_10000_Skupsky_UCI_ASV_nofood.qza
Saved PCoAResults to: pcoa_rpca_s6_min10000_stool_min_10000_Skupsky_UCI_ASV_nofood.qza
Exported pcoa_rpca_s6_min10000_stool_min_10000_Skupsky_UCI_ASV_nofood.qza as OrdinationDirectoryFormat to directory pcoa_rpca_s6_min10000_stool_min_10000_Skupsky_UCI_ASV_nofood.qza.txt
Exported dm_rpca_s6_min10000_stool_min_10000_Skupsky_UCI_ASV_nofood.qza as DistanceMatrixDirectoryFormat to directory dm_rpca_s6_min10000_stool_min_10000_Skupsky_UCI_ASV_nofood.qza.txt
```

### Collapse ASV by higher order phylogeny
```shell
(qiime2-2019.10) qiime2@qiime2core2019-10:/media/sf_ZhouYi/Shared_Folder/Julianne_SLCCre/Biotin Deficiency 2022 Final/UCI$ bash ../../scripts/collapse-taxa.sh s6_min10000_stool_min_10000_Skupsky_UCI_ASV_nofood.qza taxonomy.qza
Saved FeatureTable[Frequency] to: L1_s6_min10000_stool_min_10000_Skupsky_UCI_ASV_nofood.qza
Saved FeatureTable[Frequency] to: L2_s6_min10000_stool_min_10000_Skupsky_UCI_ASV_nofood.qza
Saved FeatureTable[Frequency] to: L3_s6_min10000_stool_min_10000_Skupsky_UCI_ASV_nofood.qza
Saved FeatureTable[Frequency] to: L4_s6_min10000_stool_min_10000_Skupsky_UCI_ASV_nofood.qza
Saved FeatureTable[Frequency] to: L5_s6_min10000_stool_min_10000_Skupsky_UCI_ASV_nofood.qza
Saved FeatureTable[Frequency] to: L6_s6_min10000_stool_min_10000_Skupsky_UCI_ASV_nofood.qza
Saved FeatureTable[Frequency] to: L7_s6_min10000_stool_min_10000_Skupsky_UCI_ASV_nofood.qza
(qiime2-2019.10) qiime2@qiime2core2019-10:/media/sf_ZhouYi/Shared_Folder/Julianne_SLCCre/Biotin Deficiency 2022 Final/UCI$ mkdir stool
(qiime2-2019.10) qiime2@qiime2core2019-10:/media/sf_ZhouYi/Shared_Folder/Julianne_SLCCre/Biotin Deficiency 2022 Final/UCI$ mv L*_* stool/
```
```shell
(qiime2-2019.10) qiime2@qiime2core2019-10:/media/sf_ZhouYi/Shared_Folder/Julianne_SLCCre/Biotin Deficiency 2022 Final/UCI$ bash ../../scripts/collapse-taxa.sh s3_min10000_intestine_min_10000_Skupsky_UCI_ASV_nofood.qza taxonomy.qza
Saved FeatureTable[Frequency] to: L1_s3_min10000_intestine_min_10000_Skupsky_UCI_ASV_nofood.qza
Saved FeatureTable[Frequency] to: L2_s3_min10000_intestine_min_10000_Skupsky_UCI_ASV_nofood.qza
Saved FeatureTable[Frequency] to: L3_s3_min10000_intestine_min_10000_Skupsky_UCI_ASV_nofood.qza
Saved FeatureTable[Frequency] to: L4_s3_min10000_intestine_min_10000_Skupsky_UCI_ASV_nofood.qza
Saved FeatureTable[Frequency] to: L5_s3_min10000_intestine_min_10000_Skupsky_UCI_ASV_nofood.qza
Saved FeatureTable[Frequency] to: L6_s3_min10000_intestine_min_10000_Skupsky_UCI_ASV_nofood.qza
Saved FeatureTable[Frequency] to: L7_s3_min10000_intestine_min_10000_Skupsky_UCI_ASV_nofood.qza
(qiime2-2019.10) qiime2@qiime2core2019-10:/media/sf_ZhouYi/Shared_Folder/Julianne_SLCCre/Biotin Deficiency 2022 Final/UCI$ mkdir intestine
(qiime2-2019.10) qiime2@qiime2core2019-10:/media/sf_ZhouYi/Shared_Folder/Julianne_SLCCre/Biotin Deficiency 2022 Final/UCI$ mv L*_* intestine/
```
### Make taxa barplot for each sample type 
```shell
(qiime2-2019.10) qiime2@qiime2core2019-10:/media/sf_ZhouYi/Shared_Folder/Julianne_SLCCre/Biotin Deficiency 2022 Final/UCI$ bash ../../scripts/taxabarplot.sh groupby_Genotype_s3_min10000_intestine_min_10000_Skupsky_UCI_ASV_nofood.qza taxonomy.qza Genotype.tsv 
Call bash taxabarplot.sh table taxonomy metadata
Saved Visualization to: barplot_groupby_Genotype_s3_min10000_intestine_min_10000_Skupsky_UCI_ASV_nofood.qza_dir.qzv
(qiime2-2019.10) qiime2@qiime2core2019-10:/media/sf_ZhouYi/Shared_Folder/Julianne_SLCCre/Biotin Deficiency 2022 Final/UCI$ mkdir intestine
(qiime2-2019.10) qiime2@qiime2core2019-10:/media/sf_ZhouYi/Shared_Folder/Julianne_SLCCre/Biotin Deficiency 2022 Final/UCI$ mv barplot_groupby_Genotype_s3_min10000_intestine_min_10000_Skupsky_UCI_ASV_nofood.qza_dir.qzv groupby_Genotype_s3_min10000_intestine_min_10000_Skupsky_UCI_ASV_nofood.qza Genotype.tsv intestine/
(qiime2-2019.10) qiime2@qiime2core2019-10:/media/sf_ZhouYi/Shared_Folder/Julianne_SLCCre/Biotin Deficiency 2022 Final/UCI$ 
```
```shell
(qiime2-2019.10) qiime2@qiime2core2019-10:/media/sf_ZhouYi/Shared_Folder/Julianne_SLCCre/Biotin Deficiency 2022 Final/UCI$ bash ../../scripts/taxabarplot.sh groupby_Genotype_Timepoint_s6_min10000_stool_min_10000_Skupsky_UCI_ASV_nofood.qza taxonomy.qza taxa_barplot/Genotype_Timepoint_metadata.tsv 
Call bash taxabarplot.sh table taxonomy metadata
Saved Visualization to: barplot_groupby_Genotype_Timepoint_s6_min10000_stool_min_10000_Skupsky_UCI_ASV_nofood.qza_dir.qzv
(qiime2-2019.10) qiime2@qiime2core2019-10:/media/sf_ZhouYi/Shared_Folder/Julianne_SLCCre/Biotin Deficiency 2022 Final/UCI$ mkdir stool
(qiime2-2019.10) qiime2@qiime2core2019-10:/media/sf_ZhouYi/Shared_Folder/Julianne_SLCCre/Biotin Deficiency 2022 Final/UCI$ mv groupby_Genotype_Timepoint_s6_min10000_stool_min_10000_Skupsky_UCI_ASV_nofood.qza barplot_groupby_Genotype_Timepoint_s6_min10000_stool_min_10000_Skupsky_UCI_ASV_nofood.qza_dir.qzv stool/
(qiime2-2019.10) qiime2@qiime2core2019-10:/media/sf_ZhouYi/Shared_Folder/Julianne_SLCCre/Biotin Deficiency 2022 Final/UCI$ mv intestine/ taxa_barplot/
(qiime2-2019.10) qiime2@qiime2core2019-10:/media/sf_ZhouYi/Shared_Folder/Julianne_SLCCre/Biotin Deficiency 2022 Final/UCI$ mv stool/ taxa_barplot/
```
