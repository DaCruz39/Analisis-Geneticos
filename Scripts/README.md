# Crear un árbol filogenético 

Dependiendo del pipeline este nos debe arrojar un solo archivo fasta que contega todos los consessos ya juntos 
en este caso nos arrojo este archivo de nombre 
all_fasta.fasta

# Paso 1 
descargamos el archivo fasta en nuentro equipo, nos dirigiremos al servido y vamos a crear una carpeta en donde subiremos el archivo fasta, una vez subido el archivo vamos a poner el directorio en donde se encuentra la del archivo y ejecutamos el siguiente comando 
```bash
mafft --auto all_fasta.fasta > all_fasta_aligned.fasta
```

Este comando es una instrucción para alinear secuencias de ADN usando el programa MAFFT, 
que es uno de los alineadores múltiples más usados en bioinformática por su velocidad, precisión y versatilidad.

# Paso 2 
comprovar si tenomos iqtree 
```bash
which iqtree
iqtree -v
```
Si no esta instalamos en dado caso que no lo tengan 
```bash
conda install -c bioconda iqtree 
```
# 2.1 ejecutamos este coóigo, este comando nos ayudará para un análisis filogenético por máxima verosimilitud (ML) 
usando IQ-TREE, una herramienta muy robusta y rápida para construir árboles evolutivos.

```bash
iqtree -s all_fasta_aligned.fasta -m GTR+G -bb 1000 -nt AUTO
```
te va generar estos archivos en tu carpeta de trabajo 

all_fasta_aligned.fasta.treefile → el árbol (Newick, ya listo)

all_fasta_aligned.fasta.log → registro

all_fasta_aligned.fasta.iqtree → parámetros del modelo

# Paso 3 descargamos todos los datos de la carpeta en el equipo o dispositivo 

# Paso 3.1 vamos a R y ponemos lo siguiente 

setwd("") 
pongan el directorio donde descargaron sus achivos de moba 
```bash
install.packages(ape) 
```
en dado caso que no lo tengamos 

# Ejecución en R 
```bash
library(ape)
tree <- read.tree("all_fasta_aligned.fasta.treefile") 
plot(tree, main="Árbol filogenético (IQ-TREE)", cex=0.8) 
```
