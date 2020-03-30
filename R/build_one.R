# BUILD_ONE.R
#
# This script defines the build_one function used in R/build.R.
#
# Ben Davies
# March 2020

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
    x <- xfun::read_utf8(a[2])
    y <- xfun::read_utf8(a[1])
    if (sum(grepl('```', y)) > 0 & sum(grepl('linkSource', y)) == 0) {
      x <- blogdown:::append_yaml(x, list(linkSource = TRUE))
    }
    x <- gsub("(\\\n){2,}", "\n\n", paste(x, collapse = "\n"))  # Excess \n's 
    x <- gsub("(\\\n)+$", "\n", x)  # EoF
    x <- xfun::protect_math(x)
    xfun::write_utf8(x, a[2])
  }
})
