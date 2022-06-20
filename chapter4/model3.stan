data {
  int N;  //サンプリング点数
  int N_pred; //予測点の個数
  vector[N] Y;  //観測値の時系列
}

parameters {
  vector[N] mu; // 推定値μ
  real<lower=0> sigma_S; // システムノイズ 
  real<lower=0> sigma_O; // 観測ノイズ
}

model {
  sigma_S ~ cauchy(0,5);  // 事前分布 
  sigma_O ~ cauchy(0,5);  // 事前分布
  mu[2:N] ~ normal(mu[1:(N-1)], sigma_S);  // システムモデル
   Y ~ normal(mu, sigma_O);  // 観測モデル
}


// ここ以下は将来予測のためのコード（本には載っていない）
generated quantities {
  vector[N+N_pred] mu_all;
  vector[N_pred] y_pred;
  mu_all[1:N] = mu;
  for (n in 1:N_pred) {
    mu_all[N+n] = normal_rng(mu_all[N+n-1], sigma_S);
    y_pred[n] = normal_rng(mu_all[N+n], sigma_O);
  }
}

