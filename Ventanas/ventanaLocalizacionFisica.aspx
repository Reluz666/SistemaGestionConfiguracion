<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ventanaLocalizacionFisica.aspx.cs" Inherits="Ventanas_ventanaLocalizacionFisica" UnobtrusiveValidationMode="None"  %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Localizacion Fisica</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>    
    <meta charset="utf-8"/>    
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>

    <!-- Bootstrap -->
    <link href="../bootstrap/css/bootstrap.min.css" rel="stylesheet"/>

    <script  src="../Otros_css_js/resaltar.js" type="text/javascript"></script>
    <link rel="stylesheet" href="../Otros_css_js/estilo.css" type="text/css" />

    <script lang="javascript" type="text/javascript">

        function AREA(_ID,
                          _AREA,
                          _SEDE,
                          _LOCAL,
                          _UBICACION,
                          _DIRECCION,
                          _NRO_PISO,
                          _NRO_AMBIENTE) {
            window.opener.document.getElementById("ID_LOCALIZACION_FISICA").value = _ID;
            window.opener.document.getElementById("LOCALIZACION_FISICA").value = "Area :" + _AREA + "\nSede: " + _SEDE + "\nLocal: " + _LOCAL + "\nUbicacion: " + _UBICACION + "\nDireccion: " + _DIRECCION + "\nNro. Piso: " + _NRO_PISO + "\nNro. Ambiente: " + _NRO_AMBIENTE;
            window.close();
        }

        function cerrar_ventana() {
            window.close();
        }
 
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
        
    </script>    
    
    <style type="text/css">
        .auto-style1 {
            color: #FFFFFF;
        }
    </style>
</head>
<body onload ="MostrarMensaje()"> 
    <form id="form1" runat="server">
        <div class="table-responsive" >
           <div class ="container-fluid">
                <table class="table table text-center">
                    <tr>
                    <td>
                        <asp:Table ID="Table_" runat="server" BackColor="White" 
                            class="table table-condensed"
                        BorderColor="White" CellPadding="2" CellSpacing="0" Font-Size="Small" 
                        GridLines="Both" style="text-align: left">
                        <asp:TableRow ID="CABECERA" runat="server">
                            <asp:TableCell ID="_ID" runat="server" BackColor="#FFFFC0" BorderColor="#FFFFC0" 
                                     ForeColor="Green" Visible="False">ID</asp:TableCell>

                            <asp:TableCell ID="_SEDE" runat="server" BackColor="Black" BorderColor="Black" 
                                ForeColor="White" >SEDE</asp:TableCell>

                            <asp:TableCell ID="_LOCAL" runat="server" BackColor="Black" BorderColor="Black" 
                                ForeColor="White" >LOCAL</asp:TableCell>

                            <asp:TableCell ID="_DISTRITO" runat="server" BackColor="Black" BorderColor="Black" 
                                ForeColor="White" >DISTRITO</asp:TableCell>

                            <asp:TableCell ID="_PROVINCIA" runat="server" BackColor="Black" BorderColor="Black" 
                                ForeColor="White" >PROVINCIA</asp:TableCell>

                            <asp:TableCell ID="_DEPARTAMENTO" runat="server" BackColor="Black" BorderColor="Black" 
                                ForeColor="White" >DEPARTAMENTO</asp:TableCell>

                            <asp:TableCell ID="_DIRECCION_LOCAL" runat="server" BackColor="Black" BorderColor="Black" 
                                ForeColor="White" >DIRECCION LOCAL</asp:TableCell>

                            <asp:TableCell ID="_AREA" runat="server" BackColor="Black" BorderColor="Black" 
                                ForeColor="White" >AREA</asp:TableCell>
                            <asp:TableCell ID="_NRO_PISO" runat="server" BackColor="Black" BorderColor="Black" 
                                ForeColor="White" >NRO PISO</asp:TableCell>
                            <asp:TableCell ID="_NRO_AMBIENTE" runat="server" BackColor="Black" BorderColor="Black" 
                                ForeColor="White" >NRO AMBIENTE</asp:TableCell>
                            <asp:TableCell ID="SELECCIONAR" runat="server" BackColor="Black" BorderColor="Black" 
                                ForeColor="White" Width="3%" HorizontalAlign="Center">SELECCIONAR</asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                    </td>
                </tr>
                <tr>
                    <td colspan="5" >
                        <asp:HiddenField ID="__pagina" runat="server" />
                        <asp:HiddenField ID="__mensaje" runat="server" />
                    </td>
                </tr>
                </table>
           </div>
        </div>
    </form>
    <script lang ="JavaScript" type="text/javascript">
        ResaltarFila('Table_');
    </script>	

     <script type="text/javascript" src="../bootstrap/js/jquery-1.12.4.min.js"></script>
     <script type="text/javascript" src="../bootstrap/js/bootstrap.min.js"></script>
</body>
</html>
