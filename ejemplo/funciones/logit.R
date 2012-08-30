g <- function(x){
  ########################################################
  ## Aquí va tu código, que debe calcular u = logit(x)
  u <- 1/(1+exp(-x))
  
  #######################################################
  # Aquí termina tu código.
  
  return(u)
}