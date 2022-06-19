# 2.4.4　移動相関

library(zoo)
# 相関係数を求めるcorrelationという名前の関数を作成する
correlation <- function(x) {
  return(cor(x[,1],x[,2]))
}
# データフレームの作成（2つの系列は正規乱数で作成している）
df <- data.frame(x1 = rnorm(50), x2= rnorm(50))
# zooのrollapplyr()関数で窓長20の相関分析(correlation)を順に適用
zoo::rollapplyr(df, width=20, FUN=correlation, by.column=F)