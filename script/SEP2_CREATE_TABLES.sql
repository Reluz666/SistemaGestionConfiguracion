CREATE TABLE [dbo].[CLASIFICACION_DATOS_ELEMENTO_CONFIGURACION](
	[ID_CLASIFICACION] [int] IDENTITY(1,1) NOT NULL,
	[NOMBRE_CLASIFICACION] [varchar](50) NOT NULL,
 CONSTRAINT [PK_CLASIFICACION_DATOS_ELEMENTO_CONFIGURACION] PRIMARY KEY CLUSTERED 
(
	[ID_CLASIFICACION] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[SEGUIMIENTO_ELEMENTO_CONFIGURACION] Fecha de script: 18/05/2026 10:08:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SEGUIMIENTO_ELEMENTO_CONFIGURACION](
	[ID_SEGUIMIENTO] [int] IDENTITY(1,1) NOT NULL,
	[ID_ELEMENTO_CONFIGURACION] [int] NOT NULL,
	[RESPONSABLE_SEGUIMIENTO] [int] NOT NULL,
	[FECHA_SEGUIMIENTO] [datetime] NOT NULL,
	[ID_CLASIFICACION] [int] NOT NULL,
	[RELACION_OTROS_CIS] [bit] NOT NULL,
	[CUMPLE_POLITICAS_GESTION_CONFIGURACION_ORGANIZACION] [bit] NOT NULL,
	[OBSERVACION_SEGUIMIENTO] [varchar](max) NOT NULL,
 CONSTRAINT [PK_SEGUIMIENTO_ELEMENTO_CONFIGURACION] PRIMARY KEY CLUSTERED 
(
	[ID_SEGUIMIENTO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[Usuario] Fecha de script: 18/05/2026 10:08:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuario](
	[Id_Uusario] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](25) NOT NULL,
	[ApePat] [varchar](25) NOT NULL,
	[ApeMat] [varchar](25) NOT NULL,
	[Telefono] [varchar](9) NOT NULL,
	[Email] [varchar](max) NOT NULL,
	[Login] [varchar](50) NOT NULL,
	[Password] [varchar](50) NOT NULL,
	[Estado] [bit] NOT NULL,
	[ID_CARGO] [int] NULL,
	[Id_Area] [int] NULL,
 CONSTRAINT [pk_Usuario_Id_Usuario] PRIMARY KEY CLUSTERED 
(
	[Id_Uusario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Objeto: View [dbo].[VISTA_DETALLE_SEGUIMIENTO_ELEMENTOS_CONFIGURACION] Fecha de script: 18/05/2026 10:08:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VISTA_DETALLE_SEGUIMIENTO_ELEMENTOS_CONFIGURACION]
AS
SELECT        dbo.SEGUIMIENTO_ELEMENTO_CONFIGURACION.ID_SEGUIMIENTO AS [ID SEGUIMIENTO], 
                         dbo.SEGUIMIENTO_ELEMENTO_CONFIGURACION.ID_ELEMENTO_CONFIGURACION AS [ID CI], 
                         dbo.SEGUIMIENTO_ELEMENTO_CONFIGURACION.RESPONSABLE_SEGUIMIENTO AS [ID RESPONSABLE], 
                         dbo.Usuario.Nombre + ' ' + dbo.Usuario.ApePat + ' ' + dbo.Usuario.ApeMat AS RESPONSABLE, 
                         dbo.SEGUIMIENTO_ELEMENTO_CONFIGURACION.FECHA_SEGUIMIENTO AS [FECHA SEGUIMIENTO], 
                         dbo.CLASIFICACION_DATOS_ELEMENTO_CONFIGURACION.NOMBRE_CLASIFICACION AS [CLASIFICACION DATOS], 
                         dbo.obtener_estado_actual_seguimiento_elemento_congiguracion(dbo.SEGUIMIENTO_ELEMENTO_CONFIGURACION.ID_SEGUIMIENTO) 
                         AS [ESTADO ACTUAL], CASE dbo.SEGUIMIENTO_ELEMENTO_CONFIGURACION.RELACION_OTROS_CIS WHEN 1 THEN 'SI' ELSE 'NO' END AS [RELACION CIS],
                          CASE dbo.SEGUIMIENTO_ELEMENTO_CONFIGURACION.CUMPLE_POLITICAS_GESTION_CONFIGURACION_ORGANIZACION WHEN 1 THEN 'SI' ELSE 'NO' END
                          AS [CUMPLE POLITICA GESTION CONIGURACION ORGANIZACION], 
                         dbo.SEGUIMIENTO_ELEMENTO_CONFIGURACION.OBSERVACION_SEGUIMIENTO AS OBSERVACION
FROM            dbo.SEGUIMIENTO_ELEMENTO_CONFIGURACION INNER JOIN
                         dbo.CLASIFICACION_DATOS_ELEMENTO_CONFIGURACION ON 
                         dbo.SEGUIMIENTO_ELEMENTO_CONFIGURACION.ID_CLASIFICACION = dbo.CLASIFICACION_DATOS_ELEMENTO_CONFIGURACION.ID_CLASIFICACION INNER
                          JOIN
                         dbo.Usuario ON dbo.SEGUIMIENTO_ELEMENTO_CONFIGURACION.RESPONSABLE_SEGUIMIENTO = dbo.Usuario.Id_Uusario





GO
/****** Objeto: Table [dbo].[Area] Fecha de script: 18/05/2026 10:08:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Area](
	[Id_Area] [int] IDENTITY(1,1) NOT NULL,
	[Codigo_Area] [varchar](6) NOT NULL,
	[Descripcion_Area] [varchar](max) NOT NULL,
	[Nro_Piso] [char](1) NOT NULL,
	[Nro_Ambiente] [varchar](3) NOT NULL,
	[Id_Local] [int] NOT NULL,
 CONSTRAINT [PK_Area_1] PRIMARY KEY CLUSTERED 
(
	[Id_Area] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[DESCRIPCION_ELEMENTO CONFIGURACION] Fecha de script: 18/05/2026 10:08:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DESCRIPCION_ELEMENTO CONFIGURACION](
	[ID_DESCRIPCION] [int] IDENTITY(1,1) NOT NULL,
	[NOMBRE_DESCRIPCION] [varchar](max) NOT NULL,
	[ID_TIPO] [int] NULL,
 CONSTRAINT [PK_DESCRIPCION_ELEMENTO CONFIGURACION] PRIMARY KEY CLUSTERED 
(
	[ID_DESCRIPCION] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[ELEMENTOS_CONFIGURACION] Fecha de script: 18/05/2026 10:08:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ELEMENTOS_CONFIGURACION](
	[ID_ELEMENTO_CONFIGURACION] [int] IDENTITY(1,1) NOT NULL,
	[NOMBRE_ELEMENTO_CONFIGURACION] [varchar](max) NULL,
	[ID_TIPO] [int] NULL,
	[ID_ESTADO] [int] NULL,
	[PROPIETARIO] [int] NULL,
	[ID_DESCRIPCION] [int] NULL,
	[ID_IMP_ELE_CONF_HAR] [int] NULL,
	[LOCALIZACION_FISICA] [int] NULL,
	[FECHA_REGISTRO] [datetime] NULL,
	[RESPONSABLE_REGISTRO] [int] NULL,
	[ID_NIVEL] [int] NULL,
	[NRO_SERIE] [varchar](max) NULL,
	[FABRICANTE_O_PROVEEDOR] [varchar](max) NULL,
	[ID_MAR] [int] NULL,
	[ID_MOD] [int] NULL,
	[IP] [varchar](15) NULL,
	[GATEWAY] [varchar](15) NULL,
	[GRUPO_TRABAJO] [varchar](max) NULL,
 CONSTRAINT [PK_ELE_CONF_HAR_1] PRIMARY KEY CLUSTERED 
(
	[ID_ELEMENTO_CONFIGURACION] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[ESTADO_ELEMENTO_CONFIGURACION] Fecha de script: 18/05/2026 10:08:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ESTADO_ELEMENTO_CONFIGURACION](
	[ID_ESTADO] [int] IDENTITY(1,1) NOT NULL,
	[NOMBRE_ESTADO] [varchar](15) NOT NULL,
 CONSTRAINT [PK_ESTADO_ELEMENTO_CONFIGURACION] PRIMARY KEY CLUSTERED 
(
CREATE TABLE [dbo].[CARGO](
	[ID_CARGO] [int] IDENTITY(1,1) NOT NULL,
	[NOMBRE_CARGO] [varchar](max) NOT NULL,
 CONSTRAINT [PK_CARGO] PRIMARY KEY CLUSTERED 
(
	[ID_CARGO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[Dependencia] Fecha de script: 18/05/2026 10:08:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dependencia](
	[Id_Dependencia] [int] IDENTITY(1,1) NOT NULL,
	[Codigo_Depemdencia] [varchar](4) NOT NULL,
	[Nombre_Dependencia] [varchar](max) NOT NULL,
 CONSTRAINT [PK_Dependencia] PRIMARY KEY CLUSTERED 
(
	[Id_Dependencia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[Profesion_Ocupacion] Fecha de script: 18/05/2026 10:08:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Profesion_Ocupacion](
	[Id_prof_ocup] [int] IDENTITY(1,1) NOT NULL,
	[Prof_Ocup] [varchar](250) NOT NULL,
	[Descripcion_prof_ocup] [varchar](250) NULL,
 CONSTRAINT [PK_Profes_Ocupac] PRIMARY KEY CLUSTERED 
(
	[Id_prof_ocup] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[Tipo_de_Documento_de_Identidad] Fecha de script: 18/05/2026 10:08:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tipo_de_Documento_de_Identidad](
	[Id_Tipo_Documento] [int] IDENTITY(1,1) NOT NULL,
	[Codigo_Tipo_Documento] [varchar](50) NOT NULL,
	[Nombre_Tipo_Documento] [varchar](250) NOT NULL,
	[Siglas_Tipo_Documento] [varchar](50) NULL,
	[Descrip_Tipo_Documento] [varchar](200) NULL,
 CONSTRAINT [PK_Tipo_de_Documento_de_Identidad] PRIMARY KEY CLUSTERED 
(
	[Id_Tipo_Documento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: View [dbo].[VISTA_PERSONAL] Fecha de script: 18/05/2026 10:08:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VISTA_PERSONAL]
AS
SELECT        dbo.Personal.Id_Personal, dbo.Sede.Descripcion_Sede AS SEDE, dbo.Local.Nombre_Local AS LOCAL, dbo.Area.Descripcion_Area AS AREA, 
                         dbo.Dependencia.Nombre_Dependencia AS DEPENDENCIA, dbo.Personal.Codigo_Personal AS CODIGO, dbo.Personal.Nombre_Personal AS NOMBRE, 
                         dbo.Personal.ApePat_Personal AS [APELLIDO PATERNO], dbo.Personal.ApeMat_Personal AS [APELLIDO MATERNO], 
                         dbo.Tipo_de_Documento_de_Identidad.Nombre_Tipo_Documento AS [TIPO DOC. IDENT.], dbo.Personal.Nro_Dni_Personal AS [NRO. DOC. IDENT.], 
                         dbo.Profesion_Ocupacion.Prof_Ocup AS PROFESION, dbo.Personal.Tel_Personal AS TELEFONO, dbo.Personal.Email_Personal AS EMAIL, 
                         CASE dbo.Personal.Estado_Personal WHEN 1 THEN 'ACTIVO' ELSE 'INACTIVO' END AS ESTADO, dbo.CARGO.NOMBRE_CARGO AS CARGO
FROM            dbo.Personal INNER JOIN
                         dbo.Tipo_de_Documento_de_Identidad ON dbo.Personal.Id_Tipo_Documento = dbo.Tipo_de_Documento_de_Identidad.Id_Tipo_Documento INNER JOIN
                         dbo.Profesion_Ocupacion ON dbo.Personal.Id_prof_ocup = dbo.Profesion_Ocupacion.Id_prof_ocup INNER JOIN
                         dbo.Area ON dbo.Personal.Id_Area = dbo.Area.Id_Area INNER JOIN
                         dbo.Dependencia ON dbo.Personal.Id_Dependencia = dbo.Dependencia.Id_Dependencia INNER JOIN
                         dbo.Local ON dbo.Area.Id_Local = dbo.Local.Id_Local INNER JOIN
                         dbo.Sede ON dbo.Local.Id_Sede = dbo.Sede.Id_Sede INNER JOIN
                         dbo.CARGO ON dbo.Personal.ID_CARGO = dbo.CARGO.ID_CARGO





GO
/****** Objeto: View [dbo].[VISTA_PERSONAL_2] Fecha de script: 18/05/2026 10:08:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VISTA_PERSONAL_2]
AS
SELECT        dbo.Personal.Id_Personal AS ID, dbo.Sede.Descripcion_Sede AS SEDE, dbo.Local.Nombre_Local AS LOCAL, dbo.Area.Descripcion_Area AS AREA, 
                         dbo.Dependencia.Nombre_Dependencia AS DEPENDENCIA, dbo.Area.Nro_Piso AS [NRO PISO], dbo.Area.Nro_Ambiente AS [NRO AMBIENTE], 
                         dbo.Personal.Nombre_Personal + ' ' + dbo.Personal.ApePat_Personal + ' ' + dbo.Personal.ApeMat_Personal AS PERSONAL, 
                         dbo.Profesion_Ocupacion.Prof_Ocup AS PROFESION, dbo.Personal.Tel_Personal AS TELEFONO, dbo.Personal.Email_Personal AS EMAIL, 
                         CASE dbo.Personal.Estado_Personal WHEN 1 THEN 'ACTIVO' ELSE 'INACTIVO' END AS ESTADO
FROM            dbo.Personal INNER JOIN
                         dbo.Tipo_de_Documento_de_Identidad ON dbo.Personal.Id_Tipo_Documento = dbo.Tipo_de_Documento_de_Identidad.Id_Tipo_Documento INNER JOIN
                         dbo.Profesion_Ocupacion ON dbo.Personal.Id_prof_ocup = dbo.Profesion_Ocupacion.Id_prof_ocup INNER JOIN
                         dbo.Area ON dbo.Personal.Id_Area = dbo.Area.Id_Area INNER JOIN
                         dbo.Dependencia ON dbo.Personal.Id_Dependencia = dbo.Dependencia.Id_Dependencia INNER JOIN
                         dbo.Local ON dbo.Area.Id_Local = dbo.Local.Id_Local INNER JOIN
                         dbo.Sede ON dbo.Local.Id_Sede = dbo.Sede.Id_Sede
WHERE        (CASE dbo.Personal.Estado_Personal WHEN 1 THEN 'ACTIVO' ELSE 'INACTIVO' END = 'ACTIVO')





GO
/****** Objeto: Table [dbo].[RELACION_ELEMENTO_CONFIGURACION] Fecha de script: 18/05/2026 10:08:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RELACION_ELEMENTO_CONFIGURACION](
	[ID_RELACION] [int] IDENTITY(1,1) NOT NULL,
	[ELEMENTO_CONFIGURACION_PADRE] [int] NOT NULL,
	[ELEMENTO_CONFIGURACION_HIJO] [int] NOT NULL,
	[COD_TIPO_RELA] [int] NOT NULL,
 CONSTRAINT [PK_RELACION_ELEMENTO_CONFIGURACION] PRIMARY KEY CLUSTERED 
(
	[ID_RELACION] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[TIPO_RELACION_ELEMENTO_CONFIGURACION] Fecha de script: 18/05/2026 10:08:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TIPO_RELACION_ELEMENTO_CONFIGURACION](
	[COD_TIPO_RELA] [int] IDENTITY(1,1) NOT NULL,
	[NOMBRE_TIPO_RELA] [varchar](25) NOT NULL,
 CONSTRAINT [PK_TIPO_RELACION_ELEMENTO_CONFIGURACION] PRIMARY KEY CLUSTERED 
(
	[COD_TIPO_RELA] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: View [dbo].[VISTA_PORCENTAJE_DE_CIS_RELATIVO_A_SERVICIOS] Fecha de script: 18/05/2026 10:08:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VISTA_PORCENTAJE_DE_CIS_RELATIVO_A_SERVICIOS]
AS
SELECT        R.ID_RELACION, P.ID_ELEMENTO_CONFIGURACION AS [PADRE ID], P.NOMBRE_ELEMENTO_CONFIGURACION AS [PADRE CI], 
                         dbo.TIPOS_ELEMENTO_CONFIGURACION.NOMBRE_TIPO AS [PADRE TIPO CI], 
                         dbo.ESTADO_ELEMENTO_CONFIGURACION.NOMBRE_ESTADO AS [PADRE ESTADO CI], 
                         dbo.Personal.Nombre_Personal + ' ' + dbo.Personal.ApePat_Personal + ' ' + dbo.Personal.ApeMat_Personal AS [PADRE PROPIETARIO CI], 
                         dbo.[DESCRIPCION_ELEMENTO CONFIGURACION].NOMBRE_DESCRIPCION AS [PADRE DESCRIPCION CI], 
                         dbo.NIVEL_PRIORIDAD.NOMBRE_NIVEL AS [PADRE NIVEL PRIORIDAD], dbo.Sede.Descripcion_Sede AS [PADRE SEDE], 
                         dbo.Local.Nombre_Local AS [PADRE LOCAL], dbo.Area.Descripcion_Area AS [PADRE AREA], dbo.Area.Nro_Piso AS [PADRE NRO PISO], 
                         dbo.Area.Nro_Ambiente AS [PADRE NRO AMBIENTE], dbo.Ubigeo.Distrito + ' ' + dbo.Ubigeo.Provincia + ' ' + dbo.Ubigeo.Departamento AS [PADRE UBICACION],
                          dbo.Local.Direccion_Local AS [PADRE DIRECCION LOCAL], C.ID_ELEMENTO_CONFIGURACION AS [HIJO ID], 
                         C.NOMBRE_ELEMENTO_CONFIGURACION AS [HIJO CI], TIPOS_ELEMENTO_CONFIGURACION_1.NOMBRE_TIPO AS [HIJO TIPO CI], 
                         ESTADO_ELEMENTO_CONFIGURACION_1.NOMBRE_ESTADO AS [HIJO ESTADO CI], 
                         Personal_1.Nombre_Personal + ' ' + Personal_1.ApePat_Personal + ' ' + Personal_1.ApeMat_Personal AS [HIJO PROPIETARIO CI], 
                         [DESCRIPCION_ELEMENTO CONFIGURACION_1].NOMBRE_DESCRIPCION AS [HIJO DESCRIPCION CI], 
                         NIVEL_PRIORIDAD_1.NOMBRE_NIVEL AS [HIJO NIVEL PRIORIDAD], Sede_1.Descripcion_Sede AS [HIJO SEDE], Local_1.Nombre_Local AS [HIJO LOCAL], 
                         Area_1.Descripcion_Area AS [HIJO AREA], Area_1.Nro_Piso AS [HIJO NRO PISO], Area_1.Nro_Ambiente AS [HIJO NRO AMBIENTE], 
                         Ubigeo_1.Distrito + ' ' + Ubigeo_1.Provincia + ' ' + Ubigeo_1.Departamento AS [HIJO UBICACION], Local_1.Direccion_Local AS [HIJO DIRECCION LOCAL], 
                         dbo.TIPO_RELACION_ELEMENTO_CONFIGURACION.NOMBRE_TIPO_RELA AS [TIPO RELACION], P.NRO_SERIE AS [PADRE NRO SERIE], 
                         C.NRO_SERIE AS [HIJO NRO SERIE], P.FABRICANTE_O_PROVEEDOR AS [PADRE FABICANTE / PROVEEDOR], 
                         C.FABRICANTE_O_PROVEEDOR AS [HIJO FABRICANTE / PROVEEDOR], P.IP AS [PADRE IP], P.GATEWAY AS [PADRE GATEWAY], C.IP AS [HIJO IP], 
                         C.GATEWAY AS [HIJO GATEWAY], P.GRUPO_TRABAJO AS [PADRE GRUPO TRABAJO], C.GRUPO_TRABAJO AS [HIJO GRUPO TRABAJO]
FROM            dbo.RELACION_ELEMENTO_CONFIGURACION AS R INNER JOIN
                         dbo.ELEMENTOS_CONFIGURACION AS P ON R.ELEMENTO_CONFIGURACION_PADRE = P.ID_ELEMENTO_CONFIGURACION INNER JOIN
                         dbo.ELEMENTOS_CONFIGURACION AS C ON R.ELEMENTO_CONFIGURACION_HIJO = C.ID_ELEMENTO_CONFIGURACION INNER JOIN
                         dbo.TIPO_RELACION_ELEMENTO_CONFIGURACION ON 
                         R.COD_TIPO_RELA = dbo.TIPO_RELACION_ELEMENTO_CONFIGURACION.COD_TIPO_RELA INNER JOIN
                         dbo.TIPOS_ELEMENTO_CONFIGURACION ON P.ID_TIPO = dbo.TIPOS_ELEMENTO_CONFIGURACION.ID_TIPO INNER JOIN
                         dbo.TIPOS_ELEMENTO_CONFIGURACION AS TIPOS_ELEMENTO_CONFIGURACION_1 ON 
                         C.ID_TIPO = TIPOS_ELEMENTO_CONFIGURACION_1.ID_TIPO INNER JOIN
                         dbo.ESTADO_ELEMENTO_CONFIGURACION ON P.ID_ESTADO = dbo.ESTADO_ELEMENTO_CONFIGURACION.ID_ESTADO INNER JOIN
                         dbo.ESTADO_ELEMENTO_CONFIGURACION AS ESTADO_ELEMENTO_CONFIGURACION_1 ON 
                         C.ID_ESTADO = ESTADO_ELEMENTO_CONFIGURACION_1.ID_ESTADO INNER JOIN
                         dbo.Personal ON P.PROPIETARIO = dbo.Personal.Id_Personal INNER JOIN
                         dbo.Personal AS Personal_1 ON C.PROPIETARIO = Personal_1.Id_Personal INNER JOIN
                         dbo.[DESCRIPCION_ELEMENTO CONFIGURACION] ON P.ID_DESCRIPCION = dbo.[DESCRIPCION_ELEMENTO CONFIGURACION].ID_DESCRIPCION INNER JOIN
                         dbo.[DESCRIPCION_ELEMENTO CONFIGURACION] AS [DESCRIPCION_ELEMENTO CONFIGURACION_1] ON 
                         C.ID_DESCRIPCION = [DESCRIPCION_ELEMENTO CONFIGURACION_1].ID_DESCRIPCION INNER JOIN
                         dbo.NIVEL_PRIORIDAD ON P.ID_NIVEL = dbo.NIVEL_PRIORIDAD.ID_NIVEL INNER JOIN
                         dbo.NIVEL_PRIORIDAD AS NIVEL_PRIORIDAD_1 ON C.ID_NIVEL = NIVEL_PRIORIDAD_1.ID_NIVEL INNER JOIN
                         dbo.Area ON P.LOCALIZACION_FISICA = dbo.Area.Id_Area INNER JOIN
                         dbo.Local ON dbo.Area.Id_Local = dbo.Local.Id_Local INNER JOIN
                         dbo.Sede ON dbo.Local.Id_Sede = dbo.Sede.Id_Sede INNER JOIN
                         dbo.Ubigeo ON dbo.Local.Cod_Ubi = dbo.Ubigeo.Cod_Ubi INNER JOIN
                         dbo.Area AS Area_1 ON C.LOCALIZACION_FISICA = Area_1.Id_Area INNER JOIN
                         dbo.Local AS Local_1 ON Area_1.Id_Local = Local_1.Id_Local INNER JOIN
                         dbo.Sede AS Sede_1 ON Local_1.Id_Sede = Sede_1.Id_Sede INNER JOIN
                         dbo.Ubigeo AS Ubigeo_1 ON Local_1.Cod_Ubi = Ubigeo_1.Cod_Ubi
WHERE        (TIPOS_ELEMENTO_CONFIGURACION_1.NOMBRE_TIPO = 'SERVICIOS AL CIUDADANO') OR
                         (TIPOS_ELEMENTO_CONFIGURACION_1.NOMBRE_TIPO = 'SERVICIOS AL PROFESIONAL')





GO
/****** Objeto: View [dbo].[VISTA_RELACION_CI_CON_OTROS_CIS] Fecha de script: 18/05/2026 10:08:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VISTA_RELACION_CI_CON_OTROS_CIS]
AS
SELECT        R.ID_RELACION, P.ID_ELEMENTO_CONFIGURACION AS [PADRE ID], P.NOMBRE_ELEMENTO_CONFIGURACION AS [PADRE CI], 
                         dbo.TIPOS_ELEMENTO_CONFIGURACION.NOMBRE_TIPO AS [PADRE TIPO CI], 
                         dbo.ESTADO_ELEMENTO_CONFIGURACION.NOMBRE_ESTADO AS [PADRE ESTADO CI], 
                         dbo.Personal.Nombre_Personal + ' ' + dbo.Personal.ApePat_Personal + ' ' + dbo.Personal.ApeMat_Personal AS [PADRE PROPIETARIO CI], 
                         dbo.[DESCRIPCION_ELEMENTO CONFIGURACION].NOMBRE_DESCRIPCION AS [PADRE DESCRIPCION CI], 
                         dbo.NIVEL_PRIORIDAD.NOMBRE_NIVEL AS [PADRE NIVEL PRIORIDAD], dbo.Sede.Descripcion_Sede AS [PADRE SEDE], 
                         dbo.Local.Nombre_Local AS [PADRE LOCAL], dbo.Area.Descripcion_Area AS [PADRE AREA], dbo.Area.Nro_Piso AS [PADRE NRO PISO], 
                         dbo.Area.Nro_Ambiente AS [PADRE NRO AMBIENTE], dbo.Ubigeo.Distrito + ' ' + dbo.Ubigeo.Provincia + ' ' + dbo.Ubigeo.Departamento AS [PADRE UBICACION],
                          dbo.Local.Direccion_Local AS [PADRE DIRECCION LOCAL], C.ID_ELEMENTO_CONFIGURACION AS [HIJO ID], 
                         C.NOMBRE_ELEMENTO_CONFIGURACION AS [HIJO CI], TIPOS_ELEMENTO_CONFIGURACION_1.NOMBRE_TIPO AS [HIJO TIPO CI], 
                         ESTADO_ELEMENTO_CONFIGURACION_1.NOMBRE_ESTADO AS [HIJO ESTADO CI], 
                         Personal_1.Nombre_Personal + ' ' + Personal_1.ApePat_Personal + ' ' + Personal_1.ApeMat_Personal AS [HIJO PROPIETARIO CI], 
                         [DESCRIPCION_ELEMENTO CONFIGURACION_1].NOMBRE_DESCRIPCION AS [HIJO DESCRIPCION CI], 
                         NIVEL_PRIORIDAD_1.NOMBRE_NIVEL AS [HIJO NIVEL PRIORIDAD], Sede_1.Descripcion_Sede AS [HIJO SEDE], Local_1.Nombre_Local AS [HIJO LOCAL], 
                         Area_1.Descripcion_Area AS [HIJO AREA], Area_1.Nro_Piso AS [HIJO NRO PISO], Area_1.Nro_Ambiente AS [HIJO NRO AMBIENTE], 
                         Ubigeo_1.Distrito + ' ' + Ubigeo_1.Provincia + ' ' + Ubigeo_1.Departamento AS [HIJO UBICACION], Local_1.Direccion_Local AS [HIJO DIRECCION LOCAL], 
                         dbo.TIPO_RELACION_ELEMENTO_CONFIGURACION.NOMBRE_TIPO_RELA AS [TIPO RELACION], P.NRO_SERIE AS [PADRE NRO SERIE], 
                         C.NRO_SERIE AS [HIJO NRO SERIE], dbo.MARCA.NOMBRE AS [PADRE MARCA], MARCA_1.NOMBRE AS [HIJO MARCA], 
                         dbo.MODELO.NOMBRE AS [PADRE MODELO], MODELO_1.NOMBRE AS [HIJO MODELO], 
                         P.FABRICANTE_O_PROVEEDOR AS [PADRE FABRICANTE / PROVEEDOR], C.FABRICANTE_O_PROVEEDOR AS [HIJO FABRICANTE / PROVEEDOR]
FROM            dbo.RELACION_ELEMENTO_CONFIGURACION AS R INNER JOIN
                         dbo.ELEMENTOS_CONFIGURACION AS P ON R.ELEMENTO_CONFIGURACION_PADRE = P.ID_ELEMENTO_CONFIGURACION INNER JOIN
                         dbo.ELEMENTOS_CONFIGURACION AS C ON R.ELEMENTO_CONFIGURACION_HIJO = C.ID_ELEMENTO_CONFIGURACION INNER JOIN
                         dbo.TIPO_RELACION_ELEMENTO_CONFIGURACION ON 
                         R.COD_TIPO_RELA = dbo.TIPO_RELACION_ELEMENTO_CONFIGURACION.COD_TIPO_RELA INNER JOIN
                         dbo.TIPOS_ELEMENTO_CONFIGURACION ON P.ID_TIPO = dbo.TIPOS_ELEMENTO_CONFIGURACION.ID_TIPO INNER JOIN
                         dbo.TIPOS_ELEMENTO_CONFIGURACION AS TIPOS_ELEMENTO_CONFIGURACION_1 ON 
                         C.ID_TIPO = TIPOS_ELEMENTO_CONFIGURACION_1.ID_TIPO INNER JOIN
                         dbo.ESTADO_ELEMENTO_CONFIGURACION ON P.ID_ESTADO = dbo.ESTADO_ELEMENTO_CONFIGURACION.ID_ESTADO INNER JOIN
                         dbo.ESTADO_ELEMENTO_CONFIGURACION AS ESTADO_ELEMENTO_CONFIGURACION_1 ON 
                         C.ID_ESTADO = ESTADO_ELEMENTO_CONFIGURACION_1.ID_ESTADO INNER JOIN
                         dbo.Personal ON P.PROPIETARIO = dbo.Personal.Id_Personal INNER JOIN
                         dbo.Personal AS Personal_1 ON C.PROPIETARIO = Personal_1.Id_Personal INNER JOIN
                         dbo.[DESCRIPCION_ELEMENTO CONFIGURACION] ON P.ID_DESCRIPCION = dbo.[DESCRIPCION_ELEMENTO CONFIGURACION].ID_DESCRIPCION INNER JOIN
                         dbo.[DESCRIPCION_ELEMENTO CONFIGURACION] AS [DESCRIPCION_ELEMENTO CONFIGURACION_1] ON 
                         C.ID_DESCRIPCION = [DESCRIPCION_ELEMENTO CONFIGURACION_1].ID_DESCRIPCION INNER JOIN
                         dbo.NIVEL_PRIORIDAD ON P.ID_NIVEL = dbo.NIVEL_PRIORIDAD.ID_NIVEL INNER JOIN
                         dbo.NIVEL_PRIORIDAD AS NIVEL_PRIORIDAD_1 ON C.ID_NIVEL = NIVEL_PRIORIDAD_1.ID_NIVEL INNER JOIN
                         dbo.Area ON P.LOCALIZACION_FISICA = dbo.Area.Id_Area INNER JOIN
                         dbo.Local ON dbo.Area.Id_Local = dbo.Local.Id_Local INNER JOIN
                         dbo.Sede ON dbo.Local.Id_Sede = dbo.Sede.Id_Sede INNER JOIN
                         dbo.Ubigeo ON dbo.Local.Cod_Ubi = dbo.Ubigeo.Cod_Ubi INNER JOIN
                         dbo.Area AS Area_1 ON C.LOCALIZACION_FISICA = Area_1.Id_Area INNER JOIN
                         dbo.Local AS Local_1 ON Area_1.Id_Local = Local_1.Id_Local INNER JOIN
                         dbo.Sede AS Sede_1 ON Local_1.Id_Sede = Sede_1.Id_Sede INNER JOIN
                         dbo.Ubigeo AS Ubigeo_1 ON Local_1.Cod_Ubi = Ubigeo_1.Cod_Ubi INNER JOIN
                         dbo.MARCA ON P.ID_MAR = dbo.MARCA.ID_MAR INNER JOIN
                         dbo.MARCA AS MARCA_1 ON C.ID_MAR = MARCA_1.ID_MAR INNER JOIN
                         dbo.MODELO ON P.ID_MOD = dbo.MODELO.ID_MOD INNER JOIN
                         dbo.MODELO AS MODELO_1 ON C.ID_MOD = MODELO_1.ID_MOD





GO
/****** Objeto: View [dbo].[VISTA_RELACION_ELEMENTOS_CONFIGURACION] Fecha de script: 18/05/2026 10:08:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VISTA_RELACION_ELEMENTOS_CONFIGURACION]
AS
SELECT        R.ID_RELACION, P.ID_ELEMENTO_CONFIGURACION AS [PADRE ID], P.NOMBRE_ELEMENTO_CONFIGURACION AS [PADRE CI], 
                         dbo.TIPOS_ELEMENTO_CONFIGURACION.NOMBRE_TIPO AS [PADRE TIPO CI], 
                         dbo.ESTADO_ELEMENTO_CONFIGURACION.NOMBRE_ESTADO AS [PADRE ESTADO CI], 
                         dbo.Personal.Nombre_Personal + ' ' + dbo.Personal.ApePat_Personal + ' ' + dbo.Personal.ApeMat_Personal AS [PADRE PROPIETARIO CI], 
                         dbo.[DESCRIPCION_ELEMENTO CONFIGURACION].NOMBRE_DESCRIPCION AS [PADRE DESCRIPCION CI], 
                         dbo.NIVEL_PRIORIDAD.NOMBRE_NIVEL AS [PADRE NIVEL PRIORIDAD], dbo.Sede.Descripcion_Sede AS [PADRE SEDE], 
                         dbo.Local.Nombre_Local AS [PADRE LOCAL], dbo.Area.Descripcion_Area AS [PADRE AREA], dbo.Area.Nro_Piso AS [PADRE NRO PISO], 
                         dbo.Area.Nro_Ambiente AS [PADRE NRO AMBIENTE], dbo.Ubigeo.Distrito + ' ' + dbo.Ubigeo.Provincia + ' ' + dbo.Ubigeo.Departamento AS [PADRE UBICACION],
                          dbo.Local.Direccion_Local AS [PADRE DIRECCION LOCAL], C.ID_ELEMENTO_CONFIGURACION AS [HIJO ID], 
                         C.NOMBRE_ELEMENTO_CONFIGURACION AS [HIJO CI], TIPOS_ELEMENTO_CONFIGURACION_1.NOMBRE_TIPO AS [HIJO TIPO CI], 
                         ESTADO_ELEMENTO_CONFIGURACION_1.NOMBRE_ESTADO AS [HIJO ESTADO CI], 
                         Personal_1.Nombre_Personal + ' ' + Personal_1.ApePat_Personal + ' ' + Personal_1.ApeMat_Personal AS [HIJO PROPIETARIO CI], 
                         [DESCRIPCION_ELEMENTO CONFIGURACION_1].NOMBRE_DESCRIPCION AS [HIJO DESCRIPCION CI], 
                         NIVEL_PRIORIDAD_1.NOMBRE_NIVEL AS [HIJO NIVEL PRIORIDAD], Sede_1.Descripcion_Sede AS [HIJO SEDE], Local_1.Nombre_Local AS [HIJO LOCAL], 
                         Area_1.Descripcion_Area AS [HIJO AREA], Area_1.Nro_Piso AS [HIJO NRO PISO], Area_1.Nro_Ambiente AS [HIJO NRO AMBIENTE], 
                         Ubigeo_1.Distrito + ' ' + Ubigeo_1.Provincia + ' ' + Ubigeo_1.Departamento AS [HIJO UBICACION], Local_1.Direccion_Local AS [HIJO DIRECCION LOCAL], 
                         dbo.TIPO_RELACION_ELEMENTO_CONFIGURACION.NOMBRE_TIPO_RELA AS [TIPO RELACION], P.NRO_SERIE AS [PADRE NRO SERIE], 
                         C.NRO_SERIE AS [HIJO NRO SERIE], P.FABRICANTE_O_PROVEEDOR AS [PADRE FABICANTE / PROVEEDOR], 
                         C.FABRICANTE_O_PROVEEDOR AS [HIJO FABRICANTE / PROVEEDOR], P.IP AS [PADRE IP], P.GATEWAY AS [PADRE GATEWAY], C.IP AS [HIJO IP], 
                         C.GATEWAY AS [HIJO GATEWAY], P.GRUPO_TRABAJO AS [PADRE GRUPO TRABAJO], C.GRUPO_TRABAJO AS [HIJO GRUPO TRABAJO]
FROM            dbo.RELACION_ELEMENTO_CONFIGURACION AS R INNER JOIN
                         dbo.ELEMENTOS_CONFIGURACION AS P ON R.ELEMENTO_CONFIGURACION_PADRE = P.ID_ELEMENTO_CONFIGURACION INNER JOIN
                         dbo.ELEMENTOS_CONFIGURACION AS C ON R.ELEMENTO_CONFIGURACION_HIJO = C.ID_ELEMENTO_CONFIGURACION INNER JOIN
                         dbo.TIPO_RELACION_ELEMENTO_CONFIGURACION ON 
                         R.COD_TIPO_RELA = dbo.TIPO_RELACION_ELEMENTO_CONFIGURACION.COD_TIPO_RELA INNER JOIN
                         dbo.TIPOS_ELEMENTO_CONFIGURACION ON P.ID_TIPO = dbo.TIPOS_ELEMENTO_CONFIGURACION.ID_TIPO INNER JOIN
                         dbo.TIPOS_ELEMENTO_CONFIGURACION AS TIPOS_ELEMENTO_CONFIGURACION_1 ON 
                         C.ID_TIPO = TIPOS_ELEMENTO_CONFIGURACION_1.ID_TIPO INNER JOIN
                         dbo.ESTADO_ELEMENTO_CONFIGURACION ON P.ID_ESTADO = dbo.ESTADO_ELEMENTO_CONFIGURACION.ID_ESTADO INNER JOIN
                         dbo.ESTADO_ELEMENTO_CONFIGURACION AS ESTADO_ELEMENTO_CONFIGURACION_1 ON 
                         C.ID_ESTADO = ESTADO_ELEMENTO_CONFIGURACION_1.ID_ESTADO INNER JOIN
                         dbo.Personal ON P.PROPIETARIO = dbo.Personal.Id_Personal INNER JOIN
                         dbo.Personal AS Personal_1 ON C.PROPIETARIO = Personal_1.Id_Personal INNER JOIN
                         dbo.[DESCRIPCION_ELEMENTO CONFIGURACION] ON P.ID_DESCRIPCION = dbo.[DESCRIPCION_ELEMENTO CONFIGURACION].ID_DESCRIPCION INNER JOIN
                         dbo.[DESCRIPCION_ELEMENTO CONFIGURACION] AS [DESCRIPCION_ELEMENTO CONFIGURACION_1] ON 
                         C.ID_DESCRIPCION = [DESCRIPCION_ELEMENTO CONFIGURACION_1].ID_DESCRIPCION INNER JOIN
                         dbo.NIVEL_PRIORIDAD ON P.ID_NIVEL = dbo.NIVEL_PRIORIDAD.ID_NIVEL INNER JOIN
                         dbo.NIVEL_PRIORIDAD AS NIVEL_PRIORIDAD_1 ON C.ID_NIVEL = NIVEL_PRIORIDAD_1.ID_NIVEL INNER JOIN
                         dbo.Area ON P.LOCALIZACION_FISICA = dbo.Area.Id_Area INNER JOIN
                         dbo.Local ON dbo.Area.Id_Local = dbo.Local.Id_Local INNER JOIN
                         dbo.Sede ON dbo.Local.Id_Sede = dbo.Sede.Id_Sede INNER JOIN
                         dbo.Ubigeo ON dbo.Local.Cod_Ubi = dbo.Ubigeo.Cod_Ubi INNER JOIN
                         dbo.Area AS Area_1 ON C.LOCALIZACION_FISICA = Area_1.Id_Area INNER JOIN
                         dbo.Local AS Local_1 ON Area_1.Id_Local = Local_1.Id_Local INNER JOIN
                         dbo.Sede AS Sede_1 ON Local_1.Id_Sede = Sede_1.Id_Sede INNER JOIN
                         dbo.Ubigeo AS Ubigeo_1 ON Local_1.Cod_Ubi = Ubigeo_1.Cod_Ubi





GO
/****** Objeto: View [dbo].[VISTA_REPORTE_ELEMENTOS_CONFIGURACION] Fecha de script: 18/05/2026 10:08:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VISTA_REPORTE_ELEMENTOS_CONFIGURACION]
AS
SELECT        dbo.ELEMENTOS_CONFIGURACION.ID_ELEMENTO_CONFIGURACION AS [ID CI], dbo.ELEMENTOS_CONFIGURACION.NOMBRE_ELEMENTO_CONFIGURACION AS [NOMBRE CI], 
                         dbo.TIPOS_ELEMENTO_CONFIGURACION.NOMBRE_TIPO AS [NOMBRE TIPO CI], dbo.ESTADO_ELEMENTO_CONFIGURACION.NOMBRE_ESTADO AS [ESTADO CI], 
                         dbo.Personal.Nombre_Personal + ' ' + dbo.Personal.ApePat_Personal + ' ' + dbo.Personal.ApeMat_Personal AS PROPIETARIO, dbo.[DESCRIPCION_ELEMENTO CONFIGURACION].NOMBRE_DESCRIPCION AS [DESCRIPCION CI], 
                         dbo.IMPACTO_COMERCIAL_ELE_CONF_HAR.NOMBRE AS [IMPACTO CI], dbo.Sede.Descripcion_Sede AS SEDE, dbo.Local.Nombre_Local AS LOCAL, 
                         dbo.Ubigeo.Distrito + '/ ' + dbo.Ubigeo.Provincia + ' /' + dbo.Ubigeo.Departamento AS [UBICACION LOCAL], dbo.Local.Direccion_Local AS [DIRECCION LOCAL], dbo.Area.Descripcion_Area AS AREA, 
                         dbo.Area.Nro_Piso AS [NRO PISO], dbo.Area.Nro_Ambiente AS [NRO AMBIENTE], dbo.ELEMENTOS_CONFIGURACION.FECHA_REGISTRO AS [FEC. CREACION CI], 
                         dbo.Usuario.Nombre + ' ' + dbo.Usuario.ApePat + ' ' + dbo.Usuario.ApeMat AS RESPONSABLE, dbo.NIVEL_PRIORIDAD.NOMBRE_NIVEL AS [NIVEL PRIORIDAD], dbo.ELEMENTOS_CONFIGURACION.NRO_SERIE AS [NRO SERIE], 
                         dbo.ELEMENTOS_CONFIGURACION.FABRICANTE_O_PROVEEDOR AS [FABRICANTE / PROVEEDOR], dbo.MARCA.NOMBRE AS MARCA, dbo.MODELO.NOMBRE AS MODELO, dbo.ELEMENTOS_CONFIGURACION.IP, 
                         dbo.ELEMENTOS_CONFIGURACION.GATEWAY, dbo.ELEMENTOS_CONFIGURACION.GRUPO_TRABAJO AS [GRUPO TRABAJO]
FROM            dbo.ELEMENTOS_CONFIGURACION INNER JOIN
                         dbo.TIPOS_ELEMENTO_CONFIGURACION ON dbo.ELEMENTOS_CONFIGURACION.ID_TIPO = dbo.TIPOS_ELEMENTO_CONFIGURACION.ID_TIPO INNER JOIN
                         dbo.ESTADO_ELEMENTO_CONFIGURACION ON dbo.ELEMENTOS_CONFIGURACION.ID_ESTADO = dbo.ESTADO_ELEMENTO_CONFIGURACION.ID_ESTADO INNER JOIN
                         dbo.Personal ON dbo.ELEMENTOS_CONFIGURACION.PROPIETARIO = dbo.Personal.Id_Personal INNER JOIN
                         dbo.[DESCRIPCION_ELEMENTO CONFIGURACION] ON dbo.ELEMENTOS_CONFIGURACION.ID_DESCRIPCION = dbo.[DESCRIPCION_ELEMENTO CONFIGURACION].ID_DESCRIPCION INNER JOIN
                         dbo.IMPACTO_COMERCIAL_ELE_CONF_HAR ON dbo.ELEMENTOS_CONFIGURACION.ID_IMP_ELE_CONF_HAR = dbo.IMPACTO_COMERCIAL_ELE_CONF_HAR.ID_IMP_ELE_CONF_HAR INNER JOIN
                         dbo.Area ON dbo.ELEMENTOS_CONFIGURACION.LOCALIZACION_FISICA = dbo.Area.Id_Area INNER JOIN
                         dbo.Local ON dbo.Area.Id_Local = dbo.Local.Id_Local INNER JOIN
                         dbo.Sede ON dbo.Local.Id_Sede = dbo.Sede.Id_Sede INNER JOIN
                         dbo.Ubigeo ON dbo.Local.Cod_Ubi = dbo.Ubigeo.Cod_Ubi INNER JOIN
                         dbo.Usuario ON dbo.ELEMENTOS_CONFIGURACION.RESPONSABLE_REGISTRO = dbo.Usuario.Id_Uusario INNER JOIN
                         dbo.NIVEL_PRIORIDAD ON dbo.ELEMENTOS_CONFIGURACION.ID_NIVEL = dbo.NIVEL_PRIORIDAD.ID_NIVEL INNER JOIN
                         dbo.MARCA ON dbo.ELEMENTOS_CONFIGURACION.ID_MAR = dbo.MARCA.ID_MAR INNER JOIN
                         dbo.MODELO ON dbo.ELEMENTOS_CONFIGURACION.ID_MOD = dbo.MODELO.ID_MOD




GO
/****** Objeto: View [dbo].[VISTA_UBIGEO] Fecha de script: 18/05/2026 10:08:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VISTA_UBIGEO]
AS
SELECT        Cod_Ubi AS ID, Codigo AS CODIGO, Departamento AS DEPARTAMENTO, Provincia AS PROVINCIA, Distrito AS DISTRITO
FROM            dbo.Ubigeo





GO
/****** Objeto: Table [dbo].[autorizacion] Fecha de script: 18/05/2026 10:08:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[autorizacion](
	[id_autorizacion] [int] IDENTITY(1,1) NOT NULL,
	[id_formulario] [int] NOT NULL,
	[IDPer] [int] NOT NULL,
	[aprobacion_autorizacion] [bit] NOT NULL,
 CONSTRAINT [PK_autorizacion] PRIMARY KEY CLUSTERED 
(
	[id_autorizacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[derecho] Fecha de script: 18/05/2026 10:08:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[derecho](
	[id_derecho] [int] IDENTITY(1,1) NOT NULL,
	[nombre_derecho] [varchar](max) NOT NULL,
 CONSTRAINT [PK_derecho] PRIMARY KEY CLUSTERED 
(
	[id_derecho] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[DETALLE_ESTADO_ACTUAL_ELEMENTO_CONFIGURACION] Fecha de script: 18/05/2026 10:08:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
(
	[ID_ESTADO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[Local] Fecha de script: 18/05/2026 10:08:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Local](
	[Id_Local] [int] IDENTITY(1,1) NOT NULL,
	[Codigo_Local] [varchar](6) NOT NULL,
	[Nombre_Local] [varchar](50) NULL,
	[Direccion_Local] [varchar](50) NOT NULL,
	[Id_Sede] [int] NOT NULL,
	[Cod_Ubi] [varchar](9) NOT NULL,
	[Telefono_local] [varchar](9) NULL,
	[Pagnia_Web_Local] [varchar](max) NULL,
	[Email_Local] [varchar](max) NULL,
	[Total_CIS_Local] [int] NULL,
 CONSTRAINT [PK_Local_1] PRIMARY KEY CLUSTERED 
(
	[Id_Local] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[MARCA] Fecha de script: 18/05/2026 10:08:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MARCA](
