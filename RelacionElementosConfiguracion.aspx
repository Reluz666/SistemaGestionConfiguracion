<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RelacionElementosConfiguracion.aspx.cs" Inherits="RelacionElementosConfiguracion"  UnobtrusiveValidationMode="None"%>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Relecion Elmentos Configuracion</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>    
    <meta charset="utf-8"/>    
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>

    <!-- Bootstrap -->
    <link href="../bootstrap/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="CssJs/Menu.css" rel="stylesheet" />

    <script  src="../Otros_css_js/resaltar.js" type="text/javascript"></script>
    <link rel="stylesheet" href="../Otros_css_js/estilo.css" type="text/css" />

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

        function abrir_ventana_Obtener_Elementos_Configuracion(Opcion) {
            if (Opcion == 1) {
                window.document.getElementById("ID_CI_P").value = 0;
                window.document.getElementById("Nombre_CI_P").value = "";
                window.document.getElementById("Tipo_CI_P").value = "";
                window.document.getElementById("Estado_CI_P").value = "";
                window.document.getElementById("Propietario_CI_P").value = "";
                window.document.getElementById("Descripcion_CI_P").value = "";
                window.document.getElementById("Sede_P").value = "";
                window.document.getElementById("Local_P").value = "";
                window.document.getElementById("Area_P").value = "";
                window.document.getElementById("NroPiso_P").value = "";
                window.document.getElementById("NroAmbiente_P").value = "";
                window.document.getElementById("Ubicacion_P").value = "";
                window.document.getElementById("Direccion_P").value = "";
                window.document.getElementById("NivelPrioridad_CI_P").value = "";
            } else if (Opcion == 2) {
                window.document.getElementById("ID_CI_H").value = 0;
                window.document.getElementById("Nombre_CI_H").value = "";
                window.document.getElementById("Tipo_CI_H").value = "";
                window.document.getElementById("Estado_CI_H").value = "";
                window.document.getElementById("Propietario_CI_H").value = "";
                window.document.getElementById("Descripcion_CI_H").value = "";
                window.document.getElementById("Sede_H").value = "";
                window.document.getElementById("Local_H").value = "";
                window.document.getElementById("Area_H").value = "";
                window.document.getElementById("NroPiso_H").value = "";
                window.document.getElementById("NroAmbiente_H").value = "";
                window.document.getElementById("Ubicacion_H").value = "";
                window.document.getElementById("Direccion_H").value = "";
                window.document.getElementById("NivelPrioridad_CI_H").value = "";
            }
            var options = 'channelmode=1,directories=0,fullscreen=0,location=0,menubar=0,resizable=0,titlebar=0,toolbar=0,edge=Raised,status=no,scrollbars=1,width=1000,height=550,top=50px, left=175px';
            window.open('Ventanas/ventanaObtenerElemtosConfiguracion.aspx?Nivel=' + Opcion, '', options);
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
            document.getElementById('<%= Nombre_CI_P.ClientID %>').readOnly = true;
            document.getElementById('<%= Tipo_CI_P.ClientID %>').readOnly = true;
            document.getElementById('<%= Estado_CI_P.ClientID %>').readOnly = true;
            document.getElementById('<%= Propietario_CI_P.ClientID %>').readOnly = true;
            document.getElementById('<%= Descripcion_CI_P.ClientID %>').readOnly = true;
            document.getElementById('<%= Sede_P.ClientID %>').readOnly = true;
            document.getElementById('<%= Local_P.ClientID %>').readOnly = true;
            document.getElementById('<%= Area_P.ClientID %>').readOnly = true;
            document.getElementById('<%= NroPiso_P.ClientID %>').readOnly = true;
            document.getElementById('<%= NroAmbiente_P.ClientID %>').readOnly = true;
            document.getElementById('<%= Ubicacion_P.ClientID %>').readOnly = true;
            document.getElementById('<%= Direccion_P.ClientID %>').readOnly = true;
            document.getElementById('<%= NivelPrioridad_CI_P.ClientID %>').readOnly = true;

            document.getElementById('<%= Nombre_CI_H.ClientID %>').readOnly = true;
            document.getElementById('<%= Tipo_CI_H.ClientID %>').readOnly = true;
            document.getElementById('<%= Estado_CI_H.ClientID %>').readOnly = true;
            document.getElementById('<%= Propietario_CI_H.ClientID %>').readOnly = true;
            document.getElementById('<%= Descripcion_CI_H.ClientID %>').readOnly = true;
            document.getElementById('<%= Sede_H.ClientID %>').readOnly = true;
            document.getElementById('<%= Local_H.ClientID %>').readOnly = true;
            document.getElementById('<%= Area_H.ClientID %>').readOnly = true;
            document.getElementById('<%= NroPiso_H.ClientID %>').readOnly = true;
            document.getElementById('<%= NroAmbiente_H.ClientID %>').readOnly = true;
            document.getElementById('<%= Ubicacion_H.ClientID %>').readOnly = true;
            document.getElementById('<%= Direccion_H.ClientID %>').readOnly = true;
            document.getElementById('<%= NivelPrioridad_CI_H.ClientID %>').readOnly = true;
           
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
                        <td style="text-align: center; color: #FFFFFF; background-color: #000000;" colspan="7">
                            Ingrese Datos Relacion Elementos de Configuracion
                            Padre</td>
                    </tr>
                    <tr>
                        <td style="text-align: left; color: #FFFFFF; background-color: #000000;">
                            Nombre
                            CI</td>
                        <td style="text-align: left; color: #FFFFFF; background-color: #000000;">
                            Tipo
                            CI</td>
                        <td style="text-align: left; color: #FFFFFF; background-color: #000000;">
                            Estado
                            CI</td>
                        <td style="text-align: left; color: #FFFFFF; background-color: #000000;">
                            Propietario
                            CI</td>
                        <td style="text-align: left; color: #FFFFFF; background-color: #000000;">
                            Descripcion
                            CI</td>
                       
                        <td style="text-align: left; color: #FFFFFF; background-color: #000000;">
                            Nivel Prioridad
                            CI</td>
                         <td style="text-align: left; color: #FFFFFF; background-color: #000000;">

                             Sede</td>
                    </tr>
                    <tr>
                    <td style="text-align: left;"">

                             <asp:TextBox ID="Nombre_CI_P" runat="server" CssClass="form-control input-sm" MaxLength="30" Autocomplete = "off" placeholder="" onchange="" 
                        onkeypress=""></asp:TextBox>

                             <asp:RequiredFieldValidator ID="rfvNombre_CI_P" runat="server" ControlToValidate="Nombre_CI_P" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>

                        </td>
                      <td style="text-align: left;"">

                             <asp:TextBox ID="Tipo_CI_P" runat="server" CssClass="form-control input-sm" MaxLength="30" Autocomplete = "off" placeholder="" onchange="" 
                        onkeypress=""></asp:TextBox>

                             <asp:RequiredFieldValidator ID="rfvTipo_CI_P" runat="server" ControlToValidate="Tipo_CI_P" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>

                        </td>
                    <td style="text-align: left;"">

                             <asp:TextBox ID="Estado_CI_P" runat="server" CssClass="form-control input-sm" MaxLength="30" Autocomplete = "off" placeholder="" onchange="" 
                        onkeypress=""></asp:TextBox>

                             <asp:RequiredFieldValidator ID="rfvEstado_CI_P" runat="server" ControlToValidate="Estado_CI_P" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>

                        </td>
                    <td style="text-align: left;"">

                             <asp:TextBox ID="Propietario_CI_P" runat="server" CssClass="form-control input-sm" MaxLength="30" Autocomplete = "off" placeholder="" onchange="" 
                        onkeypress=""></asp:TextBox>

                             <asp:RequiredFieldValidator ID="rfvPropietario_CI_P" runat="server" ControlToValidate="Propietario_CI_P" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>

                        </td>
                   <td style="text-align: left;"">

                             <asp:TextBox ID="Descripcion_CI_P" runat="server" CssClass="form-control input-sm" MaxLength="30" Autocomplete = "off" placeholder="" onchange="" 
                        onkeypress=""></asp:TextBox>

                             <asp:RequiredFieldValidator ID="rfvDescripcion_CI_P" runat="server" ControlToValidate="Descripcion_CI_P" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>

                        </td>
                    
                     <td style="text-align: left;"">

                             <asp:TextBox ID="NivelPrioridad_CI_P" runat="server" CssClass="form-control input-sm" MaxLength="30" Autocomplete = "off" placeholder="" onchange="" 
                        onkeypress=""></asp:TextBox>

                             <asp:RequiredFieldValidator ID="rfvNivelPrioridad_CI_P" runat="server" ControlToValidate="NivelPrioridad_CI_P" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>

                        </td>

                        <td style="text-align: left;"">

                             <asp:TextBox ID="Sede_P" runat="server" CssClass="form-control input-sm" MaxLength="30" Autocomplete = "off" placeholder="" onchange="" 
                        onkeypress=""></asp:TextBox>

                             <asp:RequiredFieldValidator ID="rfvSede_P" runat="server" ControlToValidate="Sede_P" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>

                         </td>
                    
                    </tr>
                    <tr>
                    <td style="text-align: left; color: #FFFFFF; background-color: #000000;">

                             Local</td>
                      <td style="text-align: left; color: #FFFFFF; background-color: #000000;">

                             Area</td>
                       <td style="text-align: left; color: #FFFFFF; background-color: #000000;">

                             Nro. Piso</td>
                       <td style="text-align: left; color: #FFFFFF; background-color: #000000;">

                             Nro. Ambiente</td>
                       <td style="text-align: left; color: #FFFFFF; background-color: #000000;">

                             Ubicacion</td> 
                       <td style="text-align: left; color: #FFFFFF; background-color: #000000;">

                             Direccion</td> 
                    </tr>
                    <tr>
                    <td style="text-align: left; color: #FFFFFF; background-color: #FFFFFF;">

                             <asp:TextBox ID="Local_P" runat="server" CssClass="form-control input-sm" MaxLength="30" Autocomplete = "off" placeholder="" onchange="" 
                        onkeypress=""></asp:TextBox>

                             <asp:RequiredFieldValidator ID="rfvLocal_P" runat="server" ControlToValidate="Local_P" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>

                        </td>
                      <td style="text-align: left; color: #FFFFFF; background-color: #FFFFFF;">

                             <asp:TextBox ID="Area_P" runat="server" CssClass="form-control input-sm" MaxLength="30" Autocomplete = "off" placeholder="" onchange="" 
                        onkeypress=""></asp:TextBox>

                             <asp:RequiredFieldValidator ID="rfvArea_P" runat="server" ControlToValidate="Area_P" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>

                        </td>
                        <td style="text-align: left; color: #FFFFFF; background-color: #FFFFFF;">

                             <asp:TextBox ID="NroPiso_P" runat="server" CssClass="form-control input-sm" MaxLength="30" Autocomplete = "off" placeholder="" onchange="" 
                        onkeypress=""></asp:TextBox>

                             <asp:RequiredFieldValidator ID="rfvNroPiso_P" runat="server" ControlToValidate="NroPiso_P" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>

                        </td>
                        <td style="text-align: left; color: #FFFFFF; background-color: #FFFFFF;">

                             <asp:TextBox ID="NroAmbiente_P" runat="server" CssClass="form-control input-sm" MaxLength="30" Autocomplete = "off" placeholder="" onchange="" 
                        onkeypress=""></asp:TextBox>

                             <asp:RequiredFieldValidator ID="rfvNroAmbiente_P" runat="server" ControlToValidate="NroAmbiente_P" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>

                        </td>
                        <td style="text-align: left; color: #FFFFFF; background-color: #FFFFFF;">

                             <asp:TextBox ID="Ubicacion_P" runat="server" CssClass="form-control input-sm" MaxLength="30" Autocomplete = "off" placeholder="" onchange="" 
                        onkeypress=""></asp:TextBox>

                             <asp:RequiredFieldValidator ID="rfvUbicacion_P" runat="server" ControlToValidate="Ubicacion_P" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>

                        </td>
                        <td style="text-align: left; color: #FFFFFF; background-color: #FFFFFF;">

                             <asp:TextBox ID="Direccion_P" runat="server" CssClass="form-control input-sm" MaxLength="30" Autocomplete = "off" placeholder="" onchange="" 
                        onkeypress=""></asp:TextBox>

                             <asp:RequiredFieldValidator ID="rfvDireccion_P" runat="server" ControlToValidate="Direccion_P" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>

                        </td>
                    
                    </tr>
                    <tr>
                    <td style="text-align: center;" colspan="7">

                    <asp:HiddenField ID="ID_CI_P" runat="server" Value="0" 
                        EnableViewState="False" />
                        <asp:Button ID="btnBuscar_CI_P" runat="server" Text="Buscar Elementos Configuracion Padre" class="btn btn-primary btn-sm" CausesValidation="False" OnClientClick="abrir_ventana_Obtener_Elementos_Configuracion(1);"/>

                     </td>
                    
                    </tr>
                    <tr>
                        <td style="text-align: center; background-color: #000000;" colspan="7" class="auto-style1">
                            Ingrese Datos Relacion Elementos de Configuracion
                            Hijo</td>
                    </tr>
                    <tr>
                        <td style="text-align: left; color: #FFFFFF; background-color: #000000;">
                            Nombre
                            CI</td>
                        <td style="text-align: left; color: #FFFFFF; background-color: #000000;">
                            Tipo
                            CI</td>
                        <td style="text-align: left; color: #FFFFFF; background-color: #000000;">
                            Estado
                            CI</td>
                        <td style="text-align: left; color: #FFFFFF; background-color: #000000;">
                            Propietario
                            CI</td>
                        <td style="text-align: left; color: #FFFFFF; background-color: #000000;">
                            Descripcion
                            CI</td>
                        <td style="text-align: left; color: #FFFFFF; background-color: #000000;">
                            Nivel Prioridad
                            CI</td>
                        <td style="text-align: left; color: #FFFFFF; background-color: #000000;">

                             Sede</td>
                    </tr>
                    <tr>
                    <td style="text-align: left;"">

                             <asp:TextBox ID="Nombre_CI_H" runat="server" CssClass="form-control input-sm" MaxLength="30" Autocomplete = "off" placeholder="" onchange="" 
                        onkeypress=""></asp:TextBox>

                             <asp:RequiredFieldValidator ID="rfvNombre_CI_H" runat="server" ControlToValidate="Nombre_CI_H" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>

                        </td>
                      <td style="text-align: left;"">

                             <asp:TextBox ID="Tipo_CI_H" runat="server" CssClass="form-control input-sm" MaxLength="30" Autocomplete = "off" placeholder="" onchange="" 
                        onkeypress=""></asp:TextBox>

                             <asp:RequiredFieldValidator ID="rfvTipo_CI_H" runat="server" ControlToValidate="Tipo_CI_H" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>

                        </td>
                    <td style="text-align: left;"">

                             <asp:TextBox ID="Estado_CI_H" runat="server" CssClass="form-control input-sm" MaxLength="30" Autocomplete = "off" placeholder="" onchange="" 
                        onkeypress=""></asp:TextBox>

                             <asp:RequiredFieldValidator ID="rfvEstado_CI_H" runat="server" ControlToValidate="Estado_CI_H" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>

                        </td>
                    <td style="text-align: left;"">

                             <asp:TextBox ID="Propietario_CI_H" runat="server" CssClass="form-control input-sm" MaxLength="30" Autocomplete = "off" placeholder="" onchange="" 
                        onkeypress=""></asp:TextBox>

                             <asp:RequiredFieldValidator ID="rfvPropietario_CI_H" runat="server" ControlToValidate="Propietario_CI_H" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>

                        </td>
                   <td style="text-align: left;"">

                             <asp:TextBox ID="Descripcion_CI_H" runat="server" CssClass="form-control input-sm" MaxLength="30" Autocomplete = "off" placeholder="" onchange="" 
                        onkeypress=""></asp:TextBox>

                             <asp:RequiredFieldValidator ID="rfvDescripcion_CI_H" runat="server" ControlToValidate="Descripcion_CI_H" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>

                        </td>
                     <td style="text-align: left;"">

                             <asp:TextBox ID="NivelPrioridad_CI_H" runat="server" CssClass="form-control input-sm" MaxLength="30" Autocomplete = "off" placeholder="" onchange="" 
                        onkeypress=""></asp:TextBox>

                             <asp:RequiredFieldValidator ID="rfvNivelPrioridad_CI_H" runat="server" ControlToValidate="NivelPrioridad_CI_H" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>

                        </td>
                     <td style="text-align: left;"">

                             <asp:TextBox ID="Sede_H" runat="server" CssClass="form-control input-sm" MaxLength="30" Autocomplete = "off" placeholder="" onchange="" 
                        onkeypress=""></asp:TextBox>

                             <asp:RequiredFieldValidator ID="rfvSede_H" runat="server" ControlToValidate="Sede_H" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>

                        </td>
                    
                    </tr>
                    <tr>
                    <td style="text-align: left; color: #FFFFFF; background-color: #000000;">

                             Local</td>
                      <td style="text-align: left; color: #FFFFFF; background-color: #000000;">

                             Area</td>
                       <td style="text-align: left; color: #FFFFFF; background-color: #000000;">

                             Nro. Piso</td>
                       <td style="text-align: left; color: #FFFFFF; background-color: #000000;">

                             Nro. Ambiente</td>
                       <td style="text-align: left; color: #FFFFFF; background-color: #000000;">

                             Ubicacion</td> 
                       <td style="text-align: left; color: #FFFFFF; background-color: #000000;">

                             Direccion</td> 
                    </tr>
                    <tr>
                    <td style="text-align: left; color: #FFFFFF; background-color: #FFFFFF;">

                             <asp:TextBox ID="Local_H" runat="server" CssClass="form-control input-sm" MaxLength="30" Autocomplete = "off" placeholder="" onchange="" 
                        onkeypress=""></asp:TextBox>

                             <asp:RequiredFieldValidator ID="rfvLocal_H" runat="server" ControlToValidate="Local_H" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>

                        </td>
                      <td style="text-align: left; color: #FFFFFF; background-color: #FFFFFF;">

                             <asp:TextBox ID="Area_H" runat="server" CssClass="form-control input-sm" MaxLength="30" Autocomplete = "off" placeholder="" onchange="" 
                        onkeypress=""></asp:TextBox>

                             <asp:RequiredFieldValidator ID="rfvArea_H" runat="server" ControlToValidate="Area_H" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>

                        </td>
                        <td style="text-align: left; color: #FFFFFF; background-color: #FFFFFF;">

                             <asp:TextBox ID="NroPiso_H" runat="server" CssClass="form-control input-sm" MaxLength="30" Autocomplete = "off" placeholder="" onchange="" 
                        onkeypress=""></asp:TextBox>

                             <asp:RequiredFieldValidator ID="rfvNroPiso_H" runat="server" ControlToValidate="NroPiso_H" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>

                        </td>
                        <td style="text-align: left; color: #FFFFFF; background-color: #FFFFFF;">

                             <asp:TextBox ID="NroAmbiente_H" runat="server" CssClass="form-control input-sm" MaxLength="30" Autocomplete = "off" placeholder="" onchange="" 
                        onkeypress=""></asp:TextBox>

                             <asp:RequiredFieldValidator ID="rfvNroAmbiente_H" runat="server" ControlToValidate="NroAmbiente_H" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>

                        </td>
                        <td style="text-align: left; color: #FFFFFF; background-color: #FFFFFF;">

                             <asp:TextBox ID="Ubicacion_H" runat="server" CssClass="form-control input-sm" MaxLength="30" Autocomplete = "off" placeholder="" onchange="" 
                        onkeypress=""></asp:TextBox>

                             <asp:RequiredFieldValidator ID="rfvUbicacion_H" runat="server" ControlToValidate="Ubicacion_H" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>

                        </td>
                        <td style="text-align: left; color: #FFFFFF; background-color: #FFFFFF;">

                             <asp:TextBox ID="Direccion_H" runat="server" CssClass="form-control input-sm" MaxLength="30" Autocomplete = "off" placeholder="" onchange="" 
                        onkeypress=""></asp:TextBox>

                             <asp:RequiredFieldValidator ID="rfvDireccion_H" runat="server" ControlToValidate="Direccion_H" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>

                        </td>
                    
                    </tr>
                    <tr>
                    <td style="text-align: center;" colspan="7">

                    <asp:HiddenField ID="ID_CI_H" runat="server" Value="0" 
                        EnableViewState="False" />
                        <asp:Button ID="btnBuscar_CI_H" runat="server" Text="Buscar Elementos Configuracion Hijo" class="btn btn-primary btn-sm" CausesValidation="False" OnClientClick="abrir_ventana_Obtener_Elementos_Configuracion(2);"/>

                     </td>
                    
                    </tr>
                     <tr>
                        <td style="text-align: left; color: #FFFFFF; background-color: #000000;" colspan="2">
                            Tipo Relacion Elemento Configuracion:</td>
                        <td style="text-align: left; color: #FFFFFF; background-color: #FFFFFF;" colspan="5">
                            <asp:DropDownList ID="ddlTipoRelecion_CI_P_H" runat="server" CssClass="form-control input-sm" 
                                        AppendDataBoundItems="True" 
                                       >
                                        <asp:ListItem Value="-1">_____SELECCIONE TIPO RELACION ELEMENTO CONFIGURACION_____</asp:ListItem>
                                    </asp:DropDownList>
                             <asp:RequiredFieldValidator ID="rfvddlTipoRelecion_CI_P_H" runat="server" ControlToValidate="ddlTipoRelecion_CI_P_H" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                             <asp:RegularExpressionValidator ID="revddlTipoRelecion_CI_P_H" runat="server" BackColor="White" 
                        ControlToValidate="ddlTipoRelecion_CI_P_H" Display="Dynamic" ErrorMessage="*" ForeColor="Red" 
                        SetFocusOnError="True" ValidationExpression="\d{1,99}"></asp:RegularExpressionValidator>
                        </td>
                    </tr>
                     <tr>
                        <td style="text-align: center; color: #FFFFFF; background-color: #FFFFFF;" colspan="7">
                   <asp:Button ID="btnRegistrar" runat="server" 
                       style="font-family: Calibri; color: #000000; font-size: medium" 
                        Text="Aceptar" 
                        onclientclick="return Confirmar('¿Desea guardar relacion elementos configuracion?');" 
                        CssClass="btn btn-success" OnClick="btnRegistrar_Click" />
                    &nbsp;<asp:Button ID="btnCancelar" runat="server" class="btn btn-danger" 
                        style="font-family: Calibri;  font-size: medium" Text="Cancelar" CausesValidation="False" PostBackUrl="~/RelacionesElementosConfiguracion.aspx" 
                         />
                         </td>
                    </tr>
                    <tr>
                        <td colspan="7" >
                            <asp:HiddenField ID="__pagina" runat="server" />
                            <asp:HiddenField ID="__mensaje" runat="server" />

                    <asp:HiddenField ID="ID_RELACION" runat="server" Value="0" 
                        EnableViewState="False" />
                    <asp:HiddenField ID="_operacion" runat="server" Value="0" 
                        EnableViewState="False" />
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
