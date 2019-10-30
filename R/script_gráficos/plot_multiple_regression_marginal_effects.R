# Scrip to plot multiple regression marginal effects----------------------------

# Packages ----------------------------------------------------------------
library(tidyverse)
library(sjPlot)

# Fit model ---------------------------------------------------------------
fit <- lm(mpg ~ cyl + wt, mtcars)
summary(fit)

# Plot marginal effects from model fit
plot_model(fit, type = "eff")
  
# Coeficient plot
plot_model(fit, show.values = TRUE) + 
  geom_hline(yintercept = 0) +
  theme_classic(base_size = 18)

# Model diagnostic
all <- plot_model(fit, type = "diag") 
all[[1]] +
  theme_classic(base_size = 18)
all[[2]] +
  theme_classic(base_size = 18)
all[[3]] +
  theme_classic(base_size = 18)
all[[4]] +
  theme_classic(base_size = 18)

# Model table
tab_model(fit)
