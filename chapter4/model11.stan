data {
  int N;
  vector[N] Y;
}

parameters {
  vector[N] mu;
  real<lower=0> sigma_W;
  real<lower=0> sigma_O;
  real diff;  // 効果
  real<lower=1, upper=N> cp; // 変化点
}

transformed parameters {
  vector[N] mu1;
  for (t in 1:N)
    mu1[t] = mu[t] + ((cp < t) ? diff : 0);  // 三項演算子による条件分岐
}

model {
  sigma_W ~ cauchy(0,5); 
  sigma_O ~ cauchy(0,5); 
  
  for (t in 2:N){
    mu[t] ~ normal(mu[t-1], sigma_W);
  }
  Y ~ normal(mu1, sigma_O);
}
