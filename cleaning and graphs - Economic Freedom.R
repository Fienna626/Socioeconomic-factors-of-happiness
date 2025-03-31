### Read in CSV file for data cleaning in R

ndata <- read.csv("merged_all.csv",header=T)


### Review Dataset in R

head(ndata)
names(ndata)
dim(ndata)	
summary(ndata)
table(ndata)
str(ndata)
names (ndata)
list(ndata)


### Change catagorial variables to factors

ndata$ISO_code  <- as.factor(data$ISO_code)
ndata$countries <- as.factor(data$countries)
ndata$AVG.RANK <- as.factor(data$AVG.RANK)


### Correlation Matrix showing "Economic Freedom’s Effect on Financial Satisfaction and Subjective Health"

library(corrplot)
M <- cor(mtcars)
corrplot(M, method = "color")
cormat = cor(ndata[,c(5, 7, 9, 10)])
colnames(cormat) <- c("Subjective Health", "Financial Satisfaction", "Temperature", "Economic Freedom", 1:4)
corrplot(cormat, method = "number")
summary(cormat)


### Regression Analysis of "Economic Freedom’s Effect on Financial Satisfaction and Subjective Health"

lm(formula = ECONOMIC.FREEDOM_scaled ~ financial_satisfaction_scaled + subjective_health_scaled, data = ndata)
m1 = lm(formula = ECONOMIC.FREEDOM_scaled ~ financial_satisfaction_scaled + subjective_health_scaled, data = ndata)
summary(m1)
