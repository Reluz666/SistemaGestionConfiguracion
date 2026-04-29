<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ventanaRelacionCIConOtrosCIS.aspx.cs" Inherits="RelacionesElementosConfiguracion" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Relacion Elementos Configuracion</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>    
    <meta charset="utf-8"/>    
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>

    <!-- Bootstrap -->
    <link href="../bootstrap/css/bootstrap.min.css" rel="stylesheet"/>

    <script  src="../Otros_css_js/resaltar.js" type="text/javascript"></script>
    <link rel="stylesheet" href="../Otros_css_js/estilo.css" type="text/css" />

    <script lang="javascript" type="text/javascript">

        
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
            width: 309px;
        }
    </style>
    
    </head>
<body onload ="MostrarMensaje()"> 
    <form id="form1" runat="server">
        <div class="table-responsive" >
           <div class ="container-fluid">
                <table class="table table text-center">
                    <tr>
                        <td style="text-align: left">                             
                            &nbsp;</td>
                    </tr>
                   
                    <tr>
                    <td>
                        <asp:Table ID="Table_" runat="server" BackColor="White" 
                            class="table table-condensed"
                        BorderColor="White" CellPadding="2" CellSpacing="0" Font-Size="X-Small" 
                        GridLines="Both" style="text-align: left">
                        <asp:TableRow ID="CABECERA" runat="server">
                            <asp:TableCell ID="_ID_RELACION" runat="server" BackColor="#FFFFC0" BorderColor="#FFFFC0" 
                                     ForeColor="Green" Visible="False">ID CI</asp:TableCell>
                            
                            <asp:TableCell ID="_PADRE_ID" runat="server" BackColor="Black" BorderColor="Black" 
                                ForeColor="White" Visible="False" >PADRE ID</asp:TableCell>

                            <asp:TableCell ID="_PADRE_CI" runat="server" BackColor="Black" BorderColor="Black" 
                                ForeColor="White" Width="50%">PADRE ELEMENETO CONFIGURACION</asp:TableCell>

                            <asp:TableCell ID="_HIJO_ID" runat="server" BackColor="Black" BorderColor="Black" 
                                ForeColor="White" Visible="False">HIJO ID</asp:TableCell>

                             <asp:TableCell ID="_HIJO_CI" runat="server" BackColor="Black" BorderColor="Black" 
                                ForeColor="White" Width="50%">HIJO ELEMENETO CONFIGURACION</asp:TableCell>

                             <asp:TableCell ID="_TIPO_RELACION" runat="server" BackColor="Black" BorderColor="Black" 
                                ForeColor="White" >TIPO RELACION</asp:TableCell>

                            
                           
                        </asp:TableRow>
                    </asp:Table>
                    </td>
                </tr>
                <tr>
                    <td >
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
