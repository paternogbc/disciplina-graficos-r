# Script to plotSurvival analysis----------------------------------------------

# Pacotes-----------------------------------------------------------------------
library(tidyverse)
library(ggfortify)
library(survival)

# Loade data-----------------------------------------------------------------
data(lung)

# FIt model-------------------------------------------------------------------
fit <- survfit(Surv(time, status) ~ sex, data = lung)

# Plot survival curves
autoplot(fit) +
  labs(x = "Time",
       y = "Survival") +
  theme_classic(base_size = 20)
