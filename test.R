#!/usr/bin/Rscript
require(ggplot2)
P = read.csv("Performance.csv")
endpoints = rbind(data.frame(TimeThreshold=1, sp=1, sn=0, VolThreshold=0), 
                  data.frame(TimeThreshold=1, sp=0, sn=1, VolThreshold=Inf)
                 )
for (i in 2:12) {
  endpoints = rbind(endpoints,
                    data.frame(TimeThreshold=i, sp=1, sn=0, VolThreshold=0), 
                    data.frame(TimeThreshold=i, sp=0, sn=1, VolThreshold=Inf)
                   )
}
fullappend = rbind(endpoints, P[ , c("sp", "sn", "TimeThreshold", "VolThreshold")])




onecurve  <- ggplot(fullappend[fullappend$TimeThreshold==6, ], aes(x=sp, y=sn, label=VolThreshold))
onecurve + geom_line(size=2) + xlim(1,0) + ylim(0,1) + geom_abline(intercept=1, slope=1) + geom_text() + labs(x="Specificity", y="Sensitivity", title="Time Threshold 6 Hr")




eightcurves <- ggplot(fullappend[fullappend$TimeThreshold >= 5, ], aes(x=sp, y=sn, color=as.factor(TimeThreshold), group=TimeThreshold, label=VolThreshold))
eightcurves + geom_line() + xlim(1,0) + ylim(0,1) + geom_abline(intercept=1, slope=1) + geom_text() + labs(x="Specificity", y="Sensitivity", color="Time")




Pw = cbind( fullappend, wid= (fullappend$TimeThreshold == 6) * 1 + 1)
widplot <- ggplot(Pw[Pw$TimeThreshold >= 5, ], aes(x=sp, y=sn, color=as.factor(wid), size=wid, label=VolThreshold, group=TimeThreshold))
widplot + geom_line() + xlim(1,0) + ylim(0,1) + scale_size(range=c(0.5, 2)) + geom_abline(intercept=1, slope=1) + labs(x="Specificity", y="Sensitivity", title="Time Threshold 6 Hr in bold") + theme(legend.position="none")




# ggsave('filename.png', plotname, width=7, height=7, dpi=100)

