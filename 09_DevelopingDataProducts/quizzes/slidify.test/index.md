---
title       : 
subtitle    : 
author      : 
job         : 
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---

## Read-And-Delete

1. Edit YAML front matter
2. Write using R Markdown
3. Use an empty line followed by three dashes to separate slides!

--- .class #id 

## Slide 2


```r
library(stats)
y <- c(1, 2, 4)
x1 <- c(1, 2, 5)
x2 <- c(2, 4, 5)
x3 <- c(8, 2, 2)

fit <- lm(y ~ x1 + x2 + x3)
summary(fit)
```


