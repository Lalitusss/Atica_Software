USE GestionUsuarios;  
GO

-- Validar y eliminar tabla Usuarios si existe
IF OBJECT_ID('dbo.Usuarios', 'U') IS NOT NULL
BEGIN
    DROP TABLE dbo.Usuarios;
END
GO

-- Crear tabla Usuarios
CREATE TABLE Usuarios (
  Id INT IDENTITY PRIMARY KEY,
  Nombre NVARCHAR(100) NOT NULL,
  Email NVARCHAR(100) NOT NULL
);
GO

-- Validar y eliminar procedimiento sp_ObtenerUsuarios si existe
IF OBJECT_ID('dbo.sp_ObtenerUsuarios', 'P') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.sp_ObtenerUsuarios;
END
GO

-- Crear procedimiento sp_ObtenerUsuarios
CREATE PROCEDURE sp_ObtenerUsuarios
AS
BEGIN
  SET NOCOUNT OFF;
  SELECT Id, Nombre, Email FROM Usuarios;
END
GO

-- Validar y eliminar procedimiento sp_InsertarUsuario si existe
IF OBJECT_ID('dbo.sp_InsertarUsuario', 'P') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.sp_InsertarUsuario;
END
GO

-- Crear procedimiento sp_InsertarUsuario
CREATE PROCEDURE sp_InsertarUsuario
  @Nombre NVARCHAR(100),
  @Email NVARCHAR(100)
AS
BEGIN
  SET NOCOUNT OFF;
  INSERT INTO Usuarios(Nombre, Email) VALUES(@Nombre, @Email);
END
GO

-- Validar y eliminar procedimiento sp_EliminarUsuario si existe
IF OBJECT_ID('dbo.sp_EliminarUsuario', 'P') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.sp_EliminarUsuario;
END
GO

-- Crear procedimiento sp_EliminarUsuario
CREATE PROCEDURE sp_EliminarUsuario
  @Id INT
AS
BEGIN
  SET NOCOUNT OFF;
  DELETE FROM Usuarios WHERE Id = @Id;
END
GO
