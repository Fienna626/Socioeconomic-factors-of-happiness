library(tidyverse)
library(ggplot2)
library(dplyr)
library(writexl)
library(countrycode)

df <- read_csv("Country_Temp.csv")

head(df)

summary(df)

str(df)

colSums(is.na(df))
#Depending on what were doing i can drop state probably since that's the only one with data missing
#Its missing because other countries don't have states

# Get unique values from a specific column and sort them alphabetically
unique_sorted_values <- sort(unique(df$Region))  # Replace 'column_name' with your actual column name

# Print the sorted unique values
print(unique_sorted_values)

###########################################Time to break things down###########################

df <- df[, !(colnames(df) %in% c("Region","City", "State", "Month", "Day"))]
summary(df)

filtered_df <- df[df$Year >= 2010 & df$Year <= 2014, ]

str(filtered_df)

avg_temp_per_country <- filtered_df %>%
  group_by(Country) %>%          # Replace 'Country' with the actual column name for countries
  summarise(avg_temperature = mean(AvgTemperature, na.rm = TRUE))

# View the result
print(avg_temp_per_country)

###################################Add country code#####################################

avg_temp_per_country$ISO_Code <- countrycode(avg_temp_per_country$Country, "country.name", "iso3c")
head(avg_temp_per_country)

###################################Cleanign and filtering done so saving ###########

write_csv(avg_temp_per_country, "AvgTemp.csv")