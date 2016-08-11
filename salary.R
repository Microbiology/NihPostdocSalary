library(ggplot2)
library(RColorBrewer)

# The new model
a <- 0
for (x in 1:7) {
	if (x == 1) {
		a[x] <- 47484
	} else if (x < 4) {
		a[x] <- a[x-1] * 1.008
	} else {
		a[x] <- a[x-1] * 1.04
	}
}
bdf <- data.frame(a)
bdf$year <- c(1:7)
bdf$model <- "New_Model"
bdf

# The old model
a <- 0
for (x in 1:7) {
	if(x == 1) {
		a[x] <- 44500
	} else {
		a[x] <- a[x-1] * 1.04
	}
}
adf <- data.frame(a)
adf$year <- c(1:7)
adf$model <- "Old_Model"
adf

total <- rbind(adf, bdf)

salaryPlot <- ggplot(total, aes(x=year, y=a, group=model, colour=model)) +
	theme_classic()+
	theme(axis.line.x = element_line(color="black"),
		axis.line.y = element_line(color="black")) +
	geom_line() +
	scale_colour_brewer(palette="Set1") +
	geom_hline(yintercept=47476, linetype="dashed") +
	annotate("text", x = 6, y = 47750, label = "Minimum Threshold") +
	ylab("Postdoc Salary (Dollars)") +
	xlab("Year in Postdoc")

pdf("./PdSalaryPlot.pdf", height=6, width=8)
	salaryPlot
dev.off()
