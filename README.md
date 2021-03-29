
<!-- README.md is generated from README.Rmd. Please edit that file -->

# ZeroEst

<!-- badges: start -->
<!-- badges: end -->

The goal of ZeroEst is to provide set of functions to estimate the noise
level in a semi-supervised high dimensional regression model. See details in https://arxiv.org/abs/2102.07203

## Installation

You can install from from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("Ilanlivne/ZeroEst")
```

## Example

This is a basic example which shows you how to calculate the naive and
proposed estimator:

``` r
library(ZeroEst)
## basic example code
n = 100
p = n
c = 10       #number of large betas
large = 5
small = 0.05
beta_range <- c(rep(small,p-c),rep(large, c) )
sigma2<- 1
X <- matrix(rnorm(n*p) ,nrow = n, ncol = p)
Y <- X %*% beta_range + rnorm(n, mean=0, sd=sqrt(sigma2))  # basic model
naive(X,Y)
#> [1] 491.8071
#> 270.4212
proposed_estimator(X,Y)
#> [1] 58.16238
#> 90.71639
```
