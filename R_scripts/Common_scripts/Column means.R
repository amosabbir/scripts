center_colmeans <- function(x) { 
	xcenter = colMeans(x)
	x - rep(xcenter, rep.int(nrow(x), ncol(x)))
	}