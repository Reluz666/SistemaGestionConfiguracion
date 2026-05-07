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
    <!-- Global Styles -->
    <link href="CssJs/global-styles.css" rel="stylesheet" />

    <style>
        /* Solo estilos específicos de tabla para Personal */
        #TablePersonal {
            border-collapse: separate !important;
            border-spacing: 0;
            width: 100%;
            min-width: 900px;
        }

        #TablePersonal thead tr th {
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

        #TablePersonal tbody tr:hover td {
            background: rgba(233, 69, 96, 0.04) !important;
        }

        #TablePersonal tbody tr td {
            padding: 0.5rem 0.45rem !important;
            border: none !important;
            border-bottom: 1px solid #f1f1f1 !important;
            vertical-align: middle;
            font-size: 0.8rem;
            color: #2d3436;
        }

        .estado-activo { color: #00b894; font-weight: 600; }
        .estado-inactivo { color: #e94560; font-weight: 600; }

        /* ===== PAGINACION ===== */
        .pagination-wrapper {
            display: flex;
            justify-content: center;
            margin-top: 1.5rem;
            flex-wrap: wrap;
            gap: 0.25rem;
        }

        .pagination-wrapper .page-item.active .page-link {
            background: #e94560;
            border-color: #e94560;
        }

        .pagination-wrapper .page-link {
            border-radius: 8px;
            margin: 0 2px;
            color: #2d3436;
        }

        .pagination-wrapper .page-link:hover {
            background: rgba(233, 69, 96, 0.1);
            color: #e94560;
        }
    </style>

    <script lang="javascript" type="text/javascript">
        function MostrarMensaje() {
            var mensaje = document.getElementById("__mensaje").value;
            if (mensaje != "") {
                alert(mensaje);
                var pagina = document.getElementById("__pagina").value;
                if (pagina !== "") location.href = pagina;
            }
        }

        function Confirmar(men) {
            if (!confirm(men)) return false;
            return true;
        }

        function SoloNumeros() {
            if ((event.keyCode < 48) || (event.keyCode > 57)) event.returnValue = false;
        }

        function SoloLetrasMinusculas() {
            if (!((event.keyCode >= 97 && event.keyCode <= 122) || event.keyCode == 32
                || event.keyCode == 193 || event.keyCode == 201 || event.keyCode == 205
                || event.keyCode == 209 || event.keyCode == 211 || event.keyCode == 218
                || event.keyCode == 220 || event.keyCode == 241)) event.returnValue = false;
        }

        function CambiaLetraMayuscula(Caja) {
            document.getElementById(Caja).value = document.getElementById(Caja).value.toUpperCase();
        }

        function pageLoad() {
            initPagination();
        }

        function initPagination() {
            var rows = document.querySelectorAll('#TablePersonal tbody tr');
            var rowsPerPage = 10;
            var totalRows = rows.length;
            var totalPages = Math.ceil(totalRows / rowsPerPage);
            var currentPage = 1;

            function showPage(page) {
                currentPage = page;
                var start = (page - 1) * rowsPerPage;
                var end = start + rowsPerPage;
                rows.forEach(function (row, idx) {
                    row.style.display = (idx >= start && idx < end) ? '' : 'none';
                });
                renderPagination();
            }

            function renderPagination() {
                var wrapper = document.getElementById('paginationWrapper');
                if (!wrapper || totalPages <= 1) {
                    if (wrapper) wrapper.style.display = 'none';
                    return;
                }
                wrapper.style.display = 'flex';
                wrapper.innerHTML = '';

                var prev = document.createElement('li');
                prev.className = 'page-item' + (currentPage === 1 ? ' disabled' : '');
                prev.innerHTML = '<a class="page-link" href="#" aria-label="Anterior">&laquo;</a>';
                prev.addEventListener('click', function (e) {
                    e.preventDefault();
                    if (currentPage > 1) showPage(currentPage - 1);
                });
                wrapper.appendChild(prev);

                for (var i = 1; i <= totalPages; i++) {
                    var li = document.createElement('li');
                    li.className = 'page-item' + (i === currentPage ? ' active' : '');
                    li.innerHTML = '<a class="page-link" href="#">' + i + '</a>';
                    li.addEventListener('click', function (e) {
                        e.preventDefault();
                        showPage(parseInt(this.textContent));
                    });
                    wrapper.appendChild(li);
                }

                var next = document.createElement('li');
                next.className = 'page-item' + (currentPage === totalPages ? ' disabled' : '');
                next.innerHTML = '<a class="page-link" href="#" aria-label="Siguiente">&raquo;</a>';
                next.addEventListener('click', function (e) {
                    e.preventDefault();
                    if (currentPage < totalPages) showPage(currentPage + 1);
                });
                wrapper.appendChild(next);
            }

            showPage(1);
        }

        // ===== FUNCIONES PARA LISTA DE PERSONAL CON BUSQUEDA Y PAGINACION =====
        var datosPersonalJson = [];
        var listaCurrentPage = 1;
        var listaRowsPerPage = 10;
        var listaFilteredData = [];

        function cargarDatosPersonal() {
            var datosJsonField = document.getElementById('datosJson');
            if (datosJsonField && datosJsonField.value) {
                try {
                    datosPersonalJson = JSON.parse(datosJsonField.value);
                    listaFilteredData = datosPersonalJson.slice();
                    renderizarTablaPersonal();
                } catch (e) {
                    console.error('Error parsing JSON:', e);
                }
            }
        }

        function filtrarTablaPersonal() {
            var searchText = document.getElementById('txtBuscarPersonal').value.toLowerCase().trim();
            if (searchText === '') {
                listaFilteredData = datosPersonalJson.slice();
            } else {
                listaFilteredData = datosPersonalJson.filter(function(item) {
                    return item.CODIGO.toLowerCase().includes(searchText) ||
                           item.NOMBRE.toLowerCase().includes(searchText) ||
                           item.APELLIDO_PATERNO.toLowerCase().includes(searchText) ||
                           item.APELLIDO_MATERNO.toLowerCase().includes(searchText) ||
                           item.NRO_DOC_IDENT.toLowerCase().includes(searchText) ||
                           item.AREA.toLowerCase().includes(searchText) ||
                           item.DEPENDENCIA.toLowerCase().includes(searchText) ||
                           item.CARGO.toLowerCase().includes(searchText) ||
                           item.SEDE.toLowerCase().includes(searchText) ||
                           item.LOCAL.toLowerCase().includes(searchText);
                });
            }
            listaCurrentPage = 1;
            renderizarTablaPersonal();
        }

        function renderizarTablaPersonal() {
            var tbody = document.getElementById('tbodyListaPersonal');
            if (!tbody) return;

            var totalRows = listaFilteredData.length;
            var totalPages = Math.ceil(totalRows / listaRowsPerPage);
            var start = (listaCurrentPage - 1) * listaRowsPerPage;
            var end = start + listaRowsPerPage;

            // Actualizar contador
            var lblContador = document.getElementById('lblContadorPersonal');
            if (lblContador) {
                if (totalRows === 0) {
                    lblContador.textContent = 'No se encontraron registros';
                } else {
                    lblContador.textContent = 'Mostrando ' + (start + 1) + '-' + Math.min(end, totalRows) + ' de ' + totalRows + ' registros';
                }
            }

            // Limpiar tabla
            tbody.innerHTML = '';

            if (totalRows === 0) {
                var tr = document.createElement('tr');
                tr.innerHTML = '<td colspan="14" class="text-center text-muted py-4">No hay datos disponibles</td>';
                tbody.appendChild(tr);
                return;
            }

            // Renderizar filas
            for (var i = start; i < end && i < totalRows; i++) {
                var item = listaFilteredData[i];
                var tr = document.createElement('tr');
                var estadoClass = item.ESTADO === 'ACTIVO' ? 'estado-activo' : 'estado-inactivo';
                tr.innerHTML =
                    '<td>' + item.CODIGO + '</td>' +
                    '<td>' + item.NOMBRE + ' ' + item.APELLIDO_PATERNO + ' ' + item.APELLIDO_MATERNO + '</td>' +
                    '<td>' + item.TIPO_DOC_IDENT + '</td>' +
                    '<td>' + item.NRO_DOC_IDENT + '</td>' +
                    '<td>' + item.PROFESION + '</td>' +
                    '<td>' + item.TELEFONO + '</td>' +
                    '<td>' + item.EMAIL + '</td>' +
                    '<td>' + item.SEDE + '</td>' +
                    '<td>' + item.LOCAL + '</td>' +
                    '<td>' + item.AREA + '</td>' +
                    '<td>' + item.DEPENDENCIA + '</td>' +
                    '<td>' + item.CARGO + '</td>' +
                    '<td class="' + estadoClass + '">' + item.ESTADO + '</td>' +
                    '<td><button type="button" class="btn btn-sm btn-primary" onclick="seleccionarPersonal(\'' + item.ID_PERSONAL + '\')"><i class="bi bi-pencil-square"></i></button></td>';
                tbody.appendChild(tr);
            }

            // Renderizar paginacion
            renderizarPaginacionListaPersonal(totalPages);
        }

        function renderizarPaginacionListaPersonal(totalPages) {
            var wrapper = document.getElementById('paginationListaPersonal');
            if (!wrapper) return;

            wrapper.innerHTML = '';

            if (totalPages <= 1) {
                wrapper.style.display = 'none';
                return;
            }

            wrapper.style.display = 'flex';

            // Boton Anterior
            var prev = document.createElement('li');
            prev.className = 'page-item' + (listaCurrentPage === 1 ? ' disabled' : '');
            prev.innerHTML = '<a class="page-link" href="#" aria-label="Anterior">&laquo;</a>';
            prev.addEventListener('click', function (e) {
                e.preventDefault();
                if (listaCurrentPage > 1) {
                    listaCurrentPage--;
                    renderizarTablaPersonal();
                }
            });
            wrapper.appendChild(prev);

            // Numeros de pagina
            for (var i = 1; i <= totalPages; i++) {
                var li = document.createElement('li');
                li.className = 'page-item' + (i === listaCurrentPage ? ' active' : '');
                li.innerHTML = '<a class="page-link" href="#">' + i + '</a>';
                li.addEventListener('click', function (e) {
                    e.preventDefault();
                    listaCurrentPage = parseInt(this.textContent);
                    renderizarTablaPersonal();
                });
                wrapper.appendChild(li);
            }

            // Boton Siguiente
            var next = document.createElement('li');
            next.className = 'page-item' + (listaCurrentPage === totalPages ? ' disabled' : '');
            next.innerHTML = '<a class="page-link" href="#" aria-label="Siguiente">&raquo;</a>';
            next.addEventListener('click', function (e) {
                e.preventDefault();
                if (listaCurrentPage < totalPages) {
                    listaCurrentPage++;
                    renderizarTablaPersonal();
                }
            });
            wrapper.appendChild(next);
        }

        function seleccionarPersonal(idPersonal) {
            // Buscar el personal por ID y simular click en el boton editar correspondiente
            var linkButtons = document.querySelectorAll('#TablePersonal tbody tr td a');
            for (var i = 0; i < linkButtons.length; i++) {
                var arg = linkButtons[i].getAttribute('commandargument') || linkButtons[i].href;
                if (arg && arg.indexOf(idPersonal + ',') === 0) {
                    linkButtons[i].click();
                    // Scroll al formulario
                    document.querySelector('.form-card').scrollIntoView({ behavior: 'smooth' });
                    return;
                }
            }
        }

        // Inicializar cuando el documento este listo
        $(document).ready(function() {
            cargarDatosPersonal();
            // Re-inicializar paginacion original
            initPagination();
        });
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

    <!-- ========== LISTA DE PERSONAL CON BUSQUEDA Y PAGINACION ========== -->
    <div class="container mb-4">
        <div class="form-card">
            <div class="card-header">
                <i class="bi bi-list-ul me-2"></i>Lista de Personal
            </div>
            <div class="card-body p-3">
                <!-- Buscador -->
                <div class="row mb-3">
                    <div class="col-md-8">
                        <div class="input-group">
                            <span class="input-group-text bg-white">
                                <i class="bi bi-search"></i>
                            </span>
                            <input type="text" id="txtBuscarPersonal" class="form-control form-control-modern"
                                   placeholder="Buscar por C&oacute;digo, Nombre, Apellido, DNI, &Aacute;rea, Dependencia, Cargo..."
                                   onkeyup="filtrarTablaPersonal()" />
                            <button class="btn btn-outline-secondary" type="button" onclick="document.getElementById('txtBuscarPersonal').value=''; filtrarTablaPersonal();">
                                <i class="bi bi-x-lg"></i>
                            </button>
                        </div>
                    </div>
                    <div class="col-md-4 text-end">
                        <span id="lblContadorPersonal" class="form-text text-muted"></span>
                    </div>
                </div>

                <!-- Tabla HTML para lista de Personal -->
                <div class="table-wrapper" style="max-height: 500px; overflow-y: auto;">
                    <table id="tblListaPersonal" class="table table-modern-grid table-hover" style="min-width: 1000px;">
                        <thead>
                            <tr>
                                <th style="width: 60px;">C&Oacute;DIGO</th>
                                <th style="width: 150px;">NOMBRE COMPLETO</th>
                                <th style="width: 80px;">TIPO DOC</th>
                                <th style="width: 90px;">NRO. DOC</th>
                                <th style="width: 100px;">PROFESI&Oacute;N</th>
                                <th style="width: 80px;">TEL&Eacute;FONO</th>
                                <th style="width: 140px;">EMAIL</th>
                                <th style="width: 100px;">SEDE</th>
                                <th style="width: 80px;">LOCAL</th>
                                <th style="width: 100px;">&Aacute;REA</th>
                                <th style="width: 120px;">DEPENDENCIA</th>
                                <th style="width: 100px;">CARGO</th>
                                <th style="width: 70px;">ESTADO</th>
                                <th style="width: 80px;">ACCI&Oacute;N</th>
                            </tr>
                        </thead>
                        <tbody id="tbodyListaPersonal">
                        </tbody>
                    </table>
                </div>

                <!-- Paginacion para lista -->
                <div class="pagination-wrapper">
                    <ul id="paginationListaPersonal" class="pagination" style="flex-wrap: wrap;"></ul>
                </div>
            </div>
        </div>
    </div>

    <!-- ========== FORMULARIO ========== -->
    <form id="form1" runat="server">
        <div class="container">

            <!-- Card Formulario -->
            <div class="form-card">
                <div class="card-header">
                    <i class="bi bi-person-plus-fill me-2"></i>Ingrese Datos del Personal
                </div>
                <div class="card-body p-3">

                    <!-- Fila 1: C&oacute;digo, Nombre, Apellido Pat., Apellido Mat. -->
                    <div class="row g-2 mb-2">
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
                    <div class="row g-2 mb-2">
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
                    <div class="row g-2 mb-2">
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

            <!-- Tabla de Resultados - asp:Table directa con paginacion manual JS -->
            <div class="table-wrapper">
                <asp:Table ID="TablePersonal" runat="server" CssClass="table table-modern-grid table-hover">
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

                <!-- Paginacion manual -->
                <div class="pagination-wrapper">
                    <ul id="paginationWrapper" class="pagination" style="flex-wrap: wrap;"></ul>
                </div>
            </div>

            <!-- Hidden Fields -->
            <asp:HiddenField ID="__mensaje" runat="server" />
            <asp:HiddenField ID="__pagina" runat="server" />
            <asp:HiddenField ID="ID_PERSONAL" runat="server" Value="0" EnableViewState="False" />
            <asp:HiddenField ID="datosJson" runat="server" EnableViewState="False" />

        </div>
    </form>

    <!-- Scripts -->
    <script type="text/javascript" src="Otros_css_js/resaltar.js"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            initPagination();
        });
    </script>

</body>
</html>
