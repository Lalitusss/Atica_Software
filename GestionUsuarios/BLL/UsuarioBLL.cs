using GestionUsuarios.DAL;
using GestionUsuarios.Entities;
using GestionUsuarios.Helpers;
using System.Collections.Generic;

namespace GestionUsuarios.BLL
{
    public class UsuarioBLL
    {
        private UsuarioDAL dal = new UsuarioDAL();

        public List<Usuario> ListarUsuarios()
        {
            return dal.ObtenerUsuarios();
        }

        public (bool success, string mensaje) AgregarUsuario(Usuario u)
        {
            if (string.IsNullOrWhiteSpace(u.Nombre))
                return (false, Mensajes.NombreObligatorio);

            if (string.IsNullOrWhiteSpace(u.Email))
                return (false, Mensajes.EmailObligatorio);

            // Aquí podrías agregar validaciones extra para email válido, etc.

            var resultado = dal.InsertarUsuario(u);

            return resultado
                ? (true, Mensajes.UsuarioAgregadoOk)
                : (false, Mensajes.UsuarioAgregadoError);
        }

        public (bool success, string mensaje) EliminarUsuario(int id)
        {
            var resultado = dal.EliminarUsuario(id);
            return resultado
                ? (true, Mensajes.UsuarioEliminadoOk)
                : (false, Mensajes.UsuarioEliminadoError);
        }
    }
}
