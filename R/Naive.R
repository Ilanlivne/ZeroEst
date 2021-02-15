

naive <- function(X, Y) {
  W = as.data.frame(X)*Y
  mean_squared_W <- colMeans(W^2)              #calculate first element of beta_square_hat
  var_W <- sapply(W,var)                       #calculate the second element of beta
  beta_square_hat <- mean_squared_W - var_W    #calculate vector of beta2_hat
  return(sum(beta_square_hat))

}


