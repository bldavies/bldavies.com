# bldavies.com

This repository contains the source material for [my website][site-url].

## Workflow

I build my website using [blogdown](https://github.com/rstudio/blogdown) and [Hugo](https://gohugo.io), and deploy it via [Netlify](https://www.netlify.com).

### Blog

I organise blog posts as [leaf bundles](https://gohugo.io/content-management/page-bundles/) under `content/blog/`.
Some posts are written in [R Markdown](https://rmarkdown.rstudio.com).
I convert such posts to Markdown using `R/build.R`.

I use a custom [taxonomy](https://gohugo.io/content-management/taxonomies/) to classify my blog posts based on the topics they discuss.

### Research

I organise my research project summaries as leaf bundles under `content/research/`.

### Vita

I build my CV using `R/cv.R` based on data stored in `_cv/` and the research project summaries under `content/research/`.
I save the intermediate TeX file for version control.

## License

Except where stated otherwise, all website content is licensed under a [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/) license.

[site-url]: https://bldavies.com/
