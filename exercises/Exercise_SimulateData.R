pacman::p_load(lavaan, here)

# read model syntax
my_model <- readLines(here("models","SimModel_Parameters.txt"))

# simulate data
my_data <- simulateData(model = my_model, sample.nobs = 200)

# check empirical covariance structure
cov(my_data)

# check model implied covariance structure
fitted(sem(my_model))

# correlation among aggregated X and X
my_data$X = rowMeans(my_data[,c("X1","X2","X3")])
my_data$Y = rowMeans(my_data[,c("Y1","Y2","Y3")])

agg_corr <- cor(my_data[,c("X","Y")])
agg_corr[1,2]

# reliability of X and Y means
alpha_Xmean <- psych::alpha(my_data[,c("X1","X2","X3")])
alpha_Ymean <- psych::alpha(my_data[,c("Y1","Y2","Y3")])

# correlation corrected for attenuation
agg_corr[1,2]/sqrt(alpha_Xmean$total$raw_alpha * alpha_Ymean$total$raw_alpha)
