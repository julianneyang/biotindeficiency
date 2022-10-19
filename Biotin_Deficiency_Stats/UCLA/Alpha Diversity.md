# Stool 
### T-test
```R 
	Welch Two Sample t-test

data:  shannon by Group
t = 1.6766, df = 7.109, p-value = 0.1369
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -0.1600601  0.9484625
sample estimates:
     mean in group BD mean in group Control 
             3.432831              3.038630 

	Welch Two Sample t-test

data:  observed_otus by Group
t = 1.0485, df = 8.1236, p-value = 0.3246
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -9.433948 25.243472
sample estimates:
     mean in group BD mean in group Control 
             46.57143              38.66667 
```

### Wilcoxon test
```R
> wilcox.test(observed_otus~Group,stool)

	Wilcoxon rank sum test with continuity correction

data:  observed_otus by Group
W = 42, p-value = 0.2895
alternative hypothesis: true location shift is not equal to 0

Warning message:
In wilcox.test.default(x = c(62, 65, 53, 42, 60, 22, 22), y = c(52,  :
  cannot compute exact p-value with ties
> wilcox.test(shannon~Group,stool)

	Wilcoxon rank sum exact test

data:  shannon by Group
W = 45, p-value = 0.1738
alternative hypothesis: true location shift is not equal to 0
```

# Cecum
### T- test
```R
> t.test(shannon~Group,cecum)

	Welch Two Sample t-test

data:  shannon by Group
t = 1.1213, df = 7.3144, p-value = 0.2976
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -0.4107919  1.1641795
sample estimates:
     mean in group BD mean in group Control 
             3.667540              3.290846 

> t.test(observed_otus~Group,cecum)

	Welch Two Sample t-test

data:  observed_otus by Group
t = 0.018187, df = 9.875, p-value = 0.9859
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -19.12795  19.44223
sample estimates:
     mean in group BD mean in group Control 
             47.85714              47.70000 
```

### Wilcox test
```R
> wilcox.test(observed_otus~Group,cecum)

	Wilcoxon rank sum test with continuity correction

data:  observed_otus by Group
W = 38, p-value = 0.807
alternative hypothesis: true location shift is not equal to 0

Warning message:
In wilcox.test.default(x = c(66, 68, 50, 52, 58, 22, 19), y = c(44,  :
  cannot compute exact p-value with ties
> wilcox.test(shannon~Group,cecum)

	Wilcoxon rank sum exact test

data:  shannon by Group
W = 49, p-value = 0.1932
alternative hypothesis: true location shift is not equal to 0
```

# SI adherent
### T-test
```R
> t.test(shannon~Group,SI_adherent)

	Welch Two Sample t-test

data:  shannon by Group
t = -0.37407, df = 7.8782, p-value = 0.7182
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -0.9517382  0.6866771
sample estimates:
     mean in group BD mean in group Control 
             3.353848              3.486378 

> t.test(observed_otus~Group,SI_adherent)

	Welch Two Sample t-test

data:  observed_otus by Group
t = -1.843, df = 14.171, p-value = 0.08635
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -18.504290   1.390004
sample estimates:
     mean in group BD mean in group Control 
             51.14286              59.70000 
```

### Wilcox test
```R
> wilcox.test(observed_otus~Group,SI_adherent)

	Wilcoxon rank sum test with continuity correction

data:  observed_otus by Group
W = 24, p-value = 0.304
alternative hypothesis: true location shift is not equal to 0

Warning message:
In wilcox.test.default(x = c(60, 55, 55, 45, 47, 54, 42), y = c(54,  :
  cannot compute exact p-value with ties
> wilcox.test(shannon~Group,SI_adherent)

	Wilcoxon rank sum exact test

data:  shannon by Group
W = 30, p-value = 0.6691
alternative hypothesis: true location shift is not equal to 0
```

# SI luminal
### T- test
```R
> t.test(shannon~Group,SI_luminal)

	Welch Two Sample t-test

data:  shannon by Group
t = -1.4297, df = 12.749, p-value = 0.1768
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -0.6957681  0.1422645
sample estimates:
     mean in group BD mean in group Control 
             3.119741              3.396492 

> t.test(observed_otus~Group,SI_luminal)

	Welch Two Sample t-test

data:  observed_otus by Group
t = -3.0241, df = 12.35, p-value = 0.01028
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -42.562711  -6.980146
sample estimates:
     mean in group BD mean in group Control 
             42.42857              67.20000 
```
### Wilcox test
```R
> wilcox.test(observed_otus~Group,SI_luminal)

	Wilcoxon rank sum test with continuity correction

data:  observed_otus by Group
W = 8, p-value = 0.009617
alternative hypothesis: true location shift is not equal to 0

Warning message:
In wilcox.test.default(x = c(53, 43, 39, 43, 26, 52, 41), y = c(86,  :
  cannot compute exact p-value with ties
> wilcox.test(shannon~Group,SI_luminal)

	Wilcoxon rank sum exact test

data:  shannon by Group
W = 24, p-value = 0.3148
alternative hypothesis: true location shift is not equal to 0
```