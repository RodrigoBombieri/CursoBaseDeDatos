CREATE DATABASE [MaxiFlix_DB]
GO
USE [MaxiFlix_DB]
/****** Object:  Table [dbo].[Categorias]    Script Date: 2/2/2024 15:49:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categorias](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](50) NULL,
 CONSTRAINT [PK_Categorias] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Clasificaciones]    Script Date: 2/2/2024 15:49:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Clasificaciones](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](100) NULL,
 CONSTRAINT [PK_Clasificaciones] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Generos]    Script Date: 2/2/2024 15:49:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Generos](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](50) NULL,
 CONSTRAINT [PK_Generos] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Media]    Script Date: 2/2/2024 15:49:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Media](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdPelicula] [int] NOT NULL,
	[MediaURL] [varchar](300) NULL,
	[IdTipo] [int] NOT NULL,
 CONSTRAINT [PK_Media] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Media.Tipos]    Script Date: 2/2/2024 15:49:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Media.Tipos](
	[Id] [int] NOT NULL,
	[Descripcion] [varchar](50) NULL,
 CONSTRAINT [PK_Media.Tipos] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Paises]    Script Date: 2/2/2024 15:49:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Paises](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NULL,
 CONSTRAINT [PK_Paises] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Peliculas]    Script Date: 2/2/2024 15:49:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Peliculas](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FechaEstreno] [smalldatetime] NULL,
	[Titulo] [varchar](100) NULL,
	[MinutosDuracion] [int] NULL,
	[Bio] [varchar](1000) NULL,
	[IdDirector] [int] NULL,
 CONSTRAINT [PK_Peliculas] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Peliculas.Categorias]    Script Date: 2/2/2024 15:49:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Peliculas.Categorias](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdCategoria] [int] NOT NULL,
	[IdPelicula] [int] NOT NULL,
 CONSTRAINT [PK_Peliculas.Categorias] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Peliculas.Clasificaciones]    Script Date: 2/2/2024 15:49:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Peliculas.Clasificaciones](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdPelicula] [int] NOT NULL,
	[IdClasificacion] [int] NOT NULL,
 CONSTRAINT [PK_Peliculas.Clasificaciones] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Peliculas.Generos]    Script Date: 2/2/2024 15:49:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Peliculas.Generos](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdGenero] [int] NOT NULL,
	[IdPelicula] [int] NOT NULL,
 CONSTRAINT [PK_Peliculas.Generos] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Peliculas.Plataformas]    Script Date: 2/2/2024 15:49:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Peliculas.Plataformas](
	[Id] [int] NOT NULL,
	[IdPelicula] [int] NOT NULL,
	[IdPlataforma] [int] NOT NULL,
	[FechaAlta] [smalldatetime] NULL,
	[FechaBaja] [smalldatetime] NULL,
 CONSTRAINT [PK_Peliculas.Plataformas] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Peliculas.Puntuacion]    Script Date: 2/2/2024 15:49:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Peliculas.Puntuacion](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdPelicula] [int] NOT NULL,
	[IdUsuario] [int] NOT NULL,
	[Puntuacion] [tinyint] NULL,
	[FechaPuntuacion] [date] NULL,
 CONSTRAINT [PK_Peliculas.Puntuacion] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Peliculas.Reparto]    Script Date: 2/2/2024 15:49:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Peliculas.Reparto](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdReparto] [int] NOT NULL,
	[IdPelicula] [int] NOT NULL,
	[Protagonista] [bit] NOT NULL,
 CONSTRAINT [PK_Peliculas.Reparto] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Plataformas]    Script Date: 2/2/2024 15:49:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Plataformas](
	[Id] [int] NOT NULL,
	[Nombre] [varchar](50) NULL,
	[Precio] [money] NULL,
 CONSTRAINT [PK_Plataformas] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Reparto]    Script Date: 2/2/2024 15:49:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reparto](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](100) NULL,
	[Apellido] [varchar](100) NULL,
	[IdNacionalidad] [int] NULL,
	[FechaNacimiento] [smalldatetime] NULL,
	[ImagenUrl] [varchar](300) NULL,
	[Dirige] [bit] NULL,
 CONSTRAINT [PK_Reparto] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuarios]    Script Date: 2/2/2024 15:49:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuarios](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NULL,
	[Apellido] [varchar](50) NULL,
	[Email] [varchar](200) NULL,
	[Clave] [varchar](50) NULL,
	[FechaCreacion] [smalldatetime] NULL,
	[Activo] [bit] NULL,
	[FotoPerfilURL] [varchar](300) NULL,
 CONSTRAINT [PK_Usuarios] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuarios.Favoritos]    Script Date: 2/2/2024 15:49:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuarios.Favoritos](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdPelicula] [int] NOT NULL,
	[IdUsuario] [int] NOT NULL,
	[FechaFavorito] [smalldatetime] NULL,
 CONSTRAINT [PK_Usuarios.Favoritos] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Peliculas.Reparto] ADD  CONSTRAINT [DF_Peliculas.Reparto_Protagonista]  DEFAULT ((0)) FOR [Protagonista]
GO
ALTER TABLE [dbo].[Reparto] ADD  CONSTRAINT [DF_Reparto_Dirige]  DEFAULT ((0)) FOR [Dirige]
GO
ALTER TABLE [dbo].[Media]  WITH CHECK ADD  CONSTRAINT [FK_Media_Media.Tipos] FOREIGN KEY([IdTipo])
REFERENCES [dbo].[Media.Tipos] ([Id])
GO
ALTER TABLE [dbo].[Media] CHECK CONSTRAINT [FK_Media_Media.Tipos]
GO
ALTER TABLE [dbo].[Media]  WITH CHECK ADD  CONSTRAINT [FK_Media_Peliculas] FOREIGN KEY([IdPelicula])
REFERENCES [dbo].[Peliculas] ([Id])
GO
ALTER TABLE [dbo].[Media] CHECK CONSTRAINT [FK_Media_Peliculas]
GO
ALTER TABLE [dbo].[Peliculas]  WITH CHECK ADD  CONSTRAINT [FK_Peliculas_Reparto] FOREIGN KEY([IdDirector])
REFERENCES [dbo].[Reparto] ([Id])
GO
ALTER TABLE [dbo].[Peliculas] CHECK CONSTRAINT [FK_Peliculas_Reparto]
GO
ALTER TABLE [dbo].[Peliculas.Categorias]  WITH CHECK ADD  CONSTRAINT [FK_Peliculas.Categorias_Categorias] FOREIGN KEY([IdCategoria])
REFERENCES [dbo].[Categorias] ([Id])
GO
ALTER TABLE [dbo].[Peliculas.Categorias] CHECK CONSTRAINT [FK_Peliculas.Categorias_Categorias]
GO
ALTER TABLE [dbo].[Peliculas.Categorias]  WITH CHECK ADD  CONSTRAINT [FK_Peliculas.Categorias_Peliculas] FOREIGN KEY([IdPelicula])
REFERENCES [dbo].[Peliculas] ([Id])
GO
ALTER TABLE [dbo].[Peliculas.Categorias] CHECK CONSTRAINT [FK_Peliculas.Categorias_Peliculas]
GO
ALTER TABLE [dbo].[Peliculas.Clasificaciones]  WITH CHECK ADD  CONSTRAINT [FK_Peliculas.Clasificaciones_Clasificaciones] FOREIGN KEY([IdClasificacion])
REFERENCES [dbo].[Clasificaciones] ([Id])
GO
ALTER TABLE [dbo].[Peliculas.Clasificaciones] CHECK CONSTRAINT [FK_Peliculas.Clasificaciones_Clasificaciones]
GO
ALTER TABLE [dbo].[Peliculas.Clasificaciones]  WITH CHECK ADD  CONSTRAINT [FK_Peliculas.Clasificaciones_Peliculas] FOREIGN KEY([IdPelicula])
REFERENCES [dbo].[Peliculas] ([Id])
GO
ALTER TABLE [dbo].[Peliculas.Clasificaciones] CHECK CONSTRAINT [FK_Peliculas.Clasificaciones_Peliculas]
GO
ALTER TABLE [dbo].[Peliculas.Generos]  WITH CHECK ADD  CONSTRAINT [FK_Peliculas.Generos_Generos] FOREIGN KEY([IdGenero])
REFERENCES [dbo].[Generos] ([Id])
GO
ALTER TABLE [dbo].[Peliculas.Generos] CHECK CONSTRAINT [FK_Peliculas.Generos_Generos]
GO
ALTER TABLE [dbo].[Peliculas.Generos]  WITH CHECK ADD  CONSTRAINT [FK_Peliculas.Generos_Peliculas] FOREIGN KEY([IdPelicula])
REFERENCES [dbo].[Peliculas] ([Id])
GO
ALTER TABLE [dbo].[Peliculas.Generos] CHECK CONSTRAINT [FK_Peliculas.Generos_Peliculas]
GO
ALTER TABLE [dbo].[Peliculas.Plataformas]  WITH CHECK ADD  CONSTRAINT [FK_Peliculas.Plataformas_Peliculas] FOREIGN KEY([IdPelicula])
REFERENCES [dbo].[Peliculas] ([Id])
GO
ALTER TABLE [dbo].[Peliculas.Plataformas] CHECK CONSTRAINT [FK_Peliculas.Plataformas_Peliculas]
GO
ALTER TABLE [dbo].[Peliculas.Plataformas]  WITH CHECK ADD  CONSTRAINT [FK_Peliculas.Plataformas_Plataformas] FOREIGN KEY([IdPlataforma])
REFERENCES [dbo].[Plataformas] ([Id])
GO
ALTER TABLE [dbo].[Peliculas.Plataformas] CHECK CONSTRAINT [FK_Peliculas.Plataformas_Plataformas]
GO
ALTER TABLE [dbo].[Peliculas.Puntuacion]  WITH CHECK ADD  CONSTRAINT [FK_Peliculas.Puntuacion_Peliculas] FOREIGN KEY([IdPelicula])
REFERENCES [dbo].[Peliculas] ([Id])
GO
ALTER TABLE [dbo].[Peliculas.Puntuacion] CHECK CONSTRAINT [FK_Peliculas.Puntuacion_Peliculas]
GO
ALTER TABLE [dbo].[Peliculas.Puntuacion]  WITH CHECK ADD  CONSTRAINT [FK_Peliculas.Puntuacion_Usuarios] FOREIGN KEY([IdUsuario])
REFERENCES [dbo].[Usuarios] ([Id])
GO
ALTER TABLE [dbo].[Peliculas.Puntuacion] CHECK CONSTRAINT [FK_Peliculas.Puntuacion_Usuarios]
GO
ALTER TABLE [dbo].[Peliculas.Reparto]  WITH CHECK ADD  CONSTRAINT [FK_Peliculas.Reparto_Peliculas] FOREIGN KEY([IdPelicula])
REFERENCES [dbo].[Peliculas] ([Id])
GO
ALTER TABLE [dbo].[Peliculas.Reparto] CHECK CONSTRAINT [FK_Peliculas.Reparto_Peliculas]
GO
ALTER TABLE [dbo].[Peliculas.Reparto]  WITH CHECK ADD  CONSTRAINT [FK_Peliculas.Reparto_Reparto] FOREIGN KEY([IdReparto])
REFERENCES [dbo].[Reparto] ([Id])
GO
ALTER TABLE [dbo].[Peliculas.Reparto] CHECK CONSTRAINT [FK_Peliculas.Reparto_Reparto]
GO
ALTER TABLE [dbo].[Reparto]  WITH CHECK ADD  CONSTRAINT [FK_Reparto_Paises] FOREIGN KEY([IdNacionalidad])
REFERENCES [dbo].[Paises] ([Id])
GO
ALTER TABLE [dbo].[Reparto] CHECK CONSTRAINT [FK_Reparto_Paises]
GO
ALTER TABLE [dbo].[Usuarios.Favoritos]  WITH CHECK ADD  CONSTRAINT [FK_Usuarios.Favoritos_Peliculas] FOREIGN KEY([IdPelicula])
REFERENCES [dbo].[Peliculas] ([Id])
GO
ALTER TABLE [dbo].[Usuarios.Favoritos] CHECK CONSTRAINT [FK_Usuarios.Favoritos_Peliculas]
GO
ALTER TABLE [dbo].[Usuarios.Favoritos]  WITH CHECK ADD  CONSTRAINT [FK_Usuarios.Favoritos_Usuarios] FOREIGN KEY([IdUsuario])
REFERENCES [dbo].[Usuarios] ([Id])
GO
ALTER TABLE [dbo].[Usuarios.Favoritos] CHECK CONSTRAINT [FK_Usuarios.Favoritos_Usuarios]
GO