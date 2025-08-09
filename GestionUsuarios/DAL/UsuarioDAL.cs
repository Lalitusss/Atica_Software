using GestionUsuarios.Entities;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace GestionUsuarios.DAL
{
    public class UsuarioDAL
    {
        private readonly string conexion = ConfigurationManager.ConnectionStrings["MiConexion"].ConnectionString;

        public List<Usuario> ObtenerUsuarios()
        {
            var lista = new List<Usuario>();
            using (SqlConnection con = new SqlConnection(conexion))
            using (SqlCommand cmd = new SqlCommand("sp_ObtenerUsuarios", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                con.Open();
                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    while (dr.Read())
                    {
                        lista.Add(new Usuario()
                        {
                            Id = Convert.ToInt32(dr["Id"]),
                            Nombre = dr["Nombre"].ToString(),
                            Email = dr["Email"].ToString()
                        });
                    }
                }
            }
            return lista;
        }

        public bool InsertarUsuario(Usuario usuario)
        {
            using (SqlConnection con = new SqlConnection(conexion))
            using (SqlCommand cmd = new SqlCommand("sp_InsertarUsuario", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Nombre", usuario.Nombre);
                cmd.Parameters.AddWithValue("@Email", usuario.Email);
                con.Open();
                int filas = cmd.ExecuteNonQuery();
                return filas > 0;
            }
        }

        public bool EliminarUsuario(int id)
        {
            using (SqlConnection con = new SqlConnection(conexion))
            using (SqlCommand cmd = new SqlCommand("sp_EliminarUsuario", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Id", id);
                con.Open();
                int filas = cmd.ExecuteNonQuery();
                return filas > 0;
            }
        }
    }
}
