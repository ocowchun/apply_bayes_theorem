schools.bug.txt='/Users/ocowchun/Dropbox/nccu/apply_bayes_theorem/1111/schools.bug.txt'
schools=read.table("/Users/ocowchun/Dropbox/nccu/apply_bayes_theorem/1111/schoolsdata.txt",header=TRUE)
schools
y=schools$estimate
J <- nrow(schools)
y <- schools$estimate
sigma.y <- schools$sd



mu.hat=function(tau,y,sigma.y){
	sum(y/(sigma.y^2+tau^2))/sum(1/(sigma.y^2+tau^2))
}

V.mu=function(tau,y,sigma.y){
	1/sum(1/(tau^2+sigma.y^2))
}

n.grid=2000
tau.grid=seq(.01,40,length=n.grid)
log.p.tau=rep(NA,n.grid)
for(i in 1:n.grid){
	mu =mu.hat(tau.grid[i],y,sigma.y)
	V=V.mu(tau.grid[i],y,sigma.y)
	log.p.tau[i]=.5*log(V)-.5*sum(log(sigma.y^2+tau.grid[i]^2))-.5*sum((y-mu)^2/(sigma.y^2+tau.grid[i]^2))
}

log.p.tau=log.p.tau-max(log.p.tau)
p.tau=exp(log.p.tau)
p.tau=p.tau/sum(p.tau)
n.sims=1000
tau=sample(tau.grid,n.sims,replace=T,prob=p.tau)

mu=rep(NA,n.sims)
theta=array(NA,c(n.sims,J))
for(i in 1:n.sims){
	mu[i]=rnorm(1,mu.hat(tau[i],y,sigma.y),sqrt(V.mu(tau[i],y,sigma.y)))
	theta.mean=(mu[i]/tau[i]^2+y/sigma.y^2)/(1/tau[i]^2+1/sigma.y^2)
	theta.sd=sqrt(1/(1/tau[i]^2+1/sigma.y^2))
	theta[i,]=rnorm(J,theta.mean,theta.sd)
}
# 另外,  要使機率為1的話, p.tau 要乘以 2000/40 (=50);
plot(c(0,30),c(0, max(p.tau*2000/40)),type='n', ylim=c(0,max(p.tau*2000/40)), yaxs="i", xlim=c(0,30), xaxs="i")
lines(tau.grid,p.tau*2000/40,ylim=c(2,3),col='red', xlim=c(0.01,10))
