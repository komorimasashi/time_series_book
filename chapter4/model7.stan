data {
  int<lower=2> L;  // 観測点
  int<lower=1> N;  // 個体数
  real X[L];   // 時点
  vector[N] Y[L];  // 体重
}

parameters {
  vector[2] gamma;
  vector[2] beta[N];
  cov_matrix[2] Tau;
  real<lower=0> sigma_R; 
}

transformed parameters{
  vector[N] yhat[L];
  for(j in 1:L)
    for(i in 1:N)
      yhat[j,i] = beta[i,1] +beta[i,2]*X[j]; 
}

model {
  gamma ~ normal(0,100);
  sigma_R ~ cauchy(0,5);

  for(i in 1:N){
    beta[i,] ~ multi_normal(gamma, Tau);
    Y[,i]~normal(yhat[,i], sigma_R);
  }
}
