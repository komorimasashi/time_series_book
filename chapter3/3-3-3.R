# 3.3.3 一般化最小二乗法

library(lmtest)
library(nlme)

set.seed(1234)
n=50 # 50時点のデータを作成します
x <- seq(50)
# AR(1)過程のシミュレーション
AR1_model <- list(order = c(1, 0, 0), ar = 0.9)
AR1_sm <- arima.sim(n = n, model = AR1_model, sd = 1)
ts.plot(AR1_sm)
# 普通にOLSで回帰分析を行います
fit.lm <- lm(AR1_sm ~ x)
# 残差の自己相関
acf(fit.lm$residuals)
# ダービン-ワトソン検定
dwtest(fit.lm)

# 一般化最小二乗法（GLS）で回帰分析
# correlationパラメータには残差の分散共分散行列のモデルを指定できる
# corAR1()は残差がAR(1)に従うという意味
fit.gls <- gls(AR1_sm ~ x, correlation = corAR1())
# fit.gls <- gls(AR1_sm ~ x, correlation = corARMA(p=1, q=0))　と書いてもよい
summary(fit.gls)

# OLSとGLSの回帰直線の違いを見る
plot(x, AR1_sm, pch=20)
lines(x, predict(fit.lm), col=1, lty=1)
lines(x, predict(fit.gls), col=2, lty=1)
legend("topleft", legend=c("DATA","OLS", "GLS"), col=c(1,1,2),pch=c(20,NA,NA),lty=c(0,1,1))
