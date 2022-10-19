### Importing ASV table
```shell
(qiime2-2019.10) qiime2@qiime2core2019-10:/media/sf_ZhouYi/Shared_Folder/Julianne_SLCCre/Biotin Deficiency 2022 Final/Zymo_BD_CTRL_Supp$ bash ../../scripts/1-qiime-tools-import.sh ASV_table.tsv 
Enter filepath to tsv containing ASV count data ASV_table.tsv
Imported ASV_table.biom as BIOMV210Format to ASV_table.qza
```

### Rarefy ASV table to 6018 
```shell
(qiime2-2019.10) qiime2@qiime2core2019-10:/media/sf_ZhouYi/Shared_Folder/Julianne_SLCCre/Biotin Deficiency 2022 Final/Zymo_BD_CTRL_Supp$ bash ../../scripts/rarefy_alpha_diversity.sh ASV_table.qza 6018
Call bash rarefy_alpha_diversity.sh table.qza sampling_depth_integer
Saved FeatureTable[Frequency] to: d6018_ASV_table.qza
Saved SampleData[AlphaDiversity] to: alpha_ASV_table/shannon.qza
Saved SampleData[AlphaDiversity] to: alpha_ASV_table/chao1.qza
Saved SampleData[AlphaDiversity] to: alpha_ASV_table/otus.qza
Saved SampleData[AlphaDiversity] to: alpha_ASV_table/pielou_e.qza
Exported chao1.qza as AlphaDiversityDirectoryFormat to directory chao1_dir
Exported otus.qza as AlphaDiversityDirectoryFormat to directory otus_dir
Exported pielou_e.qza as AlphaDiversityDirectoryFormat to directory pielou_e_dir
Exported shannon.qza as AlphaDiversityDirectoryFormat to directory shannon_dir
```
### Rarefaction curve
```shell
(qiime2-2019.10) qiime2@qiime2core2019-10:/media/sf_ZhouYi/Shared_Folder/Julianne_SLCCre/Biotin Deficiency 2022 Final/Zymo_BD_CTRL_Supp$ bash ../../scripts/rarefaction-curve.sh ASV_table.qza 6018
call bash rarefaction-curve.sh table.qza rarefaction-depth-integer
Saved Visualization to: ASV_table.qzv
```
### Filter ASV table by Sample Type 
```shell
(qiime2-2019.10) qiime2@qiime2core2019-10:/media/sf_ZhouYi/Shared_Folder/Julianne_SLCCre/Biotin Deficiency 2022 Final/Zymo_BD_CTRL_Supp$ nano README.md 
(qiime2-2019.10) qiime2@qiime2core2019-10:/media/sf_ZhouYi/Shared_Folder/Julianne_SLCCre/Biotin Deficiency 2022 Final/Zymo_BD_CTRL_Supp$ bash ../../scripts/filter-ASV-by-metadata.sh ASV_table.qza Metadata.tsv SampleType Stool
Enter filepath to the .qza table ASV_table.qza
Enter filepath to the metadata file in tsv format Metadata.tsv
Enter the column name by which to subset the data SampleType
Enter the value in the column by which to subset the data Stool
Saved FeatureTable[Frequency] to: Stool_ASV_table.qza
(qiime2-2019.10) qiime2@qiime2core2019-10:/media/sf_ZhouYi/Shared_Folder/Julianne_SLCCre/Biotin Deficiency 2022 Final/Zymo_BD_CTRL_Supp$ bash ../../scripts/filter-ASV-by-metadata.sh ASV_table.qza Metadata.tsv SampleType Colon
Enter filepath to the .qza table ASV_table.qza
Enter filepath to the metadata file in tsv format Metadata.tsv
Enter the column name by which to subset the data SampleType
Enter the value in the column by which to subset the data Colon
Saved FeatureTable[Frequency] to: Colon_ASV_table.qza
```

### Filter ASV tables
```shell
(qiime2-2019.10) qiime2@qiime2core2019-10:/media/sf_ZhouYi/Shared_Folder/Julianne_SLCCre/Biotin Deficiency 2022 Final/Zymo_BD_CTRL_Supp$ bash ../../scripts/2-all-filtering.sh Stool_ASV_table.qza 1000 12
Enter input filepath for qza table Stool_ASV_table.qza
Enter the minimum number of reads a sample must have in order to be retained 1000
Enter minimum number of samples a taxon must be observed in to be retained 12
Enter the output name for your new qza file with low sequencing depth samples discarded
Saved FeatureTable[Frequency] to: min_1000_Stool_ASV_table.qza
Enter the output name for qza file with low depth samples discarded and prevalence filtered taxa
Saved FeatureTable[Frequency] to: s12_min1000_Stool_ASV_table.qza
(qiime2-2019.10) qiime2@qiime2core2019-10:/media/sf_ZhouYi/Shared_Folder/Julianne_SLCCre/Biotin Deficiency 2022 Final/Zymo_BD_CTRL_Supp$ bash ../../scripts/2-all-filtering.sh Colon_ASV_table.qza 1000 3
Enter input filepath for qza table Colon_ASV_table.qza
Enter the minimum number of reads a sample must have in order to be retained 1000
Enter minimum number of samples a taxon must be observed in to be retained 3
Enter the output name for your new qza file with low sequencing depth samples discarded
Saved FeatureTable[Frequency] to: min_1000_Colon_ASV_table.qza
Enter the output name for qza file with low depth samples discarded and prevalence filtered taxa
Saved FeatureTable[Frequency] to: s3_min1000_Colon_ASV_table.qza
```
### Run RPCA
```shell
(qiime2-2019.10) qiime2@qiime2core2019-10:/media/sf_ZhouYi/Shared_Folder/Julianne_SLCCre/Biotin Deficiency 2022 Final/Zymo_BD_CTRL_Supp$ bash ../../scripts/rpca.sh s3_min1000_Colon_ASV_table.qza 
Enter filepath of filtered ASV table.qza file s3_min1000_Colon_ASV_table.qza
This will perform Robust Aitchison PCA on a count matrix
Saved PCoAResults % Properties('biplot') to: biplot_rpca_s3_min1000_Colon_ASV_table.qza
Saved DistanceMatrix to: dm_rpca_s3_min1000_Colon_ASV_table.qza
Saved PCoAResults to: pcoa_rpca_s3_min1000_Colon_ASV_table.qza
Exported pcoa_rpca_s3_min1000_Colon_ASV_table.qza as OrdinationDirectoryFormat to directory pcoa_rpca_s3_min1000_Colon_ASV_table.qza.txt
Exported dm_rpca_s3_min1000_Colon_ASV_table.qza as DistanceMatrixDirectoryFormat to directory dm_rpca_s3_min1000_Colon_ASV_table.qza.txt
(qiime2-2019.10) qiime2@qiime2core2019-10:/media/sf_ZhouYi/Shared_Folder/Julianne_SLCCre/Biotin Deficiency 2022 Final/Zymo_BD_CTRL_Supp$ bash ../../scripts/rpca.sh s12_min1000_Stool_ASV_table.qza 
Enter filepath of filtered ASV table.qza file s12_min1000_Stool_ASV_table.qza
This will perform Robust Aitchison PCA on a count matrix
Saved PCoAResults % Properties('biplot') to: biplot_rpca_s12_min1000_Stool_ASV_table.qza
Saved DistanceMatrix to: dm_rpca_s12_min1000_Stool_ASV_table.qza
Saved PCoAResults to: pcoa_rpca_s12_min1000_Stool_ASV_table.qza
Exported pcoa_rpca_s12_min1000_Stool_ASV_table.qza as OrdinationDirectoryFormat to directory pcoa_rpca_s12_min1000_Stool_ASV_table.qza.txt
Exported dm_rpca_s12_min1000_Stool_ASV_table.qza as DistanceMatrixDirectoryFormat to directory dm_rpca_s12_min1000_Stool_ASV_table.qza.txt
```
### Import taxonomy and collapse tables
```shell
(qiime2-2019.10) qiime2@qiime2core2019-10:/media/sf_ZhouYi/Shared_Folder/Julianne_SLCCre/Biotin Deficiency 2022 Final/Zymo_BD_CTRL_Supp$ bash ../../scripts/import-taxonomy.sh taxonomy.tsv 
Imported taxonomy.tsv as TSVTaxonomyDirectoryFormat to taxonomy.qza
(qiime2-2019.10) qiime2@qiime2core2019-10:/media/sf_ZhouYi/Shared_Folder/Julianne_SLCCre/Biotin Deficiency 2022 Final/Zymo_BD_CTRL_Supp$ bash ../../scripts/collapse-taxa.sh s12_min1000_Stool_ASV_table.qza taxonomy.qza
Saved FeatureTable[Frequency] to: L1_s12_min1000_Stool_ASV_table.qza
Saved FeatureTable[Frequency] to: L2_s12_min1000_Stool_ASV_table.qza
Saved FeatureTable[Frequency] to: L3_s12_min1000_Stool_ASV_table.qza
Saved FeatureTable[Frequency] to: L4_s12_min1000_Stool_ASV_table.qza
Saved FeatureTable[Frequency] to: L5_s12_min1000_Stool_ASV_table.qza
Saved FeatureTable[Frequency] to: L6_s12_min1000_Stool_ASV_table.qza
Saved FeatureTable[Frequency] to: L7_s12_min1000_Stool_ASV_table.qza

(qiime2-2019.10) qiime2@qiime2core2019-10:/media/sf_ZhouYi/Shared_Folder/Julianne_SLCCre/Biotin Deficiency 2022 Final/Zymo$ bash ../../scripts/collapse-taxa.sh s3_min1000_Colon_ASV_table.qza taxonomy.qza
Saved FeatureTable[Frequency] to: L1_s3_min1000_Colon_ASV_table.qza
Saved FeatureTable[Frequency] to: L2_s3_min1000_Colon_ASV_table.qza
Saved FeatureTable[Frequency] to: L3_s3_min1000_Colon_ASV_table.qza
Saved FeatureTable[Frequency] to: L4_s3_min1000_Colon_ASV_table.qza
Saved FeatureTable[Frequency] to: L5_s3_min1000_Colon_ASV_table.qza
Saved FeatureTable[Frequency] to: L6_s3_min1000_Colon_ASV_table.qza
Saved FeatureTable[Frequency] to: L7_s3_min1000_Colon_ASV_table.qza

```

### Make Taxa Barplots
```shell
(qiime2-2019.10) qiime2@qiime2core2019-10:/media/sf_ZhouYi/Shared_Folder/Julianne_SLCCre/Biotin Deficiency 2022 Final/Zymo$ bash ../../scripts/groupsamples.sh s3_min1000_Colon_ASV_table.qza Metadata.tsv Diet
Call bash groupsamples.sh asv-table.qza metadata-file metadata-column
Saved FeatureTable[Frequency] to: groupby_Diet_s3_min1000_Colon_ASV_table.qza
(qiime2-2019.10) qiime2@qiime2core2019-10:/media/sf_ZhouYi/Shared_Folder/Julianne_SLCCre/Biotin Deficiency 2022 Final/Zymo$ bash ../../scripts/groupsamples.sh s12_min1000_Stool_ASV_table.qza Metadata.tsv Diet
Call bash groupsamples.sh asv-table.qza metadata-file metadata-column
Saved FeatureTable[Frequency] to: groupby_Diet_s12_min1000_Stool_ASV_table.qza

(qiime2-2019.10) qiime2@qiime2core2019-10:/media/sf_ZhouYi/Shared_Folder/Julianne_SLCCre/Biotin Deficiency 2022 Final/Zymo$ bash ../../scripts/taxabarplot.sh groupby_Diet_s3_min1000_Colon_ASV_table.qza taxonomy.qza Diet_Metadata.tsv 
Call bash taxabarplot.sh table taxonomy metadata
Saved Visualization to: barplot_groupby_Diet_s3_min1000_Colon_ASV_table.qza_dir.qzv
(qiime2-2019.10) qiime2@qiime2core2019-10:/media/sf_ZhouYi/Shared_Folder/Julianne_SLCCre/Biotin Deficiency 2022 Final/Zymo$ bash ../../scripts/taxabarplot.sh groupby_Diet_s12_min1000_Stool_ASV_table.qza taxonomy.qza Diet_Metadata.tsv 
Call bash taxabarplot.sh table taxonomy metadata
Saved Visualization to: barplot_groupby_Diet_s12_min1000_Stool_ASV_table.qza_dir.qzv

```
