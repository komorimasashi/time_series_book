# 3.6 潜在成長曲線モデル

# データセットの準備
library(nlme)
dat <-BodyWeight[BodyWeight$Diet==1|BodyWeight$Diet==2,]
dat <-dat[dat$Time != 44,] # 等間隔で記録されていないデータを除外
dat$Time <- (dat$Time-1)/7 # 週の値に変換
dat <- data.frame(dat)

# ランダム切片モデル
library(nlme)
lme(weight ~ 1, random = ~ 1 | Rat, data=dat)
# library(lme4) # {lme4}で書く場合
# lmer(weight ~ 1 + (1 | Rat), data = dat)

# 残差の系列相関を考慮しない潜在成長曲線モデル
fit1 <- lme(weight ~ Time*Diet, random = ~ Time | Rat, data=dat)
plot(ACF(fit1), alpha = 0.01)

# 残差の系列相関を考慮した潜在成長曲線モデル
fit2 <- lme(weight ~ Time*Diet, random = ~ Time | Rat,
            correlation = corAR1(form=~Time|Rat), data=dat)
summary(fit2)
