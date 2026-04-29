<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SeguimientosElementoConfiguracion.aspx.cs" Inherits="ElementosConfiguracion"  UnobtrusiveValidationMode="None" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Elementos de Configuracion</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />

    <!-- Bootstrap -->
    <link href="../bootstrap/css/bootstrap.min.css" rel="stylesheet" />
    <link href="CssJs/Menu.css" rel="stylesheet" />

    <script src="../Otros_css_js/resaltar.js" type="text/javascript"></script>
    <link rel="stylesheet" href="../Otros_css_js/estilo.css" type="text/css" />

    <script type="text/javascript" src="../src/js/jscal2.js"></script>
    <script type="text/javascript" src="../src/js/lang/es.js"></script>
    <link rel="stylesheet" type="text/css" href="../src/css/jscal2.css" />
    <link rel="stylesheet" type="text/css" href="../src/css/border-radius.css" />
    <link rel="stylesheet" type="text/css" href="../src/css/steel/steel.css" />

     <style>
        .dropdown-submenu {
            position: relative;
        }

            .dropdown-submenu > .dropdown-menu {
                top: 0;
                left: 100%;
                margin-top: -6px;
                margin-left: -2px;
            }

            .dropdown-submenu:hover > .dropdown-menu {
                display: block;
            }

            .dropdown-submenu > a:after {
                content: "";
                margin-top: 6px;
                margin-right: -10px;
                float: right;
                border-left: 4px solid;
                border-top: 4px solid transparent;
                border-bottom: 4px solid transparent;
            }
    </style>

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
        .auto-style2 {
            font-size: x-small;
        }
    </style>
    
    </head>
<body onload ="MostrarMensaje()"> 
<nav class="navbar navbar-custom navbar-fixed-top" role="navigation">
        <!-- El logotipo y el icono que despliega el menú se agrupan
       para mostrarlos mejor en los dispositivos móviles -->
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse"
                data-target=".navbar-ex1-collapse">
                <span class="sr-only">Desplegar navegación</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="../menu.aspx"><span class="glyphicon glyphicon-home"></span>&nbsp;Inicio</a>
            <%--<a class="navbar-brand" href="menu.aspx"><span><img src="imagenes/001-home.png" /></span>  Inicio</a>--%>
        </div>


        <!-- -->
        <!-- Agrupar los enlaces de navegación, los formularios y cualquier
       otro elemento que se pueda ocultar al minimizar la barra -->
        <div class="collapse navbar-collapse navbar-ex1-collapse">
            <ul class="nav navbar-nav">
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown"><span class="glyphicon glyphicon-briefcase"></span>&nbsp;Mantenimiento <b class="caret"></b>
                    </a>
                    <ul class="dropdown-menu">
                        <li><a href="Personal.aspx" runat="server" id="trabajadores_aspx">Personal</a></li>
                        <li class="dropdown-submenu">
                            <a href="#">Tablas Institucion</a>
                            <ul class="dropdown-menu">
                                <li><a href="Sede.aspx" runat="server" id="a4">Sede</a></li>
                                <li><a href="Local.aspx" runat="server" id="A5">Local</a></li>
                                <li><a href="Area.aspx" runat="server" id="A6">Area</a></li>
                                <li><a href="Dependencia.aspx" runat="server" id="A8">Dependencia</a></li>
                            </ul>
                        </li>
                        <li class="dropdown-submenu">
                            <a href="#">Tablas Personal</a>
                            <ul class="dropdown-menu">
                                <li><a href="Cargo.aspx" runat="server" id="area_trabajo_aspx">Cargo</a></li>
                                <li><a href="ProfecionOcupacion.aspx" runat="server" id="Sub_Area_aspx">Profecion - Ocupacion</a></li>                               
                            </ul>
                        </li>
                        <li class="divider"></li>
                        <li class="dropdown-submenu">
                            <a href="#">Tablas Elemento Configuracion/a>
                            <ul class="dropdown-menu">
                                <li><a href="Modelo.aspx" runat="server" id="A14">Modelo</a></li>
                                <li><a href="Marca.aspx" runat="server" id="A13">Marca</a></li>
                                <li><a href="DescripcionElementoConfiguracion.aspx" runat="server" id="A9">Descripci&oacute;n Elemento Configuraci&oacute;n</a></li>
                                <li><a href="TiposElementoConfiguracion.aspx" runat="server" id="A10">Tipos Elemento Configuraci&oacute;n</a></li> 
                                <li><a href="TipoRelacionElementoConfiguracion.aspx" runat="server" id="A11">Tipo Relaci&oacute;n Elemento Configuraci&oacute;n</a></li>
                                <li><a href="TipoComponeneteCI.aspx" runat="server" id="A12">Tipo Componenete Elemento Configuraci&oacute;n</a></li> 
                                <li><a href="EstadoActualCI.aspx" runat="server" id="A15">Estado Actual Elemento Configuraci&oacute;n</a></li>                                                                                                                             
                            </ul>
                        </li>
                    </ul>
                </li>
            </ul>


            <ul class="nav navbar-nav">
                <!--<li class="active"><a href="#">Enlace #1</a></li>
                <li><a href="#">Enlace #2</a></li>-->
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" style="color: white"><span class="glyphicon glyphicon-user"></span>&nbsp;Gesti&oacute;n de Configuraci&oacute;n <b class="caret"></b>
                    </a>
                    <ul class="dropdown-menu">
                        
                        <li><a href="ElementosConfiguracion.aspx" runat="server" id="ElementosConfiguracion_aspx">Elementos de Configuracio&oacute;n</a></li>
                        <li><a href="RelacionesElementosConfiguracion.aspx" runat="server" id="PrendaMovimientos_aspx">Relacio&oacute;n de Elementos de Configuracio&oacute;n</a></li>
                        <li class="divider"></li>
                        <li><a href="CIsAsignarComponenetes.aspx" runat="server" id="A3">Asignar Componentes Elementos de Configuraci&oacute;n</a></li>
                        <li class="divider"></li>
                        <li><a href="LicenciasElementoConfiguracion.aspx" runat="server" id="A1">Licencias de Elementos de Configuraci&oacute;n</a></li>
                        <li class="divider"></li>
                        <li><a href="SeguimientosElementoConfiguracion.aspx" runat="server" id="_Asistencias_aspx">Seguimiento de Elementos de Configuraci&oacute;n</a></li>                        
                    </ul>
                </li>
            </ul>

            <ul class="nav navbar-nav">
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown"><span class="glyphicon glyphicon-file"></span>&nbsp;Reportes <b class="caret"></b>
                    </a>
                    <ul class="dropdown-menu">
                        <li><a href="../Reportes/ReporteElementosConfiguracion.aspx" runat="server" id="A16">Reporte de Elementos de Configuraci&oacute;n</a></li>
                        <li><a href="../Reportes/ReporteRelacionesElementosConfiguracion.aspx" runat="server" id="A17">Reporte de Relaciones de Elementos de Configuraci&oacute;n</a></li>
                        <li><a href="../Reportes/ReporteSeguimientosElementoConfiguracion.aspx" runat="server" id="A18">Reporte de Seguimientos de Elementos de Configuraci&oacute;n</a></li>
                        <li><a href="../Reportes/ReporteLicenciasElementoConfiguracion.aspx" runat="server" id="A19">Reporte de Licencias de Elementos de Configuraci&oacute;n</a></li>
                        <li><a href="../Reportes/ReporteCIsSeguidos.aspx" runat="server" id="A24">Reporte de Elementos de Configuraci&oacute;n Seguidos</a></li>
                        <li><a href="../Reportes/ReporteComponentesAsignados.aspx" runat="server" id="A20">Reporte de Componentes de Elementos de Configuraci&oacute;n Asignados</a></li>
                        <li class="divider"></li>
                        
                        <li><a href="../Reportes/ReporteDatosCorrectosCI.aspx" runat="server" id="A21">Reporte de Datos Correctos de Elementos de Configuraci&oacute;n</a></li>
                        <li><a href="../Reportes/ReporteDatosIncorrectosCI .aspx" runat="server" id="A22">Reporte de Datos Incorrectos de Elementos de Configuraci&oacute;n</a></li>
                        <li><a href="../Reportes/ReporteCIsInformacionContenidaEnCMDB .aspx" runat="server" id="A23">Reporte de Informaci&oacute;n de Elementos de Configuraci&oacute;n Contenidas en la CMDB</a></li>
                             
                        
                    </ul>
                </li>
            </ul>


            <ul class="nav navbar-nav">

                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" style="color: black"><span class="glyphicon glyphicon-wrench"></span>&nbsp;Configuraciones <b class="caret"></b>
                    </a>
                    <ul class="dropdown-menu">
                        <li><a href="Usuario.aspx" runat="server" id="usuarios_aspx">Usuarios</a></li>
                        <li><a href="../Configuracion/Usuarios.aspx" runat="server" id="permisos_aspx">Permisos</a></li>
                        <li class="divider"></li>
                        <li><a href="CerrarSession.aspx" style="text-align: left; color: red;">Cerrar Sesion</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </nav>

    <%--  ......NO CAMBIAR.........  --%>
    <div class="section">
        <div class="container">
            <div class="row main-low-margin">
                <div class="col-md-10 col-md-offset-1 col-sm-10 col-sm-offset-1">
                    <h3>-</h3>
                </div>
            </div>
        </div>
    </div>
    <form id="form1" runat="server">
        <div class="table-responsive" >
           <div class ="container-fluid">
                <table class="table table text-center">
                    
                    <tr>
                        <td style="text-align: left" colspan="5" >
                       <asp:Button ID="btnNuevoSeguiminetoCIs" runat="server"
                    Style="font-family: Calibri; color: #000000; font-size: medium"
                    Text="Nuevo Seguimiento Elemento Configuracion"
                    CssClass="btn btn-info" UseSubmitBehavior="False" OnClick="btnNuevoSeguiminetoCIs_Click" />


            
                        </td>
                    </tr>
                    
                    <tr>
                        <td style="text-align: left" >
                            <asp:CheckBox ID="cbnci" runat="server" CssClass="form-check-input position-static&quot" Font-Size="X-Small" Text="Nombre CI" AutoPostBack="True" OnCheckedChanged="cbnci_CheckedChanged"/>
                        </td>
                        <td style="text-align: left" >
                            <asp:CheckBox ID="cbtci" runat="server" CssClass="form-check-input position-static&quot" Font-Size="X-Small" Text="Tipo CI" AutoPostBack="True" OnCheckedChanged="cbtci_CheckedChanged"/>
                        </td>
                        <td style="text-align: left" >
                            <asp:CheckBox ID="cbans" runat="server" CssClass="form-check-input position-static&quot" Font-Size="X-Small" Text="Nro. Serie" AutoPostBack="True" OnCheckedChanged="cbans_CheckedChanged"/>
                        </td>
                        <td style="text-align: left" class="auto-style1" >
                            <asp:CheckBox ID="cbdci" runat="server" CssClass="form-check-input position-static&quot" Font-Size="X-Small" Text="Descripcion CI" AutoPostBack="True" OnCheckedChanged="cbdci_CheckedChanged"/>
                        </td>
                        <td style="text-align: left" class="auto-style1" >
                            <asp:CheckBox ID="cbs" runat="server" CssClass="form-check-input position-static&quot" Font-Size="X-Small" Text="Sede" AutoPostBack="True" OnCheckedChanged="cbs_CheckedChanged"/>
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
                             <asp:TextBox ID="tbns" runat="server" CssClass="form-control input-sm" MaxLength="25" Autocomplete = "off" placeholder="Ingresar Nro. Serie CI" onchange="" 
                        onkeypress="" Enabled="False"></asp:TextBox>
                        </td>
                        <td class="auto-style1">
                            <asp:DropDownList ID="ddldci" runat="server" CssClass="form-control input-sm" 
                                        AppendDataBoundItems="True" Enabled="False" 
                                       >
                                        <asp:ListItem Value="-1">_____SELECCIONE DESCRIPCION CI_____</asp:ListItem>
                                    </asp:DropDownList>
                        </td>
                        <td class="auto-style1">
                            <asp:DropDownList ID="ddls" runat="server" CssClass="form-control input-sm" 
                                        AppendDataBoundItems="True" Enabled="False" OnSelectedIndexChanged="ddls_SelectedIndexChanged" 
                                       >
                                        <asp:ListItem Value="-1">_____SELECCIONE SEDE_____</asp:ListItem>
                                    </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: left" >
                            <asp:CheckBox ID="cbl" runat="server" CssClass="form-check-input position-static&quot" Font-Size="X-Small" Text="Local" AutoPostBack="True" OnCheckedChanged="cbl_CheckedChanged"/>
                        </td>
                        <td style="text-align: left" >
                            <asp:CheckBox ID="cba" runat="server" CssClass="form-check-input position-static&quot" Font-Size="X-Small" Text="Area" AutoPostBack="True" OnCheckedChanged="cba_CheckedChanged"/>
                        </td>
                        <td style="text-align: left" >
                            <asp:CheckBox ID="cbrs" runat="server" CssClass="form-check-input position-static&quot" Font-Size="X-Small" Text="Responsable" AutoPostBack="True" OnCheckedChanged="cbrs_CheckedChanged"/>
                        </td>
                        <td style="text-align: left" >
                            <asp:CheckBox ID="cbcd" runat="server" CssClass="form-check-input position-static&quot" Font-Size="X-Small" Text="Clasificacion Datos" AutoPostBack="True" OnCheckedChanged="cbcd_CheckedChanged"/>
                        </td>
                        <td style="text-align: left" >
                            <asp:CheckBox ID="cbrocis" runat="server" CssClass="form-check-input position-static&quot" Font-Size="X-Small" Text="Relacion otros CIs" AutoPostBack="True" OnCheckedChanged="cbrocis_CheckedChanged"/>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: left" >
                            <asp:DropDownList ID="ddll" runat="server" CssClass="form-control input-sm" 
                                        AppendDataBoundItems="True" AutoPostBack="True" Enabled="False" OnSelectedIndexChanged="ddll_SelectedIndexChanged" 
                                       >
                                        <asp:ListItem Value="-1">_____SELECCIONE LOCAL_____</asp:ListItem>
                                    </asp:DropDownList>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddla" runat="server" CssClass="form-control input-sm" 
                                        AppendDataBoundItems="True" Enabled="False" 
                                       >
                                        <asp:ListItem Value="-1">_____SELECCIONE AREA_____</asp:ListItem>
                                    </asp:DropDownList>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlrs" runat="server" CssClass="form-control input-sm" 
                                        AppendDataBoundItems="True" Enabled="False" 
                                       >
                                        <asp:ListItem Value="-1">_____SELECCIONE RESPONSABLE_____</asp:ListItem>
                                    </asp:DropDownList>
                        </td>
                        <td class="auto-style1">
                            <asp:DropDownList ID="ddlcd" runat="server" CssClass="form-control input-sm" 
                                        AppendDataBoundItems="True" Enabled="False" 
                                       >
                                        <asp:ListItem Value="-1">_____SELECCIONE CLASIFICACION DATOS_____</asp:ListItem>
                                    </asp:DropDownList>
                        </td>
                        <td style="text-align: left" >
                            <asp:DropDownList ID="ddlrocis" runat="server" CssClass="form-control input-sm" 
                                        AppendDataBoundItems="True" Enabled="False" 
                                       >
                                        <asp:ListItem Value="-1">_____SELECCIONE RELACION OTROS CIS_____</asp:ListItem>
                                        <asp:ListItem>SI</asp:ListItem>
                                        <asp:ListItem>NO</asp:ListItem>
                                    </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: left" >
                            <asp:CheckBox ID="cbfs" runat="server" CssClass="form-check-input position-static&quot" Font-Size="X-Small" Text="Fecha Seguimiento" AutoPostBack="True" OnCheckedChanged="cbfs_CheckedChanged"/>
                        </td>
                        <td style="text-align: left" >
                            &nbsp;</td>
                        <td style="text-align: left" >
                            <asp:CheckBox ID="cbeacis" runat="server" CssClass="form-check-input position-static&quot" Font-Size="X-Small" Text="Estado Actual CIs" AutoPostBack="True" OnCheckedChanged="cbeacis_CheckedChanged"/>
                        </td>
                        <td class="auto-style1">
                            &nbsp;</td>
                        <td class="auto-style1">
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td style="text-align: left" class="auto-style2" >
                             <strong>Fecha Inicio:</strong><asp:TextBox ID="txtFechaInicioSeguimiento" runat="server"
                        class="form-control" placeholder="Ingrese fec. inicio" Width="" onFocus='' onChange='' onBlur='' Enabled="False"></asp:TextBox>

                    <input id="btnFechaInicioSeguimiento" type="button"
                        value="..." style="height: 25px; width: 25px;"
                        class="form-check" /></td>
                        <td style="text-align: left" class="auto-style2">
                            <strong>Fecha Fin</strong>:<asp:TextBox ID="txtFechaFinSeguimiento" runat="server" class="form-control" placeholder="Ingrese fec. fin" onFocus='' onChange='' onBlur='' Enabled="False"></asp:TextBox>
                    <input id="btnFechaFinSeguimineto" type="button"
                        value="..." style="height: 25px; width: 25px;" class="form-check" /></td>
                        <td style="text-align: left" class="auto-style2" >
                            <asp:DropDownList ID="ddleacis" runat="server" CssClass="form-control input-sm" 
                                        AppendDataBoundItems="True" Enabled="False" 
                                       >
                                        <asp:ListItem Value="-1">_____SELECCIONE ESTADO ACTUAL_____</asp:ListItem>
                                    </asp:DropDownList>
                        </td>
                        <td style="text-align:right" class="auto-style1">

                            <asp:LinkButton ID="lbtnBuscar" runat="server" CausesValidation="False" class="btn btn-info" Text="Buscar  &lt;span class='glyphicon glyphicon-search'&gt;&lt;/span&gt;" UseSubmitBehavior="False" OnClick="lbtnBuscar_Click" />
                            </td>
                         <td style="text-align: left" >
                            <asp:Button ID="btnActualizarInformacion" runat="server" class="btn btn-success" CssClass="btn btn-warning" Text="Actualizar Informacion" OnClick="btnActualizarInformacion_Click" />
                        </td>
                    </tr>
                    <tr>
                    <td colspan="5">
                        <asp:Table ID="Table_" runat="server" BackColor="White" 
                            class="table table-condensed"
                        BorderColor="White" CellPadding="2" CellSpacing="0" Font-Size="X-Small" 
                        GridLines="Both" style="text-align: left" Width="100%">
                        <asp:TableRow ID="CABECERA" runat="server">
                            <asp:TableCell ID="_ID_CI" runat="server" BackColor="#FFFFC0" BorderColor="#FFFFC0" 
                                     ForeColor="Green" Visible="False">ID CI</asp:TableCell>

                            <asp:TableCell ID="_NOMBRE_CI" runat="server" BackColor="Black" BorderColor="Black" 
                                ForeColor="White" Width="100px">NOMBRE CI</asp:TableCell>

                           

                            <asp:TableCell ID="_NOMBRE_TIPO_CI" runat="server" BackColor="Black" BorderColor="Black" 
                                ForeColor="White" >TIPO CI</asp:TableCell>

                            <asp:TableCell ID="_NRO_SERIE" runat="server" BackColor="Black" BorderColor="Black" 
                                ForeColor="White" >NRO. SERIE</asp:TableCell>

                            <asp:TableCell ID="_FABRICANTE_O_PROVEEDOR" runat="server" BackColor="Black" BorderColor="Black" 
                                ForeColor="White" Visible="false">FEBRICANTE / PROVEEDOR</asp:TableCell>

                            <asp:TableCell ID="_MARCA" runat="server" BackColor="Black" BorderColor="Black" 
                                ForeColor="White" Visible="false">MARCA</asp:TableCell>

                            <asp:TableCell ID="_MODELO" runat="server" BackColor="Black" BorderColor="Black" 
                                ForeColor="White" Visible="false">MODELO</asp:TableCell>

                            <asp:TableCell ID="_ESTADO_CI" runat="server" BackColor="Black" BorderColor="Black" 
                                ForeColor="White" Visible="false">ESTADO CI</asp:TableCell>

                            <asp:TableCell ID="_DESCRIPCION_CI" runat="server" BackColor="Black" BorderColor="Black" 
                                ForeColor="White" >DESCRIPCION CI</asp:TableCell>
                           
                            <asp:TableCell ID="_SEDE" runat="server" BackColor="Black" BorderColor="Black" 
                                ForeColor="White" >SEDE / LOCAL</asp:TableCell>

                           
                            <asp:TableCell ID="_UBICACION_LOCAL" runat="server" BackColor="Black" BorderColor="Black" 
                                ForeColor="White" >UBICACION / DIRECCION LOCAL</asp:TableCell>

                           
                            
                            <asp:TableCell ID="_AREA" runat="server" BackColor="Black" BorderColor="Black" 
                                ForeColor="White" >AREA / NRO PISO / NRO AMBIENTE</asp:TableCell>

                            <asp:TableCell ID="_RESPONSABLE_SEGUIMIENTO" runat="server" BackColor="Black" BorderColor="Black" 
                                ForeColor="White" >RESPONSABLE SEGUIMIENTO</asp:TableCell>

                            <asp:TableCell ID="_FECHA_SEGUIMIENTO" runat="server" BackColor="Black" BorderColor="Black" 
                                ForeColor="White" >FECHA SEGUIMIENTO</asp:TableCell>

                            <asp:TableCell ID="_CLASIFICACION_DATOS" runat="server" BackColor="Black" BorderColor="Black" 
                                ForeColor="White" >CLASIFICACION DATOS</asp:TableCell>
                            
                            <asp:TableCell ID="_ESTADO_ACTUAL" runat="server" BackColor="Black" BorderColor="Black" 
                                ForeColor="White" Width="120px">ESTADO ACTUAL</asp:TableCell>

                            <asp:TableCell ID="_RELACION_CIS" runat="server" BackColor="Black" BorderColor="Black" 
                                ForeColor="White" >RELACION OTROS CIs</asp:TableCell> 

                            <asp:TableCell ID="_CUMPLE_POLITICA_GESTION_CONIGURACION_ORGANIZACION" runat="server" BackColor="Black" BorderColor="Black" 
                                ForeColor="White" >CUMPLE POLITICA GESTION CONIGURACION ORGANIZACION</asp:TableCell> 

                            <asp:TableCell ID="_OBSERVACION" runat="server" BackColor="Black" BorderColor="Black" 
                                ForeColor="White" >OBSERVACION</asp:TableCell>  

                            
                            <asp:TableCell ID="SEGUIMINETO" runat="server" BackColor="Black" BorderColor="Black" 
                                ForeColor="White" Width="3%" HorizontalAlign="Center">SEGUIMIENTO</asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                    </td>
                   
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

    <script type="text/javascript">//<![CDATA[
        Calendar.setup({
            inputField: "txtFechaInicioSeguimiento",
            trigger: "btnFechaInicioSeguimiento",
            onSelect: function () { this.hide() },
            showTime: 12,
            dateFormat: "%d/%m/%Y"
        });
        Calendar.setup({
            inputField: "txtFechaFinSeguimiento",
            trigger: "btnFechaFinSeguimineto",
            onSelect: function () { this.hide() },
            showTime: 12,
            dateFormat: "%d/%m/%Y"
        });
        //]]></script>

     <script type="text/javascript" src="../bootstrap/js/jquery-1.12.4.min.js"></script>
     <script type="text/javascript" src="../bootstrap/js/bootstrap.min.js"></script>
</body>
</html>
