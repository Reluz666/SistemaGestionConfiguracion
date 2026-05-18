USE [GCS]
GO

-- ============================================================
-- SEP3: DELETE ALL DATA (CLEAN DATABASE BEFORE INSERT)
-- Run this BEFORE SEP2 if you need to restart
-- ============================================================

PRINT 'Eliminando datos existentes...'

DELETE FROM ELEMENTOS_CONFIGURACION;
DELETE FROM Personal;
DELETE FROM Area;
DELETE FROM Local;
DELETE FROM Dependencia;
DELETE FROM Profesion_Ocupacion;
DELETE FROM MARCA;
DELETE FROM MODELO;
DELETE FROM TIPOS_ELEMENTO_CONFIGURACION;
DELETE FROM ESTADO_ELEMENTO_CONFIGURACION;
DELETE FROM NIVEL_PRIORIDAD;
DELETE FROM IMPACTO_COMERCIAL_ELE_CONF_HAR;
DELETE FROM CARGO;
DELETE FROM Sede;
DELETE FROM Ubigeo;

PRINT 'Datos eliminados. Ahora ejecutar SEP2 para insertar datos limpio.'
GO