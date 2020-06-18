# Pipeline to Identify Allergens via Hybridization Probe Cluster-targeted Next-generation Sequencing

Program requires a GNU-like environment. It should be possible to run this pipeline on a Linux or Mac OS.
Following external tools are required:

1. bowtie2
2. perl 
3. R 3.6.1

This pipeline also requires target allergen gene sequences, which are listed in a fasta file '*allergens.fa*' in this study. And a target allergen information file '*allergens_annotation.csv*' is needed as well.

For each sample, running
```
perl pipeline.pl sample1_R1.fq.gz sample1_R2.fq.gz > sample1.mappedGene.txt
```
where *sample1_R1.fq.gz* and *sample1_R2.fq.gz* are compressed fastq files of sample1.

The following command is apply to annotate the results.
```
R CMD BATCH --no-save --no-restore '--args f="sample1.mappedGene.txt"' annoMappedGene.R
```



