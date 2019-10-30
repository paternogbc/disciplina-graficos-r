# Script para gerar Plots de coeficientes de modelos----------------------------
# Pacotes-----------------------------------------------------------------------
library(tidyverse)
library(RCurl)   # baixar dados online

# Load data --------------------------------------------------------------------
# Endereço do arquivo no Girhuib (RAW)
url_data <- getURL("https://raw.githubusercontent.com/paternogbc/disciplina-graficos-r/master/dados/plot_practice/anova_fatorial.csv")
dat <- read.csv(text = url_data)
dat

# Fit model---------------------------------------------------------------------
fit <- lm(massa ~ nit * fos, dat)
summary(fit)

# Prepare data for plot manually------------------------------------------------
co   <- coef(fit)
ci   <- confint(fit)
dat <- data.frame(term = names(co),
                 est = co,
                 lo = ci[,1],
                 hi = ci[,2],
                 row.names = NULL)
dat

# Coeficient plot 
ggplot(dat, aes(x = term, y = est, ymin = lo, ymax = hi)) +
  geom_errorbar(data = dat, width = .1, color = "black") +
  geom_point(data = dat, fill = "black", color = "black", shape = 21, size = 5, alpha = 1) +
  geom_hline(yintercept = 0, lty = "dashed") +
  theme_classic(base_size = 18) +
  labs(subtitle = paste(reg$call)[2],
       y = "Estimate",
       x = "Model term") +
  theme(plot.subtitle = element_text(size = 18)) +
  coord_flip()


# Fit model---------------------------------------------------------------------
fit <- lm(mpg ~ cyl + hp, mtcars)
summary(fit)

# Plot dots with colors for positive and negative estimates---------------------
# Prepare data for plot manually------------------------------------------------
co   <- coef(fit)
ci   <- confint(fit)
dat <- data.frame(term = names(co), est = co, lo = ci[,1], hi = ci[,2], row.names = NULL)
dat <- mutate(dat, sign = ifelse(est > 0, "tomato", "blue"))
dat <- mutate(dat, sig = ifelse(lo < 0 & 0 < hi, "no", "yes"))
dat <- mutate(dat, col = sign)
dat$col <- as.character(dat$col)
if (sum(dat$sig == "no") > 0) {dat[dat$sig == "no", ]$col <- "gray"}

dat

# Coeficient plot with colors
ggplot(dat, aes(x = term, y = est, ymin = lo, ymax = hi)) +
  geom_errorbar(data = dat, width = .1, color = "black") +
  geom_point(data = dat, fill = dat$col, color = "black", shape = 21, size = 5, alpha = 1) +
  geom_hline(yintercept = 0, lty = "dashed") +
  theme_classic(base_size = 18) +
  labs(subtitle = paste(fit$call)[2],
       y = "Estimate",
       x = "Model term") +
  theme(plot.subtitle = element_text(size = 18)) +
  coord_flip()
