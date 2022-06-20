# 5.8 再帰定量化分析

library(crqa) # 相互再帰定量化分析のためのパッケージ
library(nonlinearTseries) # 非線形時系列データ分析パッケージ

# 再帰定量化分析（RQA）
# データの準備
data(crqa) # 対話中の２者の手や視線の動きのデータが含まれている
ts1 <- handmovement$P1_TT_d[1:300]
ts2 <- handmovement$P2_TT_d[1:300]
ts.plot(cbind(ts1,ts2), col=c(1,2))
legend("topleft", legend = c("ts1","ts2"), col = 1:2, lty = 1)
# 相互情報量から埋め込み遅延時間（ τ ）を決定する
tau.ami = timeLag(ts1, technique = "ami",do.plot = FALSE)
# 埋め込み次元の決定
emb.dim = estimateEmbeddingDim(ts1, time.lag = tau.ami, do.plot = FALSE)
# リカレンスプロットの描画と指標の算出
ts1.rqa <- rqa(time.series = ts1, embedding.dim=emb.dim, time.lag= tau.ami,
               radius=0.1, lmin=2,do.plot=TRUE)
sprintf("再帰率：%f",ts1.rqa$REC)
sprintf("最大線長：%d",ts1.rqa$Lmax)


# 相互再帰定量化分析（CRQA)
library(crqa) # 相互再帰定量化分析のためのパッケージ
par = list(method = "crqa", metric = "euclidean", maxlag = 10,
           radiusspan = 1000, normalize = 0,rescale = 4,
           mindiagline = 10,minvertline = 10, tw = 0,
           whiteline = FALSE, recpt = FALSE, side = "both",
           datatype = "continuous",typeami = "mindip", nbins = 50)

# 遅れ時間と埋め込み次元を決定する
param <- optimizeParam(ts1, ts2, par=par)
res <- crqa(ts1, ts2, delay = param$delay, embed = param$emddim,
            radius = 0.1, normalize = 0, mindiagline = 2,
            minvertline = 2, tw = 0, method = "crqa", side = "both",
            datatype = "continuous")
plotRP(res$RP,par=list(unit = 100, labelx = "Time",
                       labely = "Time", cols = "black",
                       pcex = .5, pch = 15,
                       labax = seq(0, nrow(res$RP), 100),
                       labay = seq(0, nrow(res$RP), 100),
                       las = 1))
sprintf("再帰率：%f",res$RR/100) # パーセンテージを率に変換している
sprintf("最大線長：%d",res$maxL)
