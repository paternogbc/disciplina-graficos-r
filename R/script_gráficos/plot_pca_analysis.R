# Script to plot Principle Components Analysis (PCA)

# Pacotes-----------------------------------------------------------------------
library(tidyverse)
library(ggfortify)
library(vegan)

# Load and manipulate data------------------------------------------------------
dat <- select(iris, -Species) # remove species 

# fit PCA 
fit <- prcomp(dat)

# Plot with base R
biplot(fit)

# Plot with ggplot2 + ggfortify
autoplot(fit, data = iris, 
         colour = "Species",
         label = TRUE,
         loadings = TRUE,
         loadings.colour = "red",
         loadings.label = TRUE,
         loadings.label.colour = "black",
         loadings.label.size = 8,
         frame = TRUE,
         frame.type = 'norm') +
  theme_classic(base_size = 18)
