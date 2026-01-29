# Evaluating MAGs Quality
We examined the bins we got in day 3 and and we tried to improve their quaility
## Estimating genome completeness
To evaluate complete and redundant values for each of the bin (MAG) is with: `anvi-estimate-genome-completeness`
```
anvi-estimate-genome-completeness -c $WORK/day3/contigs.db -p $WORK/day3/merged_profiles/PROFILE.db -C METABAT2
```
To only check what bin collections you have generated (without calculating genome completeness):
```
anvi-estimate-genome-completeness --list-collections -p $WORK/day3/merged_profiles/PROFILE.db -c $WORK/day3/contigs.db
```
![alt text](Images/day4.png)

## Examining bins manually

Inciate and run interactive process like day3
 ```
 anvi-interactive -p $WORK/day3/merged_profiles/PROFILE.db -c $WORK/day3/contigs.db -C METABAT2
```

### Questions

 Which binning strategy gives you the best quality for the A R C H A E A bins? **METABINS**

How many A R C H A E A bins do you get that are of High quality? **1**
How many B A C T E R I A bins do you get that are of High quality?**4**
![alt text](Images/DAY4(2).png)
