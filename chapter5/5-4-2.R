# 5.4.2 ウェーブレットクロススペクトル解析

# Morletウェーブレットの形
morlet <- function(x) exp(-x^2/4) * cos(5*x)
x <- seq(-20,20,length=1000)
y <- morlet(x)
plot(x,y,type="l", lwd=3, ylim=c(-1.1,1.1),xlab="",ylab=expression(psi[a,tau](t)))
abline(h=0, lwd=0.5, lty=3)


# Instagramへの選挙関連投稿数の分析
library(WaveletComp)
data(USelection2016.Instagram)
posts <- apply(USelection2016.Instagram[, 2:5], FUN = "diff", MAR
               = 2)
df <- data.frame(date = as.POSIXct(USelection2016.Instagram$date[-1], tz="EST5EDT"), posts)
at <- seq(from = as.POSIXct("2016-10-31 00:00:00", tz = "EST5EDT"),
          to = as.POSIXct("2016-11-06 00:00:00", tz = "EST5EDT"),
          by = "days")

# ウェーブレット変換
w <- analyze.wavelet(df, "trump.pos", dt = 1, dj = 1/100, lowerPeriod = 6, upperPeriod = 36)
wt.image(w, legend.params = list(lab = "wavelet power levels", label.digits = 2),
         periodlab = "period (hours)", spec.period.axis = list(at = c(12, 24)),
         show.date = TRUE, spec.time.axis = list(at = at)
)

# ウェーブレットクロススペクトル
wc <- analyze.coherency(df, my.pair = c("trump.pos", "clinton.pos"),
                        dt = 1, dj = 1/100, lowerPeriod = 6, upperPeriod = 36)

wc.image(wc, lvl = 0.1, p = 0,
         legend.params = list(lab = "cross-wavelet power levels", label.digits = 2),
         periodlab = "period (hours)", spec.period.axis = list(at = c(12, 24)),
         show.date = TRUE, spec.time.axis = list(at = at))