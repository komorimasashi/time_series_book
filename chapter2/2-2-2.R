# 2.2.2　型の変換

x <- c(1, 3, 5, 7, 9)
c <- as.character(x)
mode(c) # mode型

m <- cbind(c(1,2,3),c(4,5,6))
df <- as.data.frame(m)
typeof(df) # type型
mode(df) # mode型
class(df) # class型
