x <- c(rep(3,3), seq(3,7,by=2),rev(seq(3,7,length=3)),rep(4,3))
sort(x)
rank(x)
order(x)

matr <- matrix(1:9, nrow =3)
length(matr)
mode(matr)
dim(matr)

m1 <- 1:9
dim(m1) <- c(3,3)
m1

mat <- matrix(c(1,2,3,4,5,6,7,8,9), ncol=3, byrow=T) 
mat

mat[1,]

mat[,3] > 4 # False True True

mat[mat[,3] > 4 ,2] # "row 3" in "if x > 4"'s "column" is "2,"and "3," is going to ",2"
# result is 5 and 8

Height <- c(140,155,142,175)
size.1 <- matrix(c(130,26,110,24,118,25,112,25), ncol=2, byrow=T,
                 dimnames=list(c("Lee", "Kim", "Park", "Choi"), c("Weight", "Waist")))
size <- cbind(size.1, Height)
size
##     Weight Waist Height
## Lee     130    26    140
## Kim     110    24    155
## Park    118    25    142
## Choi    112    25    175

colmean <- apply(size, 2, mean)
colmean ## 1-> row , 2-> column ,mean -> average

# Weight  Waist Height 
# 117.5   25.0  153.0 

colvar <- apply(size,2,var) 
colvar # var -> variance 

#      Weight       Waist      Height 
# 81.0000000   0.6666667 259.3333333  -> +-(root 81 = 9), +-(root0.66~ = 0.82), ```` How Far

sweep(size,2,colmean) ## each element - everage

#      Weight Waist Height
# Lee    12.5     1    -13
# Kim    -7.5    -1      2
# Park    0.5     0    -11
# Choi   -5.5     0     22

m1 <- matrix(1:4, nrow=2) # 1~4 2 column 2 row
m2 <- matrix(5:8, nrow=2) 

m1 %*% m2 # multiple
solve(m1) # m1 %*% Inverse Matrix = Identity Matrix
# Identity Matrix is ... 
t(m1)
getwd()
setwd("/Users/bloom/Desktop/learning_playground/R")

