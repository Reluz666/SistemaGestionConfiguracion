<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ventanaElementosConfiguracionParaSeguimiento.aspx.cs" Inherits="ElementosConfiguracion"  UnobtrusiveValidationMode="None" %>

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
                          _NRO_SERIE_CI,
                          _FABRICANTE_CI,
                          _MARCA_CI,
                          _MODELO_CI,
                          _ESTADO_CI,
                          _DESCRIPCION_CI,
                          _SEDE,
                          _LOCAL,
                          _UBICACION,
                          _DIRECCION,
                          _AREA,
                          _NRO_PISO,
                          _NRO_AMBIENTE) {
            window.opener.document.getElementById("hfID_ELEMENTO_CONFIGURACION").value = _ID_CI;
            window.opener.document.getElementById("tbNombre_Tipo_NroSerie").value = "Nombre: " + _NOMBRE_CI + "   Tipo: " + _TIPO_CI + "   Nro. Serie: " + _NRO_SERIE_CI
            window.opener.document.getElementById("tbFabricante_Marca_Modelo").value = "Fabricante: " + _FABRICANTE_CI + "   Marca: " + _MARCA_CI + "   Modelo: " + _MODELO_CI
            window.opener.document.getElementById("tbEstado_Descripcion_Sede").value = "Estado: " + _ESTADO_CI + "   Descripcion: " + _DESCRIPCION_CI + "   Sede: " + _SEDE
            window.opener.document.getElementById("tbLocal_Ubicacion_Direccion").value = "Local: " + _LOCAL + "   Ubicacion: " + _UBICACION + "   Direccion: " + _DIRECCION
            window.opener.document.getElementById("tbArea_NroPiso_NroAmbiente").value = "Area: " + _AREA + "   Nro. Piso: " + _NRO_PISO + "   Nro. Ambiente: " + _NRO_AMBIENTE

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
                        <td style="text-align: left" >
                            <asp:CheckBox ID="cbnci" runat="server" CssClass="form-check-input position-static&quot" Font-Size="X-Small" Text="Nombre CI" AutoPostBack="True" OnCheckedChanged="cbnci_CheckedChanged"/>
                        </td>
                        <td style="text-align: left" >
                            <asp:CheckBox ID="cbtci" runat="server" CssClass="form-check-input position-static&quot" Font-Size="X-Small" Text="Tipo CI" AutoPostBack="True" OnCheckedChanged="cbtci_CheckedChanged"/>
                        </td>
                        <td style="text-align: left" >
                            <asp:CheckBox ID="cbeci" runat="server" CssClass="form-check-input position-static&quot" Font-Size="X-Small" Text="Estado CI" AutoPostBack="True" OnCheckedChanged="cbeci_CheckedChanged"/>
                        </td>
                        <td style="text-align: left" class="auto-style1" >
                            <asp:CheckBox ID="cbpci" runat="server" CssClass="form-check-input position-static&quot" Font-Size="X-Small" Text="Propietario CI" AutoPostBack="True" OnCheckedChanged="cbpci_CheckedChanged"/>
                        </td>
                        <td style="text-align: left" class="auto-style1" >
                            <asp:CheckBox ID="cbdci" runat="server" CssClass="form-check-input position-static&quot" Font-Size="X-Small" Text="Descripcion CI" AutoPostBack="True" OnCheckedChanged="cbdci_CheckedChanged"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                             <asp:TextBox ID="txtnci" runat="server" CssClass="form-control input-sm" MaxLength="25" Autocomplete = "off" placeholder="Ingresar Nombre" onchange="" 
                        onkeypress="" Enabled="False"></asp:TextBox>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddltci" runat="server" CssClass="form-control input-sm" 
                                        AppendDataBoundItems="True" Enabled="False" 
                                       >
                                        <asp:ListItem Value="-1">_____SELECCIONE TIPO CI_____</asp:ListItem>
                                    </asp:DropDownList>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddleci" runat="server" CssClass="form-control input-sm" 
                                        AppendDataBoundItems="True" Enabled="False" 
                                       >
                                        <asp:ListItem Value="-1">_____SELECCIONE ESTADO CI_____</asp:ListItem>
                                    </asp:DropDownList>
                        </td>
                        <td class="auto-style1">
                             <asp:TextBox ID="txtpci" runat="server" CssClass="form-control input-sm" MaxLength="25" Autocomplete = "off" placeholder="Ingresar Nombre" onchange="" 
                        onkeypress="" Enabled="False"></asp:TextBox>
                        </td>
                        <td class="auto-style1">
                            <asp:DropDownList ID="ddldci" runat="server" CssClass="form-control input-sm" 
                                        AppendDataBoundItems="True" Enabled="False" 
                                       >
                                        <asp:ListItem Value="-1">_____SELECCIONE DESCRIPCION CI_____</asp:ListItem>
                                    </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: left" >
                            <asp:CheckBox ID="cbici" runat="server" CssClass="form-check-input position-static&quot" Font-Size="X-Small" Text="Impacto CI" AutoPostBack="True" OnCheckedChanged="cbici_CheckedChanged"/>
                        </td>
                        <td style="text-align: left" >
                            <asp:CheckBox ID="cbs" runat="server" CssClass="form-check-input position-static&quot" Font-Size="X-Small" Text="Sede" AutoPostBack="True" OnCheckedChanged="cbs_CheckedChanged"/>
                        </td>
                        <td style="text-align: left" >
                            <asp:CheckBox ID="cbl" runat="server" CssClass="form-check-input position-static&quot" Font-Size="X-Small" Text="Local" AutoPostBack="True" OnCheckedChanged="cbl_CheckedChanged"/>
                        </td>
                        <td style="text-align: left" >
                            <asp:CheckBox ID="cba" runat="server" CssClass="form-check-input position-static&quot" Font-Size="X-Small" Text="Area" AutoPostBack="True" OnCheckedChanged="cba_CheckedChanged"/>
                        </td>
                        <td style="text-align: left" >
                            <asp:CheckBox ID="cbans" runat="server" CssClass="form-check-input position-static&quot" Font-Size="X-Small" Text="Nro. Serie" AutoPostBack="True" OnCheckedChanged="cbans_CheckedChanged"/>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: left" >
                            <asp:DropDownList ID="ddlici" runat="server" CssClass="form-control input-sm" 
                                        AppendDataBoundItems="True" Enabled="False" 
                                       >
                                        <asp:ListItem Value="-1">_____SELECCIONE IMPACTO CI_____</asp:ListItem>
                                    </asp:DropDownList>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddls" runat="server" CssClass="form-control input-sm" 
                                        AppendDataBoundItems="True" Enabled="False" OnSelectedIndexChanged="ddls_SelectedIndexChanged" 
                                       >
                                        <asp:ListItem Value="-1">_____SELECCIONE SEDE_____</asp:ListItem>
                                    </asp:DropDownList>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddll" runat="server" CssClass="form-control input-sm" 
                                        AppendDataBoundItems="True" AutoPostBack="True" Enabled="False" OnSelectedIndexChanged="ddll_SelectedIndexChanged" 
                                       >
                                        <asp:ListItem Value="-1">_____SELECCIONE LOCAL_____</asp:ListItem>
                                    </asp:DropDownList>
                        </td>
                        <td class="auto-style1">
                            <asp:DropDownList ID="ddla" runat="server" CssClass="form-control input-sm" 
                                        AppendDataBoundItems="True" Enabled="False" 
                                       >
                                        <asp:ListItem Value="-1">_____SELECCIONE AREA_____</asp:ListItem>
                                    </asp:DropDownList>
                        </td>
                        <td style="text-align: left" >
                             <asp:TextBox ID="tbns" runat="server" CssClass="form-control input-sm" MaxLength="25" Autocomplete = "off" placeholder="Ingresar Nro. Serie CI" onchange="" 
                        onkeypress="" Enabled="False"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: left" >
                            <asp:CheckBox ID="cbf" runat="server" CssClass="form-check-input position-static&quot" Font-Size="X-Small" Text="Fabricante" AutoPostBack="True" OnCheckedChanged="cbf_CheckedChanged"/>
                        </td>
                        <td style="text-align: left" >
                            <asp:CheckBox ID="cbm" runat="server" CssClass="form-check-input position-static&quot" Font-Size="X-Small" Text="Marca" AutoPostBack="True" OnCheckedChanged="cbm_CheckedChanged"/>
                        </td>
                        <td style="text-align: left" >
                            <asp:CheckBox ID="cbmo" runat="server" CssClass="form-check-input position-static&quot" Font-Size="X-Small" Text="Modelo" AutoPostBack="True" OnCheckedChanged="cbmo_CheckedChanged"/>
                        </td>
                        <td class="auto-style1">
                            &nbsp;</td>
                        <td class="auto-style1">
                            <asp:LinkButton ID="lbtnBuscar" runat="server" CausesValidation="False" class="btn btn-info" OnClick="lbtnBuscar_Click" Text="Buscar  &lt;span class='glyphicon glyphicon-search'&gt;&lt;/span&gt;" UseSubmitBehavior="False" />
                            <asp:Button ID="btnActualizarInformacion" runat="server" class="btn btn-success" CssClass="btn btn-warning" onclick="btnActualizarInformacion_Click" Text="Actualizar Informacion" />
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: left" >
                             <asp:TextBox ID="tbf" runat="server" CssClass="form-control input-sm" MaxLength="25" Autocomplete = "off" placeholder="Ingresar Fabricante CI" onchange="" 
                        onkeypress="" Enabled="False"></asp:TextBox>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlm" runat="server" CssClass="form-control input-sm" 
                                        AppendDataBoundItems="True" Enabled="False" 
                                       >
                                        <asp:ListItem Value="-1">_____SELECCIONE MARCA_____</asp:ListItem>
                                    </asp:DropDownList>
                        </td>
                        <td style="text-align: left" >
                            <asp:DropDownList ID="ddlmo" runat="server" CssClass="form-control input-sm" 
                                        AppendDataBoundItems="True" Enabled="False" 
                                       >
                                        <asp:ListItem Value="-1">_____SELECCIONE MODELO_____</asp:ListItem>
                                    </asp:DropDownList>
                        </td>
                        <td class="auto-style1">
                            &nbsp;</td>
                        <td class="auto-style1">
                            &nbsp;</td>
                    </tr>
                    <tr>
                    <td colspan="5">
                        <asp:Table ID="Table_" runat="server" BackColor="White" 
                            class="table table-condensed"
                        BorderColor="White" CellPadding="2" CellSpacing="0" Font-Size="X-Small" 
                        GridLines="Both" style="text-align: left">
                        <asp:TableRow ID="CABECERA" runat="server">
                            <asp:TableCell ID="_ID_CI" runat="server" BackColor="#FFFFC0" BorderColor="#FFFFC0" 
                                     ForeColor="Green" Visible="False">ID CI</asp:TableCell>

                            <asp:TableCell ID="_NOMBRE_CI" runat="server" BackColor="Black" BorderColor="Black" 
                                ForeColor="White" >NOMBRE CI</asp:TableCell>

                           

                            <asp:TableCell ID="_NOMBRE_TIPO_CI" runat="server" BackColor="Black" BorderColor="Black" 
                                ForeColor="White" >TIPO CI</asp:TableCell>

                            <asp:TableCell ID="_NRO_SERIE" runat="server" BackColor="Black" BorderColor="Black" 
                                ForeColor="White" >NRO. SERIE</asp:TableCell>

                            <asp:TableCell ID="_FABRICANTE_O_PROVEEDOR" runat="server" BackColor="Black" BorderColor="Black" 
                                ForeColor="White" Visible="true">FEBRICANTE / PROVEEDOR</asp:TableCell>
                            <asp:TableCell ID="_MARCA" runat="server" BackColor="Black" BorderColor="Black" 
                                ForeColor="White" >MARCA</asp:TableCell>
                            <asp:TableCell ID="_MODELO" runat="server" BackColor="Black" BorderColor="Black" 
                                ForeColor="White" >MODELO</asp:TableCell>

                            <asp:TableCell ID="_ESTADO_CI" runat="server" BackColor="Black" BorderColor="Black" 
                                ForeColor="White" >ESTADO CI</asp:TableCell>

                           

                            <asp:TableCell ID="_PROPIETARIO" runat="server" BackColor="Black" BorderColor="Black" 
                                ForeColor="White" Visible="True">PROPIETARIO CI</asp:TableCell>

                            <asp:TableCell ID="_DESCRIPCION_CI" runat="server" BackColor="Black" BorderColor="Black" 
                                ForeColor="White" >DESCRIPCION CI</asp:TableCell>

                            <asp:TableCell ID="_IMPACTO_CI" runat="server" BackColor="Black" BorderColor="Black" 
                                ForeColor="White" >IMPACTO COMERCIAL CI</asp:TableCell>

                                <asp:TableCell ID="_NIVEL_PRIORIDAD" runat="server" BackColor="Black" BorderColor="Black" 
                                ForeColor="White" >INIVEL PRIORIDAD CI</asp:TableCell>

                            <asp:TableCell ID="_SEDE" runat="server" BackColor="Black" BorderColor="Black" 
                                ForeColor="White" >SEDE</asp:TableCell>
                            <asp:TableCell ID="_LOCAL" runat="server" BackColor="Black" BorderColor="Black" 
                                ForeColor="White" >LOCAL</asp:TableCell>
                            <asp:TableCell ID="_UBICACION_LOCAL" runat="server" BackColor="Black" BorderColor="Black" 
                                ForeColor="White" >UBICACION LOCAL</asp:TableCell>
                            <asp:TableCell ID="_DIRECCION_LOCAL" runat="server" BackColor="Black" BorderColor="Black" 
                                ForeColor="White" >DIRECCION LOCAL</asp:TableCell>
                            <asp:TableCell ID="_ID_AREA" runat="server" BackColor="Black" BorderColor="Black" 
                                ForeColor="White" Visible="False">ID AREA LOCAL</asp:TableCell>
                            <asp:TableCell ID="_AREA" runat="server" BackColor="Black" BorderColor="Black" 
                                ForeColor="White" >AREA</asp:TableCell>
                            <asp:TableCell ID="_NRO_PISO" runat="server" BackColor="Black" BorderColor="Black" 
                                ForeColor="White" >NRO PISO</asp:TableCell>
                            <asp:TableCell ID="_NRO_AMBIENTE" runat="server" BackColor="Black" BorderColor="Black" 
                                ForeColor="White" >NRO AMBIENTE</asp:TableCell>
                            
                            
                            <asp:TableCell ID="EDITAR" runat="server" BackColor="Black" BorderColor="Black" 
                                ForeColor="White" Width="3%" HorizontalAlign="Center">CI</asp:TableCell>
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
