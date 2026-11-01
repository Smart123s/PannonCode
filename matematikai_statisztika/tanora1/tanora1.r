adat=read.csv2(file="tanora1/adatfile1.csv",header=FALSE)
is.data.frame(adat)
dim(adat)
colnames(adat)=c("Nev","Magassag","Nem","Hallgato")
adat[1,]
adat[,3]
adat[2,4]
