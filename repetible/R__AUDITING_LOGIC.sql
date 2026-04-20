-- ============================================
-- FUNCIÓN: Validar acceso a laboratorio nivel 4
-- ============================================

CREATE OR REPLACE FUNCTION validar_reserva_nivel4()
RETURNS TRIGGER AS $$
DECLARE
    tipo_investigador VARCHAR;
    nivel_lab INT;
BEGIN
    -- Obtener tipo de investigador
    SELECT t.nombre INTO tipo_investigador
    FROM investigadores i
    JOIN tipos_investigador t ON i.id_tipo = t.id
    WHERE i.id = NEW.id_investigador;

    -- Obtener nivel del laboratorio
    SELECT nivel_bioseguridad INTO nivel_lab
    FROM laboratorios
    WHERE id = NEW.id_laboratorio;

    -- Validar regla
    IF nivel_lab = 4 AND tipo_investigador <> 'Director' THEN
        RAISE EXCEPTION 'Solo investigadores tipo Director pueden reservar laboratorios nivel 4';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


-- ============================================
-- FUNCIÓN: Validar estado del equipo
-- ============================================

CREATE OR REPLACE FUNCTION validar_equipo_disponible()
RETURNS TRIGGER AS $$
DECLARE
    estado_equipo VARCHAR;
BEGIN
    SELECT estado INTO estado_equipo
    FROM equipos
    WHERE id = NEW.id_equipo;

    IF estado_equipo <> 'activo' THEN
        RAISE EXCEPTION 'El equipo no está disponible para reserva';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


-- ============================================
-- FUNCIÓN: Auditoría automática
-- ============================================

CREATE OR REPLACE FUNCTION auditoria_reservas()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO log_auditoria(usuario, fecha, accion)
    VALUES (current_user, NOW(), TG_OP);

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


-- ============================================
-- TRIGGERS
-- ============================================

-- Validar nivel 4
DROP TRIGGER IF EXISTS trg_validar_nivel4 ON reservas;

CREATE TRIGGER trg_validar_nivel4
BEFORE INSERT ON reservas
FOR EACH ROW
EXECUTE FUNCTION validar_reserva_nivel4();


-- Validar estado del equipo
DROP TRIGGER IF EXISTS trg_validar_equipo ON reservas;

CREATE TRIGGER trg_validar_equipo
BEFORE INSERT ON reservas
FOR EACH ROW
EXECUTE FUNCTION validar_equipo_disponible();


-- Auditoría
DROP TRIGGER IF EXISTS trg_auditoria_reservas ON reservas;

CREATE TRIGGER trg_auditoria_reservas
AFTER INSERT OR UPDATE OR DELETE ON reservas
FOR EACH ROW
EXECUTE FUNCTION auditoria_reservas();