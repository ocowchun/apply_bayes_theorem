set.seed(250)

#Data#
n=1000
mu=3
sigma=3
sigma2=sigama^2
y = rnorm(n,mu,sigma)


#Prior#

mu0=0
tau0=0
a=2
b=1

#inits#
tau=1

#Store Results#
nsim=5000
Tau=Mu=Sigama=rep(0,nsim)
A=0

for(j in 1:nsim){
	mus =mu+.3*rt(1,3) #t with 3 df as proposal
	#it is Metropolis because the proposal is symm
	#Scaled by 1/3 to imporive acceptance rate

#Acceptance prob on log scale,r is log alpha
	r=(sum(dnorm(y,mus,1/sqrt(tau),log=T)-dnorm(y,mu,1/sqrt(tau),log=T))+
		dnorm(mus,mu0,sqrt(tau0),log=T)-dnorm(mu,mu0,sqrt(tau0),log=T))

	if (log(runif(1))<r){
		mu=mus
		A=A+1
	}
	Mu[j]=mu
	tau=Tau[j]=rgamma(1,mtau,b+sum((y-mu)^2)/2)
	Sigama[j]=1/tau
}


##作業
回家想公式(5)與r的關係