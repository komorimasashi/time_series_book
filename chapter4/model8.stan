data {
  int<lower=3> N;  // 観測点
  vector[N] X;  // x座標
  vector[N] Y;  // y座標
}

parameters {
  vector[N] muX;  // ｘ座標推定値
  vector[N] muY;  // y座標推定値
  real <lower=0,upper=1> gamma;
  real <lower=0> sigma_V; // 観測ノイズ
  real <lower=0> sigma_W;  // システムノイズ（xy方向）
  real <lower=0,upper=1> theta; // 角度（0〜1）
}

transformed parameters {
  real<lower=-pi(), upper=pi()> degree;
  degree = (2*theta-1)*pi();
}

model {
  // 事前分布
  sigma_W ~ cauchy(0,5);
  sigma_V ~ cauchy(0,5);
  theta ~ beta(1,1);
  gamma ~ beta(1,1);
  muX ~ normal(0,100);
  muY ~ normal(0,100);

  // Correlated Random Walkモデル
   for (t in 3:N) {
          muX[t] ~ normal(muX[t-1] + gamma*((cos(degree)*(muX[t-1]- muX[t-2])) - (sin(degree)*(muY[t-1]- muY[t-2]))), sigma_W);
          muY[t] ~normal( muY[t-1] + gamma*((sin(degree)*(muX[t-1]- muX[t-2])) + (cos(degree)*(muY[t-1]- muY[t-2]))), sigma_W);
  }
  
  // 観測モデル
  X ~ normal(muX, sigma_V);
  Y ~ normal(muY, sigma_V);
}
