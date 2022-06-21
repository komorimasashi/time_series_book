# RとStanではじめる 心理学のための時系列分析入門 

このページは『RとStanではじめる 心理学のための時系列分析入門』（講談社, 2022/6/23発売）のサポートサイトです．

<img src="https://user-images.githubusercontent.com/37983185/174610037-5e5e6d25-4ae5-4c41-9758-13335c0bc12a.png" width=20%>

* * *
## 本の情報
本書の概要，目次などについては出版社のページ（
https://www.kspub.co.jp/book/detail/5280751.html 
）
を御覧ください．
購入は下のリンクからできます．

  -　Amazon　https://www.amazon.co.jp/dp/4065280753

  -　紀伊國屋書店　https://www.kinokuniya.co.jp/f/dsg-01-9784065280751

* * *
## 本の内容とソースコード
書籍中のソースコードは各chapterのディレクトリにアップしています．また下記のGoogle ColaboratoryのNotebookから閲覧することが出来ます．
さらに左上の「Open In Colab」ボタンをクリックすることでブラウザ上で実行することも出来ます．

### 1章：　心理学と時系列データ分析
- [1章Colab Notebook](chapter1/Chapter_1.ipynb)
### 2章：　時系列分析の基本操作　
- 時系列クラス（Date，POSIXct，POSIXlt，tsibble），季節調整，ARIMAモデルなど 
- [2章Colab Notebook](chapter2/Chapter_2.ipynb)
### 3章：　時系列の回帰分析
- 拡張ディッキー−フラー検定，ダービン−ワトソン検定，一般化最小二乗法（GLS），潜在成長曲線モデル，中断時系列分析など
- [3章Colab Notebook](chapter3/Chapter_3.ipynb)
### 4章：　RStanによる状態空間モデル
- 状態空間モデル（ローカル線形トレンドモデル等），隠れマルコフモデル，変化点モデルほか
- [4章Colab Notebook](chapter4/Chapter_4.ipynb)
### 5章：　時系列データ同士の関係の評価
- ラグ相互相関，動的時間伸縮，コヒーレンス， ウェーブレットクロススペクトル解析，時系列クラスタリング，<br>
  再帰定量化分析，グレンジャー因果性検定，直交化インパルス応答ほか
- [5章Colab Notebook](chapter5/Chapter_5.ipynb)
### 6章：　多変量時系列データの要約
- 時系列因子分析，関数主成分分析ほか
- [6章Colab Notebook](chapter6/Chapter_6.ipynb)

* * *
## 正誤表
*　　pp.77-81<br>
（誤） 文中の`3-4-1.R`, `3-4-2.R`, `3-4-3.R`, `3-4-4.R`　各ファイルのソースコード<br>
（正） 1つのファイル（`3-4-1.R`）にまとめています

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
