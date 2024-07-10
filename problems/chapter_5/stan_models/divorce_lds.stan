data{
  int N; // number of observations
  int K; // number of covariates
  vector[N] divorce; // dependent variable
  matrix[N, K] X; // design matrix
}
parameters{
  vector[K] beta; // vector of parameters beta[1] is a vector of 1s for the intercept, beta[2:4] are the intercepts on age, marrage, and lds proportion (standardized)
  real<lower=0> sigma;
}
model{
  beta ~ normal(0, 1); // prior for the coefficients
  sigma ~ exponential(1); // prior for the scale of the likelihood
  
  // likelihood
  divorce ~ normal(X*beta, sigma);
}
