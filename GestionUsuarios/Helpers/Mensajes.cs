using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GestionUsuarios.Helpers
{
    public static class Mensajes
    {
        public const string ErrorConexionBD = "<div class='alert alert-danger'>No se pudo conectar a la base de datos.</div>";

        public const string NombreObligatorio = "El nombre es obligatorio.";
        public const string EmailObligatorio = "El email es obligatorio.";

        public const string UsuarioAgregadoOk = "Usuario agregado correctamente.";
        public const string UsuarioAgregadoError = "Error al agregar usuario.";

        public const string UsuarioEliminadoOk = "Usuario eliminado correctamente.";
        public const string UsuarioEliminadoError = "Error al eliminar usuario.";
        public const string UsuarioEliminadoOtroError = "<div class='alert alert-warning'>No se pudo determinar el usuario a eliminar.</div>";


        public const string SinRegistros = "Total de registros: 0";
        public const string TotalRegistros = "Total de registros: ";
    }
}