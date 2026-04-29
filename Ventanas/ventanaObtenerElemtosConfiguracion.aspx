<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ventanaObtenerElemtosConfiguracion.aspx.cs" Inherits="Ventanas_ventanaObtenerElemtosConfiguracion"  UnobtrusiveValidationMode="None"%>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Elementos de Configuracion</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>    
    <meta charset="utf-8"/>    
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>

    <!-- Bootstrap -->
    <link href="../bootstrap/css/bootstrap.min.css" rel="stylesheet"/>

    <script  src="../Otros_css_js/resaltar.js" type="text/javascript"></script>
    <link rel="stylesheet" href="../Otros_css_js/estilo.css" type="text/css" />

    <script lang="javascript" type="text/javascript">

        function ELEMENTO_CONFIGURACION(_ID_CI,
                          _NOMBRE_CI,
                          _TIPO_CI,
                          _ESTADO_CI,
                          _PROPIETARIO,
                          _DESCRIPCION_CI,
                          _AREA,
                          _SEDE,
                          _LOCAL,
                          _UBICACION,
                          _DIRECCION,
                          _NRO_PISO,
                          _NRO_AMBIENTE,
                          _NIVEL_PRIORIDAD,
                          _OPCION) {
            if (_OPCION==1){
                window.opener.document.getElementById("ID_CI_P").value = _ID_CI;
                window.opener.document.getElementById("Nombre_CI_P").value = _NOMBRE_CI;
                window.opener.document.getElementById("Tipo_CI_P").value = _TIPO_CI;
                window.opener.document.getElementById("Estado_CI_P").value = _ESTADO_CI;
                window.opener.document.getElementById("Propietario_CI_P").value = _PROPIETARIO;
                window.opener.document.getElementById("Descripcion_CI_P").value = _DESCRIPCION_CI;
                window.opener.document.getElementById("Sede_P").value = _SEDE;
                window.opener.document.getElementById("Local_P").value = _LOCAL;
                window.opener.document.getElementById("Area_P").value = _AREA;
                window.opener.document.getElementById("NroPiso_P").value = _NRO_PISO;
                window.opener.document.getElementById("NroAmbiente_P").value = _NRO_AMBIENTE;
                window.opener.document.getElementById("Ubicacion_P").value = _UBICACION;
                window.opener.document.getElementById("Direccion_P").value = _DIRECCION;
                window.opener.document.getElementById("NivelPrioridad_CI_P").value = _NIVEL_PRIORIDAD;
            } else if (_OPCION == 2) {
                window.opener.document.getElementById("ID_CI_H").value = _ID_CI;
                window.opener.document.getElementById("Nombre_CI_H").value = _NOMBRE_CI;
                window.opener.document.getElementById("Tipo_CI_H").value = _TIPO_CI;
                window.opener.document.getElementById("Estado_CI_H").value = _ESTADO_CI;
                window.opener.document.getElementById("Propietario_CI_H").value = _PROPIETARIO;
                window.opener.document.getElementById("Descripcion_CI_H").value = _DESCRIPCION_CI;
                window.opener.document.getElementById("Sede_H").value = _SEDE;
                window.opener.document.getElementById("Local_H").value = _LOCAL;
                window.opener.document.getElementById("Area_H").value = _AREA;
                window.opener.document.getElementById("NroPiso_H").value = _NRO_PISO;
                window.opener.document.getElementById("NroAmbiente_H").value = _NRO_AMBIENTE;
                window.opener.document.getElementById("Ubicacion_H").value = _UBICACION;
                window.opener.document.getElementById("Direccion_H").value = _DIRECCION;
                window.opener.document.getElementById("NivelPrioridad_CI_H").value = _NIVEL_PRIORIDAD;
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
                        BorderColor="White" CellPadding="2" CellSpacing="0" Font-Size="X-Small" 
                        GridLines="Both" style="text-align: left">
                        <asp:TableRow ID="CABECERA" runat="server">
                            <asp:TableCell ID="_ID_CI" runat="server" BackColor="#FFFFC0" BorderColor="#FFFFC0" 
                                     ForeColor="Green" Visible="False">ID</asp:TableCell>

                            <asp:TableCell ID="_NOMBRE_CI" runat="server" BackColor="Black" BorderColor="Black" 
                                ForeColor="White" >NOMBRE CI</asp:TableCell>

                            <asp:TableCell ID="_TIPO_CI" runat="server" BackColor="Black" BorderColor="Black" 
                                ForeColor="White" >TIPO CI</asp:TableCell>

                            <asp:TableCell ID="_ESTADO_CI" runat="server" BackColor="Black" BorderColor="Black" 
                                ForeColor="White" >ESTADO CI</asp:TableCell>

                            <asp:TableCell ID="_PROPIETARIO" runat="server" BackColor="Black" BorderColor="Black" 
                                ForeColor="White" >PROPIETARIO CI</asp:TableCell>

                            <asp:TableCell ID="_DESCRIPCION_CI" runat="server" BackColor="Black" BorderColor="Black" 
                                ForeColor="White" >DESCRIPCION CI</asp:TableCell>

                            <asp:TableCell ID="_LOCALIZACION_FISICA" runat="server" BackColor="Black" BorderColor="Black" 
                                ForeColor="White" >LOCALIZACION FISICA CI</asp:TableCell>

                           <asp:TableCell ID="_NIVEL_PRIORIDAD" runat="server" BackColor="Black" BorderColor="Black" 
                                ForeColor="White" >NIVEL PRIORIDAD CI</asp:TableCell>                           
                           
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