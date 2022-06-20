# 4.3.3 観測値がポアソン分布に従うモデル

# データの準備
set.seed(1234)
N <- 60 #期間
#周期成分を適当に作成しこれを季節成分とする
#１２ヶ月周期のフーリエ級数の第2調和まで考慮している
#5年分の周期成分を作成
set.seed(1234)
p <- numeric(60)
t <- 1:12
for(i in 1:2){
  p <- (runif(1)*2-1) * cos(i*t) + (runif(1)*2-1) * sin(i*t) + p
}

#介入系列
IV <- c(rep(0,30), rep(1,30)) 
mu_0 <- 1     # 状態初期値
sigma_W <- 0.1  # muの標準偏差
sigma_A <- 0.1  #介入効果の標準偏差
mu_A <- 1 #介入効果の平均値
#介入効果
a <- rnorm(n = N, mean = mu_A, sd = sigma_A) * IV
mu = rnorm(n = N, mean = mu_0 , sd = sigma_W)
observation <- rpois(n = N, lambda = exp(mu+p+a) )
ts.plot(observation)
rect(30,-1,60,0,col=grey(0.5),border=F)


# Stanの実行 
dat <- list(N=N, Y=observation, IV= IV)
model10 <- stan_model(file = "model10.stan", model_name="ssm10")
fit <- sampling(model10, data=dat, iter=8000, warmup=2000, thin=4, chains=4)


# 介入効果の検討
# 収束診断
summary_fit <- summary(fit)$summary[,"Rhat"]
summary_fit[summary_fit > 1.1]  #収束していれば何も表示されない

#介入効果
stan_dens(fit, pars="k", separate_chains = FALSE) #事後分布の密度
sprintf("k: %.3f (95%%CI= (%f, %.3f] )",
        summary(fit)$summary["k","50%"],
        summary(fit)$summary["k","2.5%"],
        summary(fit)$summary["k","97.5%"]
)


# 予測分布
resultMCMC <- rstan::extract(fit)
y_PRED <- apply(resultMCMC$y_pred,2,mean)
yLower95 <- apply(resultMCMC$y_pred,2,function(x) quantile(x,0.025))  #下側2.5%点
yUpper95 <- apply(resultMCMC$y_pred,2,function(x) quantile(x,0.975))  #上側2.5%点

result <- data.frame(Day=(1: dat$N),
                     PRED=y_PRED, lower=yLower95, upper=yUpper95)
g <- ggplot(data=result, aes(x=Day, y=PRED))
g <- g + geom_line(aes(y=PRED), lwd=.5)
g <- g +geom_ribbon(aes(ymin=lower,ymax=upper), alpha=.3)
plot(g)