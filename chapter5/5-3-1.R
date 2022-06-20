# 5.3.1 1 次元データの動的時間伸縮

library(dtw)

data("BJsales")

# 異なる期間のデータを抜き出すのでデータの長さは異なる
# 120サンプル抜き出して標準化, Query
ts1 <- scale(BJsales.lead[1:120])
# 150サンプル抜き出して標準化, Reference
ts2 <- scale(BJsales[1:150])

# DTW
# アライメントを調べる
alignment <- dtw(ts1, ts2)
# 時系列点の対応関係
dtwPlotThreeWay(alignment, xts=ts1, yts=ts2)
# DTWで計算した距離
sprintf("DTW (global): %5.2f", alignment$distance)
# 描画
dtwPlotTwoWay(alignment, xts=ts1, yts=ts2, main="alignment of rawdata")
ts.plot(as.ts(ts1[alignment$index1]), as.ts(ts2[alignment$index2]), col=c(1:2), lty=c(1:2), main="Global Alignment")

# DTWのオプション
# 探索範囲の窓長に制限を加える
alignment.window = dtw(ts1, ts2, window.type = "sakoechiba", window.size = abs(length(ts1) - length(ts2)))
dtwPlotTwoWay(alignment.window, xts=ts1, yts=ts2, main=" Windowed Alignment")
sprintf("DTW (windowed, global) distance: %5.2f", alignment.window$distance) # 距離

# open.end と open.beginで類似度の高い区間だけ抜き出す
alignment.openend = dtw(ts1, ts2, step=asymmetric, open.end=TRUE,open.begin=TRUE)
dtwPlotTwoWay(alignment.openend, xts=ts1, yts=ts2, main="Open.beginとOpen.end")

ts.plot(as.ts(ts1[alignment.openend$index1]),
        as.ts(ts2[alignment.openend$index2]),
        col=c(1:2),lty=c(1:2), main="Local Alignment")

sprintf("DTW(local): %5.2f", alignment.openend$distance) # 距離
