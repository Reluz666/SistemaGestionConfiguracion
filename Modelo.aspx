<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Modelo.aspx.cs" Inherits="TiposElementoConfiguracion" UnobtrusiveValidationMode="None" %>
<%@ Register src="NavBar.ascx" tagname="NavBar" tagprefix="uc1" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>Modelo</title>

    <!-- Bootstrap 5.3 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet" />
    <!-- Global Styles -->
    <link href="CssJs/global-styles.css" rel="stylesheet" />

    <style>
        /* ===== PAGINACION MANUAL (Bootstrap-only, sin DataTables) ===== */
        .pagination-wrapper {
            display: flex;
            justify-content: center;
            margin-top: 1.5rem;
        }
    </style>

    <script lang="javascript" type="text/javascript">
        function MostrarMensaje() {
            var mensaje = document.getElementById("__mensaje").value;
            if (mensaje != "") {
                alert(mensaje);
                var pagina = document.getElementById("__pagina").value;
                if (pagina !== "") location.href = pagina;
            }
        }

        function Confirmar(men) {
            if (!confirm(men)) return false;
            return true;
        }

        function SoloNumeros() {
            if ((event.keyCode < 48) || (event.keyCode > 57)) event.returnValue = false;
        }

        function SoloLetrasMinusculas() {
            if (!((event.keyCode >= 97 && event.keyCode <= 122) || event.keyCode == 32
                || event.keyCode == 193 || event.keyCode == 201 || event.keyCode == 205
                || event.keyCode == 209 || event.keyCode == 211 || event.keyCode == 218
                || event.keyCode == 220 || event.keyCode == 241)) event.returnValue = false;
        }

        function CambiaLetraMayuscula(Caja) {
            document.getElementById(Caja).value = document.getElementById(Caja).value.toUpperCase();
        }
    </script>

    <!-- Scripts -->
    <script type="text/javascript" src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body onload="MostrarMensaje()">

    <uc1:NavBar ID="NavBar1" runat="server" />

    <!-- ========== CONTENT ========== -->
    <div class="top-spacer"></div>

    <form id="form1" runat="server">
        <div class="container">

            <!-- Card Formulario -->
            <div class="form-card">
                <div class="card-header">
                    <i class="bi bi-c-square-fill me-2"></i>Ingrese Datos Modelo Elemento Configuracion
                </div>
                <div class="card-body p-3">

                    <!-- Fila: Nombre Modelo -->
                    <div class="row g-2 mb-2">
                        <div class="col-12">
                            <label class="form-label-modern">Nombre Modelo</label>
                            <asp:TextBox ID="NOMBRE" runat="server" CssClass="form-control form-control-modern"
                                         MaxLength="100" Autocomplete="off" placeholder="Ingrese Nombre Modelo Elemento Configuracion"
                                         onchange="CambiaLetraMayuscula('NOMBRE')" onkeypress="SoloLetrasMinusculas()" />
                            <asp:RequiredFieldValidator ID="rfvNOMBRE" runat="server" ControlToValidate="NOMBRE"
                                                       ErrorMessage="*" CssClass="validator-error" />
                        </div>
                    </div>

                    <!-- Botones de accion -->
                    <div class="d-flex flex-wrap gap-2 justify-content-center">
                        <asp:Button ID="btnRegistrar" runat="server" Text="Registrar" CssClass="btn btn-success btn-modern"
                                    OnClick="btnRegistrar_Click"
                                    OnClientClick="return Confirmar('¿Desea registrar modelo?');" />
                        <asp:Button ID="btnModificar" runat="server" Text="Modificar" CssClass="btn btn-warning btn-modern"
                                    OnClick="btnModificar_Click"
                                    OnClientClick="return Confirmar('¿Desea modificar modelo?');" />
                        <asp:Button ID="btnEliminar" runat="server" Text="Eliminar" CssClass="btn btn-danger btn-modern"
                                    OnClick="btnEliminar_Click"
                                    OnClientClick="return Confirmar('¿Desea eliminar modelo?');" />
                        <asp:Button ID="btnCancelar" runat="server" Text="Cancelar" CssClass="btn btn-secondary btn-modern"
                                    OnClick="btnCancelar_Click" CausesValidation="False" />
                    </div>
                </div>
            </div>

            <!-- Tabla de Resultados -->
            <div class="table-wrapper">
                <asp:Table ID="Table_" runat="server" CssClass="table table-modern-grid table-hover">
                    <asp:TableRow ID="TableRow1" runat="server">
                        <asp:TableCell ID="tcID" runat="server" Visible="false">ID</asp:TableCell>
                        <asp:TableCell ID="tcNOMBRE" runat="server">NOMBRE</asp:TableCell>
                        <asp:TableCell ID="SELECCIONAR_MODELO" runat="server" HorizontalAlign="Center">SELECCIONAR</asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
            </div>

            <!-- Hidden Fields -->
            <asp:HiddenField ID="__mensaje" runat="server" />
            <asp:HiddenField ID="__pagina" runat="server" />
            <asp:HiddenField ID="ID_MOD" runat="server" Value="0" EnableViewState="False" />

        </div>
    </form>

</html>
