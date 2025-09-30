# Analisis-Genómicos

## “Monitoreo bioinformático de virus a partir de datos de nanoporos: una revisión sistemática”
### Cruz-David, Nequiz-Valeria, Salazar-Aldair

## Introducción
#### La plataforma Oxford Nanopore permite la detección electrónica de secuencias de ADN midiendo los cambios de voltaje causados ​​por el movimiento de partículas que pasan a través del poro. Son adecuados para la detección y cuantificación de moléculas biológicas y químicas. Gracias a las continuas mejoras en las tecnologías de secuenciación y a la drástica reducción de los costes per cápita, el uso de la secuenciación de nueva generación ha sido clave en este progreso. Esto da como resultado lecturas más largas, lo que simplifica la reconstrucción del genoma en comparación con las lecturas cortas y ayuda a la identificación de variaciones estructurales, como regiones repetidas y duplicaciones ( van Dijk et al., 2023 ).

## Pipelines bioinformáticos
#### Para procesar las lecturas largas y propensas a errores que se generan, se requieren programas bioinformáticos especializados. Estos pueden ejecutarse automáticamente dentro de los pipelines para proporcionar eficazmente a los responsables de la toma de decisiones toda la información relevante sobre las características moleculares de un virus. 

# Pregunta de investigación. ¿Los pipelines bioinformáticos actuales son compatibles con datos Nanopore y útiles para el análisis del VIH?
### Hipótesis: El uso combinado de pipelines especializados con análisis en R permitirá obtener consensos genómicos confiables y mutacionales relevantes de resistencia.
#### Nota: Los pipelines puestos a prueba bajo este proyecto Genome Detective (https://github.com/samnooij/GenomeDetective_extender), INSAFLU-TELEVIR (https://github.com/INSaFLU/INSaFLU) y ONTdeCIPHER (https://github.com/emiracherif/ONTdeCIPHER), fueron evaluados para la estandarización bioinformática. Se descartaron todos, menos este último debido a complicaciones al momento de su instalación (bases de datos limitadas, acceso limitado).

## ONTdeCIPHER 
### Limitaciones
### SnpEff 
#### Necesita una base de datos para realizar anotaciones genómicas. Existen bases de datos predefinidas para miles de genomas. Pero para el VIH aún no ha sido establecida.
#### Al no poder implementarlo para VIH, se buscaron alternativas factibles, ejecutando 


