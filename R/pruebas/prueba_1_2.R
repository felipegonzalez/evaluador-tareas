library(boot)

prueba_1_2 <- function(fun, fun_solucion){
  error.1 <- FALSE
  y <- c(1,0)
  X <- matrix(c(1,2), ncol=1)
  eval.1 <- fun(y=y, X=X)
  eval.correcto <- fun_solucion(y=y, X=X)
  resultado.1 <- class(eval.1)=='function'
  resultado.2 <- abs(eval.1(2) - eval.correcto(2)) < 0.001
  resultado.3 <- abs(eval.1(-4) - eval.correcto(-4)) < 0.001
  error.1 <- !(resultado.1&resultado.2&resultado.3)
  error.1
}

