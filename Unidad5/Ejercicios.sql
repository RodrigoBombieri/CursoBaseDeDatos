-- DB MUNDO POKEMON --

-- 1) Consulta para encontrar el nombre y número de Pokémon ordenados alfabéticamente.

-- 2) Consulta para mostrar el nombre y la cantidad de Pokémon por tipo.

-- 3) Crear un Stored Procedure para cargar la Tabla Entrenadores.Medallas.

-- 4) Consulta para mostrar las medallas obtenidas por cada entrenador 
-- (primero debe haber sido creado y utilizado el SP del punto anterior)

-- 5) Consulta para mostrar el nombre de los entrenadores y la cantidad de Pokémon que poseen, 
-- solo para aquellos que tienen más de 3 Pokémon.

-- 6) Consulta para mostrar el nombre del entrenador, el nombre del Pokémon y su tipo, 
-- solo para aquellos Pokémon que tienen habilidades con descripción que contenga la palabra "ataque".

-- 7) Consulta para mostrar el nombre de los entrenadores y la cantidad de Pokémon que tienen, 
-- ordenados de forma descendente por la cantidad de Pokémon.

-- 8) Crear un Procedimiento Almacenado para Insertar un Entrenador.

-- 9) Crear un SP para Actualizar una Ciudad.

/*10) ¿Cargaste los entrenadores desde MaxiFlixDB como hizo Maxi? Bueno, ahora eliminalos.
Armá un Delete con subconsulta para que elimine todos los registros agregados pero no los quites todos, solo vamos a eliminar aquellos que pertenezcan al mundo actoral pero que además hayan nacido antes de 1980.
También queremos dejar afuera a los que tengan un apellido que comience con “S”, no nos gustan…. 👀… en ese caso no importa la fecha de nacimiento.
Recordá primero consultar los datos para asegurarte de que vas a eliminar lo indicado.*/



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