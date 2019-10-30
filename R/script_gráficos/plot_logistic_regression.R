# Script para gerar Logistic regression----

# Pacotes-----------------------------------------------------------------------
library(tidyverse)

# Generate data ----------------------------------------------------------------
y = rep(c(0,1), each = 20)
x = 1:40 + rnorm(n = 40, mean = 100, sd = 10)
dat <- data.frame(y, x)

# Fit logistic model
fit <- glm(y ~ x, family = "binomial", data = dat)
summary(fit)

# Plot templates----------------------------------------------------------------
ggplot(dat, aes(x = x, y = y)) +
  geom_point() +
  geom_smooth(method = "glm", 
              method.args = list(family = "binomial")) +
  labs(x = "X variable",
       y = "Probability of Y") +
  theme_classic(base_size = 20)
