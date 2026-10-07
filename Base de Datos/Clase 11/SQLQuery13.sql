USE PlataformaEventos;

INSERT INTO Eventos
(nombre, descripcion, fecha, hora, precio,
id_categoria, id_lugar, id_organizador)
VALUES
('Noche de Rock', 'Concierto de bandas locales',
'2026-10-15', '19:00', 85000, 1, 1, 1),

('Taller de Fotografía', 'Taller básico de fotografía',
'2026-10-20', '14:00', 45000, 2, 2, 2),

('Tecnología del Futuro', 'Conferencia sobre tecnología',
'2026-11-05', '09:00', 30000, 3, 3, 3),

('Festival Cultural', 'Festival de música y cultura',
'2026-11-20', '16:00', 60000, 4, 4, 1);
GO