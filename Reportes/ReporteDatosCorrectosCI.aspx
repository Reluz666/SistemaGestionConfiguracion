<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ReporteDatosCorrectosCI.aspx.cs" Inherits="ReporteDatosCorrectosCI" UnobtrusiveValidationMode="None" %>
<%@ Register src="../NavBar.ascx" tagname="NavBar" tagprefix="uc1" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <title>Reporte Datos Correctamente CIs</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet"/>
    <link href="../../CssJs/global-styles.css" rel="stylesheet"/>

    <style>
        .table-modern {
            border-collapse: separate !important;
            border-spacing: 0;
            width: 100%;
            min-width: 900px;
        }

        .table-modern thead tr th {
            background: linear-gradient(135deg, #1a1a2e 0%, #16213e 100%);
            color: #fff;
            font-weight: 600;
            font-size: 0.75rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            padding: 0.6rem 0.5rem !important;
            border: none !important;
            white-space: nowrap;
        }

        .table-modern tbody tr:hover td {
            background: rgba(233, 69, 96, 0.04) !important;
        }

        .table-modern tbody tr td {
            padding: 0.5rem 0.45rem !important;
            border: none !important;
            border-bottom: 1px solid #f1f1f1 !important;
            vertical-align: middle;
            font-size: 0.8rem;
            color: #2d3436;
        }

        .table-modern tfoot tr td {
            padding: 0.5rem 0.45rem !important;
            border: none !important;
            font-weight: 600;
            background: #f8f9fa;
            font-size: 0.8rem;
        }

        .table-modern tfoot tr:first-child td {
            border-top: 2px solid #dee2e6 !important;
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

        .text-high { color: #198754; font-weight: 600; }
        .text-medium { color: #ffc107; font-weight: 600; }
        .text-low { color: #dc3545; font-weight: 600; }

        .table-wrapper {
            max-height: 450px;
            overflow-y: auto;
        }
    </style>

    <script type="text/javascript" src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script type="text/javascript" src="../src/js/utils.js"></script>
    <script type="text/javascript" src="../src/js/grid-utils.js"></script>

    <script lang="javascript" type="text/javascript">
        // Grid configuration for ReporteDatosCorrectosCI
        var datosCorrectosGridConfig = {
            tableId: 'tblDatosCorrectos',
            tbodyId: 'tbodyDatosCorrectos',
            searchInputId: 'txtBuscar',
            paginationWrapperId: 'paginationWrapper',
            pageInfoId: 'pageInfo',
            counterId: 'lblContador',
            dataFieldId: 'datosJson',
            rowsPerPage: 10,
            searchFields: ['AREA', 'TIPO_CI', 'DESCRIPCION_CI', 'NOMBRE_CI', 'FECHA_SEGUIMIENTO'],
            columnRenderer: function(item) {
                var tipoCIStyle = '';
                if (item.TIPO_CI) {
                    if (item.TIPO_CI.indexOf('%') !== -1) {
                        var val = parseInt(item.TIPO_CI);
                        if (val >= 80) tipoCIStyle = 'text-high';
                        else if (val > 60) tipoCIStyle = 'text-medium';
                        else tipoCIStyle = 'text-low';
                    } else if (item.TIPO_CI.indexOf('IDEAL') !== -1) {
                        tipoCIStyle = 'text-high';
                    } else if (item.TIPO_CI.indexOf('ACEPTABLE') !== -1) {
                        tipoCIStyle = 'text-medium';
                    } else if (item.TIPO_CI.indexOf('DEFICIENTE') !== -1) {
                        tipoCIStyle = 'text-low';
                    }
                }
                return '<td>' + htmlEncode(item.AREA) + '</td>' +
                    '<td class="' + tipoCIStyle + '">' + htmlEncode(item.TIPO_CI) + '</td>' +
                    '<td>' + htmlEncode(item.DESCRIPCION_CI) + '</td>' +
                    '<td>' + htmlEncode(item.NOMBRE_CI) + '</td>' +
                    '<td>' + htmlEncode(item.FECHA_SEGUIMIENTO) + '</td>';
            }
        };

        function initGrid() {
            GridUtils.createGrid(datosCorrectosGridConfig);
        }

        function abrir_ventana_imprimir_reporte() {
            window.name = "ReporteDatosCorrectos";
            var options = 'channelmode=1,directories=0,fullscreen=0,location=0,menubar=0,resizable=no,titlebar=0,toolbar=0,edge=Raised,status=no,scrollbars=1,width=1000,height=500,top=70px,left=175px';
            window.open('Reporte.aspx', '', options);
        }

        if (window.addEventListener) {
            window.addEventListener('load', initGrid, false);
        } else if (window.attachEvent) {
            window.attachEvent('onload', initGrid);
        }
    </script>
</head>
<body onload="MostrarMensaje()">
    <uc1:NavBar ID="NavBar1" runat="server" />

    <form id="form1" runat="server">
        <div class="container">
            <div class="form-card">
                <div class="card-header">
                    <i class="bi bi-check-circle me-2"></i>Reporte de CIs con Datos Correctos
                </div>
                <div class="card-body p-3">
                    <div class="row mb-3">
                        <div class="col-md-8">
                            <div class="input-group">
                                <span class="input-group-text bg-white border-end-0">
                                    <i class="bi bi-search text-muted"></i>
                                </span>
                                <input type="text" id="txtBuscar" class="form-control border-start-0 search-input" ClientIDMode="Static"
                                       placeholder="Buscar por Area, Tipo CI, Descripcion CI, Nombre CI..." />
                                <button class="btn btn-outline-secondary" type="button" onclick="document.getElementById('txtBuscar').value=''; GridUtils.getState('tblDatosCorrectos') && GridUtils.refresh('tblDatosCorrectos');">
                                    <i class="bi bi-x-lg"></i>
                                </button>
                            </div>
                        </div>
                        <div class="col-md-4 text-end">
                            <span id="lblContador" class="form-text text-muted"></span>
                        </div>
                    </div>

                    <div class="table-wrapper">
                        <table id="tblDatosCorrectos" class="table table-modern table-hover" style="min-width: 900px;">
                            <thead>
                                <tr>
                                    <th style="width: 150px;">AREA</th>
                                    <th style="width: 180px;">TIPO CI</th>
                                    <th style="width: 200px;">DESCRIPCION CI</th>
                                    <th style="width: 150px;">NOMBRE CI</th>
                                    <th style="width: 120px;">FECHA SEGUIMIENTO</th>
                                </tr>
                            </thead>
                            <tbody id="tbodyDatosCorrectos">
                            </tbody>
                            <tfoot id="tfootStats" style="display: none;">
                                <tr>
                                    <td colspan="5" id="statsContent"></td>
                                </tr>
                            </tfoot>
                        </table>
                    </div>

                    <div class="pagination-wrapper">
                        <ul id="paginationWrapper" class="pagination" style="flex-wrap: wrap;"></ul>
                    </div>
                    <div class="page-info" id="pageInfo"></div>

                    <div class="text-end mt-3">
                        <asp:HyperLink ID="IMPRIMIR" runat="server" BorderStyle="None" class="btn btn-info btn-modern" NavigateUrl="" onclick="abrir_ventana_imprimir_reporte();">
                            <i class="bi bi-printer"></i> Imprimir reporte
                        </asp:HyperLink>
                    </div>
                </div>
            </div>
        </div>

        <asp:HiddenField ID="__mensaje" runat="server" />
        <asp:HiddenField ID="__pagina" runat="server" />
        <asp:HiddenField ID="datosJson" runat="server" EnableViewState="False" ClientIDMode="Static" />
        <asp:HiddenField ID="datosStatsJson" runat="server" EnableViewState="False" ClientIDMode="Static" />
    </form>

</body>
</html>
