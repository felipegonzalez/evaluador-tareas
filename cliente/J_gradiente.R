# Tarea 1 ejercicio.
# Cid Reyes

 J.grad <- function(y,X){
   function(theta){
    h <- inv.logit(X %*% as.matrix(theta))
    -(1/nrow(X))* t(X) %*% (h-y)
   }
 }
