# Metagenome-assembled Genomes (MAGs)


## Quality control of raw reads
First, we need to evaluate the quality of the sequenced data, make a batch script:

```
#!/bin/bash
#SBATCH --job-name=test2
#SBATCH --output=test2.out
#SBATCH --error=test2.err
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=12
#SBATCH --mem=32G
#SBATCH --partition=base
#SBATCH --time=3:00:00
#SBATCH --reservation=biol217 
```
Activate micromba tools in the terminal or just write direct in the batch script

```
micromamba activate 00_anvio
```

Run `fastqc` the file are 0_raw_reads in metagenomic directory, you could work either there or make a new directory

|Files names|
| --- |
|BGR_130305_mapped_R1.fastq.gz  |
BGR_130305_mapped_R2.fastq.gz
|BGR_130527_mapped_R1.fastq.gz
|BGR_130527_mapped_R2.fastq.gz
BGR_130708_mapped_R1.fastq.gz
BGR_130708_mapped_R2.fastq.gz  | 


```
cd $WORK
mkdir day2
cd day2
mkdir -p fastqc_out
fastqc ../metagenomics/0_raw_reads/*.fastq.gz -o $WORK/day2/fastqc_out/ 
```
To process and filter the reads we us `fastp`

```
fastp -i ../metagenomics/0_raw_reads BGR_130305_mapped_R1.fastq.gz -I ../metagenomics/0_raw_reads/BGR_130305_mapped_R2.fastq.gz -o $WORK/day2/BGR_130305_mapped_R1_cleaned.fastq.gz -O $WORK/day2/BGR_130305_mapped_R2_cleaned.fastq.gz -t 6 -q 20 -h BGR_130305.html -R BGR_130305

fastp -i ../metagenomics/0_raw_reads/BGR_130527_mapped_R1.fastq.gz -I ../metagenomics/0_raw_reads/BGR_130527_mapped_R2.fastq.gz -o $WORK/day2/BGR_130527_mapped_R1_cleaned.fastq.gz -O $WORK/day2/BGR_133527_mapped_R2_cleaned.fastq.gz -t 6 -q 20 -h BGR_130527.html -R BGR_130527

fastp -i ../metagenomics/0_raw_reads/BGR_130708_mapped_R1.fastq.gz -I ../metagenomics/0_raw_reads/BGR_130708_mapped_R2.fastq.gz -o $WORK/day2/BGR_130708_mapped_R1_cleaned.fastq.gz -O $WORK/day2/BGR_130708_mapped_R2_cleaned.fastq.gz -t 6 -q 20 -h BGR_130708.html -R BGR_130708
```

## Assembly
Perform genome assemblies using `megahit`

```
megahit -1 $WORK/day2/BGR_130305_mapped_R1_cleaned.fastq.gz -1 $WORK/day2/BGR_130527_mapped_R1_cleaned.fastq.gz -1 $WORK/day2/BGR_130708_mapped_R1_cleaned.fastq.gz -2 $WORK/day2/BGR_130305_mapped_R2_cleaned.fastq.gz -2 $WORK/day2/BGR_130527_mapped_R2_cleaned.fastq.gz -2 $WORK/day2/BGR_130708_mapped_R2_cleaned.fastq.gz -o $WORK/day2/3_coassembly/ --min-contig-len 1000 --presets meta-large -m 0.85 -t 12
```

To visualize the assembled contigs in Bandage, you need to convert the plain-text sequence file (fasta) into a fasta-like graph (fastg)

```
megahit_toolkit contig2fastg 99 final.contigs.fa > final.contigs.fastg
```
Open Bandage to visualize: 
![alt text](image.png)
