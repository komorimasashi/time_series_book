# RとStanではじめる 心理学のための時系列分析入門 

このページは『RとStanではじめる 心理学のための時系列分析入門』（講談社, 2022/6/23発売）のサポートサイトです．

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
書籍中のソースコードは各chapterのディレクトリにアップしています．また下記のGoogle ColaboratoryのNotebookから閲覧することが出来ます．
さらに左上の「Open In Colab」ボタンをクリックすることでブラウザ上で実行することも出来ます．

### 1章：　心理学と時系列データ分析
[1章Colab Notebook](chapter1/Chapter_1.ipynb)
### 2章：　時系列分析の基本操作
[2章Colab Notebook](chapter2/Chapter_2.ipynb)
### 3章：　時系列の回帰分析
[3章Colab Notebook](chapter3/Chapter_3.ipynb)
### 4章：　RStanによる状態空間モデル
[4章Colab Notebook](chapter4/Chapter_4.ipynb)
### 5章：　時系列データ同士の関係の評価
[5章Colab Notebook](chapter5/Chapter_5.ipynb)
### 6章：　多変量時系列データの要約
[6章Colab Notebook](chapter6/Chapter_6.ipynb)

* * *
## 正誤表

*　　p.141　<br>
（誤）　`fit <- sampling(model6, data=dat, iter=1000, warmup=500, thin=4, chains=4)`<br>
（正）　`fit <- sampling(model7, data=dat, iter=1000, warmup=500, thin=4, chains=4)`<br>


*　P.164　<br>
（誤）　`model13 <- stan_model(file = "model12.stan", model_name="hmm")`　<br>
（正）　`model12 <- stan_model(file = "model12.stan", model_name="hmm")`　<br>


* * *
## 連絡先
誤りなどのご指摘は，下記にご連絡いただけると幸いです．

大阪電気通信大学
小森政嗣
komori@osakac.ac.jp
