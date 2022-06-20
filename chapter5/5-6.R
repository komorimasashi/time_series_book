# 5.6 イベント周期の安定性

library(circular) 　# 角度の計算を行うライブラリ
# 表5.1の就寝時刻
time <- c(23.5, 0, 22.75, 23.5, 0.5, 1.5, 2, 23.25, 1, 23)
degree <- circular(time/24*2*pi) # 方向データに変換する
ave_deg <- mean.circular(degree)
sprintf("就寝は平均%2.1f時",　ave_deg/(2*pi)*24)
rayleigh.test(degree) # レイリー検定

# 図5.17
plot.circular(degree, zero = pi/2, rotation = 'clock')  # 位相差をプロット
arrows.circular(x=degree, y=rep(1,length(degree)), zero = pi/2, length=.1,  lwd =1.5, rotation = 'clock') # 平均方向
arrows.circular(x=mean.circular(degree),y=rho.circular(degree), zero = pi/2,,col=2, length=.1,  lwd =1.5, rotation = 'clock')  # 平均方向
