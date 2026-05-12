<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Personal.aspx.cs" Inherits="Personal" UnobtrusiveValidationMode="None" %>
<%@ Register src="NavBar.ascx" tagname="NavBar" tagprefix="uc1" %>

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

        .estado-activo { color: #198754; font-weight: 600; }
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
        .table-modern thead th {
            background: linear-gradient(135deg, #1a1a2e 0%, #16213e 100%);
            color: #fff;
            font-weight: 600;
            font-size: 0.8rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            padding: 0.75rem 0.5rem !important;
            border: none !important;
            white-space: nowrap;
        }

        .table-modern tbody td {
            padding: 0.6rem 0.5rem !important;
            border-bottom: 1px solid #f1f1f1;
            vertical-align: middle;
            font-size: 0.85rem;
            color: #2d3436;
        }

        .table-modern tbody tr:hover td {
            background: rgba(233,69,96,0.04);
        }

        .table-modern tbody tr:last-child td {
            border-bottom: none;
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

        .btn-accion {
            padding: 0.25rem 0.5rem;
            font-size: 0.75rem;
            border-radius: 6px;
            text-decoration: none;
        }

        .page-info {
            text-align: center;
            margin-top: 1rem;
            color: #6c757d;
            font-size: 0.9rem;
        }
    </style>

    <script type="text/javascript" src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <script type="text/javascript" src="src/js/utils.js"></script>
    <script type="text/javascript" src="src/js/grid-utils.js"></script>

    <script lang="javascript" type="text/javascript">
        // ===== VARIABLES GLOBALES PARA LISTA DE PERSONAL =====
        var listaCurrentPage = 1;
        var listaRowsPerPage = 10;

        // Grid configuration for Personal list
        var personalGridConfig = {
            tableId: 'tblListaPersonal',
            tbodyId: 'tbodyListaPersonal',
            searchInputId: 'txtBuscarPersonal',
            paginationWrapperId: 'paginationListaPersonal',
            pageInfoId: 'pageInfoPersonal',
            counterId: 'lblContadorPersonal',
            dataFieldId: 'datosJson',
            rowsPerPage: 10,
            searchFields: ['CODIGO', 'NOMBRE', 'APELLIDO_PATERNO', 'APELLIDO_MATERNO', 'NRO_DOC_IDENT', 'AREA', 'DEPENDENCIA', 'CARGO', 'SEDE', 'LOCAL'],
            columnRenderer: function(item) {
                var estadoClass = item.ESTADO === 'ACTIVO' ? 'estado-activo' : 'estado-inactivo';
                return '<td>' + htmlEncode(item.CODIGO) + '</td>' +
                    '<td>' + htmlEncode(item.NOMBRE) + ' ' + htmlEncode(item.APELLIDO_PATERNO) + ' ' + htmlEncode(item.APELLIDO_MATERNO) + '</td>' +
                    '<td>' + htmlEncode(item.TIPO_DOC_IDENT) + '</td>' +
                    '<td>' + htmlEncode(item.NRO_DOC_IDENT) + '</td>' +
                    '<td>' + htmlEncode(item.PROFESION) + '</td>' +
                    '<td>' + htmlEncode(item.TELEFONO) + '</td>' +
                    '<td>' + htmlEncode(item.EMAIL) + '</td>' +
                    '<td>' + htmlEncode(item.SEDE) + '</td>' +
                    '<td>' + htmlEncode(item.LOCAL) + '</td>' +
                    '<td>' + htmlEncode(item.AREA) + '</td>' +
                    '<td>' + htmlEncode(item.DEPENDENCIA) + '</td>' +
                    '<td>' + htmlEncode(item.CARGO) + '</td>' +
                    '<td class="' + estadoClass + '">' + htmlEncode(item.ESTADO) + '</td>' +
                    '<td class="text-center"><button type="button" class="btn btn-primary btn-sm btn-accion" onclick="seleccionarPersonal(\'' + item.ID_PERSONAL + '\');"><i class="bi bi-pencil-square"></i></button></td>';
            },
            onRowClick: function(item) {
                seleccionarPersonal(item.ID_PERSONAL);
            }
        };

        // Initialize the grid when page loads
        function initPersonalGrid() {
            GridUtils.createGrid(personalGridConfig);
        }

        // ===== FUNCIONES PARA LISTA DE PERSONAL CON BUSQUEDA Y PAGINACION =====

        function abrirNuevoPersonal() {
            window.location.href = 'PersonalForm.aspx?Operacion=N';
        }

        function seleccionarPersonal(idPersonal) {
            window.location.href = 'PersonalForm.aspx?Operacion=E&Id=' + idPersonal;
        }

        function setDropdownByText(dropdownId, text) {
            var dropdown = document.getElementById(dropdownId);
            if (!dropdown) return;
            for (var i = 0; i < dropdown.options.length; i++) {
                if (dropdown.options[i].text === text) {
                    dropdown.selectedIndex = i;
                    return;
                }
            }
        }
    </script>
</head>
<body onload="MostrarMensaje()">

    <uc1:NavBar ID="NavBar1" runat="server" />

    <form id="form1" runat="server">
        <div class="container">

            <!-- ========== LISTA DE PERSONAL CON BUSQUEDA Y PAGINACION ========== -->
            <div class="form-card">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <div>
                        <i class="bi bi-list-ul me-2"></i>Lista de Personal
                    </div>
                    <button type="button" class="btn btn-primary btn-modern" onclick="abrirNuevoPersonal();">
                        <i class="bi bi-plus-circle me-1"></i>Nuevo Personal
                    </button>
                </div>
                <div class="card-body p-3">
                    <!-- Buscador -->
                    <div class="row mb-3">
                        <div class="col-md-8">
                            <div class="input-group">
                                <span class="input-group-text bg-white border-end-0">
                                    <i class="bi bi-search text-muted"></i>
                                </span>
                                <input type="text" id="txtBuscarPersonal" class="form-control border-start-0 search-input" ClientIDMode="Static"
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
                        <table id="tblListaPersonal" class="table table-modern table-hover" style="min-width: 1000px;">
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
                    <div class="page-info" id="pageInfoPersonal"></div>
                </div>
            </div>


            <!-- Hidden Fields -->
            <asp:HiddenField ID="__mensaje" runat="server" />
            <asp:HiddenField ID="__pagina" runat="server" />
            <asp:HiddenField ID="ID_PERSONAL" runat="server" Value="0" EnableViewState="False" />
            <asp:HiddenField ID="datosJson" runat="server" EnableViewState="False" ClientIDMode="Static" />
            <asp:HiddenField ID="__editLocal" runat="server" ClientIDMode="Static" />
            <asp:HiddenField ID="__editArea" runat="server" ClientIDMode="Static" />

        </div>
    </form>

    <!-- Scripts -->
    <script type="text/javascript" src="Otros_css_js/resaltar.js"></script>

    <script type="text/javascript">
        if (window.addEventListener) {
            window.addEventListener('load', function() {
                initPersonalGrid();
            }, false);
        } else if (window.attachEvent) {
            window.attachEvent('onload', function() {
                initPersonalGrid();
            });
        }
    </script>

</body>
</html>
