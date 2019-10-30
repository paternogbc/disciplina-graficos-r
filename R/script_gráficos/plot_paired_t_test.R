# Script to plot paired t-test--------------------------------------------------

# Pacotes-----------------------------------------------------------------------
library(tidyverse)

# Generate data-----------------------------------------------------------------
set.seed(1226)
d <- data.frame(y = c(rnorm(20, 2, 2), rnorm(20, 3.8, 2)),
              x = rep(c("A", "B"), each = 20),
              g = rep(1:20, times = 2))

d
# Fit t-test--------------------------------------------------------------------
YA <- filter(d, x == "A") %>% pull(y)
YB <- filter(d, x == "B") %>% pull(y)

t.test(YA, YB)
t.test(YA, YB, paired = TRUE)

# Plot paired points------------------------------------------------------------
ggplot(d, aes(y = y, x = x, group = g)) +
  geom_line(color = gray(.3), size = 1) +
  geom_point(size = 4) +
  labs(x = "Explanatory variable (X)",
       y = "Response (Y)") +
  theme_classic(base_size = 20)

# Add colors to the lines (blue for positive, red for negative)
d2 <-
  d %>% mutate(
  dir = c(YA > YB, YB > YA)
)

# Plot 
ggplot(d2, aes(y = y, x = x, group = g)) +
  geom_line(aes(color = dir), show.legend = FALSE) +
  geom_point(size = 4, color = gray(.2)) +
  labs(x = "Explanatory variable (X)",
       y = "Response (Y)") +
  theme_classic(base_size = 20)
