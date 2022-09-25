# BUILD_ONE.R
#
# This script defines the build_one function used in R/build.R.
#
# Ben Davies
# September 2022

local({
  a <- commandArgs(TRUE)
  d <- gsub("^(.*)/(.*?)[.][A-Za-z]+$", "\\1", a[1])
  knitr::opts_chunk$set(
    fig.path = "figures/",
    fig.cap = "",  # Remove default alt text
    cache.path = sprintf("%s/cache/", d)
  )
  knitr::opts_knit$set(
    base.dir = normalizePath(d, mustWork = TRUE),
    base.url = ""
  )
  set.seed(0)
  knitr::knit(a[1], a[2], quiet = TRUE, encoding = "UTF-8", envir = .GlobalEnv)
  if (file.exists(a[2])) {
    x <- xfun::read_utf8(a[2])
    y <- xfun::read_utf8(a[1])
    if (sum(grepl("```", y)) > 0 & sum(grepl("linkSource", y)) == 0) {
      x <- blogdown:::append_yaml(x, list(linkSource = TRUE))
    }
    x <- xfun::protect_math(x)
    if (sum(grepl("`(\\$\\$|\\\\\\()", x)) > 0 & sum(grepl("loadMathJax", y)) == 0) {
      x <- blogdown:::append_yaml(x, list(loadMathJax = TRUE))
    }
    x <- gsub("(\\\n){2,}", "\n\n", paste(x, collapse = "\n"))  # Excess \n's 
    x <- gsub("(\\\n)+$", "\n", x)  # EoF
    xfun::write_utf8(x, a[2])
  }
})
