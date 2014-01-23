#!/usr/bin/Rscript
require(ggplot2)
myhistog <- qplot(rnorm(150))
ggsave('histogram.png', myhistog, width=7, height=7, dpi=100)

P = read.csv("Performance.csv")

qplot(x=sp, y=sn, data=P[P$TimeThreshold==6, ], xlim=c(1,0), ylim=c(0,1))

fancyplot <- ggplot(P[P$TimeThreshold >= 5, ], aes(x=sp, y=sn, color=as.factor(TimeThreshold), group=TimeThreshold))
fancyplot + geom_line() + xlim(1,0) + ylim(0,1)

Pw = cbind( P, wid= (P$TimeThreshold == 6) * 0.5 + 0.1)
widplot <- ggplot(Pw[Pw$TimeThreshold >= 5, ], aes(x=sp, y=sn, color=as.factor(TimeThreshold), size=wid))
widplot + geom_line() + xlim(1,0) + ylim(0,1) + scale_size(range=c(0, 2))
