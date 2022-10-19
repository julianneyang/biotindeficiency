### Import files
```shell
(qiime2-2019.10) qiime2@qiime2core2019-10:/media/sf_ZhouYi/Shared_Folder/Julianne_SLCCre/Biotin Deficiency 2022 Final/Zymo$ bash ../../scripts/import-taxonomy.sh Taxonomy.tsv 
Imported Taxonomy.tsv as TSVTaxonomyDirectoryFormat to taxonomy.qza

(qiime2-2019.10) qiime2@qiime2core2019-10:/media/sf_ZhouYi/Shared_Folder/Julianne_SLCCre/Biotin Deficiency 2022 Final/Zymo$ bash ../../scripts/1-qiime-tools-import.sh ASV.tsv 
Enter filepath to tsv containing ASV count data ASV.tsv
Imported ASV.biom as BIOMV210Format to ASV.qza
```

### Alpha Diversity
```shell
(qiime2-2019.10) qiime2@qiime2core2019-10:/media/sf_ZhouYi/Shared_Folder/Julianne_SLCCre/Biotin Deficiency 2022 Final/Zymo$ bash ../../scripts/rarefy_alpha_diversity.sh ASV.qza 17173
Call bash rarefy_alpha_diversity.sh table.qza sampling_depth_integer
Saved FeatureTable[Frequency] to: d17173_ASV.qza
Saved SampleData[AlphaDiversity] to: alpha_ASV/shannon.qza
Saved SampleData[AlphaDiversity] to: alpha_ASV/chao1.qza
Saved SampleData[AlphaDiversity] to: alpha_ASV/otus.qza
Saved SampleData[AlphaDiversity] to: alpha_ASV/pielou_e.qza
Exported chao1.qza as AlphaDiversityDirectoryFormat to directory chao1_dir
Exported otus.qza as AlphaDiversityDirectoryFormat to directory otus_dir
Exported pielou_e.qza as AlphaDiversityDirectoryFormat to directory pielou_e_dir
Exported shannon.qza as AlphaDiversityDirectoryFormat to directory shannon_dir
```

### Filter ASV table
```shell
(qiime2-2019.10) qiime2@qiime2core2019-10:/media/sf_ZhouYi/Shared_Folder/Julianne_SLCCre/Biotin Deficiency 2022 Final/Zymo$ nano README.md 
(qiime2-2019.10) qiime2@qiime2core2019-10:/media/sf_ZhouYi/Shared_Folder/Julianne_SLCCre/Biotin Deficiency 2022 Final/Zymo$ bash ../../scripts/filter-ASV-by-metadata.sh ASV.qza Metadata.tsv SampleType Stool
Enter filepath to the .qza table ASV.qza
Enter filepath to the metadata file in tsv format Metadata.tsv
Enter the column name by which to subset the data SampleType
Enter the value in the column by which to subset the data Stool
Saved FeatureTable[Frequency] to: Stool_ASV.qza
(qiime2-2019.10) qiime2@qiime2core2019-10:/media/sf_ZhouYi/Shared_Folder/Julianne_SLCCre/Biotin Deficiency 2022 Final/Zymo$ bash ../../scripts/filter-ASV-by-metadata.sh ASV.qza Metadata.tsv SampleType Colon
Enter filepath to the .qza table ASV.qza
Enter filepath to the metadata file in tsv format Metadata.tsv
Enter the column name by which to subset the data SampleType
Enter the value in the column by which to subset the data Colon
Saved FeatureTable[Frequency] to: Colon_ASV.qza
```

### Prevalence Filtering of subsets
```shell
(qiime2-2019.10) qiime2@qiime2core2019-10:/media/sf_ZhouYi/Shared_Folder/Julianne_SLCCre/Biotin Deficiency 2022 Final/Zymo$ ^C
(qiime2-2019.10) qiime2@qiime2core2019-10:/media/sf_ZhouYi/Shared_Folder/Julianne_SLCCre/Biotin Deficiency 2022 Final/Zymo$ bash ../../scripts/2-all-filtering.sh Colon_ASV.qza 10000 3
Enter input filepath for qza table Colon_ASV.qza
Enter the minimum number of reads a sample must have in order to be retained 10000
Enter minimum number of samples a taxon must be observed in to be retained 3
Enter the output name for your new qza file with low sequencing depth samples discarded
Saved FeatureTable[Frequency] to: min_10000_Colon_ASV.qza
Enter the output name for qza file with low depth samples discarded and prevalence filtered taxa
Saved FeatureTable[Frequency] to: s3_min10000_Colon_ASV.qza
(qiime2-2019.10) qiime2@qiime2core2019-10:/media/sf_ZhouYi/Shared_Folder/Julianne_SLCCre/Biotin Deficiency 2022 Final/Zymo$ bash ../../scripts/2-all-filtering.sh Stool_ASV.qza 10000 12
Enter input filepath for qza table Stool_ASV.qza
Enter the minimum number of reads a sample must have in order to be retained 10000
Enter minimum number of samples a taxon must be observed in to be retained 12
Enter the output name for your new qza file with low sequencing depth samples discarded
Saved FeatureTable[Frequency] to: min_10000_Stool_ASV.qza
Enter the output name for qza file with low depth samples discarded and prevalence filtered taxa
Saved FeatureTable[Frequency] to: s12_min10000_Stool_ASV.qza
```

### Beta Diversity
```shell
(qiime2-2019.10) qiime2@qiime2core2019-10:/media/sf_ZhouYi/Shared_Folder/Julianne_SLCCre/Biotin Deficiency 2022 Final/Zymo/Filtered_ASV$ for file in *; do bash ../../../scripts/rpca.sh $file;done
Enter filepath of filtered ASV table.qza file s12_min10000_Stool_ASV.qza
This will perform Robust Aitchison PCA on a count matrix
Saved PCoAResults % Properties('biplot') to: biplot_rpca_s12_min10000_Stool_ASV.qza
Saved DistanceMatrix to: dm_rpca_s12_min10000_Stool_ASV.qza
Saved PCoAResults to: pcoa_rpca_s12_min10000_Stool_ASV.qza
Exported pcoa_rpca_s12_min10000_Stool_ASV.qza as OrdinationDirectoryFormat to directory pcoa_rpca_s12_min10000_Stool_ASV.qza.txt
Exported dm_rpca_s12_min10000_Stool_ASV.qza as DistanceMatrixDirectoryFormat to directory dm_rpca_s12_min10000_Stool_ASV.qza.txt
Enter filepath of filtered ASV table.qza file s3_min10000_Colon_ASV.qza
This will perform Robust Aitchison PCA on a count matrix
Saved PCoAResults % Properties('biplot') to: biplot_rpca_s3_min10000_Colon_ASV.qza
Saved DistanceMatrix to: dm_rpca_s3_min10000_Colon_ASV.qza
Saved PCoAResults to: pcoa_rpca_s3_min10000_Colon_ASV.qza
Exported pcoa_rpca_s3_min10000_Colon_ASV.qza as OrdinationDirectoryFormat to directory pcoa_rpca_s3_min10000_Colon_ASV.qza.txt
Exported dm_rpca_s3_min10000_Colon_ASV.qza as DistanceMatrixDirectoryFormat to directory dm_rpca_s3_min10000_Colon_ASV.qza.txt
```
### Collapse Taxa on unfiltered dataset
```shell
(qiime2-2019.10) qiime2@qiime2core2019-10:/media/sf_ZhouYi/Shared_Folder/Julianne_SLCCre/Biotin Deficiency 2022 Final/Zymo$ bash ../../scripts/collapse-taxa.sh Colon_ASV.qza taxonomy.qza 
Saved FeatureTable[Frequency] to: L1_Colon_ASV.qza
Saved FeatureTable[Frequency] to: L2_Colon_ASV.qza
Saved FeatureTable[Frequency] to: L3_Colon_ASV.qza
Saved FeatureTable[Frequency] to: L4_Colon_ASV.qza
Saved FeatureTable[Frequency] to: L5_Colon_ASV.qza
Saved FeatureTable[Frequency] to: L6_Colon_ASV.qza
Saved FeatureTable[Frequency] to: L7_Colon_ASV.qza

(qiime2-2019.10) qiime2@qiime2core2019-10:/media/sf_ZhouYi/Shared_Folder/Julianne_SLCCre/Biotin Deficiency 2022 Final/Zymo$ bash ../../scripts/collapse-taxa.sh Stool_ASV.qza taxonomy.qza 
Saved FeatureTable[Frequency] to: L1_Stool_ASV.qza
Saved FeatureTable[Frequency] to: L2_Stool_ASV.qza
Saved FeatureTable[Frequency] to: L3_Stool_ASV.qza
Saved FeatureTable[Frequency] to: L4_Stool_ASV.qza
Saved FeatureTable[Frequency] to: L5_Stool_ASV.qza
Saved FeatureTable[Frequency] to: L6_Stool_ASV.qza
Saved FeatureTable[Frequency] to: L7_Stool_ASV.qza

```

### Make taxa barplots 
```shell
(qiime2-2019.10) qiime2@qiime2core2019-10:/media/sf_ZhouYi/Shared_Folder/Julianne_SLCCre/Biotin Deficiency 2022 Final/Zymo$ bash ../../scripts/groupsamples.sh Colon_ASV.qza Metadata.tsv Diet 
Call bash groupsamples.sh asv-table.qza metadata-file metadata-column
Saved FeatureTable[Frequency] to: groupby_Diet_Colon_ASV.qza
(qiime2-2019.10) qiime2@qiime2core2019-10:/media/sf_ZhouYi/Shared_Folder/Julianne_SLCCre/Biotin Deficiency 2022 Final/Zymo$ bash ../../scripts/groupsamples.sh Stool_ASV.qza Metadata.tsv Diet_Collection
Call bash groupsamples.sh asv-table.qza metadata-file metadata-column
Saved FeatureTable[Frequency] to: groupby_Diet_Collection_Stool_ASV.qza

(qiime2-2019.10) qiime2@qiime2core2019-10:/media/sf_ZhouYi/Shared_Folder/Julianne_SLCCre/Biotin Deficiency 2022 Final/Zymo$ bash ../../scripts/taxabarplot.sh groupby_Diet_Colon_ASV.qza taxonomy.qza Diet_Metadata.tsv 
Call bash taxabarplot.sh table taxonomy metadata
Saved Visualization to: barplot_groupby_Diet_Colon_ASV.qza_dir.qzv

(qiime2-2019.10) qiime2@qiime2core2019-10:/media/sf_ZhouYi/Shared_Folder/Julianne_SLCCre/Biotin Deficiency 2022 Final/Zymo$ bash ../../scripts/taxabarplot.sh groupby_Diet_Collection_Stool_ASV.qza taxonomy.qza Diet_Collection_Metadata.tsv 
Call bash taxabarplot.sh table taxonomy metadata
Saved Visualization to: barplot_groupby_Diet_Collection_Stool_ASV.qza_dir.qzv

```
