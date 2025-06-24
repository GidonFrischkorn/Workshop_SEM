# set working directory to source file location
setwd(dirname(rstudioapi::getSourceEditorContext()$path))

library(lavaan)

data_LatChange <- read.table("LatChange_data.txt", header = TRUE, sep = "\t")

testModel <- readLines("LatChange Model.txt")

fit_LatChange <- sem(testModel, data_LatChange, estimator = "ML")
summary(fit_LatChange, fit.measures = TRUE, standardized = TRUE)