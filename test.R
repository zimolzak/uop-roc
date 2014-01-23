#!/usr/bin/Rscript
require(ggplot2)
myhistog <- qplot(rnorm(150))
ggsave('histogram.png', myhistog, width=7, height=7, dpi=100)
