<%@ Page Language="C#" AutoEventWireup="true" CodeFile="LicenciasElementoConfiguracion.aspx.cs" Inherits="LicenciasElementoConfiguracion" UnobtrusiveValidationMode="None" %>

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
        function MostrarMensaje() {
            var mensaje = document.getElementById("__mensaje").value;
            if (mensaje != "") {
                alert(mensaje);
                if (document.getElementById("__pagina").value != "")
                    location.href = document.getElementById("__pagina").value;
            }
        }

        function Confirmar(men) {
            if (!confirm(men))
                return false;
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
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <div class="container">
            <div>
                <div class="table-wrapper">
                    <div class="container-fluid">
                <table class="table table text-center">
                    <tr>
                        <td style="text-align: left" colspan="7">
                       <asp:Button ID="btnNuevaLicencia" runat="server"
                    Style="font-family: Calibri; color: #000000; font-size: medium"
                    Text="Nueva Licencia Elemento Configuracion"
                    CssClass="btn btn-info" UseSubmitBehavior="False" OnClick="btnNuevaLicencia_Click" />
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: left" >
                            <asp:CheckBox ID="cbtl" runat="server" CssClass="form-check-input position-static&quot" Font-Size="X-Small" Text="Tipo Licencia" AutoPostBack="True" OnCheckedChanged="cbtl_CheckedChanged"/>
                        </td>
                        <td style="text-align: left" >
                            <asp:CheckBox ID="cbs" runat="server" CssClass="form-check-input position-static&quot" Font-Size="X-Small" Text="Suscripcion" AutoPostBack="True" OnCheckedChanged="cbs_CheckedChanged"/>
                        </td>
                        <td style="text-align: left" >
                            <asp:CheckBox ID="cbp" runat="server" CssClass="form-check-input position-static&quot" Font-Size="X-Small" Text="Licencia Perpetua" AutoPostBack="True" OnCheckedChanged="cbp_CheckedChanged"/>
                        </td>
                        <td style="text-align: left" class="auto-style1" colspan="4" >
                            <asp:CheckBox ID="cbf" runat="server" CssClass="form-check-input position-static&quot" Font-Size="X-Small" Text="Fecha Vencimiento Suscripcion" AutoPostBack="True" OnCheckedChanged="cbf_CheckedChanged"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:DropDownList ID="ddltl" runat="server" CssClass="form-control input-sm"
                                        AppendDataBoundItems="True" Enabled="False" AutoPostBack="True" OnSelectedIndexChanged="ddltl_SelectedIndexChanged"
                                       >
                                        <asp:ListItem Value="-1">_____SELECCIONE TIPO LICENCIA_____</asp:ListItem>
                                    </asp:DropDownList>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddls" runat="server" CssClass="form-control input-sm"
                                        AppendDataBoundItems="True" Enabled="False"
                                       >
                                        <asp:ListItem Value="-1">_____SELECCIONE SUSCRIPCION LICENCIA_____</asp:ListItem>
                                    </asp:DropDownList>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlp" runat="server" CssClass="form-control input-sm"
                                        AppendDataBoundItems="True" Enabled="False"
                                       >
                                        <asp:ListItem Value="-1">_____SELECCIONE OPCION_____</asp:ListItem>
                                        <asp:ListItem Value="1">SI</asp:ListItem>
                                        <asp:ListItem Value="0">NO</asp:ListItem>
                                    </asp:DropDownList>
                        </td>
                        <td class="auto-style1">
                            <strong>Fec. Ini:</strong></td>
                        <td style="text-align: left" >
                    <asp:TextBox ID="txtFechaInicioSuscripcion" runat="server"
                        class="form-control" placeholder="Ingrese fec. inicio" Width="" onFocus='' onChange='' onBlur='' Enabled="False"></asp:TextBox>

                    <input id="btnFechaInicioSuscripcion" type="button"
                        value="..." style="height: 25px; width: 25px;"
                        class="form-check" /></td>
                        <td>

                            <strong>Fec. Fin</strong>:</td>
                       <td style="text-align: left" >

                    <asp:TextBox ID="txtFechaFinSuscripcion" runat="server" class="form-control" placeholder="Ingrese fec. fin" onFocus='' onChange='' onBlur='' Enabled="False"></asp:TextBox>
                    <input id="btnFechaFinSuscripcion" type="button"
                        value="..." style="height: 25px; width: 25px;" class="form-check" /></td>
                    </tr>
                    <tr>
                        <td style="text-align: left" >
                            &nbsp;</td>
                        <td style="text-align: left" >
                            &nbsp;</td>
                        <td style="text-align: left" >
                            &nbsp;</td>
                        <td style="text-align: right" colspan="2" >
                            <asp:LinkButton ID="lbtnBuscar" runat="server" CausesValidation="False" class="btn btn-info" Text="Buscar  &lt;span class='glyphicon glyphicon-search'&gt;&lt;/span&gt;" UseSubmitBehavior="False" OnClick="lbtnBuscar_Click" />
                            </td>
                        <td style="text-align: left" colspan="2" >
                            <asp:Button ID="btnActualizarInformacion" runat="server" class="btn btn-success" CssClass="btn btn-warning" Text="Actualizar Informacion" OnClick="btnActualizarInformacion_Click" />
                        </td>
                    </tr>
                    </table>
                   </div>
                </div>

                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <asp:Table ID="tblLicencias" runat="server"
                            CssClass="table table-condensed table-responsive" Font-Size="Small">
                        </asp:Table>
                    </ContentTemplate>
                    <Triggers>
                    </Triggers>
                </asp:UpdatePanel>
            </div>
        </div>

        <asp:HiddenField ID="__mensaje" runat="server" />
        <asp:HiddenField ID="__pagina" runat="server" />
        <asp:HiddenField ID="datosJson" runat="server" />

        <!-- ========== LISTA CON BUSQUEDA Y PAGINACION ========== -->
        <div class="container mt-4" id="listSection">
            <div class="form-card">
                <div class="card-header">
                    <i class="bi bi-list-ul me-2"></i>Lista de Licencias
                </div>
                <div class="card-body">
                    <!-- Buscador -->
                    <div class="row mb-3">
                        <div class="col-md-8">
                            <input type="text" id="txtBuscarLicencia" class="form-control form-control-modern"
                                placeholder="Buscar por licencia, nombre, version o suscripcion..." />
                        </div>
                        <div class="col-md-4">
                            <span id="lblTotalRegistros" class="badge bg-primary fs-6 align-middle"></span>
                        </div>
                    </div>

                    <!-- Tabla de resultados -->
                    <div class="table-wrapper">
                        <table class="table table-modern-grid" id="tblListaLicencias">
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
                                    <th>VENCE</th>
                                </tr>
                            </thead>
                            <tbody id="tbodyLicencias">
                            </tbody>
                        </table>
                    </div>

                    <!-- Paginacion -->
                    <div class="row mt-3">
                        <div class="col-md-6">
                            <span id="lblPaginaActual" class="text-muted"></span>
                        </div>
                        <div class="col-md-6">
                            <nav aria-label="Paginacion licencias">
                                <ul class="pagination justify-content-end mb-0" id="paginationControls">
                                </ul>
                            </nav>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>

    <script type="text/javascript">
        function toggleRow(rowId) {
            var row = document.getElementById(rowId);
            if (row.style.display === "none" || row.style.display === "") {
                row.style.display = "table-row";
            } else {
                row.style.display = "none";
            }
        }
    </script>

    <script type="text/javascript" src="../Otros_css_js/resaltar.js"></script>

    <script type="text/javascript">
        Calendar.setup({
            inputField: "txtFechaInicioSuscripcion",
            trigger: "btnFechaInicioSuscripcion",
            onSelect: function () { this.hide() },
            showTime: 12,
            dateFormat: "%d/%m/%Y"
        });
        Calendar.setup({
            inputField: "txtFechaFinSuscripcion",
            trigger: "btnFechaFinSuscripcion",
            onSelect: function () { this.hide() },
            showTime: 12,
            dateFormat: "%d/%m/%Y"
        });
    </script>

    <script type="text/javascript">
        // ===== Variables globales para paginacion =====
        var allData = [];
        var currentPage = 1;
        var pageSize = 10;
        var filteredData = [];

        // ===== Inicializacion al cargar la pagina =====
        $(document).ready(function () {
            // Obtener datos del HiddenField
            var jsonData = document.getElementById("datosJson").value;
            if (jsonData && jsonData.trim() !== "") {
                try {
                    allData = JSON.parse(jsonData);
                    filteredData = allData;
                    renderTable();
                    renderPagination();
                } catch (e) {
                    console.error("Error al parsear JSON:", e);
                }
            }

            // Evento de busqueda
            $("#txtBuscarLicencia").on("keyup", function () {
                var searchTerm = $(this).val().toLowerCase().trim();
                if (searchTerm === "") {
                    filteredData = allData;
                } else {
                    filteredData = allData.filter(function (item) {
                        return item.LICENCIA.toLowerCase().indexOf(searchTerm) !== -1 ||
                               item.NOMBRE.toLowerCase().indexOf(searchTerm) !== -1 ||
                               item.VERSION.toLowerCase().indexOf(searchTerm) !== -1 ||
                               item.SUSCRIPCION.toLowerCase().indexOf(searchTerm) !== -1 ||
                               item["TIPO LICENCIA"].toLowerCase().indexOf(searchTerm) !== -1;
                    });
                }
                currentPage = 1;
                renderTable();
                renderPagination();
            });
        });

        // ===== Renderizar tabla con datos de la pagina actual =====
        function renderTable() {
            var tbody = document.getElementById("tbodyLicencias");
            tbody.innerHTML = "";

            // Calcular indices
            var startIndex = (currentPage - 1) * pageSize;
            var endIndex = Math.min(startIndex + pageSize, filteredData.length);
            var pageData = filteredData.slice(startIndex, endIndex);

            // Actualizar etiqueta de total
            document.getElementById("lblTotalRegistros").textContent =
                "Total: " + filteredData.length + " registro(s)";

            if (pageData.length === 0) {
                var tr = document.createElement("tr");
                tr.innerHTML = '<td colspan="9" class="text-center text-muted">No se encontraron resultados</td>';
                tbody.appendChild(tr);
                return;
            }

            // Generar filas
            for (var i = 0; i < pageData.length; i++) {
                var item = pageData[i];
                var tr = document.createElement("tr");

                var perpColor = item.PERPETUA === "SI" ? "color:#0066cc;" : "color:#cc0000;";
                var venceColor = "";
                if (item["VENCE LICENCIA"] === "LICENCIA VENCIDA") {
                    venceColor = "color:#cc0000;";
                } else if (item["VENCE LICENCIA"] === "LICENCIA NO DUELE") {
                    venceColor = "color:#008800;";
                } else {
                    venceColor = "color:#0066cc;";
                }

                tr.innerHTML =
                    '<td>' + item.LICENCIA + '</td>' +
                    '<td>' + item["TIPO LICENCIA"] + '</td>' +
                    '<td>' + item.NOMBRE + '</td>' +
                    '<td>' + item.VERSION + '</td>' +
                    '<td>' + item.SUSCRIPCION + '</td>' +
                    '<td>' + item["FEC. INI."] + '</td>' +
                    '<td>' + item["FEC. FIN"] + '</td>' +
                    '<td style="' + perpColor + '">' + item.PERPETUA + '</td>' +
                    '<td style="' + venceColor + '">' + item["VENCE LICENCIA"] + '</td>';
                tbody.appendChild(tr);
            }
        }

        // ===== Renderizar controles de paginacion =====
        function renderPagination() {
            var totalPages = Math.ceil(filteredData.length / pageSize);
            var ul = document.getElementById("paginationControls");
            ul.innerHTML = "";

            // Etiqueta de pagina actual
            document.getElementById("lblPaginaActual").textContent =
                "Pagina " + currentPage + " de " + (totalPages > 0 ? totalPages : 1);

            if (totalPages <= 1) {
                return;
            }

            // Boton Anterior
            var liPrev = document.createElement("li");
            liPrev.className = "page-item" + (currentPage === 1 ? " disabled" : "");
            liPrev.innerHTML = '<a class="page-link" href="#" aria-label="Anterior">&laquo;</a>';
            if (currentPage > 1) {
                liPrev.onclick = function () { goToPage(currentPage - 1); return false; };
            }
            ul.appendChild(liPrev);

            // Numeros de pagina
            var maxVisible = 5;
            var startPage = Math.max(1, currentPage - Math.floor(maxVisible / 2));
            var endPage = Math.min(totalPages, startPage + maxVisible - 1);
            if (endPage - startPage < maxVisible - 1) {
                startPage = Math.max(1, endPage - maxVisible + 1);
            }

            if (startPage > 1) {
                var liFirst = document.createElement("li");
                liFirst.className = "page-item";
                liFirst.innerHTML = '<a class="page-link" href="#">1</a>';
                liFirst.onclick = function () { goToPage(1); return false; };
                ul.appendChild(liFirst);
                if (startPage > 2) {
                    var liEllipsis = document.createElement("li");
                    liEllipsis.className = "page-item disabled";
                    liEllipsis.innerHTML = '<a class="page-link" href="#">...</a>';
                    ul.appendChild(liEllipsis);
                }
            }

            for (var i = startPage; i <= endPage; i++) {
                var li = document.createElement("li");
                li.className = "page-item" + (i === currentPage ? " active" : "");
                li.innerHTML = '<a class="page-link" href="#">' + i + '</a>';
                li.onclick = function (page) {
                    return function () { goToPage(page); return false; };
                }(i);
                ul.appendChild(li);
            }

            if (endPage < totalPages) {
                if (endPage < totalPages - 1) {
                    var liEllipsis2 = document.createElement("li");
                    liEllipsis2.className = "page-item disabled";
                    liEllipsis2.innerHTML = '<a class="page-link" href="#">...</a>';
                    ul.appendChild(liEllipsis2);
                }
                var liLast = document.createElement("li");
                liLast.className = "page-item";
                liLast.innerHTML = '<a class="page-link" href="#">' + totalPages + '</a>';
                liLast.onclick = function () { goToPage(totalPages); return false; };
                ul.appendChild(liLast);
            }

            // Boton Siguiente
            var liNext = document.createElement("li");
            liNext.className = "page-item" + (currentPage === totalPages ? " disabled" : "");
            liNext.innerHTML = '<a class="page-link" href="#" aria-label="Siguiente">&raquo;</a>';
            if (currentPage < totalPages) {
                liNext.onclick = function () { goToPage(currentPage + 1); return false; };
            }
            ul.appendChild(liNext);
        }

        // ===== Ir a una pagina especifica =====
        function goToPage(page) {
            currentPage = page;
            renderTable();
            renderPagination();
        }
    </script>

</body>
</html>
