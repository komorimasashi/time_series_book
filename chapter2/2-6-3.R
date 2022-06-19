# 2.6.3　ARMA，ARIMA，ARIMAXモデル

library(forecast)

# ARIMAモデル
# アスワンでのナイル川の流量　1871-1970.
data <-ts(Nile, start=1871)
plot(data, main="Flow of the river Nile")
# モデル選択
model <- auto.arima(data, ic="aic", stepwise=T, trace=T)
# 分析結果
summary(model)
# 予測値と信頼区間のプロット（20時点）
plot(forecast(model, level = c(50,95), h =20), shadecols=c("gray","darkgray"))

# ARIMAXモデル
# 外生変数（ダムなし: 1871-1901(31年間)，ダムあり: 1902-1970(69年間)
x <- ts(c(rep(0,31), rep(1,69)))
# モデル選択(xregに外生変数を入れる)
modelx <- auto.arima(data, xreg=x, ic="aic", stepwise=T, trace=T)
summary(modelx)

# ダムが取り壊された場合の将来予測
x_pred <- rep(0, 20) # ダムが取り壊されたと考える（20年分）
plot(forecast(modelx, level = c(50,95), h = 20, xreg = x_pred), shadecols=c("gray", "darkgray"))