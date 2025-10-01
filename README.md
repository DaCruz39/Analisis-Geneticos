# Analisis-Genómicos

# “Monitoreo bioinformático de virus a partir de datos de nanoporos: una revisión sistemática”
Cruz-David, Nequiz-Valeria, Salazar-Aldair


## Introducción
La plataforma Oxford Nanopore permite la detección electrónica de secuencias de ADN midiendo los cambios de voltaje causados ​​por el movimiento de partículas que pasan a través del poro. Son adecuados para la detección y cuantificación de moléculas biológicas y químicas. Esto da como resultado lecturas más largas, lo que simplifica la reconstrucción del genoma en comparación con las lecturas cortas y ayuda a la identificación de variaciones estructurales, como regiones repetidas y duplicaciones ( van Dijk et al., 2023 ).
Para procesar las lecturas largas y propensas a errores que se generan, se requieren programas bioinformáticos especializados. Estos pueden ejecutarse automáticamente dentro de los pipelines para proporcionar eficazmente a los responsables de la toma de decisiones toda la información relevante sobre las características moleculares de un virus. 



## Pregunta de investigación. ¿Los pipelines bioinformáticos actuales son compatibles con datos Nanopore y útiles para el análisis del VIH?


### Hipótesis: El uso combinado de pipelines especializados con análisis en R permitirá obtener consensos genómicos confiables y mutacionales relevantes de resistencia.



Nota: Los pipelines puestos a prueba bajo este proyecto Genome Detective (https://github.com/samnooij/GenomeDetective_extender), INSAFLU-TELEVIR (https://github.com/INSaFLU/INSaFLU) y ONTdeCIPHER (https://github.com/emiracherif/ONTdeCIPHER), fueron evaluados para la estandarización bioinformática. Se descartaron todos, menos este último debido a complicaciones al momento de su instalación (bases de datos limitadas, acceso limitado).


## ONTdeCIPHER 
Es un pipeline de secuenciación basado en amplicones de Oxford Nanopore Technology (ONT) que permite realizar análisis posteriores clave sobre datos de secuenciación sin procesar, desde pruebas de calidad hasta el efecto de los SNP y el análisis filogenético. ONTdeCIPHER integra 13 herramientas bioinformáticas, entre ellas Seqkit, la herramienta bioinformática ARTIC, PycoQC, MultiQC, Minimap2, Medaka, Nanopolish, Pangolin (con la base de datos modelo pangoLEARN), Deeptools (PlotCoverage, BamCoverage), Sniffles, MAFFT, RaxML y snpEff. 


# Instalación
## Requerimientos:
Python >=3

Conda >=3


## 1. Descarga del código
```bash
git clone https://github.com/emiracherif/ONTdeCIPHER
cd ONTdeCIPHER 
```

## 2. Instalación de dependencias:
### Para distribuciones Linux
```bash
conda env create --name ontdecipher --file=Environments/ontdecipher_linux.yml
```

### Para macOS
```bash
conda env create --name ontdecipher --file=Environments/ontdecipher_macOS.yml
```
Para usuarios de macOS, consulten la sección de Consejos a continuación. Dado que Medaka no es compatible con el chip Silicon de Apple, ONTdeCIPHER no funciona actualmente en dispositivos equipados con dicho chip.


## 3. Instalación de Artic & Pangolin:
### Artic
```bash
conda activate ontdecipher
cd fieldbioinformatics && python setup.py install
```

### Pangolin
```bash
cd ../Pangolin && bash install_pangolin.sh
```
Nota: pangolin funciona para linaje de variantes de COVID19 (no especializado para otros virus).

### Sniffles
```bash
install -c bioconda snpeff
```

# Estandarización pipeline bioinformático ONTdeCHIPER

##  Activar el entorno conda 
```bash
conda activate ontdecipher
```

##  Selección de muestras 
Se toma en cuenta que sea estrategia por amplicón. Actualmente, ONTdeCIPHER se utiliza principalmente para analizar la diversidad genética del SARS-CoV-2. Sin embargo, cualquier genoma de patógenos basado en amplicones.

Para descargar 8 secuencias
```bash
prefetch ERR1014227 ERR1014312 ERR1050049 ERR1050053 ERR1050067 ERR1050068 ERR1248111 ERR1248113
```

Crear directorio donde guardar las secuencias
```bash
mkdir ebola_sra
```
Desagrupar los archivos en el directorio actual para sacar la versión .sra
```bash
mv E*/* ./
```
Eliminar directorios vacíos 
```bash
rmdir ERR*/
```
Mover archivos .sra a directorio
```bash
mv *.sra ebola_sra
```
Convertir archivos .sra a fastq
```bash
fasterq-dump *.sra
```
Crear directorio para fastq
```bash
mkdir fastq_ebola
```
Mover archivos fastq al directorio creado 
```bash
mv *.fastq /home/lab13/Documents/Ecologia_AnalisisGenomico/ValeriaNequiz/ebola_ontdecipher/ebola_fastq/
```
Asignar una etiqueta a cada muestra
```bash
count=1; for f in *.fastq; do mkdir -p "barcode$(printf "%02d" $count)" && mv "$f" "barcode$(printf "%02d" $count)/" && ((count++)); done
```

Se deberá crear un directorio en primera instancia para guardar los datos de secuenciación 

## Estructura de la ruta de trabajo
```bash
Working_Directory
	├── fastq_pass
	│   ├── barcode01
	│   ├── barcode02
```

## Ejecutar el script maestro
```bash
python3 ruta/al/directorio/del/script/run_ONTdeCIPHER.py --step (valor) --params config.txt --samples config_samplename.tsv -t 4
```
## Explicando el script
``` --step ``` : puede especificarse entre los valores: ``` pycoQC, pip_core, mafft_raxm, pangolin, plots, multiqc ```. Para ejecutar todos, seleccionar ``` --all ```.


``` --params ``` : se configura en un archivo .txt que incoropora parámetros personalizados para su ejecución 

```bash
nano config.txt
```

### Ejemplo
```bash

input_fastq="/home/lab13/Documents/Ecologia_analisis_genomico/ebola_ontdecipher/ebola_fastq"
# tamaño mínimo de lectura
min="300"
# tamaño máximo de lectura
max="2000"
# nombre de salida de RaxML
name="ebola_bootstrap"
# Nombre de database de referencia del virus en SnpEff
reference_genome_snpEff="ebola_zaire"
medaka_model="r941_min_high_g360"
primers="ZaireEbola/V2"
#rutas
sniffles="/home/lab13/anaconda3/envs/ontdecipher/bin/sniffles"
conda_path="/home/lab13/anaconda3"
```

```bash --samples ```: archivo formato .tsv para asociar etiquetas con los nombres de las muestras:

```bash
nano config_prueba.tsv
```

### Ejemplo
```bash
#barcode<TAB>sampleName
barcode01       ERR1014227
barcode02       ERR1014312
barcode03       ERR1050049
barcode04       ERR1050053
barcode05       ERR1050067
barcode06       ERR1050068
barcode07       ERR1248111
barcode08       ERR1248113
```

```bash --threads/t ``` : Número máximo de subprocesos a utilizar. Valor predeterminado: 4

## Crear script maestro 

```bash
nano ejecutar
```

### Ejemplo
```bash
cd ~/ebola_ontdecipher

python3 /home/lab13/Documents/Ecologia_AnalisisGenomico/ValeriaNequiz/ebola_ontdecipher/Scripts/run_ONTdeCIPHER.py \
  --step multiqc \
  --params config.txt \
  --samples config_prueba.tsv \
  -t 4
```

## Resultados de salida del pipeline
Después de ejecutar los pasos de ONTdeCIPHER, tendrá en su directorio de trabajo los siguientes archivos y carpetas.

```bash
├── DagFiles
├── RAxML_bestTree.name_bootstrap
├── RAxML_bipartitions.name_bootstrap
├── RAxML_bipartitionsBranchLabels.name_bootstrap
├── RAxML_bootstrap.name_bootstrap
├── RAxML_info.name_bootstrap
├── Step1_usedConfigs
├── Step2_artic_guppyplex_filter
├── Step3_artic_medaka_result
├── Step4_artic_nanopolish_result
├── Step5_snpEff_result
├── Step6_plotCoverage_result
├── Step7_bamCoverage_result
├── Step8_sniffles_result
├── Step9_consensus_fasta
├── Summary
├── fast5_pass
├── fastq_pass
├── lineage_report.csv
└── report.html
```


## Aspectos a considerar

### SnpEff 
Necesita una base de datos para realizar anotaciones genómicas. Existen bases de datos predefinidas para miles de genomas. Pero para el VIH aún no ha sido establecida.
#### Al no poder implementarlo para VIH, se buscaron alternativas factibles, ejecutando el siguiente código 

```bash
snpEff databases |grep ebola
```
### Esquema de cebadores 
Se necesita disponer de ellos. Actualmente cuenta con los siguientes

![Texto alternativo](https://ejemplo.com/imagen.jpg)


### RaxML
Las herramientas bioinformáticas mafft y raxmlHPC, los cuales se utilizan para el análisis filogenético rápido y escalable de grandes conjuntos de datos, como alineaciones de secuencias de ADN y proteínas, mediante el método de máxima verosimilitud para reconstruir árboles evolutivos. Y al ejecutar con ``` plots ``` la función plot stats y el script plot_tree no se emiten. Pangolin al hacer asignación de linajes epidemiológicos especificos del COVID, inhabilita su funcionamiento para cualquier otro virus.

### Sniffles
Para descargar Sniffles correctamente, los usuarios de macOS deben instalarlo libomp ( vía  ``` brew ```). Después de la instalación, es necesario usar la ruta a la biblioteca libomp en lugar de ```/usr/local/Cellar/libomp/13.0.0``` en los siguientes comandos (si es diferente):

```bash
wget https://github.com/fritzsedlazeck/Sniffles/archive/master.tar.gz -O Sniffles.tar.gz
tar xzvf Sniffles.tar.gz
cd Sniffles-master/
mkdir -p build/
cd build/

cmake .. -DOpenMP_C_FLAGS=-fopenmp=lomp \
-DOpenMP_CXX_FLAGS=-fopenmp=lomp -DOpenMP_C_LIB_NAMES="libomp" \ 
-DOpenMP_CXX_LIB_NAMES="libomp" \
-DOpenMP_libomp_LIBRARY="/usr/local/Cellar/libomp/13.0.0/lib/libomp.dylib" \
-DOpenMP_CXX_FLAGS="-Xpreprocessor \
-fopenmp /usr/local/Cellar/libomp/13.0.0/lib/libomp.dylib \
-I/usr/local/Cellar/libomp/13.0.0/include" -DOpenMP_CXX_LIB_NAMES="libomp" \
-DOpenMP_C_FLAGS="-Xpreprocessor \
-fopenmp /usr/local/Cellar/libomp/13.0.0/lib/libomp.dylib \
-I/usr/local/Cellar/libomp/13.0.0/include"

cd ../bin/sniffles*
./sniffles
```
Para utilizar esta versión de Sniffles, puede proporcionar la ```ruta_absoluta_a/Sniffles-master/bin/sniffles``` en el archivo ```config.txt```.
