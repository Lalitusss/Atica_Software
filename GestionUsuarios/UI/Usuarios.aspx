<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Usuarios.aspx.cs" Inherits="GestionUsuarios.UI.Default" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Gestión de Usuarios</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" />
    <link href="../Content/EstilosUsuarios.css" rel="stylesheet" />
</head>

<body>
    <form id="form1" runat="server" class="container mt-5">
        <h2 style="text-align: center;">Gestión de Usuarios</h2>

        <!-- Panel de mensajes -->
        <asp:Panel ID="pnlMensaje" runat="server" CssClass="mt-2" Visible="false"></asp:Panel>
        <asp:Panel ID="pnlDB" runat="server" CssClass="mt-2" Visible="false"></asp:Panel>

        <!-- Contenedor flex para botón y buscador -->
        <div class="d-flex justify-content-between align-items-center mb-3">
            <button type="button" class="btn btn-primary btn-sm" data-toggle="modal" data-target="#modalAgregarUsuario">
                Nuevo Usuario
            </button>
            <input type="text" id="txtBuscar" class="form-control form-control-sm" placeholder="Buscar en toda la tabla..." />
        </div>

        <!-- Modal Agregar Usuario -->
        <div class="modal fade" id="modalAgregarUsuario" tabindex="-1" role="dialog" aria-labelledby="modalAgregarUsuarioLabel" aria-hidden="true">
            <div class="modal-dialog modal-sm" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="modalAgregarUsuarioLabel">Agregar Nuevo Usuario</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Cerrar">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <asp:Label ID="lblNombre" runat="server" Text="Nombre" AssociatedControlID="txtNombre" CssClass="form-label" />
                            <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" />
                            <asp:RequiredFieldValidator ID="rfvNombre" runat="server" ControlToValidate="txtNombre"
                                ErrorMessage="* Obligatorio" ForeColor="red" Display="Dynamic" CssClass="invalid-feedback" />
                        </div>
                        <div class="form-group">
                            <asp:Label ID="lblEmail" runat="server" Text="Email" AssociatedControlID="txtEmail" CssClass="form-label" />
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" />
                            <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail"
                                ErrorMessage="* Obligatorio" ForeColor="red" Display="Dynamic" CssClass="invalid-feedback" />
                            <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail"
                                ErrorMessage="Email inválido" ForeColor="red" Display="Dynamic"
                                ValidationExpression="^[^\s@]+@[^\s@]+\.[^\s@]+$" CssClass="invalid-feedback" />
                        </div>
                    </div>
                    <div class="modal-footer">
                        <asp:Button ID="btnAgregar" runat="server" Text="Agregar Usuario" CssClass="btn btn-primary btn-sm" OnClick="btnAgregar_Click" />
                        <button type="button" class="btn btn-secondary btn-sm" data-dismiss="modal" onclick="location.reload();">Cancelar</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Contenedor scroll y tabla -->
        <div class="table-wrapper mb-1">
            <asp:GridView ID="gvUsuarios" runat="server" CssClass="table table-bordered table-striped"
                AutoGenerateColumns="False" DataKeyNames="Id">
                <Columns>
                    <asp:BoundField DataField="Id" HeaderText="ID" ReadOnly="True" />
                    <asp:BoundField DataField="Nombre" HeaderText="Nombre" />
                    <asp:BoundField DataField="Email" HeaderText="Email" />
                    <asp:TemplateField>
                        <ItemTemplate>
                            <button type="button" class="btn btn-danger btn-sm btnEliminarUsuario"
                                data-toggle="modal" data-target="#modalConfirmarEliminar"
                                data-id='<%# Eval("Id") %>'
                                data-nombre='<%# Eval("Nombre") %>'>
                                Eliminar
                            </button>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <EmptyDataTemplate>
                    <div class="alert alert-info text-center m-0 p-2">
                        Sin datos o sin registros disponibles.
                    </div>
                </EmptyDataTemplate>
            </asp:GridView>
        </div>

        <!-- Contador total registros debajo de la tabla -->
        <div class="mb-3">
            <asp:Label ID="lblTotalRegistros" runat="server" CssClass="text-muted"></asp:Label>
        </div>

        <!-- Modal Confirmación Eliminar -->
        <div class="modal fade" id="modalConfirmarEliminar" tabindex="-1" role="dialog" aria-labelledby="modalConfirmarEliminarLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Confirmar eliminación</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Cerrar">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body" id="confirmacionTextoEliminar" style="padding-top: 0.75rem; padding-bottom: 0.75rem;">
                        <div style="text-align: center;">
                            <p style="font-weight: 500; font-size: 1rem; margin: 0 0 0.25rem 0;">
                                ¿Desea eliminar el usuario?
                            </p>
                            <p style="font-weight: 700; font-size: 1.1rem; margin: 0; color: #b02a37;">
                                <span id="nombreUsuarioEliminar"></span>
                            </p>
                        </div>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary btn-sm" data-dismiss="modal">Cancelar</button>
                        <asp:Button ID="btnConfirmarEliminar" runat="server" CssClass="btn btn-danger btn-sm"
                            Text="Eliminar" OnClick="btnConfirmarEliminar_Click" CausesValidation="false" />
                        <asp:HiddenField ID="hiddenIdUsuarioEliminar" runat="server" />
                    </div>
                </div>
            </div>
        </div>

    </form>

    <!-- Scripts necesario para Bootstrap -->
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script>
        var gvUsuariosClientID = '<%= gvUsuarios.ClientID %>';
        var lblTotalRegistrosClientID = '<%= lblTotalRegistros.ClientID %>';
        var hiddenIdUsuarioEliminarClientID = '<%= hiddenIdUsuarioEliminar.ClientID %>';
        var pnlMensajeClientID = '<%= pnlMensaje.ClientID %>';
    </script>
    <script src="../Scripts/ScriptsUsuarios.js"></script>
</body>
</html>
