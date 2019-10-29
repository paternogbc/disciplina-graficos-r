# Script para gerar ANOVA fatorial----

# Pacotes-----------------------------------------------------------------------
library(tidyverse)
library(RCurl)   # baixar dados online

# Load data ---------------------------------------------------------------
# Endereço do arquivo no Girhuib (RAW)
url_data <- getURL("https://raw.githubusercontent.com/paternogbc/disciplina-graficos-r/master/dados/plot_practice/anova_fatorial.csv")
dat <- read.csv(text = url_data)
dat

# Plot templates----------------------------------------------------------------

# 1. With RAW data--------------------------------------------------------------
ggplot(dat, aes(y = massa, x = nit:fos)) +
  stat_summary(geom = "bar", fun.y = "mean", fill = "gray") +
  stat_summary(geom = "errorbar", width = .2, fun.data = mean_se) +
  labs(y = "Biomassa (g)",
       x = "Tratamento") +
  theme_classic(base_size = 20)

# 2. With summarised data-------------------------------------------------------
se <- function(x) sqrt(var(x)/length(x)) # Function to calculate standard error

# Calculate average and standar error per group
dat2 <-
  dat %>% 
  group_by(nit, fos) %>% 
  summarise(avg = mean(massa, na.rm = TRUE),
            se  = se(massa))

# Plot using geom_col() + geom_errorbar()
ggplot(dat2, aes(y = avg, x = nit:fos)) +
  geom_col(fill = "gray") +
  geom_errorbar(aes(ymin = avg - se, 
                    ymax = avg + se), 
                width = .2) +
  labs(y = "Biomassa (g)",
       x = "Tratamento") +
  theme_classic(base_size = 20)
