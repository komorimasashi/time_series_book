data {
  int T;  //サンプリング点数
  vector[T] Y;  //観測値の時系列
}
parameters {
  vector[T] mu; //推定値μ
  real<lower=0> sigma_u;  //システムノイズ
  real<lower=0> sigma_v;  //観測ノイズ
}
model {
  mu[2:T] ~ normal(mu[1:(T-1)], sigma_u);  //システムモデル
  Y ~ normal(mu, sigma_v);  //観測モデル
}

generated quantities{
  vector[T+10] mu_all;
  vector[10] y_pred;
  mu_all[1:T] = mu;

  for(t in 1:10){
    mu_all[T+t] = normal_rng(mu_all[T+t-1], sigma_u);
    y_pred[t] = normal_rng(mu_all[T+t], sigma_v);
  }
}




