data{
  int N; // number of observations
  int y; // the actual data
  int n; // number of trials
}
parameters{
  real<lower=0,upper=1> p; // proportion of water (to be estimated)
}
model{
  p ~ beta(1,1); // uniform distribution from 0 to 1
  
  y ~ binomial(n, p); // likelihood of y|p
}