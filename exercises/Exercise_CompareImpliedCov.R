pacman::p_load(lavaan, here)

# Model 1 ----------------------------------------------------------------------
model1 <- readLines(here("models","ModelSpec_Model1.txt"))

# implied cov structure
cov2cor(fitted(sem(model1))$cov)


# Model 2 ----------------------------------------------------------------------
model2 <- readLines(here("models","ModelSpec_Model2.txt"))

# implied cov structure
cov2cor(fitted(sem(model2))$cov)

# Model 3 ----------------------------------------------------------------------
model3 <- readLines(here("models","ModelSpec_Model3.txt"))

# implied cov structure
cov2cor(fitted(sem(model3))$cov)

# Model 4 ----------------------------------------------------------------------
model4 <- readLines(here("models","ModelSpec_Model4.txt"))

# implied cov structure
cov2cor(fitted(sem(model4))$cov)
