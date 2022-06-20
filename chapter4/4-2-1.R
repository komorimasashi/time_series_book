# 4.2.1 状態空間モデルの基本的な書き方

# 仮想データの作成
set.seed(1234)
N <- 100 # 期間
mu_0 <- 0 # 状態初期値
mu_T <- 0 # トレンドの平均値
sigma_O <- .1 # 観測ノイズの標準偏差
sigma_W <- .1 # システムノイズの標準偏差
sigma_T <- .1 #トレンドの標準偏差
mu <- numeric(N)
# 初期値
mu[1] <- mu_0
# 傾き
trend <- rnorm(n = N-1, mean = mu_T, sd = sigma_T)
for(i in 2:N){
  mu[i] <- rnorm(n = 1, mean = mu[i-1] + trend[i-1] , sd = sigma_W)
}
# 周期成分を適当に作成しこれを季節成分とする
# 12ヵ月周期のフーリエ級数の第2調和まで考慮している
# 100ヵ月分の周期成分を作成
p <- numeric(N)
t <- 1:12
for(i in 1:2){
  p <- (runif(1)*2-1) * cos(i*t) + (runif(1)*2-1) * sin(i*t) + p
}
y <- rnorm(n = N, mean = mu+p, sigma_O)
ts.plot(y)
# リスト化
#本では「N_pred = 20」（予測のための日数の設定）は割愛されています
dat <- list(N=length(y), Y=y, N_pred = 20)  


# Stanコードコンパイルと実行
model3 <- stan_model(file = "model3.stan", model_name="ssm3")
fit3 <- sampling(model3, data=dat, iter=4000, warmup=2000, thin=4, chains=4)
model4 <- stan_model(file = "model4.stan", model_name="ssm4")
fit4 <- sampling(model4, data=dat, iter=4000, warmup=2000, thin=4, chains=4)
model5 <- stan_model(file = "model5.stan", model_name="ssm5")
fit5 <- sampling(model5, data=dat, iter=4000, warmup=2000, thin=4, chains=4)


#予測と作図（本にはソースコードは掲載されていません）
# 図 4.11 ローカルレベルモデル（上）
resultMCMC <- rstan::extract(fit3)
mu_EAP <- apply(resultMCMC$mu_all,2,mean)
muLower80 <- apply(resultMCMC$mu_all,2,function(x) quantile(x,0.1))  #上側2.5%点
muUpper80 <- apply(resultMCMC$mu_all,2,function(x) quantile(x,0.9))  #下側2.5%点
muLower95 <- apply(resultMCMC$mu_all,2,function(x) quantile(x,0.025))  #上側2.5%点
muUpper95 <- apply(resultMCMC$mu_all,2,function(x) quantile(x,0.975))  #下側2.5%点

# プロット(95%信用区間もプロットする)
result <- data.frame(Time=1:(dat$N +dat$N_pred),
                     EAP=mu_EAP, lower80=muLower80, upper80=muUpper80, lower95=muLower95, upper95=muUpper95)
g <- ggplot(data=result, aes(x=Time, y=EAP))
g <- g + geom_line(aes(y=EAP), lwd=.5)
g <- g +geom_ribbon(aes(ymin=lower80,ymax=upper80), alpha=.3) +geom_ribbon(aes(ymin=lower95,ymax=upper95), alpha=.1)
g <- g + geom_vline(xintercept=100,linetype="dashed",size=.3)
g <- g + scale_y_continuous(limits = c(-5, 3))
plot(g)


# 図 4.11 ローカル線形トレンドモデル（中）
# 事後期待値（EAP）と信頼区間の算出
resultMCMC <- rstan::extract(fit4)
mu_EAP <- apply(resultMCMC$mu_all,2,mean)
muLower80 <- apply(resultMCMC$mu_all,2,function(x) quantile(x,0.1))  #上側2.5%点
muUpper80 <- apply(resultMCMC$mu_all,2,function(x) quantile(x,0.9))  #下側2.5%点
muLower95 <- apply(resultMCMC$mu_all,2,function(x) quantile(x,0.025))  #上側2.5%点
muUpper95 <- apply(resultMCMC$mu_all,2,function(x) quantile(x,0.975))  #下側2.5%点

# プロット(95%信用区間もプロットする)
result <- data.frame(Time=1:(dat$N +dat$N_pred),
                     EAP=mu_EAP, lower80=muLower80, upper80=muUpper80, lower95=muLower95, upper95=muUpper95)
g <- ggplot(data=result, aes(x=Time, y=EAP))
g <- g + geom_line(aes(y=EAP), lwd=.5)
g <- g +geom_ribbon(aes(ymin=lower80,ymax=upper80), alpha=.3) +geom_ribbon(aes(ymin=lower95,ymax=upper95), alpha=.1)
g <- g + geom_vline(xintercept=100,linetype="dashed",size=.3)
g <- g + scale_y_continuous(limits = c(-5, 3))
plot(g)


# 図 4.11 季節成分を考慮したローカルレベルモデル（下）
# 事後期待値（EAP）と信頼区間の算出
resultMCMC <- rstan::extract(fit5)
y_mean_EAP <- apply(resultMCMC$y_mean_all,2,mean)
y_meanLower80 <- apply(resultMCMC$y_mean_all,2,function(x) quantile(x,0.1))  #上側2.5%点
y_meanUpper80 <- apply(resultMCMC$y_mean_all,2,function(x) quantile(x,0.9))  #下側2.5%点
y_meanLower95 <- apply(resultMCMC$y_mean_all ,2,function(x) quantile(x,0.025))  #上側2.5%点
y_meanUpper95 <- apply(resultMCMC$y_mean_all,2,function(x) quantile(x,0.975))  #下側2.5%点

# プロット(95%信用区間もプロットする)
result <- data.frame(Time=1:(dat$N +dat$N_pred),
                     EAP=y_mean_EAP, lower80=y_meanLower80, upper80=y_meanUpper80, lower95=y_meanLower95, upper95=y_meanUpper95)
g <- ggplot(data=result, aes(x=Time, y=EAP))
g <- g + geom_line(aes(y=EAP), lwd=.5)
g <- g +geom_ribbon(aes(ymin=lower80,ymax=upper80), alpha=.3) +geom_ribbon(aes(ymin=lower95,ymax=upper95), alpha=.1)
g <- g + geom_vline(xintercept=100,linetype="dashed",size=.3)
g <- g + scale_y_continuous(limits = c(-5, 3))
plot(g)

