# 4.2.4 多変量時系列の解析

# 軌跡のシミュレーション
set.seed(9999)
N <- 50 # 時点数
gamma <- 0.95 # 速度にかかる係数
sigma_V <- 0.01 # 観測ノイズ
sigma_W <- 0.005 # システムノイズ
degree <- 0.01 # 曲がる角度(rad)
x <- y <- muX <- muY <- rep(NA, N)

# CRWモデルに基づく軌跡
muX[1] <- muY[1] <- 0
muX[2] <- rnorm(1, muX[1], sigma_W)
muY[2] <- rnorm(1, muY[1], sigma_W)
for (t in 3:N){
  muX[t] <- rnorm(1, muX[t-1]
                  + gamma*((cos(degree)*(muX[t-1]-muX[t-2]))
                           - (sin(degree)*(muY[t-1]-muY[t-2]))), sigma_W)
  muY[t] <- rnorm(1, muY[t-1]
                  + gamma*((sin(degree)*(muX[t-1]-muX[t-2]))
                           + (cos(degree)*(muY[t-1]-muY[t-2]))), sigma_W)
}

# 観測値の作成
for (t in 1:N){
  x[t] <- rnorm(1,muX[t],sigma_V)
  y[t] <- rnorm(1,muY[t],sigma_V)
}

# リスト化
dat <- list(N = N, X =x, Y = y)


# Stanコードコンパイルと実行
model8 <- stan_model(file = "model8.stan", model_name="ssm8")
fit <- sampling(model8, data=dat, iter=4000, warmup=2000, thin=4,
                chains=4)
# 事後期待値（EAP）
resultMCMC <- rstan::extract(fit)
muX_EAP <- apply(resultMCMC$muX,2,mean)
muY_EAP <- apply(resultMCMC$muY,2,mean)
par(mfrow=c(1,3))
plot(muX,muY,type="l", main="true trajectory")
plot(x,y,type="l", main="observed trajectory")
plot(muX_EAP , muY_EAP,type="l", main="estimated trajectory")
sprintf("gamma: %.3f (95%%CI= (%f, %.3f] )",
        summary(fit)$summary["gamma","50%"],
        summary(fit)$summary["gamma","2.5%"],
        summary(fit)$summary["gamma","97.5%"]
)
sprintf("sigma_V: %.3f (95%%CI=[%.3f,%.3f])",
        summary(fit)$summary["sigma_V","50%"],
        summary(fit)$summary["sigma_V","2.5%"],
        summary(fit)$summary["sigma_V","97.5%"]
)
sprintf("sigma_W: %.3f (95%%CI=[%.3f,%.3f])",
        summary(fit)$summary["sigma_W","50%"],
        summary(fit)$summary["sigma_W","2.5%"],
        summary(fit)$summary["sigma_W","97.5%"]
)
sprintf("theta: %.3f (95%%CI=[%.3f,%.3f])",
        (((summary(fit)$summary["theta","50%"])*2-1) *pi) ,
        (((summary(fit)$summary["theta","2.5%"])*2-1) *pi) ,
        (((summary(fit)$summary["theta","97.5%"])*2-1) *pi)
)
