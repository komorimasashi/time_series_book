# 3.5 時系列同士の回帰分析

library(MARSS)
library(tseries)
library(tsModel)
library(lmtest)
library(nlme)
library(CADFtest)
library(ggplot2)

# データセットの読み込み
data(lakeWAplankton)
plankdf <- as.data.frame(lakeWAplanktonTrans)

# 1980年から1990年までのデータを抜き出す
plankdf <-subset(plankdf, 1980<=Year & Year <=1990)

# 日付をPOSIXct型にする
plankdf$Time <- as.POSIXct(paste(plankdf$Year,plankdf$Month,1),format="%Y %m %d")

# 描画
g1 <- ggplot(plankdf, aes(x = Time, y = Cyclops))+ geom_line()
plot(g1)
g2 <- ggplot(plankdf, aes(x = Time, y = Temp))+ geom_line()
plot(g2)

# ADF検定（帰無仮説: 単位根を持つ）
CADFtest(plankdf$Temp, type='trend', max.lag.y=4, criterion='AIC')
CADFtest(plankdf$Cyclops, type='trend', max.lag.y=4, criterion='AIC')

# 季節成分を考慮しないOLS回帰
fit1 <- lm(Cyclops ~ Temp, plankdf )
summary(fit1)
acf(fit1$residuals)

# 季節成分を考慮したOLS回帰
fit2 <- lm(Cyclops ~ Temp+ harmonic(Month,2,12), plankdf )
summary(fit2)
acf(fit2$residuals)

# ダービン-ワトソン検定
dwtest(fit2)

# 季節成分を考慮したGLS回帰
fit3 <- gls(Cyclops~ Temp+ harmonic(Month,2,12),correlation = corAR1(),data=plankdf)
summary(fit3)
