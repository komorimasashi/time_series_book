#　2.3.1　日付や時刻を扱うクラス

# Dateクラス
today <- Sys.Date() # 今日の日付をDateクラスとして取得します
d <- as.Date("2011-03-11") # 東日本大震災の日をDateクラスに変換します
today- d # 東日本大震災から何日経過したかがわかります

as.Date("2011年3月11日", format="%Y年%m月%d日")
as.Date("11ねん3がつ11にち", format="%yねん%mがつ%dにち")
as.Date("March 11, 2011", format="%B %d, %Y")
as.Date("11 Mar, 2011", format="%d %b, %Y")
as.Date("11/3/2011", format="%d/%m/%Y")

d = as.Date("2011-03-11")
format(d, "%Y年%m月%d日%A") # %Aや%aは曜日を示します

x <- as.Date(c("2011-03-11","2011-09-11","2012-03-11"))
y <- c(5,2,3)
plot(x,y,type="l",xlab="Day",ylab="Value", xaxt="n")
# "month"を"year"や"day"に変更すると刻みを変えることができます
axis.Date(1,at=seq(min(x),max(x),"month"),format="%y/%m/%d")

seq(as.Date("2020-12-25"), as.Date("2021-01-10"), by = "day")


# POSIXctクラスとPOSIXltクラス
as.numeric(as.POSIXct(Sys.time()))
as.POSIXct("2011-03-11 14:46:18")
as.POSIXct("2011-03-11 14:46:18", tz="Japan") # JSTになります
as.POSIXct("2011-03-11 14:46:18", tz="Asia/Tokyo") # JSTになります

t <- as.POSIXct("2011-03-11 14:46:18", tz="Japan")
as.POSIXlt(t, tz="EST") # アメリカ東部標準時で表示 (夏時間なし)

as.POSIXct("2011年3月11日14時46分18秒", format="%Y年%m月%d日%H時%M分%S秒", tz="Japan")
as.POSIXct("2011-03-11 14:46:18", format="%Y-%m-%d %H:%M:%S", tz="Japan")
# 日付を指定しなければ現在の日付になる
as.POSIXct("14:46:18", format="%H:%M:%S", tz="Japan")

t <- as.POSIXct("2011-03-11 14:46:18", tz="Japan")
# %Aや%aは曜日を表示する．%Xは24時間制の時刻を表示する
format(t, "%b %d %A %X %Y %Z")

x <- as.POSIXct(c("6:30","13:00","21:40"), format="%H:%M")
y <- c(5,2,3)
plot(x, y, type="b", xlab="Time", ylab="Value", xaxt="n")
par(xaxt="s")
start_time <- as.POSIXct("0:00",format="%H:%M")
end_time <- as.POSIXct("24:00",format="%H:%M")
axis.POSIXct(1, at=seq(start_time, end_time, "hour"), format="%H:%M")
