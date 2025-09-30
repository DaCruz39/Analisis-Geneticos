# Analisis-Genómicos

## “Monitoreo bioinformático de virus a partir de datos de nanoporos: una revisión sistemática”
Cruz-David, Nequiz-Valeria, Salazar-Aldair

## Introducción
La plataforma Oxford Nanopore permite la detección electrónica de secuencias de ADN midiendo los cambios de voltaje causados ​​por el movimiento de partículas que pasan a través del poro. Son adecuados para la detección y cuantificación de moléculas biológicas y químicas. Esto da como resultado lecturas más largas, lo que simplifica la reconstrucción del genoma en comparación con las lecturas cortas y ayuda a la identificación de variaciones estructurales, como regiones repetidas y duplicaciones ( van Dijk et al., 2023 ).
Para procesar las lecturas largas y propensas a errores que se generan, se requieren programas bioinformáticos especializados. Estos pueden ejecutarse automáticamente dentro de los pipelines para proporcionar eficazmente a los responsables de la toma de decisiones toda la información relevante sobre las características moleculares de un virus. 

## Pregunta de investigación. ¿Los pipelines bioinformáticos actuales son compatibles con datos Nanopore y útiles para el análisis del VIH?
### Hipótesis: El uso combinado de pipelines especializados con análisis en R permitirá obtener consensos genómicos confiables y mutacionales relevantes de resistencia.

Nota: Los pipelines puestos a prueba bajo este proyecto Genome Detective (https://github.com/samnooij/GenomeDetective_extender), INSAFLU-TELEVIR (https://github.com/INSaFLU/INSaFLU) y ONTdeCIPHER (https://github.com/emiracherif/ONTdeCIPHER), fueron evaluados para la estandarización bioinformática. Se descartaron todos, menos este último debido a complicaciones al momento de su instalación (bases de datos limitadas, acceso limitado).

## ONTdeCIPHER 
Es un pipeline de secuenciación basado en amplicones de Oxford Nanopore Technology (ONT) que permite realizar análisis posteriores clave sobre datos de secuenciación sin procesar, desde pruebas de calidad hasta el efecto de los SNP y el análisis filogenético. ONTdeCIPHER integra 13 herramientas bioinformáticas, entre ellas Seqkit, la herramienta bioinformática ARTIC, PycoQC, MultiQC, Minimap2, Medaka, Nanopolish, Pangolin (con la base de datos modelo pangoLEARN), Deeptools (PlotCoverage, BamCoverage), Sniffles, MAFFT, RaxML y snpEff. 





### SnpEff 
#### Necesita una base de datos para realizar anotaciones genómicas. Existen bases de datos predefinidas para miles de genomas. Pero para el VIH aún no ha sido establecida.
#### Al no poder implementarlo para VIH, se buscaron alternativas factibles, ejecutando el siguiente código 

```bash
snpEff databases |grep i- ebola
```
#### Se necesita un esquema de cebadores 
![Texto alternativo](https://ejemplo.com/imagen.jpg)

