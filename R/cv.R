# CV.R
#
# This script builds my CV using data from data/cv.yaml and data/research.yaml.
#
# Ben Davies
# March 2025


# Initialization ----

# Load packages
library(dplyr)
library(lubridate)
library(yaml)

# Define function for constructing date ranges
get_period = function(start_date, end_date) {
  x = year(start_date)
  y = year(end_date)
  ifelse(is.na(y), paste0(x, '--'), ifelse(x < y, paste0(x, '--', y - 2000), x))
}

# Define preamble
preamble = '\\documentclass[11pt,oneside]{memoir}

\\title{Curriculum Vitae}
\\author{Benjamin Davies}
\\date{\\today}

\\usepackage{mathpazo}
\\usepackage[T1]{fontenc}
\\usepackage[utf8]{inputenc}
\\usepackage[margin=1in,includefoot]{geometry}
\\usepackage[colorlinks,urlcolor=blue]{hyperref}
\\usepackage{titlesec}

\\makeevenfoot{plain}{\\today}{}{Page~\\thepage\\ of~\\thelastpage}
\\makeoddfoot{plain}{\\today}{}{Page~\\thepage\\ of~\\thelastpage}
\\OnehalfSpacing
\\pagestyle{plain}
\\raggedright
\\setlength{\\parindent}{0pt}
\\setsecnumdepth{part}
\\titleformat{\\chapter}{\\Large\\bfseries}{}{}{\\MakeUppercase}[\\titlerule]
\\titleformat{\\section}{\\large\\bfseries}{}{}{}[\\titlerule]
\\titleformat{\\subsection}{\\bfseries}{}{}{}
\\titlespacing{\\chapter}{0pt}{-2em}{1em}
\\titlespacing{\\section}{0pt}{2em}{1em}
\\titlespacing{\\subsection}{0pt}{1em}{0pt}

\\newcommand{\\entry}[2]{\\par\\parbox[t]{0.9\\linewidth}{\\strut\\raggedright\\hangindent=2em #2\\strut}\\hfill#1}'

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

# Import data
indata = read_yaml('data/cv.yaml')


## Education ----

# Extract data
education_data = indata$education %>%
  lapply(function(x) {
    x$degrees %>%
      bind_rows() %>%
      mutate(institution = x$institution)
  }) %>%
  bind_rows() %>%
  group_by(institution) %>%
  mutate(min_start_date = min(start_date),
         degree_pos = dense_rank(desc(start_date))) %>%
  ungroup() %>%
  mutate(institution_pos = dense_rank(desc(min_start_date)))

# Initialize lines
education_lines = c()

# Create institution headings
institution_lines = education_data %>%
  distinct(institution_pos, institution) %>%
  arrange(institution_pos) %>%
  mutate(line = sprintf('\\subsection{%s}', institution)) %>%
  {.$line}

# Iterate over institutions
for (i in seq_along(institution_lines)) {
  
  # Create degree list
  degree_lines = education_data %>%
    filter(institution_pos == i) %>%
    arrange(degree_pos) %>%
    mutate(line = sprintf('\\entry{%s}{%s}', get_period(start_date, end_date), title)) %>%
    {.$line}
  
  # Update lines
  education_lines = c(
    education_lines,
    '',
    institution_lines[i],
    degree_lines
  )
  
}


## Experience ----

# Extract data
experience_data = indata$experience %>%
  lapply(function(x) {
    x$roles %>%
      bind_rows() %>%
      mutate(employer = x$employer)
  }) %>%
  bind_rows() %>%
  group_by(employer) %>%
  mutate(min_start_date = min(start_date),
         role_pos = dense_rank(desc(start_date))) %>%
  ungroup() %>%
  mutate(employer_pos = dense_rank(desc(min_start_date)))

# Initialize lines
experience_lines = c()

# Create employer headings
employer_lines = experience_data %>%
  distinct(employer_pos, employer) %>%
  arrange(employer_pos) %>%
  mutate(line = sprintf('\\subsection{%s}', employer)) %>%
  {.$line}

# Iterate over employers
for (i in seq_along(employer_lines)) {
  
  # Create degree list
  role_lines = experience_data %>%
    filter(employer_pos == i) %>%
    arrange(role_pos) %>%
    mutate(line = sprintf('\\entry{%s}{%s}', get_period(start_date, end_date), title)) %>%
    {.$line}
  
  # Update lines
  experience_lines = c(
    experience_lines,
    '',
    employer_lines[i],
    role_lines
  )
  
}


## Awards ----

# Create lines
award_lines = indata$awards %>%
  bind_rows() %>%
  mutate(line = sprintf('\\entry{%s}{%s}', year, description)) %>%
  {.$line}


## Research ----

# Extract data
research_data = read_yaml('data/research.yaml') %>%
  bind_rows() %>%
  arrange(desc(date)) %>%
  mutate(headline = paste0(ifelse(grepl('http', url), sprintf('\\href{%s}{%s}', url, title), title),
                           ifelse(!is.na(coauthors), sprintf(' (with %s)', coauthors), '')))

# Create publication lines
publication_lines = research_data %>%
  filter(type == 'pub') %>%
  mutate(line = sprintf('\\entry{%s}{%s, \\emph{%s}}', year(date), headline, gsub('[*]', '', outlet))) %>%
  {.$line}

# Create working paper lines
working_paper_lines = research_data %>%
  filter(type == 'wp') %>%
  mutate(line = sprintf('\\entry{%s}{%s}', year(date), headline)) %>%
  {.$line}

# Create note lines
note_lines = research_data %>%
  filter(type == 'note') %>%
  mutate(line = sprintf('\\entry{%s}{%s}', year(date), headline)) %>%
  {.$line}


## Conference presentations ----

# Create lines
conference_lines = indata$conferences %>%
  bind_rows() %>%
  arrange(desc(date)) %>%
  mutate(text = ifelse(!is.na(location), sprintf('%s, %s', conf_title, location), conf_title),
         line = sprintf('\\entry{%s}{%s}', year(date), text)) %>%
  {.$line}


## Collation ----

body = c(
  '\\chapter{\\theauthor}',
  '',
  sprintf('Email: \\href{mailto:%s}{%s}', indata$email, indata$email),
  '',
  sprintf('Website: \\href{https://%s}{%s}', indata$website, indata$website),
  '',
  '\\section{Education}',
  education_lines,
  '',
  '\\section{Experience}',
  experience_lines,
  '',
  '\\section{Awards}',
  '',
  award_lines,
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
  '\\section{Policy and Technical Notes}',
  '',
  note_lines,
  '',
  '\\section{Conference Presentations}',
  '',
  conference_lines
)


# Compilation ----

writeLines(c(header, body, footer), 'static/cv.tex')
system('pdflatex -output-directory static static/cv.tex')
system('pdflatex -output-directory static static/cv.tex')  # Compile twice to define \thelastpage
system('rm static/cv.aux static/cv.log static/cv.out')
