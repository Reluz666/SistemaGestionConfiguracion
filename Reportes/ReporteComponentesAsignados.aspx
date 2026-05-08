<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ReporteComponentesAsignados.aspx.cs" Inherits="ReporteComponentesAsignados" UnobtrusiveValidationMode="None" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Reporte ComponentesAsignados</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>

    <!-- Bootstrap 5.3 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet" />
    <!-- Global Styles -->
    <link href="../CssJs/global-styles.css" rel="stylesheet" />
    <!-- Local Bootstrap for navbar-custom -->
    <link href="../bootstrap/css/bootstrap.min.css" rel="stylesheet" />

    <style>
        #tblReporte_wrapper {
            border-collapse: separate !important;
            border-spacing: 0;
            width: 100%;
            min-width: 1000px;
        }

        #tblReporte_wrapper thead tr th {
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

        #tblReporte_wrapper tbody tr:hover td {
            background: rgba(233, 69, 96, 0.04) !important;
        }

        #tblReporte_wrapper tbody tr td {
            padding: 0.5rem 0.45rem !important;
            border: none !important;
            border-bottom: 1px solid #f1f1f1 !important;
            vertical-align: middle;
            font-size: 0.8rem;
            color: #2d3436;
        }

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

        .search-input {
            border: 2px solid #e9ecef;
            border-radius: 10px;
            padding: 0.6rem 1rem;
            font-size: 0.95rem;
        }

        .search-input:focus {
            border-color: #e94560;
            box-shadow: 0 0 0 4px rgba(233,69,96,0.1);
            outline: none;
        }

        .page-info {
            text-align: center;
            margin-top: 1rem;
            color: #6c757d;
            font-size: 0.9rem;
        }

        .text-blue { color: #0d6efd; }
        .text-red { color: #dc3545; }
        .fw-bold { font-weight: 700; }

        .detail-row {
            background: #fff3cd !important;
        }

        .detail-row td {
            padding: 1rem !important;
        }

        .btn-detalle {
            padding: 0.25rem 0.5rem;
            font-size: 0.75rem;
        }

        .text-danger { color: #dc3545; }
        .text-primary { color: #0d6efd; }
    </style>

    <script type="text/javascript" src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script type="text/javascript" src="../src/js/utils.js"></script>
    <script type="text/javascript" src="../src/js/grid-utils.js"></script>

    <script lang="javascript" type="text/javascript">
        function abrir_ventana_imprimir_reporte(Opcion) {
            if (Verificar_Datos_tabla(Opcion)) {
                window.name = "Lista de Personal";
                var options = 'channelmode=1,directories=0,fullscreen=0,location=0,menubar=0,resizable=no,titlebar=0,toolbar=0,edge=Raised,status=no,scrollbars=1,width=1000,height=500,top=70px, left=175px';
                window.open('../Reportes/Reporte.aspx', '', options);
            }
        }

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
            var tbody = document.getElementById("tbodyReporte");
            var tabla_longitud = tbody ? tbody.rows.length : 0;

            var Ok, Rpta;
            Ok = true;
            Rpta = confirm(Pregunta);
            if (Rpta == 1) {
                if (tabla_longitud == 0) {
                    Ok = false;
                    alert(Mensaje);
                }
            }
            else {
                Ok = false;
            }
            return Ok;
        }

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

        // Store component details data globally
        var componentesData = {};

        // Toggle detail row visibility
        function toggleDetalle(ciId) {
            var detailRow = document.getElementById('detail_' + ciId);
            var btn = document.getElementById('btn_' + ciId);

            if (detailRow) {
                if (detailRow.style.display === 'none') {
                    detailRow.style.display = 'table-row';
                    btn.innerHTML = '<i class="bi bi-dash"></i>';
                    btn.classList.remove('btn-success');
                    btn.classList.add('btn-warning');
                } else {
                    detailRow.style.display = 'none';
                    btn.innerHTML = '<i class="bi bi-plus"></i>';
                    btn.classList.remove('btn-warning');
                    btn.classList.add('btn-success');
                }
            }
        }

        // Render detail row HTML
        function renderDetalleRow(ciId) {
            var componentes = componentesData[ciId] || [];
            var html = '<tr id="detail_' + ciId + '" class="detail-row" style="display:none;"><td colspan="20"><div class="p-2"><h6 class="text-dark mb-2"><i class="bi bi-box-seam"></i>&nbsp;Componentes del CI</h6>';

            if (componentes.length === 0) {
                html += '<p class="text-muted">No hay componentes para este elemento de configuración.</p>';
            } else {
                html += '<table class="table table-sm table-bordered mb-0" style="max-width: 800px;"><thead><tr>';
                html += '<th>TIPO COMPONENTE</th><th>DESCRIPCION</th><th>FABRICANTE</th><th>NRO SERIE</th><th>MODELO</th><th>MARCA</th>';
                html += '</tr></thead><tbody>';

                for (var i = 0; i < componentes.length; i++) {
                    var comp = componentes[i];
                    html += '<tr>';
                    html += '<td>' + htmlEncode(comp.TIPO_COMPONENTE) + '</td>';
                    html += '<td>' + htmlEncode(comp.DESCRIPCION) + '</td>';
                    html += '<td>' + htmlEncode(comp.FABRICANTE) + '</td>';
                    html += '<td>' + htmlEncode(comp.NRO_SERIE) + '</td>';
                    html += '<td>' + htmlEncode(comp.MODELO) + '</td>';
                    html += '<td>' + htmlEncode(comp.MARCA) + '</td>';
                    html += '</tr>';
                }

                html += '</tbody></table>';
            }

            html += '</div></td></tr>';
            return html;
        }

        // Grid configuration for ReporteComponentesAsignados
        var componentesGridConfig = {
            tableId: 'tblReporte',
            tbodyId: 'tbodyReporte',
            searchInputId: 'txtBuscar',
            paginationWrapperId: 'paginationReporte',
            pageInfoId: 'pageInfoReporte',
            counterId: 'lblContador',
            dataFieldId: 'datosJson',
            dataFieldDetalleId: 'datosJsonComponentes',
            rowsPerPage: 10,
            searchFields: ['NOMBRE_CI', 'NOMBRE_TIPO_CI', 'ESTADO_CI', 'NRO_SERIE', 'FABRICANTE_PROVEEDOR', 'MARCA_MODELO', 'IP', 'GATEWAY', 'GRUPO_TRABAJO', 'PROPIETARIO', 'DESCRIPCION_CI', 'SEDE_LOCAL', 'AREA'],
            columnRenderer: function(item) {
                var estadoClass = item.ESTADO_CI === 'ACTIVO' ? 'text-primary' : 'text-danger';

                var html = '';

                // ID_CI (hidden)
                html += '<td class="d-none">' + htmlEncode(item.ID_CI) + '</td>';

                // NOMBRE_CI
                html += '<td>' + htmlEncode(item.NOMBRE_CI) + '</td>';

                // NOMBRE_TIPO_CI
                html += '<td>' + htmlEncode(item.NOMBRE_TIPO_CI) + '</td>';

                // NRO_SERIE
                html += '<td>' + htmlEncode(item.NRO_SERIE) + '</td>';

                // FABRICANTE_PROVEEDOR
                html += '<td>' + htmlEncode(item.FABRICANTE_PROVEEDOR) + '</td>';

                // MARCA/MODELO
                html += '<td><span class="text-danger">' + htmlEncode(item.MARCA) + '</span> /<br> <span class="text-primary">' + htmlEncode(item.MODELO) + '</span></td>';

                // IP
                html += '<td>' + htmlEncode(item.IP) + '</td>';

                // GATEWAY
                html += '<td>' + htmlEncode(item.GATEWAY) + '</td>';

                // GRUPO_TRABAJO
                html += '<td>' + htmlEncode(item.GRUPO_TRABAJO) + '</td>';

                // ESTADO_CI
                html += '<td class="' + estadoClass + ' fw-bold">' + htmlEncode(item.ESTADO_CI) + '</td>';

                // PROPIETARIO
                html += '<td>' + htmlEncode(item.PROPIETARIO) + '</td>';

                // DESCRIPCION_CI
                html += '<td>' + htmlEncode(item.DESCRIPCION_CI) + '</td>';

                // IMPACTO/PRIORIDAD
                html += '<td><span class="text-primary">' + htmlEncode(item.IMPACTO_CI) + '</span> / <span class="text-danger">' + htmlEncode(item.NIVEL_PRIORIDAD) + '</span></td>';

                // SEDE/LOCAL
                html += '<td><span class="text-primary">' + htmlEncode(item.SEDE) + '</span> /<br> <span class="text-danger">' + htmlEncode(item.LOCAL) + '</span></td>';

                // AREA
                html += '<td>' + htmlEncode(item.AREA) + '</td>';

                // NRO_PISO
                html += '<td>' + htmlEncode(item.NRO_PISO) + '</td>';

                // NRO_AMBIENTE
                html += '<td>' + htmlEncode(item.NRO_AMBIENTE) + '</td>';

                // COMPONENTES button
                html += '<td class="text-center"><button type="button" id="btn_' + htmlEncode(item.ID_CI) + '" class="btn btn-success btn-detalle" onclick="toggleDetalle(\'' + htmlEncode(item.ID_CI) + '\');"><i class="bi bi-plus"></i></button></td>';

                return html;
            },
            afterRowRender: function(tr, item) {
                // Store component data for this CI
                if (item.COMPONENTES && item.COMPONENTES.length > 0) {
                    componentesData[item.ID_CI] = item.COMPONENTES;

                    // Insert detail row after this row
                    var detailHtml = renderDetalleRow(item.ID_CI);
                    var tempDiv = document.createElement('div');
                    tempDiv.innerHTML = '<table><tbody>' + detailHtml + '</tbody></table>';
                    var detailRow = tempDiv.querySelector('tr');

                    // Find position to insert
                    var nextRow = tr.nextSibling;
                    if (nextRow && nextRow.id && nextRow.id.indexOf('detail_') === 0) {
                        // Already exists, skip
                    } else {
                        tr.parentNode.insertBefore(detailRow, nextRow);
                    }
                }
            }
        };

        function initGrid() {
            GridUtils.createGrid(componentesGridConfig);
        }
    </script>
</head>
<body onload="MostrarMensaje()">
    <nav class="navbar navbar-custom navbar-fixed-top" role="navigation">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse"
                data-target=".navbar-ex1-collapse">
                <span class="sr-only">Desplegar navegación</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="../menu.aspx"><span class="glyphicon glyphicon-home"></span>&nbsp;Inicio</a>
        </div>

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
                            <a href="#">Tablas Elemento Configuracion</a>
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
                        <li><a href="../Reportes/ReporteDatosIncorrectosCI.aspx" runat="server" id="A22">Reporte de Datos Incorrectos de Elementos de Configuraci&oacute;n</a></li>
                        <li><a href="../Reportes/ReporteCIsInformacionContenidaEnCMDB.aspx" runat="server" id="A23">Reporte de Informaci&oacute;n de Elementos de Configuraci&oacute;n Contenidas en la CMDB</a></li>
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
        <div class="container">
            <!-- Report Card -->
            <div class="form-card">
                <div class="card-header">
                    <i class="bi bi-box-seam me-2"></i>Reporte de Componentes Asignados
                </div>
                <div class="card-body p-3">
                    <!-- Search Bar -->
                    <div class="row mb-3">
                        <div class="col-md-8">
                            <div class="input-group">
                                <span class="input-group-text bg-white border-end-0">
                                    <i class="bi bi-search text-muted"></i>
                                </span>
                                <input type="text" id="txtBuscar" class="form-control border-start-0 search-input" ClientIDMode="Static"
                                       placeholder="Buscar por nombre, tipo, estado, serie, marca..." />
                                <button class="btn btn-outline-secondary" type="button" onclick="document.getElementById('txtBuscar').value=''; GridUtils.refresh('tblReporte');">
                                    <i class="bi bi-x-lg"></i>
                                </button>
                            </div>
                        </div>
                        <div class="col-md-4 text-end">
                            <span id="lblContador" class="form-text text-muted"></span>
                        </div>
                    </div>

                    <!-- Table -->
                    <div class="table-wrapper" style="max-height: 500px; overflow-y: auto;">
                        <table id="tblReporte" class="table table-modern table-hover" style="min-width: 1000px;">
                            <thead>
                                <tr>
                                    <th class="d-none">ID CI</th>
                                    <th>NOMBRE CI</th>
                                    <th>TIPO CI</th>
                                    <th>NRO SERIE</th>
                                    <th>FABRICANTE/PROVEEDOR</th>
                                    <th>MARCA/MODELO</th>
                                    <th>IP</th>
                                    <th>GATEWAY</th>
                                    <th>GRUPO TRABAJO</th>
                                    <th>ESTADO CI</th>
                                    <th>PROPIETARIO</th>
                                    <th>DESCRIPCION CI</th>
                                    <th>IMPACTO/ PRIORIDAD</th>
                                    <th>SEDE/LOCAL</th>
                                    <th>AREA</th>
                                    <th>NRO PISO</th>
                                    <th>NRO AMBIENTE</th>
                                    <th>COMPONENTES</th>
                                </tr>
                            </thead>
                            <tbody id="tbodyReporte">
                            </tbody>
                        </table>
                    </div>

                    <!-- Pagination -->
                    <div class="pagination-wrapper">
                        <ul id="paginationReporte" class="pagination" style="flex-wrap: wrap;"></ul>
                    </div>
                    <div class="page-info" id="pageInfoReporte"></div>

                    <!-- Print Button -->
                    <div class="row mt-3">
                        <div class="col-md-12 text-end">
                            <asp:LinkButton ID="IMPRIMIR" runat="server" CausesValidation="False" class="btn btn-info" OnClick="IMPRIMIR_Click" OnClientClick="abrir_ventana_imprimir_reporte(2);">
                                <i class="bi bi-printer"></i>&nbsp;Imprimir reporte
                            </asp:LinkButton>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Hidden Fields -->
            <asp:HiddenField ID="__pagina" runat="server" />
            <asp:HiddenField ID="__mensaje" runat="server" />
            <asp:HiddenField ID="datosJson" runat="server" EnableViewState="False" ClientIDMode="Static" />
            <asp:HiddenField ID="datosJsonComponentes" runat="server" EnableViewState="False" ClientIDMode="Static" />
        </div>
    </form>

    <script type="text/javascript" src="Otros_css_js/resaltar.js"></script>

    <script type="text/javascript">
        if (window.addEventListener) {
            window.addEventListener('load', function() {
                initGrid();
            }, false);
        } else if (window.attachEvent) {
            window.attachEvent('onload', function() {
                initGrid();
            });
        }
    </script>
</body>
</html>
