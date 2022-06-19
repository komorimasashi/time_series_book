# 2.4.3　移動平均

library(zoo)
library(dplyr)
library(ggplot2)
library(tidyr)

#データの作成
day <- seq(as.Date("2020-12-25"), as.Date("2021-01-10"), by = "day")
dat.original <- rnorm(length(day))

#移動平均
dat.moving_average <-  zoo::rollmean(dat.original, 7, align = "right", fill = NA)

#データフレームの作成する
df <- data.frame(day = day) %>%
  dplyr::mutate(original = dat.original) %>%
  dplyr::mutate(moving_average = dat.moving_average) %>%
  pivot_longer(-day, names_to = "dat", values_to = "value")

#作図
ggplot(df,aes(day)) + geom_line(aes(y = value, colour = dat))
