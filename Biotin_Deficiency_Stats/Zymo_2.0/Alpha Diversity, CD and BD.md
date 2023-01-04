## Stool
### shannon 
```R
> output <- lme(fixed= shannon ~ Collection*Diet, random = ~1|MouseID, data=stool)
> summary(output)
Linear mixed-effects model fit by REML
 Data: stool 
       AIC      BIC    logLik
  58.78601 75.16187 -19.39301

Random effects:
 Formula: ~1 | MouseID
        (Intercept) Residual
StdDev:  0.03945333 0.335478

Fixed effects: shannon ~ Collection * Diet 
                            Value Std.Error DF   t-value p-value
(Intercept)              4.457734 0.1194268 28  37.32608  0.0000
CollectionWeek12        -1.039516 0.1677390 28  -6.19722  0.0000
CollectionWeek4         -2.090572 0.1737032 28 -12.03531  0.0000
CollectionWeek8         -1.663674 0.1677390 28  -9.91823  0.0000
DietBD                   0.061613 0.2068532 10   0.29786  0.7719
CollectionWeek12:DietBD -0.875378 0.3064514 28  -2.85650  0.0080
CollectionWeek4:DietBD  -0.431148 0.2940162 28  -1.46641  0.1537
CollectionWeek8:DietBD  -0.738070 0.2905324 28  -2.54040  0.0169
 Correlation: 
                        (Intr) CllW12 CllcW4 CllcW8 DietBD CW12:D CW4:DB
CollectionWeek12        -0.702                                          
CollectionWeek4         -0.678  0.483                                   
CollectionWeek8         -0.702  0.500  0.483                            
DietBD                  -0.577  0.405  0.392  0.405                     
CollectionWeek12:DietBD  0.384 -0.547 -0.264 -0.274 -0.666              
CollectionWeek4:DietBD   0.401 -0.285 -0.591 -0.285 -0.694  0.468       
CollectionWeek8:DietBD   0.405 -0.289 -0.279 -0.577 -0.702  0.474  0.494

Standardized Within-Group Residuals:
       Min         Q1        Med         Q3        Max 
-2.7290552 -0.5556092 -0.1750995  0.5108668  2.5615010 

Number of Observations: 46
Number of Groups: 12 
```
### OTUs
```R
> output <- lme(fixed= observed_otus ~ Collection*Diet, random = ~1|MouseID, data=stool)
> summary(output)
Linear mixed-effects model fit by REML
 Data: stool 
      AIC      BIC   logLik
  326.348 342.7238 -153.174

Random effects:
 Formula: ~1 | MouseID
         (Intercept) Residual
StdDev: 0.0005631228 11.41686

Fixed effects: observed_otus ~ Collection * Diet 
                            Value Std.Error DF   t-value p-value
(Intercept)              87.37500  4.036468 28 21.646398  0.0000
CollectionWeek12        -38.62500  5.708428 28 -6.766311  0.0000
CollectionWeek4         -49.66071  5.908785 28 -8.404557  0.0000
CollectionWeek8         -40.00000  5.708428 28 -7.007183  0.0000
DietBD                   18.87500  6.991368 10  2.699758  0.0223
CollectionWeek12:DietBD -27.29167 10.422116 28 -2.618630  0.0141
CollectionWeek4:DietBD  -26.08929 10.004301 28 -2.607807  0.0144
CollectionWeek8:DietBD  -38.25000  9.887288 28 -3.868604  0.0006
 Correlation: 
                        (Intr) CllW12 CllcW4 CllcW8 DietBD CW12:D CW4:DB
CollectionWeek12        -0.707                                          
CollectionWeek4         -0.683  0.483                                   
CollectionWeek8         -0.707  0.500  0.483                            
DietBD                  -0.577  0.408  0.394  0.408                     
CollectionWeek12:DietBD  0.387 -0.548 -0.265 -0.274 -0.671              
CollectionWeek4:DietBD   0.403 -0.285 -0.591 -0.285 -0.699  0.469       
CollectionWeek8:DietBD   0.408 -0.289 -0.279 -0.577 -0.707  0.474  0.494

Standardized Within-Group Residuals:
        Min          Q1         Med          Q3         Max 
-1.87223164 -0.55838488 -0.02189745  0.57285283  3.20797586 

Number of Observations: 46
Number of Groups: 12 
```

## Colon
```R
> t.test(shannon~Diet,cvsbd)

	Welch Two Sample t-test

data:  shannon by Diet
t = 4.9308, df = 3.9568, p-value = 0.008091
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 0.5648597 2.0352315
sample estimates:
mean in group CD mean in group BD 
        3.558840         2.258795 

> t.test(observed_otus~Diet,cvsbd)

	Welch Two Sample t-test

data:  observed_otus by Diet
t = 2.8366, df = 8.9969, p-value = 0.01952
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
  3.720395 33.029605
sample estimates:
mean in group CD mean in group BD 
          52.375           34.000 

> wilcox.test(observed_otus~Diet,cvsbd)

	Wilcoxon rank sum test with continuity correction

data:  observed_otus by Diet
W = 21, p-value = 0.08133
alternative hypothesis: true location shift is not equal to 0

Warning message:
In wilcox.test.default(x = c(51, 52, 61, 15, 69, 57, 61, 53), y = c(37,  :
  cannot compute exact p-value with ties
> wilcox.test(shannon~Diet,cvsbd)

	Wilcoxon rank sum exact test

data:  shannon by Diet
W = 24, p-value = 0.01212
alternative hypothesis: true location shift is not equal to 0

```