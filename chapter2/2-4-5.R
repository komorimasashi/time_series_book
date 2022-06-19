# 2.4.5　自己相関

#ホワイトノイズの自己相関

#White noiseの作成
white.noise <- rnorm(100)
ts.plot(white.noise)
###自己相関関数
acf(white.noise)

#ランダムウォーク
#random walkの作成
random.walk <- cumsum(rnorm(100))
ts.plot(random.walk)
acf(random.walk)

#季節成分の含まれたデータ
library(gtrendsR)
trend <- gtrends(
  keyword = "月曜日",  # 検索キーワード
  geo = "JP",  # 検索地域
  time =  "2020-08-01 2020-12-01" #取得期間
)
plot(trend)
googletrend <- trend$interest_over_time$hits
acf(googletrend)
