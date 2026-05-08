<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ReporteCIsInformacionContenidaEnCMDB.aspx.cs" Inherits="ElementosConfiguracion" UnobtrusiveValidationMode="None" %>

<%@ Register src="../NavBar.ascx" tagname="NavBar" tagprefix="uc1" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>Reporte de Informacion Contenida en la CMDB</title>

    <!-- Bootstrap 5.3 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet" />
    <!-- Global Styles -->
    <link href="../CssJs/global-styles.css" rel="stylesheet" />

    <style>
        /* ===== FORMULARIO ===== */
        .form-card {
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 4px 25px rgba(0, 0, 0, 0.08);
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            border: 1px solid rgba(0, 0, 0, 0.05);
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

        .page-info {
            text-align: center;
            margin-top: 1rem;
            color: #6c757d;
            font-size: 0.9rem;
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


        /* ===== RESPONSIVE ===== */
        @media (max-width: 991px) {
            .form-card { padding: 1.5rem; }
            .table-wrapper { padding: 1rem; }
        }

        @media (max-width: 576px) {
            .btn-modern { width: 100%; margin-bottom: 0.5rem; }
        }
    </style>

    <script type="text/javascript" src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script type="text/javascript" src="../src/js/utils.js"></script>
    <script type="text/javascript" src="../src/js/grid-utils.js"></script>

    <script lang="javascript" type="text/javascript">
        // Grid configuration for Elementos table
        var elementosGridConfig = {
            tableId: 'tblElementos',
            tbodyId: 'tbodyElementos',
            searchInputId: 'txtBuscarElementos',
            paginationWrapperId: 'paginationElementos',
            pageInfoId: 'pageInfoElementos',
            counterId: 'lblContadorElementos',
            dataFieldId: 'datosJsonElementos',
            rowsPerPage: 10,
            searchFields: ['NOMBRE CI', 'NOMBRE TIPO CI', 'AREA', 'ESTADO CI'],
            columnRenderer: function(item) {
                var estadoColor = item['ESTADO CI'] === 'ACTIVO' ? 'color: blue;' : 'color: red;';
                return '<td style="display:none;">' + htmlEncode(item['ID CI']) + '</td>' +
                    '<td>' + htmlEncode(item['NOMBRE CI']) + '</td>' +
                    '<td>' + htmlEncode(item['NOMBRE TIPO CI']) + '</td>' +
                    '<td>' + htmlEncode(item['NRO SERIE']) + '</td>' +
                    '<td>' + htmlEncode(item['FABRICANTE / PROVEEDOR']) + '</td>' +
                    '<td><font color="blue"><b>' + htmlEncode(item['MARCA']) + '</b></font> / <font color="red"><b>' + htmlEncode(item['MODELO']) + '</b></font></td>' +
                    '<td>' + htmlEncode(item['IP']) + '</td>' +
                    '<td>' + htmlEncode(item['GATEWAY']) + '</td>' +
                    '<td>' + htmlEncode(item['GRUPO TRABAJO']) + '</td>' +
                    '<td style="' + estadoColor + '">' + htmlEncode(item['ESTADO CI']) + '</td>' +
                    '<td>' + htmlEncode(item['PROPIETARIO']) + '</td>' +
                    '<td>' + htmlEncode(item['DESCRIPCION CI']) + '</td>' +
                    '<td>' + htmlEncode(item['IMPACTO CI']) + ' <b> / </b> ' + htmlEncode(item['NIVEL PRIORIDAD']) + '</td>' +
                    '<td><FONT COLOR="BLUE"><B>' + htmlEncode(item['SEDE']) + '</B></FONT> / <FONT COLOR="RED"><B>' + htmlEncode(item['LOCAL']) + '</B></FONT></td>' +
                    '<td style="display:none;">' + htmlEncode(item['UBICACION LOCAL']) + '</td>' +
                    '<td style="display:none;">' + htmlEncode(item['DIRECCION LOCAL']) + '</td>' +
                    '<td>' + htmlEncode(item['AREA']) + '</td>' +
                    '<td><FONT COLOR="BLUE"><B>' + htmlEncode(item['NRO PISO']) + '</B></FONT> / <FONT COLOR="RED"><B>' + htmlEncode(item['NRO AMBIENTE']) + '</B></FONT></td>' +
                    '<td>' + htmlEncode(item['FEC. CREACION CI']) + '</td>' +
                    '<td>' + htmlEncode(item['RESPONSABLE']) + '</td>';
            }
        };

        // Grid configuration for Licencias table
        var licenciasGridConfig = {
            tableId: 'tblLicencias',
            tbodyId: 'tbodyLicencias',
            searchInputId: 'txtBuscarLicencias',
            paginationWrapperId: 'paginationLicencias',
            pageInfoId: 'pageInfoLicencias',
            counterId: 'lblContadorLicencias',
            dataFieldId: 'datosJsonLicencias',
            rowsPerPage: 10,
            searchFields: ['AREA', 'LICENCIA', 'NOMBRE', 'VERSION'],
            columnRenderer: function(item) {
                return '<td>' + htmlEncode(item['AREA']) + '</td>' +
                    '<td>' + htmlEncode(item['LICENCIA']) + '</td>' +
                    '<td>' + htmlEncode(item['NOMBRE']) + '</td>' +
                    '<td>' + htmlEncode(item['VERSION']) + '</td>' +
                    '<td>' + htmlEncode(item['SUSCRIPCION']) + '</td>' +
                    '<td>' + htmlEncode(item['FEC. INI.']) + '</td>' +
                    '<td>' + htmlEncode(item['FEC. FIN']) + '</td>' +
                    '<td>' + htmlEncode(item['PERPETUA']) + '</td>' +
                    '<td>' + htmlEncode(item['DESCRIPCION']) + '</td>' +
                    '<td>' + htmlEncode(item['VENCE LICENCIA']) + '</td>';
            }
        };

        function initElementosGrid() {
            GridUtils.createGrid(elementosGridConfig);
        }

        function initLicenciasGrid() {
            GridUtils.createGrid(licenciasGridConfig);
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
    </script>
</head>
<body onload="MostrarMensaje()">
    <uc1:NavBar ID="NavBar1" runat="server" />

    <form id="form1" runat="server">
        <div class="container">
            <!-- Filtros de Busqueda -->
            <div class="form-card">
                <div class="card-header">
                    <i class="bi bi-funnel me-2"></i>Filtros de Busqueda
                </div>
                <div class="card-body p-3">
                    <div class="row g-3">
                        <div class="col-md-4">
                            <div class="form-check">
                                <asp:CheckBox ID="cbs" runat="server" CssClass="form-check-input" Text="Sede" AutoPostBack="True" OnCheckedChanged="cbs_CheckedChanged"/>
                            </div>
                            <asp:DropDownList ID="ddls" runat="server" CssClass="form-control form-control-modern mt-1" AppendDataBoundItems="True" Enabled="False" OnSelectedIndexChanged="ddls_SelectedIndexChanged" AutoPostBack="True">
                                <asp:ListItem Value="-1">Seleccione una opción</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="col-md-4">
                            <div class="form-check">
                                <asp:CheckBox ID="cbl" runat="server" CssClass="form-check-input" Text="Local" AutoPostBack="True" OnCheckedChanged="cbl_CheckedChanged"/>
                            </div>
                            <asp:DropDownList ID="ddll" runat="server" CssClass="form-control form-control-modern mt-1" AppendDataBoundItems="True" AutoPostBack="True" Enabled="False" OnSelectedIndexChanged="ddll_SelectedIndexChanged">
                                <asp:ListItem Value="-1">Seleccione una opción</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="col-md-4">
                            <div class="form-check">
                                <asp:CheckBox ID="cba" runat="server" CssClass="form-check-input" Text="Area" AutoPostBack="True" OnCheckedChanged="cba_CheckedChanged"/>
                            </div>
                            <asp:DropDownList ID="ddla" runat="server" CssClass="form-control form-control-modern mt-1" AppendDataBoundItems="True" Enabled="False">
                                <asp:ListItem Value="-1">Seleccione una opción</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div class="row mt-3">
                        <div class="col-md-12 d-flex flex-wrap gap-2">
                            <asp:LinkButton ID="lbtnBuscar" runat="server" CausesValidation="False" CssClass="btn btn-info btn-modern" OnClick="lbtnBuscar_Click" Text="Buscar" UseSubmitBehavior="False" />
                            <asp:Button ID="btnActualizarInformacion" runat="server" CssClass="btn btn-success btn-modern" OnClick="btnActualizarInformacion_Click" Text="Mostrar Todos los CIs" />
                        </div>
                    </div>
                </div>
            </div>

            <!-- Tabla de Elementos de Configuracion -->
            <div class="form-card">
                <div class="card-header">
                    <i class="bi bi-box-seam me-2"></i>Lista de Elementos de Configuracion
                </div>
                <div class="card-body p-3">
                    <!-- Buscador -->
                    <div class="row mb-3">
                        <div class="col-md-8">
                            <div class="input-group">
                                <span class="input-group-text bg-white border-end-0">
                                    <i class="bi bi-search text-muted"></i>
                                </span>
                                <input type="text" id="txtBuscarElementos" class="form-control border-start-0 search-input" ClientIDMode="Static"
                                       placeholder="Buscar por Nombre, Tipo CI, Area, Estado..."
                                       onkeyup="filtrarTablaElementos()" />
                                <button class="btn btn-outline-secondary" type="button" onclick="document.getElementById('txtBuscarElementos').value=''; filtrarTablaElementos();">
                                    <i class="bi bi-x-lg"></i>
                                </button>
                            </div>
                        </div>
                        <div class="col-md-4 text-end">
                            <span id="lblContadorElementos" class="form-text text-muted"></span>
                        </div>
                    </div>

                    <!-- Tabla HTML -->
                    <div class="table-wrapper" style="max-height: 500px; overflow-y: auto;">
                        <table id="tblElementos" class="table table-modern table-hover" style="min-width: 1200px;">
                            <thead>
                                <tr>
                                    <th style="display:none;">ID CI</th>
                                    <th>NOMBRE CI</th>
                                    <th>TIPO CI</th>
                                    <th>NRO SERIE</th>
                                    <th>FABRICANTE / PROVEEDOR</th>
                                    <th>MARCA / MODELO</th>
                                    <th>IP</th>
                                    <th>GATEWAY</th>
                                    <th>GRUPO TRABAJO</th>
                                    <th>ESTADO CI</th>
                                    <th>PROPIETARIO CI</th>
                                    <th>DESCRIPCION CI</th>
                                    <th>IMPACTO / PRIORIDAD</th>
                                    <th>SEDE / LOCAL</th>
                                    <th style="display:none;">UBICACION LOCAL</th>
                                    <th style="display:none;">DIRECCION LOCAL</th>
                                    <th>AREA</th>
                                    <th>NRO PISO / AMBIENTE</th>
                                    <th>FEC. CREACION</th>
                                    <th>RESPONSABLE</th>
                                </tr>
                            </thead>
                            <tbody id="tbodyElementos">
                            </tbody>
                        </table>
                    </div>

                    <!-- Paginacion -->
                    <div class="pagination-wrapper">
                        <ul id="paginationElementos" class="pagination" style="flex-wrap: wrap;"></ul>
                    </div>
                    <div class="page-info" id="pageInfoElementos"></div>
                </div>
            </div>

            <!-- Tabla de Licencias -->
            <div class="form-card">
                <div class="card-header">
                    <i class="bi bi-key me-2"></i>Lista de Licencias
                </div>
                <div class="card-body p-3">
                    <!-- Buscador -->
                    <div class="row mb-3">
                        <div class="col-md-8">
                            <div class="input-group">
                                <span class="input-group-text bg-white border-end-0">
                                    <i class="bi bi-search text-muted"></i>
                                </span>
                                <input type="text" id="txtBuscarLicencias" class="form-control border-start-0 search-input" ClientIDMode="Static"
                                       placeholder="Buscar por Area, Licencia, Nombre, Version..."
                                       onkeyup="filtrarTablaLicencias()" />
                                <button class="btn btn-outline-secondary" type="button" onclick="document.getElementById('txtBuscarLicencias').value=''; filtrarTablaLicencias();">
                                    <i class="bi bi-x-lg"></i>
                                </button>
                            </div>
                        </div>
                        <div class="col-md-4 text-end">
                            <span id="lblContadorLicencias" class="form-text text-muted"></span>
                        </div>
                    </div>

                    <!-- Tabla HTML -->
                    <div class="table-wrapper" style="max-height: 500px; overflow-y: auto;">
                        <table id="tblLicencias" class="table table-modern table-hover" style="min-width: 900px;">
                            <thead>
                                <tr>
                                    <th>AREA</th>
                                    <th>LICENCIA</th>
                                    <th>NOMBRE</th>
                                    <th>VERSION</th>
                                    <th>SUSCRIPCION</th>
                                    <th>FEC. INI.</th>
                                    <th>FEC. FIN</th>
                                    <th>PERPETUA</th>
                                    <th>DESCRIPCION</th>
                                    <th>VENCE LICENCIA</th>
                                </tr>
                            </thead>
                            <tbody id="tbodyLicencias">
                            </tbody>
                        </table>
                    </div>

                    <!-- Paginacion -->
                    <div class="pagination-wrapper">
                        <ul id="paginationLicencias" class="pagination" style="flex-wrap: wrap;"></ul>
                    </div>
                    <div class="page-info" id="pageInfoLicencias"></div>
                </div>
            </div>

            <!-- Estadisticas -->
            <div class="form-card">
                <div class="card-body p-3">
                    <asp:Label ID="Label1" runat="server" Text="Cantidad total de CIs:" style="font-weight: 700; display: block; margin-bottom: 0.5rem;"></asp:Label>
                    <asp:Label ID="Label2" runat="server" Text="Cantidad de CIs contenidas en la CMDB:" style="font-weight: 700; display: block; margin-bottom: 0.5rem;"></asp:Label>
                    <asp:Label ID="Label3" runat="server" Text="% de CIs cuya informacion estan contenidas en la CMDB" style="font-weight: 700; display: block;"></asp:Label>
                </div>
            </div>

            <!-- Hidden Fields -->
            <asp:HiddenField ID="__pagina" runat="server" />
            <asp:HiddenField ID="__mensaje" runat="server" />
            <asp:HiddenField ID="datosJsonElementos" runat="server" EnableViewState="False" ClientIDMode="Static" />
            <asp:HiddenField ID="datosJsonLicencias" runat="server" EnableViewState="False" ClientIDMode="Static" />
        </div>
    </form>

    <script type="text/javascript" src="Otros_css_js/resaltar.js"></script>

    <script type="text/javascript">
        // Wrapper functions for GridUtils (called by inline handlers)
        function filtrarTablaElementos() {
            var state = GridUtils.getState('tblElementos');
            if (state) {
                var searchInput = document.getElementById(state.config.searchInputId);
                var searchText = searchInput ? searchInput.value.toLowerCase().trim() : '';

                if (searchText === '') {
                    state.filteredData = state.data.slice();
                } else {
                    state.filteredData = state.data.filter(function(item) {
                        return state.config.searchFields.some(function(field) {
                            var value = item[field] || '';
                            return value.toLowerCase().includes(searchText);
                        });
                    });
                }

                state.currentPage = 1;
                renderizarTabla(state.config.tableId);
                generarPaginacion(state.config.tableId, Math.ceil(state.filteredData.length / state.rowsPerPage));

                if (state.config.counterId) {
                    var counter = document.getElementById(state.config.counterId);
                    if (counter) {
                        counter.textContent = 'Total: ' + state.filteredData.length + ' elementos';
                    }
                }
            }
        }

        function filtrarTablaLicencias() {
            var state = GridUtils.getState('tblLicencias');
            if (state) {
                var searchInput = document.getElementById(state.config.searchInputId);
                var searchText = searchInput ? searchInput.value.toLowerCase().trim() : '';

                if (searchText === '') {
                    state.filteredData = state.data.slice();
                } else {
                    state.filteredData = state.data.filter(function(item) {
                        return state.config.searchFields.some(function(field) {
                            var value = item[field] || '';
                            return value.toLowerCase().includes(searchText);
                        });
                    });
                }

                state.currentPage = 1;
                renderizarTabla(state.config.tableId);
                generarPaginacion(state.config.tableId, Math.ceil(state.filteredData.length / state.rowsPerPage));

                if (state.config.counterId) {
                    var counter = document.getElementById(state.config.counterId);
                    if (counter) {
                        counter.textContent = 'Total: ' + state.filteredData.length + ' licencias';
                    }
                }
            }
        }

        function renderizarTabla(gridId) {
            var state = GridUtils.getState(gridId);
            if (!state) return;

            var tbody = document.getElementById(state.config.tbodyId);
            if (!tbody) return;

            var totalRows = state.filteredData.length;
            var totalPages = Math.ceil(totalRows / state.rowsPerPage);
            var start = (state.currentPage - 1) * state.rowsPerPage;
            var end = start + state.rowsPerPage;

            tbody.innerHTML = '';

            if (totalRows === 0) {
                var tr = document.createElement('tr');
                var cellCount = document.querySelectorAll('#' + state.config.tableId + ' thead th').length || 1;
                tr.innerHTML = '<td colspan="' + cellCount + '" class="text-center text-muted py-4">No hay datos disponibles</td>';
                tbody.appendChild(tr);
                var pageInfo = document.getElementById(state.config.pageInfoId);
                if (pageInfo) pageInfo.textContent = '';
                return;
            }

            for (var i = start; i < end && i < totalRows; i++) {
                var item = state.filteredData[i];
                var tr = document.createElement('tr');
                tr.innerHTML = state.config.columnRenderer(item);
                tbody.appendChild(tr);
            }

            var pageInfo = document.getElementById(state.config.pageInfoId);
            if (pageInfo) {
                pageInfo.textContent = 'Pagina ' + state.currentPage + ' de ' + totalPages + ' (Total: ' + totalRows + ' registros)';
            }
        }

        function generarPaginacion(gridId, totalPages) {
            var state = GridUtils.getState(gridId);
            if (!state) return;

            var wrapper = document.getElementById(state.config.paginationWrapperId);
            if (!wrapper) return;

            wrapper.innerHTML = '';

            if (totalPages <= 1) {
                return;
            }

            var sb = '<nav><ul class="pagination mb-0">';

            if (state.currentPage > 1) {
                sb += '<li class="page-item"><a class="page-link" href="javascript:GridUtils.paginate(\'' + gridId + '\', ' + (state.currentPage - 1) + ')">Anterior</a></li>';
            } else {
                sb += '<li class="page-item disabled"><span class="page-link">Anterior</span></li>';
            }

            var inicio = Math.max(1, state.currentPage - 2);
            var fin = Math.min(totalPages, state.currentPage + 2);

            if (inicio > 1) {
                sb += '<li class="page-item"><a class="page-link" href="javascript:GridUtils.paginate(\'' + gridId + '\', 1)">1</a></li>';
                if (inicio > 2) sb += '<li class="page-item disabled"><span class="page-link">...</span></li>';
            }

            for (var i = inicio; i <= fin; i++) {
                if (i === state.currentPage) {
                    sb += '<li class="page-item active"><span class="page-link">' + i + '</span></li>';
                } else {
                    sb += '<li class="page-item"><a class="page-link" href="javascript:GridUtils.paginate(\'' + gridId + '\', ' + i + ')">' + i + '</a></li>';
                }
            }

            if (fin < totalPages) {
                if (fin < totalPages - 1) sb += '<li class="page-item disabled"><span class="page-link">...</span></li>';
                sb += '<li class="page-item"><a class="page-link" href="javascript:GridUtils.paginate(\'' + gridId + '\', ' + totalPages + ')">' + totalPages + '</a></li>';
            }

            if (state.currentPage < totalPages) {
                sb += '<li class="page-item"><a class="page-link" href="javascript:GridUtils.paginate(\'' + gridId + '\', ' + (state.currentPage + 1) + ')">Siguiente</a></li>';
            } else {
                sb += '<li class="page-item disabled"><span class="page-link">Siguiente</span></li>';
            }

            sb += '</ul></nav>';
            wrapper.innerHTML = sb;
        }

        if (window.addEventListener) {
            window.addEventListener('load', function() {
                initElementosGrid();
                initLicenciasGrid();
            }, false);
        } else if (window.attachEvent) {
            window.attachEvent('onload', function() {
                initElementosGrid();
                initLicenciasGrid();
            });
        }
    </script>
</body>
</html>
