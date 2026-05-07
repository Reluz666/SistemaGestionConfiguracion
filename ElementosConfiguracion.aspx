<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ElementosConfiguracion.aspx.cs" Inherits="ElementosConfiguracion"  UnobtrusiveValidationMode="None" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>Elementos de Configuración</title>

    <!-- Bootstrap 5.3 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet" />
    <!-- Global Styles -->
    <link href="CssJs/global-styles.css" rel="stylesheet" />

    <style>
        .search-card {
            background: #fff;
            border-radius: 12px;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            box-shadow: 0 2px 15px rgba(0,0,0,0.06);
        }
        .search-card .card-header {
            background: linear-gradient(135deg, #1a1a2e 0%, #16213e 100%);
            color: #fff;
            border-radius: 10px 10px 0 0;
            padding: 0.8rem 1rem;
            font-weight: 600;
            margin: -1.5rem -1.5rem 1rem -1.5rem;
        }
        .table-scroll {
            max-height: 400px;
            overflow-y: auto;
        }
    </style>

    <script lang="javascript" type="text/javascript">
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
        function MostrarMensaje() {
            var mensaje = document.getElementById("__mensaje").value;
            if (mensaje != "") {
                mostrarToast(mensaje, 'info');
                if (document.getElementById("__pagina").value != "")
                    location.href = document.getElementById("__pagina").value;
            }
        }

        function Confirmar(men) {
            if (!confirm(men))
                return false;
        }

        function mostrarToast(mensaje, tipo) {
            var container = document.getElementById('toastContainer');
            var toastId = 'toast_' + Date.now();
            var iconClass = 'bi-info-circle';
            var bgClass = 'bg-primary';

            switch(tipo) {
                case 'success': iconClass = 'bi-check-circle'; bgClass = 'bg-success'; break;
                case 'error': iconClass = 'bi-x-circle'; bgClass = 'bg-danger'; break;
                case 'warning': iconClass = 'bi-exclamation-triangle'; bgClass = 'bg-warning'; break;
            }

            var toastHtml = '<div id="' + toastId + '" class="toast" role="alert" aria-live="assertive" aria-atomic="true" data-bs-autohide="true" data-bs-delay="5000">' +
                '<div class="toast-header ' + bgClass + ' text-white">' +
                '<i class="bi ' + iconClass + ' me-2"></i>' +
                '<strong class="me-auto">Sistema</strong>' +
                '<button type="button" class="btn-close btn-close-white" data-bs-dismiss="toast" aria-label="Cerrar"></button>' +
                '</div>' +
                '<div class="toast-body">' + mensaje + '</div>' +
                '</div>';
            container.insertAdjacentHTML('beforeend', toastHtml);
            var toastElement = document.getElementById(toastId);
            var toast = new bootstrap.Toast(toastElement);
            toast.show();
            toastElement.addEventListener('hidden.bs.toast', function() { toastElement.remove(); });
        }

        // Búsqueda en tiempo real
        function buscarEnTabla(input, tablaId) {
            var filter = input.value.toUpperCase();
            var table = document.getElementById(tablaId);
            var rows = table.getElementsByTagName('tr');

            for (var i = 1; i < rows.length; i++) {
                var visible = false;
                var cells = rows[i].getElementsByTagName('td');

                for (var j = 0; j < cells.length; j++) {
                    var cell = cells[j];
                    if (cell) {
                        var text = cell.textContent || cell.innerText;
                        if (text.toUpperCase().indexOf(filter) > -1) {
                            visible = true;
                            break;
                        }
                    }
                }
                rows[i].style.display = visible ? '' : 'none';
            }
        }
    </script>

    <script type="text/javascript" src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script type="text/javascript" src="../Otros_css_js/resaltar.js"></script>
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
    <form id="form1" runat="server">
        <div class="container">
            <div class="table-wrapper">
                <div class="container-fluid">
                    <!-- Breadcrumb -->
            <nav aria-label="breadcrumb" class="breadcrumb-nav">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="Menu.aspx"><i class="bi bi-house-door"></i> Inicio</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Elementos de Configuración</li>
                </ol>
            </nav>

            <!-- Card de Búsqueda -->
            <div class="search-card">
                <div class="card-header">
                    <i class="bi bi-search me-2"></i>Búsqueda de Elementos de Configuración
                </div>
                <div class="card-body">
                    <div class="row g-3">
                        <div class="col-md-4 col-sm-6">
                            <asp:TextBox ID="txtnci" runat="server" CssClass="form-control form-control-modern" MaxLength="25" autocomplete="off" placeholder="Nombre CI"></asp:TextBox>
                        </div>
                        <div class="col-md-4 col-sm-6">
                            <asp:DropDownList ID="ddltci" runat="server" CssClass="form-control form-control-modern" AppendDataBoundItems="True">
                                <asp:ListItem Value="">_____SELECCIONE TIPO CI_____</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="col-md-4 col-sm-6">
                            <asp:DropDownList ID="ddleci" runat="server" CssClass="form-control form-control-modern" AppendDataBoundItems="True">
                                <asp:ListItem Value="">_____SELECCIONE ESTADO CI_____</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="col-md-4 col-sm-6">
                            <asp:TextBox ID="txtpci" runat="server" CssClass="form-control form-control-modern" MaxLength="25" autocomplete="off" placeholder="Propietario CI"></asp:TextBox>
                        </div>
                        <div class="col-md-4 col-sm-6">
                            <asp:DropDownList ID="ddldci" runat="server" CssClass="form-control form-control-modern" AppendDataBoundItems="True">
                                <asp:ListItem Value="">_____SELECCIONE DESCRIPCION CI_____</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="col-md-4 col-sm-6">
                            <asp:DropDownList ID="ddlici" runat="server" CssClass="form-control form-control-modern" AppendDataBoundItems="True">
                                <asp:ListItem Value="">_____SELECCIONE IMPACTO CI_____</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="col-md-4 col-sm-6">
                            <asp:DropDownList ID="ddls" runat="server" CssClass="form-control form-control-modern" AppendDataBoundItems="True" OnSelectedIndexChanged="ddls_SelectedIndexChanged">
                                <asp:ListItem Value="">_____SELECCIONE SEDE_____</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="col-md-4 col-sm-6">
                            <asp:DropDownList ID="ddll" runat="server" CssClass="form-control form-control-modern" AppendDataBoundItems="True" AutoPostBack="True" OnSelectedIndexChanged="ddll_SelectedIndexChanged">
                                <asp:ListItem Value="">_____SELECCIONE LOCAL_____</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="col-md-4 col-sm-6">
                            <asp:DropDownList ID="ddla" runat="server" CssClass="form-control form-control-modern" AppendDataBoundItems="True">
                                <asp:ListItem Value="">_____SELECCIONE AREA_____</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div class="d-flex flex-wrap gap-2 mt-3">
                        <asp:LinkButton ID="lbtnBuscar" runat="server" CausesValidation="False" CssClass="btn btn-primary btn-modern" OnClick="lbtnBuscar_Click" UseSubmitBehavior="False">
                            <i class="bi bi-search"></i> Buscar
                        </asp:LinkButton>
                        <asp:Button ID="btnActualizarInformacion" runat="server" CssClass="btn btn-warning btn-modern" OnClick="btnActualizarInformacion_Click" Text="Actualizar Información" />
                        <a href="ElementoConfiguracion.aspx?Operacion=N" class="btn btn-success btn-modern ms-auto">
                            <i class="bi bi-plus-circle"></i> Nuevo Elemento
                        </a>
                    </div>
                </div>
            </div>

            <!-- Tabla de Resultados -->
            <div class="table-wrapper">
                <asp:Table ID="Table_" runat="server" CssClass="table table-modern-grid table-hover">
                    <asp:TableRow ID="CABECERA" runat="server" Visible="false">
                                <asp:TableCell ID="_ID_CI" runat="server" BackColor="#FFFFC0" BorderColor="#FFFFC0"
                                         ForeColor="Green" Visible="False">ID CI</asp:TableCell>

                                <asp:TableCell ID="_NOMBRE_CI" runat="server" BackColor="Black" BorderColor="Black"
                                    ForeColor="White" >NOMBRE CI</asp:TableCell>

                                <asp:TableCell ID="_ID_TIPO_CI" runat="server" BackColor="Black" BorderColor="Black"
                                    ForeColor="White" Visible="False">ID TIPO CI</asp:TableCell>

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

                                <asp:TableCell ID="_ID_PROPIETARIO" runat="server" BackColor="Black" BorderColor="Black"
                                    ForeColor="White" Visible="False">ID_PROPIETARIO</asp:TableCell>

                                <asp:TableCell ID="_PROPIETARIO" runat="server" BackColor="Black" BorderColor="Black"
                                    ForeColor="White" Visible="True">PROPIETARIO CI</asp:TableCell>

                                <asp:TableCell ID="_DESCRIPCION_CI" runat="server" BackColor="Black" BorderColor="Black"
                                    ForeColor="White" >DESCRIPCION CI</asp:TableCell>

                                <asp:TableCell ID="_IMPACTO__PRIORIDAD_CI" runat="server" BackColor="Black" BorderColor="Black"
                                    ForeColor="White" >IMPACTO / PRIORIDAD</asp:TableCell>

                                <asp:TableCell ID="_SEDE_LOCAL" runat="server" BackColor="Black" BorderColor="Black"
                                    ForeColor="White" >SEDE / <br />LOCAL</asp:TableCell>
                                <asp:TableCell ID="_UBICACION_LOCAL" runat="server" BackColor="Black" BorderColor="Black"
                                    ForeColor="White" Visible="false" >UBICACION LOCAL</asp:TableCell>
                                <asp:TableCell ID="_DIRECCION_LOCAL" runat="server" BackColor="Black" BorderColor="Black"
                                    ForeColor="White" Visible="false" >DIRECCION LOCAL</asp:TableCell>
                                <asp:TableCell ID="_ID_AREA" runat="server" BackColor="Black" BorderColor="Black"
                                    ForeColor="White" Visible="False">ID AREA LOCAL</asp:TableCell>
                                <asp:TableCell ID="_AREA" runat="server" BackColor="Black" BorderColor="Black"
                                    ForeColor="White" >AREA</asp:TableCell>
                                <asp:TableCell ID="_NRO_PISO_AMBIENTE" runat="server" BackColor="Black" BorderColor="Black"
                                    ForeColor="White">NRO<br /> PISO / <br />AMBIENTE</asp:TableCell>
                                <asp:TableCell ID="_FEC_CREACION_CI" runat="server" BackColor="Black" BorderColor="Black"
                                    ForeColor="White" >FEC. CREACION</asp:TableCell>
                                <asp:TableCell ID="_ID_RESPONSABLE" runat="server" BackColor="Black" BorderColor="Black"
                                    ForeColor="White" Visible="False">ID RESPONSABLE</asp:TableCell>
                                <asp:TableCell ID="_RESPONSABLE" runat="server" BackColor="Black" BorderColor="Black"
                                    ForeColor="White" >RESPONSABLE REGISTRO CI</asp:TableCell>
                                <asp:TableCell ID="EDITAR" runat="server" BackColor="Black" BorderColor="Black"
                                    ForeColor="White" Width="5%" HorizontalAlign="Center">ACCIONES</asp:TableCell>
                            </asp:TableRow>
                        </asp:Table>
                    </div>
                </div>
            </div>

            <asp:HiddenField ID="__pagina" runat="server" />
            <asp:HiddenField ID="__mensaje" runat="server" />
        </div>
    </form>

</body>
</html>
