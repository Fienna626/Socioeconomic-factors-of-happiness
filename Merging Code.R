library(readxl)
library(writexl)

df2 <- read_xlsx("merged_data.xlsx")
df1 <- read_csv("efw_cc - clean.csv")

merged_df <- merge(df1, df2, by = "COUNTRY_ISO")

write_csv(merged_df, "merged_data.csv")