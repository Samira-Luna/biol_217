# Taxonomic annotations
`anvi-run-scg-taxonomy` associates the single-copy core genes in your contigs-db with taxnomy information.

```
anvi-run-scg-taxonomy -c $WORK/day3/contigs.db -T 20 -P 2
```
makes quick taxonomy estimates for genomes, metagenomes, or bins stored in your contigs-db using single-copy core genes.
```
#anvi-estimate-scg-taxonomy -c $WORK/day3/contigs.db -p $WORK/day3/merged_profiles/PROFILE.db --metagenome-mode --compute-scg-coverages --update-profile-db-with-taxonomy > abundance.txt
````

![alt text](Images/anvi-run.png)

Then run  `run anvi-estimate-scg-taxonomy`
![alt text](Images/TAXONOMY.png)