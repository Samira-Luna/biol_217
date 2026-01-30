#!/bin/bash
#SBATCH --job-name=test5-3-2
#SBATCH --output=test5-3-2.out
#SBATCH --error=test5-3-2.err
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=12
#SBATCH --mem=25G
#SBATCH --partition=base
#SBATCH --time=5:00:00
#SBATCH --reservation=biol217

#load necessary modules
module load gcc12-env/12.1.0
module load micromamba
eval "$(micromamba shell hook --shell=bash)"
export MAMBA_ROOT_PREFIX=$WORK/.micromamba

micromamba activate 00_anvio
cd $WORK/day5

#anvi-run-scg-taxonomy -c $WORK/day3/contigs.db -T 20 -P 2
#anvi-estimate-scg-taxonomy -c $WORK/day3/contigs.db -p $WORK/day3/merged_profiles/PROFILE.db --metagenome-mode --compute-scg-coverages --update-profile-db-with-taxonomy
#anvi-estimate-scg-taxonomy -c $WORK/day3/contigs.db -p $WORK/day3/merged_profiles/PROFILE.db --metagenome-mode --compute-scg-coverages --update-profile-db-with-taxonomy > abundance.txt
#anvi-summarize -p $WORK/day3/merged_profiles/PROFILE.db -c $WORK/day3/contigs.db -o $WORK/day5/SUMMARY_METABAT2_FINAL -C METABAT2

#nvi-dereplicate-genomes -i ? --program fastANI --similarity-threshold ? -o ? --log-file log_ANI -T 10
anvi-dereplicate-genomes -i $WORK/day5/dereplicationall.tsv --program fastANI --similarity-threshold 0.95 -o $WORK/day5/dereplication_all_ANI --log-file log_ANI -T 10 --force-overwrite
#micromamba activate .micromamba/envs/00_anvio/

# ##----------------- End -------------
module purge
jobinfo