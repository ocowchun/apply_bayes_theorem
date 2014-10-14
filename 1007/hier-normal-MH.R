# modified from http://people.duke.edu/~neelo003/r/
# Gibbs sampler for simple normal mean hierarchical model
# Conjugate priors (mu~N(m0,1/t0), sigma2<-Inv-Gam(a, b))
# Suppose that data yi ~ N(mu,1/tau), i=1,...,n
# priors mu ~ N(mu0,1/tau0), tau~ Gam(a,b)
# Use Metropolis algorithm instead of Gibbs sampling

###################################
set.seed(250)

# Data #
n<-1000
mu<-3
sigma<-3
sigma2<-sigma^2
y<-rnorm(n,mu,sigma)

# Prior Hyperparms #
mu0=0
tau0=1     
a=2;b=1

# Inits #
tau<-1

# Store Results #
nsim<-5000
Tau<-Mu<-Sigma<-rep(0,nsim)
A=0;

#   MCMC   #
mtau<-a+n/2
for (j in 1:nsim){
 mus<-mu+.3*rt(1,3)  # t with 3 df as proposal	
	             # it is Metropolis because the proposal is symm
		     # Scaled by 1/3 to improve acceptance rate
 
# Acceptance prob on log scale
 r<- (sum(dnorm(y,mus,1/sqrt(tau),log=T) - dnorm(y,mu,1/sqrt(tau),log=T)) +
	dnorm(mus,mu0,sqrt(tau0),log=T) -  dnorm(mu,mu0,sqrt(tau0),log=T))

if (log(runif(1))<r) {   
   mu<-mus		# Update mu if accepted
   A<-A+1		# Acceptance rate
  }
  Mu[j]<-mu
  tau<-Tau[j]<-rgamma(1,mtau,b+sum((y-mu)^2)/2)
  Sigma[j]<-1/tau;
}

# Posterior summaries #
mean(Mu[1501:nsim])	# Discard first 1500 as burn-in
sd(Mu[1501:nsim])
mean(Sigma[1501:nsim])
sd(Sigma[1501:nsim])
par(mfrow=c(2,2))
plot(501:nsim,Mu[501:nsim],type="l",col="lightgreen")
abline(h=mean(Mu[501:nsim]))
acf(Mu[501:nsim])
plot(density(Mu[501:nsim]))
plot(density(Sigma[501:nsim]))



##作業
# 回家想公式(5)與r的關係