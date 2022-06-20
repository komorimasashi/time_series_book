# 3.7 中断時系列デザイン

# データの準備
fileURL <- "https://raw.githubusercontent.com/gasparrini/2017_lopezbernal_IJE_codedata/master/sicily.csv"
data <- data.frame(read.csv(fileURL, header=T))

# 一般線形モデル（線形回帰）介入×時間

# 傾きの変化を考慮したモデル
fit1 <- glm(aces ~ smokban * time , family=gaussian, data)

# 傾きの変化を考慮しないモデル
# fit1 <- glm(aces ~ smokban + time , family=gaussian, data)

summary(fit1)

# 描画
pred1 <- predict(fit1) # 予測
plot(data$aces, ylim=c(0,1000),xlab="Time", ylab="ACEs")
points(pred1, col=2, type="l")

# 自己相関関数
acf(fit1$residuals)


# 一般線形モデル（線形回帰）介入×時間＋季節成分
library(tsModel)
# harmonic(time,2,12)の2番目の引数で調和数，3番目の引数で周期を指定します
fit2 <- glm(aces ~ smokban * time + harmonic(time,2,12) , family=gaussian, data)
summary(fit2)

# 描画
pred2 <- predict(fit2)
plot(data$aces, ylim=c(0,1000))
points(pred2, col=2, type="l")

# ダービン-ワトソン検定
library(lmtest)
dwtest(fit2)


# 一般線形モデル（ポアソン回帰）介入×時間
fit3 <- glm(aces ~ smokban*time, family=poisson(link="log"), data)
summary(fit3)
# 描画
pred3 <- predict(fit3)
plot(data$aces, ylim=c(0,1000))
points(exp(pred3), col=2, type="l")
acf(fit3$residuals)


# 一般線形モデル（ポアソン回帰）介入×時間＋季節成分
fit4 <- glm(aces ~ smokban*time + harmonic(time,2,12), family=poisson(link="log"), data)
summary(fit4)


# 一般線形モデル（ポアソン回帰）オフセット項+介入×時間＋季節成分
# 人口stdpopをオフセット項として投入している
fit5 <- glm(aces ~ offset(log(stdpop)) + smokban*time + harmonic(time,2,12),family=poisson(link="log"), data)
summary(fit5)

# 描画
pred5 <- predict(fit5)
plot(data$aces, ylim=c(0,1000))
points(exp(pred5), col=2, type="l")
acf(fit5$residuals)