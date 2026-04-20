-- FOREIGN KEYS
ALTER TABLE investigadores
ADD CONSTRAINT fk_tipo
FOREIGN KEY (id_tipo) REFERENCES tipos_investigador(id);

ALTER TABLE equipos
ADD CONSTRAINT fk_lab_equipo
FOREIGN KEY (id_laboratorio) REFERENCES laboratorios(id);

ALTER TABLE reservas
ADD CONSTRAINT fk_res_investigador
FOREIGN KEY (id_investigador) REFERENCES investigadores(id);

ALTER TABLE reservas
ADD CONSTRAINT fk_res_lab
FOREIGN KEY (id_laboratorio) REFERENCES laboratorios(id);

ALTER TABLE reservas
ADD CONSTRAINT fk_res_equipo
FOREIGN KEY (id_equipo) REFERENCES equipos(id);

-- CHECKS
ALTER TABLE laboratorios
ADD CONSTRAINT chk_bioseguridad
CHECK (nivel_bioseguridad BETWEEN 1 AND 4);

ALTER TABLE equipos
ADD CONSTRAINT chk_estado
CHECK (estado IN ('activo', 'mantenimiento', 'fuera_servicio'));

-- EVITAR DOBLE RESERVA
ALTER TABLE reservas
ADD CONSTRAINT unique_reserva
UNIQUE (id_investigador, fecha_inicio, fecha_fin);

-- ÍNDICE PARA FECHAS
CREATE INDEX idx_reservas_fecha
ON reservas(fecha_inicio, fecha_fin);