# 5.5 位相差の評価

library(seewave) # 信号処理ライブラリ
library(gtrendsR) # Googleトレンドを取得するライブラリ
library(tidyr)
library(circular) # 角度の計算を行うライブラリ

# Googleトレンドの取得
trend <- gtrends(
  keyword = c("おはよう", "おやすみ"), # 検索キーワード
  geo = "JP", # 検索地域
  # 取得期間．ここでは現在からさかのぼって７日間（24×7)
  time = "now 7-d",
  tz = 'Asia/Tokyo'
)
plot(trend)
df <- as.data.frame(trend$interest_over_time)
df <- df %>% pivot_wider(id_cols = date, names_from = keyword, values_from=hits)
ohayo <- scale(df$'おはよう')
oyasumi <- scale(df$'おやすみ')

# 位相差の算出
# ヒルベルト変換
ohayo.h <- hilbert(ohayo, 1, channel = 1, fftw = FALSE)
# ヒルベルト変換
oyasumi.h <- hilbert(oyasumi, 1, channel = 1, fftw = FALSE)
# 瞬時位相
ohayo.p <- atan2(Im(ohayo.h),Re(ohayo.h))
# 瞬時位相
oyasumi.p <- atan2(Im(oyasumi.h),Re(oyasumi.h))
# 位相差の計算．方向統計学のパッケージを利用
phase_diff <- circular(oyasumi.p - ohayo.p)
# 位相差をプロットしている
plot.circular(phase_diff)
# 平均方向
arrows.circular(x=mean.circular(phase_diff),y=rho.circular(phase_diff))
# 2πを24時間として時間に変換
time_diff <- mean.circular(phase_diff)/(2*pi)*24
sprintf("時間のずれは平均%f時間",time_diff)