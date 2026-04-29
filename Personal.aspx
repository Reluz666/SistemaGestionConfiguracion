<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Personal.aspx.cs" Inherits="Personal"  UnobtrusiveValidationMode="None" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Personal</title>

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
    </script>    
    
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <style type="text/css">
        .auto-style1 {
            width: 409px
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

    <div class ="container">
         <div class="table-responsive" >
             <table class="table text-center" >
                <thead>                       
                  <tr>
                    <td style="text-align: center; color: #FFFFFF; background-color: #000000;" colspan="4"> INGRESE DATOS PERSONAL</td>
                   
                  </tr>
                  <tr>
                        <td style="text-align: left; color: #FFFFFF; background-color: #000000;" 
                            class="auto-style1"> Codigo</td>
                        <td style="text-align: left; color: #FFFFFF; background-color: #000000;" 
                            class="style2"> Nombre</td>          
                        
                        <td style="text-align: left; color: #FFFFFF; background-color: #000000;" 
                            class="style2">Apellido Pat.</td>          
                        
                        <td style="text-align: left; color: #FFFFFF; background-color: #000000;" 
                            class="style2">Apellido Mat</td>          
                        
                   </tr>
                  <tr>
                        <td style="text-align: left;" 
                            class="auto-style1"> 
                             <asp:TextBox ID="Codigo" runat="server" CssClass="form-control input-sm" MaxLength="5" Autocomplete = "off" placeholder="Ingresar Codigo" onkeypress="SoloNumeros()"></asp:TextBox>
                             <asp:RequiredFieldValidator ID="rfvCodigo" runat="server" ControlToValidate="Codigo" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                             <asp:RegularExpressionValidator ID="revCodigo" runat="server" ControlToValidate="Codigo" ErrorMessage="Coigo debe tener 5 numeros." ForeColor="Red" ValidationExpression="\d{5}" SetFocusOnError="True"></asp:RegularExpressionValidator>
                        </td>
                        <td style="text-align: left" class="style2">
                             <asp:TextBox ID="Nombre" runat="server" CssClass="form-control input-sm" MaxLength="25" Autocomplete = "off" placeholder="Ingresar Nombre" onchange="CambiaLetraMayuscula('Nombre')" 
                        onkeypress="SoloLetrasMinusculas()"></asp:TextBox>
                             <asp:RequiredFieldValidator ID="rfvNombre" runat="server" ControlToValidate="Nombre" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </td>
                        
                        <td style="text-align: left" class="style2">
                             <asp:TextBox ID="ApellidoPat" runat="server" CssClass="form-control input-sm" MaxLength="25" Autocomplete = "off" placeholder="Ingresar Apellido Paterno" onchange="CambiaLetraMayuscula('ApellidoPat')" 
                        onkeypress="SoloLetrasMinusculas()"></asp:TextBox>
                             <asp:RequiredFieldValidator ID="rfvApellidoPat" runat="server" ControlToValidate="ApellidoPat" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </td>
                        
                        <td style="text-align: left" class="style2">
                             <asp:TextBox ID="ApellidoMat" runat="server" CssClass="form-control input-sm" MaxLength="25" Autocomplete = "off" placeholder="Ingresar Apellido Materno" onchange="CambiaLetraMayuscula('ApellidoMat')" 
                        onkeypress="SoloLetrasMinusculas()"></asp:TextBox>
                             <asp:RequiredFieldValidator ID="rfvApellidoMat" runat="server" ControlToValidate="ApellidoMat" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </td>
                        
                   </tr>
                  <tr>
                        <td style="text-align: left; color: #FFFFFF; background-color: #000000;" 
                            class="auto-style1"> Tipo Doc. Ident.</td>
                         <td style="text-align: left; color: #FFFFFF; background-color: #000000;" 
                            class="style2"> Nro. Doc. Ident.</td>
                        
                         <td style="text-align: left; color: #FFFFFF; background-color: #000000;" 
                            class="style2"> Profesion</td>
                        
                         <td style="text-align: left; color: #FFFFFF; background-color: #000000;" 
                            class="style2"> Telefono</td>
                        
                   </tr>
                  <tr>
                        <td style="text-align: left" 
                            class="auto-style1"> <asp:DropDownList ID="TipoDocIdent" runat="server" CssClass="form-control input-sm" 
                                        AppendDataBoundItems="True" 
                                       >
                                        <asp:ListItem Value="-1">_____SELECCIONE TIPO DOC._____</asp:ListItem>
                                    </asp:DropDownList>
                             <asp:RequiredFieldValidator ID="rfvTipoDocIdent" runat="server" ControlToValidate="TipoDocIdent" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </td>
                         <td style="text-align: left" 
                            class="style2"> 
                             <asp:TextBox ID="NroDocIdent" runat="server" CssClass="form-control input-sm" MaxLength="25" Autocomplete = "off" placeholder="Ingresar Nro. Doc. Ident." onkeypress="SoloNumeros()"></asp:TextBox>
                             <asp:RequiredFieldValidator ID="rfvNroDocIdent" runat="server" ControlToValidate="NroDocIdent" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </td>
                        
                         <td style="text-align: left" 
                            class="style2"> <asp:DropDownList ID="Profesion" runat="server" CssClass="form-control input-sm" 
                                        AppendDataBoundItems="True" 
                                       >
                                        <asp:ListItem Value="-1">_____SELECCIONE PROFESION_____</asp:ListItem>
                                    </asp:DropDownList>
                             <asp:RequiredFieldValidator ID="rfvProfesion" runat="server" ControlToValidate="Profesion" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </td>
                        
                         <td style="text-align: left" 
                            class="style2"> 
                             <asp:TextBox ID="Telefono" runat="server" CssClass="form-control input-sm" MaxLength="9" Autocomplete = "off" placeholder="Ingresar Nro. Telefono" onkeypress="SoloNumeros()"></asp:TextBox>
                             <asp:RequiredFieldValidator ID="rfvTelefono" runat="server" ControlToValidate="Telefono" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </td>
                        
                   </tr>
                  <tr>
                        <td style="text-align: left; color: #FFFFFF; background-color: #000000;" 
                            class="auto-style1"> Email</td>
                         <td style="text-align: left; color: #FFFFFF; background-color: #000000;" 
                            class="style2"> Sede</td>
                        
                        <td style="text-align: left; color: #FFFFFF; background-color: #000000;" 
                            class="style2"> Local&nbsp;</td>
                        
                         <td style="text-align: left; color: #FFFFFF; background-color: #000000;" 
                            class="style2"> Area</td>
                        
                   </tr>
                  <tr>
                        <td style="text-align: left" 
                            class="auto-style1">  
                             <asp:TextBox ID="Email" runat="server" CssClass="form-control input-sm" MaxLength="25"></asp:TextBox>
                             <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="Email" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                             <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="Email" Display="Dynamic" ErrorMessage="Email incorrecto" ForeColor="Red" SetFocusOnError="True" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                        </td>
                         <td style="text-align: left" 
                            class="style2"><asp:DropDownList ID="Sede" runat="server" CssClass="form-control input-sm" 
                                        AppendDataBoundItems="True" AutoPostBack="True" OnSelectedIndexChanged="Sede_SelectedIndexChanged" 
                                       >
                                        <asp:ListItem Value="-1">_____SELECCIONE SEDE_____</asp:ListItem>
                                    </asp:DropDownList>
                             <asp:RequiredFieldValidator ID="rfvSede" runat="server" ControlToValidate="Sede" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                             <asp:RegularExpressionValidator ID="revSede" runat="server" BackColor="White" 
                        ControlToValidate="Sede" Display="Dynamic" ErrorMessage="*" ForeColor="Red" 
                        SetFocusOnError="True" ValidationExpression="\d{1,999}"></asp:RegularExpressionValidator>
                        </td>

                                  
                        
                         <td style="text-align: left" 
                            class="style2"> <asp:DropDownList ID="Local" runat="server" CssClass="form-control input-sm" 
                                        AppendDataBoundItems="True" AutoPostBack="True" OnSelectedIndexChanged="Local_SelectedIndexChanged" 
                                       >
                                        <asp:ListItem Value="-1">_____SELECCIONE LOCAL_____</asp:ListItem>
                                    </asp:DropDownList>
                             <asp:RequiredFieldValidator ID="rfvLocal" runat="server" ControlToValidate="Local" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                             <asp:RegularExpressionValidator ID="revLocal" runat="server" BackColor="White" 
                        ControlToValidate="Local" Display="Dynamic" ErrorMessage="*" ForeColor="Red" 
                        SetFocusOnError="True" ValidationExpression="\d{1,999}"></asp:RegularExpressionValidator>
                        </td>
                        
                         <td style="text-align: left" 
                            class="style2"> 
                             <asp:DropDownList ID="Area" runat="server" CssClass="form-control input-sm" 
                                        AppendDataBoundItems="True" 
                                       >
                                        <asp:ListItem Value="-1">_____SELECCIONE AREA_____</asp:ListItem>
                                    </asp:DropDownList>
                             <asp:RequiredFieldValidator ID="rfvArea" runat="server" ControlToValidate="Area" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                             <asp:RegularExpressionValidator ID="revArea" runat="server" BackColor="White" 
                        ControlToValidate="Area" Display="Dynamic" ErrorMessage="*" ForeColor="Red" 
                        SetFocusOnError="True" ValidationExpression="\d{1,999}"></asp:RegularExpressionValidator>
                        </td>
                        
                   </tr>
                  <tr>
                        <td style="text-align: left; color: #FFFFFF; background-color: #000000;" 
                            class="auto-style1"> Dependencia</td>
                           <td style="text-align: left; color: #FFFFFF; background-color: #000000;" 
                            class="style2"> Cargo</td>
                                  
                        
                         <td style="text-align: left; color: #FFFFFF; background-color: #000000;" 
                            class="style2"> Estado</td>
                        
                         <td style="text-align: left" 
                            class="style2"> 
                             &nbsp;</td>
                        
                   </tr>
                  <tr>
                        <td style="text-align: left" 
                            class="auto-style1">  
                             <asp:DropDownList ID="Dependencia" runat="server" CssClass="form-control input-sm" 
                                        AppendDataBoundItems="True" 
                                       >
                                        <asp:ListItem Value="-1">_____SELECCIONE DEPENDENCIA_____</asp:ListItem>
                                    </asp:DropDownList>
                             <asp:RequiredFieldValidator ID="rfvDependencia" runat="server" ControlToValidate="Dependencia" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                             <asp:RegularExpressionValidator ID="revDependencia" runat="server" BackColor="White" 
                        ControlToValidate="Dependencia" Display="Dynamic" ErrorMessage="*" ForeColor="Red" 
                        SetFocusOnError="True" ValidationExpression="\d{1,999}"></asp:RegularExpressionValidator>
                        </td>
                         <td style="text-align: left" 
                            class="style2">  
                             <asp:DropDownList ID="Cargo" runat="server" CssClass="form-control input-sm" 
                                        AppendDataBoundItems="True" AutoPostBack="True" 
                                       >
                                        <asp:ListItem Value="-1">_____SELECCIONE CARGO_____</asp:ListItem>
                                    </asp:DropDownList>
                             <asp:RequiredFieldValidator ID="rfvCargo" runat="server" ControlToValidate="Cargo" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                             <asp:RegularExpressionValidator ID="revCargo" runat="server" BackColor="White" 
                        ControlToValidate="Cargo" Display="Dynamic" ErrorMessage="*" ForeColor="Red" 
                        SetFocusOnError="True" ValidationExpression="\d{1,999}"></asp:RegularExpressionValidator>
                        </td>

                                  
                        
                         <td style="text-align: left" 
                            class="style2">   
                             <asp:CheckBox ID="Estado" runat="server" CssClass="form-check-input position-static&quot" />
                        </td>
                        
                         <td style="text-align: left" 
                            class="style2"> 
                             &nbsp;</td>
                        
                   </tr>
                  <tr>
                <td colspan="4" style="text-align: center">
                   <asp:Button ID="btnRegistrar" runat="server" 
                       style="font-family: Calibri; color: #000000; font-size: medium" 
                        Text="Registrar" 
                        onclientclick="return Confirmar('¿Desea registrar Personal?');" 
                        CssClass="btn btn-success" OnClick="btnRegistrar_Click" Visible="False" />
                    &nbsp;
                    <asp:Button ID="btnModificar" runat="server" 
                        style="font-family: Calibri; color: #000000; font-size: medium" 
                        Text="Modificar"  onclientclick="return Confirmar('¿Desea modificar Personal?');" CssClass="btn btn-warning" Visible="False" OnClick="btnModificar_Click" />
                    &nbsp;
                    <asp:Button ID="btnEliminar" runat="server" 
                        style="font-family: Calibri; color: #000000; font-size: medium" 
                        Text="Eliminar"  onclientclick="return Confirmar('¿Desea eliminar Personal?');" class="btn btn-danger" Visible="False" OnClick="btnEliminar_Click" />
                    &nbsp;
                    <asp:Button ID="btnCancelar" runat="server" class="btn btn-primary" 
                        style="font-family: Calibri;  font-size: medium" Text="Cancelar" CausesValidation="False" Visible="False" OnClick="btnCancelar_Click" 
                         />
                    </td>
            </tr>
                 </thead>
             </table>
    </div> </div>

    <div class ="container">
         <div class="table-responsive" >
             <table class="table text-center">
        <tr>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td style="text-align: left">
                <asp:CheckBoxList ID="CheckBoxList1" runat="server">
                </asp:CheckBoxList>
                <asp:DropDownList ID="DropDownList1" runat="server">
                </asp:DropDownList>
            </td>
            <td style="text-align: left">
                <asp:CheckBoxList ID="CheckBoxList2" runat="server">
                </asp:CheckBoxList>
                <asp:DropDownList ID="DropDownList2" runat="server">
                </asp:DropDownList>
            </td>
            <td style="text-align: left">
                <asp:CheckBoxList ID="CheckBoxList3" runat="server">
                </asp:CheckBoxList>
                <asp:DropDownList ID="DropDownList3" runat="server">
                </asp:DropDownList>
            </td>
            <td style="text-align: left">
                <asp:CheckBoxList ID="CheckBoxList4" runat="server">
                </asp:CheckBoxList>
                <asp:DropDownList ID="DropDownList4" runat="server">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td colspan="4">
                        
                        <asp:Table ID="TablePersonal" runat="server" CssClass="form-control input" 
                            class="table table-hover table-condensed" BackColor="White" BorderColor="White" 
                            CellPadding="6" CellSpacing="2" Font-Size="X-Small" GridLines="Both" Width="100%" 
                            style="text-align: left">
                            <asp:TableRow ID="TableRow1" runat="server">
                                <asp:TableCell ID="tcId"  runat="server" BackColor="Black" BorderColor="Black" 
                                    ForeColor="White" Width="7%" Visible="false">ID PER</asp:TableCell>

                                <asp:TableCell ID="tcSede"  runat="server" BackColor="Black" BorderColor="Black" 
                                    ForeColor="White"  Width="10%">SEDE</asp:TableCell>

                                <asp:TableCell ID="tcLocal"  runat="server" BackColor="Black" BorderColor="Black" 
                                    ForeColor="White"  Width="10%">,LOCAL</asp:TableCell>

                                <asp:TableCell ID="tcArea"  runat="server" BackColor="Black" BorderColor="Black" 
                                    ForeColor="White"  Width="10%">AREA</asp:TableCell>

                                <asp:TableCell ID="tcDependencia" runat="server" BackColor="Black" BorderColor="Black" 
                                    ForeColor="White" Width="10%">DEPENDENCIA</asp:TableCell>

                                <asp:TableCell ID="tcCodigo"  runat="server" BackColor="Black" BorderColor="Black" 
                                    ForeColor="White" Width="7%" Visible="true">CODIGO</asp:TableCell>

                                <asp:TableCell ID="tcPersonal" runat="server" BackColor="Black" BorderColor="Black" 
                                    ForeColor="White" Width="15%">PERSONAL</asp:TableCell>

                                <asp:TableCell ID="tcTipoDocIdent" runat="server" BackColor="Black" BorderColor="Black" 
                                    ForeColor="White" Width="7%">TIPO DOC</asp:TableCell>

                                <asp:TableCell ID="tcNroDoc" runat="server" BackColor="Black" BorderColor="Black" 
                                    ForeColor="White" Width="7%">NRO. DOC.</asp:TableCell>

                                <asp:TableCell ID="tcProfesion" runat="server" BackColor="Black" BorderColor="Black" 
                                    ForeColor="White" Width="7%" Visible="true">PROFESION</asp:TableCell>

                                <asp:TableCell ID="tcTelefono" runat="server" BackColor="Black" BorderColor="Black" 
                                    ForeColor="White" Width="7%" Visible="true">TELEFONO</asp:TableCell>

                                <asp:TableCell ID="tcEmail" runat="server" BackColor="Black" BorderColor="Black" 
                                    ForeColor="White" Width="7%" Visible="true">EMAIL</asp:TableCell>

                                <asp:TableCell ID="tcCargo" runat="server" BackColor="Black" BorderColor="Black" 
                                    ForeColor="White" Width="7%" Visible="true">CARGO</asp:TableCell>

                               
                                <asp:TableCell ID="tcEstado" runat="server" BackColor="Black" BorderColor="Black" 
                                    ForeColor="White" Width="7%" Visible="true">ESTADO</asp:TableCell>

                                <asp:TableCell ID="seleccionar_personal" runat="server" BackColor="Black" BorderColor="Black" 
                                    ForeColor="White" Width="7%">SELECCIONAR</asp:TableCell>
                  

                            </asp:TableRow>
                        </asp:Table>
                        
                    </td>
            
        </tr>
       
        <tr>
            <td colspan="3">
                    <asp:HiddenField ID="__mensaje" runat="server" />
                    <asp:HiddenField ID="__pagina" runat="server" />
                    <asp:HiddenField ID="ID_PERSONAL" runat="server" Value="0" 
                        EnableViewState="False" />
                    </td>
            <td>
                    &nbsp;</td>
        </tr>
    </table>
    </div> </div>

    </form>

    <script lang ="JavaScript" type="text/javascript">
        ResaltarFila('TablePersonal');
    </script>	

     <script type="text/javascript" src="../bootstrap/js/jquery-1.12.4.min.js"></script>
     <script type="text/javascript" src="../bootstrap/js/bootstrap.min.js"></script>
 
    </body>
</html>
