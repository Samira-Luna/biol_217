#!/bin/bash
#SBATCH --job-name=test3
#SBATCH --output=test3.out
#SBATCH --error=test3.err
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=12
#SBATCH --mem=32G
#SBATCH --partition=base
#SBATCH --time=3:00:00
#SBATCH --reservation=biol217

#load necessary modules
module load gcc12-env/12.1.0
module load micromamba
eval "$(micromamba shell hook --shell=bash)"
export MAMBA_ROOT_PREFIX=$WORK/.micromamba

micromamba activate 00_anvio


cd $WORK/day3

#metaquast $WORK/final.contigs.fa -o $WORK/day3/metaquast_out -t 6 -m 1000
#simplyf sequence IDS
#anvi-script-reformat-fasta $WORK/final.contigs.fa -o $WORK/day3/anvi_out.fa --min-len 1000 --simplify-names --report-file simplify_names
#bowtie2-build $WORK/day3/anvi_out.fa $WORK/day3/contings_anvi.fa.index

#bowtie2 -1 $WORK/day2/BGR_130305_mapped_R1_cleaned.fastq.gz -2 $WORK/day2/BGR_130305_mapped_R2_cleaned.fastq.gz -x  $WORK/day3/contings_anvi.fa.index -S BGR_130305.sam --very-fast 
#bowtie2 -1 $WORK/day2/BGR_130527_mapped_R1_cleaned.fastq.gz -2 $WORK/day2/BGR_130527_mapped_R2_cleaned.fastq.gz -x  $WORK/day3/contings_anvi.fa.index -S BGR_130527.sam --very-fast 
#bowtie2 -1 $WORK/day2/BGR_130708_mapped_R1_cleaned.fastq.gz -2 $WORK/day2/BGR_130708_mapped_R2_cleaned.fastq.gz -x $WORK/day3/contings_anvi.fa.index -S BGR_130708.sam --very-fast 

#samtools view -Sb $WORK/day3/BGR_130305.sam > $WORK/day3/BGR_130305_mapped2.bam
#samtools view -Sb $WORK/day3/BGR_130527.sam > $WORK/day3/BGR_130527_mapped2.bam
#samtools view -Sb $WORK/day3/BGR_130708.sam > $WORK/day3/BGR_130708_mapped2.bam

#anvi-init-bam $WORK/day3/BGR_130305_mapped2.bam -o $WORK/day3/BGR_130305_sorted.bam
#anvi-init-bam $WORK/day3/BGR_130527_mapped2.bam -o $WORK/day3/BGR_130527_sorted.bam
#anvi-init-bam $WORK/day3/BGR_130708_mapped2.bam -o $WORK/day3/BGR_130708_sorted.bam

#anvi-gen-contigs-database -f $WORK/day3/anvi_out.fa -o $WORK/day3/contigs.db -n biol217
#anvi-run-hmms -c $WORK/day3/contigs.db --num-threads 4
#anvi-display-contigs-stats $WORK/day3//contigs.db

anvi-profile -i $WORK/day3/BGR_130305_sorted.bam -c $WORK/day3/contigs.db -o $WORK/day3/BGR_130305_profile/
anvi-profile -i $WORK/day3/BGR_130527_sorted.bam -c $WORK/day3/contigs.db -o $WORK/day3/BGR_130527_profile/
anvi-profile -i $WORK/day3/BGR_130708_sorted.bam -c $WORK/day3/contigs.db -o $WORK/day3/BGR_130708_profile/

#micromamba activate .micromamba/envs/00_anvio/

# ##----------------- End -------------
module purge
jobinfo