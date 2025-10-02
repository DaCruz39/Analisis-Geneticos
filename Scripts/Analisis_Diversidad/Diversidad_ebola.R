#### Cargar paquetes necesarios ####
install.packages(c("ape", "BiocManager"))  # si no los tienes
BiocManager::install(c("msa", "Biostrings"))

library(ape) ## Análisis Filogenético y Evolutivo
library(msa) ## Alineamiento Múltiple de Secuencias (MSA)
library(Biostrings) ## Manipulación Eficiente de Secuencias (Bioconductor)



#### 1. Leer todos los FASTA en la carpeta ####

carpeta_fasta <- "C:/Users/dhhcr/Desktop/Analisis_Genetico/Ebola_FASTA" # Carpeta donde están los archivos FASTA
archivos <- list.files(carpeta_fasta, pattern = "\\.fasta$", full.names = TRUE)

# Leer cada FASTA como DNAStringSet
lista_fasta <- lapply(archivos, readDNAStringSet)

# Combinar todos en un único DNAStringSet
fasta_combinado <- do.call(c, lista_fasta)



##### 2. Alineamiento múltiple ####
alineamiento <- msa(fasta_combinado, method = "Muscle")
alineamiento_ape <- as.DNAbin(alineamiento)  # convertir a DNAbin para ape
## Tarda un poco en hacer el alineamiento ##



##### 3. Limpiar columnas con gaps o nucleótidos ambiguos ####
alineamiento_limpio <- alineamiento_ape[, 
                                        apply(alineamiento_ape, 2, function(x) !any(x %in% c("-", "N")))
]



##### 4. Contar sitios polimórficos ####
seg_sites <- seg.sites(alineamiento_limpio)
num_sitios_polimorficos <- length(seg_sites)



##### 5. Calculo de distancias genómicas ####
distancias <- dist.dna(alineamiento_limpio, model = "K80")  # modelo Kimura 2-parameter
dist_promedio <- mean(distancias)



##### 6. Resumen final de diversidad ####
cat("Número de secuencias analizadas: ", nrow(alineamiento_limpio), "\n")
cat("Longitud del alineamiento limpio: ", ncol(alineamiento_limpio), " bases\n")
cat("Número de sitios polimórficos: ", num_sitios_polimorficos, "\n")
cat("Distancia genética promedio entre secuencias: ", round(dist_promedio, 5), "\n")
