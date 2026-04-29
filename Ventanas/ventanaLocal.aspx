<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ventanaLocal.aspx.cs" Inherits="TiposElementoConfiguracion" UnobtrusiveValidationMode="None" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Local</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>    
    <meta charset="utf-8"/>    
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>

    <!-- Bootstrap -->
    <link href="../bootstrap/css/bootstrap.min.css" rel="stylesheet"/>

    <script  src="../Otros_css_js/resaltar.js" type="text/javascript"></script>
    <link rel="stylesheet" href="../Otros_css_js/estilo.css" type="text/css" />

    <script lang="javascript" type="text/javascript">
        function LOCAL(_ID_LOCAL,
                          _LOCAL_CODIGO,
                          _LOCAL_NOMBRE,
                          _LOCAL_DIRECCION,
                          _SEDE,
                          _ID_UB,
                          _UBICACION_GEOGRAFICA) {
            window.opener.document.getElementById("hfCodigo_Local_Judicial").value = _ID_LOCAL;
            window.opener.document.getElementById("Local_Judicial").value = "Local: " + _LOCAL_NOMBRE + "   Ubicacion Geografica: " + _UBICACION_GEOGRAFICA + "   Direccion: " + _LOCAL_DIRECCION + "   Sede: " + _SEDE

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

        function Activa(Opcion) {
            if (Opcion == 2) {
                if (document.getElementById('cbs').checked == true) {
                    document.getElementById("ddls").disabled = ""
                } else {
                    document.getElementById("ddls").disabled = "disabled"
                }
             
            }

        }
    </script>    
    
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <style type="text/css">
        .position-static" {
            text-align: left;
        }
    </style>
</head>
<body onload ="MostrarMensaje()"> 

    <form id="form1" runat="server">



    <div class ="container">
         <div class="table-responsive" >
             <table class="table text-center">
        <tr>
            <td style="text-align: left;"">
                            <asp:CheckBox ID="cbs" runat="server" CssClass="form-check-input position-static&quot" Font-Size="X-Small" Text="Sede" onChange="Activa(2);"/>
                        </td>
            <td style="text-align: left;"">
                            &nbsp;</td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td style="text-align: left;"">
                             <asp:DropDownList ID="ddls" runat="server" CssClass="form-control input-sm" 
                                        AppendDataBoundItems="True" Enabled="False" 
                                       onChange="Activa();">
                                        <asp:ListItem Value="-1">_____SELECCIONE SEDE_____</asp:ListItem>
                                    </asp:DropDownList>
                        </td>
            <td>
                             &nbsp;</td>
            <td>
                            <asp:LinkButton ID="lbtnBuscar" runat="server" CausesValidation="False" class="btn btn-info" OnClick="lbtnBuscar_Click" Text="Buscar  &lt;span class='glyphicon glyphicon-search'&gt;&lt;/span&gt;" UseSubmitBehavior="False" />
                            <asp:Button ID="btnActualizarInformacion" runat="server" class="btn btn-success" CssClass="btn btn-warning" onclick="btnActualizarInformacion_Click" Text="Actualizar Informacion" CausesValidation="False" />
                        </td>
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
                                <asp:TableCell ID="tcID_LOCAL"  runat="server" BackColor="Black" BorderColor="Black" 
                                    ForeColor="White" Width="7%" Visible="false">ID LOCAL</asp:TableCell>

                                <asp:TableCell ID="tcLOCAL_CODIGO"  runat="server" BackColor="Black" BorderColor="Black" 
                                    ForeColor="White"  Width="15%">LOCAL CODIGO</asp:TableCell>

                                <asp:TableCell ID="tcLOCAL_NOMBRE"  runat="server" BackColor="Black" BorderColor="Black" 
                                    ForeColor="White"  Width="15%">LOCAL NOMBRE</asp:TableCell>
                                    
                               <asp:TableCell ID="tcLOCAL_DIRECCION"  runat="server" BackColor="Black" BorderColor="Black" 
                                    ForeColor="White"  Width="15%">LOCAL DIRECCION</asp:TableCell>  
                                
                               <asp:TableCell ID="tcSEDE"  runat="server" BackColor="Black" BorderColor="Black" 
                                    ForeColor="White"  Width="15%">SEDE</asp:TableCell> 
                                    
                               <asp:TableCell ID="tcID_UBI"  runat="server" BackColor="Black" BorderColor="Black" 
                                    ForeColor="White"  Width="15%" Visible="false">ID UBI</asp:TableCell>  
                                   
                               <asp:TableCell ID="tcUBICACION_GEOGRAFICA"  runat="server" BackColor="Black" BorderColor="Black" 
                                    ForeColor="White"  Width="15%">UBICACION GEOGRAFICA</asp:TableCell>                      

                                <asp:TableCell ID="SELECCIONAR_LOCAL" runat="server" BackColor="Black" BorderColor="Black" 
                                    ForeColor="White" Width="7%">SELECCIONAR LOCAL</asp:TableCell>

                            </asp:TableRow>
                        </asp:Table>
                        
                    </td>
            
        </tr>
       
        <tr>
            <td colspan="3">
                    <asp:HiddenField ID="__mensaje" runat="server" />
                    <asp:HiddenField ID="__pagina" runat="server" />
                    </td>
            <td>
                    &nbsp;</td>
        </tr>
    </table>
    </div> </div>

    </form>

    <script lang ="JavaScript" type="text/javascript">
        ResaltarFila('Table_');
    </script>	

     <script type="text/javascript" src="../bootstrap/js/jquery-1.12.4.min.js"></script>
     <script type="text/javascript" src="../bootstrap/js/bootstrap.min.js"></script>
 
    </body>
</html>
