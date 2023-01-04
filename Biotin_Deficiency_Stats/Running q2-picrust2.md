```shell
qiime tools import  
–type ‘FeatureData[Sequence]’  
–input-path /path/silva_132_99_16S.fna  
–output-path /path/silva_132_99_16S.qza
```

Make a phylogenetic tree with SEPP 
```shell
qiime fragment-insertion sepp \
  --i-representative-sequences rep-seqs.qza \
  --i-reference-database sepp-refs-gg-13-8.qza \
  --o-tree insertion-tree.qza \
  --o-placements insertion-placements.qza
  
```
Run PICRUST2 


