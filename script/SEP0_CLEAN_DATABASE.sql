USE [GCS]
GO

-- ============================================================
-- SEP0: DELETE ALL DATA (CLEAN DATABASE BEFORE INSERT)
-- Run this BEFORE SEP2 if you need to restart
-- Uses sp_MSforeachtable to disable constraints, delete, enable
-- ============================================================

PRINT 'Deshabilitando constraints...'

-- Disable all constraints
EXEC sp_MSforeachtable 'ALTER TABLE ? NOCHECK CONSTRAINT ALL';

PRINT 'Eliminando todos los datos...'

-- Delete from all tables
EXEC sp_MSforeachtable 'DELETE FROM ?';

PRINT 'Habilitando constraints y reiniciando identities...'

-- Enable all constraints and reseed
EXEC sp_MSforeachtable 'ALTER TABLE ? WITH CHECK CHECK CONSTRAINT ALL';
EXEC sp_MSforeachtable 'DBCC CHECKIDENT (''?'', RESEED, 0)';

PRINT 'Base de datos limpiada correctamente. Ya puede ejecutar SEP2.'
GO