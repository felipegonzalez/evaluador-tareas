descenso <- function(perdida, gradiente, inicio, step, n.iter){
  theta.iter <- list()
  theta.iter[[1]] <- inicio
  if(n.iter > 1){
    for(i in 2:n.iter){
      theta.iter[[i]] <- theta.iter[[i-1]] - step * as.numeric(gradiente(theta.iter[[i-1]]))
    }  
  }
  J.iter <- sapply(theta.iter, perdida)
  list(theta= theta.iter, J = J.iter )
}