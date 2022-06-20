# 4.1.5 欠損値の補間と将来の予測は同じ

# 体重仮想データ
Y <- c(69.9, 69.3, 69.8, 70.4, 70.6, 70.3, 9999, 69.6, 69.1, 69.5,
       70.1, 70.3,71.0, 9999, 69.8, 70.1, 69.8, 69.7, 69.3, 69.1)
dat <- list(T=length(Y), P=10, Y=Y) # データはリスト型にする

# Stanコードのコンパイル
model2 <- stan_model(file ="model2.stan", model_name="ssm2")

# MCMCの実行
fit <- sampling(model2, data=dat, iter=4000, warmup=2000, thin=4,chains=4)


# 図4.9の作図（本には掲載されていない部分）
# 事後期待値（EAP）と確信区間の算出
resultMCMC <- rstan::extract(fit)
mu_EAP <- apply(resultMCMC$mu,2,mean)
# 下側2.5%点
muLower95 <- apply(resultMCMC$mu,2,function(x) quantile(x,0.025))
# 上側2.5%点
muUpper95 <- apply(resultMCMC$mu,2,function(x) quantile(x,0.975))

# プロット(95%確信区間もプロットする)
result <- data.frame(Day=1:30,EAP=mu_EAP, lower=muLower95, upper=muUpper95)
g <- ggplot(data=result, aes(x=Day, y=EAP))
g <- g + geom_line(aes(y=EAP), lwd=.5)
g <- g +geom_ribbon(aes(ymin=lower,ymax=upper), alpha=.3)
plot(g)