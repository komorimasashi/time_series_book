# 5.4.1 コヒーレンス

# 信号の作成
# 1000Hzのサンプリングレートで0.25秒のデータデータを作成
t <- seq(0,.2499, by=0.001)
# xには80Hzのcos波形と120Hzのsin波形
x <- cos(2*pi*80*t) + 0.5*sin(2*pi*120*t)
# yには80Hzのsin波形と200Hzのcos波形
y <- sin(2*pi*80*t) + 0.8*sin(2*pi*200*t)

# パワースペクトル
X <- fft(x,250) # xをフーリエ変換
Y <- fft(y,250) # yをフーリエ変換
frequency <- 1000/250*(0:124) # ナイキスト周波数の範囲を設定
Pxx <- Conj(X)*X/250 # xのパワースペクトルを求める．Conj()は複素共役
Pyy <- Conj(Y)*Y/250 # yのパワースペクトルを求める

par(mfrow=c(2,2))
plot(t,x,type="l",col=1, ylim=c(-1.8,1.8), main="x")
plot(frequency, Re(Pxx)[1:125],type="l", ylab="power", main="Powerspectrum of x")
plot(t,y,type="l",col=2, ylim=c(-1.8,1.8), main="y")
plot(frequency, Re(Pyy)[1:125],type="l",ylab="power",main="Power spectrum of y")

# クロススペクトル
Cxy <- Conj(X)*Y/250
plot(frequency, abs(Cxy)[1:125],type="l", ylab="amplitude", main="Cross spectrum")

# 21番目の要素が80Hzでのθです．π/2位相がずれています
Im(log(Cxy/abs(Cxy)))[21]

# {seewave}による分析
library(seewave)
spec(x, f=1000) # xのパワースペクトル
spec(y, f=1000) # yのパワースペクトル
coh(x, y, f=1000) # xとyのコヒーレンス