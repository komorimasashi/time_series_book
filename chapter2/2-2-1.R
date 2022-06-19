# 2.2.1　モードとクラス

# ベクトルを作成します．ベクトルを作成するときはc()を使います
x <- c(1, 3, 5, 7, 9)
y <- c(6:10)
print(x)
print(y)
typeof(x) # type型
mode(x) # mode型
class(x) # class型
is.vector(x)

# ベクトルを列方向で連結すると行列オブジェクトになります
m <- cbind(x , y)
typeof(m) # type型
mode(m) # mode型
class(m) # class型
is.vector(m)
is.matrix(m)

# データフレームクラスのデータを作成します
df <- data.frame(X=x, Y=y)
print(df)
typeof(df) # type型
mode(df) # mode型
# ベクトル以外のオブジェクトに対してmode()を実行するとtypeof()と同じ出力になります
class(df) # class型