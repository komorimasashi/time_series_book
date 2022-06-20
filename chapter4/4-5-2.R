# 4.5.2 時系列分割による交差検証

library(rsample)
df.cv <- rsample::rolling_origin(
  data.frame(AirPassengers),
  # 最初の訓練用期間を24ヵ月とする
  initial = 24,
  # 検証用期間を12ヵ月とする
  assess = 12,
  # スライドを12ヵ月とする(0のときはスライド1ヵ月)
  skip = 11,
  # TRUE: 交差検証法(1)の方法，FALSE: 交差検証法(2)の方法
  cumulative = T
)

analysis(df.cv$splits[[1]]) # 訓練用データセットの1つ目
assessment(df.cv$splits[[1]]) # 検証用データセットの1つ目