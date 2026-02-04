#!/bin/bash
#SBATCH --job-name=test8
#SBATCH --output=test8.out
#SBATCH --error=test8.err
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=32
#SBATCH --mem=64G
#SBATCH --partition=base
#SBATCH --time=4:00:00
#SBATCH --reservation=biol217

#load necessary modules
module load gcc12-env/12.1.0
module load micromamba
eval "$(micromamba shell hook --shell=bash)"
export MAMBA_ROOT_PREFIX=$WORK/.micromamba

#micromamba activate 10_grabseqs
#IN TERMINAL
cd $WORK/day8/reademption
#grabseqs sra -t 4 -m ./metadata.csv SRR4018516	
#grabseqs sra -t 4 -m ./metadata.csv SRR4018515	
#grabseqs sra -t 4 -m ./metadata.csv SRR4018514	
#grabseqs sra -t 4 -m ./metadata.csv SRR4018517	
#RENOME WITH MOVE
#mkdir -p $WORK/day8/reademption 
micromamba activate 08_reademption
#reademption create --project_path $WORK/day8/reademption/READemption_analysis_2 --species methanosarcina="Methanosarcina mazei Gö1"

 #download reference genome
 
#wget -O $WORK/day8/reademption/READemption_analysis_2/input/methanosarcina_reference_sequences/GCF_000007065.1_ASM706v1_genomic.fna.gz  https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/007/065/GCF_000007065.1_ASM706v1/GCF_000007065.1_ASM706v1_genomic.fna.gz 

#wget -O $WORK/day8/reademption/READemption_analysis_2/input/methanosarcina_annotations/GCF_000007065.1_ASM706v1_genomic.gff.gz https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/007/065/GCF_000007065.1_ASM706v1/GCF_000007065.1_ASM706v1_genomic.gff.gz 

#UNZIP FILES
#gunzip $WORK/day8/reademption/READemption_analysis_2/input/methanosarcina_reference_sequences/GCF_000007065.1_ASM706v1_genomic.fna.gz
#gunzip $WORK/day8/reademption/READemption_analysis_2/input/methanosarcina_annotations/GCF_000007065.1_ASM706v1_genomic.gff.gz

# align reads to reference
reademption align -p 4 --poly_a_clipping --project_path READemption_analysis_2 --fastq

# calculate read coverage
reademption coverage -p 4 --project_path READemption_analysis_2

# quantify gene expression
reademption gene_quanti -p 4 --features CDS,tRNA,rRNA --project_path READemption_analysis_2

# calculate differential expression using DESeq2
reademption deseq -l mut_R1.fastq.gz,mut_R2.fastq.gz,wt_R1.fastq.gz,wt_R2.fastq.gz -c mut,mut,wt,wt -r 1,2,1,2 --libs_by_species methanosarcina=mut_R1,mut_R2,wt_R1,wt_R2 --project_path READemption_analysis_2

# visualization
reademption viz_align --project_path READemption_analysis_2
reademption viz_gene_quanti --project_path READemption_analysis_2
reademption viz_deseq --project_path  READemption_analysis_2

# environment cleanup
micromamba deactivate


# environment cleanup

#micromamba activate .micromamba/envs/00_anvio/

# ##----------------- End -------------
module purge
jobinfo