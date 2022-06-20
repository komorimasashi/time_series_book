# 4.5.1 WAIC

N=100
Y= cumsum(rnorm(N)) # ランダムウォークの時系列を作成
# リスト化
dat <- list(N=N, Y=Y)

# Stanコードコンパイルと実行
model13 <- stan_model(file = "model13.stan", model_name="ssm13")
fit <- sampling(model13, data=dat, iter=4000, warmup=2000, thin=4, chains=4)
library(loo)
waic(extract_log_lik(fit))$estimates