# PUBLICATIONS.R
#
# This script builds a YAML list of publications based on the markdown files
# in content/research/.
#
# Ben Davies
# August 2019

# Load packages
library(dplyr)

# Initialise output
res <- list()

# Import publication data
data <- dir('content/research', '*.md', full.names = TRUE, recursive = TRUE) %>%
  lapply(function(x) rmarkdown::yaml_front_matter(x)) %>%
  bind_rows()

# Identify working papers
wp_data <- data %>%
  filter(publication_type == 'Working Paper') %>%
  arrange(desc(date))
res$working_papers <- list()
for (i in 1 : nrow(wp_data)) {
  res$working_papers[[i]] <- list(
    title = wp_data$title[i],
    coauthors = wp_data$coauthors[i]
  )
}

# Export data
paste0('---\n', yaml::as.yaml(res), '---\n') %>%
  readr::write_file('data/publications.yaml')
