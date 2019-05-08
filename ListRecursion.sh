#!/bin/bash
while true; do ls -R /; sleep .5; done ## This alows you to see the recursive list Forever
##Here is the R code to graph the output  
#!/bin/bash
##this is R code 
##recursion library 
area <- function(f, a, b, ..., limit=10, eps=1e-5) {
+     area2 <- function(f, a, b, ..., fa = f(a, ...), fb = f(b, ...),
+ 		      limit = limit, eps = eps) {
+ 	h <- b - a
+ 	d <- (a + b)/2
+ 	fd <- f(d, ...)
+ 	a1 <- ((fa + fb) * h)/2
+ 	a2 <- ((fa + 4 * fd + fb) * h)/6
+ 	if(abs(a1 - a2) < eps)
+ 	    return(a2)
+ 	if(limit == 0) {
+ 	    warning(paste("iteration limit reached near x =", d))
+ 	    return(a2)
+ 	}
+ 	area2(f, a, d, ..., fa = fa, fb = fd, limit = limit - 1,
+ 	      eps = eps) + area2(f, d, b, ..., fa = fd, fb =
+ 	      fb, limit = limit - 1, eps = eps)
+     }
+     area2(f, a, b, ..., limit=limit, eps=eps)
+ }

