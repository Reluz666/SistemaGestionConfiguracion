<%@ Page Language="C#" AutoEventWireup="true" CodeFile="LicenciaElementoConfiguracion.aspx.cs" Inherits="Licencia_Elemento_Configuracion" UnobtrusiveValidationMode="None" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>Licencia Elemento Configuracion</title>

    <!-- Bootstrap 5.3 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet" />
    <!-- Global Styles -->
    <link href="CssJs/global-styles.css" rel="stylesheet" />

    <style>
        /* ===== NAVBAR ===== */
        .navbar-modern {
            background: linear-gradient(135deg, #1a1a2e 0%, #16213e 100%);
            border: none;
            box-shadow: 0 2px 15px rgba(0, 0, 0, 0.15);
            padding: 0.8rem 1rem;
        }

        .navbar-modern .navbar-brand {
            color: #fff !important;
            font-weight: 600;
            font-size: 1.2rem;
        }

        .navbar-modern .navbar-brand:hover {
            color: #e94560 !important;
        }

        .navbar-modern .nav-link {
            color: rgba(255, 255, 255, 0.85) !important;
            font-weight: 500;
            padding: 0.6rem 1rem !important;
            border-radius: 8px;
            transition: color 0.2s, background 0.2s;
        }

        .navbar-modern .nav-link:hover {
            color: #fff !important;
            background: rgba(255, 255, 255, 0.1);
        }

        .navbar-modern .dropdown-menu {
            background: #1a1a2e;
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 12px;
            padding: 0.5rem;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.3);
        }

        .navbar-modern .dropdown-item {
            color: rgba(255, 255, 255, 0.8);
            border-radius: 8px;
            padding: 0.5rem 1rem;
            transition: all 0.2s;
        }

        .navbar-modern .dropdown-item:hover {
            background: rgba(233, 69, 96, 0.2);
            color: #fff;
        }

        .navbar-modern .dropdown-submenu {
            position: relative;
        }

        .navbar-modern .dropdown-submenu > .dropdown-toggle::after {
            border-left: 0.3em solid;
            border-top: 0.3em solid transparent;
            border-bottom: 0.3em solid transparent;
            margin-left: auto;
        }

        .navbar-modern .dropdown-submenu > .dropdown-menu {
            top: 0;
            left: 100%;
            margin-top: -6px;
            margin-left: 2px;
            border-radius: 12px;
        }

        .navbar-modern .dropdown-submenu:hover > .dropdown-menu {
            display: block;
        }

        /* ===== FORMULARIO ===== */
        .form-card {
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 4px 25px rgba(0, 0, 0, 0.08);
            padding: 2rem;
            margin-bottom: 2rem;
            border: 1px solid rgba(0, 0, 0, 0.05);
        }

        .form-card .card-header {
            background: linear-gradient(135deg, #1a1a2e 0%, #16213e 100%);
            color: #fff;
            border-radius: 12px 12px 0 0;
            padding: 1.2rem 1.5rem;
            font-weight: 600;
            font-size: 1.1rem;
            border: none;
        }

        .form-label-modern {
            font-weight: 500;
            color: #2d3436;
            margin-bottom: 0.4rem;
            font-size: 0.9rem;
        }

        .form-control-modern {
            border: 2px solid #e9ecef;
            border-radius: 10px;
            padding: 0.6rem 1rem;
            transition: border-color 0.3s, box-shadow 0.3s;
            font-size: 0.95rem;
        }

        .form-control-modern:focus {
            border-color: #e94560;
            box-shadow: 0 0 0 4px rgba(233, 69, 96, 0.1);
            outline: none;
        }

        .form-control-modern::placeholder {
            color: #adb5bd;
        }

        select.form-control-modern {
            cursor: pointer;
        }

        /* ===== TABLA ===== */
        .table-wrapper {
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 4px 25px rgba(0, 0, 0, 0.08);
            padding: 1rem;
            border: 1px solid rgba(0, 0, 0, 0.05);
            overflow-x: auto;
        }

        .table-modern-grid {
            border-collapse: separate !important;
            border-spacing: 0;
            width: 100%;
            min-width: 900px;
        }

        .table-modern-grid thead tr th {
            background: linear-gradient(135deg, #1a1a2e 0%, #16213e 100%);
            color: #fff;
            font-weight: 600;
            font-size: 0.7rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            padding: 0.6rem 0.5rem !important;
            border: none !important;
            white-space: nowrap;
        }

        .table-modern-grid thead tr th:first-child {
            border-radius: 10px 0 0 10px;
        }

        .table-modern-grid thead tr th:last-child {
            border-radius: 0 10px 10px 0;
        }

        .table-modern-grid tbody tr td {
            padding: 0.5rem 0.45rem !important;
            border: none;
            border-bottom: 1px solid #f1f1f1;
            vertical-align: middle;
            font-size: 0.8rem;
            color: #2d3436;
            background: #fff;
        }

        .table-modern-grid tbody tr:hover td {
            background: rgba(233, 69, 96, 0.04);
        }

        .table-modern-grid tbody tr:last-child td {
            border-bottom: none;
        }

        /* Link button "Editar" en la tabla */
        .btn-link-personal {
            color: #d40924;
            font-weight: 700;
            font-size: 0.8rem;
            text-decoration: none;
            cursor: pointer;
            background: rgba(212, 9, 36, 0.08);
            padding: 0.25rem 0.6rem;
            border-radius: 6px;
            border: 1px solid rgba(212, 9, 36, 0.3);
            transition: all 0.2s ease;
            display: inline-block;
        }

        .btn-link-personal:hover {
            background: rgba(212, 9, 36, 0.15);
            border-color: #d40924;
            text-decoration: none;
            transform: translateY(-1px);
        }

        /* ===== BOTONES ===== */
        .btn-modern {
            padding: 0.6rem 1.5rem;
            border-radius: 10px;
            font-weight: 600;
            font-size: 0.95rem;
            transition: all 0.3s ease;
            border: none;
        }

        .btn-modern:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
        }

        /* ===== VALIDATORS ===== */
        .validator-error {
            color: #e94560;
            font-size: 0.8rem;
            font-weight: 500;
        }

        /* ===== SPACER ===== */
        .top-spacer { height: 100px; }

        /* ===== RESPONSIVE ===== */
        @media (max-width: 991px) {
            .navbar-modern .dropdown-submenu > .dropdown-menu {
                position: static;
                margin-top: 0;
                margin-left: 1rem;
                box-shadow: none;
            }
            .form-card { padding: 1.5rem; }
            .table-wrapper { padding: 1rem; }
        }

        @media (max-width: 576px) {
            .btn-modern { width: 100%; margin-bottom: 0.5rem; }
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

            document.getElementById("btnFechaInicioVersion").disabled = "disabled"
            document.getElementById("btnFechaFinVersion").disabled = "disabled"

            var TL = document.getElementById("ddlTIPO_LICENCIA_CI").options[document.getElementById("ddlTIPO_LICENCIA_CI").selectedIndex].text;
            var SL = document.getElementById("ddlSUSCRIPCION_LICENCIA_CI").options[document.getElementById("ddlSUSCRIPCION_LICENCIA_CI").selectedIndex].text;
            if (TL == 'PROPIETARIO' && SL != 'NINGUNA' && SL != '_____SELECCIONE SUSCRIPCION LICENCIA ELEMENTO CONFIGURACION_____') {
                document.getElementById("btnFechaInicioVersion").disabled = ""
                document.getElementById("btnFechaFinVersion").disabled = ""
            }
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

    <script type="text/javascript" src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body onload="MostrarMensaje()">

    <!-- ========== NAVBAR ========== -->
    <nav class="navbar navbar-expand-lg navbar-modern fixed-top">
        <div class="container-fluid">
            <a class="navbar-brand" href="Menu.aspx">
                <i class="bi bi-house-door-fill me-1"></i>Inicio
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                    data-bs-target="#navbarNav" aria-controls="navbarNav"
                    aria-expanded="false" aria-label="Navegaci&oacute;n">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">

                    <!-- Mantenimiento -->
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="mantenimientoDropdown"
                           role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            <i class="bi bi-briefcase-fill me-1"></i>Mantenimiento
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="mantenimientoDropdown">
                            <li><a class="dropdown-item" href="Personal.aspx">Personal</a></li>
                            <li class="dropdown-submenu">
                                <a class="dropdown-item dropdown-toggle" href="#">Tablas Instituci&oacute;n</a>
                                <ul class="dropdown-menu">
                                    <li><a class="dropdown-item" href="Sede.aspx">Sede</a></li>
                                    <li><a class="dropdown-item" href="Local.aspx">Local</a></li>
                                    <li><a class="dropdown-item" href="Area.aspx">&Aacute;rea</a></li>
                                    <li><a class="dropdown-item" href="Dependencia.aspx">Dependencia</a></li>
                                </ul>
                            </li>
                            <li class="dropdown-submenu">
                                <a class="dropdown-item dropdown-toggle" href="#">Tablas Personal</a>
                                <ul class="dropdown-menu">
                                    <li><a class="dropdown-item" href="Cargo.aspx">Cargo</a></li>
                                    <li><a class="dropdown-item" href="ProfecionOcupacion.aspx">Profesi&oacute;n - Ocupaci&oacute;n</a></li>
                                </ul>
                            </li>
                            <li><hr class="dropdown-divider" /></li>
                            <li class="dropdown-submenu">
                                <a class="dropdown-item dropdown-toggle" href="#">Tablas Elemento Configuraci&oacute;n</a>
                                <ul class="dropdown-menu">
                                    <li><a class="dropdown-item" href="Modelo.aspx">Modelo</a></li>
                                    <li><a class="dropdown-item" href="Marca.aspx">Marca</a></li>
                                    <li><a class="dropdown-item" href="DescripcionElementoConfiguracion.aspx">Descripci&oacute;n Elemento Configuraci&oacute;n</a></li>
                                    <li><a class="dropdown-item" href="TiposElementoConfiguracion.aspx">Tipos Elemento Configuraci&oacute;n</a></li>
                                    <li><a class="dropdown-item" href="TipoRelacionElementoConfiguracion.aspx">Tipo Relaci&oacute;n Elemento Configuraci&oacute;n</a></li>
                                    <li><a class="dropdown-item" href="TipoComponeneteCI.aspx">Tipo Componente Elemento Configuraci&oacute;n</a></li>
                                    <li><a class="dropdown-item" href="EstadoActualCI.aspx">Estado Actual Elemento Configuraci&oacute;n</a></li>
                                </ul>
                            </li>
                        </ul>
                    </li>

                    <!-- Gesti&oacute;n de Configuraci&oacute;n -->
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="gestionDropdown"
                           role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            <i class="bi bi-person-lines-fill me-1"></i>Gesti&oacute;n de Configuraci&oacute;n
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="gestionDropdown">
                            <li><a class="dropdown-item" href="ElementosConfiguracion.aspx">Elementos de Configuraci&oacute;n</a></li>
                            <li><a class="dropdown-item" href="RelacionesElementosConfiguracion.aspx">Relaci&oacute;n de Elementos de Configuraci&oacute;n</a></li>
                            <li><hr class="dropdown-divider" /></li>
                            <li><a class="dropdown-item" href="CIsAsignarComponenetes.aspx">Asignar Componentes Elementos de Configuraci&oacute;n</a></li>
                            <li><hr class="dropdown-divider" /></li>
                            <li><a class="dropdown-item" href="LicenciasElementoConfiguracion.aspx">Licencias de Elementos de Configuraci&oacute;n</a></li>
                            <li><hr class="dropdown-divider" /></li>
                            <li><a class="dropdown-item" href="SeguimientosElementoConfiguracion.aspx">Seguimiento de Elementos de Configuraci&oacute;n</a></li>
                        </ul>
                    </li>

                    <!-- Reportes -->
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="reportesDropdown"
                           role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            <i class="bi bi-file-earmark-bar-graph-fill me-1"></i>Reportes
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="reportesDropdown">
                            <li><a class="dropdown-item" href="../Reportes/ReporteElementosConfiguracion.aspx">Reporte de Elementos de Configuraci&oacute;n</a></li>
                            <li><a class="dropdown-item" href="../Reportes/ReporteRelacionesElementosConfiguracion.aspx">Reporte de Relaciones de Elementos de Configuraci&oacute;n</a></li>
                            <li><a class="dropdown-item" href="../Reportes/ReporteSeguimientosElementoConfiguracion.aspx">Reporte de Seguimientos de Elementos de Configuraci&oacute;n</a></li>
                            <li><a class="dropdown-item" href="../Reportes/ReporteLicenciasElementoConfiguracion.aspx">Reporte de Licencias de Elementos de Configuraci&oacute;n</a></li>
                            <li><a class="dropdown-item" href="../Reportes/ReporteCIsSeguidos.aspx">Reporte de Elementos de Configuraci&oacute;n Seguidos</a></li>
                            <li><a class="dropdown-item" href="../Reportes/ReporteComponentesAsignados.aspx">Reporte de Componentes de Elementos de Configuraci&oacute;n Asignados</a></li>
                            <li><hr class="dropdown-divider" /></li>
                            <li><a class="dropdown-item" href="../Reportes/ReporteDatosCorrectosCI.aspx">Reporte de Datos Correctos de Elementos de Configuraci&oacute;n</a></li>
                            <li><a class="dropdown-item" href="../Reportes/ReporteDatosIncorrectosCI.aspx">Reporte de Datos Incorrectos de Elementos de Configuraci&oacute;n</a></li>
                            <li><a class="dropdown-item" href="../Reportes/ReporteCIsInformacionContenidaEnCMDB.aspx">Reporte de Informaci&oacute;n de Elementos de Configuraci&oacute;n Contenidas en la CMDB</a></li>
                        </ul>
                    </li>

                    <!-- Configuraciones -->
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="configDropdown"
                           role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            <i class="bi bi-gear-fill me-1"></i>Configuraciones
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="configDropdown">
                            <li><a class="dropdown-item" href="Usuario.aspx">Usuarios</a></li>
                            <li><a class="dropdown-item" href="../Configuracion/Usuarios.aspx">Permisos</a></li>
                            <li><hr class="dropdown-divider" /></li>
                            <li><a class="dropdown-item" href="CerrarSession.aspx" style="color: #e94560;">Cerrar Sesi&oacute;n</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Espaciador para navbar fija -->
    <div class="top-spacer"></div>

    <!-- ========== FORMULARIO ========== -->
    <form id="form1" runat="server" class="form-horizontal" role="form">
        <div class="form-card">
            <div class="card-header">
                <i class="bi bi-file-earmark-plus-fill me-2"></i>Ingrese Datos Licencia
            </div>
            <div class="card-body p-3">
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
                    <div class="col-sm-offset-3 col-sm-10">

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
                </div>
            </div>
        </div>

        <!-- ========== LISTA DE LICENCIAS CON BUSQUEDA Y PAGINACION ========== -->
        <div class="container-fluid mt-4">
            <div class="form-card">
                <div class="card-header">
                    <i class="bi bi-list-ul me-2"></i>Lista de Licencias
                </div>
                <div class="card-body p-3">
                    <!-- Buscador -->
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <div class="input-group">
                                <span class="input-group-text"><i class="bi bi-search"></i></span>
                                <input type="text" id="txtBuscarLicencia" class="form-control" placeholder="Buscar por nombre, tipo, suscripcion..." autocomplete="off" />
                            </div>
                        </div>
                        <div class="col-md-6 text-end">
                            <span id="lblContador" class="badge bg-secondary"></span>
                        </div>
                    </div>

                    <!-- Tabla de Resultados -->
                    <div class="table-responsive">
                        <table class="table table-hover table-condensed table-modern-grid" id="tblListaLicencias" style="display:none;">
                            <thead>
                                <tr>
                                    <th>LICENCIA</th>
                                    <th>TIPO LICENCIA</th>
                                    <th>NOMBRE</th>
                                    <th>VERSION</th>
                                    <th>SUSCRIPCION</th>
                                    <th>FEC. INI.</th>
                                    <th>FEC. FIN</th>
                                    <th>PERPETUA</th>
                                    <th>DESCRIPCION</th>
                                    <th>VENCE</th>
                                    <th>ACCION</th>
                                </tr>
                            </thead>
                            <tbody id="tbodyLicencias"></tbody>
                        </table>
                        <div id="divSinResultados" class="alert alert-info text-center" style="display:none;">
                            No se encontraron licencias.
                        </div>
                    </div>

                    <!-- Paginacion -->
                    <div class="row mt-3">
                        <div class="col-md-12">
                            <nav>
                                <ul class="pagination justify-content-center" id="ulPaginacion"></ul>
                            </nav>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- HiddenField para datos JSON -->
        <asp:HiddenField ID="datosJson" runat="server" />

        <!-- Hidden button to handle edit postback from JavaScript -->
        <asp:Button ID="btnEditarLista" runat="server" OnClick="btnEditarLista_Click" Style="display:none;" />

    </form>

    <script type="text/javascript" src="../Otros_css_js/resaltar.js"></script>

    <script type="text/javascript">
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
    </script>

    <!-- Script para lista con busqueda y paginacion -->
    <script type="text/javascript">
        var datosLicencias = [];
        var paginaActual = 1;
        var itemsPorPagina = 10;

        function cargarDatos() {
            try {
                var jsonVal = document.getElementById('datosJson').value;
                if (jsonVal && jsonVal.trim() !== '') {
                    datosLicencias = JSON.parse(jsonVal);
                } else {
                    datosLicencias = [];
                }
            } catch (e) {
                datosLicencias = [];
            }
        }

        function formatearFecha(fechaStr) {
            if (!fechaStr || fechaStr.trim() === '') return '---';
            try {
                var fecha = new Date(fechaStr);
                var dia = fecha.getDate().toString().padStart(2, '0');
                var mes = (fecha.getMonth() + 1).toString().padStart(2, '0');
                var anio = fecha.getFullYear();
                return dia + '/' + mes + '/' + anio;
            } catch (e) {
                return fechaStr;
            }
        }

        function renderizarTabla() {
            var filtro = document.getElementById('txtBuscarLicencia').value.toUpperCase();
            var datosFiltrados = datosLicencias.filter(function (item) {
                if (!filtro) return true;
                return (item.NOMBRE && item.NOMBRE.toUpperCase().indexOf(filtro) !== -1) ||
                       (item['TIPO LICENCIA'] && item['TIPO LICENCIA'].toUpperCase().indexOf(filtro) !== -1) ||
                       (item.SUSCRIPCION && item.SUSCRIPCION.toUpperCase().indexOf(filtro) !== -1) ||
                       (item.DESCRIPCION && item.DESCRIPCION.toUpperCase().indexOf(filtro) !== -1) ||
                       (item.VERSION && item.VERSION.toUpperCase().indexOf(filtro) !== -1);
            });

            var tbl = document.getElementById('tblListaLicencias');
            var tbody = document.getElementById('tbodyLicencias');
            var divSinResultados = document.getElementById('divSinResultados');
            var lblContador = document.getElementById('lblContador');

            if (datosFiltrados.length === 0) {
                tbl.style.display = 'none';
                divSinResultados.style.display = 'block';
                lblContador.textContent = '';
                return;
            }

            tbl.style.display = 'table';
            divSinResultados.style.display = 'none';
            lblContador.textContent = 'Total: ' + datosFiltrados.length + ' licencia(s)';

            var totalPaginas = Math.ceil(datosFiltrados.length / itemsPorPagina);
            var inicio = (paginaActual - 1) * itemsPorPagina;
            var fin = inicio + itemsPorPagina;
            var datosPagina = datosFiltrados.slice(inicio, fin);

            tbody.innerHTML = '';
            for (var i = 0; i < datosPagina.length; i++) {
                var item = datosPagina[i];
                var perpetua = item.PERPETUA || '';
                var vence = item['VENCE LICENCIA'] || '';
                var tr = document.createElement('tr');
                tr.innerHTML = '<td>' + (item.LICENCIA || '') + '</td>' +
                    '<td>' + (item['TIPO LICENCIA'] || '') + '</td>' +
                    '<td>' + (item.NOMBRE || '') + '</td>' +
                    '<td>' + (item.VERSION || '') + '</td>' +
                    '<td>' + (item.SUSCRIPCION || '') + '</td>' +
                    '<td>' + formatearFecha(item['FEC. INI.']) + '</td>' +
                    '<td>' + formatearFecha(item['FEC. FIN']) + '</td>' +
                    '<td style="color:' + (perpetua === 'SI' ? 'blue' : 'red') + '">' + perpetua + '</td>' +
                    '<td>' + (item.DESCRIPCION || '') + '</td>' +
                    '<td style="color:' + (vence === 'LICENCIA VENCIDA' ? 'red' : (vence === 'LICENCIA NO VENCE' ? 'green' : 'blue')) + '">' + vence + '</td>' +
                    '<td><button type="button" class="btn btn-primary btn-sm" onclick="editarLicencia(\'' + (item.LICENCIA || '') + '\')">Editar</button></td>';
                tbody.appendChild(tr);
            }

            renderizarPaginacion(totalPaginas, datosFiltrados.length);
        }

        function renderizarPaginacion(totalPaginas, totalItems) {
            var ul = document.getElementById('ulPaginacion');
            ul.innerHTML = '';

            if (totalPaginas <= 1) return;

            var liPrev = document.createElement('li');
            liPrev.className = 'page-item' + (paginaActual === 1 ? ' disabled' : '');
            liPrev.innerHTML = '<a class="page-link" href="#" onclick="irPagina(' + (paginaActual - 1) + '); return false;">&laquo; Anterior</a>';
            ul.appendChild(liPrev);

            var maxBotones = 5;
            var inicio = Math.max(1, paginaActual - Math.floor(maxBotones / 2));
            var fin = Math.min(totalPaginas, inicio + maxBotones - 1);
            if (fin - inicio + 1 < maxBotones) {
                inicio = Math.max(1, fin - maxBotones + 1);
            }

            if (inicio > 1) {
                var li = document.createElement('li');
                li.className = 'page-item';
                li.innerHTML = '<a class="page-link" href="#" onclick="irPagina(1); return false;">1</a>';
                ul.appendChild(li);
                if (inicio > 2) {
                    var liPuntos = document.createElement('li');
                    liPuntos.className = 'page-item disabled';
                    liPuntos.innerHTML = '<a class="page-link" href="#">...</a>';
                    ul.appendChild(liPuntos);
                }
            }

            for (var i = inicio; i <= fin; i++) {
                var li = document.createElement('li');
                li.className = 'page-item' + (i === paginaActual ? ' active' : '');
                li.innerHTML = '<a class="page-link" href="#" onclick="irPagina(' + i + '); return false;">' + i + '</a>';
                ul.appendChild(li);
            }

            if (fin < totalPaginas) {
                if (fin < totalPaginas - 1) {
                    var liPuntos = document.createElement('li');
                    liPuntos.className = 'page-item disabled';
                    liPuntos.innerHTML = '<a class="page-link" href="#">...</a>';
                    ul.appendChild(liPuntos);
                }
                var li = document.createElement('li');
                li.className = 'page-item';
                li.innerHTML = '<a class="page-link" href="#" onclick="irPagina(' + totalPaginas + '); return false;">' + totalPaginas + '</a>';
                ul.appendChild(li);
            }

            var liSig = document.createElement('li');
            liSig.className = 'page-item' + (paginaActual === totalPaginas ? ' disabled' : '');
            liSig.innerHTML = '<a class="page-link" href="#" onclick="irPagina(' + (paginaActual + 1) + '); return false;">Siguiente &raquo;</a>';
            ul.appendChild(liSig);
        }

        function irPagina(numPagina) {
            paginaActual = numPagina;
            renderizarTabla();
        }

        function editarLicencia(idLicencia) {
            __doPostBack('btnEditarLista', idLicencia);
        }

        function initLista() {
            cargarDatos();
            renderizarTabla();
            document.getElementById('txtBuscarLicencia').addEventListener('keyup', function () {
                paginaActual = 1;
                renderizarTabla();
            });
        }

        if (window.addEventListener) {
            window.addEventListener('load', initLista, false);
        } else if (window.attachEvent) {
            window.attachEvent('onload', initLista);
        }
    </script>

</body>
</html>
