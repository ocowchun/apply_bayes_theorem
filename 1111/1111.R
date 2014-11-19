# first, save schoolsdata.txt in the working directory
# then, install R2WinBUGS and run the code below

# library('R2WinBUGS')
schools.bug.txt='/Users/ocowchun/Dropbox/nccu/apply_bayes_theorem/1111/schools.bug.txt'
schools=read.table("/Users/ocowchun/Dropbox/nccu/apply_bayes_theorem/1111/schoolsdata.txt",header=TRUE)
schools
y=schools$estimate
J <- nrow(schools)
y <- schools$estimate
sigma.y <- schools$sd
data <- list ("J", "y", "sigma.y")
inits <- function() {list (theta=rnorm(J,0,100), mu.theta=rnorm(1,0,100), sigma.theta=runif(1,0,100))}
parameters <- c("theta", "mu.theta", "sigma.theta")


# schools.sim <- bugs (data, inits, parameters, '/Users/ocowchun/Dropbox/nccu/apply_bayes_theorem/1111/schools.bug.txt', n.chains=3, n.iter=1000)
# print(schools.sim)
# plot(schools.sim)
# names(schools.sim)

y/sigma.y^2