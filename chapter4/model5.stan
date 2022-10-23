data {
  int N;  //時点数
  int N_pred; //予測点の個数
  vector[N] Y;
}

parameters {
  vector[N] mu;
  vector[N] season; // 季節成分
  real<lower=0> sigma_W;  //システムノイズ
  real<lower=0> sigma_S;  // 季節調整項12ヵ月分の合計のばらつき
  real<lower=0> sigma_O;  // 観測ノイズ
}

transformed parameters{
  vector[N] y_mean;
  y_mean = mu + season;
}

model {
  mu[2:N] ~ normal(mu[1:(N-1)], sigma_W);  // システムモデル
  for(t in 12:N)
    season[t] ~ normal(-sum(season[(t-11):(t-1)]), sigma_S);  // 季節成分のシステムモデル
  Y ~ normal(y_mean, sigma_O);  // 観測モデル
}

// ここ以下は将来予測のためのコード（本には載っていない）
generated quantities {
  vector[N+N_pred] mu_all;
  vector[N+N_pred] season_all;
  vector[N_pred] y_pred;
  vector[N+N_pred] y_mean_all;
  mu_all[1:N] = mu;
  season_all[1:N] = season;
  y_mean_all[1:N] = mu+season;
  
  for (n in 1:N_pred) {
    mu_all[N+n] = normal_rng(mu_all[N+n-1], sigma_W);
    season_all[N+n] = normal_rng(-sum(season_all[N+n-11:N+n-1]), sigma_S);  //季節成分のシステムモデル
    y_pred[n] = normal_rng(mu_all[N+n]+season_all[N+n], sigma_O);
    y_mean_all[N+n] = mu_all[N+n] + season_all[N+n];
  }
  
}
