# BUILD_ONE.R
#
# This script defines the build_one function used in R/build.R.
#
# Ben Davies
# June 2019

local({
  a <- commandArgs(TRUE)
  d <- gsub("^content/", "", a[1])
  d <- gsub("^([0-9]+-[0-9]+-[0-9]+-)?(.*?)[.][A-Za-z]+$", "\\2", d)  # Isolate slug
  knitr::opts_chunk$set(
    fig.path = sprintf("%s/", d),
    fig.cap = "",  # Remove default alt text
    cache.path = sprintf("%s/cache/", d)
  )
  knitr::opts_knit$set(
    base.dir = normalizePath('static/', mustWork = TRUE),
    base.url = '/'
  )
  set.seed(0)
  knitr::knit(a[1], a[2], quiet = TRUE, encoding = "UTF-8", envir = .GlobalEnv)
})
