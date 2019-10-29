# Script para gerar Linear regression----

# Pacotes-----------------------------------------------------------------------
library(tidyverse)
library(RCurl)   # baixar dados online

# Load data ---------------------------------------------------------------
# Endereço do arquivo no Girhuib (RAW)
url_data <- getURL("https://raw.githubusercontent.com/paternogbc/disciplina-graficos-r/master/dados/plot_practice/linear_regression.csv")
dat <- read.csv(text = url_data)
dat

# Plot templates----------------------------------------------------------------

# LM model fit by ggplot with geom_smoot
ggplot(dat, aes(y = y, x = x)) +
  geom_point() +
  geom_smooth(method = lm, color = "red", fill = "gray", alpha = .5) +
  labs(x = "X variable",
       y = "Y Variable") +
  theme_classic(base_size = 20)

# LM fit manually (use geom_abline to plot line)
fit  <- lm(y ~ x, dat)
# Predict values and confidence interval from model
pred <- predict(fit, interval = "confidence")
pred

# Add prediction to data
dat2 <- cbind(dat, pred)
dat2

# Plot line + CI manually
ggplot(dat2, aes(y = y, x = x)) +
  geom_point() +
  geom_ribbon(aes(ymin = lwr, ymax = upr), fill = "gray", alpha = .5) +
  geom_line(aes(y = fit, x = x), color = "red", size = 1) +
  labs(x = "X variable",
       y = "Y Variable") +
  theme_classic(base_size = 20)
