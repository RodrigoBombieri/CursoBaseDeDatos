-- Ejercicios UNIDAD 2 --
-- CONSULTAS DE SELECT -- 
--1) Obtener las Pel�culas estrenadas en la D�cada de los '80.
SELECT * FROM Peliculas
WHERE YEAR(FechaEstreno) BETWEEN 1980 AND 1989

--2) Obtener los Actores nacidos en la D�cada de los '70.
SELECT * FROM Reparto
WHERE Dirige = 0 AND (YEAR(FechaNacimiento) BETWEEN 1970 AND 1979)

--3) Obtener las Peliculas que se encuentran en la Plataforma de Disney+.
SELECT P.Titulo AS Pel�cula FROM Peliculas AS P
INNER JOIN [Peliculas.Plataformas] AS PP ON P.ID = PP.IdPelicula
INNER JOIN Plataformas AS PL ON PP.IdPlataforma = PL.Id
WHERE PL.Nombre LIKE 'Disney+'

--4) Obtener la Cantidad de Pel�culas con Clasificaci�n R. (Considerar usar el Comando LIKE)
-- 'R%' --> Comienza con 'R'
-- '%op' --> Termina con 'op'
-- '%los%' --> Contiene 'los'
SELECT COUNT(P.ID) FROM Peliculas AS P
INNER JOIN [Peliculas.Clasificaciones] AS PC ON P.Id = PC.IdPelicula
INNER JOIN Clasificaciones AS C ON PC.IdClasificacion = C.Id
WHERE C.Descripcion LIKE 'R%'

--5) Obtener la Pel�cula que mayor duraci�n tiene.
SELECT TOP 1 P.Titulo, P.MinutosDuracion FROM Peliculas AS P
ORDER BY P.MinutosDuracion DESC

SELECT P.Titulo, P.MinutosDuracion
FROM Peliculas AS P
WHERE P.MinutosDuracion = (SELECT MAX(MinutosDuracion) FROM Peliculas)

--6) Obtener las Pel�culas de Categor�a 'Superh�roes'.
SELECT P.Titulo FROM Peliculas AS P
INNER JOIN [Peliculas.Categorias] AS PC ON P.Id = PC.IdPelicula
INNER JOIN Categorias AS C ON PC.IdCategoria = C.Id
WHERE C.Descripcion LIKE 'Superh�roes'

--7) Obtener la Cantidad de Actores que trabajaron en la Pel�cula 'Los Intocables'.
SELECT COUNT(PR.ID) AS 'Total de Actores' FROM [Peliculas.Reparto] AS PR
INNER JOIN Peliculas AS P ON PR.IdPelicula = P.Id
WHERE P.Titulo LIKE 'Los Intocables'

--8) Obtener los Actores que trabajaron en la Pel�culas 'Los Intocables'.
SELECT R.Nombre + ' ' + R.Apellido AS 'Nombre', PA.Nombre AS Nacionalidad, R.FechaNacimiento FROM Reparto AS R
INNER JOIN Paises AS PA ON R.IdNacionalidad = PA.Id
INNER JOIN [Peliculas.Reparto] AS PR ON R.Id = PR.IdReparto
INNER JOIN Peliculas AS P ON PR.IdPelicula = P.Id
WHERE P.Titulo LIKE 'Los Intocables'

--9) Obtener el Total de Pel�culas del Cat�logo.
SELECT COUNT(*) AS 'Cantidad de Pel�culas' FROM Peliculas

--10) Obtener la Lista de Usuarios Inactivos.
SELECT U.Nombre + ' ' + U.Apellido as Nombre, U.Email, U.FechaCreacion FROM USUARIOS U
WHERE Activo = 0


-- CONSULTAS DE INSERT -- 

-- 11) Ingresar el siguiente Film.
--Pel�cula: "The Good, the Bad and the Ugly"
--Biograf�a: "Tres hombres violentos pelean por una caja que alberga 200 000 d�lares, la cual fue escondida durante la Guerra Civil. Dado que ninguno puede encontrar la tumba donde est� el bot�n sin la ayuda de los otros dos, deben colaborar, pese a odiarse."
--Duraci�n: 162 minutos
--Fecha de Estreno: 11 de enero de 1968
INSERT INTO Peliculas(FechaEstreno, Titulo, MinutosDuracion, Bio, IdDirector)
VALUES ('1968-11-01', 'The Good, the Bad and the Ugly', 162, 'Tres hombres violentos pelean por una caja que alberga 200 000 d�lares, la cual fue escondida durante la Guerra Civil. Dado que ninguno puede encontrar la tumba donde est� el bot�n sin la ayuda de los otros dos, deben colaborar, pese a odiarse.', NULL) 

--12) En base al Film recientemente agregado al Cat�logo, agreg�rselo como Favorito a Severus Snape.
INSERT INTO [Usuarios.Favoritos](IdPelicula, IdUsuario, FechaFavorito)
VALUES(26, 4, GETDATE())

--13) Ahora hagamos que esta pelicula se pueda ver en las Plataformas de Netflix y Amazon.
INSERT INTO [Peliculas.Plataformas](Id, IdPelicula, IdPlataforma, FechaAlta, FechaBaja)
VALUES(44, 26, 1, GETDATE(), null),
	(45, 26, 2, GETDATE(), null)


--14) �Cu�l es la "relaci�n" que tienen estas consultas al Ejecutarse? �Cu�l es el motivo?
INSERT INTO Peliculas (FechaEstreno, Titulo, MinutosDuracion, Bio, IdDirector) VALUES ('2014-08-21', 'Relatos Salvajes', 122, 'Seis relatos que alternan la intriga, la comedia y la violencia. Sus personajes se ver�n empujados hacia el abismo y hacia el innegable placer de perder el control al cruzar la delgada l�nea que separa la civilizaci�n de la barbarie.', 112);
INSERT INTO [Peliculas.Categorias] (Id, IdCategoria, IdPelicula) VALUES (75, 6, 2);
INSERT INTO [Peliculas.Plataformas] (IdPelicula, IdPlataforma, FechaAlta) VALUES (24, 10, '2024-03-27');


-- CONSULTAS DE UPDATE --
SELECT* FROM Peliculas
-- 15) La Pel�cula de Rocky dej� de estar disponible en la Plataforma de Paramount+ el 16 de enero del 2024.
UPDATE [Peliculas.Plataformas] SET FechaBaja = '2024-01-16'
WHERE IdPelicula = 3 AND IdPlataforma = 9

-- 16) Hubo un error al momento de registrar la pel�cula de Iron Man. El Protagonista no fue Robert Downey Jr., qui�n interpret� el papel fue Diego Peretti.
UPDATE [Peliculas.Reparto] SET IdReparto = 107
WHERE IdPelicula = 2 AND Protagonista = 1

-- 17) La Plataforma Tubi TV cambia de firma, dado que cambiar� su nombre a MaxiPrograma TV.
UPDATE Plataformas SET Nombre = 'Maxi Programa TV'
WHERE Nombre LIKE 'Tubi TV'

-- 18) La Pel�cula de Spiderman cambia su Clasificaci�n de PG-13 a 'Apta para todos los P�blicos'.
UPDATE [Peliculas.Clasificaciones] SET IdClasificacion = 1
WHERE IdPelicula = 12

-- CONSULTAS DE DELETE --

--19) El Usuario Homero Simpson hace mucho tiempo que est� inactivo. Hay que eliminarlo de la Base de manera f�sica.
DELETE Usuarios 
WHERE Id = 3
--20) Realizar una limpieza de las Puntuaciones de las Pel�culas. Eliminar todas las Puntuaciones desde el 2020 hasta el 2023 (inclusive). �Se podr� realizar la Consulta?
DELETE [Peliculas.Puntuacion]
WHERE YEAR(FechaPuntuacion) BETWEEN 2020 AND 2023

--21) Se debe realizar una limpieza de Pel�culas. Hay que eliminar las Pel�culas que se hayan estrenado desde 1980 hasta 1989 (inclusive). �Se podr� realizar la Consulta?
DELETE Peliculas
WHERE YEAR(FechaEstreno) BETWEEN 1980 AND 1989
-- Arroja error ya que la tabla pel�culas posee referencias a otras tablas