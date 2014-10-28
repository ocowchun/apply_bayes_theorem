beta.hat=
sigma.hat=1/tau*
mtau=a+n/2

beta= mvrnorm(1,beta.hat,sigma.hat)
tau=rgamma(1,mtau,b+1/2*t(y-x%*%beta.hat)*(y-x%*%beta.hat))
sigma[i]=1/tau
