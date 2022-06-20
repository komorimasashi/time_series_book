data{
  int N; // データ総数
  int Attend[N]; // 週毎の出席数
  int Check[N]; // 週毎の出席をとった回数
}

parameters{
  vector[N] mu;
  real<lower=0> sigma; 
}

transformed parameters {
  vector<lower=0, upper=1>[N] theta; // 各時点の出席率
  theta = inv_logit(mu); // ロジスティック関数
}

model{
  sigma ~ cauchy(0,5); 
  for (i in 2:N)
    mu[i]~normal(mu[i-1], sigma); 

  for(i in 1:N)
    Attend[i] ~ binomial(Check[i], theta[i]);
}
