# 5.2 相互相関

library(fields) # image.plot()を使うため
library(zoo) # rollapplyr()を使うため

# 相互相関
# {rMEA}パッケージに含まれるデータが公開されているgithubのリポジトリ内のファイル
url<-"https://raw.githubusercontent.com/kleinbub/rMEA/master/inst/extdata/normal/203_01.txt"
dat <- read.table(url, sep = " ", header=TRUE)

# 体の動きの大きさの時系列プロット
ts.plot(dat, lty=c(1:2), col=c(1:2))
legend("topright",c("Client","Therapist"),lty=c(1:2),col=c(1:2))

# 相互相関関数
r <- ccf(dat[,1], dat[,2], type = "correlation", lag.max = 100, plot=T, main="")


# 移動ラグ相関
# 相関係数を求める自作関数
corr <- function(x) ccf(x[, 1], x[,2], type = "correlation",lag.max = laglen, plot=F)$acf

# パラメータの設定
window <- 1000 # 相関係数の窓長を1000にする
laglen <- 50 # 考慮するラグの長さ
fps <- 25 # frame per second（1秒間の映像コマ数）
df <- data.frame(dat)
cor_mat<- rollapplyr(df, window, corr, by.column=F)

# 作図
colnames(cor_mat) <- c(-laglen:laglen)
rownames(cor_mat) <- 1:nrow(cor_mat)
image.plot(cor_mat,axes =F, xlab="Time(min)", ylab="Lag(sec)")
axis(1, at=seq(0,1, by=1500/(nrow(cor_mat)-1)),labels=seq(0,14000,　by=1500)/(60*fps))
axis(2, at=seq(0,1, by=50/(ncol(cor_mat)-1)),labels=seq(-laglen, laglen, by=50)/25)

