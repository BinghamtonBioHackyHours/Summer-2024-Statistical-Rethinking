data{
  int N; // number of observations
  int K; // number of predictors (incuding intercept)
  vector[N] y; // dependent variable
  matrix[N,K] X; // design matrix (first column is 1's for intercept)
}
parameters{
  vector[K] beta; // regression coefficients
  real<lower=0> sigma; // sd of likelihood
}
model{
  // priors
  beta ~ normal(0, 1);
  log(sigma) ~ normal(0, 1);
  
  // likelihood
  y ~ normal(X*beta, sigma);
}