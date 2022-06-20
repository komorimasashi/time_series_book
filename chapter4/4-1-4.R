# 4.1.4 RStan の使い方

# 体重仮想データ
Y <- c(69.9, 69.3, 69.8, 70.4, 70.6, 70.3, 69.9, 69.6, 69.1, 69.5,
       70.1, 70.3, 71.0,69.9, 69.8, 70.1, 69.8, 69.7, 69.3, 69.1)

library(rstan) # ライブラリの読み込み

dat <- list(T=length(Y), Y=Y) # データはlist型にする

# Stanコードのコンパイル
model1 <- stan_model("model1.stan", model_name="ssm1")
# MCMCの実行
fit <- sampling(model1, data=dat, iter=4000, warmup=2000, thin=4,chains=4)
summary(fit)

# 収束診断
summary_fit <- summary(fit)$summary[,"Rhat"]
summary_fit[summary_fit > 1.1] # 収束していれば何も表示されない

# 事後期待値（EAP）と確信区間の算出
resultMCMC <- rstan::extract(fit)
mu_EAP <- apply(resultMCMC$mu,2,mean)
# 下側2.5%点
muLower95 <- apply(resultMCMC$mu,2,function(x) quantile(x,0.025))
# 上側2.5%点
muUpper95 <- apply(resultMCMC$mu,2,function(x) quantile(x,0.975))

# プロット(95%確信区間もプロットする)
result <- data.frame(Day=1:20,EAP=mu_EAP, lower=muLower95, upper=muUpper95)
g <- ggplot(data=result, aes(x=Day, y=EAP))
g <- g + geom_line(aes(y=EAP), lwd=.5)
g <- g +geom_ribbon(aes(ymin=lower,ymax=upper), alpha=.3)
plot(g)

# 事後分布の密度
stan_dens(fit, pars="sigma_u", separate_chains = TRUE)

# サンプリングの軌跡
stan_trace(fit, pars="sigma_u",inc_warmup =T)

# 事後分布の密度
stan_dens(fit, pars="y_pred", separate_chains = FALSE)

