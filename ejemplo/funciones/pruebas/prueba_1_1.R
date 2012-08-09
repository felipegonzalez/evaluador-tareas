prueba_1_1 <- function(fun, fun_solucion){
  error.1 <- FALSE
  resultado.1 <- class(fun)=='function'
  resultado.2 <- abs(fun(2) - fun_solucion)  < 0.001
  error.1 <- !(resultado.1&resultado.2)
  error.1
}
