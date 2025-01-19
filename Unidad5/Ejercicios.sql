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

/*1)  Obtener una lista de películas que incluya el título de la película y su duración en minutos. 
Además, agregar una columna adicional llamada 'ClasificacionDuracion' que clasifique la duración 
de cada película en tres categorías: 'Corta' si la duración es menor a 90 minutos, 
'Media' si la duración está entre 90 y 119 minutos, y 'Larga' si la duración es igual o mayor a 120 minutos.*/

/*2)  Obtener una lista de películas junto con una columna adicional llamada 'Disponibilidad' 
que indique si la película está disponible en alguna plataforma de streaming. 
Si la película está disponible en al menos una plataforma, mostrar 'Disponible';
de lo contrario, mostrar 'No disponible'.*/

-- 3)  Obtener una lista de todas las clasificaciones únicas de las películas disponibles en la plataforma.

-- 4)  Obtener una lista de todas las plataformas únicas disponibles para ver películas.

-- 5)  Obtener la cantidad de Peliculas registradas en cada Plataforma.

-- 6)  Obtener las Plataformas que no cuenta con ninguna Película.

-- 7)  Obtener la cantidad de películas por género, pero solo incluir aquellos géneros que tengan al menos 3 películas asociadas.

/* 8)  Obtener el promedio de duración de las películas por clasificación, 
pero solo incluir aquellas clasificaciones que tengan un promedio de duración mayor o igual a 120 minutos.*/

/*9) Crear una vista llamada 'VistaPeliculasCategorias' que muestre el título de las películas 
y sus categorías correspondientes.*/

/* 10)  Crear un procedimiento almacenado llamado 'ObtenerPeliculasPorCategoria' que tome un parámetro 
de entrada 'CategoriaId' y devuelva todas las películas que pertenecen a la categoría especificada. 
El procedimiento debe seleccionar el título, la fecha de estreno y la duración en minutos de cada película.*/