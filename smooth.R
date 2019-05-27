> ### This used to be in   example(smooth) before we had package-specific demos
> #  Copyright (C) 1997-2009 The R Core Team
> 
> require(stats); require(graphics); require(datasets)

> op <- par(mfrow = c(1,1))

> ## The help(smooth) examples:
> example(smooth, package="stats")

smooth> require(graphics)

smooth> ## see also   demo(smooth) !
smooth> 
smooth> x1 <- c(4, 1, 3, 6, 6, 4, 1, 6, 2, 4, 2) # very artificial

smooth> (x3R <- smooth(x1, "3R")) # 2 iterations of "3"
3R Tukey smoother resulting from  smooth(x = x1, kind = "3R") 
 used 2 iterations
 [1] 3 3 3 6 6 4 4 4 2 2 2

smooth> smooth(x3R, kind = "S")
S Tukey smoother resulting from  smooth(x = x3R, kind = "S") 
 changed
 [1] 3 3 3 3 4 4 4 4 2 2 2

smooth> sm.3RS <- function(x, ...)
smooth+    smooth(smooth(x, "3R", ...), "S", ...)

smooth> y <- c(1, 1, 19:1)

smooth> plot(y, main = "misbehaviour of \"3RSR\"", col.main = 3)
Hit <Return> to see next plot: 

smooth> lines(sm.3RS(y))

smooth> lines(smooth(y))

smooth> lines(smooth(y, "3RSR"), col = 3, lwd = 2)  # the horror

smooth> x <- c(8:10, 10, 0, 0, 9, 9)

smooth> plot(x, main = "breakdown of  3R  and  S  and hence  3RSS")
Hit <Return> to see next plot: 

smooth> matlines(cbind(smooth(x, "3R"), smooth(x, "S"), smooth(x, "3RSS"), smooth(x)))

smooth> presidents[is.na(presidents)] <- 0 # silly

smooth> summary(sm3 <- smooth(presidents, "3R"))
3R Tukey smoother resulting from
 smooth(x = presidents, kind = "3R") ;  n = 120 
 used 4 iterations
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    0.0    44.0    57.0    54.2    71.0    82.0 

smooth> summary(sm2 <- smooth(presidents,"3RSS"))
3RSS Tukey smoother resulting from
 smooth(x = presidents, kind = "3RSS") ;  n = 120 
 used 5 iterations
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
   0.00   44.00   57.00   55.45   69.00   82.00 

smooth> summary(sm  <- smooth(presidents))
3RS3R Tukey smoother resulting from
 smooth(x = presidents) ;  n = 120 
 used 7 iterations
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  24.00   44.00   57.00   55.88   69.00   82.00 

smooth> all.equal(c(sm2), c(smooth(smooth(sm3, "S"), "S")))  # 3RSS  === 3R S S
[1] TRUE

smooth> all.equal(c(sm),  c(smooth(smooth(sm3, "S"), "3R"))) # 3RS3R === 3R S 3R
[1] TRUE

smooth> plot(presidents, main = "smooth(presidents0, *) :  3R and default 3RS3R")
Hit <Return> to see next plot: 

smooth> lines(sm3, col = 3, lwd = 1.5)

smooth> lines(sm, col = 2, lwd = 1.25)

> ## Didactical investigation:
> 
> showSmooth <- function(x, leg.x = 1, leg.y = max(x)) {
+   ss <- cbind(x, "3c"  = smooth(x, "3", end="copy"),
+                  "3"   = smooth(x, "3"),
+                  "3Rc" = smooth(x, "3R", end="copy"),
+                  "3R"  = smooth(x, "3R"),
+               sm = smooth(x))
+   k <- ncol(ss) - 1
+   n <- length(x)
+   slwd <- c(1,1,4,1,3,2)
+   slty <- c(0, 2:(k+1))
+   matplot(ss, main = "Tukey Smoothers", ylab = "y ;  sm(y)",
+           type= c("p",rep("l",k)), pch= par("pch"), lwd= slwd, lty= slty)
+   legend(leg.x, leg.y,
+          c("Data",       "3   (copy)", "3  (Tukey)",
+                  "3R  (copy)", "3R (Tukey)", "smooth()"),
+          pch= c(par("pch"),rep(-1,k)), col=1:(k+1), lwd= slwd, lty= slty)
+   ss
+ }

> ## 4 simple didactical examples, showing different steps in smooth():
> 
> for(x in list(c(4, 6, 2, 2, 6, 3, 6, 6, 5, 2),
+               c(3, 2, 1, 4, 5, 1, 3, 2, 4, 5, 2),
+               c(2, 4, 2, 6, 1, 1, 2, 6, 3, 1, 6),
+               x1))
+     print(t(showSmooth(x)))
Hit <Return> to see next plot: 
    [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9] [,10]
x      4    6    2    2    6    3    6    6    5     2
3c     4    4    2    2    3    6    6    6    5     2
3      4    4    2    2    3    6    6    6    5     3
3Rc    4    4    2    2    3    6    6    6    5     2
3R     4    4    2    2    3    6    6    6    5     3
sm     4    4    4    3    3    6    6    6    5     3
Hit <Return> to see next plot: 
    [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9] [,10] [,11]
x      3    2    1    4    5    1    3    2    4     5     2
3c     3    2    2    4    4    3    2    3    4     4     2
3      2    2    2    4    4    3    2    3    4     4     4
3Rc    3    2    2    4    4    3    3    3    4     4     2
3R     2    2    2    4    4    3    3    3    4     4     4
sm     2    2    2    2    3    3    3    3    4     4     4
Hit <Return> to see next plot: 
    [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9] [,10] [,11]
x      2    4    2    6    1    1    2    6    3     1     6
3c     2    2    4    2    1    1    2    3    3     3     6
3      2    2    4    2    1    1    2    3    3     3     3
3Rc    2    2    2    2    1    1    2    3    3     3     6
3R     2    2    2    2    1    1    2    3    3     3     3
sm     2    2    2    2    2    2    2    3    3     3     3
Hit <Return> to see next plot: 
    [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9] [,10] [,11]
x      4    1    3    6    6    4    1    6    2     4     2
3c     4    3    3    6    6    4    4    2    4     2     2
3      3    3    3    6    6    4    4    2    4     2     2
3Rc    4    3    3    6    6    4    4    4    2     2     2
3R     3    3    3    6    6    4    4    4    2     2     2
sm     3    3    3    3    4    4    4    4    2     2     2

> par(op)
> 
> 
> demo(smooth)


	demo(smooth)
	---- ~~~~~~

Type  <Return>	 to start : 

> ### This used to be in   example(smooth) before we had package-specific demos
> #  Copyright (C) 1997-2009 The R Core Team
> 
> require(stats); require(graphics); require(datasets)

> op <- par(mfrow = c(1,1))

> ## The help(smooth) examples:
> example(smooth, package="stats")

smooth> require(graphics)

smooth> ## see also   demo(smooth) !
smooth> 
smooth> x1 <- c(4, 1, 3, 6, 6, 4, 1, 6, 2, 4, 2) # very artificial

smooth> (x3R <- smooth(x1, "3R")) # 2 iterations of "3"
3R Tukey smoother resulting from  smooth(x = x1, kind = "3R") 
 used 2 iterations
 [1] 3 3 3 6 6 4 4 4 2 2 2

smooth> smooth(x3R, kind = "S")
S Tukey smoother resulting from  smooth(x = x3R, kind = "S") 
 changed
 [1] 3 3 3 3 4 4 4 4 2 2 2

smooth> sm.3RS <- function(x, ...)
smooth+    smooth(smooth(x, "3R", ...), "S", ...)

smooth> y <- c(1, 1, 19:1)

smooth> plot(y, main = "misbehaviour of \"3RSR\"", col.main = 3)
Hit <Return> to see next plot: 

smooth> lines(sm.3RS(y))

smooth> lines(smooth(y))

smooth> lines(smooth(y, "3RSR"), col = 3, lwd = 2)  # the horror

smooth> x <- c(8:10, 10, 0, 0, 9, 9)

smooth> plot(x, main = "breakdown of  3R  and  S  and hence  3RSS")
Hit <Return> to see next plot: 

smooth> matlines(cbind(smooth(x, "3R"), smooth(x, "S"), smooth(x, "3RSS"), smooth(x)))

smooth> presidents[is.na(presidents)] <- 0 # silly

smooth> summary(sm3 <- smooth(presidents, "3R"))
3R Tukey smoother resulting from
 smooth(x = presidents, kind = "3R") ;  n = 120 
 used 4 iterations
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    0.0    44.0    57.0    54.2    71.0    82.0 

smooth> summary(sm2 <- smooth(presidents,"3RSS"))
3RSS Tukey smoother resulting from
 smooth(x = presidents, kind = "3RSS") ;  n = 120 
 used 5 iterations
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
   0.00   44.00   57.00   55.45   69.00   82.00 

smooth> summary(sm  <- smooth(presidents))
3RS3R Tukey smoother resulting from
 smooth(x = presidents) ;  n = 120 
 used 7 iterations
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  24.00   44.00   57.00   55.88   69.00   82.00 

smooth> all.equal(c(sm2), c(smooth(smooth(sm3, "S"), "S")))  # 3RSS  === 3R S S
[1] TRUE

smooth> all.equal(c(sm),  c(smooth(smooth(sm3, "S"), "3R"))) # 3RS3R === 3R S 3R
[1] TRUE

smooth> plot(presidents, main = "smooth(presidents0, *) :  3R and default 3RS3R")
Hit <Return> to see next plot: 

smooth> lines(sm3, col = 3, lwd = 1.5)

smooth> lines(sm, col = 2, lwd = 1.25)

> ## Didactical investigation:
> 
> showSmooth <- function(x, leg.x = 1, leg.y = max(x)) {
+   ss <- cbind(x, "3c"  = smooth(x, "3", end="copy"),
+                  "3"   = smooth(x, "3"),
+                  "3Rc" = smooth(x, "3R", end="copy"),
+                  "3R"  = smooth(x, "3R"),
+               sm = smooth(x))
+   k <- ncol(ss) - 1
+   n <- length(x)
+   slwd <- c(1,1,4,1,3,2)
+   slty <- c(0, 2:(k+1))
+   matplot(ss, main = "Tukey Smoothers", ylab = "y ;  sm(y)",
+           type= c("p",rep("l",k)), pch= par("pch"), lwd= slwd, lty= slty)
+   legend(leg.x, leg.y,
+          c("Data",       "3   (copy)", "3  (Tukey)",
+                  "3R  (copy)", "3R (Tukey)", "smooth()"),
+          pch= c(par("pch"),rep(-1,k)), col=1:(k+1), lwd= slwd, lty= slty)
+   ss
+ }

> ## 4 simple didactical examples, showing different steps in smooth():
> 
> for(x in list(c(4, 6, 2, 2, 6, 3, 6, 6, 5, 2),
+               c(3, 2, 1, 4, 5, 1, 3, 2, 4, 5, 2),
+               c(2, 4, 2, 6, 1, 1, 2, 6, 3, 1, 6),
+               x1))
+     print(t(showSmooth(x)))
Hit <Return> to see next plot: 
    [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9] [,10]
x      4    6    2    2    6    3    6    6    5     2
3c     4    4    2    2    3    6    6    6    5     2
3      4    4    2    2    3    6    6    6    5     3
3Rc    4    4    2    2    3    6    6    6    5     2
3R     4    4    2    2    3    6    6    6    5     3
sm     4    4    4    3    3    6    6    6    5     3
Hit <Return> to see next plot: 
    [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9] [,10] [,11]
x      3    2    1    4    5    1    3    2    4     5     2
3c     3    2    2    4    4    3    2    3    4     4     2
3      2    2    2    4    4    3    2    3    4     4     4
3Rc    3    2    2    4    4    3    3    3    4     4     2
3R     2    2    2    4    4    3    3    3    4     4     4
sm     2    2    2    2    3    3    3    3    4     4     4
Hit <Return> to see next plot: 
    [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9] [,10] [,11]
x      2    4    2    6    1    1    2    6    3     1     6
3c     2    2    4    2    1    1    2    3    3     3     6
3      2    2    4    2    1    1    2    3    3     3     3
3Rc    2    2    2    2    1    1    2    3    3     3     6
3R     2    2    2    2    1    1    2    3    3     3     3
sm     2    2    2    2    2    2    2    3    3     3     3
Hit <Return> to see next plot: 
    [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9] [,10] [,11]
x      4    1    3    6    6    4    1    6    2     4     2
3c     4    3    3    6    6    4    4    2    4     2     2
3      3    3    3    6    6    4    4    2    4     2     2
3Rc    4    3    3    6    6    4    4    4    2     2     2
3R     3    3    3    6    6    4    4    4    2     2     2
sm     3    3    3    3    4    4    4    4    2     2     2
