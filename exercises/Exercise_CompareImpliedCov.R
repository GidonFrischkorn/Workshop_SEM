pacman::p_load(lavaan, here)

# Model 1 ----------------------------------------------------------------------
model1 <- readLines(here("models","ModelSpec_Model1.txt"))

# implied cov structure
cov2cor(fitted(sem(model1))$cov)


# Model 2 ----------------------------------------------------------------------
model2 <- readLines(here("models","ModelSpec_Model2.txt"))

data2 <- simulateData(model = model2, sample.nobs = 2000, std.lv = F)
cov(data2)

# implied cov structure
cov2cor(fitted(sem(model2))$cov)

# Model 3 ----------------------------------------------------------------------
model3 <- readLines(here("models","ModelSpec_Model3.txt"))

# implied cov structure
cov2cor(fitted(sem(model3))$cov)

# Model 4 ----------------------------------------------------------------------
model4 <- readLines(here("models","ModelSpec_Model4.txt"))

data4 <- simulateData(model = model4, sample.nobs = 2000)

# implied cov structure
cov2cor(fitted(sem(model4))$cov)
