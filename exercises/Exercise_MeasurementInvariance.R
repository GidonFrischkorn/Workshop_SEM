pacman::p_load(lavaan, blavaan, here, semPlot)

data <- HolzingerSwineford1939

model_syntax <- readLines(here("models","HS_model.txt"))

fit_configural <- sem(
  model = model_syntax,
  data = data,
  group = "school"
)

fit_metric <- sem(
  model = model_syntax,
  data = data,
  group = "school",
  group.equal = c("loadings")
)

fit_scalar <- sem(
  model = model_syntax,
  data = data,
  group = "school",
  group.equal = c("loadings","intercepts"),
)

summary(fit_metric)

fit_strict <- sem(
  model = model_syntax,
  data = data,
  group = "school",
  group.equal = c("loadings","intercepts","residuals")
)

fit_stricter <- sem(
  model = model_syntax,
  data = data,
  group = "school",
  group.equal = c("loadings","intercepts","residuals","lv.variances")
)

fit_strictest <- sem(
  model = model_syntax,
  data = data,
  group = "school",
  group.equal = c("loadings","intercepts","residuals","lv.variances","lv.covariances")
)

fit_compromise <- sem(
  model = model_syntax,
  data = data,
  group = "school",
  group.equal = c("loadings","residuals","lv.variances","lv.covariances")
)

lavTestLRT(
  fit_configural,
  fit_metric,
  fit_scalar,
  fit_strict,
  fit_stricter,
  fit_strictest
)

lavTestLRT(
  fit_configural,
  fit_metric,
  fit_compromise
)

fitMeasures(fit_compromise, fit.measures = c("chisq","df","pvalue","CFI","RMSEA"))
summary(fit_compromise, fit.measures = TRUE, standardized = TRUE)
