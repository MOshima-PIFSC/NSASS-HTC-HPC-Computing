tmp=read.csv('data.csv')
fit=lm(y~x,data=tmp)
out = data.frame(par=unname(fit$coefficients))
write.csv(out,file='par.csv')
