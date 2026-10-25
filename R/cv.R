# CV.R
#
# This script builds my CV using data from data/cv.yaml and data/research.yaml.
#
# Ben Davies
# October 2026


# Initialization ----

# Load packages
library(dplyr)
library(lubridate)
library(purrr)
library(tidyr)
library(yaml)

# Define function for constructing date ranges
get_period = function(start_date, end_date) {
  x = year(start_date)
  y = year(end_date)
  ifelse(is.na(y), paste0(x, '--present'), ifelse(x < y, paste0(x, '--', y - 2000), x))
}

# Define preamble
preamble = '\\documentclass[11pt,oneside]{memoir}

\\title{Curriculum Vitae}
\\author{Benjamin Davies}
\\date{\\today}

\\usepackage{mathpazo}
\\usepackage[T1]{fontenc}
\\usepackage[utf8]{inputenc}
\\usepackage[margin=0.5in]{geometry}
\\usepackage[colorlinks,urlcolor=blue]{hyperref}
\\usepackage{titlesec}

\\linespread{1.15}
\\pagestyle{empty}
\\raggedright
\\setlength{\\parindent}{0pt}
\\setsecnumdepth{part}
\\titleformat{\\section}{\\large\\bfseries}{}{}{}[\\titlerule]
\\titleformat{\\subsection}{\\bfseries}{}{}{}
\\titlespacing{\\section}{0pt}{1.5em}{1em}
\\titlespacing{\\subsection}{0pt}{1em}{0pt}

\\newcommand{\\entry}[1]{\\par\\hangindent=0.25in #1.}'

# Define header
header = c(
  preamble,
  '',
  '\\begin{document}',
  ''
)

# Define footer
footer = c(
  '',
  '\\end{document}'
)


# Body ----

## Non-research ----

# Import data
indata = read_yaml('data/cv.yaml')

# Address
address_tex = indata$coordinates$address %>%
  paste(collapse = ', ')

# Email
email_tex = indata$coordinates$email %>%
  {sprintf('\\href{mailto:%s}{%s}', ., .)}

# Website
website_tex = indata$coordinates$website %>%
  {sprintf('\\href{https://%s}{%s}', ., .)}

# Awards
award_lines = indata$awards %>%
  bind_rows() %>%
  mutate(tex = sprintf('\\entry{%s, %s}', description, year)) %>%
  pull(tex)

# Research and professional experience
experience_lines = indata$experience %>%
  lapply(function(x) {
    x$roles %>%
      bind_rows() %>%
      mutate(employer = x$employer)
  }) %>%
  bind_rows() %>%
  arrange(desc(start_date)) %>%
  mutate(period = map2_chr(start_date, end_date, get_period),
         tex = sprintf('\\entry{%s, %s, %s}', title, employer, period)) %>%
  pull(tex)

# Teaching experience
teaching_lines = indata$teaching %>%
  lapply(function(x) {
    institution = ifelse('note' %in% names(x), sprintf('{\\bfseries %s} (%s)', x$institution, x$note), sprintf('{\\bfseries %s}', x$institution))
    courses = x$courses %>%
      bind_rows() %>%
      distinct(title) %>%
      {paste(sort(.$title), collapse = '; ')}
    sprintf('\\entry{%s: %s}', institution, courses)
  }) %>%
  unlist()

# Presentations
presentation_lines = indata$presentations %>%
  bind_rows() %>%
  mutate(year = year(date),
         text = ifelse(!is.na(location), sprintf('%s, %s', venue, location), venue)) %>%
  group_by(year) %>%
  arrange(venue) %>%
  summarise(list = paste(text, collapse = '; ')) %>%
  ungroup() %>%
  arrange(desc(year)) %>%
  mutate(tex = sprintf('\\entry{{\\bfseries %s}: %s}', year, list)) %>%
  pull(tex)


## Research ----

# Prepare data
research_data = read_yaml('data/research.yaml') %>%
  bind_rows() %>%
  arrange(desc(date)) %>%
  mutate(coauthors = gsub('\\[([^]]+)\\]\\([^)]*\\)', '\\1', coauthors),  # Remove URLs
         title = paste0(ifelse(grepl('http', url), sprintf('\\href{%s}{%s}', url, title), title)),
         text = paste0('``',
                       title,
                       ifelse(!is.na(coauthors), sprintf("'' (with %s), ", coauthors), ",'' "),
                       ifelse(!is.na(outlet), sprintf('{\\itshape %s}, ', outlet), ''),
                       year(date)),
         tex = sprintf('\\entry{%s}', text))

# Publications
publication_lines = research_data %>%
  filter(type == 'pub') %>%
  pull(tex)

# Working papers
working_paper_lines = research_data %>%
  filter(type == 'wp') %>%
  pull(tex)


## Collation ----

body = c(
  '\\begin{center}',
  paste('\t', c(
    '{\\Large\\bfseries\\theauthor} \\\\',
    '\\vskip0.5em',
    paste(address_tex, '\\\\'),
    paste(email_tex, '|', website_tex)
  )),
  '\\end{center}',
  '',
  '\\section{Education}',
  '',
  '\\entry{PhD in Economics, Stanford University, 2020--27 (expected)}',
  '\\entry{BSc(Hons, 1st class) in Economics and Mathematics, University of Canterbury, 2014--17}',
  '',
  '\\section{Publications}',
  '',
  publication_lines,
  '',
  {
    if (length(working_paper_lines) > 0) {
      c(
        '\\section{Working Papers}',
        '',
        working_paper_lines,
        ''
      )
    } else {
      c()
    }
  },
  '\\section{Awards}',
  '',
  award_lines,
  '',
  '\\section{Research and Professional Experience}',
  '',
  experience_lines,
  '',
  '\\section{Teaching Experience}',
  '',
  teaching_lines,
  '',
  # '\\section{Seminars and Conference Presentations}',
  # '',
  # presentation_lines,
  # '',
  '\\vfill\\hfill{\\itshape\\small Last updated: \\today}'
)


# Compilation ----

writeLines(c(header, body, footer), 'static/cv.tex')
system('pdflatex -output-directory static static/cv.tex')
system('rm static/cv.aux static/cv.log static/cv.out')
