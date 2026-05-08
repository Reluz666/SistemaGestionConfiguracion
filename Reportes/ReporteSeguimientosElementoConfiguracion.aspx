<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ReporteSeguimientosElementoConfiguracion.aspx.cs" Inherits="ReporteSeguimientosElementoConfiguracion" UnobtrusiveValidationMode="None" %>
<%@ Register src="../NavBar.ascx" tagname="NavBar" tagprefix="uc1" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>Reporte Seguimientos de Elementos de Configuracion</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet" />
    <link href="../CssJs/global-styles.css" rel="stylesheet" />

    <style>
        .top-spacer { height: 100px; }
        .table-wrapper {
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 4px 25px rgba(0,0,0,0.08);
            padding: 1.5rem;
            border: 1px solid rgba(0,0,0,0.05);
        }
        .table-modern thead th {
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
        .table-modern tbody td {
            padding: 0.5rem 0.45rem !important;
            border: none;
            border-bottom: 1px solid #f1f1f1;
            vertical-align: middle;
            font-size: 0.8rem;
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
        .btn-accion {
            padding: 0.25rem 0.5rem;
            font-size: 0.75rem;
            border-radius: 6px;
        }
        .color-blue { color: #0066cc; }
        .color-red { color: #cc0000; }
        .color-green { color: #198754; font-weight: 600; }
        .btn-success { background: #198754; color: #fff; }
        .btn-primary { background: #0d6efd; color: #fff; }
        @media (max-width: 991px) {
            .table-wrapper { padding: 1rem; }
        }
    </style>

    <script type="text/javascript" src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script type="text/javascript" src="../src/js/utils.js"></script>
    <script type="text/javascript" src="../src/js/grid-utils.js"></script>

    <script lang="javascript" type="text/javascript">
        function MostrarMensaje() {
            var mensaje = document.getElementById("__mensaje").value;
            if (mensaje != "") {
                alert(mensaje);
                if (document.getElementById("__pagina").value != "")
                    location.href = document.getElementById("__pagina").value;
            }
        }

        // Grid configuration for Seguimientos Report
        var seguimientosGridConfig = {
            tableId: 'tblSeguimientos',
            tbodyId: 'tbodySeguimientos',
            searchInputId: 'txtBusqueda',
            paginationWrapperId: 'paginationSeguimientos',
            pageInfoId: 'pageInfoSeguimientos',
            counterId: 'lblTotal',
            dataFieldId: 'datosJson',
            rowsPerPage: 10,
            searchFields: ['NOMBRE_CI', 'TIPO_CI', 'NRO_SERIE', 'DESCRIPCION', 'SEDE', 'RESPONSABLE', 'ESTADO_ACTUAL'],
            columnRenderer: function(item) {
                var estadoColor = item.ESTADO === 'ACTIVO' ? 'color-blue' : 'color-red';
                var relacionColor = item.RELACION_CIS === 'SI' ? 'color-blue' : 'color-red';
                var cumpleColor = item.CUMPLE_POLITICA === 'SI' ? 'color-blue' : 'color-red';
                var fechaSeguimiento = parseJsonDate(item.FECHA_SEGUIMIENTO);

                return '<td>' + htmlEncode(item.NOMBRE_CI) + '</td>' +
                    '<td>' + htmlEncode(item.TIPO_CI) + '</td>' +
                    '<td>' + htmlEncode(item.NRO_SERIE) + '</td>' +
                    '<td>' + htmlEncode(item.DESCRIPCION) + '</td>' +
                    '<td><span class="color-red">' + htmlEncode(item.SEDE) + '</span> / <span class="color-blue">' + htmlEncode(item.LOCAL) + '</span></td>' +
                    '<td><span class="color-red">' + htmlEncode(item.UBICACION) + '</span> / <span class="color-blue">' + htmlEncode(item.DIRECCION) + '</span></td>' +
                    '<td><span class="color-red">' + htmlEncode(item.AREA) + '</span> / <span class="color-blue">' + htmlEncode(item.NRO_PISO) + '</span> / ' + htmlEncode(item.NRO_AMBIENTE) + '</td>' +
                    '<td>' + htmlEncode(item.RESPONSABLE) + '</td>' +
                    '<td class="color-green fw-bold">' + fechaSeguimiento + '</td>' +
                    '<td>' + htmlEncode(item.CLASIFICACION_DATOS) + '</td>' +
                    '<td>' + htmlEncode(item.ESTADO_ACTUAL).replace(/,/g, '<br>') + '</td>' +
                    '<td class="' + relacionColor + '">' + htmlEncode(item.RELACION_CIS) + '</td>' +
                    '<td class="' + cumpleColor + '">' + htmlEncode(item.CUMPLE_POLITICA) + '</td>' +
                    '<td>' + htmlEncode(item.OBSERVACION) + '</td>' +
                    '<td class="text-center"><button type="button" class="btn btn-success btn-sm btn-accion" onclick="editarSeguimiento(\'' + item.ID_CI + '\');"><i class="bi bi-pencil-square"></i> EDITAR</button></td>';
            },
            onRowClick: function(item) {
                editarSeguimiento(item.ID_CI);
            }
        };

        function parseJsonDate(jsonDate) {
            if (!jsonDate) return '';
            try {
                var date = new Date(parseInt(jsonDate.replace(/\/Date\((\d+)\)\//gi, '$1')));
                if (isNaN(date.getTime())) return jsonDate;
                var day = ("0" + date.getDate()).slice(-2);
                var month = ("0" + (date.getMonth() + 1)).slice(-2);
                var year = date.getFullYear();
                return day + "/" + month + "/" + year;
            } catch (e) {
                return jsonDate;
            }
        }

        function editarSeguimiento(idCI) {
            var gridState = GridUtils.getState('tblSeguimientos');
            var datosCompletos = gridState ? gridState.data : [];

            for (var i = 0; i < datosCompletos.length; i++) {
                if (datosCompletos[i].ID_CI === idCI) {
                    var item = datosCompletos[i];
                    var estadoActual = item.ESTADO_ACTUAL ? item.ESTADO_ACTUAL.replace(/,/g, '-') : '';

                    Session["__SEGUIMIENTO_ELEMENTO_CONFIGURACION__"] = new Object[] {
                        item.ID_CI,
                        "Nombre: " + item.NOMBRE_CI + "   Tipo: " + item.TIPO_CI + "   Nro. Serie: " + item.NRO_SERIE,
                        "Fabricante: " + item.FABRICANTE + "   Marca: " + item.MARCA + "   Modelo: " + item.MODELO,
                        "Estado: " + item.ESTADO + "   Descripcion: " + item.DESCRIPCION + "   Sede: " + item.SEDE,
                        "Local: " + item.LOCAL + "   Ubicacion: " + item.UBICACION + "   Direccion: " + item.DIRECCION,
                        "Area: " + item.AREA + "   Nro. Piso: " + item.NRO_PISO + "   Nro. Ambiente: " + item.NRO_AMBIENTE,
                        item.ID_SEGUIMIENTO,
                        item.ID_RESPONSABLE,
                        item.RESPONSABLE,
                        item.FECHA_SEGUIMIENTO,
                        item.CLASIFICACION_DATOS,
                        estadoActual,
                        item.RELACION_CIS,
                        item.CUMPLE_POLITICA,
                        item.OBSERVACION
                    };

                    location.href = "SeguimientoElementoConfiguracion.aspx";
                    return;
                }
            }
        }

        function initSeguimientosGrid() {
            GridUtils.createGrid(seguimientosGridConfig);
        }

        if (window.addEventListener) {
            window.addEventListener('load', initSeguimientosGrid, false);
        } else if (window.attachEvent) {
            window.attachEvent('onload', initSeguimientosGrid);
        }
    </script>
</head>
<body onload="MostrarMensaje()">

    <uc1:NavBar ID="NavBar1" runat="server" />

    <div class="top-spacer"></div>

    <form id="form1" runat="server">
        <div class="container">
            <div class="table-wrapper">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h4 class="mb-0"><i class="bi bi-clipboard-check me-2"></i>Reporte de Seguimientos de Elementos de Configuracion</h4>
                </div>

                <div class="row mb-3">
                    <div class="col-md-8">
                        <div class="input-group">
                            <span class="input-group-text bg-white border-end-0">
                                <i class="bi bi-search text-muted"></i>
                            </span>
                            <input type="text" id="txtBusqueda" class="form-control border-start-0 search-input"
                                placeholder="Buscar por Nombre CI, Tipo, Nro. Serie, Descripcion, Sede, Responsable..." />
                            <button class="btn btn-outline-secondary" type="button" onclick="document.getElementById('txtBusqueda').value=''; filtrarTabla();">
                                <i class="bi bi-x-lg"></i>
                            </button>
                        </div>
                    </div>
                    <div class="col-md-4 text-end">
                        <span id="lblTotal" class="form-text text-muted"></span>
                    </div>
                </div>

                <div class="table-responsive" style="max-height: 600px; overflow-y: auto;">
                    <table id="tblSeguimientos" class="table table-modern table-hover">
                        <thead>
                            <tr>
                                <th>NOMBRE CI</th>
                                <th>TIPO CI</th>
                                <th>NRO. SERIE</th>
                                <th>DESCRIPCION</th>
                                <th>SEDE / LOCAL</th>
                                <th>UBICACION / DIRECCION</th>
                                <th>AREA / NRO PISO / NRO AMBIENTE</th>
                                <th>RESPONSABLE</th>
                                <th>FECHA SEGUIMIENTO</th>
                                <th>CLASIFICACION DATOS</th>
                                <th>ESTADO ACTUAL</th>
                                <th>RELACION CIS</th>
                                <th>CUMPLE POLITICA</th>
                                <th>OBSERVACION</th>
                                <th>ACCION</th>
                            </tr>
                        </thead>
                        <tbody id="tbodySeguimientos">
                        </tbody>
                    </table>
                </div>

                <div class="pagination-wrapper" id="paginationSeguimientos"></div>
                <div class="page-info" id="pageInfoSeguimientos"></div>
            </div>

            <asp:HiddenField ID="__mensaje" runat="server" />
            <asp:HiddenField ID="__pagina" runat="server" />
            <asp:HiddenField ID="datosJson" runat="server" ClientIDMode="Static" />
        </div>
    </form>

</body>
</html>
