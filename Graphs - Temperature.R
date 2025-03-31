# Load the necessary libraries
library(tidyverse)
library(readr)
library(corrplot)
library(ggplot2)
library(dplyr)
library(rworldmap)
library(RColorBrewer)

df <- read_csv("merged_all.csv")

# View the column names
colnames(df)

# Inspect the structure of the dataset
str(df)

# Select only the relevant columns
correlation_data <- df[, c("avg_temperature", "happiness", "subjective_health")]

# Rename the columns for custom labels
colnames(correlation_data) <- c("Temperature", "Happiness", "Subjective Health")

# Calculate the correlation matrix
correlation_matrix <- cor(correlation_data, use = "complete.obs")

# Print the correlation matrix
print(correlation_matrix)

# Create a correlation plot with a purple color palette
corrplot(correlation_matrix, method = "color", type = "upper", 
         col = brewer.pal(n = 8, name = "BuPu"),
         tl.col = "black", tl.srt = 45, 
         addCoef.col = "black")  # Add correlation coefficients as numbers

# Fit a linear model with multiple interactions
linear_model_multiple_interactions <- lm(avg_temperature ~ happiness + subjective_health, data = df)
summary(linear_model_multiple_interactions)

########################################World Map######################################

world_map_data <- df[, c("countries", "happiness")]

# Merge the data with the world map
map_data <- joinCountryData2Map(world_map_data, joinCode = "NAME", nameJoinColumn = "countries")

# Convert to sf object
install.packages("sf")
library(sf)
map_data_sf <- st_as_sf(map_data)

ggplot(map_data_sf) +
  geom_sf(aes(fill = happiness)) +
  scale_fill_gradientn(colors = brewer.pal(9, "YlGnBu"), na.value = "white", name = "Happiness Score") +
  theme_minimal() +
  labs(title = "World Happiness Heatmap") +
  theme(axis.text = element_blank(),
        axis.title = element_blank(),
        panel.grid = element_blank(),
        panel.background = element_blank())