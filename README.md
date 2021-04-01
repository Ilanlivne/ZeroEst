
<!-- README.md is generated from README.Rmd. Please edit that file -->

# ZeroEst

<!-- badges: start -->
<!-- badges: end -->

The goal of ZeroEst is to provide set of functions to estimate the noise
level in a semi-supervised high dimensional regression model. See more
details here: <https://arxiv.org/abs/2102.07203>

## Installation

You can install from from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("Ilanlivne/ZeroEst")
```

## Example

This is a basic example which shows you how to calculate the naive,
proposed and modified estimators:

``` r
library(ZeroEst)
set.seed(1)
n = 100
p = n
c = 5    #number of large betas
large = 1
small = 0.05
beta_range <- c(rep(small,p-c),rep(large, c) )
sigma2<- 1
X <- matrix(rnorm(n*p) ,nrow = n, ncol = p)
Y <- X %*% beta_range + rnorm(n, mean=0, sd=sqrt(sigma2))  
 
Naive(X,Y)
[1] 5.489833
proposed_estimator(X,Y)
[1] 4.820103
modified_estimator(X,Y)
[1] 5.796899
```
