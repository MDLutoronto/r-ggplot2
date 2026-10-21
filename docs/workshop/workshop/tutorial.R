#
# ggplot2 - Tutorial 
# by Nadia Muhe, Map & Data Library
# GitHub: https://github.com/MDLutoronto/r-ggplot2 
#===============================================================================

#----------------------------#
# ggplot2                    #
#----------------------------#
install.packages("ggplot2")
library(ggplot2)

#----------------------------#
# LFS Datasets               #
#----------------------------#
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


#------------------------------#
# ggplot()                     #
#------------------------------#
ggplot()
ggplot(lfs26sep)
ggplot(lfs26sep, aes(x = hrlyearn))
ggplot(lfs26sep, aes(x = uhrsmain, y = hrlyearn))
       

#------------------------------#
# Example 1: Histogram         #
#------------------------------#
ggplot(lfs26sep, aes(x = hrlyearn/100, weight = finalwt)) +
  geom_histogram(binwidth = 1, na.rm = TRUE) +
  theme_classic()

ggplot(lfs26sep, aes(x = hrlyearn/100, weight = finalwt)) +
  geom_histogram(binwidth = 1, fill = "darkblue", colour = "lightblue", na.rm = TRUE) +
  theme_classic() + 
  scale_y_continuous(labels = scales::comma) + 
  ggtitle("Hourly Wages in Ontario") + 
  theme(plot.title = element_text(size = 14, hjust = 0.5)) + 
  xlab("Hourly wage ($)") + ylab("Estimated employees") + 
  labs(caption = "Source: Statistics Canada, LFS PUMF, September 2026")



#------------------------------#
# Example 2: Scatterplot       #
#------------------------------#
ggplot(lfs26sep, aes(x = uhrsmain/10, y = hrlyearn/100)) + 
  geom_point(shape = "circle open", na.rm = TRUE) +
  theme_light()

ggplot(lfs26sep, aes(x = uhrsmain/10, y = hrlyearn/100, colour = gender)) + 
  geom_point(shape = "circle open", na.rm = TRUE) +
  theme_light() + 
  ggtitle("Hourly Wage by Weekly Hours in Ontario") + 
  xlab("Weekly hours") + ylab("Hourly wage ($)") + 
  labs(colour = "Gender", 
       caption = "Source: Statistics Canada, LFS PUMF, September 2026")
  

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

  
# 2) Using Brewer palettes
ggplot(lfs26sep, aes(x = uhrsmain/10, y = hrlyearn/100, colour = gender)) + 
  geom_point(shape = "circle open", na.rm = TRUE) +
  theme_light() + 
  ggtitle("Hourly Wage by Weekly Hours in Ontario") + 
  xlab("Weekly hours") + ylab("Hourly wage ($)") + 
  labs(colour = "Gender", 
       caption = "Source: Statistics Canada, LFS PUMF, September 2026") + 
  scale_colour_brewer(palette = "Set2")



#-------------------------------------#
# Example 3: Line Graph               #
#-------------------------------------#
ggplot(subset(lfs25, lfsstat == "Unemployed"), 
       aes(x = survmnth, weight = finalwt)) +
  geom_line(stat = "count") +
  theme_minimal()

ggplot(subset(lfs25, lfsstat == "Unemployed"), 
       aes(x = factor(survmnth, levels = 1:12, labels = month.abb), group = 1,
           weight = finalwt)) +
  geom_line(stat = "count", colour = "yellow3", linewidth = 1) +
  theme_minimal() + 
  scale_y_continuous(labels = scales::comma) + 
  labs(title = "Ontario Unemployment Trends",
       subtitle = "Estimated unemployed people, 2025",
       x = "Survey Month", y = "Estimated unemployed", 
       caption = "Source: Statistics Canada, LFS PUMF, 2025")



#-------------------------------------#
# Saving Plots                        #
#-------------------------------------#

# Store the last plot as an object
linegraph <- last_plot()

# Save the last plot to a file
ggsave("lfs_2025_linegraph_last.png")

# Save a specific plot to a file
ggsave("lfs_2025_linegraph.png", plot = linegraph, width = 8, height = 5, dpi = 150)

