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

# Data: Labour Force Survey
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

# Data: Diamonds
data(diamonds)
ggplot(diamonds, aes(price)) + geom_histogram()
ggplot(diamonds, aes(price)) + geom_histogram() + theme_classic()
ggplot(diamonds, aes(price)) + geom_histogram(binwidth=100) + theme_classic()
ggplot(diamonds, aes(price)) + 
  geom_histogram(binwidth=100, fill="darkblue", color="lightblue") + 
  theme_classic() + 
  ggtitle("Histogram of the Diamond Prices") + 
  theme(plot.title=element_text(size=20, hjust=0.5)) + 
  xlab("Price") + ylab("Count")

#------------------------------#
# Example 2: Scatterplot       #
#------------------------------#

# Data: Labour Force Survey
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

# Data: Diamonds
data(diamonds)
install.packages("colourpicker")
clarity_colours <- c("#228510", "#FF7F00", "#9932CC", "#C1FFC1", "#FFC125", "#7F7F7F", "#FF6EB4", "#00FA9A")
ggplot(diamonds, aes(carat, price, colour=clarity)) + 
  geom_point(shape="diamond filled") + 
  theme_light() + 
  ggtitle("Diamond Price by Carat and Clarity") + 
  xlab("Carat") + ylab("Price") +
  labs(colour = "Clarity") + 
  scale_colour_manual(values = clarity_colours)


#-------------------------------------#
# Example 3: Line Graph               #
#-------------------------------------#

# Data: Labour Force Survey
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


# Data: Economics
data(economics)
ggplot(economics, aes(x=date, y=uempmed)) +
  theme_minimal() +
  geom_line(colour="yellow3", linewidth=1) + 
  labs(title="US Unemployment Trends",
       subtitle="Median unemployment duration in weeks, 1967–2015") +
  xlab("Date") +
  ylab("Median Duration (Weeks)")


#-------------------------------------#
# Saving Plots                        #
#-------------------------------------#

# Store the last plot as an object
linegraph <- last_plot()

# Save the last plot to a file
ggsave("lfs_2025_linegraph_last.png")

# Save a specific plot to a file
ggsave("lfs_2025_linegraph.png", plot = linegraph, width = 8, height = 5, dpi = 150)

