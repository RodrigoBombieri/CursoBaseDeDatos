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


-- ORDER BY