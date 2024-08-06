data{
  int N; // number of observations
  int K; // number of predictors
  int J; // number of "observations" in the new predictors
  vector[N] y; // dependent variable (training data)
  matrix[N,K] X; // matrix of predictors (training data)
  vector[N] y2; // dependent variable (test data)
  matrix[N,K] X2; // matrix of predictors (test data)
  real alpha_scale;
  real beta_scale;
  matrix[J,K] X_tilde; // new predictors to simulate over
}
parameters{
  vector[K] beta; // coefficients
  real alpha; // intercept
  real<lower=0> sigma; // scale of likelihood
}
model{
  beta ~ normal(0, beta_scale); // prior on the slopes
  alpha ~ normal(0, alpha_scale); // prior on the intercept
  sigma ~ exponential(1); // prior on the lik scale
  
  y ~ normal(alpha + X*beta, sigma); // likelihood
}
generated quantities{
  // log likelihoods for calculating the information criteria
  vector[N] log_lik; // vector of likelihoods given alpha, beta, and sigma 
  for(i in 1:N){
    log_lik[i] = normal_lpdf(y[i] | alpha + X[i,]*beta, sigma);
  }
  // log likelihoods of the test data
  vector[N] log_lik_test;
  for(i in 1:N){
    log_lik_test[i] = normal_lpdf(y2[i] | alpha + X2[i,]*beta, sigma);
  }
  
  vector[J] mu_tilde = alpha + X_tilde*beta; // posterior of the the mean over X values
  array[J] real y_tilde;
  for(i in 1:J){
    y_tilde[i] = normal_rng(mu_tilde[i], sigma);
  }
  
  array[N] real y2_pred;
  for(i in 1:N){
    y2_pred[i] = normal_rng(alpha + X2[i,]*beta,sigma);
  }
  
}