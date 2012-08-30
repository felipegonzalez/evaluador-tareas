descenso <- function(perdida, gradiente, inicio, step, n.iter){
  
  theta.iter <- list()
  theta.iter[[1]] <- inicio
  
  ########################################################
  ## Aquí va tu código, que debe calcula una
  ## theta.iter (lista), donde cada componente es un
  ## vector de parámetros
  ## y J.iter con los valores de la pérdida evaluada en las
  ## iteraciones
  
  if(n.iter > 1){
    for(i in 2:n.iter){
      theta.iter[[i]] <- theta.iter[[i-1]] - step * as.numeric(gradiente(theta.iter[[i-1]]))
    }  
  }
  
  J.iter <- sapply(theta.iter, perdida)
  
  ###########################################################
  ## Aquí termina tu código
  list(theta= theta.iter, J = J.iter )
}
