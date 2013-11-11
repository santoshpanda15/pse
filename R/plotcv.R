# Coefficient of variation
cv <- function(x, ...) sd(x, ...)/mean(x, ...)

plotcv <- function(x, stack = FALSE, index.res = 1, col = index.res, ...) { 
	if (stack)
		stop("Unimplemented option: stack!");
	if (index.res != 1)
		stop ("Unimplemented option: index.res");
	if (class(x)!="LHS")
		stop("The first argument should be of class LHS!");
	if (get.repetitions(x)<2)
		stop("Error in function plotcv: the LHS object must have at least two repetitions!")
	pointwise <- apply(get.results(x, FALSE), c(1,2), cv)
	global <- cv(get.results(x, TRUE))
	m <- max(pointwise, 1.05*global)
	Ecdf(pointwise, xlim=c(min(pointwise), m), xlab="pointwise cv", col=col, ...)
	abline(v=global, lwd=2, lty=3)
	if (m > 0.8*max(pointwise)) {pos=2} else {pos=4}
	text(x=global, y=0.1, label="global cv", pos=pos)
}

plotecdf <- function (LHS, stack=FALSE, index.res =1:get.noutputs(LHS), col=index.res, ...) {
	if (stack) {
		dat <- vec(get.results(LHS)[,index.res])
		g <- rep(index.res, each=dim(LHS$res)[1])
		Ecdf(dat, group=g, col=col)
	} else Ecdf(get.results(LHS)[,index.res])
}
