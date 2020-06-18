# Pipeline to identify Allergens via Hybridization Probe Cluster-targeted Next-generation Sequencing

Program requires a GNU-like environment. It should be possible to run this pipeline on a Linux or Mac OS.
Following external tools are required:

1. bowtie2
2. perl 
3. R 3.6.1

This pipeline also requires target allergen gene sequences, which are listed in a fasta file '*allergens.fa*' in this study.

For each sample, running
> perl pipeline.pl sample1_R1.fq.gz sample1_R2.fq.gz > sample1.mappedGene.txt
