### Weight
```R
> t.test(X..Starting.weight~Group,data)

	Welch Two Sample t-test

data:  X..Starting.weight by Group
t = -6.7769, df = 13.481, p-value = 1.085e-05
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -32.58321 -16.87394
sample estimates:
     mean in group BD mean in group Control 
             108.5714              133.3000 

> wilcox.test(X..Starting.weight~Group,data)

	Wilcoxon rank sum test with continuity correction

data:  X..Starting.weight by Group
W = 0, p-value = 0.0006782
alternative hypothesis: true location shift is not equal to 0
```

### Histology
```R
> t.test(Histology~Group,histo)

	Welch Two Sample t-test

data:  Histology by Group
t = 3.378, df = 5.131, p-value = 0.01894
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 0.9711623 6.9621710
sample estimates:
     mean in group BD mean in group Control 
             4.166667              0.200000 

> wilcox.test(Histology~Group,histo)

	Wilcoxon rank sum test with continuity correction

data:  Histology by Group
W = 54, p-value = 0.004934
alternative hypothesis: true location shift is not equal to 0
```

### Calprotectin
```R
> t.test(Calprotectin~Diet,calprotectin)

	Welch Two Sample t-test

data:  Calprotectin by Diet
t = -3.7981, df = 9.9902, p-value = 0.003503
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -12139.401  -3161.869
sample estimates:
mean in group Control      mean in group BD 
             1542.222              9192.857 

> wilcox.test(Calprotectin~Diet,calprotectin)

	Wilcoxon rank sum test with continuity correction

data:  Calprotectin by Diet
W = 4, p-value = 0.00285
alternative hypothesis: true location shift is not equal to 0
```


