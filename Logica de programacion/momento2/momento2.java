package notes;

import java.util.Scanner;

public class momento2 {
    static Scanner sc = new Scanner(System.in);

    public static void main(String[] args) {
        double[] consumo = new double[6]; // aqui guardo los consumos
        int opcion = 0;

        do {
            mostrarMenu();
            opcion = sc.nextInt();
            switch (opcion) {
                case 1:
                    registrarConsumo(consumo);
                    break;
                case 2:
                    consultarFactura(consumo);
                    break;
                case 3:
                    generarReporte(consumo);
                    break;
                case 4:
                    System.out.println("Salir");
                    break;
                default:
                    System.out.println("Opción inválida");
                    break;
            }
        } while (opcion != 4);
    }

    // Muestra el menu, se hace de esta forma porq al meterlo en el switch no me deja organizarlo bien.
    public static void mostrarMenu() {
        System.out.println("===== LOS GUADUALES - CONTROL DE AGUA =====");
        System.out.println("1. Registrar consumo de un apartamento");
        System.out.println("2. Consultar factura de un apartamento");
        System.out.println("3. Ver reporte general del conjunto");
        System.out.println("4. Salir");
    }

    // Al igual que el anterior no puedo ponerlo en cada case del switch, aqui genero un while para identificar el apto al cual se le va a registrar su consumo
    public static void registrarConsumo(double[] consumos) {
        System.out.println("numero de apartamento (1 a 6):");
        int a = sc.nextInt();
        // Trate de hacerlo sin el operador y no pude dar con un resultado correcto, me toco ver un video para incorporarlo.
        while (a < 1 || a > 6) {
            System.out.println("mal, escriba otra vez (1 a 6):");
            a = sc.nextInt();
        }

        System.out.println("consumo en m3:");
        double c = sc.nextDouble();
        while (c <= 0) {
            System.out.println("tiene que ser mayor que 0, intentar de nuevo:");
            c = sc.nextDouble();
        }
        // esto lo trate de poner sin el a - 1 y no me dio, despues de ver como hacerlo con un caso parecido ahi si me dejo aunque sigo sin entender el detras de esto.
        consumos[a - 1] = c; // se resta 1 porque el arreglo empieza en 0, esto a diferencia que en python me genera duda que no inicie desde 0
        System.out.println("listo, guardado");
    }

    // pide el apto y muestra la factura
    public static void consultarFactura(double[] consumos) {
        System.out.println("numero de apartamento (1 a 6):");
        int a = sc.nextInt();
        while (a < 1 || a > 6) {
            System.out.println("mal, escriba otra vez (1 a 6):");
            a = sc.nextInt();
        }
        // Aqui se calcula, si el apto seleccioando no tiene un valor por eso el == 0, este no muestra valor sino que muestra ese print
        if (consumos[a - 1] == 0) {
            System.out.println("El apartamento " + a + " no tiene consumo registrado");
        } else {
            // Aqui imprime "a" que es el numero de apartamento y el consumo que es el gasto del apartamento en cuestion.
            imprimirFactura(a, consumos[a - 1]);
        }
    }

    // imprime la factura, aqui se hacen los calculos del consumo
    public static void imprimirFactura(int apartamento, double consumo) {
        // Definimos las tarifas para cada caso en el que se gasto cierto cantidad de agua en m3
        double tarifa = 0;
        if (consumo <= 10) {
            tarifa = 3000;
        }
        if (consumo > 10 && consumo <= 20) {
            tarifa = 4500;
        }
        if (consumo > 20) {
            tarifa = 6000;
        }
        // Calculamos el consumo + la tarifa, le asignamos este calculo a la variaqble "valor", y le asignamos el subtotal que seria la fija + el valor
        double valor = consumo * tarifa;
        double subtotal = 12000 + valor;
        double recargo = 0;
        // Definimos el recargo para los casos donde se sobrepasa el consumo. Esto nos dice que si consumo supera el 25 se crea la variable recargo que es el subtotal + el 10%
        if (consumo > 25) {
            recargo = subtotal * 0.10;
        }
        // El total es siempre el subtotal + el recargo, si no hay recargo es valor siempre sera 0 para esa variable.
        double total = subtotal + recargo;

        // Imprimimos todo lo anterior segun se necesite.
        System.out.println("---- FACTURA APTO " + apartamento + " ----");
        System.out.println("Consumo: " + consumo);
        System.out.println("Tarifa: " + tarifa);
        System.out.println("Valor consumo: " + valor);
        System.out.println("Cargo fijo: 12000");
        if (consumo > 25) {
            System.out.println("Recargo: " + recargo);
        }
        System.out.println("Total a pagar: " + total);
        if (consumo > 25) {
            System.out.println("ALERTA: consumo excesivo");
        }
    }

    // el reporte de todos los datos hasta el momento
    public static void generarReporte(double[] consumos) {
        double suma = 0;
        int registrados = 0;
        int sinregis = 0;
        int excesivo = 0;
        double mayor = 0;
        int aptoMayor = 0;

        // Se crea el contador
        int i = 0;
        // Se crea un while donde se revisa que la variable i que en este caso corresponde a los apto y dependiendo de si tiene datos o no hace una cosa u otra
        while (i < 6) {
            // Revisa los datos en consumo y si este no tiene datos agrega a la variable sinregis un punto porque hay aptos que no tienen registro.
            if (consumos[i] == 0) {
                sinregis = sinregis + 1;

            // Lo mismo que lo de arriba pero si hay datos este lo guarda en la cariable resgistrados.
            } else {
                registrados = registrados + 1;
                // Suma guarda el consumo total de los apto que tienen reegistro para tener el consumo total
                suma = suma + consumos[i];
                // Si hay algun dato con consumo superior al 25 este se cuarda en la variable excesivo para el gasto.
                if (consumos[i] > 25) {
                    excesivo = excesivo + 1;
                }
                // Guarda que apartamento tiene mayor consumo, pregunta por cada valor y guarda el primero que toma como el mayor, despues pasa al siguiente para ver si es mayor o menos y o guarda en la variable mayor.
                if (consumos[i] > mayor) {
                    mayor = consumos[i];
                    aptoMayor = i + 1;
                }
            }
            i = i + 1; // sin esto el while nunca termina
        }
        // Si no hay ningun valor registrado se muestra el siguiente print
        if (registrados == 0) {
            System.out.println("Aún no hay consumos registrados");
        } else {
            // Si hay datos lo que hace es que la variable suma que contenia la suma de todos los consumos se divide por el numero de apto registrados y estop daria el promedio.
            double promedio = suma / registrados;

            // lo mismo de la factura pero para el que gasto mas
            double t = 0;
            if (mayor <= 10) {
                t = 3000;
            }
            if (mayor > 10 && mayor <= 20) {
                t = 4500;
            }
            if (mayor > 20) {
                t = 6000;
            }
            double gasto = 12000 + mayor * t;
            if (mayor > 25) {
                gasto = gasto + gasto * 0.10;
            }

            System.out.println("---- REPORTE ----");
            System.out.println("Consumo total: " + suma);
            System.out.println("Promedio: " + promedio);
            System.out.println("Mayor consumo: apto " + aptoMayor + " con " + mayor + " m3 y pago " + gasto);
            System.out.println("Sin registro: " + sinregis);
            System.out.println("Con consumo excesivo: " + excesivo);
        }
    }
    // De la linea 121 a 176 me ayude de la IA, mas que no poder hacerlo me enrede varias veces y ya por tiempo decidi terminarlo asi.
    // Pensandolo hubierea sido bueno agregar una funcion de eliminar algun registro o todos estos cuando pase un mes para mes a mes tener nuevos datos.
}
