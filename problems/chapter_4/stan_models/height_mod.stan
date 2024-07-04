data{
  int N; // number of observations
  vector[N] weight; // standardized weights
  vector[N] height; // standardized heights
}
parameters{
  real a; // intercept (height when weight is at it's mean)
  real b; // slope
  real<lower=0> sigma; // scale for the likelihood
}
model{
  
  // priors
  a ~ normal(0, .5);
  b ~ normal(0, .5);
  sigma ~ exponential(1);
  
  // linear model
  vector[N] mu = a + b * weight;
  
  // likelihood
  height ~ normal(mu, sigma);
}
generated quantities{
  // this generates a predicted dataset for every iteration in the chains
  array[N] real y_pred = normal_rng(a + b * weight, sigma);
}