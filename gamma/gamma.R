# rgamma(n, shape, rate = 1, scale = 1/rate)
g1=rgamma(1000,shape=1,scale=1);
g2=rgamma(1000,shape=2,scale=2);
g3=rgamma(1000,shape=3,scale=0.5);

ig1=1/g1
ig1=ig1[ig1<3]

ig2=1/g2
ig2=ig2[ig2<3]

ig3=1/g3
ig3=ig3[ig3<3]


par(mfrow=c(3,2))
plot(density(g1),main="gamma distrubution shape=1,scale=2")
plot(density(ig1),main="inverse gamma distrubution shape=1,scale=2")

plot(density(g2),main="gamma distrubution shape=2,scale=2")
plot(density(ig2),main="inverse gamma distrubution shape=2,scale=2")


plot(density(g3),main="gamma distrubution shape=3,scale=0.5")
plot(density(ig3),main="inverse gamma distrubution shape=3,scale=0.5")



