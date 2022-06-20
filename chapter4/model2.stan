data {
  int T;  //サンプリング点数
  int P;  //予測をしたい日数
  vector[T] Y;  //観測値の時系列
}

parameters {
  vector[T+P] mu; //推定値μ
  real<lower=0> sigma_u;  //システムノイズ
  real<lower=0> sigma_v;  //観測ノイズ
}

model {
  mu[2:(T+P)] ~ normal(mu[1:(T+P-1)], sigma_u);  //システムモデル
  for (i in 1:T){
    if(Y[i]!=9999){
      Y[i] ~ normal(mu[i], sigma_v);  //観測モデル
    }
  }
}
