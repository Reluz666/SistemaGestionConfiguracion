<%@ Page Language="C#" AutoEventWireup="true" CodeFile="LicenciaElementoConfiguracion.aspx.cs" Inherits="Licencia_Elemento_Configuracion" UnobtrusiveValidationMode="None" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Licencia Elemento Configuracion</title>
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


        function abrir_ventana_Elementos_Configuracion_Software() {
            window.document.getElementById("ID_ELEMENTO_CONFIGURACION").value = 0;
            window.document.getElementById("TIPO_CI").value = "";
            window.document.getElementById("NOMBRE_CI").value = "";
            window.document.getElementById("NRO_SERIE").value = "";
            window.document.getElementById("PROPIETARIO_CI").value = "";
            window.document.getElementById("DESCRIPCION_CI").value = "";

            window.document.getElementById("__mensaje").value = "";
            window.document.getElementById("__pagina").value = "";
            var options = 'channelmode=1,directories=0,fullscreen=0,location=0,menubar=0,resizable=0,titlebar=0,toolbar=0,edge=Raised,status=no,scrollbars=1,width=1000,height=550,top=50px, left=175px';
            window.open('Ventanas/ventanaElementosConfiguracionSoftware.aspx', options);
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
            document.getElementById('<%= txtFechaInicioVersion.ClientID %>').readOnly = true;
            document.getElementById('<%= txtFechaFinVersion.ClientID %>').readOnly = true;

            document.getElementById('<%= TIPO_CI.ClientID %>').readOnly = true;
            document.getElementById('<%= NOMBRE_CI.ClientID %>').readOnly = true;
            document.getElementById('<%= NRO_SERIE.ClientID %>').readOnly = true;
            document.getElementById('<%= PROPIETARIO_CI.ClientID %>').readOnly = true;
            document.getElementById('<%= DESCRIPCION_CI.ClientID %>').readOnly = true;

            //document.getElementById('<%= LICENCIA_PERPETUA.ClientID %>').disabled = "disabled"
            



            document.getElementById("btnFechaInicioVersion").disabled = "disabled"
            //document.getElementById("btnFechaInicioVersion").hidden = "hidden"
            document.getElementById("btnFechaFinVersion").disabled = "disabled"
            //document.getElementById("btnFechaFinVersion").hidden = "hidden"

            //window.document.getElementById("txtFechaInicioVersion").value = "";
            //window.document.getElementById("txtFechaFinVersion").value = "";

            var TL = document.getElementById("ddlTIPO_LICENCIA_CI").options[document.getElementById("ddlTIPO_LICENCIA_CI").selectedIndex].text;
            var SL = document.getElementById("ddlSUSCRIPCION_LICENCIA_CI").options[document.getElementById("ddlSUSCRIPCION_LICENCIA_CI").selectedIndex].text;
            if (TL == 'PROPIETARIO' && SL != 'NINGUNA' && SL != '_____SELECCIONE SUSCRIPCION LICENCIA ELEMENTO CONFIGURACION_____') {
                document.getElementById("btnFechaInicioVersion").disabled = ""
                document.getElementById("btnFechaFinVersion").disabled = ""
                //document.getElementById("btnFechaInicioVersion").hidden = ""
                //document.getElementById("btnFechaFinVersion").hidden = ""

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

    <meta name="viewport" content="width=device-width, initial-scale=1" />
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

    <form id="form1" runat="server" class="form-horizontal" role="form">
        <div class="form-group">
            <div class="col-sm-offset-3 col-sm-10">

                <label for="lblTitulo" class="col-sm-3 control-label">Ingrese Datos Licencia</label>

            </div>
        </div>
        <div class="form-group">
            <label for="lblTIPO_LICENCIA_CI" class="col-sm-3 control-label">Tipo Licencia:</label>
            <div class="col-sm-5">

                <asp:DropDownList ID="ddlTIPO_LICENCIA_CI" runat="server" CssClass="form-control input-sm"
                    AppendDataBoundItems="True" AutoPostBack="True" OnSelectedIndexChanged="ddlTIPO_LICENCIA_CI_SelectedIndexChanged">
                    <asp:ListItem Value="-1">_____SELECCIONE TIPO LICENCIA ELEMENTO CONFIGURACION_____</asp:ListItem>
                </asp:DropDownList>

                <asp:RequiredFieldValidator ID="rfvTIPO_LICENCIA_CI" runat="server" ControlToValidate="ddlTIPO_LICENCIA_CI" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="revTIPO_LICENCIA_CI" runat="server" BackColor="White"
                    ControlToValidate="ddlTIPO_LICENCIA_CI" Display="Dynamic" ErrorMessage="*" ForeColor="Red"
                    SetFocusOnError="True" ValidationExpression="[1-999]"></asp:RegularExpressionValidator>

            </div>
        </div>
        <div class="form-group">
            <label for="lblSUSCRIPCION_LICENCIA_CI" class="col-sm-3 control-label">Suscripcion Licencia:</label>
            <div class="col-sm-5">

                <asp:DropDownList ID="ddlSUSCRIPCION_LICENCIA_CI" runat="server" CssClass="form-control input-sm"
                    AppendDataBoundItems="True" AutoPostBack="True" OnSelectedIndexChanged="ddlSUSCRIPCION_LICENCIA_CI_SelectedIndexChanged">
                    <asp:ListItem Value="-1">_____SELECCIONE SUSCRIPCION LICENCIA ELEMENTO CONFIGURACION_____</asp:ListItem>
                </asp:DropDownList>

                <asp:RequiredFieldValidator ID="rfvSUSCRIPCION_LICENCIA_CI" runat="server" ControlToValidate="ddlSUSCRIPCION_LICENCIA_CI" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="revSUSCRIPCION_LICENCIA_CI" runat="server" BackColor="White"
                    ControlToValidate="ddlSUSCRIPCION_LICENCIA_CI" Display="Dynamic" ErrorMessage="*" ForeColor="Red"
                    SetFocusOnError="True" ValidationExpression="[1-999]"></asp:RegularExpressionValidator>

            </div>
        </div>
        <div class="form-group">
            <label for="lblNOMBRE" class="col-sm-3 control-label">Nombre:</label>
            <div class="col-sm-5">

                <asp:TextBox ID="NOMBRE" runat="server" CssClass="form-control input-sm" MaxLength="25" Autocomplete="off" placeholder="Ingresar Nombre Licencia Elemento Configuracion" onchange="CambiaLetraMayuscula('NOMBRE')"
                    onkeypress="SoloLetrasMinusculas()"></asp:TextBox>

                <asp:RequiredFieldValidator ID="rfvNOMBRE" runat="server" ControlToValidate="NOMBRE" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>

            </div>
        </div>
        <div class="form-group">
            <label for="lblVERSION" class="col-sm-3 control-label">Version:</label>
            <div class="col-sm-5">

                <asp:TextBox ID="VERSION" runat="server" CssClass="form-control input-sm" MaxLength="25" Autocomplete="off" placeholder="Ingresar Version Licencia Elemento Configuracion" onchange="CambiaLetraMayuscula('VERSION')"
                    onkeypress="SoloLetrasMinusculas()"></asp:TextBox>

                <asp:RequiredFieldValidator ID="rfvVERSION" runat="server" ControlToValidate="VERSION" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>

            </div>
        </div>


        <div class="form-group">
            <label for="lblFecha" class="col-sm-3 control-label">Fecha:</label>
            <div class="col-sm-5">

                <div class="btn-group-justified">
                    <asp:TextBox ID="txtFechaInicioVersion" runat="server"
                        class="form-control" placeholder="Ingrese fec. inicio licencia CI" Width="" onFocus='' onChange='' onBlur=''></asp:TextBox>
                    <span class="form-check"></span>

                    <input id="btnFechaInicioVersion" type="button"
                        value="..." style="height: 25px; width: 25px;"
                        class="form-check" />
                    <asp:RequiredFieldValidator ID="rfvFechaInicioVersion" runat="server" ControlToValidate="txtFechaInicioVersion" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                    <span class="input-group-addon" style="border-style: none; border-color: #FFFFFF; background-color: #FFFFFF"></span>

                    <asp:TextBox ID="txtFechaFinVersion" runat="server" class="form-control" placeholder="Ingrese fec. fin licencia CI" onFocus='' onChange='' onBlur=''></asp:TextBox>
                    <span class="form-check"></span>
                    <input id="btnFechaFinVersion" type="button"
                        value="..." style="height: 25px; width: 25px;" class="form-check" />
                    <span class="form-check">

                        <asp:RequiredFieldValidator ID="rfvFechaFinVersion" runat="server" ControlToValidate="txtFechaFinVersion" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>

                        <asp:CompareValidator ID="cvFechas" runat="server" ControlToCompare="txtFechaInicioVersion" ControlToValidate="txtFechaFinVersion" ErrorMessage="Feha Inicio Licencia debe ser menor a la Fecha Final Licencia" ForeColor="Red" Operator="GreaterThanEqual"></asp:CompareValidator>

                    </span>
                </div>
            </div>
        </div>
        <div class="form-group">
            <label for="lblLICENCIA_PERPETUA" class="col-sm-3 control-label">Licencia Perpetua:</label>
            <div class="col-sm-5">



                <asp:CheckBox ID="LICENCIA_PERPETUA" runat="server" CssClass="form-check-input position-static&quot" Text="Si / No" />



            </div>
        </div>


        <div class="form-group">
            <label for="lblDESCRIPCION" class="col-sm-3 control-label">Descripcion:</label>
            <div class="col-sm-5">

                <asp:TextBox ID="DESCRIPCION" runat="server" CssClass="form-control input-sm" MaxLength="25" Autocomplete="off" placeholder="Ingresar Descripcion Licencia Elemento Configuracion" onchange="CambiaLetraMayuscula('DESCRIPCION')"
                    onkeypress="SoloLetrasMinusculas()"></asp:TextBox>

                <span class="form-check">

                    <asp:RequiredFieldValidator ID="rfvDESCRIPCION" runat="server" ControlToValidate="DESCRIPCION" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>

                </span>

            </div>
        </div>

        <div class="form-group">
            <div class="col-sm-offset-3 col-sm-11">

                <label for="lblTitulo" class="col-sm-3 control-label">Ingrese Datos Elemento Configuracion Software</label>

            </div>
        </div>

        <div class="form-group">
            <div class="col-sm-offset-3 col-sm-10">

                <asp:Button ID="btnBucar" runat="server"
                    Style="font-family: Calibri; color: #000000; font-size: medium"
                    Text="Buscar Elemento Configuracion"
                    CssClass="btn btn-info" OnClick="btnBucar_Click" UseSubmitBehavior="False" />


            </div>
        </div>

        <div class="form-group">
            <label for="lblTIPOCI" class="col-sm-3 control-label">Tipo CI:</label>
            <div class="col-sm-5">

                <asp:HiddenField ID="ID_ELEMENTO_CONFIGURACION" runat="server" Value="0"
                    EnableViewState="False" />

                <asp:TextBox ID="TIPO_CI" runat="server" CssClass="form-control input-sm" MaxLength="25" Autocomplete="off" placeholder="Ingresar Tipo Elemento Configuracion" onchange="CambiaLetraMayuscula('TIPO_CI')"
                    onkeypress="SoloLetrasMinusculas()"></asp:TextBox>

            </div>
        </div>

        <div class="form-group">
            <label for="lblNOMBRCI" class="col-sm-3 control-label">Nombre CI:</label>
            <div class="col-sm-5">

                <asp:TextBox ID="NOMBRE_CI" runat="server" CssClass="form-control input-sm" MaxLength="25" Autocomplete="off" placeholder="Ingresar Nombre Elemento Configuracion" onchange="CambiaLetraMayuscula('NOMBRE_CI')"
                    onkeypress="SoloLetrasMinusculas()"></asp:TextBox>

            </div>
        </div>

        <div class="form-group">
            <label for="lblNROSERIE" class="col-sm-3 control-label">Nro. Serie:</label>
            <div class="col-sm-5">

                <asp:TextBox ID="NRO_SERIE" runat="server" CssClass="form-control input-sm" MaxLength="25" Autocomplete="off" placeholder="Ingresar Nro. Serie Elemento Configuracion" onchange="CambiaLetraMayuscula('NRO_SERIE')"
                    onkeypress="SoloLetrasMinusculas()"></asp:TextBox>

            </div>
        </div>

        <div class="form-group">
            <label for="lblPROPIETARIOCI" class="col-sm-3 control-label">Propietario CI:</label>
            <div class="col-sm-5">

                <asp:TextBox ID="PROPIETARIO_CI" runat="server" CssClass="form-control input-sm" MaxLength="25" Autocomplete="off" placeholder="Ingresar Propietario Elemento Configuracion" onchange="CambiaLetraMayuscula('PROPIETARIO_CI')"
                    onkeypress="SoloLetrasMinusculas()"></asp:TextBox>

            </div>
        </div>

        <div class="form-group">
            <label for="lblDESCRIPCION_CI" class="col-sm-3 control-label">Descripcion CI:</label>
            <div class="col-sm-5">

                <asp:TextBox ID="DESCRIPCION_CI" runat="server" CssClass="form-control input-sm" MaxLength="25" Autocomplete="off" placeholder="Ingresar Descripcion Licencia Elemento Configuracion" onchange="CambiaLetraMayuscula('DESCRIPCION_CI')"
                    onkeypress="SoloLetrasMinusculas()"></asp:TextBox>

            </div>
        </div>


        <div class="form-group">
            <div class="col-sm-offset-3 col-sm-10">

                <asp:Button ID="btnAgregarCI" runat="server"
                    Style="font-family: Calibri; color: #000000; font-size: medium"
                    Text="Agregar Elemento Configuracion"
                    CssClass="btn btn-info" CausesValidation="False" OnClick="btnAgregarCI_Click" />


            </div>
        </div>


        <div class="form-group">
            <div class="col-sm-offset-1 col-sm-8">

                <asp:Table ID="Table_" runat="server" CssClass="form-control input"
                    class="table table-hover table-condensed" BackColor="White" BorderColor="White"
                    CellPadding="6" CellSpacing="2" Font-Size="Small" GridLines="Both" Width="100%"
                    Style="text-align: left">
                    <asp:TableRow ID="TableRow1" runat="server">
                        <asp:TableCell ID="tcID_RE" runat="server" BackColor="Black" BorderColor="Black"
                            ForeColor="White" Width="7%" Visible="false">ID RE</asp:TableCell>

                        <asp:TableCell ID="tcIdCi" runat="server" BackColor="Black" BorderColor="Black"
                            ForeColor="White" Width="7%" Visible="false">ID CI</asp:TableCell>

                        <asp:TableCell ID="tcTipo_CI" runat="server" BackColor="Black" BorderColor="Black"
                            ForeColor="White" Width="20%">TIPO CI</asp:TableCell>

                        <asp:TableCell ID="tcNombre_CI" runat="server" BackColor="Black" BorderColor="Black"
                            ForeColor="White" Width="20%">NOMBRE CI</asp:TableCell>

                        <asp:TableCell ID="tcNro_Serie" runat="server" BackColor="Black" BorderColor="Black"
                            ForeColor="White" Width="20%">NRO. SERIE</asp:TableCell>

                        <asp:TableCell ID="tcPropietario_CI" runat="server" BackColor="Black" BorderColor="Black"
                            ForeColor="White" Width="20%">PROPIETARIO CI</asp:TableCell>

                        <asp:TableCell ID="tcDescripcion_CI" runat="server" BackColor="Black" BorderColor="Black"
                            ForeColor="White" Width="20%" Visible="true">DESCRIPCION CI</asp:TableCell>

                        <asp:TableCell ID="seleccionar_personal" runat="server" BackColor="Black" BorderColor="Black"
                            ForeColor="White" Width="7%" HorizontalAlign="Center">CI</asp:TableCell>


                    </asp:TableRow>
                </asp:Table>

            </div>
        </div>



        <div class="form-group">
            <div class="col-sm-offset-4 col-sm-10">

                <asp:Button ID="btnRegistrar" runat="server"
                    Style="font-family: Calibri; color: #000000; font-size: medium"
                    Text="Aceptar"
                    CssClass="btn btn-success" OnClick="btnRegistrar_Click" />
                <asp:Button ID="btnCancelar" runat="server" class="btn btn-danger"
                    Style="font-family: Calibri; font-size: medium" Text="Cancelar" CausesValidation="False" PostBackUrl="~/LicenciasElementoConfiguracion.aspx" />

                <asp:HiddenField ID="__mensaje" runat="server" />
                <asp:HiddenField ID="__pagina" runat="server" />

                <b>
                    <asp:HiddenField ID="_operacion" runat="server" Value="N" 
                        EnableViewState="False" />
                    <asp:HiddenField ID="hfFILA_DETALLE_RELACION_LICENCIA_ELEMENTO_CONFIGURACION" runat="server" Value="-1" />
                    <asp:HiddenField ID="hfID_LICENCIA_ELE_CONF" runat="server" Value="-1" />
                </b>

            </div>
    </form>

    <script lang ="JavaScript" type="text/javascript">
        ResaltarFila('Table_');
    </script>	

    <script type="text/javascript" src="../bootstrap/js/jquery-1.12.4.min.js"></script>
    <script type="text/javascript" src="../bootstrap/js/bootstrap.min.js"></script>


    <script type="text/javascript">//<![CDATA[
        Calendar.setup({
            inputField: "txtFechaInicioVersion",
            trigger: "btnFechaInicioVersion",
            onSelect: function () { this.hide() },
            showTime: 12,
            dateFormat: "%d/%m/%Y"
        });
        Calendar.setup({
            inputField: "txtFechaFinVersion",
            trigger: "btnFechaFinVersion",
            onSelect: function () { this.hide() },
            showTime: 12,
            dateFormat: "%d/%m/%Y"
        });
        //]]></script>
</body>
</html>
