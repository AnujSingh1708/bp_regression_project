# Load libraries
library(tidyverse)
library(haven)
library(skimr)
library(janitor)

# Set working directory
setwd("E:/Projects/NFHS5_Analysis/data/Men's NCD risk")

# Load and clean data
datafile <- read_csv("datafile.csv") %>%
  clean_names()

# Create men_ncd dataframe
men_ncd <- datafile %>%
  select(
    state = states_u_ts,
    area,
    underweight = men_age_15_49_years_whose_body_mass_index_bmi_is_below_normal_bmi_18_5_kg_m2_percent,
    overweight = men_age_15_49_years_who_are_overweight_or_obese_bmi_25_0_kg_m2_percent,
    bp_mild = men_age_15_years_and_above_wih_mildly_elevated_blood_pressure_systolic_140_159_mm_of_hg_and_or_diastolic_90_99_mm_of_hg_percent,
    bp_severe = men_age_15_years_and_above_wih_moderately_or_severely_elevated_blood_pressure_systolic_160_mm_of_hg_and_or_diastolic_100_mm_of_hg_percent,
    bp_high = men_age_15_years_and_above_wih_elevated_blood_pressure_systolic_140_mm_of_hg_and_or_diastolic_90_mm_of_hg_or_taking_medicine_to_control_blood_pressure_percent,
    tobacco = men_age_15_years_and_above_who_use_any_kind_of_tobacco_percent,
    alcohol = men_age_15_years_and_above_who_consume_alcohol_percent
  )

# Convert relevant columns to numeric
men_ncd <- men_ncd %>%
  mutate(across(-c(state, area), ~ as.numeric(str_trim(.))))

# Filter only "Total" area
men_ncd_total <- men_ncd %>%
  filter(area == "Total") %>%
  select(-area)

# Save cleaned data
write_csv(men_ncd_total, "../data/processed/men_ncd_total_bp.csv")
