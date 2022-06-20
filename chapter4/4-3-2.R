# 4.3.2 観測値が二項分布に従うモデル

#日毎の出席確認回数
check <- c(0,0,0,0,0,0,0,0,0,3,3,3,2,3,0,0,4,4,4,2,3,0,0,4,4,4,2,3,0,0,4,4,0,0,0,0,0,4,4,4,2,3,0,0,4,4,4,2,4,0,0,4,4,4,2,3,0,0,4,4,3,2,3,0,0,3,3,2,2,2,0,0,3,3,2,2,2,0,0,3,3,2,2,2,0,0,3,3,2,2,2,0,0,3,3,2,2,2,0,0,2,3,2,2,2,0,0,0,3,2,1,1,1,0,3,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,2,2,2,3,0,0,1,2,2,2,3,0,0,1,2,2,2,3,0,0,1,1,2,2,3,0,0,1,2,2,2,3,0,0,1,2,2,2,3,0,0,1,2,2,0,0,0,0,0,2,2,2,3,0,0,1,2,2,2,3,0,0,1,2,2,2,3,0,0,1,2,2,2,3,0,0,1,2,2,2,3,0,0,1,2,2,2,3,0,0,1,1,0,2,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,2,2,3,0,0,1,2,2,2,3,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)
#日毎の出席回数
attend <- c(0,0,0,0,0,0,0,0,0,3,3,2,2,3,0,0,3,3,3,2,3,0,0,3,3,3,2,3,0,0,0,2,0,0,0,0,0,3,3,3,2,3,0,0,3,3,3,2,4,0,0,3,2,3,2,3,0,0,3,3,2,2,2,0,0,0,1,2,2,2,0,0,2,1,2,2,2,0,0,3,2,2,2,2,0,0,3,2,2,2,2,0,0,0,2,2,2,2,0,0,2,2,2,2,2,0,0,0,2,2,1,1,1,0,3,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,2,3,0,0,1,1,2,2,3,0,0,1,1,2,2,3,0,0,1,1,0,0,0,0,0,1,1,2,2,3,0,0,0,1,1,2,3,0,0,1,1,1,0,0,0,0,0,2,2,1,3,0,0,1,2,2,2,3,0,0,1,1,2,2,3,0,0,1,1,2,2,3,0,0,1,1,1,1,3,0,0,1,1,2,2,3,0,0,0,1,0,2,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,2,3,0,0,1,2,2,2,3,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)


#リスト化
dat <- list(N=length(check), Attend = attend, Check = check)
plot(check, type="l", ylim=c(0,5), ylab="", xlab="日")
par(new =T)
plot(attend, type="l", ylim=c(0,5), col=2, ylab="回数", xlab="")
labels <- c("出席確認","出席")
legend("topright", legend = labels, col = c(1,2), lty = c(1,1))

# Stanの実行
dat <- list(N=length(check), Attend = attend, Check = check)
model9 <- stan_model(file = "model9.stan", model_name="ssm9")
fit <- sampling(model9, data=dat, iter=4000, warmup=2000, thin=4, chains=4)

# 出席意欲μの事後期待値（EAP）（左）と出席率θの事後中央値（MED）
resultMCMC <- rstan::extract(fit)
mu_EAP <- apply(resultMCMC$mu,2,mean)
muLower95 <- apply(resultMCMC$mu,2,function(x) quantile(x,0.025))  #下側2.5%点
muUpper95 <- apply(resultMCMC$mu,2,function(x) quantile(x,0.975))  #上側2.5%点

theta_50 <- apply(resultMCMC$theta,2,median)
thetaLower95 <- apply(resultMCMC$theta,2,function(x) quantile(x,0.025))  #下側2.5%点
thetaUpper95 <- apply(resultMCMC$theta,2,function(x) quantile(x,0.975))  #上側2.5%点

# 描画 
# 意欲μ
result_mu <- data.frame(Time=1:length(check),EAP=mu_EAP, lower=muLower95, upper=muUpper95)
g <- ggplot(data=result_mu, aes(x=Time, y=EAP))
g <- g + geom_line(aes(y=EAP), lwd=.5)
g <- g +geom_ribbon(aes(ymin=lower,ymax=upper), alpha=.3)+ labs(x="DAY", y=expression(mu))
plot(g)

# 出席確率θ
result_theta <- data.frame(Time=1:length(check),　THETA=theta_50, lower=thetaLower95, upper=thetaUpper95)
g <- ggplot(data=result_theta, aes(x=Time, y=THETA))
g <- g + geom_line(aes(y=THETA), lwd=.5)
g <- g +geom_ribbon(aes(ymin=lower,ymax=upper), alpha=.3)+ labs(x="DAY", y=expression(theta))
plot(g)
