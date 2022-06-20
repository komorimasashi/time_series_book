# 5.3.2 2 次元データの動的時間伸縮

library(ggplot2)
library(MARSS)

# アカウミガメ位置情報データ
# 位置情報の単位は緯度（latitude: lat)と経度(longitude: lon)です
data(loggerhead)
dat <- loggerheadNoisy
g <- ggplot(dat, aes(x = lon, y = lat, color = turtle))+ geom_line()
plot(g)

# 2次元データのDynamic Time Warping
library(dtw)
# BigMama，MaryLeeと名付けられた2匹のウミガメのデータを取り出します
ts1 <- subset(dat, turtle=='BigMama')[,c("lon","lat")]
ts2 <- subset(dat, turtle=='MaryLee')[,c("lon","lat")]

# 時系列点の対応関係を調べる
# 距離を求める関数proxy::dist()を使います
alignment <-dtw(proxy::dist(ts1,ts2))
plot(alignment$index1, alignment$index2, main="Warping function",type='l')

# DTWで計算した距離
alignment$distance

# 描画
b <- data.frame(
  lon = ts1$lon[alignment$index1], lat = ts1$lat[alignment$index1],
  row_num = 1:length(alignment$index1)
)

m <- data.frame(
  lon = ts2$lon[alignment$index2], lat = ts2$lat[alignment$index2],
  row_num = 1:length(alignment$index2)
)

x <- rbind(data.frame(turtle = "BigMama", b), data.frame(turtle = "MaryLee", m))
g <- ggplot(x, aes(x = lon, y = lat, color = turtle))
g <- g + geom_text(aes(label=row_num))
plot(g)