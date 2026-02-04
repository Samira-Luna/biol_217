#!/bin/bash
#SBATCH --job-name=test6-4
#SBATCH --output=test6-4.out
#SBATCH --error=test6-4.err
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=12
#SBATCH --mem=64G
#SBATCH --partition=base
#SBATCH --time=3:00:00
#SBATCH --reservation=biol217

#load necessary modules
module load gcc12-env/12.1.0
module load micromamba
eval "$(micromamba shell hook --shell=bash)"
export MAMBA_ROOT_PREFIX=$WORK/.micromamba


#SHORT READS
#micromamba activate 01_short_reads_qc
#cd $WORK/day6

#mkdir -p $WORK/day6/short_reads_out
#for i in ../genomics/0_raw_reads/short_reads/*.gz
#do 
 # fastqc $i -o $WORK/day6/short_reads_out/  -t 8
#done

#mkdir -p $WORK/day6/short_reads_out/fastp

#fastp -i ../genomics/0_raw_reads/short_reads/241155E_R1.fastq.gz -I ../genomics/0_raw_reads/short_reads/241155E_R2.fastq.gz -R 241155E_fastp -h 241155E.html  -o  $WORK/day6/short_reads_out/fastp/241155E_R1_clean.fastq.gz -O $WORK/day6/short_reads_out/fastp/241155E_R2_clean.fastq.gz   -t 6 -q 25


#for i in $WORK/day6/short_reads_out/fastp/*.gz
#do 
 # fastqc $i -o $WORK/day6/short_reads_out/  -t 8
#done


#micromamba activate 02_long_reads_qc
#cd $WORK/day6 
#mkdir -p $WORK/day6/long_reads_out

#NanoPlot --fastq ../genomics/0_raw_reads/long_reads/*.gz -o $WORK/day6/long_reads_out -t 6 --maxlength 40000 --minlength 1000 --plots kde --format png --N50 --dpi 300 --store --raw --tsv_stats --info_in_report
#mkdir -p $WORK/day6/long_reads_out/clean_long_reads
#filtlong --min_length 1000 --keep_percent 90 ../genomics/0_raw_reads/long_reads/*.gz  | gzip > $WORK/day6/long_reads_out/clean_long_reads/241155E_cleaned_filtlong.fastq.gz


#mkdir -p $WORK/day6/long_reads_out/clean_nanoplot
#NanoPlot --fastq $WORK/day6/long_reads_out/clean_long_reads/241155E_cleaned_filtlong.fastq.gz -o $WORK/day6/long_reads_out/clean_nanoplot/241155E_cleaned_nanaplot -t 6 --maxlength 40000 --minlength 1000 --plots kde --format png --N50 --dpi 300 --store --raw --tsv_stats --info_in_report


#UNYCLEAR 

#micromamba activate 03_unicycler
#cd $WORK/day6 
#mkdir -p $WORK/day6/hybrid_assembly

#unicycler -1 $WORK/day6/short_reads_out/fastp/241155E_R1_clean.fastq.gz -2 $WORK/day6/short_reads_out/fastp/241155E_R2_clean.fastq.gz -l $WORK/day6/long_reads_out/clean_long_reads/241155E_cleaned_filtlong.fastq.gz -o $WORK/day6/hybrid_assembly -t 8
#micromamba deactivate
#echo "---------Unicycler Assembly pipeline Completed Successfully---------"

#ASSEMBLY QUALITY

#micromamba activate 04_quast
#cd $WORK/day6 
#mkdir  $WORK/day6/hybrid_assembly/assembly_quality/quast
#quast.py $WORK/day6/hybrid_assembly/assembly.fasta --circos -L --conserved-genes-finding --rna-finding\
 #    --glimmer --use-all-alignments --report-all-metrics -o $WORK/day6/hybrid_assembly/assembly_quality/quast -t 8
# micromamba deactivate

 #micromamba activate 04_checkm
#cd $WORK/day6 
#mkdir -p $WORK/day6/hybrid_assembly/assembly_quality/checkM
#checkm lineage_wf $WORK/day6/hybrid_assembly/ $WORK/day6/hybrid_assembly/assembly_quality/checkM -x fasta --tab_table --file $WORK/day6/hybrid_assembly/assembly_quality/checkM/checkm_results -r -t 8
#checkm tree_qa $WORK/day6/hybrid_assembly/assembly_quality/checkM/checkm_results
#checkm qa $WORK/day6/hybrid_assembly/assembly_quality/checkM/lineage.ms $WORK/day6/hybrid_assembly/assembly_quality/checkM/ -o 1 > $WORK/day6/hybrid_assembly/assembly_quality/checkM/final_table_01.csv
#checkm qa $WORK/day6/hybrid_assembly/assembly_quality/checkM/lineage.ms $WORK/day6/hybrid_assembly/assembly_quality/checkM/ -o 2 > .$WORK/day6/hybrid_assembly/assembly_quality/checkM/final_table_checkm.csv
#micromamba deactivate
 


  #micromamba activate 04_checkm2
  #cd $WORK/day6
  #mkdir -p $WORK/day6/hybrid_assembly/assembly_quality/checkM2
 #checkm2 predict --threads 1 --input $WORK/day6/hybrid_assembly/*.fasta --output-directory $WORK/day6/hybrid_assembly/assembly_quality/checkM2
#micromamba deactivate

#ANOTE GENOMES
 #micromamba activate 05_prokka
 # cd $WORK/day6
#prokka  $WORK/day6/hybrid_assembly/assembly.fasta --outdir $WORK/day6/4_annotated_genome  --kingdom Bacteria --addgenes --cpus 32

#CLASIFY GENOMES
 #micromamba activate 06_gtdbtk
 #cd $WORK/day6
#mkdir -p $WORK/day6/classify_genome/5_gtdb_classification
 #gtdbtk classify_wf --cpus 1 --genome_dir $WORK/day6/4_annotated_genome --out_dir $WORK/day6/classify_genome/5_gtdb_classification --extension .fna --skip_ani_screen
  #micromamba deactivate

#MULTYQC
micromamba activate 01_short_reads_qc
 cd $WORK/day6
multiqc -d $WORK/day6/ -o $WORK/day6/6_multiqc
# ##----------------- End -------------
module purge
jobinfo