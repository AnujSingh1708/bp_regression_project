# Load libraries
library(tidyverse)
library(broom)

# Load the model and data
model_bp <- readRDS("../results/model_bp.rds")
men_ncd_total <- read_csv("../data/processed/men_ncd_total_bp.csv")

# Create modeling dataset again (just to plot)
predictors <- men_ncd_total %>%
  select(underweight, overweight, tobacco, alcohol)
outcome <- men_ncd_total$bp_high
bp_data <- bind_cols(predictors, high_bp = outcome)

# Coefficient Plot
tidy_bp <- tidy(model_bp, conf.int = TRUE)

ggplot(tidy_bp, aes(x = term, y = estimate)) +
  geom_point() +
  geom_errorbar(aes(ymin = conf.low, ymax = conf.high), width = 0.2) +
  labs(title = "Coefficient Plot for High BP Model", x = "Predictor", y = "Estimate") +
  theme_minimal()

ggsave("../plots/bp_coefficients.png", width = 7, height = 5)

# Actual vs Fitted Plot
ggplot(bp_data, aes(x = fitted(model_bp), y = high_bp)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE, color = "blue") +
  labs(title = "Actual vs Fitted: BP Model", x = "Fitted Values", y = "Actual Values") +
  theme_minimal()

ggsave("../plots/bp_actual_vs_fitted.png", width = 7, height = 5)

# Diagnostic Plots
png("../plots/bp_diagnostics.png", width = 800, height = 800)
par(mfrow = c(2, 2))
plot(model_bp)
dev.off()
