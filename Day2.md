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

Run Highlighting `fastqc` the file are 0_raw_reads in metagenomic directory, you could work either there or make a new directory

|Files names|
| --- | --- | --- |
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
### be smaller
Header with three or more # will not be automatically underlined

# Line breaks
If you want some text to start in the next line, a ENTER is not enough.

Use two Enters, <br>
or instert \<br> where needed.

# Create a list
1.
2.
3.

# Create bulletpoints
* 
* 
1. also combinable
    * with numbers

# Highlight text options
* Highlighting `the text`
* Making the *text* italic
* Making the **text** bold
* Making the ***text*** italic & bold
* Underlining the <u>text</u> 


# Documenting code
Use \``` to highlight your code in  blocks
```
print("Hello World")
```
# Including links 
Type work you want to be hyperlinked in [] and the link beind in ()

[FastQC](https://github.com/s-andrews/FastQC)


# Create a table  (use pipes \|)
 ### Tools used:
| Tool | Version | Repository |
| --- | --- | --- |
| fastqc | 0.11.9 | [FastQC](https://github.com/s-andrews/FastQC ) |
| fastp | 0.22.0 | [fastp](https://github.com/OpenGene/fastp ) |
| megahit | 1.2.9 | [megahit](https://github.com/voutcn/megahit ) |


# Include pictures
* Create a folder called "images" in your repo
* place the image inside it

![image](./images/your_image.png)