### Read in ASV table
```shell
(qiime2-2019.10) qiime2@qiime2core2019-10:/media/sf_ZhouYi/Shared_Folder/Julianne_SLCCre/Biotin Deficiency 2022 Final/UCLA$ bash ../../scripts/1-qiime-tools-import.sh Skupsky_Sept2021_ASV_count_table.tsv 
Enter filepath to tsv containing ASV count data Skupsky_Sept2021_ASV_count_table.tsv
Imported Skupsky_Sept2021_ASV_count_table.biom as BIOMV210Format to Skupsky_Sept2021_ASV_count_table.qza
(qiime2-2019.10) qiime2@qiime2core2019-10:/media/sf_ZhouYi/Shared_Folder/Julianne_SLCCre/Biotin Deficiency 2022 Final/UCLA$ mv Skupsky_Sept2021_ASV_count_table.qza ASV.qza
```
### Filter ASV table by Sample Type 
```shell
(qiime2-2019.10) qiime2@qiime2core2019-10:/media/sf_ZhouYi/Shared_Folder/Julianne_SLCCre/Biotin Deficiency 2022 Final/UCLA$ bash ../../scripts/filter-ASV-by-metadata.sh ASV.qza Metadata.tsv SampleType Stool_Pellet
Enter filepath to the .qza table ASV.qza
Enter filepath to the metadata file in tsv format Metadata.tsv
Enter the column name by which to subset the data SampleType
Enter the value in the column by which to subset the data Stool_Pellet
Saved FeatureTable[Frequency] to: Stool_Pellet_ASV.qza
(qiime2-2019.10) qiime2@qiime2core2019-10:/media/sf_ZhouYi/Shared_Folder/Julianne_SLCCre/Biotin Deficiency 2022 Final/UCLA$ bash ../../scripts/filter-ASV-by-metadata.sh ASV.qza Metadata.tsv SampleType SI_adherent
Enter filepath to the .qza table ASV.qza
Enter filepath to the metadata file in tsv format Metadata.tsv
Enter the column name by which to subset the data SampleType
Enter the value in the column by which to subset the data SI_adherent
Saved FeatureTable[Frequency] to: SI_adherent_ASV.qza
(qiime2-2019.10) qiime2@qiime2core2019-10:/media/sf_ZhouYi/Shared_Folder/Julianne_SLCCre/Biotin Deficiency 2022 Final/UCLA$ bash ../../scripts/filter-ASV-by-metadata.sh ASV.qza Metadata.tsv SampleType SI_luminal
Enter filepath to the .qza table ASV.qza
Enter filepath to the metadata file in tsv format Metadata.tsv
Enter the column name by which to subset the data SampleType
Enter the value in the column by which to subset the data SI_luminal
Saved FeatureTable[Frequency] to: SI_luminal_ASV.qza
(qiime2-2019.10) qiime2@qiime2core2019-10:/media/sf_ZhouYi/Shared_Folder/Julianne_SLCCre/Biotin Deficiency 2022 Final/UCLA$ bash ../../scripts/filter-ASV-by-metadata.sh ASV.qza Metadata.tsv SampleType adherent_cecum
Enter filepath to the .qza table ASV.qza
Enter filepath to the metadata file in tsv format Metadata.tsv
Enter the column name by which to subset the data SampleType
Enter the value in the column by which to subset the data adherent_cecum
Saved FeatureTable[Frequency] to: adherent_cecum_ASV.qza
```

### Calculate alpha diversity for each subset
```shell
(qiime2-2019.10) qiime2@qiime2core2019-10:/media/sf_ZhouYi/Shared_Folder/Julianne_SLCCre/Biotin Deficiency 2022 Final/UCLA/SampleType_Subsets$ bash ../../../scripts/rarefy_alpha_diversity.sh Stool_Pellet_ASV.qza 15735
Call bash rarefy_alpha_diversity.sh table.qza sampling_depth_integer
Saved FeatureTable[Frequency] to: d15735_Stool_Pellet_ASV.qza
Saved SampleData[AlphaDiversity] to: alpha_Stool_Pellet_ASV/shannon.qza
Saved SampleData[AlphaDiversity] to: alpha_Stool_Pellet_ASV/chao1.qza
Saved SampleData[AlphaDiversity] to: alpha_Stool_Pellet_ASV/otus.qza
Saved SampleData[AlphaDiversity] to: alpha_Stool_Pellet_ASV/pielou_e.qza
Exported chao1.qza as AlphaDiversityDirectoryFormat to directory chao1_dir
Exported otus.qza as AlphaDiversityDirectoryFormat to directory otus_dir
Exported pielou_e.qza as AlphaDiversityDirectoryFormat to directory pielou_e_dir
Exported shannon.qza as AlphaDiversityDirectoryFormat to directory shannon_dir
```
### Filter to features observed in at least 3 mice 
```shell
(qiime2-2019.10) qiime2@qiime2core2019-10:/media/sf_ZhouYi/Shared_Folder/Julianne_SLCCre/Biotin Deficiency 2022 Final/UCLA/SampleType_Subsets$ for file in *; do bash ../../../scripts/2-all-filtering.sh $file 10000 3; done
Enter input filepath for qza table SI_adherent_ASV.qza
Enter the minimum number of reads a sample must have in order to be retained 10000
Enter minimum number of samples a taxon must be observed in to be retained 3
Enter the output name for your new qza file with low sequencing depth samples discarded
Saved FeatureTable[Frequency] to: min_10000_SI_adherent_ASV.qza
Enter the output name for qza file with low depth samples discarded and prevalence filtered taxa
Saved FeatureTable[Frequency] to: s3_min10000_SI_adherent_ASV.qza
Enter input filepath for qza table SI_luminal_ASV.qza
Enter the minimum number of reads a sample must have in order to be retained 10000
Enter minimum number of samples a taxon must be observed in to be retained 3
Enter the output name for your new qza file with low sequencing depth samples discarded
Saved FeatureTable[Frequency] to: min_10000_SI_luminal_ASV.qza
Enter the output name for qza file with low depth samples discarded and prevalence filtered taxa
Saved FeatureTable[Frequency] to: s3_min10000_SI_luminal_ASV.qza
Enter input filepath for qza table Stool_Pellet_ASV.qza
Enter the minimum number of reads a sample must have in order to be retained 10000
Enter minimum number of samples a taxon must be observed in to be retained 3
Enter the output name for your new qza file with low sequencing depth samples discarded
Saved FeatureTable[Frequency] to: min_10000_Stool_Pellet_ASV.qza
Enter the output name for qza file with low depth samples discarded and prevalence filtered taxa
Saved FeatureTable[Frequency] to: s3_min10000_Stool_Pellet_ASV.qza
Enter input filepath for qza table adherent_cecum_ASV.qza
Enter the minimum number of reads a sample must have in order to be retained 10000
Enter minimum number of samples a taxon must be observed in to be retained 3
Enter the output name for your new qza file with low sequencing depth samples discarded
Saved FeatureTable[Frequency] to: min_10000_adherent_cecum_ASV.qza
Enter the output name for qza file with low depth samples discarded and prevalence filtered taxa
Saved FeatureTable[Frequency] to: s3_min10000_adherent_cecum_ASV.qza

(qiime2-2019.10) qiime2@qiime2core2019-10:/media/sf_ZhouYi/Shared_Folder/Julianne_SLCCre/Biotin Deficiency 2022 Final/UCLA/SampleType_Subsets$ bash ../../../scripts/rarefy_alpha_diversity.sh adherent_cecum_ASV.qza 17393
Call bash rarefy_alpha_diversity.sh table.qza sampling_depth_integer
Saved FeatureTable[Frequency] to: d17393_adherent_cecum_ASV.qza
Saved SampleData[AlphaDiversity] to: alpha_adherent_cecum_ASV/shannon.qza
Saved SampleData[AlphaDiversity] to: alpha_adherent_cecum_ASV/chao1.qza
Saved SampleData[AlphaDiversity] to: alpha_adherent_cecum_ASV/otus.qza
Saved SampleData[AlphaDiversity] to: alpha_adherent_cecum_ASV/pielou_e.qza
Exported chao1.qza as AlphaDiversityDirectoryFormat to directory chao1_dir
Exported otus.qza as AlphaDiversityDirectoryFormat to directory otus_dir
Exported pielou_e.qza as AlphaDiversityDirectoryFormat to directory pielou_e_dir
Exported shannon.qza as AlphaDiversityDirectoryFormat to directory shannon_dir
(qiime2-2019.10) qiime2@qiime2core2019-10:/media/sf_ZhouYi/Shared_Folder/Julianne_SLCCre/Biotin Deficiency 2022 Final/UCLA/SampleType_Subsets$ bash ../../../scripts/rarefy_alpha_diversity.sh SI_adherent_ASV.qza 19788
Call bash rarefy_alpha_diversity.sh table.qza sampling_depth_integer
Saved FeatureTable[Frequency] to: d19788_SI_adherent_ASV.qza
Saved SampleData[AlphaDiversity] to: alpha_SI_adherent_ASV/shannon.qza
Saved SampleData[AlphaDiversity] to: alpha_SI_adherent_ASV/chao1.qza
Saved SampleData[AlphaDiversity] to: alpha_SI_adherent_ASV/otus.qza
Saved SampleData[AlphaDiversity] to: alpha_SI_adherent_ASV/pielou_e.qza
Exported chao1.qza as AlphaDiversityDirectoryFormat to directory chao1_dir
Exported otus.qza as AlphaDiversityDirectoryFormat to directory otus_dir
Exported pielou_e.qza as AlphaDiversityDirectoryFormat to directory pielou_e_dir
Exported shannon.qza as AlphaDiversityDirectoryFormat to directory shannon_dir
(qiime2-2019.10) qiime2@qiime2core2019-10:/media/sf_ZhouYi/Shared_Folder/Julianne_SLCCre/Biotin Deficiency 2022 Final/UCLA/SampleType_Subsets$ bash ../../../scripts/rarefy_alpha_diversity.sh SI_luminal_ASV.qza 19286
Call bash rarefy_alpha_diversity.sh table.qza sampling_depth_integer
Saved FeatureTable[Frequency] to: d19286_SI_luminal_ASV.qza
Saved SampleData[AlphaDiversity] to: alpha_SI_luminal_ASV/shannon.qza
Saved SampleData[AlphaDiversity] to: alpha_SI_luminal_ASV/chao1.qza
Saved SampleData[AlphaDiversity] to: alpha_SI_luminal_ASV/otus.qza
Saved SampleData[AlphaDiversity] to: alpha_SI_luminal_ASV/pielou_e.qza
Exported chao1.qza as AlphaDiversityDirectoryFormat to directory chao1_dir
Exported otus.qza as AlphaDiversityDirectoryFormat to directory otus_dir
Exported pielou_e.qza as AlphaDiversityDirectoryFormat to directory pielou_e_dir
Exported shannon.qza as AlphaDiversityDirectoryFormat to directory shannon_dir

```

### Run RPCA on Filtered ASV
```shell
(qiime2-2019.10) qiime2@qiime2core2019-10:/media/sf_ZhouYi/Shared_Folder/Julianne_SLCCre/Biotin Deficiency 2022 Final/UCLA/Filtered_ASV$ for file in *; do bash ../../../scripts/rpca.sh $file;done

```

### Collapse filtered ASV into genera
```shell
(qiime2-2019.10) qiime2@qiime2core2019-10:/media/sf_ZhouYi/Shared_Folder/Julianne_SLCCre/Biotin Deficiency 2022 Final/UCLA/Filtered_ASV$ for file in *; do bash ../../../scripts/collapse-taxa.sh $file ../taxonomy.qza;done
```

### Make taxa barplots
```shell
(qiime2-2019.10) qiime2@qiime2core2019-10:/media/sf_ZhouYi/Shared_Folder/Julianne_SLCCre/Biotin Deficiency 2022 Final/UCLA/Filtered_ASV$ for file in *; do bash ../../../scripts/groupsamples.sh $file ../Metadata.tsv Group;done
Call bash groupsamples.sh asv-table.qza metadata-file metadata-column
Saved FeatureTable[Frequency] to: groupby_Group_s3_min10000_SI_adherent_ASV.qza
Call bash groupsamples.sh asv-table.qza metadata-file metadata-column
Saved FeatureTable[Frequency] to: groupby_Group_s3_min10000_SI_luminal_ASV.qza
Call bash groupsamples.sh asv-table.qza metadata-file metadata-column
Saved FeatureTable[Frequency] to: groupby_Group_s3_min10000_Stool_Pellet_ASV.qza
Call bash groupsamples.sh asv-table.qza metadata-file metadata-column
Saved FeatureTable[Frequency] to: groupby_Group_s3_min10000_adherent_cecum_ASV.qza

(qiime2-2019.10) qiime2@qiime2core2019-10:/media/sf_ZhouYi/Shared_Folder/Julianne_SLCCre/Biotin Deficiency 2022 Final/UCLA/Filtered_ASV/taxa_barplots$ for file in *; do bash ../../../../scripts/taxabarplot.sh $file ../../taxonomy.qza diet_metadata.tsv; done

```
