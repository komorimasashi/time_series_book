# 6.3 動的因子分析

library(MARSS)

data(lakeWAplankton)
plankdat <- lakeWAplanktonTrans
# 1980年から1990年までのプランクトンの量のデータを抜き出す
dat <- plankdat[1980<=plankdat[,"Year"] & plankdat[,"Year"]<=1990,
                c("Cryptomonas", "Diatoms","Cyclops","Unicells", "Epischura")]
# 時刻が列に対応するように転置する
dat <- t(dat)

# DFAの実行(RおよびQのモデルを設定する)
model.list = list(m=3, R="diagonal and unequal", Q="identity")
fit <- MARSS(dat, model=model.list, z.score=TRUE,
             form="dfa", control=list(maxit=3000))

# 結果の概要（Zは因子負荷量，Rは観測誤差の推定値が示される）
# 因子得点fはfit$statesに入っている
summary(fit)
# 推定された状態f_tのグラフ
plot(fit, plot.type = "xtT")
# 観測値と観測値の予測平均値とCIのグラフ
plot(fit, plot.type = "fitted.ytT")