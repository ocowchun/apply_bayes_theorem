# http://people.duke.edu/~neelo003/r
# File: Albert and Chib (Probit).r
# Generate Binary Data and run Gibbs Sampler
# Assumes conjugate normal prior on Beta
# Albert and Chib (1993) section 3
# Nov 15, 2007
##################################
install.packages("msm")
library(msm)          			# For rtnorm function
library(mvtnorm)

# Simulate data
set.seed(250)
n<-1000					# Sample Size
x<-sample(0:4,n,replace=T)		# Covariates
X<-matrix(c(rep(1,n),x), ncol=2)   	# Design matrix
tbeta<-c(-.75,.75)          		# True beta
p<-pnorm(X%*%tbeta) 	        	# Prob. Vector
y<-rbinom(n,1,p)				# Observations
k<-2 						# Number of parms
n1<-sum(y)                  		# Number of successes
n0<-n-n1

# Priors on Beta=c(alpha, beta)
  beta0<-c(0,0)				# Prior Mean for Beta
  vbeta0<-diag(10,2)			# Prior Cov of Beta (vague)

# Initial Values
  fit<-glm(y~x,family=binomial(link=probit))
  Beta<-rep(0,k)

# Create vectors to store results
  nsim<-1000  				# Number of Iterations of Gibbs Sampler
  z<-rep(0,n)				# Latent Normal Variable
  Betamat<-matrix(0,nrow=nsim,ncol=k) 	# Store Results
 
###################
# GIBBS SAMPLER	#
###################
 # Posterior Variance of Beta
	prec0<-solve(vbeta0)
	vbeta<-solve(prec0+crossprod(X,X))

for (i in 2:nsim) {

 # Draw Latent Variable, z, from its full conditional, given y
  muz<-X%*%Beta			# Update Mean of Z
  z[y==0]<-rtnorm(n0,muz[y==0],1,-Inf,0)
  z[y==1]<-rtnorm(n1,muz[y==1],1,0,Inf)

  #z[y==0]<-qnorm(runif(n,0,pnorm(0,muz,1)),muz,1)[y==0]  # using inverse-CDF method
  #z[y==1]<-qnorm(runif(n,pnorm(0,muz,1),1),muz,1)[y==1]

 # Posterior mean of Beta|Z
   mbeta <- vbeta%*%(prec0%*%beta0+crossprod(X,z))
   Betamat[i,]<-Beta<-c(rmvnorm(1,mbeta,vbeta)) # try to compare the dimension of rmvnorm(1,mbeta,vbeta) and c(rmvnorm(1,mbeta,vbeta)) to see the difference
 
  if (i%%100==0) print(i)
 }

# Get Summaries
apply(Betamat[501:nsim,],2,mean)

par(mfrow=c(2,1))
plot(1:nsim,Betamat[,1], type="l", col="lightgreen")
abline(h=mean(Betamat[501:nsim,1]),col="blue4")
plot(1:nsim,Betamat[,2], type="l", col="lightgreen")
abline(h=mean(Betamat[501:nsim,2]),col="blue4")
