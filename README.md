# bldavies.com

This repository contains the source material for [my website](https://bldavies.com/).

## Workflow

I build my website using [blogdown](https://github.com/rstudio/blogdown) and [Hugo](https://gohugo.io), and deploy it via [Netlify](https://www.netlify.com).

### Blog

I organise blog posts as [leaf bundles](https://gohugo.io/content-management/page-bundles/) under `content/blog/`.
Some posts are written in [R Markdown](https://rmarkdown.rstudio.com).
I convert such posts to Markdown using `R/build.R`.

I use a custom [taxonomy](https://gohugo.io/content-management/taxonomies/) to classify my blog posts based on the topics they discuss:

* [culture](https://bldavies.com/topics/culture/)
* [economics](https://bldavies.com/topics/economics/): markets, incentives, and the academic discipline
* [education](https://bldavies.com/topics/education/)
* [mathematics](https://bldavies.com/topics/mathematics/)
* (mass) [media](https://bldavies.com/topics/media/): music, news, and podcasts
* [networks](https://bldavies.com/topics/networks/)
* [politics](https://bldavies.com/topics/politics/), voting, and government
* [research](https://bldavies.com/topics/research/), publishing, and academia
* information about [software](https://bldavies.com/topics/software/) and data I maintain
* [sports](https://bldavies.com/topics/sports/)
* [statistics](https://bldavies.com/topics/statistics/): sampling, estimation, and inference

### Research

I list my research projects in `data/research.yaml`.

### Vita

I build my CV using `R/cv.R` based on data stored in `_cv/` and `data/research.yaml`.
I save the intermediate TeX file for version control.

## License

Except where stated otherwise, all website content is licensed under a [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/) license.
