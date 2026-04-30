<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Personal.aspx.cs" Inherits="Personal" UnobtrusiveValidationMode="None" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>Personal</title>

    <!-- Bootstrap 5.3 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet" />
    <!-- DataTables.net CSS -->
    <link href="https://cdn.jsdelivr.net/npm/datatables.net-bs5@2.0.1/css/dataTables.bootstrap5.min.css" rel="stylesheet" />
    <!-- Custom Menu CSS -->
    <link href="CssJs/Menu.css" rel="stylesheet" />

    <style>
        /* ===== NAVBAR MODERNA ===== */
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
            transition: all 0.3s ease;
        }

        .navbar-modern .navbar-brand:hover {
            color: #e94560 !important;
            transform: translateX(3px);
        }

        .navbar-modern .nav-link {
            color: rgba(255, 255, 255, 0.85) !important;
            font-weight: 500;
            padding: 0.6rem 1rem !important;
            border-radius: 8px;
            transition: all 0.3s ease;
            position: relative;
        }

        .navbar-modern .nav-link:hover {
            color: #fff !important;
            background: rgba(255, 255, 255, 0.1);
        }

        .navbar-modern .nav-link::after {
            content: '';
            position: absolute;
            bottom: 4px;
            left: 50%;
            width: 0;
            height: 2px;
            background: #e94560;
            transition: all 0.3s ease;
            transform: translateX(-50%);
        }

        .navbar-modern .nav-link:hover::after {
            width: 60%;
        }

        .navbar-modern .dropdown-toggle::after {
            border-top: 0.3em solid;
            transition: transform 0.3s ease;
        }

        .navbar-modern .dropdown-toggle:hover::after {
            transform: rotate(180deg);
        }

        .navbar-modern .dropdown-menu {
            background: #1a1a2e;
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 12px;
            padding: 0.5rem;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.3);
            animation: fadeIn 0.2s ease;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .navbar-modern .dropdown-item {
            color: rgba(255, 255, 255, 0.8);
            border-radius: 8px;
            padding: 0.5rem 1rem;
            transition: all 0.2s ease;
        }

        .navbar-modern .dropdown-item:hover {
            background: rgba(233, 69, 96, 0.2);
            color: #fff;
            transform: translateX(5px);
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

        /* ===== FORMULARIO MODERNO ===== */
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
            transition: all 0.3s ease;
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

        /* ===== TABLA MODERNA ===== */
        .table-modern-wrapper {
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 4px 25px rgba(0, 0, 0, 0.08);
            padding: 1.5rem;
            border: 1px solid rgba(0, 0, 0, 0.05);
        }

        .table-modern {
            border-collapse: separate !important;
            border-spacing: 0;
        }

        .table-modern thead tr th {
            background: linear-gradient(135deg, #1a1a2e 0%, #16213e 100%);
            color: #fff;
            font-weight: 600;
            font-size: 0.85rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            padding: 1rem 0.8rem !important;
            border: none !important;
            white-space: nowrap;
        }

        .table-modern thead tr th:first-child {
            border-radius: 10px 0 0 10px !important;
        }

        .table-modern thead tr th:last-child {
            border-radius: 0 10px 10px 0 !important;
        }

        .table-modern tbody tr {
            transition: all 0.2s ease;
        }

        .table-modern tbody tr:hover {
            background: rgba(233, 69, 96, 0.05) !important;
        }

        .table-modern tbody tr td {
            padding: 0.85rem 0.8rem !important;
            border: none;
            border-bottom: 1px solid #f1f1f1;
            vertical-align: middle;
            font-size: 0.9rem;
            color: #2d3436;
        }

        .table-modern tbody tr:last-child td {
            border-bottom: none;
        }

        .table-modern .btn-sm {
            padding: 0.35rem 0.75rem;
            font-size: 0.8rem;
            border-radius: 8px;
        }

        .estado-activo {
            color: #00b894;
            font-weight: 600;
        }

        .estado-inactivo {
            color: #e94560;
            font-weight: 600;
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

        .btn-modern:active {
            transform: translateY(0);
        }

        .btn-success-modern {
            background: linear-gradient(135deg, #00b894 0%, #00a085 100%);
            color: #fff;
        }

        .btn-warning-modern {
            background: linear-gradient(135deg, #fdcb6e 0%, #f39c12 100%);
            color: #2d3436;
        }

        .btn-danger-modern {
            background: linear-gradient(135deg, #e94560 0%, #c0392b 100%);
            color: #fff;
        }

        .btn-primary-modern {
            background: linear-gradient(135deg, #0984e3 0%, #0652DD 100%);
            color: #fff;
        }

        .btn-secondary-modern {
            background: linear-gradient(135deg, #636e72 0%, #535c5f 100%);
            color: #fff;
        }

        /* ===== VALIDATORS ===== */
        .validator-error {
            color: #e94560;
            font-size: 0.8rem;
            font-weight: 500;
        }

        /* ===== DATA TABLES CUSTOM ===== */
        .dataTables_filter input {
            border: 2px solid #e9ecef;
            border-radius: 8px;
            padding: 0.5rem 1rem;
            margin-left: 0.5rem;
        }

        .dataTables_filter input:focus {
            border-color: #e94560;
            outline: none;
        }

        .dataTables_length select {
            border: 2px solid #e9ecef;
            border-radius: 8px;
            padding: 0.4rem 2rem 0.4rem 0.75rem;
        }

        .dataTables_paginate .paginate_button {
            border-radius: 8px !important;
            margin: 0 2px;
        }

        .dataTables_paginate .paginate_button.current {
            background: linear-gradient(135deg, #e94560 0%, #c0392b 100%) !important;
            color: #fff !important;
            border: none !important;
        }

        .dataTables_paginate .paginate_button:hover {
            background: rgba(233, 69, 96, 0.1) !important;
            color: #e94560 !important;
            border: none !important;
        }

        /* ===== SPACER ===== */
        .top-spacer {
            height: 100px;
        }

        /* ===== RESPONSIVE ===== */
        @media (max-width: 991px) {
            .navbar-modern .dropdown-submenu > .dropdown-menu {
                position: static;
                margin-top: 0;
                margin-left: 1rem;
                box-shadow: none;
            }

            .form-card {
                padding: 1.5rem;
            }

            .table-modern-wrapper {
                padding: 1rem;
            }
        }

        @media (max-width: 576px) {
            .btn-modern {
                width: 100%;
                margin-bottom: 0.5rem;
            }
        }
    </style>

    <script lang="javascript" type="text/javascript">
        function MostrarMensaje() {
            var mensaje = document.getElementById("__mensaje").value;
            if (mensaje != "") {
                alert(mensaje);
                var pagina = document.getElementById("__pagina").value;
                if (pagina !== "")
                    location.href = pagina;
            }
        }

        function Confirmar(men) {
            if (!confirm(men))
                return false;
            return true;
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

        function initDataTable() {
            if (typeof $.fn.DataTable !== 'undefined') {
                $('#TablePersonal').DataTable({
                    language: {
                        url: 'https://cdn.jsdelivr.net/npm/datatables.net-plugins@2.0.1/i18n/es-ES.json'
                    },
                    lengthMenu: [[5, 10, 25, 50, -1], [5, 10, 25, 50, "Todos"]],
                    pageLength: 10,
                    order: [[1, 'asc']],
                    dom: 'Bfrtip',
                    buttons: [],
                    responsive: true,
                    columnDefs: [
                        { orderable: false, targets: -1 }
                    ]
                });
            }
        }
    </script>
</head>
<body onload="MostrarMensaje()">

    <!-- ========== NAVBAR MODERNA ========== -->
    <nav class="navbar navbar-expand-lg navbar-modern fixed-top">
        <div class="container-fluid">
            <a class="navbar-brand" href="../menu.aspx">
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

            <!-- Card Formulario -->
            <div class="form-card">
                <div class="card-header">
                    <i class="bi bi-person-plus-fill me-2"></i>Ingrese Datos del Personal
                </div>
                <div class="card-body p-4">

                    <!-- Fila 1: C&oacute;digo, Nombre, Apellido Pat., Apellido Mat. -->
                    <div class="row g-3 mb-3">
                        <div class="col-md-3 col-sm-6">
                            <label class="form-label-modern">C&oacute;digo</label>
                            <asp:TextBox ID="Codigo" runat="server" CssClass="form-control form-control-modern"
                                         MaxLength="5" Autocomplete="off" placeholder="Ingrese c&oacute;digo"
                                         onkeypress="SoloNumeros()" />
                            <asp:RequiredFieldValidator ID="rfvCodigo" runat="server" ControlToValidate="Codigo"
                                                       ErrorMessage="*" CssClass="validator-error" />
                            <asp:RegularExpressionValidator ID="revCodigo" runat="server" ControlToValidate="Codigo"
                                                             ErrorMessage="C&oacute;digo debe tener 5 d&iacute;gitos"
                                                             CssClass="validator-error"
                                                             ValidationExpression="\d{5}" />
                        </div>
                        <div class="col-md-3 col-sm-6">
                            <label class="form-label-modern">Nombre</label>
                            <asp:TextBox ID="Nombre" runat="server" CssClass="form-control form-control-modern"
                                         MaxLength="25" Autocomplete="off" placeholder="Ingrese nombre"
                                         onchange="CambiaLetraMayuscula('Nombre')" onkeypress="SoloLetrasMinusculas()" />
                            <asp:RequiredFieldValidator ID="rfvNombre" runat="server" ControlToValidate="Nombre"
                                                       ErrorMessage="*" CssClass="validator-error" />
                        </div>
                        <div class="col-md-3 col-sm-6">
                            <label class="form-label-modern">Apellido Paterno</label>
                            <asp:TextBox ID="ApellidoPat" runat="server" CssClass="form-control form-control-modern"
                                         MaxLength="25" Autocomplete="off" placeholder="Apellido paterno"
                                         onchange="CambiaLetraMayuscula('ApellidoPat')" onkeypress="SoloLetrasMinusculas()" />
                            <asp:RequiredFieldValidator ID="rfvApellidoPat" runat="server" ControlToValidate="ApellidoPat"
                                                       ErrorMessage="*" CssClass="validator-error" />
                        </div>
                        <div class="col-md-3 col-sm-6">
                            <label class="form-label-modern">Apellido Materno</label>
                            <asp:TextBox ID="ApellidoMat" runat="server" CssClass="form-control form-control-modern"
                                         MaxLength="25" Autocomplete="off" placeholder="Apellido materno"
                                         onchange="CambiaLetraMayuscula('ApellidoMat')" onkeypress="SoloLetrasMinusculas()" />
                            <asp:RequiredFieldValidator ID="rfvApellidoMat" runat="server" ControlToValidate="ApellidoMat"
                                                       ErrorMessage="*" CssClass="validator-error" />
                        </div>
                    </div>

                    <!-- Fila 2: Tipo Doc., Nro Doc., Profesi&oacute;n, Tel&eacute;fono -->
                    <div class="row g-3 mb-3">
                        <div class="col-md-3 col-sm-6">
                            <label class="form-label-modern">Tipo Doc. Ident.</label>
                            <asp:DropDownList ID="TipoDocIdent" runat="server" CssClass="form-control form-control-modern"
                                             AppendDataBoundItems="True">
                                <asp:ListItem Value="-1">___SELECCIONE TIPO DOC.___</asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="rfvTipoDocIdent" runat="server" ControlToValidate="TipoDocIdent"
                                                       ErrorMessage="*" CssClass="validator-error" />
                        </div>
                        <div class="col-md-3 col-sm-6">
                            <label class="form-label-modern">Nro. Doc. Ident.</label>
                            <asp:TextBox ID="NroDocIdent" runat="server" CssClass="form-control form-control-modern"
                                         MaxLength="25" Autocomplete="off" placeholder="N&uacute;mero de documento"
                                         onkeypress="SoloNumeros()" />
                            <asp:RequiredFieldValidator ID="rfvNroDocIdent" runat="server" ControlToValidate="NroDocIdent"
                                                       ErrorMessage="*" CssClass="validator-error" />
                        </div>
                        <div class="col-md-3 col-sm-6">
                            <label class="form-label-modern">Profesi&oacute;n</label>
                            <asp:DropDownList ID="Profesion" runat="server" CssClass="form-control form-control-modern"
                                             AppendDataBoundItems="True">
                                <asp:ListItem Value="-1">___SELECCIONE PROFESI&Oacute;N___</asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="rfvProfesion" runat="server" ControlToValidate="Profesion"
                                                       ErrorMessage="*" CssClass="validator-error" />
                        </div>
                        <div class="col-md-3 col-sm-6">
                            <label class="form-label-modern">Tel&eacute;fono</label>
                            <asp:TextBox ID="Telefono" runat="server" CssClass="form-control form-control-modern"
                                         MaxLength="9" Autocomplete="off" placeholder="N&uacute;mero telef&oacute;nico"
                                         onkeypress="SoloNumeros()" />
                            <asp:RequiredFieldValidator ID="rfvTelefono" runat="server" ControlToValidate="Telefono"
                                                       ErrorMessage="*" CssClass="validator-error" />
                        </div>
                    </div>

                    <!-- Fila 3: Email, Sede, Local, &Aacute;rea -->
                    <div class="row g-3 mb-3">
                        <div class="col-md-3 col-sm-6">
                            <label class="form-label-modern">Email</label>
                            <asp:TextBox ID="Email" runat="server" CssClass="form-control form-control-modern"
                                         MaxLength="100" placeholder="email@ejemplo.com" />
                            <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="Email"
                                                       ErrorMessage="*" CssClass="validator-error" />
                            <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="Email"
                                                             Display="Dynamic" ErrorMessage="Email incorrecto"
                                                             CssClass="validator-error"
                                                             ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" />
                        </div>
                        <div class="col-md-3 col-sm-6">
                            <label class="form-label-modern">Sede</label>
                            <asp:DropDownList ID="Sede" runat="server" CssClass="form-control form-control-modern"
                                             AppendDataBoundItems="True" AutoPostBack="True"
                                             OnSelectedIndexChanged="Sede_SelectedIndexChanged">
                                <asp:ListItem Value="-1">___SELECCIONE SEDE___</asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="rfvSede" runat="server" ControlToValidate="Sede"
                                                       ErrorMessage="*" CssClass="validator-error" />
                            <asp:RegularExpressionValidator ID="revSede" runat="server" ControlToValidate="Sede"
                                                             Display="Dynamic" ErrorMessage="*"
                                                             CssClass="validator-error"
                                                             ValidationExpression="\d{1,999}" />
                        </div>
                        <div class="col-md-3 col-sm-6">
                            <label class="form-label-modern">Local</label>
                            <asp:DropDownList ID="Local" runat="server" CssClass="form-control form-control-modern"
                                             AppendDataBoundItems="True" AutoPostBack="True"
                                             OnSelectedIndexChanged="Local_SelectedIndexChanged">
                                <asp:ListItem Value="-1">___SELECCIONE LOCAL___</asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="rfvLocal" runat="server" ControlToValidate="Local"
                                                       ErrorMessage="*" CssClass="validator-error" />
                            <asp:RegularExpressionValidator ID="revLocal" runat="server" ControlToValidate="Local"
                                                             Display="Dynamic" ErrorMessage="*"
                                                             CssClass="validator-error"
                                                             ValidationExpression="\d{1,999}" />
                        </div>
                        <div class="col-md-3 col-sm-6">
                            <label class="form-label-modern">&Aacute;rea</label>
                            <asp:DropDownList ID="Area" runat="server" CssClass="form-control form-control-modern"
                                             AppendDataBoundItems="True">
                                <asp:ListItem Value="-1">___SELECCIONE &Aacute;REA___</asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="rfvArea" runat="server" ControlToValidate="Area"
                                                       ErrorMessage="*" CssClass="validator-error" />
                            <asp:RegularExpressionValidator ID="revArea" runat="server" ControlToValidate="Area"
                                                             Display="Dynamic" ErrorMessage="*"
                                                             CssClass="validator-error"
                                                             ValidationExpression="\d{1,999}" />
                        </div>
                    </div>

                    <!-- Fila 4: Dependencia, Cargo, Estado -->
                    <div class="row g-3 mb-4">
                        <div class="col-md-4 col-sm-6">
                            <label class="form-label-modern">Dependencia</label>
                            <asp:DropDownList ID="Dependencia" runat="server" CssClass="form-control form-control-modern"
                                             AppendDataBoundItems="True">
                                <asp:ListItem Value="-1">___SELECCIONE DEPENDENCIA___</asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="rfvDependencia" runat="server" ControlToValidate="Dependencia"
                                                       ErrorMessage="*" CssClass="validator-error" />
                            <asp:RegularExpressionValidator ID="revDependencia" runat="server" ControlToValidate="Dependencia"
                                                             Display="Dynamic" ErrorMessage="*"
                                                             CssClass="validator-error"
                                                             ValidationExpression="\d{1,999}" />
                        </div>
                        <div class="col-md-4 col-sm-6">
                            <label class="form-label-modern">Cargo</label>
                            <asp:DropDownList ID="Cargo" runat="server" CssClass="form-control form-control-modern"
                                             AppendDataBoundItems="True">
                                <asp:ListItem Value="-1">___SELECCIONE CARGO___</asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="rfvCargo" runat="server" ControlToValidate="Cargo"
                                                       ErrorMessage="*" CssClass="validator-error" />
                        </div>
                        <div class="col-md-4 col-sm-6 d-flex align-items-end">
                            <div class="form-check">
                                <asp:CheckBox ID="Estado" runat="server" CssClass="form-check-input" />
                                <label class="form-check-label ms-2 form-label-modern" for="Estado">Activo</label>
                            </div>
                        </div>
                    </div>

                    <!-- Botones de acci&oacute;n -->
                    <div class="d-flex flex-wrap gap-2 justify-content-center">
                        <asp:Button ID="btnRegistrar" runat="server" Text="Registrar" CssClass="btn btn-success btn-modern"
                                    OnClick="btnRegistrar_Click"
                                    OnClientClick="return Confirmar('¿Desea registrar Personal?');" />
                        <asp:Button ID="btnModificar" runat="server" Text="Modificar" CssClass="btn btn-warning btn-modern"
                                    OnClick="btnModificar_Click"
                                    OnClientClick="return Confirmar('¿Desea modificar Personal?');" />
                        <asp:Button ID="btnEliminar" runat="server" Text="Eliminar" CssClass="btn btn-danger btn-modern"
                                    OnClick="btnEliminar_Click"
                                    OnClientClick="return Confirmar('¿Desea eliminar Personal?');" />
                        <asp:Button ID="btnCancelar" runat="server" Text="Cancelar" CssClass="btn btn-secondary btn-modern"
                                    OnClick="btnCancelar_Click" CausesValidation="False" />
                    </div>
                </div>
            </div>

            <!-- Card Tabla de Resultados -->
            <div class="table-modern-wrapper">
                <asp:Table ID="TablePersonal" runat="server" CssClass="table table-modern table-hover w-100">
                    <asp:TableRow ID="TableRow1" runat="server">
                        <asp:TableCell ID="tcId" runat="server" Visible="false">ID PER</asp:TableCell>
                        <asp:TableCell ID="tcSede" runat="server">SEDE</asp:TableCell>
                        <asp:TableCell ID="tcLocal" runat="server">LOCAL</asp:TableCell>
                        <asp:TableCell ID="tcArea" runat="server">&Aacute;REA</asp:TableCell>
                        <asp:TableCell ID="tcDependencia" runat="server">DEPENDENCIA</asp:TableCell>
                        <asp:TableCell ID="tcCodigo" runat="server">C&Oacute;DIGO</asp:TableCell>
                        <asp:TableCell ID="tcPersonal" runat="server">PERSONAL</asp:TableCell>
                        <asp:TableCell ID="tcTipoDocIdent" runat="server">TIPO DOC</asp:TableCell>
                        <asp:TableCell ID="tcNroDoc" runat="server">NRO. DOC.</asp:TableCell>
                        <asp:TableCell ID="tcProfesion" runat="server">PROFESI&Oacute;N</asp:TableCell>
                        <asp:TableCell ID="tcTelefono" runat="server">TEL&Eacute;FONO</asp:TableCell>
                        <asp:TableCell ID="tcEmail" runat="server">EMAIL</asp:TableCell>
                        <asp:TableCell ID="tcCargo" runat="server">CARGO</asp:TableCell>
                        <asp:TableCell ID="tcEstado" runat="server">ESTADO</asp:TableCell>
                        <asp:TableCell ID="seleccionar_personal" runat="server">SELECCIONAR</asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
            </div>

            <!-- Hidden Fields -->
            <asp:HiddenField ID="__mensaje" runat="server" />
            <asp:HiddenField ID="__pagina" runat="server" />
            <asp:HiddenField ID="ID_PERSONAL" runat="server" Value="0" EnableViewState="False" />

        </div>
    </form>

    <!-- Scripts -->
    <script type="text/javascript" src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/datatables.net@2.0.1/js/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/datatables.net-bs5@2.0.1/js/dataTables.bootstrap5.min.js"></script>
    <script type="text/javascript" src="../Otros_css_js/resaltar.js"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            ResaltarFila('TablePersonal');
            initDataTable();
        });
    </script>

</body>
</html>
