



#' Optimal modified coeffs
#' @keywords internal
#' @param X  matrix
#' @param Y vector
#' @param coef_vec a vector
#'
#' @return double
#' @export
#' @import tidyr
#' @import dplyr
#' @importFrom magrittr %>%
optimal_modified_coeff  <- function(X,Y,coef_vec = NULL) {
  j_1 <- j_2 <- NULL
  p = ncol(X)
  n = nrow(X)
  smp_size <- floor(0.5 * n)
  W = as.data.frame(X)*Y
  Y = as.data.frame(Y)
  ind <- sample(seq_len(n), size = smp_size) # randomly split the sample into two equal subsets:
  # covariate-selection subset and a subset for estimation of zero-estimators
  Y_1 <- Y[ind, ]
  X_1 <- X[ind, ]
  X_2 <- X[-ind, ]
  W_2 <- W[-ind, ]

  if (is.null(coef_vec)) {
    coef_vec <- selection_algoritm(X_1,Y_1)
  }

  df <- data.frame(j_1 = rep(1:p,each=p), j_2=rep(1:p,times=p))%>%
    dplyr::group_by(j_1, j_2) %>%
    dplyr::filter(j_1 %in% coef_vec & j_2 %in% coef_vec) %>%
    dplyr::mutate( psi_hat =  ifelse(j_1==j_2,func(W_2[,j_1],W_2[,j_2], X_2[,j_1]*X_2[,j_2]-1),
                                     func(W_2[,j_1],W_2[,j_2],X_2[,j_1]*X_2[,j_2])
    )  )

  return(sum(df$psi_hat))
}


#' Modified estimator
#'
#' @param X  matrix
#' @param Y vector
#' @param coef_vec a vector
#'
#' @return double
#' @export
#' @import tidyr
#' @import dplyr
#' @importFrom magrittr %>%
#' @examples
#' X <- matrix(rnorm(15),3,5)
#' Y <- c(2, 4.2, 5.8)
#' coef_vec <- c(1,2,3)
#' modified_estimator(X,Y,coef_vec)
#' @export
modified_estimator <- function(X,Y,coef_vec = NULL) {
  K=10
  phi=NA
  for (k in 1:K) {
    phi[k] <-  optimal_modified_coeff(X,Y,coef_vec)
  }
  return(ZeroEst::naive(X,Y) - 2*sum(phi)/K)

}
