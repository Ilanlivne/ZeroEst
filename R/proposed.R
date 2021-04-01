#' triple mean
#'
#' @param X vector length n
#' @param Y vector length n
#' @param Z vector length n
#'
#' @return double
#' @export
#' @examples
#'  func(seq(1,10,length = 50), seq(1,20,length = 50),seq(1,30,length = 50))


#' @useDynLib ZeroEst
#' @importFrom Rcpp sourceCpp
NULL
#> NULL





#' Selection algorithm
#' @keywords internal
#' @param X  matrix
#' @param Y vector
#'
#' @return double
#' @export
#' @import tidyr
#' @import dplyr
#' @importFrom magrittr %>%
#' @examples
#' X<-matrix(rnorm(15),3,5)
#' Y<-c(2, 4.2, 5.8)
#' selection_algoritm(X,Y)
selection_algoritm <- function(X,Y){
  max_diff <- index <- lag_1 <- NULL
  p=ncol(X)
  # step 1: calculate \hat\beta_j^2 for j=1,...,p:
  W_3 = as.data.frame(X)*Y
  mean_squared_W<- colMeans(W_3^2)  #calculate first element of beta_square_hat
  var_W<-sapply(W_3,var) # #calculate the second element of beta
  beta_square_hat<- mean_squared_W - var_W # calculate vector of beta2_hat
  # step2:  calculate the differences lamda_j for j=2,...,p:
  dt <- data.frame(  j = 1:p,  beta_square_hat   ) %>% dplyr::arrange(beta_square_hat) %>%
    dplyr::mutate( index = 1:dplyr::n(),  lag_1 = dplyr::lag(beta_square_hat),
            diff = beta_square_hat - lag_1
    ) %>% dplyr::select(-lag_1) %>% dplyr::filter(diff != "NA")
  #step 3: Select the covariates of B_gamma.
  #calculate  j_star:
  index_star = dt %>%  dplyr::mutate(max_diff = max(diff, na.rm = T)) %>%
    dplyr::filter(diff == max_diff) %>% dplyr::select(index) %>% unlist()
  if (p-index_star<2) {
    index_star = index_star  %>% unlist()-1
  }
  dt<- dt %>% dplyr::mutate(pred =dplyr::if_else(index >= index_star,"big","small"))
  return(dt[which(dt$pred=='big'),1])
}






#' proposed estimator
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
#' proposed_estimator(X,Y,coef_vec)
proposed_estimator <- function(X,Y,coef_vec = NULL) {
  j_1 <- j_2 <- lag_1 <-  NULL
 if (is.null(coef_vec)) {
   coef_vec <- selection_algoritm(X,Y)
 }
  p = ncol(X)
  W = as.data.frame(X)*Y
  df <- data.frame(j_1 = rep(1:p,each=p), j_2=rep(1:p,times=p))%>%
    dplyr::group_by(j_1, j_2) %>%
    dplyr::filter(j_1 %in% coef_vec & j_2 %in% coef_vec) %>%
    dplyr::mutate( psi_hat =  ifelse (j_1 == j_2, func(W[,j_1],W[,j_2], X[,j_1]*X[,j_2]-1),
                               func(W[,j_1],W[,j_2],X[,j_1]*X[,j_2])
    )  )
  T_proposed_estimator <- sum(df$psi_hat)
  return(ZeroEst::naive(X,Y) - 2 * T_proposed_estimator)
}


