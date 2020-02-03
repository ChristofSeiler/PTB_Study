# Figure 2

library("ggplot2")
library("cowplot")
library("ggthemes")
theme_set(theme_few())
scale_colour_discrete = function(...) scale_colour_few()

load("network_t_statistic_H1N1.Rdata")
A = network_t_statistic
load("network_log_coefficient_H1N1.Rdata")
B = network_log_coefficient
load("robust_fit_IFNL_mock.Rdata")
C = gmine_with_outlier
load("robust_fit_IFNL_H1N1.Rdata")
D = gmine_with_outlier

plot_grid(A, C, B, D, nrow = 2, labels = c("A","C","B","D"), 
          rel_widths = c(3.5, 1), scale = 0.9)

set.seed(1)
ggsave(filename = "Fig2.jpg", width = 13, height = 8)
set.seed(1)
ggsave(filename = "Fig2.tiff", width = 13, height = 8)
