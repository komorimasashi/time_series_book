# 6.4 関数主成分分析

library(fda)

# 膝関節データの読み込み
data(gait)
# 元データのプロット(20時点，39人)
matplot(gait[,,2], type="l", xlab="time", ylab="angle")

# 基底関数の作成(フーリエ級数)
# 8つの基底関数を作成
basis.f <- create.fourier.basis(c(0, 1), nbasis=8)
gait.ft <- smooth.basis(dimnames(gait)[[1]], gait[,,2], basis.f) # 基底関数の当てはめ
plot(gait.ft,xlab="time",ylab="angle") # 描画 
lines(mean.fd(gait.ft$fd),lwd=3,col=1) # 平均関数

# 基底関数の作成(B-スプライン関数，8つの基底関数)
# 8つの基底関数を作成(norder=4は3次のスプラインであることを指す) 
basis.b <- create.bspline.basis(c(0,1),nbasis=8, norder=4)
gait.bs <- smooth.basis(dimnames(gait)[[1]], gait[,,2], basis.b)
# 基底関数の当てはめ
plot(gait.bs,xlab="time",ylab="angle") # 描画 
lines(mean.fd(gait.bs$fd),lwd=3,col=1) # 平均関数


# 関数主成分分析の実行
# まず基底関数と同じ数の主成分を求める 
gait.pca <- pca.fd(gait.ft$fd, nharm = 8) 
plot(cumsum(gait.pca$varprop),type="o",xlab='component',ylab='contribution') # 累積寄与率 
plot(gait.pca$harmonics[1:3]) # 固有関数

# 角度パターンの各種成分軸に沿った変化
plot.pca.fd(gait.pca, cex.main=1)
# 主成分得点
plot(gait.pca$scores[,c(1,2)], xlab="FPC Score 1",ylab="FPC Score 2") # PC1-PC2 
text(gait.pca$scores[,c(1,2)],labels=dimnames(gait)[[2]],cex=1)
plot(gait.pca$scores[,c(1,3)], xlab="FPC Score 1",ylab="FPC Score 3")  # PC1-PC3
text(gait.pca$scores[,c(1,3)],labels=dimnames(gait)[[2]],cex=1)
