# 3.4 データの観察と変換

# 3.4.1 図示
# データの観察と変換
library(coronavirus)
library(dplyr)
library(tseries)
library(CADFtest)
# 図示
data(coronavirus)
covid.Ja <- coronavirus %>%
  filter(type == "confirmed") %>%
  filter(date <= as.Date("2021/09/01")) %>%
  filter(country == "Japan")
# 描画
plot(covid.Ja$date,covid.Ja$cases,type="l",xlab="Day",ylab="Cases",xaxt ="n")
axis.Date(1,at=covid.Ja$date[as.numeric(covid.Ja$date) %% 14 == 0],format="%y/%m")


# 3.4.2 対数変換
# 片対数グラフをプロット
plot(covid.Ja$date,covid.Ja$cases,log="y", type="l",xlab="Day",ylab="Cases",xaxt ="n")
axis.Date(1,at=covid.Ja$date[as.numeric(covid.Ja$date) %% 14 == 0],format="%y/%m")

# 2020年2月10日以降のデータのみを取り出し片対数グラフでプロット
covid.Ja.nn<- covid.Ja %>% filter(date >= as.Date("2020/02/10"))
plot(covid.Ja.nn$date,covid.Ja.nn$cases,log="y",type="l",xlab="Day",ylab="Cases",xaxt ="n")
axis.Date(1,at=covid.Ja.nn$date[as.numeric(covid.Ja.nn$date) %% 14== 0 ],format="%y/%m")

# 3.4.3 単位根検定
# 対数変換
logcases <- log(covid.Ja.nn$cases)
# ADF検定
CADFtest(logcases,
         type='trend', # トレンド項も定数項もあり
         max.lag.y=5, # ラグの最大次数を指定
         criterion='AIC' # ラグ次数はAIC規準で選ぶ
)

# 差分系列のADF検定
CADFtest(diff(logcases),
         type='trend', # トレンド項も定数項もあり
         max.lag.y=5, # ラグの最大次数を指定
         criterion='AIC' # ラグ次数はAIC規準で選ぶ
)

# 3.4.4 季節調整
# 季節成分とトレンドとそれ以外に分解する
logcases.diff.stl<-stl(ts(diff(logcases), frequency=7),s.window="periodic")
plot(logcases.diff.stl)
# 季節調整後のデータ
logcases.diff.ex_season <-logcases.diff.stl$time.series[,2]+logcases.diff.stl$time.series[,3]
plot(logcases.diff.ex_season)