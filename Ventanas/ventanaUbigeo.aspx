<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ventanaUbigeo.aspx.cs" Inherits="ElementosConfiguracion"  UnobtrusiveValidationMode="None" %>

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

        function UBICACION_GEOGRAFICA(_ID,
                          _CODIGO,
                          _DEPARTAMENTO,
                          _PROVINCIA,
                          _DISTRITO) {
            window.opener.document.getElementById("hfCodigo_Ubicacion_Geografica").value = _ID;
            window.opener.document.getElementById("Ubicacion_Geografica").value = _DEPARTAMENTO + ' / ' + _PROVINCIA + ' / ' + _DISTRITO;
            
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
                        <td style="text-align: left" colspan="5">                             
                            &nbsp;</td>
                        <td style="text-align: left">                             
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td style="text-align: left" >
                            <asp:CheckBox ID="cbd" runat="server" CssClass="form-check-input position-static&quot" Font-Size="X-Small" Text="Departamento" AutoPostBack="True" OnCheckedChanged="cbd_CheckedChanged"/>
                        </td>
                        <td style="text-align: left" >
                            <asp:CheckBox ID="cbp" runat="server" CssClass="form-check-input position-static&quot" Font-Size="X-Small" Text="Provincia" AutoPostBack="True" OnCheckedChanged="cbp_CheckedChanged"/>
                        </td>
                        <td style="text-align: left" >
                            &nbsp;</td>
                        <td style="text-align: left" class="auto-style1" >
                            &nbsp;</td>
                        <td style="text-align: left" class="auto-style1" >
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td>
                            <asp:DropDownList ID="ddld" runat="server" CssClass="form-control input-sm" 
                                        AppendDataBoundItems="True" Enabled="False" AutoPostBack="True" OnSelectedIndexChanged="ddld_SelectedIndexChanged" 
                                       >
                                        <asp:ListItem Value="-1">_____SELECCIONE DEPARTAMENTO_____</asp:ListItem>
                                    </asp:DropDownList>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlp" runat="server" CssClass="form-control input-sm" 
                                        AppendDataBoundItems="True" Enabled="False" 
                                       >
                                        <asp:ListItem Value="-1">_____SELECCIONE PROVINCIA_____</asp:ListItem>
                                    </asp:DropDownList>
                        </td>
                        <td>
                            <asp:LinkButton ID="lbtnBuscar" runat="server" CausesValidation="False" class="btn btn-info" OnClick="lbtnBuscar_Click" Text="Buscar  &lt;span class='glyphicon glyphicon-search'&gt;&lt;/span&gt;" UseSubmitBehavior="False" />
                            <asp:Button ID="btnActualizarInformacion" runat="server" class="btn btn-success" CssClass="btn btn-warning" onclick="btnActualizarInformacion_Click" Text="Actualizar Informacion" />
                        </td>
                        <td class="auto-style1">
                             &nbsp;</td>
                        <td class="auto-style1">
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td style="text-align: left" >
                            &nbsp;</td>
                        <td style="text-align: left" >
                            &nbsp;</td>
                        <td style="text-align: left" >
                            &nbsp;</td>
                        <td style="text-align: left" >
                            &nbsp;</td>
                        <td class="auto-style1">
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td style="text-align: left" >
                            &nbsp;</td>
                        <td>
                            &nbsp;</td>
                        <td>
                            &nbsp;</td>
                        <td class="auto-style1">
                            &nbsp;</td>
                        <td class="auto-style1">
                            &nbsp;</td>
                    </tr>
                    <tr>
                    <td colspan="5">
                        <asp:Table ID="Table_" runat="server" BackColor="White" 
                            class="table table-condensed"
                        BorderColor="White" CellPadding="2" CellSpacing="0" Font-Size="Small" 
                        GridLines="Both" style="text-align: left">
                        <asp:TableRow ID="CABECERA" runat="server">
                            <asp:TableCell ID="tcID" runat="server" BackColor="#FFFFC0" BorderColor="#FFFFC0" 
                                     ForeColor="Green" Visible="False">ID</asp:TableCell>

                            <asp:TableCell ID="tcCODIGO" runat="server" BackColor="Black" BorderColor="Black" 
                                ForeColor="White" >CODIGO</asp:TableCell>

                            <asp:TableCell ID="tcDEPARTAMENTO" runat="server" BackColor="Black" BorderColor="Black" 
                                ForeColor="White" >DEPARTAMENTO</asp:TableCell>

                            <asp:TableCell ID="tcPROVINCIA" runat="server" BackColor="Black" BorderColor="Black" 
                                ForeColor="White" >PROVINCIA</asp:TableCell>
                           
                            <asp:TableCell ID="tcDISTRITO" runat="server" BackColor="Black" BorderColor="Black" 
                                ForeColor="White" >DISTRITO CI</asp:TableCell>

                            
                            <asp:TableCell ID="EDITAR" runat="server" BackColor="Black" BorderColor="Black" 
                                ForeColor="White" Width="3%" HorizontalAlign="Center">UBIGEO</asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                    </td>
                    <td>
                        &nbsp;</td>
                </tr>
                <tr>
                    <td colspan="5" >
                        <asp:HiddenField ID="__pagina" runat="server" />
                        <asp:HiddenField ID="__mensaje" runat="server" />
                    </td>
                    <td >
                        &nbsp;</td>
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
