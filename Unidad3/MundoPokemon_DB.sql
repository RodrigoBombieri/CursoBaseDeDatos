USE MASTER;
GO
--MDF: master data file (registro de los datos)
--LDF: log data file (registro de sucesos)
CREATE DATABASE MundoPokemon_DB
GO
USE MundoPokemon_DB
GO

CREATE TABLE Pokemons(
	Id INT not null,
	Nombre VARCHAR(50),
	Numero INT,
	Bio VARCHAR(250),
	Altura FLOAT,
	Peso FLOAT,
	ImagenUrl VARCHAR(500),
	IdEvolucion INT
);
GO
CREATE TABLE Entrenadores(
	Id INT not null,
	Nombre VARCHAR(50),
	Apellido VARCHAR(50),
	NickName VARCHAR(50),
	Email VARCHAR(100),
	Clave VARCHAR(25),
	FechaNacimiento DATE
);
GO
CREATE TABLE Elementos(
	Id INT not null PRIMARY KEY,
	Descripcion VARCHAR(50)
);
GO
CREATE TABLE Habilidades(
	Id INT not null,
	Nombre VARCHAR(50),
	Descripcion VARCHAR(250),
	IdTipo INT,

	CONSTRAINT PK_Habilidad PRIMARY KEY(Id)
);
GO
CREATE TABLE [Pokemons.Habilidades](
	Id INT not null,
	IdPokemon INT,
	IdHabilidad INT,

	CONSTRAINT PK_Pokemons_Habilidad PRIMARY KEY(Id),
	CONSTRAINT FK_PokeHabilidad_Habilidades FOREIGN KEY(IdHabilidad) REFERENCES Habilidades(Id),
);
--GO
--ALTER TABLE Pokemons
--ADD CONSTRAINT PK_Pokemon PRIMARY KEY(Id)
--GO
--ALTER TABLE [Pokemons.Habilidades]
--ADD CONSTRAINT FK_PokeHabilidad_Pokemons FOREIGN KEY(IdPokemon) REFERENCES Pokemons(Id)
GO
CREATE TABLE [Pokemons.Tipos](
	Id INT not null PRIMARY KEY,
	IdPokemon INT not null FOREIGN KEY REFERENCES Pokemons(Id),
	IdElemento INT not null FOREIGN KEY REFERENCES Elementos(Id)
);
GO
CREATE TABLE [Pokemons.Debilidades](
	Id INT not null PRIMARY KEY,
	IdPokemon INT not null FOREIGN KEY REFERENCES Pokemons(Id),
	IdElemento INT not null FOREIGN KEY REFERENCES Elementos(Id)
);
GO
CREATE TABLE Medallas(
	Id INT not null PRIMARY KEY,
	Nombre VARCHAR(50),
	ImagenUrl VARCHAR(500)
);
GO
CREATE TABLE Ciudades(
	Id INT not null PRIMARY KEY IDENTITY,
	Nombre VARCHAR(100)
);
GO
--ALTER TABLE Entrenadores
--ADD CONSTRAINT PK_Entrenadores PRIMARY KEY(Id)
--GO
CREATE TABLE Gimnasios(
	Id INT not null PRIMARY KEY IDENTITY,
	Nombre VARCHAR(100),
	IdCiudad INT not null FOREIGN KEY REFERENCES Ciudades(Id),
	IdMedalla INT not null FOREIGN KEY REFERENCES Medallas(Id),
	IdEntrenador INT not null FOREIGN KEY REFERENCES Entrenadores(Id)
);
GO
CREATE TABLE [Entrenadores.Medallas](
	Id INT not null PRIMARY KEY IDENTITY,
	IdEntrenador INT not null FOREIGN KEY REFERENCES Entrenadores(Id),
	IdMedalla INT not null FOREIGN KEY REFERENCES Medallas(Id),
	FechaObtencion	DATETIME
);
GO
CREATE TABLE [Entrenadores.Pokemons](
	Id INT not null PRIMARY KEY IDENTITY(1,1),
	IdEntrenador INT not null FOREIGN KEY REFERENCES Entrenadores(Id),
	IdPokemon INT not null FOREIGN KEY REFERENCES Pokemons(Id),
	Nombre VARCHAR(100)
);
GO
CREATE TABLE [Evoluciones.Variables](
	Id INT not null PRIMARY KEY IDENTITY(1,1),
	--IdEvolucion INT not null FOREIGN KEY REFERENCES Pokemons(IdEvolucion),
	IdPokemon INT not null FOREIGN KEY REFERENCES Pokemons(Id)
);
GO
--ALTER TABLE Pokemons
--ADD CONSTRAINT FK_Pokemons_Evolucion FOREIGN KEY(IdEvolucion) REFERENCES [Evoluciones.Variables](Id)
--GO

