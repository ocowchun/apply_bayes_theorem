# modified from http://people.duke.edu/~neelo003/r/
# Gibbs sampler for simple normal mean hierarchical model
# Data yi ~ N(mu,1/tau), i=1,...,n
# conjugate priors mu ~ N(mu0,1/t0), tau~ Gam(a,b) (i.e. sigma2~Inv-Gam(a,b))
# Full conditionals are
# mu|tau,y ~ N( (tau*sum(y)+t0*mu0)/(n*tau + tau0), 1/(n*tau + t0))
# tau|mu,y ~ Gam( a+n/2, b+(1/2)*sum((y-mu)^2))
# Finally, use "monitor" from library(R2WinBUGS) to check convergence

###################################
library(R2WinBUGS)
set.seed(250)

# Data #
n=1000
mu=3
sigma=3
sigma2=sigma^2
y=rnorm(n,mu,sigma)

# Prior Hyperparms #
m0=0
t0=1     
a=2;b=1

# Try 3 Inits #
tau.init=c(1,2,3)

# Store Results #
n.chains=length(tau.init)
nsim=5000
sims=array(NA, c(nsim, n.chains, 2))

# Gibbs #
mtau<-a+n/2
for (j in 1: n.chains){
 tau=tau.init[j]
 for (i in 1:nsim) {
   v=1/(tau*n + t0)
   m=v*(tau*sum(y)+t0*m0)
   mu=sims[i]=rnorm(1,m,sqrt(v))

   tau=rgamma(1,mtau,b+sum((y-mu)^2)/2)
   sims[i,j,]=c(mu,1/tau)
 }
}

# Posterior plots#
a1=nsim/2
par(mfrow=c(n.chains,2));
for (i in 1:n.chains){
 plot(sims[a1:nsim,i,1],xlab="t",ylab="mu",type="l")
 plot(density(sims[a1:nsim,i,1]),col="red",main="mu",lty=3)
}
for (i in 1:n.chains){
 plot(sims[a1:nsim,i,2],xlab="t",ylab="sigma2",type="l")
 plot(density(sims[a1:nsim,i,2]),col="green",main="sigma2",lty=3)
}

monitor(sims[a1:nsim,,1:2])