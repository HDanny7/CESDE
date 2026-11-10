# El Delirio — sitio web (proyecto académico)

Librería en línea: libros digitales (EPUB y PDF) y físicos. HTML5 + CSS3 + JavaScript, sin frameworks.

## Cómo abrirlo
- Descomprime el ZIP y abre `index.html` en el navegador.
- Mejor (para que funcione "Acceder"): `python3 -m http.server 8000` dentro de la carpeta y abre http://localhost:8000
- Se publica tal cual en cualquier hosting estático (GitHub Pages, Netlify, etc.).

## Páginas
`index` · `catalogo` · `libro?id=...` (ficha) · `carrito` (carrito y pago) · `biblioteca` · `acceder` · `nosotros` · `ayuda` (FAQ, formatos, envíos, contacto, legal) · `404`

## Qué es REAL y qué es SIMULADO
| Función | Estado |
|---|---|
| Filtros, búsqueda, orden, paginación, ficha, carrito, cupón, validación de formularios | Real (funciona en el navegador) |
| Pago, pedidos, seguimiento, cuentas, boletín, formulario de contacto | **Simulado**: se guarda en `localStorage`. No cobra, no envía correos. Requiere backend + pasarela. |
| Descargas EPUB/PDF | Archivo `.txt` de demostración (no hay archivos reales) |

## Pendiente de confirmar con el cliente (marcado en el sitio)
- Precios (`js/data.js`), costos de envío por ciudad, cupón `DELIRIO10`
- Portadas reales: guarda `assets/images/portadas/<id>.jpg` (400×600). Sin archivo, se dibuja una portada provisional.
- Logo oficial (hay uno SVG propio en `assets/logos/`), ilustración del gato, banner, fotos de libros físicos
- Muestras gratuitas (solo *Don Quijote* trae texto), misión/historia, devoluciones, términos y privacidad
- Correo (`german@example.com`) y WhatsApp (`573000000000`) de ejemplo; redes sociales
- Dominio real en `robots.txt`, `sitemap.xml` y metadatos
- "Selección destacada" y "Recién llegados" son banderas manuales (`destacado`, `nuevo`) hasta tener datos de ventas.

## Cómo agregar un libro
Añade un objeto en `window.LIBROS` (`js/data.js`) con `id`, `titulo`, `autor`, `anio`, `genero`, `formatos` (precio en COP por formato) y `sinopsis`.

## Estructura
```
index.html … 404.html   css/styles.css   js/data.js (datos)   js/main.js (lógica, comentado)
assets/{images/portadas, icons, logos}   robots.txt   sitemap.xml
```
