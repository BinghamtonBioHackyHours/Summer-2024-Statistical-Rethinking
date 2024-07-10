data{
  int N; // number of observations
  int K; // number of predictors
  vector[N] marriage;
  matrix[N,K] X; // design matrix with a column of 1s for the intercept and then age and divorce
}
parameters{
  vector[K] beta; // coefficients
  real<lower=0> sigma; // parameter for the scale of the likelihood
}
model{
  //priors
  beta ~ normal(0,1); // pretty loose likelihood since the variables are standardized
  sigma ~ exponential(1);
  
  marriage ~ normal(X*beta, sigma);
}