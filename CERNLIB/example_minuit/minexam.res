  MINUIT RELEASE 96.03  INITIALIZED.   DIMENSIONS 100/ 50  EPSMAC=  0.89E-15

 PARAMETER DEFINITIONS:
    NO.   NAME         VALUE      STEP SIZE      LIMITS
     1 'Re(X)     '    0.0000      0.10000         no limits
     2 'Im(X)     '    0.0000      0.10000         no limits
     5 'Delta M   '   0.53500      0.10000         no limits
    10 'T Kshort  '   0.89200      constant
    11 'T Klong   '    518.30      constant
 **********
 **    1 **CALL FCN   1.000    
 **********
  LEPTONIC K ZERO DECAYS
 PLUS, MINUS, TOTAL=       194        55       250
0    TIME        THEOR+      EXPTL+     THEOR-      EXPTL-
   0.1000       12.41       11.00      0.1838E-01   0.000    
   0.2000       11.73       9.000      0.6949E-01   0.000    
   0.3000       11.10       13.00      0.1478       0.000    
   0.4000       10.49       13.00      0.2485       0.000    
   0.5000       9.929       17.00      0.3672       0.000    
   0.6000       9.396       9.000      0.5000       0.000    
   0.7000       8.895       1.000      0.6436       0.000    
   0.8000       8.423       7.000      0.7950       0.000    
   0.9000       7.979       8.000      0.9517       1.000    
    1.000       7.563       9.000       1.111       1.000    
    1.100       7.172       6.000       1.272       0.000    
    1.200       6.806       4.000       1.432       2.000    
    1.300       6.464       6.000       1.590       1.000    
    1.400       6.144       3.000       1.745       4.000    
    1.500       5.845       7.000       1.896       4.000    
    1.600       5.567       4.000       2.041       2.000    
    1.700       5.309       7.000       2.181       4.000    
    1.800       5.069       3.000       2.315       2.000    
    1.900       4.847       8.000       2.442       2.000    
    2.000       4.641       4.000       2.562       0.000    
    2.100       4.452       6.000       2.675       2.000    
    2.200       4.277       5.000       2.781       3.000    
    2.300       4.117       7.000       2.880       7.000    
    2.400       3.970       2.000       2.971       2.000    
    2.500       3.836       7.000       3.056       3.000    
    2.600       3.715       1.000       3.133       6.000    
    2.700       3.604       4.000       3.204       2.000    
    2.800       3.504       1.000       3.268       4.000    
    2.900       3.414       4.000       3.326       1.000    
    3.000       3.334       5.000       3.378       5.000    
 DATA EVTS PLUS, MINUS=    191.00     58.00
0          POSITIVE LEPTONS                    NEGATIVE LEPTONS
      TIME    THEOR    EXPTL    CHISQ         TIME    THEOR    EXPTL    CHISQ
     0.100   12.215   11.000    0.134
     0.200   11.550    9.000    0.723
     0.300   10.923   13.000    0.332
     0.400   10.333   13.000    0.547
     0.500    9.776   17.000    3.070
     0.600    9.251    9.000    0.007
     0.800   17.050    8.000   10.237
     0.900    7.856    8.000    0.003
     1.000    7.446    9.000    0.268
     1.100    7.061    6.000    0.188
     1.200    6.701    4.000    1.824
                                              1.200    7.969    4.000    3.939
     1.300    6.364    6.000    0.022
                                              1.400    3.517    5.000    0.440
     1.500   11.804   10.000    0.325
                                              1.500    1.999    4.000    1.001
     1.600    5.481    4.000    0.549
     1.700    5.227    7.000    0.449
                                              1.700    4.453    6.000    0.399
     1.900    9.762   11.000    0.139
                                              1.900    5.016    4.000    0.258
     2.000    4.569    4.000    0.081
     2.100    4.383    6.000    0.436
     2.200    4.211    5.000    0.125
                                              2.200    8.455    5.000    2.388
     2.300    4.053    7.000    1.240
                                              2.300    3.037    7.000    2.244
     2.500    7.686    9.000    0.192
                                              2.500    6.356    5.000    0.368
                                              2.600    3.304    6.000    1.211
     2.700    7.205    5.000    0.973
                                              2.800    6.825    6.000    0.113
     2.900    6.811    5.000    0.656
     3.000    3.282    5.000    0.590
                                              3.000    7.069    6.000    0.191

 FCN=   35.66115     FROM CALl fcn  STATUS=RESET          1 CALLS        1 TOTAL
                     EDM= unknown      STRATEGY= 1      NO ERROR MATRIX       

  EXT PARAMETER               CURRENT GUESS      PHYSICAL LIMITS       
  NO.   NAME        VALUE          ERROR       NEGATIVE      POSITIVE  
   1   Re(X)        0.0000       0.10000    
   2   Im(X)        0.0000       0.10000    
   5   Delta M     0.53500       0.10000    
  10   T Kshort    0.89200       constant   
  11   T Klong      518.30       constant   
 **********
 **    2 **FIX   5.000    
 **********
 **********
 **    3 **SET PRINT   0.000    
 **********
 **********
 **    4 **MIGRAD
 **********

 MIGRAD MINIMIZATION HAS CONVERGED.

 MIGRAD WILL VERIFY CONVERGENCE AND ERROR MATRIX.

 FCN=   34.46034     FROM MIGRAD    STATUS=CONVERGED     41 CALLS       42 TOTAL
                     EDM=  0.80E-07    STRATEGY= 1      ERROR MATRIX ACCURATE 

  EXT PARAMETER                                   STEP         FIRST   
  NO.   NAME        VALUE          ERROR          SIZE      DERIVATIVE 
   1   Re(X)       0.16407E-01   0.72090E-01   0.17639E-03  -0.28064E-02
   2   Im(X)       0.70951E-01   0.10114       0.24569E-03  -0.46762E-02
   5   Delta M     0.53500         fixed    
  10   T Kshort    0.89200       constant   
  11   T Klong      518.30       constant   
 **********
 **    5 **MINOS
 **********

 MINUIT TASK: Time Distribution of Leptonic K0 Decays           

 FCN=   34.46034     FROM MINOS     STATUS=SUCCESSFUL    84 CALLS      126 TOTAL
                     EDM=  0.80E-07    STRATEGY= 1      ERROR MATRIX ACCURATE 

  EXT PARAMETER                  PARABOLIC         MINOS ERRORS        
  NO.   NAME        VALUE          ERROR      NEGATIVE      POSITIVE   
   1   Re(X)       0.16407E-01   0.72090E-01  -0.63526E-01   0.82846E-01
   2   Im(X)       0.70951E-01   0.10114      -0.84444E-01   0.10295    
   5   Delta M     0.53500         fixed    
  10   T Kshort    0.89200       constant   
  11   T Klong      518.30       constant   
 **********
 **    6 **RELEASE   5.000    
 **********
 **********
 **    7 **MIGRAD
 **********

 MIGRAD MINIMIZATION HAS CONVERGED.

 MIGRAD WILL VERIFY CONVERGENCE AND ERROR MATRIX.

 FCN=   33.43457     FROM MIGRAD    STATUS=CONVERGED     76 CALLS      202 TOTAL
                     EDM=  0.35E-06    STRATEGY= 1      ERROR MATRIX ACCURATE 

  EXT PARAMETER                                   STEP         FIRST   
  NO.   NAME        VALUE          ERROR          SIZE      DERIVATIVE 
   1   Re(X)       0.55648E-01   0.88809E-01   0.17195E-03   0.10663E-01
   2   Im(X)       0.27690E-01   0.12535       0.23432E-03   0.79898E-02
   5   Delta M     0.32670       0.24295       0.65218E-03  -0.22361E-02
  10   T Kshort    0.89200       constant   
  11   T Klong      518.30       constant   
 **********
 **    8 **MINOS
 **********

 MINUIT TASK: Time Distribution of Leptonic K0 Decays           

 FCN=   33.43457     FROM MINOS     STATUS=SUCCESSFUL   471 CALLS      673 TOTAL
                     EDM=  0.35E-06    STRATEGY= 1      ERROR MATRIX ACCURATE 

  EXT PARAMETER                  PARABOLIC         MINOS ERRORS        
  NO.   NAME        VALUE          ERROR      NEGATIVE      POSITIVE   
   1   Re(X)       0.55648E-01   0.88809E-01  -0.73133E-01   0.94477E-01
   2   Im(X)       0.27690E-01   0.12535      -0.17859       0.12321    
   5   Delta M     0.32670       0.24295      -0.85930       0.20591    
  10   T Kshort    0.89200       constant   
  11   T Klong      518.30       constant   
 **********
 **    9 **CALL FCN   3.000    
 **********
0          POSITIVE LEPTONS                    NEGATIVE LEPTONS
      TIME    THEOR    EXPTL    CHISQ         TIME    THEOR    EXPTL    CHISQ
     0.100   11.900   11.000    0.074
     0.200   11.223    9.000    0.549
     0.300   10.595   13.000    0.445
     0.400   10.012   13.000    0.687
     0.500    9.472   17.000    3.334
     0.600    8.970    9.000    0.000
     0.800   16.576    8.000    9.193
     0.900    7.669    8.000    0.014
     1.000    7.296    9.000    0.323
     1.100    6.948    6.000    0.150
     1.200    6.625    4.000    1.723
                                              1.200    5.654    4.000    0.684
     1.300    6.325    6.000    0.018
                                              1.400    3.136    5.000    0.695
     1.500   11.832   10.000    0.336
                                              1.500    1.851    4.000    1.155
     1.600    5.545    4.000    0.597
     1.700    5.320    7.000    0.403
                                              1.700    4.256    6.000    0.507
     1.900   10.030   11.000    0.086
                                              1.900    4.972    4.000    0.236
     2.000    4.738    4.000    0.136
     2.100    4.571    6.000    0.340
     2.200    4.416    5.000    0.068
                                              2.200    8.713    5.000    2.757
     2.300    4.272    7.000    1.063
                                              2.300    3.215    7.000    2.046
     2.500    8.152    9.000    0.080
                                              2.500    6.859    5.000    0.691
                                              2.600    3.631    6.000    0.935
     2.700    7.693    5.000    1.451
                                              2.800    7.631    6.000    0.443
     2.900    7.300    5.000    1.058
     3.000    3.521    5.000    0.438
                                              3.000    8.081    6.000    0.722
