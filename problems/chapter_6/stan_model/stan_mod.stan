data{
  int N;
  vector[N] x;
  vector[N] y;
  real b_scale;
  real a_scale;
  real<lower=0> sigma_prior;
}
parameters{
  real a;
  real b;
  real<lower=0> sigma;
}
model{
  a ~ normal(0, a_scale);
  b ~ normal(0, b_scale);
  sigma ~ exponential(sigma_prior);
  
  y ~ normal(a + b*x, sigma);
}
generated quantities{
  vector[N] log_lik;
  for(i in 1:N){
    log_lik[i] = normal_lpdf(y[i]|a + b*x[i], sigma);
  }
}

