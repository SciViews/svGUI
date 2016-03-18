# svGUI

[![Linux & OSX Build Status](https://travis-ci.org/SciViews/svGUI.svg )](https://travis-ci.org/SciViews/svGUI)
[![Win Build Status](https://ci.appveyor.com/api/projects/status/github/SciViews/svGUI?branch=master&svg=true)](http://ci.appveyor.com/project/phgrosjean/svGUI)
[![Coverage Status](https://img.shields.io/codecov/c/github/SciViews/svGUI/master.svg)
](https://codecov.io/github/SciViews/svGUI?branch=master)
[![CRAN Status](http://www.r-pkg.org/badges/version/svGUI)](http://cran.r-project.org/package=svGUI)
[![License](https://img.shields.io/badge/license-GPL-blue.svg)](http://www.gnu.org/licenses/gpl-2.0.html)

SciViews - functions to manage GUIs in R.

_Build badges are as follows._
- _Status for latest stable R version for both Linux and Mac OS X at left._
- _Status for the devel version of R under Windows at right._ 


## Installation

### Latest stable version

The latest stable version of **svGUI** can simply be installed from [CRAN](http://cran.r-project.org):

```r
install.packages("svGUI")
```


### Development version

Make sure you have the **devtools** R package installed:

```r
install.packages("devtools")
```

Use `install_github()` to install the **svGUI** package from Github (source from **master** branch will be recompiled on your machine):

```r
devtools::install_github("SciViews/svGUI")
```

R should install all required dependencies automatically, and then it should compile and install **svGUI**.

Latest devel version of **svGUI** (source + Windows binaires for the devel version of R) is also available from [appveyor](https://ci.appveyor.com/project/phgrosjean/svGUI/build/artifacts).


## Usage

Make the **svGUI** package available in your R session:

```r
library("svGUI")
```

Get help about this package:

```r
library(help = "svGUI")
help("svGUI-package")
```

For further instructions, please, refer to these help pages.


## Note to developers

This package used to be developed on R-Forge in the past. However, the latest [R-Forge version](https://r-forge.r-project.org/projects/sciviews/) was moved to this Github repository on 2016-03-17 (SVN version 569). **Please, do not use R-Forge anymore for SciViews development, use this Github repository instead.**
