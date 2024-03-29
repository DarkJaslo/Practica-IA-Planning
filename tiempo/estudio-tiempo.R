
setwd("~/Documentos/IA/Practica-IA-Planning")
PDDL <- read.table("formato.txt", header = TRUE, sep = " ")

#install.packages("RColorBrewer")
library(RColorBrewer)
palette <- brewer.pal(name="Set2", n=6)
#dev.new()
plot(PDDL$tiempo ~ PDDL$libros, ylim=range(0, PDDL$tiempo), type="p",
     col=palette[4], lwd=2, pch=22,
     ylab="Tiempo", xlab="Número de libros")
