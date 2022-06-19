# 2.3.2　時系列データを取り扱うためのクラス

# tsクラス
data(UKgas)
class(UKgas) # たしかに"ts"クラスです
# tsクラスのオブジェクトをプロットするときにはts.plot()を使います
ts.plot(UKgas)
# データ取得開始の（年，四半期）がベクトルとして入っています
start(UKgas)
# データ取得終了の（年，四半期）がベクトルとして入っています
end(UKgas)


library(forecast)
autoplot(UKgas)

# 2020年1月から60ヵ月分の観測値の仮想データ（ランダムウォーク）
set.seed(9999)
x <- ts(data =　cumsum(rnorm(n=60)), start=c(2020,1), frequency=12)
ts.plot(x)

window(x,c(2020,1),c(2021,3))

# 時系列を整然データとして扱うクラス

library(tsibble)
library(dplyr)
library(ggplot2)

# UKgasデータをtbl_tsクラスに変換しggplot2で描画しています

UKgas %>%
  as_tsibble　%>%
  ggplot()　+ geom_line(aes(x = index, y = value))

# UKgasデータをtbl_tsクラスに変換，年ごとに平均値を集計しggplot2で描画しています
UKgas %>%
  as_tsibble　%>%
  # index_by()は{dplyr}のgroup_by()の時系列版です
  index_by(Year = ~ year(.)) 　%>%
  summarise(Mean = mean(value)) %>%
  ggplot()　+ geom_line(aes(x = Year, y = Mean))
