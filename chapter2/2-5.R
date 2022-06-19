# 2.5　時期列の分解

# decompose関数
y <- ts(googletrend, frequency=7)
y.decomp <- decompose(y,type="additive")
plot(y.decomp)


# stl関数
y.stl <- stl(y, s.window="periodic")
plot(y.stl)
#季節調整後のデータ
y.ex_season <- y.stl$time.series[,"trend"]+y.stl$time.series[,"remainder"]
plot(y.ex_season)
