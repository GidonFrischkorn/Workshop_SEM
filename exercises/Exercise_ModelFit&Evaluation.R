pacman::p_load(lavaan, here)

sample_size <- 1000

# Step 1: Simulate data --------------------------------------------------------
models <- paste0("ModelFit_GenModel",1:4,".txt")

# sample random model
genModel <- readLines(here("models",models[1]))

# simulate Data
simData <- simulateData(model = genModel, sample.nobs = sample_size)

# Step 2: Fit Models -----------------------------------------------------------

model1 <- readLines(here("models","ModelFit_Model1.txt"))
model2 <- readLines(here("models","ModelFit_Model2.txt"))
model3 <- readLines(here("models","ModelFit_Model3.txt"))
model4 <- readLines(here("models","ModelFit_Model4.txt"))

fit_model1 <- sem(model = model1, data = simData, std.lv = TRUE)
fit_model2 <- sem(model = model2, data = simData, estimator = "ml")
fit_model3 <- sem(model = model3, data = simData, estimator = "ml")
fit_model4 <- sem(model = model4, data = simData, estimator = "ml")

parameterEstimates(fit_model1)
parameterEstimates(fit_model2)
parameterEstimates(fit_model3)
parameterEstimates(fit_model4)

fitMeasures(fit_model1, fit.measures = c("chisq","df","pvalue","CFI","RMSEA"))
fitMeasures(fit_model2, fit.measures = c("chisq","df","pvalue","CFI","RMSEA"))
fitMeasures(fit_model3, fit.measures = c("chisq","df","pvalue","CFI","RMSEA"))
fitMeasures(fit_model4, fit.measures = c("chisq","df","pvalue","CFI","RMSEA"))

lavTestLRT(fit_model1,fit_model2,fit_model3,fit_model4)

summary(fit_model1)
summary(fit_model2)
summary(fit_model3)
summary(fit_model4)
