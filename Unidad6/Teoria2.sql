-- FUNCIONES --

CREATE OR ALTER FUNCTION Saludar(@Nombre VARCHAR(50))
RETURNS VARCHAR(50)
AS BEGIN
	DECLARE @SaludoCompleto VARCHAR(50)
	SET @SaludoCompleto = CONCAT('Hola, ', @Nombre);

	RETURN @SaludoCompleto;
END

SELECT Id, dbo.Saludar(Nombre) AS Saludo FROM Pokemons

-- Función para que, a partir de una fecha, calcule la cantidad de días de la última captura de pokemon
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