z=rtnorm(8000,2,2,lower=0)
 x=rnorm(10000,2,2)
 y=x[x>0]
 par(mfrow=c(2,1))
 plot(density(y))
 plot(density(z))
