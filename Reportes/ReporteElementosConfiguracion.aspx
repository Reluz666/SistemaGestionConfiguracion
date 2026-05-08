<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ReporteElementosConfiguracion.aspx.cs" Inherits="ReporteElementosConfiguracion"  UnobtrusiveValidationMode="None" %>

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
        //AGREGADO EN REQUE EL MARTES 21 DE MARZO DEL 2023
        function abrir_ventana_imprimir_reporte(Opcion) {
            if (Verificar_Datos_tabla(Opcion)) {
                window.name = "Lista de Personal";
                var options = 'channelmode=1,directories=0,fullscreen=0,location=0,menubar=0,resizable=no,titlebar=0,toolbar=0,edge=Raised,status=no,scrollbars=1,width=1000,height=500,top=70px, left=175px';
                window.open('../Reportes/Reporte.aspx', '', options);
            }
            //            if (window.confirm('¿Desea imprimir el reporte?')) {
            //                window.name = "Lista de Personal";
            //                var options = 'channelmode=1,directories=0,fullscreen=0,location=0,menubar=0,resizable=no,titlebar=0,toolbar=0,edge=Raised,status=no,scrollbars=1,width=1000,height=500,top=70px, left=175px';
            //                window.open('../Reportes/Reporte.aspx', '', options);
            //            }
        }

        //********************** AGREGADO EN REQUE EL 21-03-2023 ***************************
        function Verificar_Datos_tabla(Opcion) {
            var Pregunta = '';
            var Mensaje = '';
            if (Opcion == 1) {
                Pregunta = "¿Desea exportar los datos a Microsoft Office Excel...?";
                Mensaje = "No hay datos para exportar a Microsoft Office Excel.";
            }
            else if (Opcion == 2) {
                Pregunta = "¿Desea imprimir el reporte?";
                Mensaje = "No hay datos para imprimir el reporte.";
            }
            var tabla = document.getElementById("Table_");
            var tabla_longitud = (tabla.rows.length) - 1;

            //            alert(tabla_longitud);


            var Ok, Rpta;
            Ok = true;
            Rpta = confirm(Pregunta);
            if (Rpta == 1)//Aceptar
            {
                if (tabla_longitud == 0) {
                    Ok = false;
                    alert(Mensaje);
                } else {
                    ;
                }
            }
            else {
                Ok = false;
            }
            return Ok;
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
                        <li><a href="../Reportes/ReporteDatosIncorrectosCI.aspx" runat="server" id="A22">Reporte de Datos Incorrectos de Elementos de Configuraci&oacute;n</a></li>
                        <li><a href="../Reportes/ReporteCIsInformacionContenidaEnCMDB.aspx" runat="server" id="A23">Reporte de Informaci&oacute;n de Elementos de Configuraci&oacute;n Contenidas en la CMDB</a></li>
                             
                        
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
                        <td style="text-align: left" colspan="5">                             
                            &nbsp;</td>
                        <td style="text-align: left">                             
                            &nbsp;</td>
                    </tr>
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
                            <asp:CheckBox ID="cbr" runat="server" CssClass="form-check-input position-static&quot" Font-Size="X-Small" Text="Responsable" AutoPostBack="True" OnCheckedChanged="cbr_CheckedChanged"/>
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
                        <td class="auto-style1">
                            <asp:DropDownList ID="ddlr" runat="server" CssClass="form-control input-sm" 
                                        AppendDataBoundItems="True" Enabled="False" 
                                       >
                                        <asp:ListItem Value="-1">_____SELECCIONE RESPONSABLE_____</asp:ListItem>
                                    </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: left" >
                            <asp:CheckBox ID="cbnp" runat="server" CssClass="form-check-input position-static&quot" Font-Size="X-Small" Text="Nivel Prioridad" AutoPostBack="True" OnCheckedChanged="cbnp_CheckedChanged"/>
                        </td>
                        <td style="text-align: left" >
                            <asp:CheckBox ID="cbm" runat="server" CssClass="form-check-input position-static&quot" Font-Size="X-Small" Text="Marca" AutoPostBack="True" OnCheckedChanged="cbm_CheckedChanged"/>
                        </td>
                        <td style="text-align: left" >
                            <asp:CheckBox ID="cbmo" runat="server" CssClass="form-check-input position-static&quot" Font-Size="X-Small" Text="Modelo" AutoPostBack="True" OnCheckedChanged="cbmo_CheckedChanged"/>
                        </td>
                        <td style="text-align: left" >
                            <asp:CheckBox ID="cbf" runat="server" CssClass="form-check-input position-static&quot" Font-Size="X-Small" Text="Fecha Registro CI" AutoPostBack="True" OnCheckedChanged="cbf_CheckedChanged"/>
                        </td>
                        <td class="auto-style1">
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td style="text-align: left" >
                            <asp:DropDownList ID="ddlnp" runat="server" CssClass="form-control input-sm" 
                                        AppendDataBoundItems="True" Enabled="False" 
                                       >
                                        <asp:ListItem Value="-1">_____SELECCIONE NIVEL PRIORIDAD_____</asp:ListItem>
                                    </asp:DropDownList>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlm" runat="server" CssClass="form-control input-sm" 
                                        AppendDataBoundItems="True" Enabled="False" 
                                       >
                                        <asp:ListItem Value="-1">_____SELECCIONE MARCA_____</asp:ListItem>
                                    </asp:DropDownList>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlmo" runat="server" CssClass="form-control input-sm" 
                                        AppendDataBoundItems="True" Enabled="False" 
                                       >
                                        <asp:ListItem Value="-1">_____SELECCIONE MODELO_____</asp:ListItem>
                                    </asp:DropDownList>
                        </td>
                        <td style="text-align: left" >
                            <strong>Fec. Ini:</strong><asp:TextBox ID="txtfi" runat="server"
                        class="form-control" placeholder="Ingrese fec. inicio" Width="" onFocus='' onChange='' onBlur='' Enabled="False"></asp:TextBox>

                    <input id="btnfi" type="button"
                        value="..." style="height: 25px; width: 25px;"
                        class="form-check" /></td>
                        <td style="text-align: left" >
                            <strong>Fec. Fin</strong>:<asp:TextBox ID="txtff" runat="server" class="form-control" placeholder="Ingrese fec. fin" onFocus='' onChange='' onBlur='' Enabled="False"></asp:TextBox>
                    <input id="btnff" type="button"
                        value="..." style="height: 25px; width: 25px;" class="form-check" /></td>
                    </tr>
                    <tr>
                        <td style="text-align: left" >
                            &nbsp;</td>
                        <td>
                            &nbsp;</td>
                        <td>
                            &nbsp;</td>
                        <td style="text-align: left" >
                            <asp:LinkButton ID="lbtnBuscar" runat="server" CausesValidation="False" class="btn btn-info" OnClick="lbtnBuscar_Click" Text="Buscar  &lt;span class='glyphicon glyphicon-search'&gt;&lt;/span&gt;" UseSubmitBehavior="False" />
                            <asp:Button ID="btnActualizarInformacion" runat="server" class="btn btn-success" CssClass="btn btn-warning" onclick="btnActualizarInformacion_Click" Text="Actualizar Informacion" />
                        </td>
                        <td class="auto-style1">
                            <asp:HyperLink ID="IMPRIMIR" runat="server" BorderStyle="None" class="btn btn-info" NavigateUrl="" onClick="abrir_ventana_imprimir_reporte(2);">Imprimir reporte</asp:HyperLink>
                        </td>
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

                          <%--  <asp:TableCell ID="_ID_TIPO_CI" runat="server" BackColor="Black" BorderColor="Black" 
                                ForeColor="White" Visible="False">ID TIPO CI</asp:TableCell>--%>

                            <asp:TableCell ID="_NOMBRE_TIPO_CI" runat="server" BackColor="Black" BorderColor="Black" 
                                ForeColor="White" >TIPO CI</asp:TableCell>

                            <asp:TableCell ID="_NRO_SERIE" runat="server" BackColor="Black" BorderColor="Black" 
                                ForeColor="White" >NRO SERIE</asp:TableCell>

                             <asp:TableCell ID="_FABRICANTE_O_PROVEEDOR" runat="server" BackColor="Black" BorderColor="Black" 
                                ForeColor="White" >FABRICANTE<BR />PROVEEDOR</asp:TableCell>

                             <asp:TableCell ID="_MARCA_MODELO" runat="server" BackColor="Black" BorderColor="Black" 
                                ForeColor="White" >MARCA /<br />MODELO</asp:TableCell>

                            <asp:TableCell ID="_IP" runat="server" BackColor="Black" BorderColor="Black" 
                                ForeColor="White" >IP</asp:TableCell>

                            <asp:TableCell ID="_GATEWAY" runat="server" BackColor="Black" BorderColor="Black" 
                                ForeColor="White" >GATEWAY</asp:TableCell>

                            <asp:TableCell ID="_GRUPO_TRABAJO" runat="server" BackColor="Black" BorderColor="Black" 
                                ForeColor="White" >GRUPO<BR />TRABAJO</asp:TableCell>

                            <asp:TableCell ID="_ESTADO_CI" runat="server" BackColor="Black" BorderColor="Black" 
                                ForeColor="White" >ESTADO CI</asp:TableCell>

                          <%--  <asp:TableCell ID="_ID_PROPIETARIO" runat="server" BackColor="Black" BorderColor="Black" 
                                ForeColor="White" Visible="False">ID_PROPIETARIO</asp:TableCell>--%>

                            <asp:TableCell ID="_PROPIETARIO" runat="server" BackColor="Black" BorderColor="Black" 
                                ForeColor="White" Visible="True">PROPIETARIO CI</asp:TableCell>

                            <asp:TableCell ID="_DESCRIPCION_CI" runat="server" BackColor="Black" BorderColor="Black" 
                                ForeColor="White" >DESCRIPCION CI</asp:TableCell>

                            <asp:TableCell ID="_IMPACTO__PRIORIDAD_CI" runat="server" BackColor="Black" BorderColor="Black" 
                                ForeColor="White" >IMPACTO / PRIORIDAD</asp:TableCell>

                            <%--<asp:TableCell ID="_IMPACTO_CI" runat="server" BackColor="Black" BorderColor="Black" 
                                ForeColor="White" >IMPACTO COMERCIAL CI</asp:TableCell>

                                <asp:TableCell ID="_NIVEL_PRIORIDAD" runat="server" BackColor="Black" BorderColor="Black" 
                                ForeColor="White" >INIVEL PRIORIDAD CI</asp:TableCell>--%>

                            <asp:TableCell ID="_SEDE_LOCAL" runat="server" BackColor="Black" BorderColor="Black" 
                                ForeColor="White" >SEDE / <br />LOCAL</asp:TableCell>
                            <%--<asp:TableCell ID="_LOCAL" runat="server" BackColor="Black" BorderColor="Black" 
                                ForeColor="White" >LOCAL</asp:TableCell>--%>
                            <asp:TableCell ID="_UBICACION_LOCAL" runat="server" BackColor="Black" BorderColor="Black" 
                                ForeColor="White" Visible="false" >UBICACION LOCAL</asp:TableCell>
                            <asp:TableCell ID="_DIRECCION_LOCAL" runat="server" BackColor="Black" BorderColor="Black" 
                                ForeColor="White" Visible="false" >DIRECCION LOCAL</asp:TableCell>
                            <%--<asp:TableCell ID="_ID_AREA" runat="server" BackColor="Black" BorderColor="Black" 
                                ForeColor="White" Visible="False">ID AREA LOCAL</asp:TableCell>--%>
                            <asp:TableCell ID="_AREA" runat="server" BackColor="Black" BorderColor="Black" 
                                ForeColor="White" >AREA</asp:TableCell>
                            <asp:TableCell ID="_NRO_PISO_AMBIENTE" runat="server" BackColor="Black" BorderColor="Black" 
                                ForeColor="White" >NRO<br /> PISO / <br />AMBIENTE</asp:TableCell>
                            <%--<asp:TableCell ID="_NRO_AMBIENTE" runat="server" BackColor="Black" BorderColor="Black" 
                                ForeColor="White" >NRO AMBIENTE</asp:TableCell>--%>
                            <asp:TableCell ID="_FEC_CREACION_CI" runat="server" BackColor="Black" BorderColor="Black" 
                                ForeColor="White" >FEC. CREACION</asp:TableCell>
                           <%-- <asp:TableCell ID="_ID_RESPONSABLE" runat="server" BackColor="Black" BorderColor="Black" 
                                ForeColor="White" Visible="False">ID RESPONSABLE</asp:TableCell>--%>
                            <asp:TableCell ID="_RESPONSABLE" runat="server" BackColor="Black" BorderColor="Black" 
                                ForeColor="White" >RESPONSABLE REGISTRO CI</asp:TableCell>
                           
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
     <script type="text/javascript">//<![CDATA[
        Calendar.setup({
            inputField: "txtfi",
            trigger: "btnfi",
            onSelect: function () { this.hide() },
            showTime: 12,
            dateFormat: "%d/%m/%Y"
        });
        Calendar.setup({
            inputField: "txtff",
            trigger: "btnff",
            onSelect: function () { this.hide() },
            showTime: 12,
            dateFormat: "%d/%m/%Y"
        });
        //]]></script>	
    <script lang ="JavaScript" type="text/javascript">
        ResaltarFila('Table_');
    </script>	

     <script type="text/javascript" src="../bootstrap/js/jquery-1.12.4.min.js"></script>
     <script type="text/javascript" src="../bootstrap/js/bootstrap.min.js"></script>
</body>
</html>
