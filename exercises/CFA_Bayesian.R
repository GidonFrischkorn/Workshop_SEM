pacman::p_load(lavaan, blavaan, here, semPlot)

data <- HolzingerSwineford1939

fit_nullModel <- bcfa(model = readLines(here("models","HS_NullModel.txt")),
                      data = data, std.lv = T, sample = 2000)

fit_3factor <- bcfa(model = readLines(here("models","HS_model.txt")),
                    data = data, std.lv = T, sample = 2000)

blavFitIndices(fit_3factor,
               baseline.model = fit_nullModel)

summary(fit_3factor, standardized = TRUE)

fit_singleFactor <- bcfa(model = readLines(here("models","HS_singleFactor.txt")),
                         data = data, std.lv = T, sample = 2000)
blavFitIndices(fit_singleFactor,
               baseline.model = fit_nullModel)

blavCompare(fit_3factor,fit_singleFactor)

fit_hierarchical <- bcfa(model = readLines(here("models","HS_hierarchical.txt")),
                         data = data, std.lv = T,
                         sample = 2000)
blavFitIndices(fit_hierarchical,
               baseline.model = fit_nullModel)
summary(fit_hierarchical)
semPaths(fit_hierarchical)

blavCompare(fit_3factor, fit_hierarchical)

fit_bifactor <- bcfa(model = readLines(here("models","HS_Bifactor.txt")),
                     data = data, std.lv = T, orthogonal = TRUE,
                     sample = 2000)
blavFitIndices(fit_bifactor,
               baseline.model = fit_nullModel)
summary(fit_bifactor)

semPaths(fit_bifactor)

blavCompare(fit_bifactor, fit_hierarchical)
