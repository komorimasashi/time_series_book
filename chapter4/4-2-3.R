# 4.2.3 パネルデータの分析

# model7.stanをキックするRコード

library(nlme)
library(ggplot2)
library(tidyr)
library(dplyr)

dat <-BodyWeight[BodyWeight$Diet==1|BodyWeight$Diet==2,]
dat <-dat[dat$Time != 44,]
dat$Time <- (dat$Time-1)/7
dat <- data.frame(dat)
dat %>% select(-Diet) %>%
  pivot_wider(names_from = Rat, values_from = weight) %>%
  select(-Time) -> weight

# リスト化
dat <- list(N = ncol(weight), X=c(1:nrow(weight)), L =nrow(weight), Y = weight)
# stanコードコンパイルと実行
model7 <- stan_model(file ="model7.stan", model_name="ssm7")
fit <- sampling(model7, data=dat, iter=1000, warmup=500, thin=4, chains=4)
summary(fit)
