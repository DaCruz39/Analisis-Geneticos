
# script: construir_arbol_phylo.R

setwd("C:/Users/Aldair Delgado/Documents/arbol_phylogenetico")
install.packages(ape)
library(ape)
tree <- read.tree("all_fasta_aligned.fasta.treefile")
plot(tree, main="Árbol filogenético (IQ-TREE)", cex=0.8)
