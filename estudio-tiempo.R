
setwd("~/Documentos/IA/Practica-IA-Planning/tiempo")
PDDL <- read.table("resultados.txt", header = TRUE, sep = " ")

#install.packages("RColorBrewer")
library(RColorBrewer)
palette <- brewer.pal(name="Set2", n=6)
#dev.new()
plot((PDDL$tiempo)/1000.0 ~ PDDL$libros, type="b", ylim=range(0,1),
     lwd=1.5, pch=1,
     ylab="Tiempo (s)", xlab="Número de libros")
