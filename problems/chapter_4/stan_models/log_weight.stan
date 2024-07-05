data{
  int N; // number of observations
  vector[N] height; // heights
  vector[N] log_weight; // log-weight
}
parameters{
  real a; // intercept
  real b; // slope on log-weight
  real<lower=0,upper=50> sigma; // scale of likelihood
}
model{
  // priors for parameters
  a ~ normal(178, 100);
  b ~ normal(0, 100);
  sigma ~ uniform(0, 50);
  
  // linear model
  vector[N] mu = a + b * log_weight;
  
  // likelihood
  height ~ normal(mu, sigma);
}
generated quantities{
  array[N] real y_pred = normal_rng(a + b * log_weight, sigma);
}