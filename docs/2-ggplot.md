---
title: ggplot()
layout: home
staff:
    - name: Nadia Muhe
      link: https://library.utoronto.ca/staff/nadia-muhe
maintainer:
    - name: Nadia Muhe
      link: https://library.utoronto.ca/staff/nadia-muhe
created_date: 2026-10-15
nav_order: 2
parent: Introduction to ggplot2
---

## ggplot()

Every ggplot2 graph starts with the `ggplot()` function. Plot variables are specified inside the `aes()` function.

This page uses the `lfs26sep` dataset from the [Setup](https://mdlutoronto.github.io/r-ggplot2/1-setup/) section.

```
ggplot()
ggplot(lfs26sep)
```

<img src="{{ '/assets/images/ggplot1.png' | relative_url }}"  alt='Empty grey ggplot canvas with no axes' title='' width='600'>

```
ggplot(lfs26sep, aes(x = hrlyearn))
```

<img src="{{ '/assets/images/ggplot2.png' | relative_url }}"  alt='ggplot canvas with an x-axis for hourly earnings and no data' title='' width='600'>

```
ggplot(lfs26sep, aes(x = uhrsmain, y = hrlyearn))
```

<img src="{{ '/assets/images/ggplot3.png' | relative_url }}"  alt='ggplot canvas with x- and y-axes and no data' title='' width='600'>

To draw data on the canvas, add a geom function, such as geom_histogram(), using +. The next examples show how.