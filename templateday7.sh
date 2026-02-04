#!/bin/bash
#SBATCH --job-name=test7-2-3
#SBATCH --output=test7-2-3.out
#SBATCH --error=test7-2-3.err
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
cd $WORK/day7


#mkdir -p $WORK/day7/pangenomics/V_jascida_genomes
cd $WORK/day7/pangenomics/V_jascida_genomes/

#ls *.fasta | awk 'BEGIN{FS="_"}{print $1}' > genomes.txt

#for g in `cat genomes.txt`
#do
#    echo
#    echo "Working on $g ..."
#    echo
#    anvi-script-reformat-fasta ${g}_scaffolds.fasta \
#                               --min-len 2500 \
#                               --simplify-names \
#                               -o ${g}_scaffolds_2.5K.fasta
#done

#for g in `cat genomes.txt`
#do
    
    #anvi-gen-contigs-database -f ${g}_scaffolds_2.5K.fasta \
   #                           -o V_jascida_${g}.db \
  #                            --num-threads 4 \
 #                             -n V_jascida_${g}
#done

#for g in *.db
#do
    #anvi-run-hmms -c $g --num-threads 4
   # anvi-run-ncbi-cogs -c $g --num-threads 4
  #  anvi-scan-trnas -c $g --num-threads 4
 #   anvi-run-scg-taxonomy -c $g --num-threads 4
#done

#INTERACTIVE PASTE IN TERMINAL
#anvi-display-contigs-stats $WORK/day7/pangenomics/V_jascida_genomes/*db


#anvi-script-gen-genomes-file --input-dir  $WORK/day7/pangenomics/V_jascida_genomes/ \
#                             -o external-genomes.txt

#IDETIFY CONTAMINATE BINS
#anvi-profile -c $WORK/day7/pangenomics/V_jascida_genomes/V_jascida_52.db \
#             --sample-name V_jascida_52 \
#             --output-dir V_jascida_52 \
#             --blank

 #          anvi-interactive -c  $WORK/day7/pangenomics/V_jascida_genomes/V_jascida_52.db -p $WORK/day7/pangenomics/V_jascida_genomes/V_jascida_52/PROFILE.db


#anvi-split -p $WORK/day7/pangenomics/V_jascida_genomes/V_jascida_52/PROFILE.db \
 #          -c $WORK/day7/pangenomics/V_jascida_genomes/V_jascida_52.db \
    #       -C default \
     #      -o V_jascida_52_SPLIT

      #  sed 's/V_jascida_52.db/V_jascida_52_SPLIT\/V_jascida_52_CLEAN\/CONTIGS.db/g' external-genomes.txt > external-genomes-final.txt

#anvi-estimate-genome-completeness -e $WORK/day7/pangenomics/V_jascida_genomes/external-genomes-final.txt -o $WORK/day7/pangenomics/V_jascida_genomes/genome_completeness_final.txt

#PANGENOME
anvi-gen-genomes-storage -e $WORK/day7/pangenomics/V_jascida_genomes/external-genomes-final.txt \
                         -o $WORK/day7/pangenomics/V_jascida_genomes/V_jascida-GENOMES.db

anvi-pan-genome -g $WORK/day7/pangenomics/V_jascida_genomes/V_jascida-GENOMES.db \
                --project-name V_jascida \
                --num-threads 8 
anvi-compute-genome-similarity -e $WORK/day7/pangenomics/V_jascida_genomes/external-genomes-final.txt \
                 -o $WORK/day7/pangenomics/ani \
                 -p V_jascida/V_jascida-PAN.db  \
                 -T 8    

                 anvi-display-pan -p $WORK/day7/pangenomics/V_jascida_genomes/V_jascida/V_jascida-PAN.db \
                 -g $WORK/day7/pangenomics/V_jascida_genomes/V_jascida-GENOMES.db

#micromamba activate .micromamba/envs/00_anvio/

# ##----------------- End -------------
#module purge
#jobinfo