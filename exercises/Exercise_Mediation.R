pacman::p_load(lavaan, blavaan, here, semPlot)

?PoliticalDemocracy
data <- PoliticalDemocracy

model_syntax <- readLines(here("models","MediationModel.txt"))

fit_mediation <- sem(
  model = model_syntax,
  data = data,
  estimator = "ML"
)

summary(fit_mediation,
        fit.measures = TRUE,
        standardized = TRUE)
