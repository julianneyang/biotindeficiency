# Stool
### LMEM - Collection* Diet
Shannon
```R
Fixed effects: shannon ~ Collection * Diet 
                                 Value Std.Error DF   t-value p-value
(Intercept)                   4.398301 0.1693209 25 25.976119  0.0000
CollectionWeek12             -1.041200 0.2394560 25 -4.348189  0.0002
CollectionWeek4              -1.845717 0.2586420 25 -7.136186  0.0000
CollectionWeek8              -1.763714 0.2394560 25 -7.365507  0.0000
DietBD                        0.121046 0.2394560  9  0.505504  0.6254
DietBD_supp                   0.118867 0.2394560  9  0.496403  0.6315
CollectionWeek12:DietBD      -0.873954 0.3524696 25 -2.479517  0.0203
CollectionWeek4:DietBD       -0.676003 0.3524696 25 -1.917904  0.0666
CollectionWeek8:DietBD       -0.638030 0.3386419 25 -1.884084  0.0712
CollectionWeek12:DietBD_supp  0.003367 0.3386419 25  0.009944  0.9921
CollectionWeek4:DietBD_supp  -0.438250 0.3524696 25 -1.243369  0.2253
CollectionWeek8:DietBD_supp   0.200080 0.3386419 25  0.590831  0.5599
```
OTUs
```R
Fixed effects: observed_otus ~ Collection * Diet 
                                 Value Std.Error DF   t-value p-value
(Intercept)                   91.75000  5.551287 25 16.527698  0.0000
CollectionWeek12             -47.50000  7.850706 25 -6.050412  0.0000
CollectionWeek4              -50.41667  8.479731 25 -5.945550  0.0000
CollectionWeek8              -51.25000  7.850706 25 -6.528076  0.0000
DietBD                        14.50000  7.850706  9  1.846968  0.0978
DietBD_supp                   -8.75000  7.850706  9 -1.114549  0.2939
CollectionWeek12:DietBD      -18.41667 11.555926 25 -1.593699  0.1236
CollectionWeek4:DietBD       -25.33333 11.555926 25 -2.192237  0.0379
CollectionWeek8:DietBD       -27.00000 11.102574 25 -2.431868  0.0225
CollectionWeek12:DietBD_supp  17.75000 11.102574 25  1.598728  0.1224
CollectionWeek4:DietBD_supp    2.41667 11.555926 25  0.209128  0.8360
CollectionWeek8:DietBD_supp   22.50000 11.102574 25  2.026557  0.0535
```

### LMEM: Collection + Diet
Shannon
```R
Fixed effects: shannon ~ Collection + Diet 
                     Value Std.Error DF   t-value p-value
(Intercept)       4.586070 0.1315902 31  34.85116  0.0000
CollectionWeek12 -1.308268 0.1539752 31  -8.49661  0.0000
CollectionWeek4  -2.233830 0.1539752 31 -14.50772  0.0000
CollectionWeek8  -1.909698 0.1504332 31 -12.69466  0.0000
DietBD           -0.396084 0.1349611  9  -2.93480  0.0166
DietBD_supp       0.072687 0.1325862  9   0.54823  0.5969
```

Observed OTUs
```R
Fixed effects: observed_otus ~ Collection + Diet 
                     Value Std.Error DF    t-value p-value
(Intercept)       93.76375  4.726292 31  19.838756  0.0000
CollectionWeek12 -47.43888  5.530292 31  -8.578007  0.0000
CollectionWeek4  -58.56693  5.530292 31 -10.590207  0.0000
CollectionWeek8  -52.75000  5.403072 31  -9.762965  0.0000
DietBD            -2.59146  4.847366  9  -0.534613  0.6059
DietBD_supp        2.30020  4.762068  9   0.483025  0.6406
```

### T-test: Control vs BD
Shannon
```R
> t.test(shannon~Diet, stool_Week4)

	Welch Two Sample t-test

data:  shannon by Diet
t = 2.9326, df = 4.4973, p-value = 0.037
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 0.05168021 1.05823380
sample estimates:
mean in group Control      mean in group BD 
             2.552583              1.997626 

> t.test(shannon~Diet, stool_Week8)

	Welch Two Sample t-test

data:  shannon by Diet
t = 3.5848, df = 5.6641, p-value = 0.01277
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 0.1589683 0.8749996
sample estimates:
mean in group Control      mean in group BD 
             2.634586              2.117602 

> t.test(shannon~Diet, stool_Week12)

	Welch Two Sample t-test

data:  shannon by Diet
t = 2.3194, df = 3.3134, p-value = 0.09484
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -0.2270324  1.7328492
sample estimates:
mean in group Control      mean in group BD 
             3.357101              2.604192 
```
Observed OTUs
```R
> t.test(observed_otus~Diet, stool_Week4)

	Welch Two Sample t-test

data:  observed_otus by Diet
t = 1.4947, df = 4.5826, p-value = 0.2004
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -8.319434 29.986101
sample estimates:
mean in group Control      mean in group BD 
             41.33333              30.50000 

> t.test(observed_otus~Diet, stool_Week8)

	Welch Two Sample t-test

data:  observed_otus by Diet
t = 5.6373, df = 4.0461, p-value = 0.004709
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
  6.371202 18.628798
sample estimates:
mean in group Control      mean in group BD 
                 40.5                  28.0 

> t.test(observed_otus~Diet, stool_Week12)

	Welch Two Sample t-test

data:  observed_otus by Diet
t = 0.98931, df = 4.4039, p-value = 0.3737
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -6.68887 14.52220
sample estimates:
mean in group Control      mean in group BD 
             44.25000              40.33333 
```

### T-Test: Control vs BD_supp
Shannon
```R
> t.test(shannon~Diet, stool_Week4)

	Welch Two Sample t-test

data:  shannon by Diet
t = 1.6884, df = 4.4946, p-value = 0.1587
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -0.1837808  0.8225472
sample estimates:
mean in group Control mean in group BD_supp 
             2.552583              2.233200 

> t.test(shannon~Diet, stool_Week8)

	Welch Two Sample t-test

data:  shannon by Diet
t = -1.7844, df = 5.79, p-value = 0.1264
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -0.7601806  0.1222873
sample estimates:
mean in group Control mean in group BD_supp 
             2.634586              2.953533 

> t.test(shannon~Diet, stool_Week12)

	Welch Two Sample t-test

data:  shannon by Diet
t = -0.35525, df = 4.0637, p-value = 0.7401
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -1.0716775  0.8272094
sample estimates:
mean in group Control mean in group BD_supp 
             3.357101              3.479335 
```
OTUs
```R
> t.test(observed_otus~Diet, stool_Week4)

	Welch Two Sample t-test

data:  observed_otus by Diet
t = 0.81801, df = 4.8699, p-value = 0.4515
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -13.73008  26.39675
sample estimates:
mean in group Control mean in group BD_supp 
             41.33333              35.00000 

> t.test(observed_otus~Diet, stool_Week8)

	Welch Two Sample t-test

data:  observed_otus by Diet
t = -6.0614, df = 3.9947, p-value = 0.003756
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -20.051479  -7.448521
sample estimates:
mean in group Control mean in group BD_supp 
                40.50                 54.25 

> t.test(observed_otus~Diet, stool_Week12)

	Welch Two Sample t-test

data:  observed_otus by Diet
t = -1.3373, df = 4.9522, p-value = 0.2393
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -26.350127   8.350127
sample estimates:
mean in group Control mean in group BD_supp 
                44.25                 53.25 
```

# Colon
### T-Test: Control vs BD
```R
> t.test(shannon~Diet,cvsbd)

	Welch Two Sample t-test

data:  shannon by Diet
t = -3.8506, df = 4.9803, p-value = 0.01208
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -2.3181016 -0.4607813
sample estimates:
     mean in group BD mean in group Control 
             2.258795              3.648236 

> t.test(observed_otus~Diet,cvsbd)

	Welch Two Sample t-test

data:  observed_otus by Diet
t = -1.014, df = 3.5052, p-value = 0.3754
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -41.89856  20.39856
sample estimates:
     mean in group BD mean in group Control 
                34.00                 44.75 

```

### Wilcoxon Test: Control vs BD
```R
> wilcox.test(observed_otus~Diet,cvsbd)

	Wilcoxon rank sum test with continuity correction

data:  observed_otus by Diet
W = 3, p-value = 0.3725
alternative hypothesis: true location shift is not equal to 0

Warning message:
In wilcox.test.default(x = c(37, 28, 37), y = c(51, 52, 61, 15)) :
  cannot compute exact p-value with ties
> wilcox.test(shannon~Diet,cvsbd)

	Wilcoxon rank sum exact test

data:  shannon by Diet
W = 0, p-value = 0.05714
alternative hypothesis: true location shift is not equal to 0
```

### T Test: Control vs BD_Supp
```R
> t.test(shannon~Diet,cvsbds)

	Welch Two Sample t-test

data:  shannon by Diet
t = -0.58092, df = 3.8992, p-value = 0.5932
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -1.0420991  0.6845156
sample estimates:
mean in group BD_supp mean in group Control 
             3.469445              3.648236 

> t.test(observed_otus~Diet,cvsbds)

	Welch Two Sample t-test

data:  observed_otus by Diet
t = 1.4217, df = 3.6685, p-value = 0.2343
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -15.62414  46.12414
sample estimates:
mean in group BD_supp mean in group Control 
                60.00                 44.75
```

### Wilcox: Control vs BD_Supp
```R
> wilcox.test(observed_otus~Diet,cvsbds)

	Wilcoxon rank sum test with continuity correction

data:  observed_otus by Diet
W = 13.5, p-value = 0.1465
alternative hypothesis: true location shift is not equal to 0

Warning message:
In wilcox.test.default(x = c(69, 57, 61, 53), y = c(51, 52, 61,  :
  cannot compute exact p-value with ties
> wilcox.test(shannon~Diet,cvsbds)

	Wilcoxon rank sum exact test

data:  shannon by Diet
W = 6, p-value = 0.6857
alternative hypothesis: true location shift is not equal to 0
```