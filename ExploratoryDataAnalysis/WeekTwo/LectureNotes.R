## All of the data stored in this script is stored in the data folder
if (!file.exists("data")) {
   dir.create("data")
}

# Lattice Functions
   # xyplot, bwplot, historam, stripplot, dotplot, splom, levelplot
   ## general plot function: xyplot(y ~x | f*g, data)
library(lattice)
library(datasets)
library(swirl)
## simple lattice plot
xyplot(Ozone~Wind, data=airquality)
## more complex plot
airquality <- transform(airquality, Month=factor(Month))
xyplot(Ozone ~ Wind | Month, data=airquality, layout=c(5,1))
## lattice plots don't print to an object directly, it creates an object of
## class trellis that must be print to an oject, which it calls, in a second step
p <- xyplot(Ozone~Wind, data=airquality) ##Nothing happens
print(p)
# Lattice Panel Functions
set.seed(10)
x <- rnorm(100)
f <- rep(0:1, each=50)
y <- x+f-f*x+rnorm(100, sd=0.5)
f <- factor(f, labels=c("Group 1", "Group 2"))
xyplot(y~ x | f, layout=c(2,1))
## Calling custom panel function
xyplot(x~y | f, panel=function(x, y, ...) {
   panel.xyplot(x,y, ...) ## First call the default panel function for 'xyplot'
   panel.abline(h=median(y),lty=2) ## Add a horizontal line at the median
})
## Lattice panel functions: Regression line
xyplot(x~y | f, panel=function(x, y, ...) {
   panel.xyplot(x,y, ...) ## First call the default panel function for 'xyplot'
   panel.lmline(x, y, col=2) ## overlay a simple linear regression line
})
# The ggplot2 Plotting System - Part 1
   ## qplot() is the base plotting function in ggplot2
   ## the data comes from a data frame
library(ggplot2)
str(mpg)
qplot(displ, hwy, data=mpg)
qplot(displ, hwy, data=mpg, color=drv) # color code the points based on factor variable
qplot(displ, hwy, data=mpg, geom=c("point","smooth")) # create a confidence intervals 95% in the gray area
qplot(hwy, data=mpg, fill=drv ) # histogram
qplot(displ, hwy, data=mpg, facets=.~drv) # facets shows different subgroups (factors) in different panels
qplot(hwy, data=mpg, facets = drv~.,binwidth=2) # facets
# The ggplot2 Plotting System - Part 2
   ## Basoc Components of a ggplot2 Plot
      ## A data frame
      ## aesthetic mappings: how data are mapped to color size
      ## geoms: geometric objects like points, lines, shapes.
      ## facets: for conditional plots.
      ## stats: statistical transformations like binning, quantiles, smoothing.
      ## scales: what scale an aesthetic map uses (example: male=red, female=blue).
      ## coordinate system
testdat <- data.frame(x = 1:100, y = rnorm(100))
testdat[50,2] <- 100 ##Outlier!
plot(testdat$x, testdat$y, type = "l", ylim = c(-3,3)) ## this shows the data and not the outlier
g <- ggplot(testdat, aes(x = x, y = y))
g + geom_line() # this shows the outlier
g + geom_line()+ ylim(-3,3) # be careful with this plot, the outlier is totaly missing
g + geom_line() + coord_cartesian(ylim = c(-3,3)) ## the outlier is included in this graph

