# Figure 2

library("ggplot2")
library("cowplot")
library("ggthemes")
theme_set(theme_grey())

load("gvolcano_unstim.Rdata")
A = gvolcano
load("gvolcano_stim.Rdata")
B = gvolcano

plot_grid(A, B, nrow = 2, labels = c("A","B"))

set.seed(1)
ggsave(filename = "Fig1.jpg", width = 8, height = 11)
set.seed(1)
ggsave(filename = "Fig1.tiff", width = 8, height = 11)
