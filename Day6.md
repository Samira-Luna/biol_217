# Genomics

## Quality control of SHORT raw reads
First, we need to evaluate the quality of the sequenced data, make a batch script:

Activate micromba tools in the terminal or just write direct in the batch script

```
#micromamba activate 01_short_reads_qc
```
Run `fastqc` the file are 0_raw_reads in genomic directory, you could work either there or make a new directory

|Short reads | Long reads |  |
| --- | --- | --- |
| 241155E_R1.fastq.gz | 241155E.fastq.gz  
| 241155E_R2.fastq.gz|  
```
cd $WORK/day6
mdir day6
mkdir -p $WORK/day6/short_reads_out
for i in ../genomics/0_raw_reads/short_reads/*.gz
do 
  fastqc $i -o $WORK/day6/short_reads_out/  -t 8
done
````
Run `fastp` 
```
mkdir -p $WORK/day6/short_reads_out/fastp
fastp -i ../genomics/0_raw_reads/short_reads/241155E_R1.fastq.gz -I ../genomics/0_raw_reads/short_reads/241155E_R2.fastq.gz -R 241155E_fastp -h 241155E.html  -o  $WORK/day6/short_reads_out/fastp/241155E_R1_clean.fastq.gz -O $WORK/day6/short_reads_out/fastp/241155E_R2_clean.fastq.gz   -t 6 -q 25
```
Check the quality of the cleaned reads with fastqc again

```
for i in $WORK/day6/short_reads_out/fastp/*.gz
do 
  fastqc $i -o $WORK/day6/short_reads_out/  -t 8
done
```
#### Questions
How Good is the read quality? **NICE**
![alt text](Images/day6-1.png)
![alt text](Images/day6-5.png)
How many reads before trimming and how many do you have now?
![alt text](Images/day6-2.png)
Did the quality of the reads improve after trimming?
![alt text](Images/day6-3.png)
![alt text](Images/day6-4.png)

## Long reads

We will used `nanoplot`

```
micromamba activate 02_long_reads_qc
cd $WORK/day6 
mkdir -p $WORK/day6/long_reads_out

NanoPlot --fastq ../genomics/0_raw_reads/long_reads/*.gz -o $WORK/day6/long_reads_out -t 6 --maxlength 40000 --minlength 1000 --plots kde --format png --N50 --dpi 300 --store --raw --tsv_stats --info_in_report
```

For filtering long reads by quality. we used `filtlong`
```
mkdir -p $WORK/day6/long_reads_out/clean_long_reads
filtlong --min_length 1000 --keep_percent 90 ../genomics/0_raw_reads/long_reads/*.gz  | gzip > $WORK/day6/long_reads_out/clean_long_reads/241155E_cleaned_filtlong.fastq.gz
```
Check the quality of the cleaned reads with nanoplot again
```
mkdir -p $WORK/day6/long_reads_out/clean_nanoplot
NanoPlot --fastq $WORK/day6/long_reads_out/clean_long_reads/241155E_cleaned_filtlong.fastq.gz -o $WORK/day6/long_reads_out/clean_nanoplot/241155E_cleaned_nanaplot -t 6 --maxlength 40000 --minlength 1000 --plots kde --format png --N50 --dpi 300 --store --raw --tsv_stats --info_in_report
```
#### Questions
How Good is the long reads quality?
    ![alt text](Images/day6-6.png)
    How many reads before trimming and how many do you have now?
![alt text](Images/day6-7.png)

## Assemble the genome using Uniycler
Unicycler is an assembly pipeline for bacterial genomes. 

```
micromamba activate 03_unicycler
#cd $WORK/day6 
#mkdir -p $WORK/day6/hybrid_assembly

unicycler -1 $WORK/day6/short_reads_out/fastp/241155E_R1_clean.fastq.gz -2 $WORK/day6/short_reads_out/fastp/241155E_R2_clean.fastq.gz -l $WORK/day6/long_reads_out/clean_long_reads/241155E_cleaned_filtlong.fastq.gz -o $WORK/day6/hybrid_assembly -t 8
micromamba deactivate
````
It will take some time around 1 hour, after finish check the assembly quality, three different tools will be used.

### Quast
```
micromamba activate 04_quast
cd $WORK/day6 
mkdir  $WORK/day6/hybrid_assembly/assembly_quality/quast
quast.py $WORK/day6/hybrid_assembly/assembly.fasta --circos -L --conserved-genes-finding --rna-finding\
     --glimmer --use-all-alignments --report-all-metrics -o $WORK/day6/hybrid_assembly/assembly_quality/quast -t 8
micromamba deactivate
```
### CheckM
```
#micromamba activate 04_checkm
#cd $WORK/day6 
#mkdir -p $WORK/day6/hybrid_assembly/assembly_quality/checkM
#checkm lineage_wf $WORK/day6/hybrid_assembly/ $WORK/day6/hybrid_assembly/assembly_quality/checkM -x fasta --tab_table --file $WORK/day6/hybrid_assembly/assembly_quality/checkM/checkm_results -r -t 8
#checkm tree_qa $WORK/day6/hybrid_assembly/assembly_quality/checkM/checkm_results
#checkm qa $WORK/day6/hybrid_assembly/assembly_quality/checkM/lineage.ms $WORK/day6/hybrid_assembly/assembly_quality/checkM/ -o 1 > $WORK/day6/hybrid_assembly/assembly_quality/checkM/final_table_01.csv
#checkm qa $WORK/day6/hybrid_assembly/assembly_quality/checkM/lineage.ms $WORK/day6/hybrid_assembly/assembly_quality/checkM/ -o 2 > .$WORK/day6/hybrid_assembly/assembly_quality/checkM/final_table_checkm.csv
#micromamba deactivate
```
###CheckM2
```
#micromamba activate 04_checkm2
  #cd $WORK/day6
  #mkdir -p $WORK/day6/hybrid_assembly/assembly_quality/checkM2
 #checkm2 predict --threads 1 --input $WORK/day6/hybrid_assembly/*.fasta --output-directory $WORK/day6/hybrid_assembly/assembly_quality/checkM2
#micromamba deactivate
```
### Bandage
Visualize the assembly using Bandage
 ![alt text](Images/day6-8.png)
 ## Annote the genomes
 We used `Prokka:` rapid prokaryotic genome annotation
 ```
  micromamba activate 05_prokka
  cd $WORK/day6
prokka  $WORK/day6/hybrid_assembly/assembly.fasta --outdir $WORK/day6/4_annotated_genome  --kingdom Bacteria --addgenes --cpus 32
```

## Classify the genome
We used `GTDB-Tk` is a software toolkit for assigning objective taxonomic classifications to bacterial and archaeal genomes based on the Genome Database Taxonomy GTDB
```
 micromamba activate 06_gtdbtk
 cd $WORK/day6
mkdir -p $WORK/day6/classify_genome/5_gtdb_classification
 gtdbtk classify_wf --cpus 1 --genome_dir $WORK/day6/4_annotated_genome --out_dir $WORK/day6/classify_genome/5_gtdb_classification --extension .fna --skip_ani_screen
  micromamba deactivate
```
## MultiQC to combine reports
