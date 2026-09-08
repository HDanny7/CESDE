Funcion descuento <- CalcularDescuento(total)
    Definir descuento Como Real;
    Si total < 20000 Entonces
        descuento <- 0;
    SiNo
        Si total < 50000 Entonces
            descuento <- total * 0.05;
        SiNo
            Si total < 100000 Entonces
                descuento <- total * 0.10;
            SiNo
                descuento <- total * 0.15;
            FinSi
        FinSi
    FinSi
FinFuncion

Algoritmo CajaLaEsquina
    Definir opcionProducto Como Entero;
    Definir cantidad Como Entero;
    Definir cuaderno Como Real;
    Definir lapicero Como Real;
    Definir resaltador Como Real;
    Definir subtotal Como Real;
    Definir totalCompra Como Real;
    Definir valorDescuento Como Real;
    Definir totalTrasDescuento Como Real;
    Definir totalPagar Como Real;
    Definir medioPago Como Entero;
    Definir otraVenta Como Caracter;
	
    cuaderno <- 8500;
    lapicero <- 1200;
    resaltador <- 3500;
    totalCompra <- 0;
    otraVenta <- "S";
	
    Mientras otraVenta = "S" O otraVenta = "s" Hacer
        Escribir "1) Cuaderno  2) Lapicero  3) Resaltador";
        Escribir "Escoja el producto:";
        Leer opcionProducto;
        Escribir "¿Cuantos quiere?";
        Leer cantidad;
		
        Segun opcionProducto Hacer
            1: subtotal <- cuaderno * cantidad;
            2: subtotal <- lapicero * cantidad;
            3: subtotal <- resaltador * cantidad;
            De Otro Modo: subtotal <- 0;
        FinSegun
		
        Escribir "Subtotal: ", subtotal;
        totalCompra <- totalCompra + subtotal;
		
        Escribir "¿Registrar otro producto? (S/N)";
        Leer otraVenta;
    FinMientras
	
    valorDescuento <- CalcularDescuento(totalCompra);
    totalTrasDescuento <- totalCompra - valorDescuento;
	
    Escribir "Medio de pago: 1) Efectivo  2) Tarjeta  3) Transferencia";
    Leer medioPago;
	
    Segun medioPago Hacer
        1: totalPagar <- totalTrasDescuento - (totalCompra * 0.02);
        2: totalPagar <- totalTrasDescuento + (totalCompra * 0.03);
        3: totalPagar <- totalTrasDescuento;
        De Otro Modo: totalPagar <- totalTrasDescuento;
    FinSegun
	
    Escribir "Generar Factura";
    Escribir "Total productos: ", totalCompra;
    Escribir "Descuento: ", valorDescuento;
    Escribir "Total a pagar: ", totalPagar;
FinAlgoritmo