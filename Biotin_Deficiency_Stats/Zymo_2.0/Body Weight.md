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