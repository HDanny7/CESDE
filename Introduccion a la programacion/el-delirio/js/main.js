/* =========================================================
   main.js — Lógica de El Delirio (JavaScript ES6+, sin frameworks)
   Todo lo "transaccional" (carrito, pago, biblioteca, cuentas, boletín)
   está SIMULADO con localStorage, tal como indica el brief académico.
   Para vender de verdad se necesita backend + pasarela de pago.
   ========================================================= */
(() => {
'use strict';

/* ---------- Utilidades ---------- */
const L = window.LIBROS, CIUDADES = window.CIUDADES, CUPONES = window.CUPONES;
const $  = (s, c = document) => c.querySelector(s);
const $$ = (s, c = document) => [...c.querySelectorAll(s)];
const COP = n => new Intl.NumberFormat('es-CO', { style:'currency', currency:'COP', maximumFractionDigits:0 }).format(n);
const FMT = { epub:'EPUB', pdf:'PDF', fisico:'Físico' };
const esc = s => String(s).replace(/[&<>"']/g, c => ({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[c]));
const norm = s => s.toLowerCase().normalize('NFD').replace(/[\u0300-\u036f]/g, '');
const libro = id => L.find(l => l.id === id);
const precioMin = l => Math.min(...Object.values(l.formatos));

/* Almacenamiento seguro (localStorage puede fallar en modo privado) */
const store = {
  get(k, d) { try { const v = localStorage.getItem('delirio:' + k); return v === null ? d : JSON.parse(v); } catch { return d; } },
  set(k, v) { try { localStorage.setItem('delirio:' + k, JSON.stringify(v)); } catch { /* sin almacenamiento */ } },
  del(k)    { try { localStorage.removeItem('delirio:' + k); } catch { /* nada */ } }
};

/* Aviso breve (role=status para lectores de pantalla) */
let toastT;
function toast(msg) {
  let t = $('.toast');
  if (!t) { t = document.createElement('div'); t.className = 'toast'; t.setAttribute('role', 'status'); document.body.appendChild(t); }
  t.textContent = msg; t.classList.add('ver');
  clearTimeout(toastT); toastT = setTimeout(() => t.classList.remove('ver'), 2600);
}

/* ---------- Gráficos: gato de la marca y portadas ---------- */
/* El gato con libro y luz. Las pupilas (.pupila) siguen al cursor si la clase es "gato-vivo". */
const gato = (cls = '') => `<svg class="gato ${cls}" viewBox="0 0 64 64" aria-hidden="true" focusable="false">
  <path d="M10 30 L13 5 L29 17 Q32 16.5 35 17 L51 5 L54 30 Q56 44 32 44 Q8 44 10 30Z" fill="currentColor"/>
  <circle cx="23" cy="29" r="5" fill="#1E90E0"/><circle cx="41" cy="29" r="5" fill="#1E90E0"/>
  <circle class="pupila" cx="23" cy="29" r="2.2" fill="#121212"/><circle class="pupila" cx="41" cy="29" r="2.2" fill="#121212"/>
  <path d="M30 36 L34 36 L32 38.5Z" fill="#3B1F5C"/>
  <g stroke="currentColor" stroke-width="1.2" stroke-linecap="round"><path d="M5 34 L18 36"/><path d="M5 40 L18 39"/><path d="M59 34 L46 36"/><path d="M59 40 L46 39"/></g>
  <path d="M6 52 Q19 47 32 52 Q45 47 58 52 L58 60 Q45 55 32 60 Q19 55 6 60Z" fill="#1E90E0"/>
  <path d="M32 46 L32 49 M24 47 L25 49.5 M40 47 L39 49.5" stroke="#8FCBF7" stroke-width="1.4" stroke-linecap="round"/></svg>`;

/* Portada provisional dibujada en SVG (se usa si no existe assets/images/portadas/<id>.jpg) */
const PAL = [['#3B1F5C','#FFFFFF','#1E90E0'], ['#121212','#FFFFFF','#8FCBF7'], ['#1E90E0','#121212','#FFFFFF'], ['#2A1542','#FFFFFF','#8FCBF7']];
function portadaSVG(l) {
  const [bg, fg, ac] = PAL[L.indexOf(l) % PAL.length];
  const lineas = []; let cur = '';
  l.titulo.split(' ').forEach(p => { // parte el título en líneas de ≤14 caracteres
    if ((cur + ' ' + p).trim().length > 14) { if (cur) lineas.push(cur); cur = p; } else cur = (cur + ' ' + p).trim();
  });
  if (cur) lineas.push(cur);
  const t = lineas.map((x, k) => `<text x="200" y="${190 + k * 44}" text-anchor="middle" font-size="36" font-weight="700" fill="${fg}" font-family="Playfair Display,Georgia,serif">${esc(x)}</text>`).join('');
  const yA = 190 + lineas.length * 44 + 14;
  const svg = `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 400 600"><rect width="400" height="600" fill="${bg}"/><rect x="22" y="22" width="356" height="556" fill="none" stroke="${ac}" stroke-width="3"/>${t}<text x="200" y="${yA}" text-anchor="middle" font-size="21" fill="${ac}" font-family="Lato,Arial,sans-serif">${esc(l.autor)}</text><circle cx="200" cy="520" r="12" fill="${ac}"/></svg>`;
  return 'data:image/svg+xml;charset=utf-8,' + encodeURIComponent(svg);
}
/* Si la portada real no existe, el navegador dispara "error" y ponemos la provisional */
document.addEventListener('error', e => {
  const im = e.target;
  if (im.tagName === 'IMG' && im.dataset.id && !im.dataset.fb) { im.dataset.fb = '1'; im.src = portadaSVG(libro(im.dataset.id)); }
}, true);
const portadaImg = (l, o = {}) => `<img src="assets/images/portadas/${l.id}.jpg" data-id="${l.id}" alt="${o.deco ? '' : `Portada de ${esc(l.titulo)}, de ${esc(l.autor)}`}" width="400" height="600" ${o.eager ? '' : 'loading="lazy"'}>`;

const tarjeta = l => `<article class="libro aparece">
  <a class="libro__portada" href="libro.html?id=${l.id}" tabindex="-1" aria-hidden="true">${portadaImg(l, { deco:true })}</a>
  <div class="libro__cuerpo">
    <h3><a href="libro.html?id=${l.id}">${esc(l.titulo)}</a></h3>
    <p class="libro__autor">${esc(l.autor)}</p>
    <div class="libro__pie"><span class="precio">Desde ${COP(precioMin(l))}</span>
    <span>${Object.keys(l.formatos).map(f => `<span class="sello">${FMT[f]}</span>`).join(' ')}</span></div>
  </div></article>`;

/* ---------- Validación de formularios ---------- */
/* reglas: { nombreCampo: valor => 'mensaje de error' | '' } */
function validar(form, reglas) {
  let primero = null;
  Object.entries(reglas).forEach(([n, fn]) => {
    const inp = form.elements[n], campo = inp.closest('.campo');
    campo.querySelector('.msg-error')?.remove(); campo.classList.remove('error'); inp.removeAttribute('aria-invalid');
    const m = fn(inp.value.trim());
    if (m) {
      campo.classList.add('error'); inp.setAttribute('aria-invalid', 'true');
      const p = document.createElement('p'); p.className = 'msg-error'; p.id = (inp.id || n) + '-err'; p.textContent = m;
      campo.appendChild(p); inp.setAttribute('aria-describedby', p.id); primero = primero || inp;
    }
  });
  primero?.focus();
  return !primero;
}
const rEmail  = v => /^[^\s@]+@[^\s@]+\.[^\s@]{2,}$/.test(v) ? '' : 'Escribe un correo válido, por ejemplo nombre@correo.com.';
const rMin    = (n, txt) => v => v.length >= n ? '' : txt;
const rTel    = v => /^\d{7,12}$/.test(v.replace(/[\s-]/g, '')) ? '' : 'Escribe un teléfono con 7 a 12 dígitos.';

/* ---------- Carrito (localStorage) ---------- */
const getCart  = () => store.get('carro', []).filter(i => libro(i.id) && libro(i.id).formatos[i.fmt]);
const saveCart = c => { store.set('carro', c); pintarContador(); };
function agregar(id, fmt) {
  const c = getCart(), it = c.find(x => x.id === id && x.fmt === fmt);
  if (it) {
    if (fmt !== 'fisico') { toast('Ese libro digital ya está en tu carrito.'); return; }
    it.qty++;
  } else c.push({ id, fmt, qty:1 });
  saveCart(c); toast('Agregado al carrito.');
}
function totales() {
  const c = getCart(); let sub = 0, fisicos = false;
  c.forEach(i => { sub += libro(i.id).formatos[i.fmt] * i.qty; if (i.fmt === 'fisico') fisicos = true; });
  const cup = store.get('cupon', null), desc = cup && CUPONES[cup] ? Math.round(sub * CUPONES[cup]) : 0;
  return { c, sub, fisicos, cup, desc };
}
function pintarContador() {
  const n = getCart().reduce((a, i) => a + i.qty, 0);
  $$('.nav__carro span').forEach(s => { s.textContent = n; });
}

/* ---------- Descarga de demostración ---------- */
/* No existen archivos reales; se genera un .txt marcado como DEMO (nunca un EPUB/PDF falso). */
function descargar(l, fmt) {
  const txt = `EL DELIRIO — ARCHIVO DE DEMOSTRACIÓN\n\nTítulo: ${l.titulo}\nAutor: ${l.autor}\nFormato comprado: ${FMT[fmt]}\n\nEste archivo es un marcador de posición. Cuando el cliente entregue los archivos reales (EPUB/PDF), se enlazarán aquí.\n`;
  const url = URL.createObjectURL(new Blob([txt], { type:'text/plain;charset=utf-8' }));
  const a = Object.assign(document.createElement('a'), { href:url, download:`${l.id}-${fmt}-demo.txt` });
  document.body.appendChild(a); a.click(); a.remove(); URL.revokeObjectURL(url);
}

/* ---------- Estructura común: encabezado, pie, botones flotantes ---------- */
function montarEstructura() {
  const pag = document.body.dataset.page, user = store.get('sesion', null);
  const enlaces = [['index.html','Inicio','inicio'], ['catalogo.html','Catálogo','catalogo'], ['nosotros.html','Nosotros','nosotros'],
    ['ayuda.html','Ayuda','ayuda'], ['biblioteca.html','Mi biblioteca','biblioteca'], ['acceder.html', user ? esc(user.nombre) : 'Acceder','acceder']];
  $('#cabecera').outerHTML = `<header class="cabecera"><div class="contenedor cabecera__fila">
    <a class="marca" href="index.html">${gato()}<span>El Delirio</span></a>
    <button class="menu-btn" aria-expanded="false" aria-controls="nav">Menú</button>
    <nav class="nav" id="nav" aria-label="Principal">
      ${enlaces.map(([h, t, k]) => `<a href="${h}" ${pag === k ? 'aria-current="page"' : ''}>${t}</a>`).join('')}
      <a class="nav__carro" href="carrito.html" ${pag === 'carrito' ? 'aria-current="page"' : ''}>Carro<span aria-label="artículos">0</span></a>
    </nav></div></header>`;
  $('#pie').outerHTML = `<footer class="pie"><div class="contenedor"><div class="pie__grid">
    <div><h2>El Delirio</h2><p>Libros digitales (EPUB y PDF) y físicos. Elige cómo leer.</p></div>
    <div><h2>Explora</h2><ul><li><a href="catalogo.html">Catálogo</a></li><li><a href="nosotros.html">Nosotros</a></li><li><a href="biblioteca.html">Mi biblioteca</a></li></ul></div>
    <div><h2>Ayuda y legal</h2><ul><li><a href="ayuda.html#formatos">Guía de formatos</a></li><li><a href="ayuda.html#envios">Envíos y devoluciones</a></li><li><a href="ayuda.html#faq">Preguntas frecuentes</a></li><li><a href="ayuda.html#legal">Términos y privacidad</a></li></ul></div>
    <div><h2>Contacto</h2><ul><li><a href="mailto:german@example.com">german@example.com</a></li><li>Redes sociales:</li></ul></div>
  </div><small>© 2026 El Delirio · Proyecto académico de Introducción a la programación. Los pagos y envíos son simulados.</small></div></footer>`;
  document.body.insertAdjacentHTML('beforeend', `<div class="flotantes">
    <button class="flotante flotante--arriba" id="arriba" aria-label="Volver al inicio de la página" hidden><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M12 19V5M5 12l7-7 7 7"/></svg></button>
    <a class="flotante flotante--wa" href="https://wa.me/573000000000?text=Hola%2C%20quiero%20ayuda%20con%20El%20Delirio" target="_blank" rel="noopener" aria-label="Escribir por WhatsApp (número de ejemplo)"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linejoin="round" aria-hidden="true"><path d="M21 12a8 8 0 0 1-11.6 7.1L4 20l1-4.6A8 8 0 1 1 21 12Z"/></svg></a></div>`);
  /* Menú hamburguesa accesible */
  const btn = $('.menu-btn'), nav = $('#nav');
  const cerrar = () => { nav.classList.remove('abierto'); btn.setAttribute('aria-expanded', 'false'); };
  btn.addEventListener('click', () => btn.setAttribute('aria-expanded', String(nav.classList.toggle('abierto'))));
  document.addEventListener('keydown', e => { if (e.key === 'Escape') cerrar(); });
  nav.addEventListener('click', e => { if (e.target.closest('a')) cerrar(); });
  /* Botón "volver arriba" */
  const arriba = $('#arriba');
  addEventListener('scroll', () => { arriba.hidden = scrollY < 500; }, { passive:true });
  arriba.addEventListener('click', () => scrollTo({ top:0 }));
  pintarContador();
}

/* ---------- Efectos: ojos del gato y aparición suave ---------- */
function ojos() {
  if (matchMedia('(prefers-reduced-motion: reduce)').matches) return;
  const gatos = $$('.gato-vivo'); if (!gatos.length) return;
  let raf;
  addEventListener('pointermove', e => {
    cancelAnimationFrame(raf);
    raf = requestAnimationFrame(() => gatos.forEach(g => {
      const r = g.getBoundingClientRect(), dx = e.clientX - (r.left + r.width / 2), dy = e.clientY - (r.top + r.height * .45);
      const d = Math.hypot(dx, dy) || 1, k = Math.min(d / 150, 1) * 2.2; // máximo 2,2 unidades de recorrido
      $$('.pupila', g).forEach(p => { p.style.transform = `translate(${dx / d * k}px,${dy / d * k}px)`; });
    }));
  });
}
let obs;
function observar() {
  if (!('IntersectionObserver' in window)) { $$('.aparece').forEach(e => e.classList.add('visible')); return; }
  obs = obs || new IntersectionObserver(es => es.forEach(e => { if (e.isIntersecting) { e.target.classList.add('visible'); obs.unobserve(e.target); } }), { threshold:.1 });
  $$('.aparece:not(.visible)').forEach(e => obs.observe(e));
}

/* ---------- Boletín (simulado: guarda el correo en este navegador) ---------- */
function boletin() {
  const f = $('#boletin-form'); if (!f) return;
  f.addEventListener('submit', e => {
    e.preventDefault();
    if (!validar(f, { correo:rEmail })) return;
    const lista = store.get('boletin', []); const c = f.elements.correo.value.trim().toLowerCase();
    if (!lista.includes(c)) lista.push(c);
    store.set('boletin', lista); f.reset();
    $('#boletin-msg').textContent = 'Listo: guardamos tu correo en este navegador. (Demostración: para enviar boletines reales se necesita un servicio de correo.)';
  });
}

/* ---------- Página: Inicio ---------- */
function inicio() {
  $('#generos').innerHTML = [...new Set(L.map(l => l.genero))].map(g => `<a class="chip" href="catalogo.html?genero=${encodeURIComponent(g)}">${esc(g)}</a>`).join('');
  $('#destacados').innerHTML = L.filter(l => l.destacado).slice(0, 4).map(tarjeta).join('');
  $('#nuevos').innerHTML = L.filter(l => l.nuevo).slice(0, 4).map(tarjeta).join('');
  $('#hero-gato').innerHTML = gato('gato-vivo');
  $('#hero-pila').innerHTML = [libro('frankenstein'), libro('don-quijote'), libro('alicia')].map(l => portadaImg(l, { deco:true, eager:true })).join('');
}

/* ---------- Página: Nosotros ---------- */
function nosotros() { $('#nos-gato').innerHTML = gato('gato-vivo'); }

/* ---------- Página: 404 ---------- */
function notfound() { $('#gato-404').innerHTML = gato('gato-vivo'); }

/* ---------- Página: Catálogo ---------- */
function catalogo() {
  const POR = 8, f = $('#filtros'), lista = $('#lista'); let pag = 1;
  const gs = [...new Set(L.map(l => l.genero))];
  f.elements.genero.innerHTML = '<option value="">Todos los géneros</option>' + gs.map(g => `<option>${esc(g)}</option>`).join('');
  const p = new URLSearchParams(location.search);
  if (gs.includes(p.get('genero'))) f.elements.genero.value = p.get('genero');
  if (p.get('q')) f.elements.q.value = p.get('q');
  function pintar() {
    const q = norm(f.elements.q.value), g = f.elements.genero.value, max = +f.elements.precio.value, fm = $$('input[name=fmt]:checked', f).map(i => i.value);
    $('#precio-val').textContent = COP(max);
    let r = L.filter(l => {
      const fms = Object.keys(l.formatos).filter(x => !fm.length || fm.includes(x));
      return fms.length && (!g || l.genero === g) && (!q || norm(l.titulo + ' ' + l.autor).includes(q)) && Math.min(...fms.map(x => l.formatos[x])) <= max;
    });
    const o = f.elements.orden.value;
    if (o === 'precio-asc') r.sort((a, b) => precioMin(a) - precioMin(b));
    if (o === 'precio-desc') r.sort((a, b) => precioMin(b) - precioMin(a));
    if (o === 'titulo') r.sort((a, b) => a.titulo.localeCompare(b.titulo, 'es'));
    const n = Math.max(1, Math.ceil(r.length / POR)); pag = Math.min(pag, n);
    $('#conteo').textContent = `${r.length} ${r.length === 1 ? 'libro' : 'libros'}`;
    lista.innerHTML = r.length ? r.slice((pag - 1) * POR, pag * POR).map(tarjeta).join('')
      : `<div class="vacio" style="grid-column:1/-1"><p>No encontramos libros con esos filtros.</p><button class="btn btn--azur" type="button" id="limpiar">Quitar filtros</button></div>`;
    $('#paginas').innerHTML = n > 1 ? Array.from({ length:n }, (_, i) => `<button type="button" data-p="${i + 1}" aria-label="Página ${i + 1}" ${i + 1 === pag ? 'aria-current="true"' : ''}>${i + 1}</button>`).join('') : '';
    observar();
  }
  f.addEventListener('input', () => { pag = 1; pintar(); });
  f.addEventListener('submit', e => e.preventDefault());
  f.addEventListener('reset', () => setTimeout(() => { pag = 1; pintar(); }));
  $('#paginas').addEventListener('click', e => { const b = e.target.closest('button'); if (b) { pag = +b.dataset.p; pintar(); $('#conteo').scrollIntoView({ behavior:'smooth' }); } });
  lista.addEventListener('click', e => { if (e.target.id === 'limpiar') f.reset(); });
  pintar();
}

/* ---------- Página: Ficha del libro ---------- */
function ficha() {
  const l = libro(new URLSearchParams(location.search).get('id')), c = $('#ficha');
  if (!l) {
    document.title = 'Libro no encontrado | El Delirio';
    c.innerHTML = '<div class="vacio"><h1>No encontramos ese libro</h1><p>Puede que el enlace esté incompleto.</p><a class="btn btn--azur" href="catalogo.html">Ver el catálogo</a></div>'; return;
  }
  document.title = `${l.titulo} — ${l.autor} | El Delirio`;
  $('meta[name=description]').content = `${l.titulo}, de ${l.autor}. ${l.sinopsis} Disponible en ${Object.keys(l.formatos).map(f => FMT[f]).join(', ')}.`;
  const fms = Object.keys(l.formatos);
  c.innerHTML = `<div class="ficha"><div>${portadaImg(l, { eager:true }).replace('<img', '<img class="ficha__portada"')}</div>
    <div><h1>${esc(l.titulo)}</h1><p class="meta">${esc(l.autor)} · ${esc(l.genero)} · ${esc(l.anio)}</p><p>${esc(l.sinopsis)}</p>
    <fieldset class="formatos"><legend class="solo-lectores">Formato</legend>
      ${fms.map((f, i) => `<label><input type="radio" name="fmt" value="${f}" ${i === 0 ? 'checked' : ''}><span>${FMT[f]}</span></label>`).join('')}</fieldset>
    <p class="ficha__precio" id="precio" aria-live="polite"></p><p class="meta" id="nota-fmt"></p>
    <div class="hero__acciones"><button class="btn btn--azur" id="agregar">Agregar al carrito</button><button class="btn btn--borde" id="muestra">Leer muestra</button></div>
    <p class="aviso" style="margin-top:1.5rem">Los precios son de demostración, pendientes de confirmar con el cliente.</p></div></div>
    <dialog id="dlg" aria-labelledby="dlg-t"><h2 id="dlg-t">Muestra de «${esc(l.titulo)}»</h2>
      <p>${l.muestra ? esc(l.muestra) : 'La muestra gratuita de este título aún no está cargada (pendiente del archivo real).'}</p>
      <form method="dialog"><button class="btn btn--azur">Cerrar</button></form></dialog>`;
  const sel = () => $('input[name=fmt]:checked').value;
  const act = () => {
    $('#precio').textContent = COP(l.formatos[sel()]);
    $('#nota-fmt').textContent = sel() === 'fisico' ? 'Envío a domicilio. El costo depende de tu ciudad.' : 'Descarga inmediata al pagar. Queda guardado en Mi biblioteca.';
  };
  $$('input[name=fmt]').forEach(i => i.addEventListener('change', act)); act();
  $('#agregar').addEventListener('click', () => agregar(l.id, sel()));
  $('#muestra').addEventListener('click', () => $('#dlg').showModal());
  /* Relacionados */
  const rel = L.filter(x => x.id !== l.id).sort((a, b) => (b.genero === l.genero) - (a.genero === l.genero)).slice(0, 4);
  $('#relacionados').innerHTML = rel.map(tarjeta).join('');
  /* Datos estructurados Schema.org */
  const ld = { '@context':'https://schema.org', '@type':'Book', name:l.titulo, author:{ '@type':'Person', name:l.autor }, genre:l.genero,
    description:l.sinopsis, offers:fms.map(f => ({ '@type':'Offer', priceCurrency:'COP', price:l.formatos[f], name:FMT[f] })) };
  const s = document.createElement('script'); s.type = 'application/ld+json'; s.textContent = JSON.stringify(ld); document.head.appendChild(s);
  observar();
}

/* ---------- Página: Carrito y pago (simulado) ---------- */
function carrito() {
  const f = $('#pago');
  f.elements.ciudad.innerHTML = '<option value="">Elige tu ciudad</option>' + Object.keys(CIUDADES).map(c => `<option>${esc(c)}</option>`).join('');
  function pintar() {
    const t = totales(); $('#carro-vacio').hidden = t.c.length > 0; $('#carro-lleno').hidden = !t.c.length;
    $('#lineas').innerHTML = t.c.map((i, k) => { const l = libro(i.id), p = l.formatos[i.fmt]; return `<div class="linea">${portadaImg(l, { deco:true })}
      <div><h3>${esc(l.titulo)}</h3><p>${FMT[i.fmt]} · ${COP(p)}</p>
      ${i.fmt === 'fisico' ? `<div class="cant"><button type="button" data-a="menos" data-k="${k}" aria-label="Quitar una unidad">−</button><span aria-live="polite">${i.qty}</span><button type="button" data-a="mas" data-k="${k}" aria-label="Agregar una unidad">+</button></div>` : ''}
      <button type="button" class="quitar" data-a="quitar" data-k="${k}">Quitar</button></div><strong>${COP(p * i.qty)}</strong></div>`; }).join('');
    $('#envio-campos').hidden = !t.fisicos;
    const envio = t.fisicos && CIUDADES[f.elements.ciudad.value] ? CIUDADES[f.elements.ciudad.value] : 0, total = t.sub - t.desc + envio;
    $('#totales').innerHTML = `<div class="fila"><dt>Subtotal</dt><dd>${COP(t.sub)}</dd></div>
      ${t.desc ? `<div class="fila"><dt>Cupón ${esc(t.cup)}</dt><dd>−${COP(t.desc)}</dd></div>` : ''}
      ${t.fisicos ? `<div class="fila"><dt>Envío</dt><dd>${envio ? COP(envio) : 'Elige ciudad'}</dd></div>` : ''}
      <div class="fila total"><dt>Total</dt><dd>${COP(total)}</dd></div>`;
    return { t, envio, total };
  }
  $('#lineas').addEventListener('click', e => {
    const b = e.target.closest('button'); if (!b) return;
    const c = getCart(), it = c[+b.dataset.k]; if (!it) return;
    if (b.dataset.a === 'mas') it.qty++;
    if (b.dataset.a === 'menos') it.qty = Math.max(1, it.qty - 1);
    if (b.dataset.a === 'quitar') c.splice(+b.dataset.k, 1);
    saveCart(c); pintar();
  });
  $('#cupon-btn').addEventListener('click', () => {
    const cod = $('#cupon').value.trim().toUpperCase();
    if (CUPONES[cod]) { store.set('cupon', cod); toast('Cupón aplicado.'); } else { store.del('cupon'); toast('Ese cupón no existe o expiró.'); }
    pintar();
  });
  f.elements.ciudad.addEventListener('change', pintar);
  f.addEventListener('submit', e => {
    e.preventDefault();
    const { t, envio, total } = pintar();
    const reglas = { correo:rEmail, metodo:v => v ? '' : 'Elige un método de pago.' };
    if (t.fisicos) Object.assign(reglas, { nombre:rMin(3, 'Escribe tu nombre completo.'), ciudad:v => v ? '' : 'Elige tu ciudad.', direccion:rMin(6, 'Escribe tu dirección completa.'), telefono:rTel });
    if (!validar(f, reglas)) return;
    /* Pago SIMULADO: no se cobra nada ni se piden datos de tarjeta. */
    const pedido = { id:'ED-' + Date.now().toString(36).toUpperCase(), fecha:new Date().toISOString(), total, envio, metodo:f.elements.metodo.value, estado:0,
      fisicos:t.c.filter(i => i.fmt === 'fisico'), direccion:t.fisicos ? `${f.elements.direccion.value}, ${f.elements.ciudad.value}` : '' };
    const bib = store.get('biblioteca', {});
    t.c.filter(i => i.fmt !== 'fisico').forEach(i => { bib[i.id] = [...new Set([...(bib[i.id] || []), i.fmt])]; });
    store.set('biblioteca', bib);
    if (pedido.fisicos.length) store.set('pedidos', [pedido, ...store.get('pedidos', [])]);
    store.set('carro', []); store.del('cupon'); pintarContador();
    $('#carro-lleno').hidden = true;
    const conf = $('#confirmacion'); conf.hidden = false;
    conf.innerHTML = `<div class="vacio">${gato()}<h2>¡Gracias por tu compra!</h2><p>Pedido <strong>${pedido.id}</strong> por ${COP(total)}.</p>
      <p class="aviso">Pago simulado: no se realizó ningún cobro.</p>
      <p>${t.c.some(i => i.fmt !== 'fisico') ? 'Tus libros digitales ya están en Mi biblioteca. ' : ''}${pedido.fisicos.length ? 'Puedes seguir tu pedido físico en Mi biblioteca.' : ''}</p>
      <a class="btn btn--azur" href="biblioteca.html">Ir a Mi biblioteca</a></div>`;
    conf.focus();
  });
  pintar();
}

/* ---------- Página: Mi biblioteca ---------- */
function biblioteca() {
  const bib = store.get('biblioteca', {}), ids = Object.keys(bib).filter(libro);
  $('#bib-digitales').innerHTML = ids.length ? ids.map(id => { const l = libro(id); return `<article class="item-bib">${portadaImg(l, { deco:true })}
    <div><h3>${esc(l.titulo)}</h3><p class="libro__autor">${esc(l.autor)}</p>
    <div class="acc">${bib[id].map(f => `<button class="btn btn--azur btn--chico" data-id="${id}" data-f="${f}">Descargar ${FMT[f]} (demo)</button>`).join('')}</div></div></article>`; }).join('')
    : '<p>Aún no tienes libros digitales. <a href="catalogo.html">Explora el catálogo</a>.</p>';
  const ped = store.get('pedidos', []), PASOS = ['Pedido recibido', 'Preparando', 'En camino', 'Entregado'];
  $('#bib-pedidos').innerHTML = ped.length ? ped.map(p => `<article class="item-bib" style="grid-template-columns:1fr"><div>
    <h3>Pedido ${esc(p.id)}</h3><p class="libro__autor">${new Date(p.fecha).toLocaleDateString('es-CO')} · ${esc(p.direccion)} · ${COP(p.total)}</p>
    <p>${p.fisicos.map(i => `${esc(libro(i.id)?.titulo || i.id)} ×${i.qty}`).join(', ')}</p>
    <ol class="pasos" aria-label="Estado del pedido">${PASOS.map((s, i) => `<li ${i === p.estado ? 'class="activo" aria-current="step"' : ''}>${s}</li>`).join('')}</ol>
    <p class="libro__autor">Estado de demostración: no hay conexión con una transportadora real.</p></div></article>`).join('')
    : '<p>No tienes pedidos de libros físicos.</p>';
  $('#bib-digitales').addEventListener('click', e => { const b = e.target.closest('button[data-id]'); if (b) descargar(libro(b.dataset.id), b.dataset.f); });
}

/* ---------- Página: Acceder / Registrarse (demostración local) ---------- */
async function sha(t) { // la contraseña nunca se guarda en claro; es solo una demo, no seguridad real
  if (!crypto.subtle) throw new Error('sin-crypto');
  const b = await crypto.subtle.digest('SHA-256', new TextEncoder().encode(t));
  return [...new Uint8Array(b)].map(x => x.toString(16).padStart(2, '0')).join('');
}
function acceder() {
  const fi = $('#form-ingresar'), fr = $('#form-registro'), tabs = $$('[role=tab]'), cuenta = $('#cuenta');
  const user = store.get('sesion', null);
  function vista() {
    const u = store.get('sesion', null);
    cuenta.hidden = !u; $('#paneles').hidden = !!u;
    if (u) $('#cuenta-txt').textContent = `Hola, ${u.nombre}. Tu sesión está iniciada en este navegador.`;
  }
  tabs.forEach(t => t.addEventListener('click', () => {
    tabs.forEach(x => x.setAttribute('aria-selected', String(x === t)));
    fi.hidden = t.dataset.v !== 'ingresar'; fr.hidden = t.dataset.v !== 'registro';
  }));
  const err = (el, m) => { el.textContent = m; };
  fr.addEventListener('submit', async e => {
    e.preventDefault();
    if (!validar(fr, { nombre:rMin(3, 'Escribe tu nombre.'), correo:rEmail, clave:rMin(8, 'Usa al menos 8 caracteres.') })) return;
    const us = store.get('usuarios', {}), mail = fr.elements.correo.value.trim().toLowerCase();
    if (us[mail]) { err($('#reg-msg'), 'Ya existe una cuenta con ese correo. Ingresa con ella.'); return; }
    try { us[mail] = { nombre:fr.elements.nombre.value.trim(), h:await sha(mail + fr.elements.clave.value) }; } catch { err($('#reg-msg'), 'Este navegador no permite crear cuentas aquí. Abre el sitio con localhost o https.'); return; }
    store.set('usuarios', us); store.set('sesion', { nombre:us[mail].nombre, correo:mail }); location.reload();
  });
  fi.addEventListener('submit', async e => {
    e.preventDefault();
    if (!validar(fi, { correo:rEmail, clave:rMin(1, 'Escribe tu contraseña.') })) return;
    const mail = fi.elements.correo.value.trim().toLowerCase(), u = store.get('usuarios', {})[mail];
    try {
      if (!u || u.h !== await sha(mail + fi.elements.clave.value)) { err($('#ing-msg'), 'Correo o contraseña incorrectos.'); return; }
    } catch { err($('#ing-msg'), 'Este navegador no permite ingresar aquí. Abre el sitio con localhost o https.'); return; }
    store.set('sesion', { nombre:u.nombre, correo:mail }); location.reload();
  });
  $('#salir').addEventListener('click', () => { store.del('sesion'); location.reload(); });
  vista(); void user;
}

/* ---------- Página: Ayuda (formulario de contacto) ---------- */
function ayuda() {
  const f = $('#form-contacto');
  f.addEventListener('submit', e => {
    e.preventDefault();
    if (!validar(f, { nombre:rMin(3, 'Escribe tu nombre.'), correo:rEmail, mensaje:rMin(10, 'Cuéntanos un poco más (mínimo 10 caracteres).') })) return;
    store.set('mensajes', [...store.get('mensajes', []), { n:f.elements.nombre.value, c:f.elements.correo.value, m:f.elements.mensaje.value, f:Date.now() }]);
    f.reset();
    $('#contacto-msg').textContent = 'Mensaje guardado en este navegador. Demostración: aún no hay servidor de correo conectado, por eso no se envió a nadie. Puedes escribirnos a german@example.com.';
  });
}

/* ---------- Arranque ---------- */
document.addEventListener('DOMContentLoaded', () => {
  montarEstructura();
  const paginas = { inicio, nosotros, notfound, catalogo, libro:ficha, carrito, biblioteca, acceder, ayuda };
  paginas[document.body.dataset.page]?.();
  boletin(); ojos(); observar();
});
})();
