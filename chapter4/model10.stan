data {
  int N;  // サンプリング点数
  int Y[N];  // 観測値の時系列
  vector[N] IV; // 介入の有無（0:介入なし，1:介入あり）
}
parameters {
  vector[N] mu; //μ 
  vector[N] season;  // 季節調整項
  real<lower=0> sigma_S;  // muのシステムノイズ
  real<lower=0> sigma_season; // 季節成分のノイズ
  real k; // 介入効果の係数
}
transformed parameters{
  vector[N] lambda;
  lambda =  exp(mu + season + k*IV);
}
model {
  for (t in 2:N)
    mu[t] ~ normal(mu[t-1], sigma_S);
  // 季節成分：11ヶ月前から1ヶ月前までの合計値に−1をかけた値になると考える
  for (i in 12:N)
    season[i] ~ normal(-sum(season[(i-11):(i-1)]), sigma_season);
  // 観測モデル
  Y ~ poisson(lambda);
}
generated quantities {
  int y_pred[N];
  y_pred = poisson_rng(exp(mu + k*IV));
}
