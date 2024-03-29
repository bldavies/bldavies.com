# CV.R
#
# This script builds my CV using data from data/cv.yaml and data/research.yaml.
#
# Ben Davies
# August 2023


# Initialization ----

library(bldr)
library(dplyr)
library(lubridate)
library(purrr)
library(rmarkdown)
library(yaml)

md2tex = function(x) {  # Untested against edge cases
  x = gsub('[*](.*)[*]', '\\\\emph{\\1}', x)
  x = gsub('"(.*)"', '``\\1\'\'', x)
  x
}

get_period = function(start_date, end_date) {
  x = year(start_date)
  y = year(end_date)
  ifelse(is.na(y), paste0(x, '--present'), ifelse(x < y, paste0(x, '--', y - 2000), x))
}

indata = read_yaml('data/cv.yaml')


# Header and footer ----

preamble = '\\documentclass[11pt,oneside]{memoir}

\\title{Curriculum Vitae}
\\author{Benjamin Davies}
\\date{\\today}

\\usepackage{mathpazo}
\\usepackage[T1]{fontenc}
\\usepackage[utf8]{inputenc}
\\usepackage[margin=1in,includefoot]{geometry}
\\usepackage{nohyperref}

\\makeevenfoot{plain}{\\theauthor}{}{Page~\\thepage\\ of~\\thelastpage}
\\makeoddfoot{plain}{\\theauthor}{}{Page~\\thepage\\ of~\\thelastpage}
\\OnehalfSpacing
\\pagestyle{plain}
\\raggedright
\\setaftersecskip{1em}
\\setbeforesecskip{2em}
\\setlength{\\parindent}{0pt}
\\setsecheadstyle{\\large\\bfseries}
\\setsecnumdepth{part}

\\newcommand{\\entry}[1]{\\par\\hangindent=0.4in #1}'

header = c(
  preamble,
  '',
  '\\begin{document}',
  ''
)

footer = c(
  '',
  '\\end{document}'
)


# Contact info ----

contact_info = with(
  unlist(indata$addresses, recursive = F),
  c(
    '\\parbox{\\textwidth}{%',
    '\t\\parbox[t]{0.6\\textwidth}{%',
    paste(paste0('\t\t', strsplit(physical, '\n')[[1]]), collapse = '\\par\n\t'),
    '\t}',
    '\t\\hfill',
    '\t\\parbox[t]{0.3\\textwidth}{\\raggedleft%',
    sprintf('\t\t%s\\par', email),
    sprintf('\t\t%s', web),
    '\t}',
    '}\\par'
  )
)


# Education ----

education = indata$degrees %>%
  bind_rows() %>%
  arrange(desc(start_date)) %>%
  mutate(period = get_period(start_date, end_date),
         text = sprintf('\t\\entry{%s, %s, %s.}', degree, institution, period)) %>%
  {.$text}


# Employment ----

employment = indata$jobs %>%
  bind_rows() %>%
  arrange(desc(start_date)) %>%
  mutate(period = paste0(year(start_date), '--', ifelse(!is.na(end_date), year(end_date) - 2000, 'present')),
         text = sprintf('\t\\entry{%s, %s, %s.}', position, employer, period)) %>%
  {.$text}


# Honours ---

honours = indata$honours %>%
  bind_rows() %>%
  mutate(text = sprintf('%s, %s.', description, year)) %>%
  {sprintf('\t\\entry{%s}', .$text)}


# Research ----

research = read_yaml('data/research.yaml') %>%
  bind_rows() %>%
  arrange(desc(date)) %>%
  mutate(text = paste0('"', title,
                       ifelse(!is.na(coauthors), sprintf('" (with %s), ', coauthors), '," '),
                       ifelse(!is.na(outlet), sprintf('%s, ', outlet), ''),
                       ifelse(!is.na({if ('forthcoming' %in% names(.)) forthcoming else rep(NA, nrow(.))}), 'forthcoming', substr(date, 1, 4)),
                       '.'))

working_papers = research %>%
  filter(type == 'wp') %>%
  {sprintf('\t\\entry{%s}', md2tex(.$text))}

publications = research %>%
  filter(type == 'pub') %>%
  {sprintf('\t\\entry{%s}', md2tex(.$text))}


# Presentations ----

presentations = indata$talks %>%
  bind_rows() %>%
  arrange(date) %>%
  group_by(year = year(date)) %>%
  distinct(location) %>%
  summarise(text = paste0(paste(location, collapse = '; '), '.')) %>%
  ungroup() %>%
  arrange(-year) %>%
  {sprintf('\t\\entry{\\parbox[b]{0.4in}{\\emph{%d}: }%s}', .$year, .$text)}


# Teaching ----

teaching = indata$teaching %>%
  bind_rows() %>%
  arrange(desc(start_date)) %>%
  mutate(period = get_period(start_date, end_date),
         text = sprintf('\t\\entry{%s, %s, %s.}', position, institution, period)) %>%
  {.$text}


# Combine and compile ----

content = c(
  '\\begin{center}',
  '\t{\\Large\\bfseries\\MakeUppercase{\\theauthor}\\par}\\vskip\\beforesecskip',
  '\\end{center}',
  '',
  contact_info,
  '',
  '\\section{Education}',
  '',
  education,
  '',
  '\\section{Employment}',
  '',
  employment,
  '',
  '\\section{Honours}',
  '',
  honours,
  '',
  {
    if (length(working_papers) > 0) {
      c(
        '\\section{Working Papers}',
        '',
        working_papers,
        ''
      )
    } else {
      c()
    }
  },
  '\\section{Publications}',
  '',
  publications,
  '',
  '\\section{Seminars and Conference Presentations}',
  '',
  presentations,
  '',
  '\\section{Teaching}',
  '',
  teaching,
  '\\vskip\\beforesecskip',
  '\\begin{center}',
  '\t\\footnotesize Last updated: \\today',
  '\\end{center}'
) %>%
  {paste0('\t', .)}

writeLines(c(header, content, footer), 'static/cv.tex')
system('pdflatex -output-directory static static/cv.tex')
system('pdflatex -output-directory static static/cv.tex')  # Compile twice to define \thelastpage
system('rm static/cv.aux static/cv.log')
