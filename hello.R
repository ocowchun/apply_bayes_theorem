x0=x_old=c(-10,-10,0,0)
x_new=rep(0,4)
x=NULL
x=cbind(x,x0)
s=c(0.5,5,0.5,5);
accept=c(0,0,0,0);
k=500
for(i in 1:k){
	e=rnorm(1,0,1);
	y=s*e
	u=runif(1,0,1)
	alpha=exp(-(y^2-(x_old)^2)/2)
	for(j in 1:4){
		if(u< alpha[j]){
			x_new[j]=y[j]
			accept[j]=accept[j]+1
		}
		else{
			x_new[j]=x_old[j]
		}
	}
	x=cbind(x,x_new)
	x_old=x_new
}

acc_rate=accept/k
acc_rate
par(mfrow=c(4,2))
for(j in 1:4)
{
	ts.plot(x[j,])
}

for (i in 1:4) {
	acf(x[j,])
}