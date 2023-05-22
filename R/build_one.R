# BUILD_ONE.R
#
# This script defines the build_one function used in R/build.R.
#
# Ben Davies
# May 2023

local({
  
  # Get input arguments
  a = commandArgs(T)
  
  # Extract post directory
  post_dir = gsub("^(.*)/(.*?)[.][A-Za-z]+$", "\\1", a[1])
  
  # Set knitr options
  knitr::opts_chunk$set(
    fig.path = "figures/",
    fig.cap = "",  # Remove default alt text
    cache.path = sprintf("%s/cache/", post_dir)
  )
  knitr::opts_knit$set(
    base.dir = normalizePath(post_dir, mustWork = T),
    base.url = ""
  )
  
  # Knit to md
  set.seed(0)
  knitr::knit(a[1], a[2], quiet = T, encoding = "UTF-8", envir = .GlobalEnv)
  
  # Post-process knitted file
  if (file.exists(a[2])) {
    
    # Read Rmd source and knitted md file
    infile = xfun::read_utf8(a[1])
    outfile = xfun::read_utf8(a[2])
    
    # Add linkSource to YAML header if Rmd source contains code block
    if (sum(grepl("```", infile)) > 0 & sum(grepl("linkSource", infile)) == 0) {
      outfile = blogdown:::append_yaml(outfile, list(linkSource = T))
    }
    
    # Set up MathJax
    outfile = xfun::protect_math(outfile)
    if (sum(grepl("`(\\$\\$|\\\\\\()", outfile)) > 0 & sum(grepl("loadMathJax", infile)) == 0) {
      outfile = blogdown:::append_yaml(outfile, list(loadMathJax = T))
    }
    
    # Remove excess whitespace
    outfile = gsub("(\\\n){2,}", "\n\n", paste(outfile, collapse = "\n"))
    outfile = gsub("(\\\n)+$", "\n", outfile)
    
    # Save post-processed file
    xfun::write_utf8(outfile, a[2])
    
  }
})
