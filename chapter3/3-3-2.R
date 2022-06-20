# 3.3.2 ダービン - ワトソン検定

library(lmtest)

# AR(1)過程のシミュレーション
AR1_model <- list(order = c(1, 0, 0), ar = 0.9)
AR1_sm <- arima.sim(n = 100, model = AR1_model, sd = 1)
fit <- lm(AR1_sm ~1)

# ダービン-ワトソン検定
dwtest(fit)