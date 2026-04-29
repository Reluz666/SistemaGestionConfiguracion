<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ventanaTiposElementoConfiguracion.aspx.cs" Inherits="Ventanas_ventanaTiposElementoConfiguracion" UnobtrusiveValidationMode="None" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Tipos Elemento Configuracion</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>    
    <meta charset="utf-8"/>    
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>

    <!-- Bootstrap -->
    <link href="../bootstrap/css/bootstrap.min.css" rel="stylesheet"/>

    <script  src="../Otros_css_js/resaltar.js" type="text/javascript"></script>
    <link rel="stylesheet" href="../Otros_css_js/estilo.css" type="text/css" />

    <script lang="javascript" type="text/javascript">

        function TIPOSELEMTOCONFIGURACION(_ID_TIPO,
                          _TIPO_ELEMENTO_CONFIGURACION) {
            window.opener.document.getElementById("ID_TIPO_ELEMENTO_CONFIGURACION").value = _ID_TIPO;
            window.opener.document.getElementById("TIPO_ELEMENTO_CONFIGURACION").value = _TIPO_ELEMENTO_CONFIGURACION;
            var ok = _TIPO_ELEMENTO_CONFIGURACION=="MANUALES DE PROCESOS"
            || _TIPO_ELEMENTO_CONFIGURACION == "LICENCIAS"
            || _TIPO_ELEMENTO_CONFIGURACION == "SERVICIO"
            || _TIPO_ELEMENTO_CONFIGURACION == "APLICACION";
            window.opener.document.getElementById("NRO_SERIE").value = "";
            window.opener.document.getElementById("NRO_SERIE").readOnly = false;

            window.opener.document.getElementById("IP").value = "";
            window.opener.document.getElementById("IP").readOnly = false;

            window.opener.document.getElementById("GATEWAY").value = "";
            window.opener.document.getElementById("GATEWAY").readOnly = false;

            window.opener.document.getElementById("GRUPO_TRABAJO").value = "";
            window.opener.document.getElementById("GRUPO_TRABAJO").readOnly = false;
            if (ok == false) {
            } else {
                window.opener.document.getElementById("NRO_SERIE").value = "NINGUNO";
                window.opener.document.getElementById("NRO_SERIE").readOnly = true;

                window.opener.document.getElementById("IP").value = "NINGUNO";
                window.opener.document.getElementById("IP").readOnly = true;

                window.opener.document.getElementById("GATEWAY").value = "NINGUNO";
                window.opener.document.getElementById("GATEWAY").readOnly = true;

                window.opener.document.getElementById("GRUPO_TRABAJO").value = "NINGUNO";
                window.opener.document.getElementById("GRUPO_TRABAJO").readOnly = true;
            }
            if (_TIPO_ELEMENTO_CONFIGURACION == "APLICACION") {
                window.opener.document.getElementById("NRO_SERIE").value = "";
                window.opener.document.getElementById("NRO_SERIE").readOnly = false;
            }

           
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
                            <asp:TableCell ID="_ID_TIPO" runat="server" BackColor="#FFFFC0" BorderColor="#FFFFC0" 
                                     ForeColor="Green" Visible="False">ID</asp:TableCell>
                            <asp:TableCell ID="_TIPO_ELEMENTO_CONFIGURACION" runat="server" BackColor="Black" BorderColor="Black" 
                                ForeColor="White" >TIPO ELEMENTO CONFIGURACION</asp:TableCell>
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
