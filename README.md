
<!-- README.md is generated from README.Rmd. Please edit that file -->

<!-- badges: start -->

[![Build
Status](https://github.com/dzhw/questionMetadataPreparation/workflows/Build%20and%20Deploy/badge.svg)](https://github.com/dzhw/questionMetadataPreparation/actions)
[![Coverage
status](https://codecov.io/github/dzhw/questionMetadataPreparation/branch/master/graph/badge.svg)](https://codecov.io/github/dzhw/questionMetadataPreparation?branch=master)
[![Lifecycle:
stable](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://www.tidyverse.org/lifecycle/#stable)
[![Documentation](https://img.shields.io/badge/documentation--brightgreen)](https://github.com/dzhw/FDZ_Allgemein/wiki/Fragen-2.0)
<!-- badges: end -->

# [Question Metadata Preparation](https://dzhw.github.io/questionMetadataPreparation/)

This [R](https://www.r-project.org/about.html) package ([Question
Metadata
Preparation](https://dzhw.github.io/questionMetadataPreparation/)) helps
preparing question-metadata for the [MDM](https://metadata.fdz.dzhw.eu)
of the research data center of the DZHW. If you do not work for the
research data center of the DZHW, this package will probably be only
useful for learning purposes, as it is specifically designed to help
with our internal processes.

## Installation for Users

If you are a Windows user you might need to install the
[Rtools](https://cran.r-project.org/bin/windows/Rtools/), in case one of
the dependencies is not available as a binary. Make sure to use the
correct – matching to the version of your R installation – version, not
necessarily the newest version.

You can install the released version of questionMetadataPreparation from
[Github](https://github.com/dzhw/questionMetadataPreparation) within
your [R](https://www.r-project.org/about.html) session:

``` r
install.packages("remotes", dependencies = TRUE)
remotes::install_github("dzhw/questionMetadataPreparation")
```

### After updating to a newer R version

In case you update R, first make sure to have the appropriate
[Rtools](https://cran.r-project.org/bin/windows/Rtools/) version
installed. Recently for example, R 4.0.0 was released, so you have to
make sure to use `rtools40-x86_64.exe`. Afterwards, perform the
installation process from above again. In case there’s an error that the
package/library `$X` is not available, install this package manually:
`install.packages("$X", type="source")` and replace `$X` with the
package that caused the error (e.g. `backports`). It might be required
to run `update.packages(repos='http://cran.rstudio.com/', ask=FALSE,
checkBuilt=TRUE)`.

## Installation of development version

Developers need to setup the R devtools on their machine.

``` r
install.packages("devtools", dependencies = TRUE)
devtools::install_github("dzhw/questionMetadataPreparation")
```

After setting up devtools you can install all required R packages with

``` bash
R -e 'devtools::install_deps(dep = T)'
```

During development you should start an R session in the project root in
order to run:

``` r
devtools::load_all() # loads the project from the current directory
devtools::install() # installs the project from the current directory
devtools::test() # runs the test_that tests
```

You can build the package on you local machine with

``` bash
R CMD build .
```

Before pushing to Github (and thus kicking of CI) you should run

``` bash
R CMD check *tar.gz
```

# Usefull links, further documentation

  - [Further
    Documentation](https://github.com/dzhw/FDZ_Allgemein/wiki/Fragen-2.0)

## Having trouble?

Please file an issue in our [issue
tracker](https://github.com/dzhw/metadatamanagement/issues)
