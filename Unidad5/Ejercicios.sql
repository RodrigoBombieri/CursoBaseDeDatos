-- DB MUNDO POKEMON --

-- 1) Consulta para encontrar el nombre y número de Pokémon ordenados alfabéticamente.
SELECT P.Nombre, P.Numero FROM Pokemons P
ORDER BY P.Nombre ASC

-- 2) Consulta para mostrar el nombre y la cantidad de Pokémon por tipo.
SELECT E.Descripcion, COUNT(E.Id) AS Cantidad FROM Elementos E
INNER JOIN [Pokemons.Tipos] PT ON E.Id = PT.IdElemento
GROUP BY E.Descripcion

-- 3) Crear un Stored Procedure para cargar la Tabla Entrenadores.Medallas.
CREATE OR ALTER PROCEDURE spAgregarEntrenadoresMedallas(
	@IdEntrenador INT,
	@IdMedalla INT
) 
AS BEGIN

IF EXISTS (SELECT Id FROM Entrenadores WHERE Id = @IdEntrenador)
BEGIN
	IF EXISTS (SELECT Id FROM Medallas WHERE Id = @IdMedalla)
	BEGIN
		INSERT INTO [Entrenadores.Medallas]
		VALUES (@IdEntrenador, @IdMedalla, GETDATE())
		PRINT ('Medalla Asociada correctamente')
	END
	ELSE
	BEGIN
		RAISERROR('La medalla no existe', 16, 1)
	END
END
ELSE
BEGIN
	RAISERROR('El entrenador no existe', 16, 1)
END

END


-- 4) Consulta para mostrar las medallas obtenidas por cada entrenador 
-- (primero debe haber sido creado y utilizado el SP del punto anterior)
SELECT E.Nombre AS Entrenador, M.Nombre AS Medalla FROM Medallas M
INNER JOIN [Entrenadores.Medallas] EM ON M.Id = EM.IdMedalla
INNER JOIN Entrenadores E ON EM.IdEntrenador = E.Id

-- 5) Consulta para mostrar el nombre de los entrenadores y la cantidad de Pokémon que poseen, 
-- solo para aquellos que tienen más de 3 Pokémon.
SELECT E.Nombre AS Entrenador, COUNT(P.Id) AS 'Cantidad de Pokemons' FROM Entrenadores E
INNER JOIN [Entrenadores.Pokemons] EP ON E.Id = EP.IdEntrenador
INNER JOIN Pokemons P ON EP.IdPokemon = P.Id
GROUP BY E.Nombre
HAVING COUNT(P.Id) > 3

-- 6) Consulta para mostrar el nombre del entrenador, el nombre del Pokémon y su tipo, 
-- solo para aquellos Pokémon que tienen habilidades con descripción que contenga la palabra "ataque".
SELECT E.Nombre AS Entrenador, P.Nombre AS Pokemon, EL.Descripcion AS Tipo FROM Entrenadores E
INNER JOIN [Entrenadores.Pokemons] EP ON E.Id = EP.IdEntrenador
INNER JOIN Pokemons P ON EP.IdPokemon = P.Id
INNER JOIN [Pokemons.Tipos] PT ON P.Id = PT.IdPokemon
INNER JOIN [Pokemons.Habilidades] PH ON P.Id = PH.IdPokemon
INNER JOIN Elementos EL ON PT.IdElemento = EL.Id
INNER JOIN Habilidades H ON PH.IdHabilidad = H.Id
WHERE H.Descripcion LIKE '%ataque%'


-- 7) Consulta para mostrar el nombre de los entrenadores y la cantidad de Pokémon que tienen, 
-- ordenados de forma descendente por la cantidad de Pokémon.
SELECT E.Nombre, COUNT(EP.IdPokemon) AS Cantidad FROM Entrenadores E
INNER JOIN [Entrenadores.Pokemons] EP ON E.Id = EP.IdEntrenador
GROUP BY E.Nombre
ORDER BY Cantidad DESC

-- 8) Crear un Procedimiento Almacenado para Insertar un Entrenador.
CREATE OR ALTER PROCEDURE spAgregarEntrenador(
	@Nombre VARCHAR(50),
	@Apellido VARCHAR(50),
	@NickName VARCHAR(50),
	@Email VARCHAR(100),
	@Clave VARCHAR(25),
	@FechaNacimiento DATE
)
AS BEGIN
	INSERT INTO Entrenadores (Nombre, Apellido, NickName, Email, Clave, FechaNacimiento)
	VALUES (@Nombre, @Apellido, @NickName, @Email, @Clave, @FechaNacimiento)
	PRINT ('Entrenador agregado correctamente')
END

EXEC spAgregarEntrenador 'Prueba', 'Prueba A', 'PruebaAA', 'Prueba@gmail.com', 'prueba123', '1990-10-10'

-- 9) Crear un SP para Actualizar una Ciudad.
CREATE OR ALTER PROCEDURE spEditarCiudad(
	@Id INT,
	@Nombre VARCHAR(100)
)
AS BEGIN
	UPDATE Ciudades SET Nombre = @Nombre
	WHERE Id = @Id
END

EXEC spEditarCiudad 12, 'Isla Bomba'

/*10) ¿Cargaste los entrenadores desde MaxiFlixDB como hizo Maxi? Bueno, ahora eliminalos.
Armá un Delete con subconsulta para que elimine todos los registros agregados pero no los quites todos, 
solo vamos a eliminar aquellos que pertenezcan al mundo actoral pero que además hayan nacido antes de 1980.
También queremos dejar afuera a los que tengan un apellido que comience con “S”, no nos gustan…. 👀… 
en ese caso no importa la fecha de nacimiento.
Recordá primero consultar los datos para asegurarte de que vas a eliminar lo indicado.*/
DELETE FROM Entrenadores WHERE Id IN (
	SELECT Id FROM Entrenadores WHERE Apellido LIKE 'S%' OR YEAR(FechaNacimiento) < 1980 )

SELECT * FROM Entrenadores


-- DB MAXI FLIX --
USE MaxiFlix_DB
/*1)  Obtener una lista de películas que incluya el título de la película y su duración en minutos. 
Además, agregar una columna adicional llamada 'ClasificacionDuracion' que clasifique la duración 
de cada película en tres categorías: 'Corta' si la duración es menor a 90 minutos, 
'Media' si la duración está entre 90 y 119 minutos, y 'Larga' si la duración es igual o mayor a 120 minutos.*/
SELECT P.Titulo, P.MinutosDuracion,
	CASE WHEN P.MinutosDuracion < 90 THEN 'Corta'
	WHEN P.MinutosDuracion >= 90 AND P.MinutosDuracion <= 119 THEN 'Media'
	WHEN P.MinutosDuracion > 119 THEN 'Larga'
	END AS ClasificacionDuracion
FROM Peliculas P


/*2)  Obtener una lista de películas junto con una columna adicional llamada 'Disponibilidad' 
que indique si la película está disponible en alguna plataforma de streaming. 
Si la película está disponible en al menos una plataforma, mostrar 'Disponible';
de lo contrario, mostrar 'No disponible'.*/

SELECT DISTINCT P.Titulo,
	CASE WHEN PP.IdPlataforma IN (SELECT PP.IdPlataforma FROM [Peliculas.Plataformas] PP
	WHERE pp.IdPelicula = P.Id) THEN 'Disponible'
	ELSE 'No Disponible'
	END AS Disponibilidad, P.Id
FROM Peliculas P
INNER JOIN [Peliculas.Plataformas] PP ON P.Id = PP.IdPelicula

-- 3)  Obtener una lista de todas las clasificaciones únicas de las películas disponibles en la plataforma.

-- 4)  Obtener una lista de todas las plataformas únicas disponibles para ver películas.

-- 5)  Obtener la cantidad de Peliculas registradas en cada Plataforma.
SELECT PL.Nombre AS Plataforma, COUNT(P.Id) AS CantidadPeliculas FROM Plataformas PL
INNER JOIN [Peliculas.Plataformas] PP ON PL.Id = PP.IdPlataforma
INNER JOIN Peliculas P ON PP.IdPelicula = P.Id
GROUP BY PL.Nombre

-- 6)  Obtener las Plataformas que no cuenta con ninguna Película.
SELECT PL.Nombre AS Plataforma, COUNT(P.Id) AS CantidadPeliculas FROM Plataformas PL
LEFT JOIN [Peliculas.Plataformas] PP ON PL.Id = PP.IdPlataforma
LEFT JOIN Peliculas P ON PP.IdPelicula = P.Id
GROUP BY PL.Nombre
HAVING COUNT(P.Id) < 1

-- 7)  Obtener la cantidad de películas por género, pero solo incluir 
-- aquellos géneros que tengan al menos 3 películas asociadas.
SELECT G.Descripcion AS Género, COUNT(P.Id) AS 'Películas por género' FROM Generos G
INNER JOIN [Peliculas.Generos] PG ON G.Id = PG.IdGenero
INNER JOIN Peliculas P ON PG.IdPelicula = P.Id
GROUP BY G.Descripcion
HAVING COUNT(P.Id) > 3

/* 8)  Obtener el promedio de duración de las películas por clasificación, 
pero solo incluir aquellas clasificaciones que tengan un promedio de duración mayor o igual a 120 minutos.*/
SELECT CL.Descripcion AS Clasificacion, AVG(P.MinutosDuracion) AS 'Promedio duración' FROM Clasificaciones CL
INNER JOIN [Peliculas.Clasificaciones] PC ON CL.Id = PC.IdClasificacion
INNER JOIN Peliculas P ON PC.IdPelicula = P.Id
GROUP BY CL.Descripcion
HAVING AVG(P.MinutosDuracion) >= 120

/*9) Crear una vista llamada 'VistaPeliculasCategorias' que muestre el título de las películas 
y sus categorías correspondientes.*/
CREATE OR ALTER VIEW vPeliculasCategorias AS
SELECT P.Titulo AS Película, C.Descripcion AS Categoria FROM Peliculas P
INNER JOIN [Peliculas.Clasificaciones] PC ON P.Id = PC.IdPelicula
INNER JOIN Clasificaciones C ON PC.IdClasificacion = C.Id

/* 10)  Crear un procedimiento almacenado llamado 'ObtenerPeliculasPorCategoria' que tome un parámetro 
de entrada 'CategoriaId' y devuelva todas las películas que pertenecen a la categoría especificada. 
El procedimiento debe seleccionar el título, la fecha de estreno y la duración en minutos de cada película.*/
CREATE OR ALTER PROCEDURE spObtenerPeliculasPorCategoria(
	@CategoriaId INT
)
AS BEGIN
	IF EXISTS (SELECT Id FROM Categorias WHERE Id = @CategoriaId)
	BEGIN
		SELECT DISTINCT P.Titulo AS Pelicula, P.FechaEstreno, P.MinutosDuracion FROM Peliculas P
		INNER JOIN [Peliculas.Categorias] PC ON P.Id = PC.IdPelicula
		INNER JOIN Categorias C ON PC.IdCategoria = @CategoriaId
	END
	ELSE
	BEGIN
		RAISERROR('La categoria ingresada no es válida', 16,1)
	END
END

EXEC spObtenerPeliculasPorCategoria 6