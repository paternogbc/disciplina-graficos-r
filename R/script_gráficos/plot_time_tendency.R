# Script for Tidy Tuesday: 2018-11-13 
# Malaria deaths for Brasil, Peru, Colômbia e Bolívia

## packages----
library(tidyverse)
library(RCurl)
library(RColorBrewer)

### Load data----
url <- "https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2018/2018-11-13/malaria_deaths.csv"
dat <- read_csv(getURL(url))

### Simplify colnames
dat <- dat %>% 
  rename(deaths = colnames(dat)[4],
         country = Entity) 
dat %>% head()

### Filter for some countries
dat <- dat %>%
  dplyr::filter(country %in% c("Brazil", "Colombia", "Peru", "Bolivia")) %>%
  dplyr::select(country, Year, deaths)

## Plot-----
# Malaria Deaths/100.000 hab ~ year | by country
g1 <- 
  ggplot(dat, aes(y = deaths, x = Year, color = country, label = country)) +
  geom_line(size = 4, alpha = .7) +
  geom_point(size = 5, alpha = .9) + 
  scale_x_continuous(breaks = seq(1990, 2016, 2)) +
  theme_classic(base_size = 20) +
  theme(panel.grid = element_blank(), 
        legend.position = c(.8,.9),
        legend.background = element_blank()) + 
  labs(x = "Year",
       y = "Malaria deaths per 100,000 people", 
       title = "Great Decline in Malaria Deaths",
       caption = "Source: https://ourworldindata.org/malaria")
g1
