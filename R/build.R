# BUILD.R
#
# This script is called by blogdown::build_site(method = "custom"). It compiles
# each Rmd file in content/ as an md file.
#
# Ben Davies
# June 2019

# Define build_one function
build_one <- function(io)  {
  if (!blogdown:::require_rebuild(io[2], io[1])) return()  # Skip compilation if input older than output
  message('* knitting ', io[1])
  if (xfun::Rscript(shQuote(c('R/build_one.R', io))) != 0) {
    unlink(io[2])
    stop('Failed to compile ', io[1], ' to ', io[2])
  }
}

# Identify files
rmds <- list.files("content", "[.]Rmd$", recursive = TRUE, full.names = TRUE)
files <- cbind(rmds, blogdown:::with_ext(rmds, ".md"))

# Build files
for (i in 1 : nrow(files)) build_one(files[i, ])
