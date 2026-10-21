---
title: Saving plots
layout: home
staff:
    - name: Nadia Muhe
      link: https://library.utoronto.ca/staff/nadia-muhe
maintainer:
    - name: Nadia Muhe
      link: https://library.utoronto.ca/staff/nadia-muhe
created_date: 2026-10-15
nav_order: 6
parent: Introduction to ggplot2
---

## Saving plots

Use `ggsave()` to save plots. 

```
# Store the last plot as an object
linegraph <- last_plot()

# Save the last plot to a file
ggsave("lfs_2025_linegraph_last.png")

# Save a specific plot to a file
ggsave("lfs_2025_linegraph.png", plot = linegraph, width = 8, height = 5, dpi = 150)
```