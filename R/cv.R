# CV.R
#
# This script builds my CV based on data stored in _cv/ and the research project
# summaries in content/research/.
#
# Ben Davies
# August 2020


# Initialisation ----

library(dplyr)
library(lubridate)
library(purrr)
library(readr)
library(rmarkdown)
library(yaml)

data_dir <- "_cv/"

md2tex <- function(x) {  # Untested against edge cases
  x <- gsub("[*](.*)[*]", "\\\\emph{\\1}", x)
  x <- gsub("\"(.*)\"", "``\\1''", x)
  x
}

null2na <- function(x) ifelse(is.null(x), NA, x)


# Header and footer ----

header <- c(
  read_lines(paste0(data_dir, "preamble.tex")),
  "",
  "\\begin{document}",
  ""
)

footer <- c(
  "",
  "\\end{document}"
)


# Contact info ----

coordinates <- read_yaml(paste0(data_dir, "coordinates.yaml"))

contact_info <- c(
  "\\parbox{\\textwidth}{%",
  "\t\\parbox[t]{0.6\\textwidth}{%",
  paste(paste0("\t\t", coordinates$address), collapse = "\\par\n\t"),
  "\t}",
  "\t\\hfill",
  "\t\\parbox[t]{0.3\\textwidth}{\\raggedleft%",
  sprintf("\t\t%s\\par", coordinates$email),
  sprintf("\t\t%s", coordinates$website),
  "\t}",
  "}\\par"
)


# Education ----

education <- read_csv(paste0(data_dir, "education.csv")) %>%
  arrange(desc(start_date)) %>%
  mutate(period = paste0(year(start_date), "--", ifelse(!is.na(end_date), year(end_date) - 2000, "present")),
         text = sprintf("\t\\entry{%s, %s, %s.}", qualification, institution, period)) %>%
  {.$text}


# Experience ----

experience <- read_csv(paste0(data_dir, "experience.csv")) %>%
  arrange(desc(start_date)) %>%
  mutate(period = paste0(year(start_date), "--", ifelse(!is.na(end_date), year(end_date) - 2000, "present")),
         text = sprintf("\t\\entry{%s, %s, %s.}", position, employer, period)) %>%
  {.$text}


# Honours ---

honours <- read_csv(paste0(data_dir, "honours.csv")) %>%
  mutate(text = sprintf("%s, %s.", award, year)) %>%
  arrange(desc(row_number())) %>%
  {sprintf("\t\\entry{%s}", .$text)}


# Research ----

research <- read_yaml("data/research.yaml") %>%
  bind_rows() %>%
  arrange(desc(date)) %>%
  mutate(text = paste0("\"", title,
                       ifelse(!is.na(coauthors), sprintf("\" (with %s), ", coauthors), ",\" "),
                       ifelse(!is.na(outlet), sprintf("%s, ", outlet), ""),
                       ifelse(!is.na({if ("forthcoming" %in% names(.)) forthcoming else rep(NA, nrow(.))}), "forthcoming", substr(date, 1, 4)),
                       "."))

working_papers <- research %>%
  filter(type == "wp") %>%
  {sprintf("\t\\entry{%s}", md2tex(.$text))}

publications <- research %>%
  filter(type == "pub") %>%
  {sprintf("\t\\entry{%s}", md2tex(.$text))}


# Presentations ----

presentations <- read_csv(paste0(data_dir, "presentations.csv"), col_types = cols(date = "D")) %>%
  arrange(date) %>%
  group_by(year = year(date)) %>%
  distinct(location) %>%
  summarise(text = paste0(paste(location, collapse = "; "), ".")) %>%
  ungroup() %>%
  arrange(-year) %>%
  {sprintf("\t\\entry{\\parbox[b]{0.4in}{\\emph{%d}: }%s}", .$year, .$text)}


# Combine and compile ----

content <- c(
  "\\begin{center}",
  "\t{\\Large\\bfseries\\MakeUppercase{\\theauthor}\\par}\\vskip\\beforesecskip",
  "\\end{center}",
  "",
  contact_info,
  "",
  "\\section{Education}",
  "",
  education,
  "",
  "\\section{Experience}",
  "",
  experience,
  "",
  "\\section{Honours}",
  "",
  honours,
  "",
  {
    if (length(working_papers) > 0) {
      c(
        "\\section{Working Papers}",
        "",
        working_papers,
        ""
      )
    } else {
      c()
    }
  },
  "\\section{Publications}",
  "",
  publications,
  "",
  "\\section{Seminars and Conference Presentations}",
  "",
  presentations,
  "\\vskip\\beforesecskip",
  "\\begin{center}",
  "\t\\footnotesize Last updated: \\today",
  "\\end{center}"
) %>%
  {paste0("\t", .)}

writeLines(c(header, content, footer), "static/cv.tex")
system("pdflatex -output-directory static static/cv.tex")
system("pdflatex -output-directory static static/cv.tex")  # Compile twice to define \thelastpage
system("rm static/cv.aux static/cv.log")
