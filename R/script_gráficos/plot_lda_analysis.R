# Script to plot discriminant analysis

# Pacotes-----------------------------------------------------------------------
library(tidyverse)
library(ggfortify)
library(lfda)

# Load and manipulate data------------------------------------------------------
# Local Fisher Discriminant Analysis (LFDA)
fit <- lfda(iris[,-5], iris[, 5], 4, metric = "plain")
fit

# Plot discriminant analysis with ggplot() + ggfortify()
autoplot(fit, data = iris, frame = TRUE, frame.colour = 'Species') +
  theme_classic(base_size = 18)
