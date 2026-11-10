/* =========================================================
   data.js — Catálogo de El Delirio
   ⚠ DEMOSTRACIÓN: los títulos son de dominio público.
   ⚠ Los precios (COP) son DE EJEMPLO, pendientes de confirmar con el cliente.
   Para usar portadas reales: guardar assets/images/portadas/<id>.jpg
   (400×600). Si no existe, el sitio dibuja una portada provisional.
   ========================================================= */
window.LIBROS = [
  { id:'don-quijote', titulo:'Don Quijote de la Mancha', autor:'Miguel de Cervantes', anio:'1605', genero:'Novela',
    formatos:{ epub:14000, pdf:12000, fisico:78000 }, destacado:true, nuevo:false,
    sinopsis:'Un hidalgo manchego, trastornado por leer novelas de caballería, se hace caballero andante y sale a los caminos con su escudero Sancho Panza.',
    muestra:'En un lugar de la Mancha, de cuyo nombre no quiero acordarme, no ha mucho tiempo que vivía un hidalgo de los de lanza en astillero, adarga antigua, rocín flaco y galgo corredor.' },
  { id:'frankenstein', titulo:'Frankenstein', autor:'Mary Shelley', anio:'1818', genero:'Ciencia ficción',
    formatos:{ epub:11000, pdf:9000, fisico:56000 }, destacado:true, nuevo:false,
    sinopsis:'Un joven científico da vida a una criatura y debe enfrentar las consecuencias de haberla abandonado.' },
  { id:'veinte-mil-leguas', titulo:'Veinte mil leguas de viaje submarino', autor:'Julio Verne', anio:'1870', genero:'Ciencia ficción',
    formatos:{ epub:12000, pdf:10000 }, destacado:false, nuevo:true,
    sinopsis:'El profesor Aronnax y sus compañeros recorren los océanos a bordo del Nautilus, el submarino del enigmático capitán Nemo.' },
  { id:'orgullo-y-prejuicio', titulo:'Orgullo y prejuicio', autor:'Jane Austen', anio:'1813', genero:'Romance',
    formatos:{ epub:13000, pdf:11000, fisico:62000 }, destacado:true, nuevo:false,
    sinopsis:'Elizabeth Bennet y el señor Darcy se enfrentan a sus propios prejuicios y a las normas sociales de la Inglaterra rural.' },
  { id:'dracula', titulo:'Drácula', autor:'Bram Stoker', anio:'1897', genero:'Misterio',
    formatos:{ epub:13000, fisico:70000 }, destacado:true, nuevo:false,
    sinopsis:'Jonathan Harker viaja a Transilvania para cerrar un negocio con un conde y descubre un secreto oscuro, contado a través de cartas y diarios.' },
  { id:'sabueso-baskerville', titulo:'El sabueso de los Baskerville', autor:'Arthur Conan Doyle', anio:'1902', genero:'Misterio',
    formatos:{ epub:11000, pdf:9500, fisico:58000 }, destacado:false, nuevo:true,
    sinopsis:'Sherlock Holmes y el doctor Watson investigan la leyenda de un perro espectral que ronda los páramos de Dartmoor.' },
  { id:'alicia', titulo:'Alicia en el país de las maravillas', autor:'Lewis Carroll', anio:'1865', genero:'Infantil',
    formatos:{ epub:9000, pdf:8000, fisico:52000 }, destacado:false, nuevo:true,
    sinopsis:'Una niña sigue a un conejo blanco por una madriguera y llega a un mundo donde la lógica funciona al revés.' },
  { id:'marianela', titulo:'Marianela', autor:'Benito Pérez Galdós', anio:'1878', genero:'Novela',
    formatos:{ epub:10000, pdf:8500 }, destacado:false, nuevo:false,
    sinopsis:'Marianela guía a Pablo, un joven ciego; la llegada de un médico que puede devolverle la vista pone a prueba su amistad.' },
  { id:'arte-de-la-guerra', titulo:'El arte de la guerra', autor:'Sun Tzu', anio:'Siglo V a. C.', genero:'Negocios',
    formatos:{ epub:9500, pdf:8000, fisico:45000 }, destacado:true, nuevo:false,
    sinopsis:'Tratado breve de estrategia que hoy se lee también como guía de liderazgo, competencia y toma de decisiones.' },
  { id:'meditaciones', titulo:'Meditaciones', autor:'Marco Aurelio', anio:'Siglo II d. C.', genero:'Autoayuda',
    formatos:{ epub:9000, pdf:7500, fisico:48000 }, destacado:false, nuevo:false,
    sinopsis:'Notas personales del emperador romano sobre disciplina, aceptación y cómo vivir bien.' },
  { id:'maquina-del-tiempo', titulo:'La máquina del tiempo', autor:'H. G. Wells', anio:'1895', genero:'Ciencia ficción',
    formatos:{ epub:8500, pdf:7000, fisico:46000 }, destacado:false, nuevo:true,
    sinopsis:'Un inventor viaja al año 802.701 y descubre una humanidad dividida en dos especies muy distintas.' },
  { id:'origen-de-las-especies', titulo:'El origen de las especies', autor:'Charles Darwin', anio:'1859', genero:'Académicos',
    formatos:{ epub:15000, pdf:13000 }, destacado:false, nuevo:false,
    sinopsis:'Darwin expone su teoría de la evolución por selección natural, apoyada en décadas de observación.' }
];
/* Costos de envío por ciudad — VALORES DE EJEMPLO, pendientes de confirmar */
window.CIUDADES = { 'Medellín':8000, 'Bogotá':12000, 'Cali':12000, 'Barranquilla':14000, 'Otra ciudad de Colombia':18000 };
/* Cupones de demostración (porcentaje de descuento) */
window.CUPONES = { 'DELIRIO10':0.10 };
