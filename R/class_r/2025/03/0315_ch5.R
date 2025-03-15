setwd("/Users/bloom/Desktop/learning_playground/R/class_r/2025/03")
getwd()

arr <- array(1:24, c(3,3,2))

dimnames(arr) <- list(paste("row", c(1:3)), paste("col", c(1:3)),paste("ar",c(1:2)))

length(arr) # [1] 18
mode(arr) #[1] "numeric"
dim(arr) # [1] 3 3 2
dimnames(arr) 

# [[1]]
#[1] "row 1" "row 2" "row 3"
#[[2]]
#[1] "col 1" "col 2" "col 3"
#[[3]]
#[1] "ar 1" "ar 2"

array(1:6) 
# [1] 1 2 3 4 5 6
array(1:6, c(2,3)) 
#      [,1] [,2] [,3]
#[1,]    1    3    5
#[2,]    2    4    6
array(1:8, c(2,2,2)) 
# , , 1

#[,1] [,2]
#[1,]    1    3
#[2,]    2    4

#, , 2

#[,1] [,2]
#[1,]    5    7
#[2,]    6    8

arr <- c(1:24) 
dim(arr) <- c(3,4,2) 

ary1 <- array(1:8, dim = c(2,2,2)) 
ary2 <- array(8:1, dim = c(2,2,2))

ary1 + ary2 
ary1 * ary2 
ary1 %*% ary2 # sum(each element multiplied value)

ary1[,,1] # first dimension
ary1[1,1,] # each Matrix  of [1,1]  
ary1[1,,-2] # except second dimension and first row

a <- 1:10
b <- 11:15
klist <- list(vec1=a, vec2=b, descrip="example") # make list
length(klist) 
mode(klist) # type is not kind of numeric just list type
names(klist) 

list1 <- list("A", 1:8) 
list1

list1[[3]] <- list(c(T, F)) # add vector(matrix) at third dimension
list1[[2]][9] <- 9 # add vector value (9) at second matrix of place at 9
list1

list1[3] <- NULL
list1[[2]] <- list1[[2]][-9]
list1

a <- 1:10
b <- 11:15 # 
nlist <- list(vec1=a, vec2=b, descrip="example")
nlist

nlist[[2]][5] 
nlist$vec2[c(2,3)] 

char1 <- rep(LETTERS[1:3],c(2,2,1)) 
char1 # [1] "A" "A" "B" "B" "C"

num1 <- rep(1:3,c(2,2,1)) 
num1 # [1] 1 1 2 2 3

test1 <- data.frame(char1, num1) # test1 데이터 프레임 생성
test1

#     char1 num1
# 1     A    1
# 2     A    1
# 3     B    2
# 4     B    2
# 5     C    3




a1 <- c("a","b","c","d","e","f","g","h","i","j","k","l","m","n","o")
dim(a1) <- c(5,3) 
a1

test3 <- as.data.frame(a1) 
test3

#   V1 V2 V3
# 1  a  f  k
# 2  b  g  l
# 3  c  h  m
# 4  d  i  n
# 5  e  j  o


cbind(test1,test3)
#     char1 num1 V1 V2 V3
# 1     A    1  a  f  k
# 2     A    1  b  g  l
# 3     B    2  c  h  m
# 4     B    2  d  i  n
# 5     C    3  e  j  o


char1 <- rep(LETTERS[1:3],c(1,2,2))
char1

num1 <- rep(1:3,c(1,1,3))
num1

test4 <- data.frame(char1, num1)
test4

#   char1 num1
# 1     A    1
# 2     B    1
# 3     B    2
# 4     C    2
# 5     C    3


rbind(test1, test4) # add cross to column
merge(test1, test4) # 두개의 값을 비교해서 두 값에서 서로 공토된값만 방출 




