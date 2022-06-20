# 5.7 時系列クラスタリング

# 1次元データのDTWと時系列クラスタリング
library(TSclust)

# データの作成
# ランダムウォークを返す関数
RndWalk1D <- function(n){
  rndwalk <- cumsum(rnorm(n))
  return(rndwalk)
}

N <- 30 # 時系列サンプルのサイズ
LEN <- 100 # 時系列サンプルの長さ
data <- apply(matrix(NA, nrow=LEN, ncol=N), 2, RndWalk1D)
data <- as.data.frame(data)

# 時系列クラスタリング
d <- diss(data, "DTWARP") # 距離の指標としてDTW距離を指定する
h <- hclust(d, method = "ward.D") # Ward法による階層クラスタリング
plot(h, hang = -1) # デンドログラムを描画する
NUMCLASS <-4 # 何クラスに分類して結果を表示するか
h.cluster <- cutree(h, NUMCLASS) # 属するクラスタの情報を返す
matplot(data, type = 'l', lty = 1, col = h.cluster) # 描画