<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ElementoConfiguracion.aspx.cs" Inherits="ElementoConfiguracion" UnobtrusiveValidationMode="None" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>    
    <meta charset="utf-8"/>    
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>

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
        function abrir_ventana_busca_Tipos_ElementoConfiguracion() {
            window.document.getElementById("ID_TIPO_ELEMENTO_CONFIGURACION").value = 0;
            window.document.getElementById("TIPO_ELEMENTO_CONFIGURACION").value = "";
            window.document.getElementById("NRO_SERIE").value = "";
            window.document.getElementById("IP").value = "";
            var options = 'channelmode=1,directories=0,fullscreen=0,location=0,menubar=0,resizable=0,titlebar=0,toolbar=0,edge=Raised,status=no,scrollbars=1,width=1000,height=550,top=50px, left=175px';
            window.open('Ventanas/ventanaTiposElementoConfiguracion.aspx', '', options);
        }

        function abrir_ventana_busca_Personal() { 
            window.document.getElementById("ID_PROPIETARIO").value = 0;
            window.document.getElementById("PROPIETARIO").value = "";
            var options = 'channelmode=1,directories=0,fullscreen=0,location=0,menubar=0,resizable=0,titlebar=0,toolbar=0,edge=Raised,status=no,scrollbars=1,width=1000,height=550,top=50px, left=175px';
            window.open('Ventanas/ventanaPropietarioElementoConfiguracion.aspx', '', options);
        }

        function abrir_ventana_busca_Localizacion_Fisica() {
            window.document.getElementById("ID_LOCALIZACION_FISICA").value = 0;
            window.document.getElementById("LOCALIZACION_FISICA").value = "";
            var options = 'channelmode=1,directories=0,fullscreen=0,location=0,menubar=0,resizable=0,titlebar=0,toolbar=0,edge=Raised,status=no,scrollbars=1,width=1000,height=550,top=50px, left=175px';
            window.open('Ventanas/ventanaLocalizacionFisica.aspx', '', options);
        }

        function MostrarMensaje() {
            var mensaje = document.getElementById("__mensaje").value;
            if (mensaje != "") {
                alert(mensaje);
                if (document.getElementById("__pagina").value != "")
                    location.href = document.getElementById("__pagina").value;

            }
            
            document.getElementById('<%= PROPIETARIO.ClientID %>').readOnly = true;
            document.getElementById('<%= LOCALIZACION_FISICA.ClientID %>').readOnly = true;
            document.getElementById('<%= FECHA_REGISTRO.ClientID %>').readOnly = true;
            document.getElementById('<%= RESPONSABLE_REGISTRO.ClientID %>').readOnly = true;

           
           <%-- <%
                if (NRO_SERIE.Text=="NINGUNO") {
                 %>
            
                   document.getElementById('<%= NRO_SERIE.ClientID %>').readOnly = true;
                 <%}
            %>--%>

            
            
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

        function SoloNumeros_() {
            if (!((event.keyCode >= 48 && event.keyCode <= 57) || event.keyCode == 46)) {
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

        
    </script>    
    
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
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

    <div class ="container">
         <div class="table-responsive" >
             <table class="table text-center" >
                <thead>                       
                  <tr>
                    <td style="text-align: center; color: #FFFFFF; background-color: #000000;" colspan="2"> INGRESE DATOS ELEMENTO CONFIGURACION</td>
                   
                  </tr>
                  <tr>
                        <td style="text-align: left; color: #FFFFFF; background-color: #000000;" 
                            class="style2"> Tipo:</td>
                        <td style="text-align: left; color: #FFFFFF; background-color: #FFFFFF;" 
                            class="style2"> 
                            <asp:DropDownList ID="TIPOCI" runat="server" CssClass="form-control input-sm" 
                                        AppendDataBoundItems="True" AutoPostBack="True" OnSelectedIndexChanged="TIPOCI_SelectedIndexChanged" 
                                       >
                                        <asp:ListItem Value="-1">_____SELECCIONE TIPO CI_____</asp:ListItem>
                                    </asp:DropDownList>
                             <asp:RequiredFieldValidator ID="rfvTipoCI" runat="server" ControlToValidate="TIPOCI" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                             <asp:RegularExpressionValidator ID="revTIPOCI" runat="server" BackColor="White" ControlToValidate="TIPOCI" Display="Dynamic" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True" ValidationExpression="\d{1,999}"></asp:RegularExpressionValidator>
                             </td>          
                        
                            
                        
                                 
                        
                           </tr>
                  <tr>
                        <td style="text-align: left; color: #FFFFFF; background-color: #000000;" 
                            class="style2"> Sub Tipo:</td>
                        <td style="text-align: left; color: #FFFFFF; background-color: #FFFFFF;" 
                            class="style2"> 
                             <asp:DropDownList ID="DESCRIPCION_ELEMENTO_CONFIGURACION" runat="server" AppendDataBoundItems="True" CssClass="form-control input-sm">
                                 <asp:ListItem Value="-1">_____SELECCIONE DESCRIPCION_____</asp:ListItem>
                             </asp:DropDownList>
                             <asp:RequiredFieldValidator ID="rfvDESCRIPCION_ELEMENTO_CONFIGURACION" runat="server" ControlToValidate="DESCRIPCION_ELEMENTO_CONFIGURACION" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                             <asp:RegularExpressionValidator ID="revDESCRIPCION_ELEMENTO_CONFIGURACION" runat="server" BackColor="White" ControlToValidate="DESCRIPCION_ELEMENTO_CONFIGURACION" Display="Dynamic" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True" ValidationExpression="\d{1,99}"></asp:RegularExpressionValidator>
                             </td>          
                        
                            
                        
                                 
                        
                           </tr>
                  <tr>
                        <td style="text-align: left; color: #FFFFFF; background-color: #000000;" 
                            class="style2"> Nombre:</td>
                        <td style="text-align: left; color: #FFFFFF; background-color: #FFFFFF;" 
                            class="style2"> 
                             <asp:TextBox ID="NOMBRE_ELEMENTO_CONFIGURACION" runat="server" CssClass="form-control input-sm" MaxLength="99" Autocomplete = "off" placeholder="Ingresar Elemento Configuracion" onchange="CambiaLetraMayuscula('NOMBRE_ELEMENTO_CONFIGURACION')" 
                        onkeypress=""></asp:TextBox>
                             <asp:RequiredFieldValidator ID="rfvNOMBRE_ELEMENTO_CONFIGURACION" runat="server" ControlToValidate="NOMBRE_ELEMENTO_CONFIGURACION" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                             </td>          
                        
                            
                        
                                 
                        
                           </tr>
                  <tr>
                        <td style="text-align: left; color: #FFFFFF; background-color: #000000;" 
                            class="style2"> 
                             Nro. Serie:</td>
                        <td style="text-align: left" class="style2">
                             <asp:TextBox ID="NRO_SERIE" runat="server" CssClass="form-control input-sm" MaxLength="30" Autocomplete = "off" placeholder="Ingresar Nro. Serie" onchange="CambiaLetraMayuscula('NRO_SERIE')"  
                        onkeypress=""></asp:TextBox>
                             <asp:RequiredFieldValidator ID="rfvNRO_SERIE" runat="server" ControlToValidate="NRO_SERIE" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                             </td>
                        
                        
       
                        
                   </tr>
                  <tr>
                        <td style="text-align: left; color: #FFFFFF; background-color: #000000;" 
                            class="style2"> 
                             Fabricante o Proveedor:</td>
                        <td style="text-align: left" class="style2">
                             <asp:TextBox ID="FABRICANTE_O_PROVEEDOR" runat="server" CssClass="form-control input-sm" Autocomplete = "off" placeholder="Ingresar Fabricante o Proveedor" onchange="CambiaLetraMayuscula('FABRICANTE_O_PROVEEDOR')"  
                        onkeypress=""></asp:TextBox>
                             <asp:RequiredFieldValidator ID="rfvFABRICANTE_O_PROVEEDOR" runat="server" ControlToValidate="FABRICANTE_O_PROVEEDOR" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                             </td>
                        
                        
       
                        
                   </tr>
                  <tr>
                        <td style="text-align: left; color: #FFFFFF; background-color: #000000;" 
                            class="style2"> 
                             Marca:</td>
                        <td style="text-align: left" class="style2">
                             <asp:DropDownList ID="MARCA" runat="server" AppendDataBoundItems="True" CssClass="form-control input-sm">
                                 <asp:ListItem Value="-1">_____SELECCIONE MARCA_____</asp:ListItem>
                             </asp:DropDownList>
                             <asp:RequiredFieldValidator ID="rfvMARCA" runat="server" ControlToValidate="MARCA" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                             <asp:RegularExpressionValidator ID="revMARCA" runat="server" BackColor="White" ControlToValidate="MARCA" Display="Dynamic" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True" ValidationExpression="\d{1,999}"></asp:RegularExpressionValidator>
                             </td>
                        
                        
       
                        
                   </tr>
                  <tr>
                        <td style="text-align: left; color: #FFFFFF; background-color: #000000;" 
                            class="style2"> 
                             Modelo:</td>
                        <td style="text-align: left" class="style2">
                             <asp:DropDownList ID="MODELO" runat="server" AppendDataBoundItems="True" CssClass="form-control input-sm">
                                 <asp:ListItem Value="-1">_____SELECCIONE MODELO_____</asp:ListItem>
                             </asp:DropDownList>
                             <asp:RequiredFieldValidator ID="rfvMODELO" runat="server" ControlToValidate="MODELO" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                             <asp:RegularExpressionValidator ID="revMODELO" runat="server" BackColor="White" ControlToValidate="MODELO" Display="Dynamic" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True" ValidationExpression="\d{1,999}"></asp:RegularExpressionValidator>
                             </td>
                        
                        
       
                        
                   </tr>
                  <tr>
                        <td style="text-align: left; color: #FFFFFF; background-color: #000000;" 
                            class="style2"> 
                             Direccion IP:</td>
                        <td style="text-align: left" class="style2">
                             <asp:TextBox ID="IP" runat="server" CssClass="form-control input-sm" MaxLength="15" Autocomplete = "off" placeholder="Ingresar Direccion IP" onchange="CambiaLetraMayuscula('NRO_SERIE')"  
                        onkeypress="SoloNumeros_();"
></asp:TextBox>
                             <asp:RequiredFieldValidator ID="rfvIP" runat="server" ControlToValidate="IP" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
        <asp:RegularExpressionValidator ID="revIP" runat="server" ControlToValidate="IP" ErrorMessage="Direccion IP incorrecta." ValidationExpression="^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$" ForeColor="Red"></asp:RegularExpressionValidator>
    
                             </td>
                        
                        
       
                        
                   </tr>
                  <tr>
                        <td style="text-align: left; color: #FFFFFF; background-color: #000000;" 
                            class="style2"> 
                             Gateway:</td>
                        <td style="text-align: left" class="style2">
                             <asp:TextBox ID="GATEWAY" runat="server" CssClass="form-control input-sm" MaxLength="15" Autocomplete = "off" placeholder="Ingresar Direccion Gateway" onchange="CambiaLetraMayuscula('NRO_SERIE')"  
                        onkeypress="SoloNumeros_();"
></asp:TextBox>
                             <asp:RequiredFieldValidator ID="rfvGATEWAY" runat="server" ControlToValidate="GATEWAY" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
        <asp:RegularExpressionValidator ID="revGateway" runat="server" ControlToValidate="GATEWAY" ErrorMessage="Direccion Gateway incorrecta." ValidationExpression="^((25[0-5]|2[0-4][0-9]|[0-1]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[0-1]?[0-9][0-9]?)$" ForeColor="Red"></asp:RegularExpressionValidator>
    
                             </td>
                        
                        
       
                        
                   </tr>
                  <tr>
                        <td style="text-align: left; color: #FFFFFF; background-color: #000000;" 
                            class="style2"> 
                             Grupo de Trabajo:</td>
                        <td style="text-align: left" class="style2">
                             <asp:TextBox ID="GRUPO_TRABAJO" runat="server" CssClass="form-control input-sm" MaxLength="99" Autocomplete = "off" placeholder="Ingresar Grupo Trabajo" onchange="CambiaLetraMayuscula('GRUPO_TRABAJO')"  
                        onkeypress="" 
></asp:TextBox>

                             <asp:RequiredFieldValidator ID="rfvGRUPO_TRABAJO" runat="server" ControlToValidate="GRUPO_TRABAJO" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                             </td>
                        
                        
       
                        
                   </tr>
                  <tr>
                        <td style="text-align: left; color: #FFFFFF; background-color: #000000;" 
                            class="style2"> Estado:<td style="text-align: left; color: #FFFFFF; background-color: #FFFFFF;" 
                            class="style2"><asp:DropDownList ID="ESTADO_ELEMENTO_CONFIGURACION" runat="server" CssClass="form-control input-sm" 
                                        AppendDataBoundItems="True" 
                                       >
                                        <asp:ListItem Value="-1">_____SELECCIONE ESTADO_____</asp:ListItem>
                                    </asp:DropDownList>
                             <asp:RequiredFieldValidator ID="rfvESTADO_ELEMENTO_CONFIGURACION" runat="server" ControlToValidate="ESTADO_ELEMENTO_CONFIGURACION" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                             <asp:RegularExpressionValidator ID="revESTADO_ELEMENTO_CONFIGURACION" runat="server" BackColor="White" 
                        ControlToValidate="ESTADO_ELEMENTO_CONFIGURACION" Display="Dynamic" ErrorMessage="*" ForeColor="Red" 
                        SetFocusOnError="True" ValidationExpression="[1-999]"></asp:RegularExpressionValidator></td>
                        
                         
                        
            
                        
                   </tr>
                  <tr>
                        <td style="text-align: left; color: #FFFFFF; background-color: #000000;" 
                            class="style2">  
                             Propietario:</td>
                         <td style="text-align: left" 
                            class="style2"> 
                             <asp:TextBox ID="PROPIETARIO" runat="server" CssClass="form-control input-sm" MaxLength="60" Autocomplete = "off" placeholder="Ingresar Propietario" onchange="" 
                        onkeypress=""></asp:TextBox>
                             <asp:RequiredFieldValidator ID="rfvPROPIETARIO" runat="server" ControlToValidate="PROPIETARIO" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                             <asp:ImageButton ID="ibtnBUSCAR_PROPIETARIO" runat="server" CausesValidation="False" CssClass="btn btn-info btn-xs" ImageUrl="~/Imagnes/buscar.ico" ToolTip="Buscar Propietario" OnClientClick="abrir_ventana_busca_Personal();" />
                    <asp:HiddenField ID="ID_PROPIETARIO" runat="server" Value="0" 
                        EnableViewState="False" />
                        </td>
                        
                        

                        
                   </tr>
                  <tr>
                        <td style="text-align: left; color: #FFFFFF; background-color: #000000;" 
                            class="style2"> Impacto Comercial:</td>
                         <td style="text-align: left; color: #FFFFFF; background-color: #FFFFFF;" 
                            class="style2"> <asp:DropDownList ID="IMPACTO_COMERCIAL_ELELEMTO_CONFIGURACION" runat="server" AppendDataBoundItems="True" CssClass="form-control input-sm">
                                 <asp:ListItem Value="-1">_____SELECCIONE IMPACTO COMERCIAL_____</asp:ListItem>
                             </asp:DropDownList>
                             <asp:RequiredFieldValidator ID="rfvIMPACTO_COMERCIAL_ELELEMTO_CONFIGURACION" runat="server" ControlToValidate="IMPACTO_COMERCIAL_ELELEMTO_CONFIGURACION" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                             <asp:RegularExpressionValidator ID="revIMPACTO_COMERCIAL_ELELEMTO_CONFIGURACION" runat="server" BackColor="White" ControlToValidate="IMPACTO_COMERCIAL_ELELEMTO_CONFIGURACION" Display="Dynamic" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True" ValidationExpression="[1-999]"></asp:RegularExpressionValidator>
                        </td>
                        
                        
                        
                   </tr>
                  <tr>
                        <td style="text-align: left; color: #FFFFFF; background-color: #000000;" 
                            class="style2"> Localizacion Fisica:&nbsp;</td>
                         <td style="text-align: left; color: #FFFFFF; background-color: #FFFFFF;" 
                            class="style2">  
                             <asp:TextBox ID="LOCALIZACION_FISICA" runat="server" CssClass="form-control input-sm" MaxLength="60" Autocomplete = "off" placeholder="Ingresar Localizacion Fisica" onchange="" 
                        onkeypress="" TextMode="MultiLine"></asp:TextBox>
                             <asp:RequiredFieldValidator ID="rfvLOCALIZACION_FISICA" runat="server" ControlToValidate="LOCALIZACION_FISICA" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                             <asp:ImageButton ID="ibtnBUSCAR_LOCALIZACION_FISICA" runat="server" CausesValidation="False" CssClass="btn btn-info btn-xs" ImageUrl="~/Imagnes/buscar.ico" ToolTip="Buscar Localizacion Fisica" OnClientClick="abrir_ventana_busca_Localizacion_Fisica();" />
                    <asp:HiddenField ID="ID_LOCALIZACION_FISICA" runat="server" Value="0" 
                        EnableViewState="False" />
                        </td>
                        
                        
                        
                   </tr>
                  <tr>
                        <td style="text-align: left; color: #FFFFFF; background-color: #000000;" 
                            class="style2"> Nivel de Prioridad:</td>
                         <td style="text-align: left; color: #FFFFFF; background-color: #FFFFFF;" 
                            class="style2">  
                             <asp:DropDownList ID="NIVEL_PRIORIDAD" runat="server" AppendDataBoundItems="True" CssClass="form-control input-sm">
                                 <asp:ListItem Value="-1">_____SELECCIONE NIVEL PRIORIDAD_____</asp:ListItem>
                             </asp:DropDownList>
                             <asp:RequiredFieldValidator ID="rfvNIVEL_PRIORIDAD" runat="server" ControlToValidate="NIVEL_PRIORIDAD" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                             <asp:RegularExpressionValidator ID="revNIVEL_PRIORIDAD" runat="server" BackColor="White" ControlToValidate="NIVEL_PRIORIDAD" Display="Dynamic" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True" ValidationExpression="[1-999]"></asp:RegularExpressionValidator>
                        </td>
                        
                        
                        
                   </tr>
                  <tr>
                        <td style="text-align: left; color: #FFFFFF; background-color: #000000;" 
                            class="style2"> Fecha Registro:</td>
                         <td style="text-align: left; color: #FFFFFF; background-color: #FFFFFF;" 
                            class="style2">  
                             <asp:TextBox ID="FECHA_REGISTRO" runat="server" CssClass="form-control input-sm" MaxLength="30" Autocomplete = "off" placeholder="Ingresar Fecha Registro" onchange="" 
                        onkeypress=""></asp:TextBox>
                             <asp:RequiredFieldValidator ID="rfvFECHA_REGISTRO" runat="server" ControlToValidate="FECHA_REGISTRO" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </td>
                        
                        
                        
                   </tr>
                  <tr>
                        <td style="text-align: left; color: #FFFFFF; background-color: #000000;" 
                            class="style2"> Responsable Registro:</td>
                         <td style="text-align: left; color: #FFFFFF; background-color: #FFFFFF;" 
                            class="style2">  
                             <asp:TextBox ID="RESPONSABLE_REGISTRO" runat="server" CssClass="form-control input-sm" MaxLength="30" Autocomplete = "off" placeholder="Ingresar Responsable Registro" onchange="" 
                        onkeypress=""></asp:TextBox>
                             <asp:RequiredFieldValidator ID="rfvRESPONSABLE_REGISTRO" runat="server" ControlToValidate="RESPONSABLE_REGISTRO" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                    <asp:HiddenField ID="ID_RESPONSABLE_REGISTRO" runat="server" Value="0" 
                        EnableViewState="False" />
                        </td>
                        
                        
                        
                   </tr>
                  <tr>
                        <td style="text-align: center" 
                            class="style2" colspan="2">  
                   <asp:Button ID="btnRegistrar" runat="server" 
                       style="font-family: Calibri; color: #000000; font-size: medium" 
                        Text="Aceptar" 
                        onclientclick="return Confirmar('¿Desea guardar datos elemento configuracion?');" 
                        CssClass="btn btn-success" OnClick="btnRegistrar_Click" />
                    &nbsp;<asp:Button ID="btnCancelar" runat="server" class="btn btn-primary" 
                        style="font-family: Calibri;  font-size: medium" Text="Cancelar" CausesValidation="False" PostBackUrl="~/ElementosConfiguracion.aspx" OnClick="btnCancelar_Click" 
                         />
                        </td>

                                  
                        
                        
                        
                   </tr>
                  <tr>
                <td colspan="2" style="text-align: center">
                    <asp:HiddenField ID="__mensaje" runat="server" />
                    <asp:HiddenField ID="__pagina" runat="server" />
                    <asp:HiddenField ID="ID_ELEMENTO_CONFIGURACION" runat="server" Value="0" 
                        EnableViewState="False" />
                    <asp:HiddenField ID="_operacion" runat="server" Value="0" 
                        EnableViewState="False" />
                    &nbsp;
                    &nbsp;
                    &nbsp;
                    </td>
            </tr>
                 </thead>
             </table>
    </div> </div>



    </form>

    <script lang ="JavaScript" type="text/javascript">
        ResaltarFila('TableUsuario');
    </script>	

     <script type="text/javascript" src="../bootstrap/js/jquery-1.12.4.min.js"></script>
     <script type="text/javascript" src="../bootstrap/js/bootstrap.min.js"></script>
 
    </body>
</html>

