#!/bin/bash
#SBATCH --job-name=test4
#SBATCH --output=test4.out
#SBATCH --error=test4.err
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

micromamba activate 00_gunc

cd $WORK/day4

#anvi-estimate-genome-completeness -c $WORK/day3/contigs.db -p $WORK/day3/merged_profiles/PROFILE.db -C METABAT2
#anvi-estimate-genome-completeness --list-collections -p $WORK/day3/merged_profiles/PROFILE.db -c $WORK/day3/contigs.db

#interactive
anvi-interactive -p $WORK/day3/merged_profiles/PROFILE.db -c $WORK/day3/contigs.db -C METABAT2
#anvi-interactive -p $WORK/day3/merged_profiles/PROFILE.db -c $WORK/day3/contigs.db -C MAXBIN2

#refine
#gunc run -i $WORK/day4/refine/METABAT__15-contigs.fa -r $WORK/databases/gunc/gunc_db_progenomes2.1.dmnd --out_dir $WORK/day4/gunc_out --detailed_output --threads 12

#gunc plot -d $WORK/day4/gunc_out/diamond_output/*.diamond.progenomes_2.1.out  -g $WORK/day4/gunc_out/gene_calls/gene_counts.json --out_dir $WORK/day4/gunc_out/gunc
#cp $WORK/day3/merged_profiles/PROFILE.db $WORK/day4/PROFILE_refined.db
anvi-refine -c $WORK/day3/contigs.db -p $WORK/day4/PROFILE.db --bin-id METABAT__15 -C METABAT2 
#micromamba activate .micromamba/envs/00_anvio/

# ##----------------- End -------------
module purge
jobinfo