# 4.4.3 隠れマルコフモデル

# 仮想データの作成
set.seed(1234)
N <- 50 # 50時点のデータを作成します
# 仮想データの遷移確率
P <- matrix(c(0.8, 0.1, 0.2,
              0.1, 0.8, 0.2,
              0.1, 0.1, 0.6), ncol = 3)
# レジームごとの潜在変数の値
mu <- c(0, 5.0, 10.0)
# レジームごとの観測ノイズ
sigma <- c(1.0, 1.0, 1.0)
# 仮想データの作成
y <- z <- rep(NA, N)
# レジームの遷移
z[1] <- sample(x=c(1,2,3), size=1, replace = T, prob=c(1/3,1/3,1/3))
for (i in 2:N){
  z[i] <- sample(x=c(1,2,3), size=1, replace = T, prob=P[z[i-1], ])
}
# 観測ノイズを加えて観測値を生成する
for(i in 1:N)
  y[i] <- rnorm(1, mu[z[i]], sigma[z[i]])


# リスト化
dat <- list(K=3,
            N=N,
            Y=y,
            alpha =c(1/3, 1/3, 1/3)
)


# Stanコードコンパイルと実行
model12 <- stan_model(file = "model12.stan", model_name="hmm")
fit <- sampling(model12, data=dat, iter=6000, warmup=3000, thin=5,chains=4)
resultMCMC <- rstan::extract(fit)

# 最頻値を求める関数
statmode <- function(x) {
  names(which.max(table(x)))
}
state <- apply(resultMCMC$y_star,2,statmode)
# 作図（黒線が真の状態，赤線が推定された状態）
ts.plot(as.ts(z), as.ts(state), col=c(1:2))
