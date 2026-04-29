<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Usuarios.aspx.cs" Inherits="Configuracion_Default" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="hPersonal" runat="server">
    <title>Personal</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <meta name="MobileOptimized" content="width" />
    <meta name="HandheldFriendly" content="true" />
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <!-- Bootstrap -->
    <link href="../bootstrap/css/bootstrap.min.css" rel="stylesheet" />
    <script type="text/javascript" src="../bootstrap/js/jquery-1.12.4.min.js"></script>
    <script type="text/javascript" src="../bootstrap/js/bootstrap.min.js"></script>
    <link href="CssJs/Menu.css" rel="stylesheet" />

    <script type="text/javascript" src="../src/js/jscal2.js"></script>
    <script type="text/javascript" src="../src/js/lang/es.js"></script>
    <link rel="stylesheet" type="text/css" href="../src/css/jscal2.css" />
    <link rel="stylesheet" type="text/css" href="../src/css/border-radius.css" />
    <link rel="stylesheet" type="text/css" href="../src/css/steel/steel.css" />
    <%--AGREGADO EL 13-12-2022--%>
    <link href="../Otros_css_js/TableResponsive.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript">


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

        function BloqueaIngresoDatos() {
            event.returnValue = false;

        }

        function SoloNumeros() {
            if ((event.keyCode < 48) || (event.keyCode > 57)) {
                event.returnValue = false;
            }

        }

        function SoloLetras(e) {
            if (!(event.keyCode >= 65 && event.keyCode <= 90 || event.keyCode == 32 || event.keyCode == 193 || event.keyCode == 201 || event.keyCode == 205 || event.keyCode == 209 || event.keyCode == 211 || event.keyCode == 218 || event.keyCode == 220)) {
                event.keyCode = 0;
            }
        }

        /*Ultima Modificacion: 22/7/2019
        Ing. Secundino Alvites Rodas.
        */
        function SoloLetrasMinusculas() {
            if (!((event.keyCode >= 97 && event.keyCode <= 122) || event.keyCode == 32 || event.keyCode == 193 || event.keyCode == 201 || event.keyCode == 205 || event.keyCode == 209 || event.keyCode == 211 || event.keyCode == 218 || event.keyCode == 220 || event.keyCode == 241)) {
                event.returnValue = false;
            }
        }


        function LetrasNumeros(e) {
            if (!(event.keyCode >= 48 && event.keyCode <= 57 || event.keyCode >= 65 && event.keyCode <= 90 || event.keyCode == 32 || event.keyCode == 193 || event.keyCode == 201 || event.keyCode == 205 || event.keyCode == 209 || event.keyCode == 211 || event.keyCode == 218 || event.keyCode == 220)) {
                event.keyCode = 0;
            }
        }

        /*
        Función que permite al usuario ingrese sólo números enteros o reales.
        Parametros: e    , permite obtener el valor de la tecla prsionada.
        Punto, false sólo números enteros;true sólo números reales.
        Texto, texto que contiene el valor numerico. 
        */
        function SoloDecimales(e, Punto, Texto) {
            if (event.keyCode == 8)
                ;
            else if (event.keyCode == 46) {
                if (Punto == false)
                    event.keyCode = 0;
                else {
                    for (i = 0; i < Texto.value.length; i++) {
                        if (Texto.value.charCodeAt(i) == 46) {
                            event.keyCode = 0;
                        }
                    }
                }
            }
            else if (!(event.keyCode >= 48 && event.keyCode <= 57)) {
                event.keyCode = 0;
            }
        }


        function CambiaLetraMayuscula(Caja) {
            document.getElementById(Caja).value = document.getElementById(Caja).value.toUpperCase();
        }

    </script>
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
    <%--<script src="../Otros_css_js/resaltar.js" type="text/javascript"></script>--%>
    <link rel="stylesheet" href="../Otros_css_js/estilo.css" type="text/css" />
</head>
<body onload="MostrarMensaje()">
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
                        <li><a href="~/Personal.aspx" runat="server" id="trabajadores_aspx">Personal</a></li>
                        <li class="dropdown-submenu">
                            <a href="#">Tablas Institucion</a>
                            <ul class="dropdown-menu">
                                <li><a href="~/Sede.aspx" runat="server" id="a4">Sede</a></li>
                                <li><a href="~/Local.aspx" runat="server" id="A5">Local</a></li>
                                <li><a href="~/Area.aspx" runat="server" id="A6">Area</a></li>
                                <li><a href="~/Dependencia.aspx" runat="server" id="A8">Dependencia</a></li>
                            </ul>
                        </li>
                        <li class="dropdown-submenu">
                            <a href="#">Tablas Personal</a>
                            <ul class="dropdown-menu">
                                <li><a href="~/Cargo.aspx" runat="server" id="area_trabajo_aspx">Cargo</a></li>
                                <li><a href="~/ProfecionOcupacion.aspx" runat="server" id="Sub_Area_aspx">Profecion - Ocupacion</a></li>                               
                            </ul>
                        </li>
                        <li class="divider"></li>
                        <li class="dropdown-submenu">
                            <a href="#">Tablas Elemento Configuracion/a>
                            <ul class="dropdown-menu">
                                <li><a href="~/Modelo.aspx" runat="server" id="A14">Modelo</a></li>
                                <li><a href="~/Marca.aspx" runat="server" id="A13">Marca</a></li>
                                <li><a href="~/DescripcionElementoConfiguracion.aspx" runat="server" id="A9">Descripci&oacute;n Elemento Configuraci&oacute;n</a></li>
                                <li><a href="~/TiposElementoConfiguracion.aspx" runat="server" id="A10">Tipos Elemento Configuraci&oacute;n</a></li> 
                                <li><a href="~/TipoRelacionElementoConfiguracion.aspx" runat="server" id="A11">Tipo Relaci&oacute;n Elemento Configuraci&oacute;n</a></li>
                                <li><a href="~/TipoComponeneteCI.aspx" runat="server" id="A12">Tipo Componenete Elemento Configuraci&oacute;n</a></li> 
                                <li><a href="~/EstadoActualCI.aspx" runat="server" id="A15">Estado Actual Elemento Configuraci&oacute;n</a></li>                                                                                                                             
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
                        
                        <li><a href="~/ElementosConfiguracion.aspx" runat="server" id="ElementosConfiguracion_aspx">Elementos de Configuracio&oacute;n</a></li>
                        <li><a href="~/RelacionesElementosConfiguracion.aspx" runat="server" id="PrendaMovimientos_aspx">Relacio&oacute;n de Elementos de Configuracio&oacute;n</a></li>
                        <li class="divider"></li>
                        <li><a href="~/CIsAsignarComponenetes.aspx" runat="server" id="A3">Asignar Componentes Elementos de Configuraci&oacute;n</a></li>
                        <li class="divider"></li>
                        <li><a href="~/LicenciasElementoConfiguracion.aspx" runat="server" id="A1">Licencias de Elementos de Configuraci&oacute;n</a></li>
                        <li class="divider"></li>
                        <li><a href="~/SeguimientosElementoConfiguracion.aspx" runat="server" id="_Asistencias_aspx">Seguimiento de Elementos de Configuraci&oacute;n</a></li>                        
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
                        <li><a href="../Reportes/Reporte_De_CIS_Relativo_A_Servicios.aspx" runat="server" id="A2">Reporte de CIS Relativo A Servicios</a></li>
                        <li><a href="../Reportes/Reporte_CIS_Relacionados_Con_Otros_CIS.aspx" runat="server" id="A7">Reporte de de CIs relacionados con otros CIs</a></li>     
                        
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
                        <li><a href="../CerrarSession.aspx" style="text-align: left; color: red;">Cerrar Sesion</a></li>
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
    <form id="frmPersonal" runat="server">
        <div class="form-group">
            <div class="container">
                <div class="table-responsive">
                    <center>
                        <asp:Label ID="lbTitulo" runat="server" Text="Lista Usuarios" Font-Bold="True" 
                            Font-Size="Large"></asp:Label>
                     </center>
                     <asp:Table ID="TablePersonal" runat="server"  
                             CssClass="table table-bordered table-hover text-center  table-striped"
                        BackColor="White" CellPadding="2" CellSpacing="0" Font-Size="Smaller" GridLines="Both"
                        Style="text-align: left">
                            <asp:TableRow ID="TableRow1" runat="server">
                                <asp:TableCell ID="tcID"  runat="server" BackColor="Black" BorderColor="Black" 
                                    ForeColor="White" Width="7%" Visible="false">ID</asp:TableCell>

                                <asp:TableCell ID="tcCARGO"  runat="server" BackColor="Black" BorderColor="Black" 
                                    ForeColor="White"  Width="10%" Visible="true">CARGO</asp:TableCell>

                                <asp:TableCell ID="tcUSUARIO" runat="server" BackColor="Black" BorderColor="Black" 
                                    ForeColor="White" Width="15%" Visible="true">USUARIO</asp:TableCell>

                                <asp:TableCell ID="tcTELEFONO" runat="server" BackColor="Black" BorderColor="Black" 
                                    ForeColor="White" Width="7%" Visible="false">TELEFONO</asp:TableCell>

                                <asp:TableCell ID="tcEMAIL" runat="server" BackColor="Black" BorderColor="Black" 
                                    ForeColor="White" Width="15%" Visible="true">EMAIL</asp:TableCell>

                                <asp:TableCell ID="TCLogin" runat="server" BackColor="Black" BorderColor="Black" 
                                    ForeColor="White" Width="7%" Visible="true">LOGIN</asp:TableCell>

                                <asp:TableCell ID="TCPassword" runat="server" BackColor="Black" BorderColor="Black" 
                                    ForeColor="White" Width="7%" Visible="true">PASSWORD</asp:TableCell>
                                
                                <asp:TableCell ID="TCEstado" runat="server" BackColor="Black" BorderColor="Black" 
                                    ForeColor="White" Width="7%" Visible="true">ESTADO</asp:TableCell>

                                <asp:TableCell ID="seleccionaralumno" runat="server" BackColor="Black" BorderColor="Black" 
                                    ForeColor="White" Width="7%">ACCESO SISTEMA</asp:TableCell>
                            </asp:TableRow>
                        </asp:Table>
                </div>
            </div>
        </div>
        <asp:HiddenField ID="__mensaje" runat="server" />
        <asp:HiddenField ID="__pagina" runat="server" />   
        
       
     <script type="text/javascript" src="../Otros_css_js/jquery-3.1.1.slim.min.js"></script>
        <script type="text/javascript" src="../Otros_css_js/restables.js"></script>
        <script type="text/javascript">
            window.addEventListener("load", convertirPrimerTR);

            $(document).ready(function () {
                $('table').resTables();
            });

            function convertirPrimerTR() {
                // Obtener el primer elemento <tr> del <tbody>
                var tr = document.querySelector("tbody tr");

                // Clonar el elemento <tr>
                var thead = tr.cloneNode(true);

                // recorremos el thead y reemplazamos los <td> por <th>
                for (var i = 0; i < thead.children.length; i++) {
                    var th = document.createElement("th");
                    th.innerHTML = thead.children[i].innerHTML;
                    thead.replaceChild(th, thead.children[i]);
                }

                // Crear un nuevo elemento <thead> y agregar el elemento clonado <tr>
                var nuevoThead = document.createElement("thead");
                nuevoThead.appendChild(thead);

                // Obtener la tabla y agregar el nuevo <thead> al principio
                var tabla = document.querySelector("table");
                tabla.insertBefore(nuevoThead, tabla.firstChild);

                // Eliminar el elemento <tr> original del <tbody>
                tr.remove();
            }
        </script>   
   
     <script language="JavaScript" type="text/javascript">
         ResaltarFila('TablePersonal');   
    </script>	
        
       
    </form>

     </body>
</html>

