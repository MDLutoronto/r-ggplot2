---
title: Scatterplot
layout: home
staff:
    - name: Nadia Muhe
      link: https://library.utoronto.ca/staff/nadia-muhe
maintainer:
    - name: Nadia Muhe
      link: https://library.utoronto.ca/staff/nadia-muhe
created_date: 2026-10-15
nav_order: 4
parent: Introduction to ggplot2
---

## Scatterplot

Use `geom_point()` to plot a scatterplot. The `shape` argument specifies the shape of each data point. The `na.rm = TRUE` argument tells R to ignore missing values and silences the warning about dropped rows. 


```
ggplot(lfs26sep, aes(x = uhrsmain/10, y = hrlyearn/100)) + 
  geom_point(shape = "circle open", na.rm = TRUE) +
  theme_light()
```

<img src="{{ '/assets/images/scatterplot1.png' | relative_url }}"  alt='Scatterplot of hourly wage by usual weekly hours in Ontario' title='' width='600'  >

```
ggplot(lfs26sep, aes(x = uhrsmain/10, y = hrlyearn/100, colour = gender)) + 
  geom_point(shape = "circle open", na.rm = TRUE) +
  theme_light() + 
  ggtitle("Hourly Wage by Weekly Hours in Ontario") + 
  xlab("Weekly hours") + ylab("Hourly wage ($)") + 
  labs(colour = "Gender", 
       caption = "Source: Statistics Canada, LFS PUMF, September 2026")
```

<img src="{{ '/assets/images/scatterplot2.png' | relative_url }}"  alt='Same scatterplot with points coloured by gender, plus title, labels, and legend' title='' width='600'  >


### Colourpicker

The `colourpicker` package adds a colour picker to RStudio. After installing it, open **Addins > Colour Picker**, choose your colours, and copy their hex codes. Then pass them to `scale_colour_manual()`, one colour per group.

```
# 1) Using Colourpicker
install.packages("colourpicker")
gender_colours <- c("#00B2EE", "#FF8C00")
ggplot(lfs26sep, aes(x = uhrsmain/10, y = hrlyearn/100, colour = gender)) + 
  geom_point(shape = "circle open", na.rm = TRUE) +
  theme_light() + 
  ggtitle("Hourly Wage by Weekly Hours in Ontario") + 
  xlab("Weekly hours") + ylab("Hourly wage ($)") + 
  labs(colour = "Gender", 
       caption = "Source: Statistics Canada, LFS PUMF, September 2026") + 
  scale_colour_manual(values = gender_colours)
```

<img src="{{ '/assets/images/scatterplot3.png' | relative_url }}"  alt='Same scatterplot using custom blue and orange colours for gender' title='' width='600'  >


### Brewer palettes

`scale_colour_brewer()` applies a ready-made palette. For groups with no natural order, like gender, use a qualitative palette such as "Set2".

```
# 2) Using Brewer palettes
ggplot(lfs26sep, aes(x = uhrsmain/10, y = hrlyearn/100, colour = gender)) + 
  geom_point(shape = "circle open", na.rm = TRUE) +
  theme_light() + 
  ggtitle("Hourly Wage by Weekly Hours in Ontario") + 
  xlab("Weekly hours") + ylab("Hourly wage ($)") + 
  labs(colour = "Gender", 
       caption = "Source: Statistics Canada, LFS PUMF, September 2026") + 
  scale_colour_brewer(palette = "Set2")
```
<img src="{{ '/assets/images/scatterplot4.png' | relative_url }}"  alt='Same scatterplot using the Set2 Brewer palette for gender' title='' width='600'  >