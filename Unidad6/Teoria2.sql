-- FUNCIONES --

CREATE OR ALTER FUNCTION Saludar(@Nombre VARCHAR(50))
RETURNS VARCHAR(50)
AS BEGIN
	DECLARE @SaludoCompleto VARCHAR(50)
	SET @SaludoCompleto = CONCAT('Hola, ', @Nombre);

	RETURN @SaludoCompleto;
END

SELECT Id, dbo.Saludar(Nombre) AS Saludo FROM Pokemons

-- Funci�n para que, a partir de una fecha, calcule la cantidad de d�as de la �ltima captura de pokemon
CREATE OR ALTER FUNCTION Dias(@Fecha DATE)
RETURNS INT
AS BEGIN
	DECLARE @CantDias INT
	SET @CantDias = DATEDIFF(DAY,@Fecha,GETDATE())

	RETURN @CantDias
END

SELECT ED.Id, E.Nombre, dbo.Dias(FechaUltimaCaptura) AS 'Dias sin captura' FROM EntrenadoresDetalle ED
INNER JOIN Entrenadores E ON ED.Id = E.Id
WHERE FechaUltimaCaptura IS NOT NULL




-- CONCURRENCIA + BLOQUEOS + MONITOREO --

/* CONCURRENCIA: La posibilidad que brinda la DB de que varios usuarios 
se puedan conectar y realizar acciones al mismo tiempo en la misma DB.
Gestiona m�ltiples conexiones y acciones en simult�neo
Uno de los mecanismos para gestionar son las Transacciones
--Niveles de transacciones:
	-- Read Uncommitted:
	-- Read Committed: Por defecto
	-- Repeatable Read:
	-- Snapshot:
	-- 
*/


/* BLOQUEOS:
-- Al haber una consulta consumiendo una tabla, si ingresa otra consulta a la misma tabla deber�
esperar a que termine la primera.

-- Niveles de aislamiento
-- Shared Lock: Bloqueo compartido, permite que los SELECTS se ejecuten en simult�neo, 
	pero bloquea los INSERT, DELETE, UPDATE.
-- Exclusive Lock:
-- Update Lock: Si est� haciendo un UPDATE no se puede hacer un SELECT, 
	pero si puede hacer un INSERT concurrente.
*/

-- Reportes:
-- Click derecho en la DB -> Reportes



-- HERRAMIENTAS DE MONITOREO --

-- Activity Monitor: listado de las consultas que usaron muchos recursos recientemente utilizadas.
-- Reports: informaci�n personalizada sobre procesos
-- SQL Profiler: Seleccionar la consulta -> click derecho
-- XEvent Profiler: informaci�n de lo que pasa en el momento


-- QUERY PLAN --
