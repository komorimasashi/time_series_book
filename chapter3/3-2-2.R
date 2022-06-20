# 3.2.2 単位根過程の検定

library(CADFtest)
set.seed(1234)
# ランダムウォークする時系列データを作成します
y <- cumsum(rnorm(200))

# ADF検定
CADFtest(y,
         type='trend', # 定数項もトレンド項もある
         max.lag.y=5, # ラグの最大次数を指定
         criterion='AIC' # ラグ次数はAIC規準で選ぶ
)

# ADF検定
CADFtest(diff(y), # 1階差分系列
         type='trend', # トレンド項も定数項もあり
         max.lag.y=5, # ラグの最大次数を指定
         criterion='AIC' # ラグ次数はAIC規準で選ぶ
)

library(forecast)
ndiffs(y)
