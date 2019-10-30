# Script to plot ANCOVA model---------------------------------------------------
library(tidyverse)


# Load data --------------------------------------------------------------------
data(iris)

# Fit ANCOVA model -------------------------------------------------------------
fit <- lm(Petal.Length ~ Sepal.Length * Species, iris)
anova(fit)

# Plot ANCOVA model ------------------------------------------------------------
ggplot(iris, aes(y = Petal.Length, x = Sepal.Length, color = Species)) +
  geom_point() +
  geom_smooth(method = lm) +
  labs(x = "Explanatory variable (X)",
       y = "Response (Y)") +
  theme_classic(base_size = 20)
