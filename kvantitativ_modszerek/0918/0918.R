x<-rcauchy(100)
plot(density(x))

for (i in 1:10000) {
  y<-mean(sample(x, 20))
}