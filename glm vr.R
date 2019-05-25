> #  Copyright (C) 1997-2009 The R Core Team
> 
> #### -*- R -*-
> require(stats)

> Fr <- c(68,42,42,30, 37,52,24,43,
+ 	66,50,33,23, 47,55,23,47,
+ 	63,53,29,27, 57,49,19,29)

> Temp <- gl(2, 2, 24, labels = c("Low", "High"))

> Soft <- gl(3, 8, 24, labels = c("Hard","Medium","Soft"))

> M.user <- gl(2, 4, 24, labels = c("N", "Y"))

> Brand <- gl(2, 1, 24, labels = c("X", "M"))

> detg <- data.frame(Fr,Temp, Soft,M.user, Brand)

> detg.m0 <- glm(Fr ~ M.user*Temp*Soft + Brand, family = poisson, data = detg)

> summary(detg.m0)

Call:
glm(formula = Fr ~ M.user * Temp * Soft + Brand, family = poisson, 
    data = detg)

Deviance Residuals: 
     Min        1Q    Median        3Q       Max  
-2.20876  -0.99190  -0.00126   0.93542   1.97601  

Coefficients:
                            Estimate Std. Error z value Pr(>|z|)    
(Intercept)                  4.01524    0.10034  40.018  < 2e-16 ***
M.userY                     -0.21184    0.14257  -1.486  0.13731    
TempHigh                    -0.42381    0.15159  -2.796  0.00518 ** 
SoftMedium                   0.05311    0.13308   0.399  0.68984    
SoftSoft                     0.05311    0.13308   0.399  0.68984    
BrandM                      -0.01587    0.06300  -0.252  0.80106    
M.userY:TempHigh             0.13987    0.22168   0.631  0.52806    
M.userY:SoftMedium           0.08323    0.19685   0.423  0.67245    
M.userY:SoftSoft             0.12169    0.19591   0.621  0.53449    
TempHigh:SoftMedium         -0.30442    0.22239  -1.369  0.17104    
TempHigh:SoftSoft           -0.30442    0.22239  -1.369  0.17104    
M.userY:TempHigh:SoftMedium  0.21189    0.31577   0.671  0.50220    
M.userY:TempHigh:SoftSoft   -0.20387    0.32540  -0.627  0.53098    
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

(Dispersion parameter for poisson family taken to be 1)

    Null deviance: 118.627  on 23  degrees of freedom
Residual deviance:  32.826  on 11  degrees of freedom
AIC: 191.24

Number of Fisher Scoring iterations: 4


> detg.mod <- glm(terms(Fr ~ M.user*Temp*Soft + Brand*M.user*Temp,
+                       keep.order = TRUE),
+ 		family = poisson, data = detg)

> summary(detg.mod)

Call:
glm(formula = terms(Fr ~ M.user * Temp * Soft + Brand * M.user * 
    Temp, keep.order = TRUE), family = poisson, data = detg)

Deviance Residuals: 
     Min        1Q    Median        3Q       Max  
-0.91365  -0.35585   0.00253   0.33027   0.92146  

Coefficients:
                            Estimate Std. Error z value Pr(>|z|)    
(Intercept)                  4.14887    0.10603  39.128  < 2e-16 ***
M.userY                     -0.40521    0.16188  -2.503  0.01231 *  
TempHigh                    -0.44275    0.17121  -2.586  0.00971 ** 
M.userY:TempHigh            -0.12692    0.26257  -0.483  0.62883    
SoftMedium                   0.05311    0.13308   0.399  0.68984    
SoftSoft                     0.05311    0.13308   0.399  0.68984    
M.userY:SoftMedium           0.08323    0.19685   0.423  0.67245    
M.userY:SoftSoft             0.12169    0.19591   0.621  0.53449    
TempHigh:SoftMedium         -0.30442    0.22239  -1.369  0.17104    
TempHigh:SoftSoft           -0.30442    0.22239  -1.369  0.17104    
M.userY:TempHigh:SoftMedium  0.21189    0.31577   0.671  0.50220    
M.userY:TempHigh:SoftSoft   -0.20387    0.32540  -0.627  0.53098    
BrandM                      -0.30647    0.10942  -2.801  0.00510 ** 
M.userY:BrandM               0.40757    0.15961   2.554  0.01066 *  
TempHigh:BrandM              0.04411    0.18463   0.239  0.81119    
M.userY:TempHigh:BrandM      0.44427    0.26673   1.666  0.09579 .  
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

(Dispersion parameter for poisson family taken to be 1)

    Null deviance: 118.627  on 23  degrees of freedom
Residual deviance:   5.656  on  8  degrees of freedom
AIC: 170.07

Number of Fisher Scoring iterations: 4


> summary(detg.mod, correlation = TRUE, symbolic.cor = TRUE)

Call:
glm(formula = terms(Fr ~ M.user * Temp * Soft + Brand * M.user * 
    Temp, keep.order = TRUE), family = poisson, data = detg)

Deviance Residuals: 
     Min        1Q    Median        3Q       Max  
-0.91365  -0.35585   0.00253   0.33027   0.92146  

Coefficients:
                            Estimate Std. Error z value Pr(>|z|)    
(Intercept)                  4.14887    0.10603  39.128  < 2e-16 ***
M.userY                     -0.40521    0.16188  -2.503  0.01231 *  
TempHigh                    -0.44275    0.17121  -2.586  0.00971 ** 
M.userY:TempHigh            -0.12692    0.26257  -0.483  0.62883    
SoftMedium                   0.05311    0.13308   0.399  0.68984    
SoftSoft                     0.05311    0.13308   0.399  0.68984    
M.userY:SoftMedium           0.08323    0.19685   0.423  0.67245    
M.userY:SoftSoft             0.12169    0.19591   0.621  0.53449    
TempHigh:SoftMedium         -0.30442    0.22239  -1.369  0.17104    
TempHigh:SoftSoft           -0.30442    0.22239  -1.369  0.17104    
M.userY:TempHigh:SoftMedium  0.21189    0.31577   0.671  0.50220    
M.userY:TempHigh:SoftSoft   -0.20387    0.32540  -0.627  0.53098    
BrandM                      -0.30647    0.10942  -2.801  0.00510 ** 
M.userY:BrandM               0.40757    0.15961   2.554  0.01066 *  
TempHigh:BrandM              0.04411    0.18463   0.239  0.81119    
M.userY:TempHigh:BrandM      0.44427    0.26673   1.666  0.09579 .  
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

(Dispersion parameter for poisson family taken to be 1)

    Null deviance: 118.627  on 23  degrees of freedom
Residual deviance:   5.656  on  8  degrees of freedom
AIC: 170.07

Number of Fisher Scoring iterations: 4

Correlation of Coefficients:
                                                           
(Intercept)                 1                              
M.userY                     , 1                            
TempHigh                    , . 1                          
M.userY:TempHigh            . , , 1                        
SoftMedium                  , . .   1                      
SoftSoft                    , . .   . 1                    
M.userY:SoftMedium          . ,   . , . 1                  
M.userY:SoftSoft            . ,   . . , . 1                
TempHigh:SoftMedium         .   , . . . .   1              
TempHigh:SoftSoft           .   , . . .   . . 1            
M.userY:TempHigh:SoftMedium   . . . .   , . , . 1          
M.userY:TempHigh:SoftSoft     . . .   . . , . , . 1        
BrandM                      .                       1      
M.userY:BrandM                .                     , 1    
TempHigh:BrandM                 . .                 . . 1  
M.userY:TempHigh:BrandM         . .                 . . , 1
attr(,"legend")
[1] 0 ‘ ’ 0.3 ‘.’ 0.6 ‘,’ 0.8 ‘+’ 0.9 ‘*’ 0.95 ‘B’ 1


> anova(detg.m0, detg.mod)
Analysis of Deviance Table

Model 1: Fr ~ M.user * Temp * Soft + Brand
Model 2: Fr ~ M.user * Temp * Soft + Brand * M.user * Temp
  Resid. Df Resid. Dev Df Deviance
1        11     32.826            
2         8      5.656  3    27.17
> 
> demo(glm.vr)


	demo(glm.vr)
	---- ~~~~~~

Type  <Return>	 to start : 

> #  Copyright (C) 1997-2009 The R Core Team
> 
> #### -*- R -*-
> require(stats)

> Fr <- c(68,42,42,30, 37,52,24,43,
+ 	66,50,33,23, 47,55,23,47,
+ 	63,53,29,27, 57,49,19,29)

> Temp <- gl(2, 2, 24, labels = c("Low", "High"))

> Soft <- gl(3, 8, 24, labels = c("Hard","Medium","Soft"))

> M.user <- gl(2, 4, 24, labels = c("N", "Y"))

> Brand <- gl(2, 1, 24, labels = c("X", "M"))

> detg <- data.frame(Fr,Temp, Soft,M.user, Brand)

> detg.m0 <- glm(Fr ~ M.user*Temp*Soft + Brand, family = poisson, data = detg)

> summary(detg.m0)

Call:
glm(formula = Fr ~ M.user * Temp * Soft + Brand, family = poisson, 
    data = detg)

Deviance Residuals: 
     Min        1Q    Median        3Q       Max  
-2.20876  -0.99190  -0.00126   0.93542   1.97601  

Coefficients:
                            Estimate Std. Error z value Pr(>|z|)    
(Intercept)                  4.01524    0.10034  40.018  < 2e-16 ***
M.userY                     -0.21184    0.14257  -1.486  0.13731    
TempHigh                    -0.42381    0.15159  -2.796  0.00518 ** 
SoftMedium                   0.05311    0.13308   0.399  0.68984    
SoftSoft                     0.05311    0.13308   0.399  0.68984    
BrandM                      -0.01587    0.06300  -0.252  0.80106    
M.userY:TempHigh             0.13987    0.22168   0.631  0.52806    
M.userY:SoftMedium           0.08323    0.19685   0.423  0.67245    
M.userY:SoftSoft             0.12169    0.19591   0.621  0.53449    
TempHigh:SoftMedium         -0.30442    0.22239  -1.369  0.17104    
TempHigh:SoftSoft           -0.30442    0.22239  -1.369  0.17104    
M.userY:TempHigh:SoftMedium  0.21189    0.31577   0.671  0.50220    
M.userY:TempHigh:SoftSoft   -0.20387    0.32540  -0.627  0.53098    
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

(Dispersion parameter for poisson family taken to be 1)

    Null deviance: 118.627  on 23  degrees of freedom
Residual deviance:  32.826  on 11  degrees of freedom
AIC: 191.24

Number of Fisher Scoring iterations: 4


> detg.mod <- glm(terms(Fr ~ M.user*Temp*Soft + Brand*M.user*Temp,
+                       keep.order = TRUE),
+ 		family = poisson, data = detg)

> summary(detg.mod)

Call:
glm(formula = terms(Fr ~ M.user * Temp * Soft + Brand * M.user * 
    Temp, keep.order = TRUE), family = poisson, data = detg)

Deviance Residuals: 
     Min        1Q    Median        3Q       Max  
-0.91365  -0.35585   0.00253   0.33027   0.92146  

Coefficients:
                            Estimate Std. Error z value Pr(>|z|)    
(Intercept)                  4.14887    0.10603  39.128  < 2e-16 ***
M.userY                     -0.40521    0.16188  -2.503  0.01231 *  
TempHigh                    -0.44275    0.17121  -2.586  0.00971 ** 
M.userY:TempHigh            -0.12692    0.26257  -0.483  0.62883    
SoftMedium                   0.05311    0.13308   0.399  0.68984    
SoftSoft                     0.05311    0.13308   0.399  0.68984    
M.userY:SoftMedium           0.08323    0.19685   0.423  0.67245    
M.userY:SoftSoft             0.12169    0.19591   0.621  0.53449    
TempHigh:SoftMedium         -0.30442    0.22239  -1.369  0.17104    
TempHigh:SoftSoft           -0.30442    0.22239  -1.369  0.17104    
M.userY:TempHigh:SoftMedium  0.21189    0.31577   0.671  0.50220    
M.userY:TempHigh:SoftSoft   -0.20387    0.32540  -0.627  0.53098    
BrandM                      -0.30647    0.10942  -2.801  0.00510 ** 
M.userY:BrandM               0.40757    0.15961   2.554  0.01066 *  
TempHigh:BrandM              0.04411    0.18463   0.239  0.81119    
M.userY:TempHigh:BrandM      0.44427    0.26673   1.666  0.09579 .  
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

(Dispersion parameter for poisson family taken to be 1)

    Null deviance: 118.627  on 23  degrees of freedom
Residual deviance:   5.656  on  8  degrees of freedom
AIC: 170.07

Number of Fisher Scoring iterations: 4


> summary(detg.mod, correlation = TRUE, symbolic.cor = TRUE)

Call:
glm(formula = terms(Fr ~ M.user * Temp * Soft + Brand * M.user * 
    Temp, keep.order = TRUE), family = poisson, data = detg)

Deviance Residuals: 
     Min        1Q    Median        3Q       Max  
-0.91365  -0.35585   0.00253   0.33027   0.92146  

Coefficients:
                            Estimate Std. Error z value Pr(>|z|)    
(Intercept)                  4.14887    0.10603  39.128  < 2e-16 ***
M.userY                     -0.40521    0.16188  -2.503  0.01231 *  
TempHigh                    -0.44275    0.17121  -2.586  0.00971 ** 
M.userY:TempHigh            -0.12692    0.26257  -0.483  0.62883    
SoftMedium                   0.05311    0.13308   0.399  0.68984    
SoftSoft                     0.05311    0.13308   0.399  0.68984    
M.userY:SoftMedium           0.08323    0.19685   0.423  0.67245    
M.userY:SoftSoft             0.12169    0.19591   0.621  0.53449    
TempHigh:SoftMedium         -0.30442    0.22239  -1.369  0.17104    
TempHigh:SoftSoft           -0.30442    0.22239  -1.369  0.17104    
M.userY:TempHigh:SoftMedium  0.21189    0.31577   0.671  0.50220    
M.userY:TempHigh:SoftSoft   -0.20387    0.32540  -0.627  0.53098    
BrandM                      -0.30647    0.10942  -2.801  0.00510 ** 
M.userY:BrandM               0.40757    0.15961   2.554  0.01066 *  
TempHigh:BrandM              0.04411    0.18463   0.239  0.81119    
M.userY:TempHigh:BrandM      0.44427    0.26673   1.666  0.09579 .  
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

(Dispersion parameter for poisson family taken to be 1)

    Null deviance: 118.627  on 23  degrees of freedom
Residual deviance:   5.656  on  8  degrees of freedom
AIC: 170.07

Number of Fisher Scoring iterations: 4

Correlation of Coefficients:
                                                           
(Intercept)                 1                              
M.userY                     , 1                            
TempHigh                    , . 1                          
M.userY:TempHigh            . , , 1                        
SoftMedium                  , . .   1                      
SoftSoft                    , . .   . 1                    
M.userY:SoftMedium          . ,   . , . 1                  
M.userY:SoftSoft            . ,   . . , . 1                
TempHigh:SoftMedium         .   , . . . .   1              
TempHigh:SoftSoft           .   , . . .   . . 1            
M.userY:TempHigh:SoftMedium   . . . .   , . , . 1          
M.userY:TempHigh:SoftSoft     . . .   . . , . , . 1        
BrandM                      .                       1      
M.userY:BrandM                .                     , 1    
TempHigh:BrandM                 . .                 . . 1  
M.userY:TempHigh:BrandM         . .                 . . , 1
attr(,"legend")
[1] 0 ‘ ’ 0.3 ‘.’ 0.6 ‘,’ 0.8 ‘+’ 0.9 ‘*’ 0.95 ‘B’ 1


> anova(detg.m0, detg.mod)
Analysis of Deviance Table

Model 1: Fr ~ M.user * Temp * Soft + Brand
Model 2: Fr ~ M.user * Temp * Soft + Brand * M.user * Temp
  Resid. Df Resid. Dev Df Deviance
1        11     32.826            
2         8      5.656  3    27.17
