par(mfrow = c(2,1))
plot(function(x) dnorm(x, log = TRUE), -6, 6,
     main = "log { Normal density }")
curve(log(dnorm(x)), add = TRUE, col = "red", lwd = 2)
mtext("dnorm(x, log=TRUE)", adj = 0)
mtext("log(dnorm(x))", col = "red", adj = 1)

plot(function(x) pnorm(x, log.p = TRUE), -6, 6,
     main = "log { Normal Cumulative }")
curve(log(pnorm(x)), add = TRUE, col = "red", lwd = 2)
mtext("pnorm(x, log=TRUE)", adj = 0)
mtext("log(pnorm(x))", col = "red", adj = 1)

plot(function(x) dnorm(x), -3, 3, main = "", xlab = "", ylab = "")

plot(function(x) dnorm(x, mean = 1, sd = 0.7), -2, 4, main = "", xlab = "", ylab = "")
plot(function(x) dnorm(x, mean = 0, sd = 0.7), -3, 3, main = "", xlab = "", ylab = "")
