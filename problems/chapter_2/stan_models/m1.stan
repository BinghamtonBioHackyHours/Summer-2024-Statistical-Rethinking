data{
  int N; // size of data
  array[N] int water; // the data with water as 1, land as 0
}
parameters{
  real<lower=0,upper=1> p; // proportion water, defined as being between 0 and 1
}
model{
  // prior
  p ~ beta(1,1); // uniform between 0 and 1
  
  // likelihood
  water ~ bernoulli(p); // this could be a binomial with the data being the sum of water
}