package EjemploProjectFinal;

import java.util.Scanner;

/* Ferrocarriles de antioquia requiere un sistema que permita asignar un ticket en un tren
 * a un usuario a traves de una venta. Del usuario requiere: id, nombre, apellido, origen, destino.
 * Del tren del tren # de asientos, maquina, Del cajero requiere conocer los mismos datos del usuario mas el rol y la contraseña.
 * Del ticket requiere  requiere conocer: Id del ticket, usuario, tren, asiento, origen, destino, precio.
 * De la venta requiere conocer: ide de la venta, id del ticket, pecio, cantiidad, total
 * El sistema dede permitir: registrar, actualizar, consultar por id, consultar todos y eliminar para cada
 * entidad del sistema, usuarios, trenes, ticket, ventas.
 * El sistema debe permitir navegar las opciones a traves de menus.
 * El sistema debe permitir registrar un cajero e iniciar sesion
 * El sistema debe permitir al cajero contar con un deshboard(solo deben incluir los menus) con los menus a las diferentes opciones despues de iniciar sesion.
 * La compañia cuenta con 3 trenes cada uno con capacidad de 4 pasajeros.
 * Cada tren hace un viaje de ida y vuelta en un dia a 3 destinos: Santa fe, Cisneros y Puerto Berrio*/

public class TrainTicketSystem {
    // Scanner
    static Scanner sc = new Scanner(System.in);

    // Crear las variables para las entidades

    // Usuario

    static int id;
    static String nombre;
    static String apellido;
    static String origen;
    static String destino;


    // Usuario Cajero

    static String rol;
    static String password;

    // Tren

    static int trenId;
    static String modelo;
    static int capacidad;

    // Ticket

    static int ticketId;
    static int usuario;
    static String origenRuta;
    static String destinoRuta;
    static String silla;
    static int tren;
    static String fecha;
    static String hora;
    static double precio;

    // Venta

    static int ventaId;
    static int ticketIdVenta;
    static int cantidad;
    static double precioVentaUnitario;
    static double totalVenta;

    // Arrays: una fila con "" en la primera columna esta libre

    // Usuarios
    static String[][] usuarios = new String[2][5];
    static String[] encabezados = {"Id", "Nombre", "Apellido", "Origen", "Destino" };

    // Trenes: la compañia tiene 3 trenes
    static String[][] trenes = new String[3][3];
    static String[] encabezadosTren = {"Id", "Maquina", "Capacidad"};

    // Cajeros: mismos datos del usuario mas rol y contraseña
    static String[][] cajeros = new String[2][7];
    static String[] encabezadosCajero = {"Id", "Nombre", "Apellido", "Origen", "Destino", "Rol", "Password"};

    // Tickets: 3 trenes x 4 asientos = 12 tickets
    static String[][] tickets = new String[12][7];
    static String[] encabezadosTicket = {"Id", "UsuarioId", "TrenId", "Silla", "Origen", "Destino", "Precio"};

    // Ventas
    static String[][] ventas = new String[12][5];
    static String[] encabezadosVenta = {"Id", "TicketId", "Precio", "Cantidad", "Total"};

    // Fila que deja buscarFila (-1 si el id no existe)
    static int fila;

    public static void main(String[] args) {
        // Deja las matrices libres y carga los 3 trenes de la compañia (capacidad 4)
        iniciar(usuarios);
        iniciar(cajeros);
        iniciar(tickets);
        iniciar(ventas);
        for (int i = 0; i < trenes.length; i++){
            trenes[i][0] = "" + (i + 1);
            trenes[i][1] = "Maquina " + (i + 1);
            trenes[i][2] = "4";
        }
        menuApp();
    }

    // ------------------------------------------------------------
    // Metodos generales (sirven para todas las entidades)
    // ------------------------------------------------------------

    // Llena una matriz con "" para dejar todas sus filas libres
    public static void iniciar(String[][] tabla){
        for (int i = 0; i < tabla.length; i++){
            for (int j = 0; j < tabla[i].length; j++){
                tabla[i][j] = "";
            }
        }
    }

    // Busca el id en la matriz y guarda su fila en "fila" (-1 si no existe)
    public static void buscarFila(String[][] tabla, String idBuscado){
        fila = -1;
        for (int i = 0; i < tabla.length; i++){
            if (tabla[i][0].equals(idBuscado) && !idBuscado.equals("")){
                fila = i;
            }
        }
    }

    // Imprime una fila mostrando cada encabezado con su dato
    public static void imprimirFila(String[][] tabla, String[] enc, int numFila){
        for (int j = 0; j < enc.length; j++){
            System.out.println(enc[j] + ": " + tabla[numFila][j]);
        }
        System.out.println("----------------------------------");
    }

    // Registra una fila nueva pidiendo cada dato por consola
    public static void registrar(String[][] tabla, String[] enc){
        int libre = 0;
        while (!tabla[libre][0].equals("")){
            libre++;
        }
        // Pide el id y repite mientras este vacio
        while (tabla[libre][0].equals("")){
            System.out.println("Ingrese " + enc[0] + ": ");
            tabla[libre][0] = sc.nextLine();
        }
        // Pide el resto de datos
        for (int j = 1; j < enc.length; j++){
            System.out.println("Ingrese " + enc[j] + ": ");
            tabla[libre][j] = sc.nextLine();
        }
        System.out.println("Registro guardado.");
    }

    // Muestra todas las filas registradas
    public static void consultarTodos(String[][] tabla, String[] enc){
        boolean hayDatos = false;
        for (int i = 0; i < tabla.length; i++){
            if (!tabla[i][0].equals("")){
                imprimirFila(tabla, enc, i);
                hayDatos = true;
            }
        }
        if (!hayDatos){
            System.out.println("No hay datos registrados.");
        }
    }

    // Pide un id y muestra solo esa fila
    public static void consultarPorId(String[][] tabla, String[] enc){
        System.out.println("Indique el " + enc[0] + " a consultar: ");
        buscarFila(tabla, sc.nextLine());
        if (fila == -1){
            System.out.println("No se encontro ese id.");
        } else {
            imprimirFila(tabla, enc, fila);
        }
    }

    // Pide un id, deja escoger un dato y lo cambia
    public static void actualizar(String[][] tabla, String[] enc){
        System.out.println("Ingrese el " + enc[0] + " a actualizar: ");
        buscarFila(tabla, sc.nextLine());
        if (fila == -1){
            System.out.println("No se encontro ese id.");
        } else {
            System.out.println("Seleccione el dato a actualizar:");
            for (int j = 1; j < enc.length; j++){
                System.out.println(j + ". " + enc[j]);
            }
            int opcion = sc.nextInt();
            sc.nextLine();
            System.out.println("Nuevo valor de " + enc[opcion] + ": ");
            tabla[fila][opcion] = sc.nextLine();
            System.out.println("Dato actualizado.");
        }
    }

    // Pide un id y deja la fila libre con ""
    public static void eliminar(String[][] tabla, String[] enc){
        System.out.println("Ingrese el " + enc[0] + " a eliminar: ");
        buscarFila(tabla, sc.nextLine());
        if (fila == -1){
            System.out.println("No se encontro ese id.");
        } else {
            for (int j = 0; j < enc.length; j++){
                tabla[fila][j] = "";
            }
            System.out.println("Registro eliminado.");
        }
    }

    // ------------------------------------------------------------
    // Metodo del creacion del ticket
    // ------------------------------------------------------------

    // Crea un ticket: calcula el precio con el destino y revisa que la silla sea valida y este libre
    public static void crearTicket(){
        System.out.println("Ingrese el id del ticket: ");
        String nuevoId = sc.nextLine();
        System.out.println("Ingrese el id del usuario: ");
        String idUsuario = sc.nextLine();
        System.out.println("Ingrese el id del tren: ");
        String idTren = sc.nextLine();
        System.out.println("Ingrese la silla (1 a 4): ");
        int sillaNum = sc.nextInt();
        sc.nextLine();
        System.out.println("Ingrese el origen: ");
        String origenTicket = sc.nextLine();
        System.out.println("Ingrese el destino (Santa Fe, Cisneros o Puerto Berrio): ");
        String destinoTicket = sc.nextLine();

        // Precio segun el destino (queda en 0 si el destino no es valido)
        double precioTicket = 0;
        if (destinoTicket.equalsIgnoreCase("Santa Fe")){
            precioTicket = 15000;
        } else if (destinoTicket.equalsIgnoreCase("Cisneros")){
            precioTicket = 25000;
        } else if (destinoTicket.equalsIgnoreCase("Puerto Berrio")){
            precioTicket = 40000;
        }

        // Revisa si la silla ya esta ocupada en ese tren
        boolean ocupada = false;
        for (int i = 0; i < tickets.length; i++){
            if (tickets[i][2].equals(idTren) && tickets[i][3].equals("" + sillaNum)){
                ocupada = true;
            }
        }

        // Guarda el ticket solo si la silla es valida y esta libre, y el destino es valido
        if (sillaNum >= 1 && sillaNum <= 4 && !ocupada && precioTicket > 0){
            int libre = 0;
            while (!tickets[libre][0].equals("")){
                libre++;
            }
            tickets[libre][0] = nuevoId;
            tickets[libre][1] = idUsuario;
            tickets[libre][2] = idTren;
            tickets[libre][3] = "" + sillaNum;
            tickets[libre][4] = origenTicket;
            tickets[libre][5] = destinoTicket;
            tickets[libre][6] = "" + precioTicket;
            System.out.println("Ticket creado. Precio: " + precioTicket);
        } else {
            System.out.println("Silla no valida, silla ocupada o destino no valido.");
        }
    }

    // ------------------------------------------------------------
    // Metodo del registro de la venta
    // ------------------------------------------------------------

    // Registra una venta de un ticket: total = precio x cantidad
    public static void registrarVenta(){
        int libre = 0;
        while (!ventas[libre][0].equals("")){
            libre++;
        }
        System.out.println("Ingrese el id de la venta: ");
        ventas[libre][0] = sc.nextLine();
        System.out.println("Ingrese el id del ticket: ");
        ventas[libre][1] = sc.nextLine();
        System.out.println("Ingrese la cantidad: ");
        int cantidadVenta = sc.nextInt();
        sc.nextLine();

        buscarFila(tickets, ventas[libre][1]);
        double precioUnitario = Double.parseDouble(tickets[fila][6]);
        ventas[libre][2] = "" + precioUnitario;
        ventas[libre][3] = "" + cantidadVenta;
        ventas[libre][4] = "" + (precioUnitario * cantidadVenta);
        System.out.println("Venta registrada. Total: " + ventas[libre][4]);
    }

    // Actualiza la cantidad de una venta y recalcula el total
    public static void actualizarVenta(){
        System.out.println("Ingrese el id de la venta a actualizar: ");
        buscarFila(ventas, sc.nextLine());
        if (fila == -1){
            System.out.println("No se encontro esa venta.");
        } else {
            System.out.println("Ingrese la nueva cantidad: ");
            int cantidadVenta = sc.nextInt();
            sc.nextLine();
            ventas[fila][3] = "" + cantidadVenta;
            ventas[fila][4] = "" + (Double.parseDouble(ventas[fila][2]) * cantidadVenta);
            System.out.println("Venta actualizada.");
        }
    }

    // ------------------------------------------------------------
    // Metodo de la app
    // ------------------------------------------------------------

    // Menu principal (antes de iniciar sesion): registrar cajero, iniciar sesion o salir
    public static void menuApp(){
        int opcion = -1;
        while (opcion != 0){
            System.out.println("\n===== FERROCARRILES DE ANTIOQUIA =====\n" +
                    "1. Registrar cajero\n" +
                    "2. Iniciar sesion\n" +
                    "0. Salir\n" +
                    "Seleccione una opcion: ");
            opcion = sc.nextInt();
            sc.nextLine();
            if (opcion == 1){
                registrar(cajeros, encabezadosCajero);
            } else if (opcion == 2){
                login();
            }
        }
        System.out.println("Hasta luego.");
    }

    // ------------------------------------------------------------
    // Login
    // ------------------------------------------------------------

    // Pide id y password del cajero con maximo 3 intentos. Si son correctos abre el dashboard
    public static void login(){
        int intentos = 0;
        boolean acceso = false;
        while (intentos < 3 && !acceso){
            System.out.println("Id del cajero: ");
            String idCajero = sc.nextLine();
            System.out.println("Contraseña: ");
            String clave = sc.nextLine();

            buscarFila(cajeros, idCajero);
            if (fila != -1 && cajeros[fila][6].equals(clave)){
                acceso = true;
                dashboard();
            } else {
                intentos++;
                System.out.println("Datos incorrectos. Intento " + intentos + " de 3.");
            }
        }
    }

    // ------------------------------------------------------------
    // Dashboard del cajero (solo menus)
    // ------------------------------------------------------------

    // Menu que ve el cajero despues de iniciar sesion
    public static void dashboard(){
        int opcion = -1;
        while (opcion != 0){
            System.out.println("\n===== DASHBOARD CAJERO =====\n" +
                    "1. Usuarios\n" +
                    "2. Trenes\n" +
                    "3. Tickets\n" +
                    "4. Ventas\n" +
                    "0. Cerrar sesion\n" +
                    "Seleccione una opcion: ");
            opcion = sc.nextInt();
            sc.nextLine();
            if (opcion == 1){
                menuCrud("USUARIOS", usuarios, encabezados);
            } else if (opcion == 2){
                menuCrud("TRENES", trenes, encabezadosTren);
            } else if (opcion == 3){
                menuCrud("TICKETS", tickets, encabezadosTicket);
            } else if (opcion == 4){
                menuCrud("VENTAS", ventas, encabezadosVenta);
            }
        }
    }

    // ------------------------------------------------------------
    // menu de usuario, tren, ticket y venta (un solo menu para las 4 entidades)
    // ------------------------------------------------------------
    public static void menuCrud(String entidad, String[][] tabla, String[] enc){
        int opcion = -1;
        while (opcion != 0){
            System.out.println("\n===== MENU " + entidad + " =====\n" +
                    "1. Registrar\n" +
                    "2. Actualizar\n" +
                    "3. Consultar por id\n" +
                    "4. Consultar todos\n" +
                    "5. Eliminar\n" +
                    "0. Volver\n" +
                    "Seleccione una opcion: ");
            opcion = sc.nextInt();
            sc.nextLine();
            switch (opcion){
                case 1:
                    if (entidad.equals("TICKETS")){
                        crearTicket();
                    } else if (entidad.equals("VENTAS")){
                        registrarVenta();
                    } else {
                        registrar(tabla, enc);
                    }
                    break;
                case 2:
                    if (entidad.equals("VENTAS")){
                        actualizarVenta();
                    } else {
                        actualizar(tabla, enc);
                    }
                    break;
                case 3:
                    consultarPorId(tabla, enc);
                    break;
                case 4:
                    consultarTodos(tabla, enc);
                    break;
                case 5:
                    eliminar(tabla, enc);
                    break;
            }
        }
    }
}
