data {
  int N;  //サンプリング点数
  int N_pred; //予測点の個数
  vector[N] Y;  //観測値の時系列

}

parameters {
  vector[N] mu; // 推定値μ
  vector[N] v;  // トレンド
  real<lower=0> sigma_S;  // システムノイズ(レベル)
  real<lower=0> sigma_V;  // システムノイズ(トレンド)
  real<lower=0> sigma_O;  // 観測ノイズ
}

model {
  sigma_S ~ cauchy(0,5);  // 事前分布 
  sigma_V ~ cauchy(0,5);  // 事前分布
  sigma_O ~ cauchy(0,5);  // 事前分布

  //システムモデル
  for(t in 2:N){
    mu[t] ~ normal(mu[t-1]+v[t-1], sigma_S);
    v[t] ~ normal(v[t-1], sigma_V); 
  }

  //観測モデル
  Y ~ normal(mu, sigma_O);
}

// ここ以下は将来予測のためのコード（本には載っていない）
generated quantities {
  vector[N+N_pred] mu_all;
  vector[N+N_pred] v_all;
  vector[N_pred] y_pred;
  mu_all[1:N] = mu;
  v_all[1:N] = v;
  
  for (n in 1:N_pred) {
    mu_all[N+n] = normal_rng(mu_all[N+n-1]+v_all[N+n-1], sigma_S);
    v_all[N+n] = normal_rng(v_all[N+n-1], sigma_V);
    y_pred[n] = normal_rng(mu_all[N+n], sigma_O);
  }
}
