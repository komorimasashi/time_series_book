# 2.6.1　ARモデル

# ARモデル
model.small <- list(order = c(1, 0, 0), ar = 0.1, sd = 0.1)　 #AR(1)モデル（φ=0.1）
model.large <- list(order = c(1, 0, 0), ar = 0.9, sd = 0.1)　 #AR(1)モデル（φ=0.9）
AR1.small <- arima.sim(n = 500, model = model.small)  #数値シミュレーション
AR1.large <- arima.sim(n = 500, model = model.large)  #数値シミュレーション

# 描画のセットアップ
par(mfrow = c(2, 2))
ylm <- c(min(AR1.small, AR1.large), max(AR1.small, AR1.large))
# 時系列の描画
plot.ts(AR1.small, ylim = ylm, ylab = expression(italic(y)[italic(t)]), main = expression(paste(phi, " = 0.1")))
plot.ts(AR1.large, ylim = ylm, ylab = expression(italic(y)[italic(t)]), main = expression(paste(phi, " = 0.9")))

# 自己相関関数
acf(AR1.small, main="")
acf(AR1.large, main="")
