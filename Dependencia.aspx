<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Dependencia.aspx.cs" Inherits="TiposElementoConfiguracion" UnobtrusiveValidationMode="None" %>
<%@ Register src="NavBar.ascx" tagname="NavBar" tagprefix="uc1" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>Dependencia</title>

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
                if (document.getElementById("__pagina").value != "")
                    location.href = document.getElementById("__pagina").value;

            }

        }

        function window_load() {
            MostrarMensaje()
        }

        function Confirmar(men) {
            if (!confirm(men))
                return false;

        }

        function SoloNumeros() {
            if ((event.keyCode < 48) || (event.keyCode > 57)) {
                event.returnValue = false;
         }
        }

        function SoloLetrasMinusculas() {
            if (!((event.keyCode >= 97 && event.keyCode <= 122) || event.keyCode == 32 || event.keyCode == 193 || event.keyCode == 201 || event.keyCode == 205 || event.keyCode == 209 || event.keyCode == 211 || event.keyCode == 218 || event.keyCode == 220 || event.keyCode == 241)) {
                event.returnValue = false;
            }
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
                    <i class="bi bi-building me-2"></i>Ingrese Datos Dependencia
                </div>
                <div class="card-body p-3">

                    <!-- Fila 1: Codigo Dependencia -->
                    <div class="row g-2 mb-2">
                        <div class="col-md-6 col-sm-6">
                            <label class="form-label-modern">C&oacute;digo Dependencia</label>
                            <asp:TextBox ID="Codigo_Depemdencia" runat="server" CssClass="form-control form-control-modern"
                                         MaxLength="4" Autocomplete="off" placeholder="Ingrese c&oacute;digo dependencia"
                                         onkeypress="SoloNumeros()" />
                            <asp:RequiredFieldValidator ID="rfvCodigo_Depemdencia" runat="server" ControlToValidate="Codigo_Depemdencia"
                                                       ErrorMessage="*" CssClass="validator-error" />
                        </div>
                    </div>

                    <!-- Fila 2: Nombre Dependencia -->
                    <div class="row g-3 mb-4">
                        <div class="col-md-6 col-sm-6">
                            <label class="form-label-modern">Nombre Dependencia</label>
                            <asp:TextBox ID="Nombre_Dependencia" runat="server" CssClass="form-control form-control-modern"
                                         MaxLength="999" Autocomplete="off" placeholder="Ingrese nombre dependencia"
                                         onchange="CambiaLetraMayuscula('Nombre_Dependencia')"
                                         onkeypress="SoloLetrasMinusculas()" />
                            <asp:RequiredFieldValidator ID="rfvNombre_Dependencia" runat="server" ControlToValidate="Nombre_Dependencia"
                                                       ErrorMessage="*" CssClass="validator-error" />
                        </div>
                    </div>

                    <!-- Botones de acci&oacute;n -->
                    <div class="d-flex flex-wrap gap-2 justify-content-center">
                        <asp:Button ID="btnRegistrar" runat="server" Text="Registrar" CssClass="btn btn-success btn-modern"
                                    OnClick="btnRegistrar_Click"
                                    OnClientClick="return Confirmar('¿Desea registrar dependencia?');" />
                        <asp:Button ID="btnModificar" runat="server" Text="Modificar" CssClass="btn btn-warning btn-modern"
                                    OnClick="btnModificar_Click"
                                    OnClientClick="return Confirmar('¿Desea modificar dependencia?');" />
                        <asp:Button ID="btnEliminar" runat="server" Text="Eliminar" CssClass="btn btn-danger btn-modern"
                                    OnClick="btnEliminar_Click"
                                    OnClientClick="return Confirmar('¿Desea eliminar dependencia?');" />
                        <asp:Button ID="btnCancelar" runat="server" Text="Cancelar" CssClass="btn btn-secondary btn-modern"
                                    OnClick="btnCancelar_Click" CausesValidation="False" />
                    </div>
                </div>
            </div>

            <!-- Tabla de Resultados -->
            <div class="table-wrapper">
                <asp:Table ID="Table_" runat="server" CssClass="table table-modern-grid table-hover">
                    <asp:TableRow ID="TableRow1" runat="server">
                        <asp:TableCell ID="tcID" runat="server" BackColor="Black" BorderColor="Black"
                            ForeColor="White" Width="7%" Visible="false">ID</asp:TableCell>
                        <asp:TableCell ID="tcCodigo_Depemdenciae" runat="server" BackColor="Black" BorderColor="Black"
                            ForeColor="White" Width="10%">CODIGO DEPENDENCIA</asp:TableCell>
                        <asp:TableCell ID="tcNombre_Dependencia" runat="server" BackColor="Black" BorderColor="Black"
                            ForeColor="White" Width="60%">NOMBRE DEPENDENCIA</asp:TableCell>
                        <asp:TableCell ID="SELECCIONAR_DEPENDENCIA" runat="server" BackColor="Black" BorderColor="Black"
                            ForeColor="White" Width="7%" HorizontalAlign="Center">SELECCIONAR</asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
            </div>

            <!-- Hidden Fields -->
            <asp:HiddenField ID="__mensaje" runat="server" />
            <asp:HiddenField ID="__pagina" runat="server" />
            <asp:HiddenField ID="Id_Dependencia" runat="server" Value="0" EnableViewState="False" />

        </div>
    </form>

    <!-- Scripts -->
    <script type="text/javascript" src="Otros_css_js/resaltar.js"></script>

</body>
</html>
