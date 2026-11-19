Función suma <- SumarDigitos (n)
	Definir suma, resto Como Entero
	suma <- 0
	Mientras n>0 Hacer
		resto <- n MOD 10
		suma <- suma+resto
		n <- trunc(n/10)
	FinMientras
FinFunción

Algoritmo Misterio
	Definir numero, pasos Como Entero
	Escribir 'Digite un numero entero positivo:'
	Leer numero
	pasos <- 0
	Mientras numero>9 Hacer
		numero <- SumarDigitos(numero)
		pasos <- pasos+1
	FinMientras
	Escribir 'Resultado: ', numero
	Escribir 'Pasos: ', pasos
	Si numero MOD 2=0 Y numero<>0 Entonces
		Escribir 'Tipo A'
	SiNo
		Escribir 'Tipo B'
	FinSi
FinAlgoritmo
