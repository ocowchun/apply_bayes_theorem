```r
library(MASS)
x3=c(11.9,22.8,18.7,20.1,12.9,21.7,27.1,25.4,21.3,19.3,25.4,27.2,11.7,17.8,12.8,23.9,22.6,25.4,14.8,21.1)

x2=c(29.1,28.2,37.0,31.1,30.9,23.7,27.6,30.6,23.2,24.8,30.0,28.3,23.0,28.6,21.3,30.1,25.7,24.6,27.1,27.5)

x1=c(43.1,49.8,51.9,54.3,42.2,53.9,58.5,52.1,49.9,53.5,56.6,56.7,46.5,44.2,42.7,54.4,55.3,58.6,48.2,51.0)

y=c(19.5,24.7,30.7,29.8,19.1,25.6,31.4,27.9,22.1,25.5,31.1,30.4,18.7,19.7,14.6,29.5,27.7,30.2,22.7,25.2)

x=cbind(x1,x2,x3)
n=length(y)

beta.init=c(0,0,0)
tau.init=1
a=2
b=1
nsinm=1000

beta=beta.init
tau=tau.init

beta.mean=solve(t(x)%*%x) %*% t(x) %*% y
sigma2.shape=a+n/2

for( i in 1 : nsinm)
{
	sigma2=1/tau
	beta.var=sigma2*solve(t(x)%*%x)
	beta=mvrnorm(1,beta.mean,beta.var)

	sigma2.rate=b+t((y-x%*%beta))%*%(y-x%*%beta)/2
	sigma2=rgamma(1,sigma2.shape,sigma2.rate)
	tau=1/sigma2
}

print(paste0("beta:",beta))
print(paste0("tau:",tau))

```