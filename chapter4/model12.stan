data {
  int<lower=1> K;  // 状態の種類
  int<lower=1> N;  // 時点の数
  real Y[N];  // 観測値
  vector<lower=0>[3] alpha;  // 遷移確率の初期値
}
parameters {
  simplex[K] theta[K];  // 遷移確率行列
  ordered[K] mu;  // muと状態kの対応関係がchainごとに異なるのを防ぐためordered型で宣言
  vector<lower=0,upper=100>[K] sigma;
}
model {
  real acc[K];
  real gamma[N, K];
  // 事前分布
  for (k in 1:K)
    theta[k] ~ dirichlet(alpha);
  mu ~ normal(0, 100);
  sigma ~ cauchy(0,5);
  
  //尤度
  for (k in 1:K)
    gamma[1, k] = normal_lpdf(Y[1] | mu[k], sigma[k]);
  
  for (t in 2:N) {
    for (k in 1:K) {
      for (j in 1:K)
        acc[j] = gamma[t-1,j]+log(theta[j, k])+normal_lpdf(Y[t] | mu[k], sigma[k]);
      gamma[t,k] = log_sum_exp(acc);
    }
  }
  target += log_sum_exp(gamma[N,]);
}

// ビタビ・アルゴリズム
generated quantities {
  int<lower=1, upper=K> y_star[N]; 
  real log_p_y_star;
  
  {
    int back_ptr[N,K]; 
    real best_logp[N,K];
    real best_total_logp;
    
    for (k in 1:K)
      best_logp[1,k] = normal_lpdf(Y[1] | mu[k], sigma[k]); 
    for (t in 2:N) {
      for (k in 1:K) {
          best_logp[t,k] = negative_infinity();
          for (j in 1:K) {
            real logp;
            logp=best_logp[t-1,j]+log(theta[j,k])+normal_lpdf(Y[t]|mu[k], sigma[k]);
            if (logp > best_logp[t,k]) {
              back_ptr[t,k] = j;
              best_logp[t,k] = logp;
            }
          }
        }
      }
      log_p_y_star = max(best_logp[N]);
      
      for (k in 1:K)
        if (best_logp[N,k] == log_p_y_star)
          y_star[N] = k;
      for (t in 1:(N - 1))
        y_star[N - t] = back_ptr[N-t+1, y_star[N-t+1]];
  }
}
