# svGUI

<!-- badges: start -->

[![R-CMD-check](https://github.com/SciViews/svGUI/workflows/R-CMD-check/badge.svg)](https://github.com/SciViews/svGUI/actions) [![Win build status](https://ci.appveyor.com/api/projects/status/github/SciViews/svGUI?branch=master&svg=true)](https://ci.appveyor.com/project/phgrosjean/svGUI) [![Coverage status](https://img.shields.io/codecov/c/github/SciViews/svGUI/master.svg)](https://codecov.io/github/SciViews/svGUI?branch=master) [![CRAN status](https://www.r-pkg.org/badges/version/svGUI)](https://cran.r-project.org/package=svGUI) [![License](https://img.shields.io/badge/license-GPL-blue.svg)](https://www.gnu.org/licenses/gpl-2.0.html) [![Lifecycle: stable](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://www.tidyverse.org/lifecycle/#stable)

<!-- badges: end -->

{svGUI} provides a general mechanism to implement GUIs in R, including own storage environment, and information on the GUI status. For instance, one would know if a dialog box is displayed, is modal, or what was the result of the last dialog box used. Moreover, a mechanisms to use fallback in case the desired GUI is not available (for instance, by using a textuyal version of the dialog box) is also implemented. To look at an example of use, see the [{svDialogs}](https://github.com/SciViews/svDialogs) R package.

## Installation

You can install the released version of {svGUI} from [CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("svGUI")
```

You can also install the latest development version. Make sure you have the {remotes} R package installed:

``` r
install.packages("remotes")
```

Use `install_github()` to install the {svGUI} package from GitHub (source from **master** branch will be recompiled on your machine):

``` r
remotes::install_github("SciViews/svGUI")
```

R should install all required dependencies automatically, and then it should compile and install {svGUI}.

Latest devel version of {svGUI} (source + Windows binaries for the latest stable version of R at the time of compilation) is also available from [appveyor](https://ci.appveyor.com/project/phgrosjean/svGUI/build/artifacts).

## Usage

You can get further help about this package this way: Make the {svGUI} package available in your R session:

``` r
library("svGUI")
```

Get help about this package:

``` r
library(help = "svGUI")
help("svGUI-package")
vignette("svGUI") # None is installed with install_github()
```

For further instructions, please, refer to the help pages at <https://www.sciviews.org/svGUI/>.

## Code of Conduct

Please note that the svGUI project is released with a [Contributor Code of Conduct](https://contributor-covenant.org/version/2/0/CODE_OF_CONDUCT.html). By contributing to this project, you agree to abide by its terms.

## Note to developers

This package used to be developed on R-Forge in the past. However, the latest [R-Forge version](https://r-forge.r-project.org/projects/sciviews/) was moved to this GitHub repository on 2016-03-17 (SVN version 569). **Please, do not use R-Forge anymore for SciViews development, use this GitHub repository instead.**
