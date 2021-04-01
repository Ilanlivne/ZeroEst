
<!-- README.md is generated from README.Rmd. Please edit that file -->

# ZeroEst

<!-- badges: start -->
<!-- badges: end -->

The goal of ZeroEst is to provide set of functions to estimate the noise
level in a semi-supervised high dimensional regression model.

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
proposed_estimator(X,Y)
modified_estimator(X,Y)
```

You’ll still need to render `README.Rmd` regularly, to keep `README.md`
up-to-date. `devtools::build_readme()` is handy for this. You could also
use GitHub Actions to re-render `README.Rmd` every time you push. An
example workflow can be found here:
<https://github.com/r-lib/actions/tree/master/examples>.
