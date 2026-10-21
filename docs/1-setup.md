---
title: Setup
layout: home
staff:
    - name: Nadia Muhe
      link: https://library.utoronto.ca/staff/nadia-muhe
maintainer:
    - name: Nadia Muhe
      link: https://library.utoronto.ca/staff/nadia-muhe
created_date: 2026-10-15
nav_order: 1
parent: Introduction to ggplot2
---

## Setup

### R and RStudio

R is a free programming language for data analysis. RStudio is a free program that makes R easier to use. You need to install both, and R must be installed first.

For installation steps, see this [R & RStudio](https://mdlutoronto.github.io/r-intro/01-r-and-rstudio/) lesson. 


### Install ggplot2

```
# Install & load ggplot2
install.packages("ggplot2")
library(ggplot2)
```


### Prepare LFS Datasets

This guide uses two Labour Force Survey (LFS) datasets: Ontario 2025 and Ontario September 2026. 

The code below collects the two datasets from Statistics Canada directly in R using the `canpumf` package and filters to Ontario using the `dplyr` package. 


```
# Temporary storage
options(canpumf.cache_path = tempdir())   # LFS downloads
options(duckdb.home = tempdir())          # DuckDB helper files

# Install packages
install.packages(c("canpumf", "dplyr"))

# Load packages
library(canpumf)  # To pull LFS dataset
library(dplyr)    # To modify dataset

# Import datasets (before collecting)
get_pumf("LFS", "2025") |> close_pumf()
get_pumf("LFS", "2026-09") |> close_pumf()

# Collect 2025 Ontario
lfs25 <- get_pumf("LFS", "2025") |>
  filter(PROV == "Ontario") |>
  collect() |>
  rename_with(tolower)

# Collect September 2026 Ontario
lfs26sep <- get_pumf("LFS", "2026-09") |>
  filter(PROV == "Ontario") |>
  collect() |>
  rename_with(tolower)
```
 

### LFS Variables Used

Variable names are uppercase in the original data. The code filters using `PROV`, then converts all names to lowercase, so the examples use lowercase variable names.

- **PROV**: Province
- **survmnth**: Survey month (1-12)
- **lfsstat**: Labour force status (employed, unemployed, or not in the labour force)
- **gender**: Gender (Men+, Women+)
- **hrlyearn**: Hourly wage (unit = cents)
- **uhrsmain**: Weekly hours (unit = tenths of an hour)
- **finalwt**: Final weight (number of people each respondent represents)


**Technique:** [Extracting data](https://mdlutoronto.github.io/tutorials-search/?technique=Extracting+data)\
**Tools:** [R](https://mdlutoronto.github.io/tutorials-search/?tool=R)\
**Data Format:** [Statistics](https://mdlutoronto.github.io/tutorials-search/?dataFormat=Statistics)