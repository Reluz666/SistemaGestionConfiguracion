<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Marca.aspx.cs" Inherits="TiposElementoConfiguracion" UnobtrusiveValidationMode="None" %>
<%@ Register src="NavBar.ascx" tagname="NavBar" tagprefix="uc1" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>Marca</title>

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

    <script type="text/javascript" src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body onload="MostrarMensaje()">

    <uc1:NavBar ID="NavBar1" runat="server" />

    <!-- ========== CONTENT ========== -->
    <div class="top-spacer"></div>

    <form id="form1" runat="server">

    <div class ="container">
         <div class="table-responsive" >
             <table class="table text-center" >
                <thead>
                  <tr>
                    <td style="text-align: center; color: #FFFFFF; background-color: #000000;" colspan="3"> INGRESE DATOS MARCAELEMENTO CONFIGURACION</td>

                  </tr>
                  <tr>
                        <td style="text-align: left; color: #FFFFFF; background-color: #000000;"
                            class="style2" colspan="3"> Nombre Marca</td>



                  </tr>
                  <tr>
                        <td style="text-align: left;"
                            class="style2" colspan="3">
                             <asp:TextBox ID="NOMBRE" runat="server" CssClass="form-control input-sm" MaxLength="25" Autocomplete = "off" placeholder="Ingrese Nombre Marca Elemento Configuracion" onchange="CambiaLetraMayuscula('NOMBRE')"
                        onkeypress="SoloLetrasMinusculas()"></asp:TextBox>
                             <asp:RequiredFieldValidator ID="rfvNOMBRE" runat="server" ControlToValidate="NOMBRE" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </td>


                   </tr>
                  <tr>
                        <td style="text-align: left"
                            class="style2">
                             &nbsp;</td>
                         <td style="text-align: left"
                            class="style2">
                             &nbsp;</td>


                         <td style="text-align: left"
                            class="style2"> &nbsp;</td>



                   </tr>
                  <tr>
                <td colspan="3" style="text-align: center">
                   <asp:Button ID="btnRegistrar" runat="server"
                       style="font-family: Calibri; color: #000000; font-size: medium"
                        Text="Registrar"
                        onclientclick="return Confirmar('¿Desea registrar marca?');"
                        CssClass="btn btn-success" Visible="False" OnClick="btnRegistrar_Click" />
                    &nbsp;
                    <asp:Button ID="btnModificar" runat="server"
                        style="font-family: Calibri; color: #000000; font-size: medium"
                        Text="Modificar"  onclientclick="return Confirmar('¿Desea modificar marca?');" CssClass="btn btn-warning" Visible="False" OnClick="btnModificar_Click" />
                    &nbsp;
                    <asp:Button ID="btnEliminar" runat="server"
                        style="font-family: Calibri; color: #000000; font-size: medium"
                        Text="Eliminar"  onclientclick="return Confirmar('¿Desea eliminar marca?');" class="btn btn-danger" Visible="False" OnClick="btnEliminar_Click" />
                    &nbsp;
                    <asp:Button ID="btnCancelar" runat="server" class="btn btn-primary"
                        style="font-family: Calibri;  font-size: medium" Text="Cancelar" CausesValidation="False" Visible="False" OnClick="btnCancelar_Click"
                         />
                    </td>
            </tr>
                 </thead>
             </table>
    </div> </div>

    <div class ="container">
         <div class="table-responsive" >
             <table class="table text-center">
        <tr>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td colspan="4">

                        <asp:Table ID="Table_" runat="server" CssClass="form-control input"
                            class="table table-hover table-condensed" BackColor="White" BorderColor="White"
                            CellPadding="6" CellSpacing="2" Font-Size="Small" GridLines="Both" Width="100%"
                            style="text-align: left">
                            <asp:TableRow ID="TableRow1" runat="server">
                                <asp:TableCell ID="tcID"  runat="server" BackColor="Black" BorderColor="Black"
                                    ForeColor="White" Width="7%" Visible="false">ID</asp:TableCell>

                                 <asp:TableCell ID="tcNOMBRE"  runat="server" BackColor="Black" BorderColor="Black"
                                    ForeColor="White"  Width="15%">NOMBRE</asp:TableCell>

                                <asp:TableCell ID="SELECCIONAR_MODELO" runat="server" BackColor="Black" BorderColor="Black"
                                    ForeColor="White" Width="7%" HorizontalAlign="Center">SELECCIONAR</asp:TableCell>

                            </asp:TableRow>
                        </asp:Table>

                    </td>

        </tr>

        <tr>
            <td colspan="3">
                    <asp:HiddenField ID="__mensaje" runat="server" />
                    <asp:HiddenField ID="__pagina" runat="server" />
                    <asp:HiddenField ID="ID_MAR" runat="server" Value="0"
                        EnableViewState="False" />
                    </td>
            <td>
                    &nbsp;</td>
        </tr>
    </table>
    </div> </div>

    </form>

</body>
</html>
