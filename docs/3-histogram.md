---
title: Histogram
layout: home
staff:
    - name: Nadia Muhe
      link: https://library.utoronto.ca/staff/nadia-muhe
maintainer:
    - name: Nadia Muhe
      link: https://library.utoronto.ca/staff/nadia-muhe
created_date: 2026-10-15
nav_order: 3
parent: Introduction to ggplot2
---

## Histogram

Use `geom_histogram()` to plot a histogram. The `binwidth` argument sets the width of each bar, in the units of the x-axis variable. The `na.rm = TRUE` argument tells R to ignore missing values and silences the warning about dropped rows. `weight = finalwt` makes the y-axis show estimated Ontario employees instead of survey responses.

```
ggplot(lfs26sep, aes(x = hrlyearn/100, weight = finalwt)) +
  geom_histogram(binwidth = 1, na.rm = TRUE) +
  theme_classic()
```

<img src="{{ '/assets/images/histogram1.png' | relative_url }}"  alt='Histogram of hourly wages in Ontario' title='' width='600'>

```
ggplot(lfs26sep, aes(x = hrlyearn/100, weight = finalwt)) +
  geom_histogram(binwidth = 1, fill = "darkblue", colour = "lightblue", na.rm = TRUE) +
  theme_classic() + 
  scale_y_continuous(labels = scales::comma) + 
  ggtitle("Hourly Wages in Ontario") + 
  theme(plot.title = element_text(size = 14, hjust = 0.5)) + 
  xlab("Hourly wage ($)") + ylab("Estimated employees") + 
  labs(caption = "Source: Statistics Canada, LFS PUMF, September 2026")
```

<img src="{{ '/assets/images/histogram2.png' | relative_url }}"  alt='Styled version of the same histogram with dark blue bars, a title, axis labels, and a source caption' title='' width='600'>