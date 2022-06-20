# 5.9 グレンジャー因果性検定と VAR モデル

library(tsDyn)
library(vars)

# 5.9.1 VAR モデル
# 仮想時系列データの作成
# 係数行列
B<-matrix(c(10,20,0.3,-0.5,0.6,0.5), 2)
# 初期値
S <- matrix(c(25,10),1)
# 撹乱項の分散共分散行列
V <- matrix(c(1,0.8,0.8,1), nrow=2, ncol=2)
# include="const"で切片(定数項)ありのモデルでデータを作成
set.seed(9999)
dat <- VAR.sim(B=B, n=100, lag=1, include="const", starting = S, varcov = V)
df <- data.frame(y1 = dat[,1], y2=dat[,2])
# 作図
ts.plot(df, gpars=list(ylim=c(0,40), col=c(1:2)))
legend("topright", legend = c("mood","activity"), lty=1, col=c(1:2))


# 5.9.2 VAR モデルの選択
VARselect(df, lag.max=5, type = "const")

var_model <- VAR(df, p=1, type = "const")
summary(var_model)

# ARモデルとVARモデルによる予測
library(forecast)
ar_model <-Arima(df$y1,order=c(1,0,0), include.constant = T)
df2 <- data.frame(y1 = dat[-1,1],
                  AR=ar_model$fitted[-1],
                  var_model$varresult$y1$fitted.values)
ts.plot(df2, gpars=list(ylim=c(22,30), col=c(1,2,4)))
legend("topright", legend = c("y1","AR(1)", "VAR(1)"), lty=1, col=c(1,2,4))


# 5.9.3 グレンジャー因果性検定
causality(var_model, cause = "y2") # y_2からy_1への因果性検定
causality(var_model, cause = "y1") # y_1からy_2への因果性検定


# 5.9.4 直交化インパルス応答関数
#（非直交化）インパルス応答関数
impulse_func <- irf(var_model, n.ahead=5, orth=FALSE)
plot(impulse_func)

# 直交化インパルス応答関数
ortho_impulse_func <- irf(var_model, n.ahead=5, orth=TRUE)
plot(ortho_impulse_func)