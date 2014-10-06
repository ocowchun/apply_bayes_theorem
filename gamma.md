#gamma 
##gamma function
是階乘函數在實數與複數上的擴展，

###歷史
尤拉於1729年解決階乘由整數往實數上延拓的問題(ex:計算2.5!)，由此導致了\\(\Gamma\\)函數的誕生。

[reference](http://cos.name/2013/01/lda-math-gamma-function/)

\\(
\large \Gamma(k)=	\int^\infty_{-\infty} y^{k-1}e^{-y}\,dy
\\)

(1) \\(
\Gamma(k)>0 \quad \forall k>0
\\)

(2) \\(
\Gamma(k)=(k-1)\Gamma(k-1)
\\)

(3) \\(
\Gamma(n)=(n-1)! \quad , n\in N
\\)

(4) \\(
\gamma(\frac{1}{2})=\sqrt{\pi}
\\)


##pdf
\\(
\large GAM(k,\theta)=\frac{x^{k-1}}{\theta^k\Gamma(k)}e^{-\frac{x}{\theta}} \, \small, 0 < x , 0 < \theta , 0 < k
\\)

\\(
x \sim GAM(k,\theta)
\\)

\\(
\large GAM(1,\theta) => \frac{1}{\theta}e^{-\frac{x}{\theta}}
\\)

pdf:機率密度函數
把機率密度函數積分就可以得到機率

gamma是一個連續的分配

\\(
GAM(1,\theta)
\\)為Exponential distribution的pdf


####gamma的MGF:
\\(
\large (\frac{1}{1-\theta t})^k
\\)

####gamma的MEAN:
\\(
k\theta
\\)

####gamma的variance
\\(
k\theta^2
\\)


##Inverse-gamma distribution
the distribution of the reciprocal of a variable distributed according to the gamma distribution(gamma分配的倒數)

\\(
If\, X \sim Gamma(k,\theta) \, then \, \frac{1}{x} \sim Inv-Gamma(k,\theta^{-1})
\\)

###備註
####E(x)
mean(期望值)統計上用E(x)來表示

####MGF:Moment-generating function
\\(
Mx(t)=E(e^{tx})
\\)
可以用來推導期望值與變異數