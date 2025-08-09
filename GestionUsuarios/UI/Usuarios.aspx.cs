using GestionUsuarios.BLL;
using GestionUsuarios.Entities;
using GestionUsuarios.Helpers;
using System;
using System.Data.SqlClient;
using System.Web.UI;

namespace GestionUsuarios.UI
{
    public partial class Default : Page
    {
        private UsuarioBLL bll = new UsuarioBLL();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try
                {
                    CargarUsuarios();
                    MostrarMensajeDesdeSession();

                }
                catch (SqlException)
                {
                    MostrarMensajeDB(Mensajes.ErrorConexionBD);
                }
            }
        }

        private void CargarUsuarios()
        {
            try
            {
                var usuarios = bll.ListarUsuarios();
                gvUsuarios.DataSource = usuarios;
                gvUsuarios.DataBind();

                if (usuarios != null && usuarios.Count > 0)
                    lblTotalRegistros.Text = Mensajes.TotalRegistros + usuarios.Count;
                else
                    lblTotalRegistros.Text = Mensajes.SinRegistros;
            }
            catch (SqlException)
            {
                MostrarMensajeDB(Mensajes.ErrorConexionBD);
            }
            catch (Exception ex)
            {
                MostrarMensaje($"<div class='alert alert-danger'>Error inesperado: {ex.Message}</div>");
            }
        }

        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            try
            {
                if (Page.IsValid)
                {
                    var usuario = new Usuario
                    {
                        Nombre = txtNombre.Text.Trim(),
                        Email = txtEmail.Text.Trim()
                    };

                    var resultado = bll.AgregarUsuario(usuario);

                    if (resultado.success)
                    {
                        Session["MensajeExito"] = $"<div class='alert alert-success'>{resultado.mensaje}</div>";
                        Response.Redirect(Request.RawUrl);
                    }
                    else
                    {
                        MostrarMensaje($"<div class='alert alert-danger'>{resultado.mensaje}</div>");
                    }
                }
            }
            catch (SqlException)
            {
                MostrarMensajeDB(Mensajes.ErrorConexionBD);
            }
            catch (Exception ex)
            {
                MostrarMensaje($"<div class='alert alert-danger'>Error inesperado: {ex.Message}</div>");
            }
        }

        protected void btnConfirmarEliminar_Click(object sender, EventArgs e)
        {
            try
            {
                if (int.TryParse(hiddenIdUsuarioEliminar.Value, out int id))
                {
                    var resultado = bll.EliminarUsuario(id);

                    if (resultado.success)
                    {
                        Session["MensajeExito"] = $"<div class='alert alert-success'>{resultado.mensaje}</div>";
                        Response.Redirect(Request.RawUrl);
                    }
                    else
                    {
                        MostrarMensaje($"<div class='alert alert-danger'>{resultado.mensaje}</div>");
                    }
                }
                else
                {
                    MostrarMensaje(Mensajes.UsuarioEliminadoOtroError);
                }
            }
            catch (SqlException)
            {
                MostrarMensajeDB(Mensajes.ErrorConexionBD);
            }
            catch (Exception ex)
            {
                MostrarMensaje($"<div class='alert alert-danger'>Error inesperado: {ex.Message}</div>");
            }
        }

        private void MostrarMensaje(string htmlMensaje)
        {
            pnlMensaje.Controls.Clear();
            pnlMensaje.Controls.Add(new LiteralControl(htmlMensaje));
            pnlMensaje.Visible = true;
        }

        private void MostrarMensajeDB(string htmlMensaje)
        {
            pnlDB.Controls.Clear();
            pnlDB.Controls.Add(new LiteralControl(htmlMensaje));
            pnlDB.Visible = true;
        }

        private void MostrarMensajeDesdeSession()
        {
            if (Session["MensajeExito"] != null)
            {
                MostrarMensaje(Session["MensajeExito"].ToString());
                Session.Remove("MensajeExito");
            }
            else
            {
                pnlMensaje.Visible = false;
                pnlMensaje.Controls.Clear();
            }
        }
    }
}
