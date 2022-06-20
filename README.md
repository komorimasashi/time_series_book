# RとStanではじめる 心理学のための時系列分析入門 

このページは『RとStanではじめる 心理学のための時系列分析入門』（講談社, 2022/6/23発売）のサポートサイトです(作成中)．

* * *
## 本の情報
本書の概要，目次などについては出版社のページ（
https://www.kspub.co.jp/book/detail/5280751.html 
）
を御覧ください．
購入は下のリンクからできます．
Amazon　https://www.amazon.co.jp/dp/4065280753

紀伊國屋書店　https://www.kinokuniya.co.jp/f/dsg-01-9784065280751

* * *
## ソースコード
### 1章：　心理学と時系列データ分析
### 2章：　時系列分析の基本操作
### 3章：　時系列の回帰分析
### 4章：　RStanによる状態空間モデル
### 5章：　時系列データ同士の関係の評価
### 6章：　多変量時系列データの要約

* * *
## 正誤表

p.141 「fit <- sampling(model6, data=dat, iter=1000, warmup=500, thin=4, chains=4)」は

正しくは「fit <- sampling(model7, data=dat, iter=1000, warmup=500, thin=4, chains=4)」


P.164「model13 <- stan_model(file = "model12.stan", model_name="hmm")」は

正しくは「model12 <- stan_model(file = "model12.stan", model_name="hmm")」

* * *
## 連絡先
大阪電気通信大学
小森政嗣
komori@osakac.ac.jp
