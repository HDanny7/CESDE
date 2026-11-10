document.addEventListener('DOMContentLoaded', () => {
  console.log("El Delirio - Librería Virtual cargada correctamente.");

  // Interacción de botones de carrito
  const cartButtons = document.querySelectorAll('.agregar-carrito');
  cartButtons.forEach(button => {
    button.addEventListener('click', (e) => {
      e.preventDefault();
      alert('¡Libro agregado al carrito exitosamente!');
    });
  });

  // Validación básica del formulario de contacto
  const form = document.querySelector('#form-contacto');
  if (form) {
    form.addEventListener('submit', (e) => {
      e.preventDefault();
      alert('¡Mensaje enviado con éxito! Nos pondremos en contacto pronto.');
      form.reset();
    });
  }
});
