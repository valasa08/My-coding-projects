# Set working directory where all input and output files are stored
setwd("/Users/chandramaharshivalasa/Dropbox/Historical Agricultural Statistics")

# Load required libraries for data handling and Excel I/O
library(readxl)
library(dplyr)
library(tidyr)
library(writexl)
library(haven)

# ------------------------------------------------------------
# 1. LOAD AND PREPARE COUNTRY CROSSWALK + CROP DATA
# ------------------------------------------------------------

# Read country crosswalk and align column name with crop dataset
country_crosswalk <- read_excel("country_crosswalk.xlsx") %>%
  rename(country = country_raw)

# Read raw crop dataset (contains both modern and historical country names)

crop_raw <- read_dta("updated_all_sources_master_new.dta")
str(crop_raw)


# Inspect column names (useful for debugging joins)
names(crop_raw)
names(country_crosswalk)

# Standardize country identifiers by merging with crosswalk
# Adds country_std (ISO3 or historical entity) and id_type
crop_clean <- crop_raw %>% 
  left_join(country_crosswalk, by = "country")

# ------------------------------------------------------------
# 2. BUILD YEAR-LEVEL HISTORICAL MEMBERSHIP TABLE
# ------------------------------------------------------------

# Read historical membership ranges (start_year, end_year)
membership_ranges <- read_excel("historical_membership.xlsx")

# Expand ranges into year-level data
# Creates one row per (historical entity × ISO3 × year)
membership_yearly <- membership_ranges  %>%
  rename(iso3 = ISO3) %>%
  rowwise()  %>%
  mutate(year = list(seq(start_year, end_year)))  %>%
  unnest(year)  %>%
  ungroup()



# ------------------------------------------------------------
# 3. CLEAN AGRICULTURAL LAND DATA
# ------------------------------------------------------------

# Read agricultural land dataset
agland_raw <- read_dta("Total_Crop_land.dta")

# Ensure one observation per (iso3, year)
# If duplicates exist, take mean agricultural land
agland_clean <- agland_raw  %>%
  rename(iso3 = ISO3_string)  %>%
  group_by(iso3, year)  %>%
  summarise(
    agland = mean(Tot_Crop_land, na.rm = TRUE),
    .groups = "drop"
  )
str(agland_raw)

# ------------------------------------------------------------
# 4. CONSTRUCT TIME-VARYING CROSSWALK (ALLOCATION WEIGHTS)
# ------------------------------------------------------------

# Merge membership with agland to compute land shares
# share_agland = country's agland / total agland of historical entity
crosswalk_tv <- membership_yearly %>%
  left_join(agland_clean, by = c("iso3", "year")) %>%
  group_by(Historical_countries, year) %>%
  mutate(
    total_agland = sum(agland, na.rm = TRUE),
    share_agland = if_else(total_agland > 0, agland / total_agland, NA_real_)
  ) %>%
  ungroup()

# ------------------------------------------------------------
# 5. SPLIT DATA INTO HISTORICAL AND MODERN OBSERVATIONS
# ------------------------------------------------------------

# Identify all historical entities
hist_entities <- unique(membership_yearly$Historical_countries)

# Historical observations (to be allocated)
crop_hist <- crop_clean |>
  filter(country_std %in% hist_entities)

# Modern observations (already ISO3)
crop_modern <- crop_clean |>
  filter(!(country_std %in% hist_entities))

# ------------------------------------------------------------
# 6. REMOVE OVERLAPPING OBSERVATIONS (AVOID DOUBLE COUNTING)
# ------------------------------------------------------------

# Identify modern country-years that overlap with historical aggregates
overlap_flags <- crop_hist |>
  rename(Historical_countries = country_std) |>
  inner_join(membership_yearly, by = c("Historical_countries", "year")) |>
  select(iso3, year) |>
  distinct()

# Remove overlapping rows from modern dataset
crop_modern_clean <- crop_modern |>
  anti_join(overlap_flags, by = c("country_std" = "iso3", "year"))

# ------------------------------------------------------------
# 7. SELECT VARIABLES TO ALLOCATE
# ------------------------------------------------------------

# Select only crop output and area variables
# Exclude non-comparable variables (e.g., livestock products)
alloc_vars <- names(crop_hist)[
  grepl("output|area", names(crop_hist), ignore.case = TRUE) &
    !grepl("milk|meat|butter|wool", names(crop_hist), ignore.case = TRUE)
]

# Print selected variables for verification
alloc_vars

# ------------------------------------------------------------
# 8. ALLOCATE HISTORICAL DATA TO MODERN COUNTRIES
# ------------------------------------------------------------

# Distribute historical observations using land shares
crop_hist_alloc <- crop_hist |>
  rename(Historical_countries = country_std) |>
  left_join(crosswalk_tv, by = c("Historical_countries", "year")) |>
  filter(!is.na(iso3), !is.na(share_agland)) |>
  mutate(
    across(all_of(alloc_vars), ~ .x * share_agland)
  ) |>
  rename(country_std = iso3)

# ------------------------------------------------------------
# 9. CREATE CONSISTENT COUNTRY NAMES (LATEST AVAILABLE)
# ------------------------------------------------------------

# For each ISO3, take the most recent country name available
country_name_latest <- bind_rows(
  crop_modern_clean,
  crop_hist_alloc
) |>
  filter(!is.na(country)) |>
  group_by(country_std) |>
  slice_max(order_by = year, n = 1, with_ties = FALSE) |>
  select(country_std, country)

# ------------------------------------------------------------
# 10. COMBINE AND AGGREGATE FINAL DATASET
# ------------------------------------------------------------

# Combine modern + allocated historical data
# Aggregate to one row per (country_std, year)
crop_final_additive <- bind_rows(
  crop_modern_clean,
  crop_hist_alloc
) |>
  group_by(country_std, year) |>
  summarise(
    across(all_of(alloc_vars), ~ sum(.x, na.rm = TRUE)),
    .groups = "drop"
  ) |>
  left_join(country_name_latest, by = "country_std") |>
  relocate(country, .before = country_std)

# ------------------------------------------------------------
# 11. CLEAN DATA: REPLACE ZERO VALUES WITH NA
# ------------------------------------------------------------

##For the all crop data that has zeros, it's being replaced by NA as the crop data was only built with the data available.
crop_final_additive <- crop_final_additive |>
  mutate(
    across(all_of(alloc_vars), ~ ifelse(.x == 0, NA, .x))
  )

# ------------------------------------------------------------
# 12. CREATE FULL COUNTRY–YEAR PANEL (1900–2010)
# ------------------------------------------------------------

# Define full year range
all_years <- 1900:2010

# Expand dataset to include all country-year combinations
crop_final_additive <- crop_final_additive |>
  complete(country_std, year = all_years)

# Bring country names back (since complete() may introduce NAs)
crop_final_additive <- crop_final_additive |>
  group_by(country_std) |>
  fill(country, .direction = "downup") |>
  ungroup()

write_xlsx(crop_final_additive, "crop_final_additive.xlsx")
View(crop_final_additive)

str(crop_final_additive$country_std)
df <- crop_final_additive %>%
  filter(is.na(country_std))













  

