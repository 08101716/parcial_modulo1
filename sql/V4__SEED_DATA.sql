-- Tipos
INSERT INTO tipos_investigador (nombre) VALUES
('Junior'), ('Senior'), ('Director');

-- Investigadores
INSERT INTO investigadores (nombre, correo, id_tipo) VALUES
('Ana Lopez', 'ana@mail.com', 1),
('Carlos Ruiz', 'carlos@mail.com', 2),
('Maria Perez', 'maria@mail.com', 3),
('Luis Gomez', 'luis@mail.com', 1),
('Sofia Torres', 'sofia@mail.com', 2);

-- Laboratorios
INSERT INTO laboratorios (nombre, nivel_bioseguridad, capacidad) VALUES
('Lab A', 1, 10),
('Lab B', 2, 8),
('Lab C', 3, 6),
('Lab D', 4, 4),
('Lab E', 2, 5);

-- Equipos
INSERT INTO equipos (nombre, estado, id_laboratorio) VALUES
('Microscopio', 'activo', 1),
('Centrifuga', 'activo', 2),
('Espectrometro', 'mantenimiento', 3),
('Incubadora', 'activo', 4),
('PCR', 'activo', 5);

-- Reservas válidas
INSERT INTO reservas (id_investigador, id_laboratorio, id_equipo, fecha_inicio, fecha_fin) VALUES
(3, 4, 4, '2026-05-01 10:00', '2026-05-01 12:00'), -- Director OK
(2, 2, 2, '2026-05-02 09:00', '2026-05-02 11:00'),
(1, 1, 1, '2026-05-03 08:00', '2026-05-03 10:00'),
(5, 5, 5, '2026-05-04 14:00', '2026-05-04 16:00'),
(4, 3, 3, '2026-05-05 13:00', '2026-05-05 15:00');