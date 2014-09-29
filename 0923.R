# x0=1則 x1有0.4的機會是0,0.6的機會是1 
# x0=0則 x1有0.7的機會是0,0.3的機會是1 
# 試問xn=0的機率是否會受x0影響? n是個很大的數

guess=function(n,init) {
	p0=c(0.7,0.4)
	result=0
	for(j in 1:1000){
		current=init
		for(i in 1:n){
			to_zero=runif(1)>p0[current+1]
			if(to_zero){
				current=0
			}
			else{
				current=1
			}
		}
		result=result+current
	}
	result/1000
}
