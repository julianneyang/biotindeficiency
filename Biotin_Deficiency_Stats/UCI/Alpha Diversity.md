### Stool (Longitudinal)
##### LMEM Timepoint* Genotype
Shannon
```R
> output <- lme(fixed= shannon ~ Timepoint*Genotype, random = ~1|MouseID, data=stool)
> summary(output)
Linear mixed-effects model fit by REML
 Data: stool 
       AIC      BIC   logLik
  49.28061 52.19005 -18.6403

Random effects:
 Formula: ~1 | MouseID
        (Intercept)  Residual
StdDev:   0.1528384 0.8951204

Fixed effects: shannon ~ Timepoint * Genotype 
                              Value Std.Error DF   t-value p-value
(Intercept)                5.615433 0.4540375  6 12.367775  0.0000
TimepointDay7             -0.300471 0.6329457  6 -0.474718  0.6518
GenotypeKO                 0.460696 0.6421060  6  0.717476  0.5000
TimepointDay7 :GenotypeKO -0.896646 0.8951204  6 -1.001704  0.3552
 Correlation: 
                          (Intr) TmpnD7 GntyKO
TimepointDay7             -0.697              
GenotypeKO                -0.707  0.493       
TimepointDay7 :GenotypeKO  0.493 -0.707 -0.697

Standardized Within-Group Residuals:
        Min          Q1         Med          Q3         Max 
-2.13105533 -0.70011084 -0.01687066  0.67648772  1.13249510 

Number of Observations: 16
Number of Groups: 8
```
OTUS
```R
> output <- lme(fixed= observed_otus ~ Timepoint*Genotype, random = ~1|MouseID, data=stool)
> summary(output)
Linear mixed-effects model fit by REML
 Data: stool 
       AIC      BIC    logLik
  149.4181 152.3275 -68.70904

Random effects:
 Formula: ~1 | MouseID
        (Intercept) Residual
StdDev:    31.65504 51.07327

Fixed effects: observed_otus ~ Timepoint * Genotype 
                           Value Std.Error DF   t-value p-value
(Intercept)               303.75  30.04380  6 10.110237  0.0001
TimepointDay7             -58.50  36.11426  6 -1.619859  0.1564
GenotypeKO                -14.50  42.48836  6 -0.341270  0.7445
TimepointDay7 :GenotypeKO -28.75  51.07327  6 -0.562917  0.5939
 Correlation: 
                          (Intr) TmpnD7 GntyKO
TimepointDay7             -0.601              
GenotypeKO                -0.707  0.425       
TimepointDay7 :GenotypeKO  0.425 -0.707 -0.601

Standardized Within-Group Residuals:
       Min         Q1        Med         Q3        Max 
-1.5699036 -0.4206768 -0.1203218  0.5088738  1.4943200 

Number of Observations: 16
Number of Groups: 8 
```
##### LMEM Timepoint + Genotype
Shannon
```R
> output <- lme(fixed= shannon ~ Timepoint+Genotype, random = ~1|MouseID, data=stool)
> summary(output)
Linear mixed-effects model fit by REML
 Data: stool 
      AIC      BIC    logLik
  49.9003 52.72505 -19.95015

Random effects:
 Formula: ~1 | MouseID
        (Intercept)  Residual
StdDev:   0.1521983 0.8953385

Fixed effects: shannon ~ Timepoint + Genotype 
                   Value Std.Error DF   t-value p-value
(Intercept)     5.839595 0.3950910  7 14.780379  0.0000
TimepointDay7  -0.748794 0.4476693  7 -1.672650  0.1383
GenotypeKO      0.012373 0.4604236  6  0.026873  0.9794
 Correlation: 
               (Intr) TmpnD7
TimepointDay7  -0.567       
GenotypeKO     -0.583  0.000

Standardized Within-Group Residuals:
       Min         Q1        Med         Q3        Max 
-2.3814346 -0.5011999  0.1436771  0.6565929  1.2815526 

Number of Observations: 16
Number of Groups: 8 
```
OTUS
```R
> output <- lme(fixed= observed_otus ~ Timepoint+Genotype, random = ~1|MouseID, data=stool)
> summary(output)
Linear mixed-effects model fit by REML
 Data: stool 
       AIC      BIC    logLik
  157.4037 160.2284 -73.70184

Random effects:
 Formula: ~1 | MouseID
        (Intercept) Residual
StdDev:    33.60538 48.51721

Fixed effects: observed_otus ~ Timepoint + Genotype 
                  Value Std.Error DF   t-value p-value
(Intercept)    310.9375  26.90149  7 11.558374  0.0000
TimepointDay7  -72.8750  24.25860  7 -3.004089  0.0198
GenotypeKO     -28.8750  33.95792  6 -0.850317  0.4278
 Correlation: 
               (Intr) TmpnD7
TimepointDay7  -0.451       
GenotypeKO     -0.631  0.000

Standardized Within-Group Residuals:
       Min         Q1        Med         Q3        Max 
-1.7357755 -0.4186752  0.0571005  0.5027003  1.4074139 

Number of Observations: 16
Number of Groups: 8 
```
##### Wilcoxon rank-sum
Shannon
```R
> wilcox.test(shannon~Genotype,stool_day0)

	Wilcoxon rank sum exact test

data:  shannon by Genotype
W = 4, p-value = 0.3429
alternative hypothesis: true location shift is not equal to 0

> wilcox.test(shannon~Genotype,stool_day7)

	Wilcoxon rank sum exact test

data:  shannon by Genotype
W = 9, p-value = 0.8857
alternative hypothesis: true location shift is not equal to 0

```
OTUs
```R
> wilcox.test(observed_otus~Genotype,stool_day0)

	Wilcoxon rank sum exact test

data:  observed_otus by Genotype
W = 10, p-value = 0.6857
alternative hypothesis: true location shift is not equal to 0

> wilcox.test(observed_otus~Genotype,stool_day7)

	Wilcoxon rank sum exact test

data:  observed_otus by Genotype
W = 10, p-value = 0.6857
alternative hypothesis: true location shift is not equal to 0
```
##### T-test
Shannon
```R
> t.test(shannon~Genotype,stool_day0)

	Welch Two Sample t-test

data:  shannon by Genotype
t = -0.95847, df = 5.5116, p-value = 0.378
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -1.6625577  0.7411662
sample estimates:
mean in group WT mean in group KO 
        5.615433         6.076129 

> t.test(shannon~Genotype,stool_day7)

	Welch Two Sample t-test

data:  shannon by Genotype
t = 0.56585, df = 4.3801, p-value = 0.5992
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -1.631861  2.503761
sample estimates:
mean in group WT mean in group KO 
        5.314962         4.879012 
```
OTUs
```R
> t.test(observed_otus~Genotype,stool_day0)

	Welch Two Sample t-test

data:  observed_otus by Genotype
t = 0.43292, df = 5.1267, p-value = 0.6827
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -70.96094  99.96094
sample estimates:
mean in group WT mean in group KO 
          303.75           289.25 

> t.test(observed_otus~Genotype,stool_day7)

	Welch Two Sample t-test

data:  observed_otus by Genotype
t = 0.86696, df = 4.2723, p-value = 0.432
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -91.84532 178.34532
sample estimates:
mean in group WT mean in group KO 
          245.25           202.00 
```
### Intestines (Cross- Sectional)
##### T-test
```R
> t.test(shannon~Genotype,intestine)

	Welch Two Sample t-test

data:  shannon by Genotype
t = -2.8499, df = 4.1114, p-value = 0.04493
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -3.39925591 -0.06247052
sample estimates:
mean in group KO mean in group WT 
        4.295841         6.026704 

```
```R
> t.test(observed_otus~Genotype,intestine)

	Welch Two Sample t-test

data:  observed_otus by Genotype
t = -3.8698, df = 3.7379, p-value = 0.02043
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -247.62791  -37.37209
sample estimates:
mean in group KO mean in group WT 
          165.25           307.75 
```
##### Wilcoxon rank-sum

```R
> wilcox.test(shannon~Genotype,intestine)

	Wilcoxon rank sum exact test

data:  shannon by Genotype
W = 2, p-value = 0.1143
alternative hypothesis: true location shift is not equal to 0
```

```R
> wilcox.test(observed_otus~Genotype,intestine)

	Wilcoxon rank sum exact test

data:  observed_otus by Genotype
W = 0, p-value = 0.02857
alternative hypothesis: true location shift is not equal to 0

```