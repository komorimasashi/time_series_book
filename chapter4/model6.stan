data {
  int<lower=2> L;  // 観測点
  int<lower=1> N;  // 個体数
  vector[N] Y[L];  // 体重
}

parameters {
  real gamma;
  vector[N] beta;
  real<lower=0> sigma_R; 
  real<lower=0> sigma_U;
}

model {
  // 事前分布
  gamma ~ normal(0,100);
  sigma_R ~ cauchy(0,5);
  sigma_U ~ cauchy(0,5);
  // 事後分布
  beta ~ normal(gamma, sigma_U);  // レベル2（システムモデル）
  for(i in 1:N)
    Y[,i]~normal(beta[i], sigma_R);  // レベル1（観測モデル）
}
