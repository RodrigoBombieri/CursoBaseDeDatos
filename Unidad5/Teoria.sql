 -- COLLATION: Cotejo de datos, especificar como se van a tratar los textos en la DB.

 select name, collation_name from sys.databases where name like 'master'

 Alter Database MundoPokemon_DB
	Collate Modern_Spanish_CI_AS_UTF8

-- CI es Case Insensitive (No distingue mayúsculas y minúsculas)
-- CS es Case Sensitive (Distingue entre mayúsculas y minúsculas)
-- AI
-- AS es Acent Sensitive (Distingue letras con acentos) 
-- UTF8 por ejemplo se pueden guardar emojis


-- DISTINCT, CASE, COLLATE, ORDER BY

Select P.Nombre, H.Nombre From Pokemons P
INNER JOIN [Pokemons.Habilidades] PH ON P.Id = PH.IdPokemon
INNER JOIN Habilidades H ON PH.IdHabilidad = H.Id
WHERE P.Id = 1

-- Habilidades (quitando los repetidos) de los primeros 20 pokemons
Select DISTINCT H.Id, 
H.Nombre,
CASE WHEN E.Descripcion = 'Planta' THEN N'🌿 Planta'
WHEN E.Descripcion = 'Agua' THEN N'💧 Agua' 
WHEN E.Descripcion = 'Volador' THEN N'🪽 Volador'
WHEN E.Descripcion = 'Veneno' THEN N'☢️ Veneno' 
ELSE E.Descripcion END AS Tipo

From Habilidades H
INNER JOIN [Pokemons.Habilidades] PH ON H.Id = PH.IdHabilidad
INNER JOIN Elementos E ON H.IdTipo = E.Id
WHERE PH.IdPokemon <= 20
--WHERE PH.IdPokemon <= 20 AND E.Descripcion LIKE 'Planta'
--ORDER By Tipo Desc


-- ORDER BY: Cláusula que ordena filas del listado (por defecto es ascendente); asc; desc; 
-- Se usa para ordenar los resultados de una consulta SQL en base a una o más columnas
SELECT P.Id, P.Nombre, E.Descripcion AS Tipo FROM Pokemons P
INNER JOIN [Pokemons.Tipos] PT ON P.Id = PT.IdPokemon
INNER JOIN Elementos E ON PT.IdElemento = E.Id
ORDER BY Nombre, Tipo


-- GROUP BY Cláusla para agrupar datos (SUM(), COUNT(), AVG(), MAX(), MIN(), etc).
-- Agrupa los registros que tienen valores similares en columnas específicas
Select H.Nombre AS Habilidad, COUNT(H.Id) 'Cantidad Pokemons'
From Habilidades H
INNER JOIN [Pokemons.Habilidades] PH ON H.Id = PH.IdHabilidad
INNER JOIN Elementos E ON H.IdTipo = E.Id
WHERE PH.IdPokemon <= 20
GROUP BY H.Nombre


Select P.Nombre, E.Descripcion AS Tipo, COUNT(H.Id) AS 'Habilidades posibles'
From Pokemons P
INNER JOIN [Pokemons.Tipos] PT ON P.Id = PT.IdPokemon
INNER JOIN Elementos E ON PT.IdElemento = E.Id
INNER JOIN Habilidades H ON H.IdTipo = E.Id
GROUP BY P.Nombre, E.Descripcion
ORDER BY 'Habilidades posibles' Desc

-- HAVING: Filtra grupos creados por GROUP BY según una condición, 
-- similar a WHERE pero aplicado a resultados agregados (CALCULADOS SUM, COUNT, AVG).
-- Se escribe después del group by

Select H.Nombre AS Habilidad, COUNT(P.Id) 'Cantidad Pokemons'
From Habilidades H
INNER JOIN [Pokemons.Habilidades] PH ON H.Id = PH.IdHabilidad
INNER JOIN Elementos E ON H.IdTipo = E.Id
INNER JOIN Pokemons P ON PH.IdPokemon = P.Id
WHERE PH.IdPokemon <= 20
GROUP BY H.Nombre
HAVING COUNT(P.Id) > 4

-- FUNCIONES INTEGRADAS:
-- Agregado: MAX MIN SUM..
-- String: LEFT LOWER SUBSTRING NCHAR..
-- Fecha y Hora: DATE DATEDIFF YEAR MONTH..

SELECT Nombre, ISNULL(IdEvolucion,0) IdEvolucion FROM Pokemons -- Si el id es nulo muestra un 0

--							IdTipo	  1			2		3
SELECT Id, Nombre, CHOOSE(IdTipo, 'Planta', 'Fuego', 'Agua') Tipo
FROM Habilidades WHERE CHOOSE(IdTipo, 'Planta', 'Fuego', 'Agua') IS NOT NULL
ORDER BY Tipo


-- Crea un código concatenando 
-- a) Substring de nombre (comenzando del 1 y con longitud de 3 caracteres)
-- b) Número
-- c) y Peso
SELECT Nombre, CONCAT(SUBSTRING(Nombre, 1, 3), Numero, Peso) AS Codigo FROM Pokemons


-- Cálculo de edad
-- YEAR: le pedimos que nos devuelva en años 
-- la diferencia entre la fecha de hoy y la fecha de nacimiento pasadas por parámetro
SELECT Nombre, FechaNacimiento,
DATEDIFF(YEAR, FechaNacimiento, GETDATE()) AS Edad,
GETDATE() AS 'Fecha Actual'
FROM Entrenadores

-- Cálculo de edad teniendo en cuenta meses y días
SELECT 
    Nombre, 
    FechaNacimiento,
    CASE -- Si el mes de nacimiento es menor que el mes actual,
        WHEN MONTH(FechaNacimiento) < MONTH(GETDATE()) 
			-- o si es igual pero el día del mes ya pasó, se usa la diferencia directa
            OR (MONTH(FechaNacimiento) = MONTH(GETDATE()) AND DAY(FechaNacimiento) <= DAY(GETDATE())) THEN
            DATEDIFF(YEAR, FechaNacimiento, GETDATE())
        ELSE -- Si no, se resta 1 porque el cumpleaños aún no ocurrió en este año.
            DATEDIFF(YEAR, FechaNacimiento, GETDATE()) - 1
    END AS Edad,
    GETDATE() AS 'Fecha Actual'
FROM Entrenadores;


-- SUBCONSULTAS CON SELECT: Pueden estar a nivel columna, a nivel where

-- Habilidades que están presentes en pokemons con id < 20
SELECT Id, Nombre,
(SELECT Descripcion FROM Elementos E WHERE E.Id = H.IdTipo) AS Tipo
FROM HABILIDADES H 
	WHERE H.Id IN (SELECT IdHabilidad FROM [Pokemons.Habilidades] WHERE IdPokemon <= 20)
ORDER BY Tipo DESC


-- Que tipos de pokemons tienen los entrenadores
SELECT E.Nombre FROM Entrenadores E WHERE E.Id IN
	(SELECT IdEntrenador FROM [Entrenadores.Pokemons] WHERE IdPokemon IN
		(SELECT IdPokemon FROM [Pokemons.Tipos] WHERE IdElemento IN
			(SELECT Id FROM Elementos WHERE Descripcion LIKE 'Planta')
		)
	)


-- Todos los pokemons que tienen asociado algún entrenador
SELECT * FROM Pokemons WHERE Id IN
	(SELECT IdPokemon FROM [Entrenadores.Pokemons])



-- SUBCONSULTAS CON DELETE UPDATE E INSERT: 

DELETE FROM Entrenadores WHERE Id IN (
	SELECT Id FROM Entrenadores WHERE Apellido LIKE '' AND YEAR(FechaNacimiento) >= 1990)


-- La subconsulta cumple la funcion de un VALUES

INSERT INTO Entrenadores (Id, Nombre, Apellido, NickName, Email, Clave, FechaNacimiento)
--> Migracion de otra base de datos
SELECT (SELECT MAX(ID) FROM Entrenadores)+Id AS Id, -- (Al ID max alto de Entrenadores le suma el Id de Reparto, MAX+1..MAX+n.. 13+1, 13+2..)
--SELECT (SELECT MAX(ID)+1 FROM Entrenadores) AS Id, -- Para insertar uno solo
Nombre,
Apellido, 
Nombre AS NickName,
CONCAT(Nombre, Apellido, '@bomba.gmail.com') AS Email,
CONCAT(Nombre, '123xyz') AS Clave,
FechaNacimiento
FROM MaxiFlix_DB.dbo.Reparto WHERE Id != 1 -- Para insertar todos
--FROM MaxiFlix_DB.dbo.Reparto WHERE Id = 1 -- Para insertar uno solo




-- VISTAS: Consultas empaquetadas, predefinidas que devuelven un set de datos.
-- Se pueden joinear con tablas, agregarle clausulas (where, order by, etc)

-- * SELECT

-- 1)
CREATE OR ALTER VIEW vElementos AS
SELECT Id, Descripcion FROM Elementos

--Para llamar
SELECT * FROM vElementos

-- 2)
CREATE OR ALTER VIEW vHabilidadesDisponiblesPokemonsMenor20 AS
Select DISTINCT H.Id, 
H.Nombre,
CASE WHEN E.Descripcion = 'Planta' THEN N'🌿 Planta'
WHEN E.Descripcion = 'Agua' THEN N'💧 Agua' 
WHEN E.Descripcion = 'Volador' THEN N'🪽 Volador'
WHEN E.Descripcion = 'Veneno' THEN N'☢️ Veneno' 
ELSE E.Descripcion END AS Tipo
From Habilidades H
INNER JOIN [Pokemons.Habilidades] PH ON H.Id = PH.IdHabilidad
INNER JOIN Elementos E ON H.IdTipo = E.Id
WHERE PH.IdPokemon <= 20

--
SELECT * FROM vHabilidadesDisponiblesPokemonsMenor20
ORDER BY Tipo DESC



-- 3) POKEMONS CON TIPO Y DEBILIDAD
CREATE OR ALTER VIEW vPokemonsTipoDebilidad AS
SELECT Id, Nombre, Numero,
	(SELECT TOP 1 E.Descripcion
	FROM Elementos E INNER JOIN [Pokemons.Tipos] PT
	ON PT.IdElemento = E.Id WHERE PT.IdPokemon = P.Id) AS Tipo,
	(SELECT TOP 1 E.Descripcion
	FROM Elementos E INNER JOIN [Pokemons.Debilidades] PD
	ON PD.IdElemento = E.Id WHERE PD.IdPokemon = P.Id) AS Debilidad
FROM Pokemons P

-- Listado anterior más el nombre de su entrenador
CREATE OR ALTER VIEW vEntrenadoresPokemons AS
SELECT E.Id IdEntrenador, E.Nombre NombreEntrenador, VP.* FROM vPokemonsTipoDebilidad VP
	INNER JOIN [Entrenadores.Pokemons] EP ON EP.IdPokemon = VP.Id
	INNER JOIN Entrenadores E ON EP.IdEntrenador = E.Id


-- * VISTAS: para EDITAR DATOS DE LA TABLA a la que estoy apuntando desde la vista
-- No se recomienda usar Vistas para éstas acciones, se hacen con SP o Triggers
-- Si tiene funciones agregadas (sum, count) o distinct, o group by no se ejecutan éstas acciones

UPDATE vElementos SET Descripcion = 'Planta 2' WHERE Id = 1
INSERT INTO vElementos (Id, Descripcion) VALUES (999, 'Ejemplo')
DELETE FROM vElementos WHERE Id = 999



-- * PROCEDIMIENTOS ALMACENADOS * --
-- Llevar a cabo acciones SELECT, INSERT, UPDATE, DELETE
-- Usar cláusulas WHERE, ORDER BY, JOINS, etc.
-- Se pueden pasar parámetros 

CREATE OR ALTER PROCEDURE spElementoListar(
	@Id INT
)
AS BEGIN
	SELECT Id, Descripcion FROM Elementos
	WHERE Id = @Id
END

-- Llamar al procedimiento
EXEC spElementoListar 5

-- AGREGAR
CREATE OR ALTER PROCEDURE spElementosInsert(
	@Id INT,
	@Descripcion NVARCHAR(50)
)
AS BEGIN
	INSERT INTO Elementos VALUES(@Id, @Descripcion)
END

-- ELIMINAR
CREATE OR ALTER PROCEDURE spElementosEliminar(
	@Id INT
)
AS BEGIN
	DELETE FROM Elementos WHERE Id = @Id
END



-- * IF EN SP - VALIDAR CARDINALIDAD * --

CREATE OR ALTER PROCEDURE spAsociarPokemon(
	@IdEntrenador INT,
	@IdPokemon INT,
	@Nombre VARCHAR(50)
)
AS BEGIN

	DECLARE @CantidadPokemon INT; -- Declaramos una variable
	SELECT @CantidadPokemon = COUNT(IdEntrenador) FROM [Entrenadores.Pokemons] 
	WHERE IdEntrenador = @IdEntrenador

	-- Verificamos si tiene más de 5 pokemons
	IF @CantidadPokemon < 5
	BEGIN
		-- Verificamos si el id pasado por parámetro existe en el listado de entrenadores
		IF EXISTS (SELECT Id FROM Entrenadores WHERE Id = @IdEntrenador)	
		BEGIN 
			INSERT INTO [Entrenadores.Pokemons]
			VALUES (@IdEntrenador, @IdPokemon, @Nombre)
			PRINT ('Pokemon asociado correctamente')
		END
		ELSE
		BEGIN
			RAISERROR('El Entrenador no existe', 16, 1)
			RETURN
		END
	END
	ELSE
	BEGIN
		RAISERROR('No se pudo procesar. El entrenador tiene más de 5 pokemons asociados', 16, 1)
	END
END

--
EXEC spAsociarPokemon 1, 9, 'Juan'