pacman::p_load(lavaan, blavaan, here, semPlot)

data <- HolzingerSwineford1939

fit_configural <- sem(
  model = readLines(here("models","HS_model.txt")),
  data = data,
  std.lv = T,
  group = "school"
)

fit_metric <- sem(
  model = readLines(here("models","HS_model.txt")),
  data = data,
  std.lv = T,
  group = "school",
  group.equal = c("loadings")
)

fit_scalar <- sem(
  model = readLines(here("models","HS_model.txt")),
  data = data,
  std.lv = T,
  group = "school",
  group.equal = c("loadings","intercepts")
)

fit_strict <- sem(
  model = readLines(here("models","HS_model.txt")),
  data = data,
  std.lv = T,
  group = "school",
  group.equal = c("loadings","intercepts","residuals")
)

fit_stricter <- sem(
  model = readLines(here("models","HS_model.txt")),
  data = data,
  std.lv = T,
  group = "school",
  group.equal = c("loadings","intercepts","residuals","lv.variances")
)

fit_strictest <- sem(
  model = readLines(here("models","HS_model.txt")),
  data = data,
  std.lv = T,
  group = "school",
  group.equal = c("loadings","intercepts","residuals","lv.variances","lv.covariances")
)

fit_compromise <- sem(
  model = readLines(here("models","HS_model.txt")),
  data = data,
  std.lv = T,
  group = "school",
  group.equal = c("loadings","lv.variances","lv.covariances")
)

lavTestLRT(
  fit_configural,
  fit_metric,
  fit_scalar,
  fit_strict,
  fit_stricter,
  fit_strictest,
  fit_compromise
)

fitMeasures(fit_metric, fit.measures = c("chisq","df","pvalue","CFI","RMSEA"))
summary(fit_compromise, fit.measures = TRUE, standardized = TRUE)
