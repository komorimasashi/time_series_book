# 3.2.1 単位根過程

y <- cumsum(rnorm(100)) # ランダムウォーク
dy <- diff(y) # ランダムウォークの1階差分
par(mfrow = c(1,2))
ts.plot(y, main="random walk")
ts.plot(dy, main="white noise")


# 見せかけの回帰（何度か実行すると多くの場合に回帰係数が有意になることがわかります）
x <- cumsum(rnorm(100)) # ランダムウォーク
y <- cumsum(rnorm(100)) # ランダムウォーク
summary(lm(y~x)) # 最小二乗法による回帰
