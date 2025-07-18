# Load libraries
library(tidyverse)
library(car)
library(MASS)

# Load data
men_ncd_total <- read_csv("../data/processed/men_ncd_total_bp.csv")

# Prepare variables
predictors <- men_ncd_total %>%
  select(underweight, overweight, tobacco, alcohol)
outcome <- men_ncd_total$bp_high

# Combine into a modeling dataframe
bp_data <- bind_cols(predictors, high_bp = outcome)

# Fit model
model_bp <- lm(high_bp ~ underweight + overweight + tobacco + alcohol, data = bp_data)

# Print summary
summary(model_bp)

# Multicollinearity check
vif(model_bp)

# Stepwise model selection
step_model_bp <- stepAIC(model_bp, direction = "both")
summary(step_model_bp)

# Save model object if needed
saveRDS(model_bp, "../results/model_bp.rds")
