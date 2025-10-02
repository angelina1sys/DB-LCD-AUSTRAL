# Práctica de Funciones y Joins

-- 1) Armá una agenda de turnos listando institución y consultorio, fecha-hora del turno, nombre del médico y paciente para el día de hoy
--  -------------------------------------------------------------------------------------------------------
-- |Institución	- Consultorio	| fecha-hora del turno dd-mm-YYYY HH:MM	| (matrícula) Médido	| Paciente |
--  -------------------------------------------------------------------------------------------------------


-- 2) Basándote en el ejercicio anterior agregá la edad del paciente a la fecha del turno
-- Función para calcular la edad: year(curdate()) - year(fec_nac) - (right(curdate(), 5) < right(fec_nac, 5)) 
--  --------------------------------------------------------------------------------------------------------------
-- |Institución	- Consultorio	| fecha-hora del turno dd-mm-YYYY HH:MM	| (matrícula) Médido	| Paciente | Edad |
--  --------------------------------------------------------------------------------------------------------------


-- 3) Basándote en el ejercicio anterior agregá la cobertura médica a la fecha del turno, si no tiene cobertura indicar PARTICULAR
-- Ayudín: COALESCE(os.obra_social, 'PARTICULAR') // CASE para “Vigente/Sin cobertura”
--  ----------------------------------------------------------------------------------------------------------------------------
-- |Institución	- Consultorio	| fecha-hora del turno dd-mm-YYYY HH:MM	| (matrícula) Médido	| Paciente | Obra Social        |
--  ----------------------------------------------------------------------------------------------------------------------------

-- 4) Etiqueta de consultorio
-- Devolvé CONCAT(i.razon_social, ' (', l.localidad, ') - ', c.consultorio) y UPPER(...) para ponerlo en mayúsculas.
--  -----------------------------------------------------------------------------------
-- |Institución	- Consultorio	| Dirección (calle altura - LOCALIDADA (en mayúsculas) |
--  -----------------------------------------------------------------------------------


-- 5) Para cada especialidad del médico ordenador por especialidad alfabéticamente:
-- si algún médico no tiene especialidad informar "No especializado" "" ""
--  ----------------------------------------------------------------------------------------------
-- |Especialidad	| (matrícula) Médido	| Fecha de Graduación | Antigüedad en la especialidad |
--  ----------------------------------------------------------------------------------------------


-- 6) Listar todos los pacientes menores de 16 años junto con sus acompañantes
--  -----------------------------------------
-- |Paciente	| Edad	| Acompañante | Edad |
--  -----------------------------------------


-- 7) Edad del médico e Institución (viene de la mano de la RN un médico atiende en un único consultorio
-- ordenado por mes y día
--  -----------------------------------------------------------------------------------
-- |Institución	- Consultorio	| Médido | Fecha de nacimiento (orden mes, día) | Edad |
--  -----------------------------------------------------------------------------------

-- 8) Código legible del turno: Construí un código AAAAMMDD-HHMM-<inst>-<consul>-<id> con DATE_FORMAT
SELECT
  t.id,
  CONCAT(
    DATE_FORMAT(t.fecha, '%Y%m%d'), '-',
    DATE_FORMAT(t.hora,  '%H%i'  ), '-',
    REPLACE(LEFT(UPPER(i.razon_social), 3), ' ', ''), '-',
    REPLACE(c.consultorio, ' ', ''), '-',
    LPAD(t.id, 6, '0')
  ) AS codigo_turno
FROM turnos t
JOIN consultorio  c ON c.id = t.consultorio_id
JOIN instituciones i ON i.id = c.institucion_id;
