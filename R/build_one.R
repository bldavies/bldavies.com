# BUILD_ONE.R
#
# This script defines the build_one function used in R/build.R.
#
# Ben Davies
# July 2019

local({
  a <- commandArgs(TRUE)
  d <- gsub("^(.*)/(.*?)[.][A-Za-z]+$", "\\1", a[1])
  knitr::opts_chunk$set(
    fig.path = "",
    fig.cap = "",  # Remove default alt text
    cache.path = "cache/"
  )
  knitr::opts_knit$set(
    base.dir = normalizePath(d, mustWork = TRUE),
    base.url = ""
  )
  set.seed(0)
  knitr::knit(a[1], a[2], quiet = TRUE, encoding = "UTF-8", envir = .GlobalEnv)
})
