# BUILD_ONE.R
#
# This script defines the build_one function used in R/build.R.
#
# Ben Davies
# December 2019

local({
  a <- commandArgs(TRUE)
  d <- gsub("^(.*)/(.*?)[.][A-Za-z]+$", "\\1", a[1])
  knitr::opts_chunk$set(
    fig.path = "figures/",
    fig.cap = "",  # Remove default alt text
    cache.path = "cache/"
  )
  knitr::opts_knit$set(
    base.dir = normalizePath(d, mustWork = TRUE),
    base.url = ""
  )
  set.seed(0)
  knitr::knit(a[1], a[2], quiet = TRUE, encoding = "UTF-8", envir = .GlobalEnv)
  if (file.exists(a[2])) {
    x <- blogdown:::append_yaml(
      xfun::read_utf8(a[2]), list(from_Rmd = TRUE)
    )
    xfun::write_utf8(x, a[2])
  }
})
