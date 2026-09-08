Funcion definitiva <- CalcularDefinitiva(nota1, nota2, nota3)
    Definir definitiva Como Real;
    definitiva <- nota1*0.30 + nota2*0.30 + nota3*0.40;
FinFuncion

Algoritmo ConsolidadoNotas
    Definir totalEstudiantes Como Entero;
	Definir contador Como Entero;
	Definir aprobados Como Entero;
	Definir escala Como Entero;
	Definir reprobados Como Entero;
	Definir nota1 Como Real;
	Definir nota2 Como Real;
	Definir nota3 Como Real;
	Definir porcentajeAprobacion Como Real;
	Definir definitiva Como Real;
    Definir nombre Como Caracter;
	
    Escribir "¿Cuántos estudiantes va a registrar?";
    Leer totalEstudiantes;
	
    aprobados <- 0;
    reprobados <- 0;
    contador <- 1;
	
    Si totalEstudiantes > 0 Entonces
        Mientras contador <= totalEstudiantes Hacer
            Escribir "Nombre del estudiante:";
            Leer nombre;
            Escribir "Nota 1:";
            Leer nota1;
            Escribir "Nota 2:";
            Leer nota2;
            Escribir "Nota 3:";
            Leer nota3;
			
            definitiva <- CalcularDefinitiva(nota1, nota2, nota3);
            escala <- trunc(definitiva);
			
            Segun escala Hacer
                5: Escribir nombre,definitiva," EXCELENTE";
                4: Escribir nombre,definitiva," SOBRESALIENTE";
                3: Escribir nombre,definitiva," ACEPTABLE";
                De Otro Modo: Escribir nombre,definitiva," INSUFICIENTE";
            FinSegun
			
            Si definitiva >= 3 Entonces
                aprobados <- aprobados + 1;
            SiNo
                reprobados <- reprobados + 1;
            FinSi
			
            contador <- contador + 1;
        FinMientras
		
        porcentajeAprobacion <- (aprobados / totalEstudiantes) * 100;
        Escribir "Aprobados: ", aprobados;
        Escribir "Reprobados: ", reprobados;
        Escribir "% Aprobación: ", porcentajeAprobacion;
    SiNo
        Escribir "No hay estudiantes para procesar";
    FinSi
FinAlgoritmo