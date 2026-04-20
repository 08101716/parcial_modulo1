-- Tipos de investigador
CREATE TABLE tipos_investigador (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

-- Investigadores
CREATE TABLE investigadores (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(100) UNIQUE,
    id_tipo INT NOT NULL
);

-- Laboratorios
CREATE TABLE laboratorios (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    nivel_bioseguridad INT NOT NULL,
    capacidad INT
);

-- Equipos
CREATE TABLE equipos (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    estado VARCHAR(50) NOT NULL,
    id_laboratorio INT NOT NULL
);

-- Reservas
CREATE TABLE reservas (
    id SERIAL PRIMARY KEY,
    id_investigador INT NOT NULL,
    id_laboratorio INT NOT NULL,
    id_equipo INT NOT NULL,
    fecha_inicio TIMESTAMP NOT NULL,
    fecha_fin TIMESTAMP NOT NULL
);

-- Auditoría
CREATE TABLE log_auditoria (
    id SERIAL PRIMARY KEY,
    usuario VARCHAR(100),
    fecha TIMESTAMP,
    accion VARCHAR(50)
);