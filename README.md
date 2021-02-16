
<!-- README.md is generated from README.Rmd. Please edit that file -->

# ZeroEst

<!-- badges: start -->
<!-- badges: end -->

The goal of ZeroEst is to provide set of functions to estimate the noise level in a semi-supervised high dimensional regression model.

## Installation

<!-- You can install the released version of ZeroEst from
[CRAN](https://CRAN.R-project.org) with: 

``` r
install.packages("ZeroEst")
```-->

You can install from  [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("Ilanlivne/ZeroEst")
```

## Example

This is a basic example which shows you how to calculate the naive and proposed estimator

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
#> 270.4212
proposed_estimator(X,Y)
#> 90.71639
```
<!--
What is special about using `README.Rmd` instead of just `README.md`?
You can include R chunks like so:

``` r
naive(X,Y)
#> 270.4212
 proposed_estimator(X,Y)
#> 90.71639
```
-->
<!--
You’ll still need to render `README.Rmd` regularly, to keep `README.md`
up-to-date. `devtools::build_readme()` is handy for this. You could also
use GitHub Actions to re-render `README.Rmd` every time you push. An
example workflow can be found here:
<https://github.com/r-lib/actions/tree/master/examples>.

You can also embed plots, for example:

<img src="man/figures/README-pressure-1.png" width="100%" />

In that case, don’t forget to commit and push the resulting figure
files, so they display on GitHub and CRAN.
-->
