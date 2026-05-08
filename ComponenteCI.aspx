<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ComponenteCI.aspx.cs" Inherits="TiposElementoConfiguracion" UnobtrusiveValidationMode="None" %>
<%@ Register src="NavBar.ascx" tagname="NavBar" tagprefix="uc1" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>Componente CI</title>

    <!-- Bootstrap 5.3 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet" />
    <!-- Global Styles -->
    <link href="CssJs/global-styles.css" rel="stylesheet" />

    <style>
        /* Solo estilos especificos de tabla para ComponenteCI */
        #Table_ {
            border-collapse: separate !important;
            border-spacing: 0;
            width: 100%;
            min-width: 900px;
        }

        #Table_ thead tr th {
            background: linear-gradient(135deg, #1a1a2e 0%, #16213e 100%);
            color: #fff;
            font-weight: 600;
            font-size: 0.7rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            padding: 0.6rem 0.5rem !important;
            border: none !important;
            white-space: nowrap;
        }

        #Table_ tbody tr:hover td {
            background: rgba(233, 69, 96, 0.04) !important;
        }

        #Table_ tbody tr td {
            padding: 0.5rem 0.45rem !important;
            border: none !important;
            border-bottom: 1px solid #f1f1f1 !important;
            vertical-align: middle;
            font-size: 0.8rem;
            color: #2d3436;
        }
    </style>

    <script type="text/javascript" src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>

    <script lang="javascript" type="text/javascript">
        function MostrarMensaje() {
            var mensaje = document.getElementById("__mensaje").value;
            if (mensaje != "") {
                alert(mensaje);
                if (document.getElementById("__pagina").value != "")
                    location.href = document.getElementById("__pagina").value;
            }
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
</head>
<body onload="MostrarMensaje()">

    <uc1:NavBar ID="NavBar1" runat="server" />

    <!-- ========== FORMULARIO ========== -->
    <form id="form1" runat="server">

    <div class="table-wrapper">
           <div class="container-fluid">

             <table class="table text-center">
        <tr>
            <td style="text-align: left;"" colspan="2">
                             <asp:TextBox ID="tb1" runat="server" CssClass="form-control input-sm" MaxLength="25" Autocomplete = "off" placeholder="Ingresar Nro Serie CI" onchange=""
                        onkeypress="" Enabled="False" Font-Bold="True"></asp:TextBox>
                        </td>
        </tr>
        <tr>
            <td style="text-align: left;"" colspan="2">
                             <asp:TextBox ID="tb2" runat="server" CssClass="form-control input-sm" MaxLength="25" Autocomplete = "off" placeholder="Ingresar Nro Serie CI" onchange=""
                        onkeypress="" Enabled="False" Font-Bold="True"></asp:TextBox>
                        </td>
        </tr>
        <tr>
            <td colspan="2">

                        <asp:Table ID="Table_" runat="server" CssClass="form-control input"
                            class="table table-hover table-condensed" BackColor="White" BorderColor="White"
                            CellPadding="6" CellSpacing="2" Font-Size="Small" GridLines="Both" Width="100%"
                            style="text-align: left">
                            <asp:TableRow ID="TableRow1" runat="server">
                                <asp:TableCell ID="tcID"  runat="server" BackColor="Black" BorderColor="Black"
                                    ForeColor="White" Width="7%" Visible="false">ID</asp:TableCell>

                                <asp:TableCell ID="tcNOMBRE"  runat="server" BackColor="Black" BorderColor="Black"
                                    ForeColor="White"  Width="15%">NOMBRE</asp:TableCell>

                                <asp:TableCell ID="tcDESCRIPCION"  runat="server" BackColor="Black" BorderColor="Black"
                                    ForeColor="White"  Width="30%">DESCRIPCION</asp:TableCell>

                                <asp:TableCell ID="tcFABRICANTE"  runat="server" BackColor="Black" BorderColor="Black"
                                    ForeColor="White"  Width="20%">FABRICANTE</asp:TableCell>

                                <asp:TableCell ID="tcNRO_SERIE"  runat="server" BackColor="Black" BorderColor="Black"
                                    ForeColor="White"  Width="18%">NRO SERIE</asp:TableCell>

                                <asp:TableCell ID="tcMARCA"  runat="server" BackColor="Black" BorderColor="Black"
                                    ForeColor="White"  Width="10%">MARCA</asp:TableCell>

                                <asp:TableCell ID="tcMODELO"  runat="server" BackColor="Black" BorderColor="Black"
                                    ForeColor="White"  Width="15%">MODELO</asp:TableCell>



                            </asp:TableRow>
                        </asp:Table>

                    </td>

        </tr>

        <tr>
            <td>
                    <asp:HiddenField ID="__mensaje" runat="server" />
                    <asp:Button ID="btnEnviar" runat="server" OnClick="Button1_Click" Text="Enviar" CssClass="btn btn-primary btn-sm" />
                    <asp:HiddenField ID="__pagina" runat="server" />
                    </td>
            <td>
                    &nbsp;</td>
        </tr>
    </table>
     </div>
      </div>

    </form>

    <script type="text/javascript" src="Otros_css_js/resaltar.js"></script>

</body>
</html>
