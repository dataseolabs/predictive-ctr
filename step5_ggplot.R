library(ggplot2)

sitename <- paste("Mon Site (",nrow(scdata)," requêtes )")


hh <- ggplot(click_curve, aes(position, CTRmean)) + theme_minimal()

hh <- hh + geom_line(linetype = 2) + coord_cartesian(xlim = c(1, 10), ylim = c(0,1))
hh <- hh + geom_ribbon(aes(position, ymin = lower, ymax = upper), alpha = 0.2, fill = "orange")
hh <- hh + scale_y_continuous(labels = scales::percent)
hh <- hh + geom_point() + geom_label(aes(label = scales::percent(CTRmean)))
hh <- hh + labs(title=sitename)
hh <- hh + labs(x="position",y="ctr moyen") 

print(hh)



