pacman::p_load(lavaan, here)

# read model syntax
my_model <- readLines(here("models","SimModel_Parameters.txt"))
fit_model <- "
varX =~ X1 + X2 + X3
varY =~ Y1 + Y2 + Y3
"

n_repetitions <- 500

observed_correlations <- numeric(n_repetitions)
corrected_correlations <- numeric(n_repetitions)
sem_correlations <- numeric(n_repetitions)

for (i in 1:length(my_correlations)) {
  # simulate data
  my_data <- simulateData(model = my_model, sample.nobs = 100)

  # check empirical covariance structure
  cov(my_data)

  # correlation among aggregated X and X
  my_data$X = rowMeans(my_data[,c("X1","X2","X3")])
  my_data$Y = rowMeans(my_data[,c("Y1","Y2","Y3")])

  agg_corr <- cor(my_data[,c("X","Y")])
  observed_correlations[i] <- agg_corr[1,2]

  # reliability of X and Y means
  alpha_Xmean <- psych::alpha(my_data[,c("X1","X2","X3")], max = 2000, warnings = F)
  alpha_Ymean <- psych::alpha(my_data[,c("Y1","Y2","Y3")], max = 2000, warnings = F)

  # correlation corrected for attenuation
  corrected_correlations[i] <- agg_corr[1,2]/
    sqrt(alpha_Xmean$total$raw_alpha * alpha_Ymean$total$raw_alpha)

  # check model implied covariance structure
  my_fit <- sem(fit_model, data = my_data, std.lv = T)

  parEst <- parameterEstimates(my_fit)
  parEst <- subset(parEst, op == "~~" & lhs == "varX" & rhs == "varY")
  sem_correlations[i] <- parEst$est
}

hist(observed_correlations - 0.6, breaks = 20)
mean(observed_correlations - 0.6)
sd(observed_correlations - 0.6)

hist(corrected_correlations - 0.6, breaks = 20)
mean(corrected_correlations - 0.6)
sd(corrected_correlations-0.6)

hist(sem_correlations - 0.6, breaks = 20)
mean(sem_correlations - 0.6)
sd(sem_correlations - 0.6)


