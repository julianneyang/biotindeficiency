```R
> output <- lme(fixed= Weight_Percent_of_Baseline ~ Collection*Diet, random = ~1|MouseID, data=data)
> summary(output)
Linear mixed-effects model fit by REML
 Data: data 
       AIC      BIC    logLik
  253.1924 274.5615 -112.5962

Random effects:
 Formula: ~1 | MouseID
        (Intercept) Residual
StdDev:    4.796169 4.128162

Fixed effects: Weight_Percent_of_Baseline ~ Collection * Diet 
                                 Value Std.Error DF   t-value p-value
(Intercept)                  100.00000  3.164054 25 31.605019  0.0000
CollectionWeek4               22.20049  3.212575 25  6.910497  0.0000
CollectionWeek8               31.25000  2.919052 25 10.705532  0.0000
CollectionWeek12              34.50000  2.919052 25 11.818907  0.0000
DietBD                         0.00000  4.474649  9  0.000000  1.0000
DietBD_supp                    0.00000  4.474649  9  0.000000  1.0000
CollectionWeek4:DietBD        -2.45049  4.340680 25 -0.564541  0.5774
CollectionWeek8:DietBD        -8.00000  4.128162 25 -1.937908  0.0640
CollectionWeek12:DietBD      -19.47691  4.340680 25 -4.487064  0.0001
CollectionWeek4:DietBD_supp   -2.45049  4.340680 25 -0.564541  0.5774
CollectionWeek8:DietBD_supp   -6.75000  4.128162 25 -1.635110  0.1146
CollectionWeek12:DietBD_supp  -5.25000  4.128162 25 -1.271752  0.2152
```

```R
> output <- lme(fixed= Weight_Percent_of_Baseline ~ Collection+Diet, random = ~1|MouseID, data=data)
> summary(output)
Linear mixed-effects model fit by REML
 Data: data 
       AIC      BIC    logLik
  289.0959 302.6069 -136.5479

Random effects:
 Formula: ~1 | MouseID
        (Intercept) Residual
StdDev:    4.662905 5.276875

Fixed effects: Weight_Percent_of_Baseline ~ Collection + Diet 
                     Value Std.Error DF  t-value p-value
(Intercept)      103.59302  3.000122 31 34.52960  0.0000
CollectionWeek4   20.77100  2.214708 31  9.37866  0.0000
CollectionWeek8   26.33333  2.154275 31 12.22376  0.0000
CollectionWeek12  27.08658  2.214708 31 12.23032  0.0000
DietBD            -7.01331  3.828511  9 -1.83186  0.1002
DietBD_supp       -3.76575  3.807957  9 -0.98892  0.3485
```

```R
Linear mixed-effects model fit by REML
 Data: data 
       AIC      BIC    logLik
  292.5858 304.5808 -139.2929

Random effects:
 Formula: ~1 | MouseID
        (Intercept) Residual
StdDev:    4.652175 5.277843

Fixed effects: Weight_Percent_of_Baseline ~ Collection + Diet 
                     Value Std.Error DF  t-value p-value
(Intercept)      101.70340  2.310381 31 44.02019   0.000
CollectionWeek4   20.71928  2.214488 31  9.35624   0.000
CollectionWeek8   26.33333  2.154671 31 12.22151   0.000
CollectionWeek12  27.08772  2.215100 31 12.22867   0.000
DietBD            -5.11019  3.304082 10 -1.54663   0.153
 Correlation: 
                 (Intr) CllcW4 CllcW8 CllW12
CollectionWeek4  -0.447                     
CollectionWeek8  -0.466  0.486              
CollectionWeek12 -0.467  0.472  0.486       
DietBD           -0.477 -0.014  0.000  0.027

Standardized Within-Group Residuals:
        Min          Q1         Med          Q3         Max 
-2.27179784 -0.66955139 -0.02807639  0.50732261  1.91240318 

Number of Observations: 46
Number of Groups: 12 
```

```R
> output <- lme(fixed= Weight_Percent_of_Baseline ~ Collection*Diet, random = ~1|MouseID, data=data)
> summary(output)
Linear mixed-effects model fit by REML
 Data: data 
       AIC      BIC    logLik
  267.2338 283.6097 -123.6169

Random effects:
 Formula: ~1 | MouseID
        (Intercept) Residual
StdDev:    4.787811  4.13782

Fixed effects: Weight_Percent_of_Baseline ~ Collection * Diet 
                            Value Std.Error DF  t-value p-value
(Intercept)             100.00000  2.237317 28 44.69640  0.0000
CollectionWeek4          21.02883  2.160493 28  9.73335  0.0000
CollectionWeek8          27.87500  2.068910 28 13.47328  0.0000
CollectionWeek12         31.87500  2.068910 28 15.40666  0.0000
DietBD                    0.00000  3.875146 10  0.00000  1.0000
CollectionWeek4:DietBD   -1.27883  3.637101 28 -0.35161  0.7278
CollectionWeek8:DietBD   -4.62500  3.583457 28 -1.29065  0.2074
CollectionWeek12:DietBD -16.85248  3.827369 28 -4.40315  0.0001
 Correlation: 
```