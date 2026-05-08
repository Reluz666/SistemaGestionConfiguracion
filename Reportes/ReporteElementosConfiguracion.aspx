<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ReporteElementosConfiguracion.aspx.cs" Inherits="ElementosConfiguracion" UnobtrusiveValidationMode="None" %>

<%@ Register src="../NavBar.ascx" tagname="NavBar" tagprefix="uc1" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>Elementos de Configuracion</title>

    <!-- Bootstrap 5.3 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet" />
    <!-- Global Styles -->
    <link href="CssJs/global-styles.css" rel="stylesheet" />

    <style>
        /* ===== FORMULARIO ===== */
        .form-card {
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 4px 25px rgba(0, 0, 0, 0.08);
            padding: 2rem;
            margin-bottom: 2rem;
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

        #tblElementosConfiguracion {
            border-collapse: separate !important;
            border-spacing: 0;
            width: 100%;
            min-width: 1800px;
        }

        #tblElementosConfiguracion thead tr th {
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

        #tblElementosConfiguracion thead tr th:first-child {
            border-radius: 10px 0 0 10px;
        }

        #tblElementosConfiguracion thead tr th:last-child {
            border-radius: 0 10px 10px 0;
        }

        #tblElementosConfiguracion tbody tr td {
            padding: 0.5rem 0.45rem !important;
            border: none;
            border-bottom: 1px solid #f1f1f1;
            vertical-align: middle;
            font-size: 0.8rem;
            color: #2d3436;
            background: #fff;
        }

        #tblElementosConfiguracion tbody tr:hover td {
            background: rgba(233, 69, 96, 0.04);
        }

        #tblElementosConfiguracion tbody tr:last-child td {
            border-bottom: none;
        }

        /* ===== COLOR CLASSES ===== */
        .text-primary { color: #0d6efd; }
        .text-danger { color: #dc3545; }
        .text-success { color: #198754; }
        .estado-activo { color: #0d6efd; font-weight: 600; }
        .estado-inactivo { color: #dc3545; font-weight: 600; }

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

        /* ===== SEARCH ===== */
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

    <script type="text/javascript" src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script type="text/javascript" src="src/js/utils.js"></script>
    <script type="text/javascript" src="src/js/grid-utils.js"></script>

    <script lang="javascript" type="text/javascript">
        // Grid configuration for Elementos de Configuracion
        var elementosGridConfig = {
            tableId: 'tblElementosConfiguracion',
            tbodyId: 'tbodyElementosConfiguracion',
            searchInputId: 'txtBuscarElementos',
            paginationWrapperId: 'paginationElementos',
            pageInfoId: 'pageInfoElementos',
            counterId: 'lblContadorElementos',
            dataFieldId: 'datosJson',
            rowsPerPage: 10,
            searchFields: ['NOMBRE CI', 'NOMBRE TIPO CI', 'NRO SERIE', 'FABRICANTE / PROVEEDOR', 'MARCA', 'MODELO', 'IP', 'GATEWAY', 'GRUPO TRABAJO', 'ESTADO CI', 'PROPIETARIO', 'DESCRIPCION CI', 'IMPACTO CI', 'NIVEL PRIORIDAD', 'SEDE', 'LOCAL', 'UBICACION LOCAL', 'DIRECCION LOCAL', 'AREA', 'NRO PISO', 'NRO AMBIENTE', 'FEC. CREACION CI', 'RESPONSABLE'],
            columnRenderer: function(item) {
                var estadoClass = item['ESTADO CI'] === 'ACTIVO' ? 'estado-activo' : 'estado-inactivo';
                return '<td>' + htmlEncode(item['NOMBRE CI']) + '</td>' +
                    '<td>' + htmlEncode(item['NOMBRE TIPO CI']) + '</td>' +
                    '<td>' + htmlEncode(item['NRO SERIE']) + '</td>' +
                    '<td>' + htmlEncode(item['FABRICANTE / PROVEEDOR']) + '</td>' +
                    '<td><span class="text-primary fw-bold">' + htmlEncode(item['MARCA']) + '</span> / <span class="text-danger fw-bold">' + htmlEncode(item['MODELO']) + '</span></td>' +
                    '<td>' + htmlEncode(item['IP']) + '</td>' +
                    '<td>' + htmlEncode(item['GATEWAY']) + '</td>' +
                    '<td>' + htmlEncode(item['GRUPO TRABAJO']) + '</td>' +
                    '<td class="' + estadoClass + '">' + htmlEncode(item['ESTADO CI']) + '</td>' +
                    '<td>' + htmlEncode(item['PROPIETARIO']) + '</td>' +
                    '<td>' + htmlEncode(item['DESCRIPCION CI']) + '</td>' +
                    '<td>' + htmlEncode(item['IMPACTO CI']) + '<b>  /  </b>' + htmlEncode(item['NIVEL PRIORIDAD']) + '</td>' +
                    '<td><span class="text-primary fw-bold">' + htmlEncode(item['SEDE']) + '</span><br /><span class="text-danger fw-bold">' + htmlEncode(item['LOCAL']) + '</span></td>' +
                    '<td>' + htmlEncode(item['AREA']) + '</td>' +
                    '<td><span class="text-primary fw-bold">' + htmlEncode(item['NRO PISO']) + '</span> / <span class="text-danger fw-bold">' + htmlEncode(item['NRO AMBIENTE']) + '</span></td>' +
                    '<td>' + htmlEncode(item['FEC. CREACION CI']) + '</td>' +
                    '<td>' + htmlEncode(item['RESPONSABLE']) + '</td>';
            }
        };

        function initElementosGrid() {
            GridUtils.createGrid(elementosGridConfig);
        }

        function abrir_ventana_imprimir_reporte(Opcion) {
            var state = GridUtils.getState('tblElementosConfiguracion');
            var totalRows = state ? state.filteredData.length : 0;
            if (totalRows === 0) {
                alert('No hay datos para imprimir el reporte.');
                return false;
            }
            window.name = "Elementos de Configuracion";
            var options = 'channelmode=1,directories=0,fullscreen=0,location=0,menubar=0,resizable=no,titlebar=0,toolbar=0,edge=Raised,status=no,scrollbars=1,width=1000,height=500,top=70px, left=175px';
            window.open('../Reportes/Reporte.aspx', '', options);
            return true;
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

            <!-- Form Card with Search -->
            <div class="form-card">
                <div class="card-header">
                    <i class="bi bi-folder-fill me-2"></i>Reporte de Elementos de Configuracion
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
                                       placeholder="Buscar por Nombre CI, Tipo, Serie, Marca, Modelo, IP, Sede, Local, Area, Responsable..."
                                       onkeyup="" />
                                <button class="btn btn-outline-secondary" type="button" onclick="document.getElementById('txtBuscarElementos').value=''; GridUtils.refresh('tblElementosConfiguracion');">
                                    <i class="bi bi-x-lg"></i>
                                </button>
                            </div>
                        </div>
                        <div class="col-md-4 text-end">
                            <span id="lblContadorElementos" class="form-text text-muted"></span>
                            <asp:HyperLink ID="IMPRIMIR" runat="server" BorderStyle="None" class="btn btn-info btn-modern ms-2" NavigateUrl="" onClick="return abrir_ventana_imprimir_reporte(2);">Imprimir reporte</asp:HyperLink>
                        </div>
                    </div>

                    <!-- Tabla HTML -->
                    <div class="table-wrapper" style="max-height: 500px; overflow-y: auto;">
                        <table id="tblElementosConfiguracion" class="table table-modern table-hover" style="min-width: 1800px;">
                            <thead>
                                <tr>
                                    <th style="width: 120px;">NOMBRE CI</th>
                                    <th style="width: 100px;">TIPO CI</th>
                                    <th style="width: 100px;">NRO SERIE</th>
                                    <th style="width: 130px;">FABRICANTE /<br />PROVEEDOR</th>
                                    <th style="width: 100px;">MARCA /<br />MODELO</th>
                                    <th style="width: 100px;">IP</th>
                                    <th style="width: 100px;">GATEWAY</th>
                                    <th style="width: 100px;">GRUPO<br />TRABAJO</th>
                                    <th style="width: 80px;">ESTADO CI</th>
                                    <th style="width: 100px;">PROPIETARIO CI</th>
                                    <th style="width: 120px;">DESCRIPCION CI</th>
                                    <th style="width: 100px;">IMPACTO /<br />PRIORIDAD</th>
                                    <th style="width: 100px;">SEDE /<br />LOCAL</th>
                                    <th style="width: 100px;">AREA</th>
                                    <th style="width: 100px;">NRO PISO /<br />AMBIENTE</th>
                                    <th style="width: 100px;">FEC. CREACION</th>
                                    <th style="width: 120px;">RESPONSABLE<br />REGISTRO CI</th>
                                </tr>
                            </thead>
                            <tbody id="tbodyElementosConfiguracion">
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

            <!-- Hidden Fields -->
            <asp:HiddenField ID="__pagina" runat="server" />
            <asp:HiddenField ID="__mensaje" runat="server" />
            <asp:HiddenField ID="datosJson" runat="server" EnableViewState="False" ClientIDMode="Static" />
        </div>
    </form>

    <!-- Scripts -->
    <script type="text/javascript" src="Otros_css_js/resaltar.js"></script>

    <script type="text/javascript">
        if (window.addEventListener) {
            window.addEventListener('load', function() {
                initElementosGrid();
            }, false);
        } else if (window.attachEvent) {
            window.attachEvent('onload', function() {
                initElementosGrid();
            });
        }
    </script>

</body>
</html>
