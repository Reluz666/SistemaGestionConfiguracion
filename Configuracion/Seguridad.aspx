<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Seguridad.aspx.cs" Inherits="Configuracion_Seguridad" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="hDiagostico" runat="server">
    <title>Diagostico</title>
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

        /*Ultima Modificacion: 20/01/2022
        Ing. Secundino Alvites Rodas.
        */
        function LetrasNumeros() {
            if (!((event.keyCode >= 48 && event.keyCode <= 57) || event.keyCode >= 65 && event.keyCode <= 90 || event.keyCode >= 97 && event.keyCode <= 122 || event.keyCode == 32 || event.keyCode == 193 || event.keyCode == 201 || event.keyCode == 205 || event.keyCode == 209 || event.keyCode == 211 || event.keyCode == 218 || event.keyCode == 220)) {
                event.returnValue = false;
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


        function Activa(Celda,Letra,Fila,Coumna) {
            if (document.getElementById(Celda).checked == true) {
                Rpta = confirm("¿Desea Activar Autorizacion y Permisos Para Ingresar al Sistema?");
                if (Rpta == 1) {
                    for (j = 4; j < 19; j++) {
                        document.getElementById(Letra + Fila.toString() + j.toString()).checked = true;
                    }
                }
                else {
                    document.getElementById(Celda).checked = false;
                }
            }
            else {
                Rpta = confirm("¿Desea Desactivar Autorizacion y Permisos Para Ingresar al Sistema?");
                if (Rpta == 1) {
                    for (j = 4; j < 19; j++) {
                        document.getElementById(Letra + Fila.toString() + j.toString()).checked = false;
                    }
                }
                else {
                    document.getElementById(Celda).checked = true;
                }
            }
//            alert(Celda)
        }

        //AGREGADO EN REQUE EL MARTES 21 DE MARZO DEL 2023
        function abrir_ventana_imprimir_reporte(Opcion) {
            if (Verificar_Datos_tabla(Opcion)) {
                window.name = "Autorizaci&oacute;n y Permisos Para Ingresar al Sistema";
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
            var tabla = document.getElementById("tSeguridad");
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
    <form id="frmSeguridad" runat="server" >

       <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    
        <div class="form-group">
            <div class="container">
                <div class="table-responsive">  
                    <center><asp:Label ID="lblTitulo" runat="server" Text="<b>Datos Usuario</b>"></asp:Label></center> 
                    <div class="col-md-12 col-sm-12">
                        <div class="form-group col-md-4 col-sm-4">
                            <b>Colaborador</b><br />
                            <asp:Label ID="lblCOLABORADOR" runat="server" Text=""></asp:Label>
                        </div>                       
                        <div class="form-group col-md-4 col-sm-4">
                            <b>Cargo</b><br />
                            <asp:Label ID="lblCARGO" runat="server" Text=""></asp:Label>
                        </div>                        
                    </div>
                </div>
            </div>
        </div>

        <div class="form-group" style="left: 30px; position: absolute;">
             <div class="container" style="width:1450px">
                 <div class="table-responsive"  style="width:1450px"> 
                           <center><asp:Label ID="lblTitulo2" runat="server" Text="<b>Autorizaci&oacute;n y Permisos Para Ingresar al Sistema</b>"></asp:Label></center>   
                           <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                <ContentTemplate>
                                        <asp:Table ID="tSeguridad" runat="server"
                                                            CssClass="table table-bordered table-hover text-center  table-striped"
                                                            BackColor="White" CellPadding="2" CellSpacing="0" 
                                                            Font-Size="8pt" GridLines="Both"
                                                            Style="text-align: left" Font-Names="Arial">
                       
                                                            <asp:TableRow ID="trDetalleTarea" runat="server" Visible="true">
                                                                <asp:TableCell ID="tc_CODIGO_AUTORIZACION" runat="server" BackColor="Black" BorderColor="Black"
                                                                    ForeColor="White" Visible="false" Width="2%">COD. AUTORIZACI&Oacute;N</asp:TableCell>

                                                                <asp:TableCell ID="tcCODIGO_FORMULARIO" runat="server" BackColor="Black" BorderColor="Black"
                                                                    ForeColor="White" Visible="false" Width="2%">COD. FORMULARIO</asp:TableCell>

                                                               <asp:TableCell ID="tcAUTORIZACION" runat="server" BackColor="Black" BorderColor="Black"
                                                                    ForeColor="White" Visible="true" Width="2%">AUTORIZACI&Oacute;N</asp:TableCell>
                            
                                                               <asp:TableCell ID="tcNOMBRE_FORMULARIO" runat="server" BackColor="Black" BorderColor="Black"
                                                                    ForeColor="White" Visible="true" Width="2%">P&Aacute;GINA WEB</asp:TableCell>
                            
                                                            </asp:TableRow>
                                        </asp:Table>
                                </ContentTemplate>
                           </asp:UpdatePanel>                  
                   </div>
                   <div class="form-group col-md-12" style="text-align: center"> 
                        <asp:LinkButton ID="lbEnviar" runat="server" class="btn btn-primary" 
                            onclick="lbEnviar_Click" 
                            onclientclick="return Confirmar('¿Desea guardar los datos de Seguridad?');" 
                            Width="100px">Enviar</asp:LinkButton>
                        <asp:LinkButton ID="lbCancelar" runat="server" class="btn btn-danger" 
                            CausesValidation="False" Width="100px" onclick="lbCancelar_Click">Cancelar</asp:LinkButton>
                        <asp:LinkButton ID="IMPRIMIR" runat="server" class="btn btn-info" 
                            onclick="IMPRIMIR_Click" 
                            Width="120px" CausesValidation="False" 
                            onclientclick="abrir_ventana_imprimir_reporte(2);" Visible="False">Imprimir reporte</asp:LinkButton>
                             
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
    
      
    
       
    
      
    
    </form>
    
</body>
</html>
