# 4.4.2 変化点モデル

# データの作成
set.seed(9999)
N <- 100  # 期間
cp <- 50
mu_0 <- 0     # 状態初期値
sigma_W <- .1  # システムノイズの標準偏差
sigma_O <- .1  # 観測ノイズの標準偏差
a <- 3  #　介入効果の大きさ

# 状態の初期値
mu <- y <- rep(NA, N)
mu[1] <- mu_0

#change pointが発生する日
cp <- 50

# データの生成
for(i in 2:N){
  if(i == cp){
    mu[i] <- rnorm(n = 1, mean = mu[i-1] + a, sd = sigma_W)
  }else{
    mu[i] <- rnorm(n = 1, mean = mu[i-1], sd = sigma_W)
  }
}

for(i in 1:N){
  y[i] <- rnorm(n = 1, mean = mu[i], sd = sigma_O)
}
ts.plot(y)
dat <- list(N=N, Y=y)


# Stanの実行
model11 <- stan_model(file = "model11.stan", model_name="ssm11")
fit <- sampling(model11, data=dat, iter=8000, warmup=2000, thin=4, chains=4)
stan_dens(fit, pars="cp", separate_chains = FALSE)  +  scale_x_continuous(limits = c(48, 51)) #事後分布の密度

