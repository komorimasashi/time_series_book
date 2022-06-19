# 2.4.1　時系列データの操作

#ラグ
# tsクラスのオブジェクトのラグを求めるときはstats::lag()を使う
# 2020年1月からの配列
x <-ts(1:120,start=c(2020,1),frequency=12)
# 1年前にずらしたデータ(2019年1月から開始される)
stats::lag(x, k=12)
# tsクラス以外のオブジェクトのラグを求めるにはdplyr::lag()を使う
library(dplyr)
x <- 1:10
dplyr::lag(x, k=1)

# ラグ系列でデータフレームを作成する
data.frame(x = 1:10) %>%
  dplyr::mutate(lead=lead(x, k=1)) %>%
  dplyr::mutate(lag=lag(x, k=1))


# 階差
x <- cumsum(0:10) # 時系列(0,1,3,6,10,15,21,28,36,45,55)
diff(x, lag=1, differences=1) # 1階階差（等差数列になる）
diff(x, lag=1, differences=2) # 2階階差（すべて1になる）