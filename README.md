# svGUI

[![Linux & OSX Build Status](https://travis-ci.org/SciViews/svGUI.svg )](https://travis-ci.org/SciViews/svGUI)
[![Win Build Status](https://ci.appveyor.com/api/projects/status/github/SciViews/svGUI?branch=master&svg=true)](http://ci.appveyor.com/project/phgrosjean/svGUI)
[![Coverage Status](https://img.shields.io/codecov/c/github/SciViews/svGUI/master.svg)
](https://codecov.io/github/SciViews/svGUI?branch=master)
[![CRAN Status](http://www.r-pkg.org/badges/version/svGUI)](http://cran.r-project.org/package=svGUI)
[![License](https://img.shields.io/badge/license-GPL-blue.svg)](http://www.gnu.org/licenses/gpl-2.0.html)

Basic GUI functions for SciViews.

The [R-Forge version](https://r-forge.r-project.org/projects/sciviews/)) is moved to Github on 2016-03-17 (SVN version 569). **Please, do not use R-forge anymore for SciViews development, use this Github repository instead.**


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

Use `install_github()` to install the **svGUI** package from Github (master branch):

```r
devtools::install_github("SciViews/svGUI")
```

R should install all required dependencies automatically, and then it should compile and install **svGUI**.

Latest devel version in source and Windows binaires formats also available from [appveyor](https://ci.appveyor.com/project/phgrosjean/svGUI/build/artifacts).


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
