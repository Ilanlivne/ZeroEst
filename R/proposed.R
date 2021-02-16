


#' triple mean
#'
#' @param X vector length n
#' @param Y vector length n
#' @param Z vector length n
#'
#' @return
#' @export
#' @examples
#'  func(seq(1,10,length = 50), seq(1,20,length = 50),seq(1,30,length = 50))
func<-function(X,Y,Z) {
  n=length(X)
  A=X %o% Y %o% Z
  (sum(A)-sum(apply(A, 1, diag))-sum(apply(A, 2, diag))-sum(apply(A, 3, diag))+2*sum(A[ cbind(1:n,1:n,1:n) ]))/(n*(n-1)*(n-2))
}




#' proposed estimator
#'
#' @param X  matrix
#' @param Y vector
#' @param coef_vecvector a vector
#'
#' @return
#' @export
#' @importFrom magrittr %>%
#' @examples
#' X <- matrix(rnorm(15),3,5)
#' Y <- c(2, 4.2, 5.8)
#' coef_vec <- c(1,2,3)
#' proposed_estimator(X,Y,coef_vec)
proposed_estimator <- function(X,Y,coef_vec) {
  p = ncol(X)
  W = as.data.frame(X)*Y
  df <- data.frame(j_1 = rep(1:p,each=p), j_2=rep(1:p,times=p))%>%
    dplyr::group_by(j_1, j_2) %>%
    dplyr::filter(j_1 %in% coef_vec & j_2 %in% coef_vec) %>%
    dplyr::mutate( psi_hat =  ifelse (j_1 == j_2, func(W[,j_1],W[,j_2], X[,j_1]*X[,j_2]-1),
                               func(W[,j_1],W[,j_2],X[,j_1]*X[,j_2])
    )  )
  return(sum(df$psi_hat))
}
