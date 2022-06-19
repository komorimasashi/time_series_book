# 2.1.4 データの読み込み

# 本の中では下のソースで書かれている
# tmp <- read.csv("dat.csv", fileEncoding='CP932', header=TRUE, skip=3)

# Github上のデータファイル(文字コードはShift-JIS(CP932))を読み込んで表示する
URL <- "https://raw.githubusercontent.com/komorimasashi/time_series_book/51834306ffd7b5085d65e8058476ae2c65f98276/data/dat.csv"
tmp <- read.csv(URL, fileEncoding='CP932', header=TRUE, skip=3)
print(tmp)
