data {
  int N;  // サンプリング点数
  vector[N] Y;  // 観測値の時系列
}

parameters {
  vector[N] mu; //推定値μ
  real<lower=0> sigma_S;  // μのシステムノイズ
  real<lower=0> sigma_O;  // 観測ノイズ
}

model {
  // システムモデル
  for(t in 2:N){
    mu[t] ~ normal(mu[t-1], sigma_S);
  }

  // 観測モデル
  Y ~ normal(mu, sigma_O);
}

generated quantities{
  real log_lik[N];
  for(i in 1:N){
    log_lik[i] = normal_lpdf(Y[i]| mu[i], sigma_O);
  }
}
