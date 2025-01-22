
-- OPERADOR UNION --
-- Unir el resultado de 2 consultas de tablas distintas (incluso de distintas DBs)
-- Pautas para utilizarlo:
	-- Deben tener la misma cantidad de columnas
	-- Deben tener el mismo tipo de dato
-- El nombre de las columnas se establece con la primera consulta
-- El order by se establece con la segunda consulta
-- Se pueden agregar los UNION y consultas que necesitemos

SELECT COUNT(Id) FROM
	(SELECT Id, Descripcion FROM Elementos
	UNION -- el UNION quita los datos repetidos
	SELECT Id, Nombre FROM Medallas) AS Resultado



SELECT Nombre FROM Entrenadores
UNION ALL -- no quita los datos repetidos
SELECT Nombre FROM MaxiFlix_DB.dbo.Reparto
ORDER BY Nombre ASC



SELECT * FROM Entrenadores WHERE Email LIKE '%Me%'
UNION
SELECT * FROM Entrenadores WHERE Apellido LIKE ''



-- TABLAS TEMPORALES --
-- Se usan para optimizar alguna consulta compleja, consumir menos memoria y agilizar tiempos
-- Para determinar que la tabla será temporal se antepone el # al nombre (Al cerrar el SQL la tabla desaparece)
-- Para determinar que la tabla será global se antepone el ## al nombre (Al cerrar todas las conexiones SQL la tabla desaparece)


CREATE TABLE #ElementosTemporal(
	Id int,
	Descripcion VARCHAR(50)
);


INSERT INTO #ElementosTemporal (Id, Descripcion)
SELECT Id, Descripcion FROM Elementos WHERE Id > 10 AND Id <20


-- TRIGGERS --
-- Es un procedimiento almacenado que se ejecuta automáticamente según el contexto
-- Se deja configurado para que se ejecute en determinada situación (INSERT, DELETE, UPDATE)
-- Trigger DML: Manipular datos INSERT DELETE UPDATE
-- Trigger DDL: Mnipular tablas, columnas, relaciones
-- Trigger Logon

-- El trigger va a estar escuchando las acciones de una determinada tabla y va a accionar lo que hayamos
-- configurado.

-- AFTER INSERT: Luego que se ejecute el INSERT, DELETE, UPDATE.

-- INSTEAD OF: Previo a que se ejecute el INSERT, DELETE, UPDATE.

-- ESTRUCTURA

/*CREATE OR ALTER TRIGGER NombreTrigger
ON NombreTabla
[AFTER o INSTEAD OF] [INSERT, UPDATE o DELETE]
AS BEGIN
	-- Acciones del Trigger
END*/

CREATE TABLE EntrenadoresDetalle(
	Id INT,
	FechaInicio DATE,
	FechaUltimaCaptura DATE,
	IdUltimoPokemonCapturado INT
);


-- Cada vez que de de alta un Entrenador, se dará de alta también un EntrenadorDetalle

-- Tablas temporales:
-- INSERTED: Contiene los datos que estan por ser insertados INSERT, o que actualicé UPDATE
-- DELETED: Contiene los dato que se está por eliminar DELETE, o que estoy por actualizar UPDATE

CREATE OR ALTER TRIGGER trInsertEntrenadorDetalle
ON Entrenadores
AFTER INSERT -- Luego de que se inserta el Entrenador
AS BEGIN
	INSERT INTO EntrenadoresDetalle (Id, FechaInicio)
	SELECT Id, GETDATE() FROM inserted -- Obtengo el Id de la tabla temporal Inserted
END

-- Desactivar el Trigger
DISABLE TRIGGER trInsertEntrenadorDetalle ON Entrenadores

-- Activar el Trigger
ENABLE TRIGGER trInsertEntrenadorDetalle ON Entrenadores


-- Ejemplos de Triggers

CREATE OR ALTER TRIGGER trActualizarDetalleEntrenador
ON [Entrenadores.Pokemons]
AFTER INSERT
AS BEGIN
	UPDATE EntrenadoresDetalle
	SET IdUltimoPokemonCapturado = (SELECT IdPokemon FROM inserted),
	FechaUltimaCaptura = GETDATE()
	WHERE Id = (SELECT IdEntrenador FROM inserted)
END

EXEC spAsociarPokemon 124, 4, 'pepito'

CREATE OR ALTER TRIGGER trValidarAsociarPokemon
ON [Entrenadores.Pokemons]
INSTEAD OF INSERT -- Antes de insertar
AS BEGIN

DECLARE @CantPokemon INT;

SELECT @CantPokemon = COUNT(Id) FROM [Entrenadores.Pokemons]
WHERE IdEntrenador = (SELECT IdEntrenador FROM inserted)

IF @CantPokemon >= 5
BEGIN
	RAISERROR ('No puedes tener más de 5 pokemons.', 16, 1);
	ROLLBACK TRANSACTION;
	RETURN;
END
ELSE
BEGIN
	INSERT INTO [Entrenadores.Pokemons]
	SELECT * FROM inserted
END

END



EXEC spAsociarPokemon 1, 2, 'Cachito'