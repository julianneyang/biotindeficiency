# Stool
### LMEM
Shannon ~Collection* Diet
```R
Fixed effects: shannon ~ Collection * Diet 
                                 Value Std.Error DF  t-value p-value
(Intercept)                   6.412616 0.1517077 25 42.26956  0.0000
CollectionWeek12              0.280384 0.2145470 25  1.30686  0.2032
CollectionWeek4               0.392880 0.2317373 25  1.69537  0.1024
CollectionWeek8               0.248497 0.2145470 25  1.15824  0.2577
DietBD                        0.346987 0.2145470  9  1.61730  0.1403
DietBD_supp                  -0.009505 0.2145470  9 -0.04430  0.9656
CollectionWeek12:DietBD      -0.251051 0.3158047 25 -0.79496  0.4341
CollectionWeek4:DietBD       -0.683649 0.3158047 25 -2.16478  0.0402
CollectionWeek8:DietBD       -0.455329 0.3034153 25 -1.50068  0.1460
CollectionWeek12:DietBD_supp  0.136618 0.3034153 25  0.45027  0.6564
CollectionWeek4:DietBD_supp  -0.113289 0.3158047 25 -0.35873  0.7228
CollectionWeek8:DietBD_supp   0.193375 0.3034153 25  0.63733  0.5297
```

OTUs ~ Collection* Diet 
```R
Fixed effects: observed_otus ~ Collection * Diet 
                                 Value Std.Error DF   t-value p-value
(Intercept)                  170.75000  18.32156 25  9.319622  0.0000
CollectionWeek12              18.75000  25.91060 25  0.723642  0.4760
CollectionWeek4               34.58333  27.98664 25  1.235708  0.2281
CollectionWeek8                9.00000  25.91060 25  0.347348  0.7312
DietBD                        45.75000  25.91060  9  1.765687  0.1113
DietBD_supp                  -21.25000  25.91060  9 -0.820128  0.4333
CollectionWeek12:DietBD      -40.25000  38.13937 25 -1.055340  0.3014
CollectionWeek4:DietBD       -85.33333  38.13937 25 -2.237408  0.0344
CollectionWeek8:DietBD       -62.00000  36.64312 25 -1.691996  0.1031
CollectionWeek12:DietBD_supp  58.50000  36.64312 25  1.596480  0.1229
CollectionWeek4:DietBD_supp  -10.08333  38.13937 25 -0.264381  0.7937
CollectionWeek8:DietBD_supp   47.75000  36.64312 25  1.303110  0.2044
```

Shannon~ Collection + Diet 
```R
                    Value Std.Error DF  t-value p-value
(Intercept)      6.503219 0.1107493 31 58.72019  0.0000
CollectionWeek12 0.239111 0.1295891 31  1.84515  0.0746
CollectionWeek4  0.111321 0.1295891 31  0.85903  0.3969
CollectionWeek8  0.161179 0.1266080 31  1.27306  0.2125
DietBD           0.009069 0.1135864  9  0.07984  0.9381
DietBD_supp      0.056605 0.1115876  9  0.50727  0.6242
```

OTUs ~ Collection + Diet 
```R
Fixed effects: observed_otus ~ Collection + Diet 
                     Value Std.Error DF   t-value p-value
(Intercept)      177.02581  14.35268 31 12.333986  0.0000
CollectionWeek12  25.56055  16.79425 31  1.521982  0.1381
CollectionWeek4    0.45689  16.79425 31  0.027205  0.9785
CollectionWeek8    4.25000  16.40791 31  0.259021  0.7973
DietBD             1.14024  14.72036  9  0.077460  0.9400
DietBD_supp        4.53233  14.46133  9  0.313410  0.7611
```