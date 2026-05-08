<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ReporteLicenciasElementoConfiguracion.aspx.cs" Inherits="ReporteLicenciasElementoConfiguracion" UnobtrusiveValidationMode="None" %>
<%@ Register src="../NavBar.ascx" tagname="NavBar" tagprefix="uc1" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>Reporte Licencias de Elementos de Configuracion</title>

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
        .color-blue { color: #0066cc; font-weight: 600; }
        .color-red { color: #cc0000; font-weight: 600; }
        .color-green { color: #198754; font-weight: 600; }
        .btn-info { background: #0dcaf0; color: #fff; }
        .detail-row td {
            background: #f8f9fa !important;
        }
        .detail-table {
            margin: 0;
            font-size: 0.75rem;
        }
        .detail-table th {
            background: #6c757d !important;
            color: #fff;
            padding: 0.3rem 0.4rem !important;
            font-weight: 600;
        }
        .detail-table td {
            padding: 0.3rem 0.4rem !important;
            border-bottom: 1px solid #dee2e6;
        }
        @media (max-width: 991px) {
            .table-wrapper { padding: 1rem; }
        }
    </style>

    <script type="text/javascript" src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script type="text/javascript" src="../src/js/utils.js"></script>

    <script lang="javascript" type="text/javascript">
        function MostrarMensaje() {
            var mensaje = document.getElementById("__mensaje").value;
            if (mensaje != "") {
                alert(mensaje);
                if (document.getElementById("__pagina").value != "")
                    location.href = document.getElementById("__pagina").value;
            }
        }

        function toggleRow(rowId) {
            var row = document.getElementById(rowId);
            if (row) {
                if (row.style.display === "none" || row.style.display === "") {
                    row.style.display = "table-row";
                } else {
                    row.style.display = "none";
                }
            }
        }

        var allData = [];
        var currentPage = 1;
        var pageSize = 10;
        var filteredData = [];

        function filtrarTabla(texto) {
            texto = texto.toUpperCase();
            var datosFiltrados = [];

            for (var i = 0; i < allData.length; i++) {
                var row = allData[i];
                var textoFila = (row.LICENCIA || '') + ' ' + (row.TIPO_LICENCIA || '') + ' ' +
                    (row.NOMBRE || '') + ' ' + (row.VERSION || '') + ' ' +
                    (row.SUSCRIPCION || '');
                if (textoFila.toUpperCase().indexOf(texto) > -1) {
                    datosFiltrados.push(row);
                }
            }

            filteredData = datosFiltrados;
            currentPage = 1;
            Paginar(1);
        }

        function Paginar(pagina) {
            currentPage = pagina;
            var tbody = document.getElementById("tbodyLicencias");
            if (!tbody) return;

            var totalPaginas = Math.ceil(filteredData.length / pageSize);
            var inicio = (pagina - 1) * pageSize;
            var fin = inicio + pageSize;
            var datosPagina = filteredData.slice(inicio, fin);

            var lblTotal = document.getElementById("lblTotalRegistros");
            if (lblTotal) lblTotal.textContent = 'Total: ' + filteredData.length + ' elementos';

            tbody.innerHTML = "";

            if (datosPagina.length === 0) {
                tbody.innerHTML = '<tr><td colspan="10" class="text-center text-muted py-4">No se encontraron licencias</td></tr>';
                document.getElementById("pageInfoLicencia").textContent = '';
                return;
            }

            for (var i = 0; i < datosPagina.length; i++) {
                var item = datosPagina[i];
                var perpColor = item.PERPETUA === "SI" ? "color-blue" : "color-red";
                var venceColor = "color-blue";
                if (item.VENCE_LICENCIA === "LICENCIA VENCIDA") {
                    venceColor = "color-red";
                } else if (item.VENCE_LICENCIA === "LICENCIA NO VENCE") {
                    venceColor = "color-green";
                }

                var tr = document.createElement("tr");
                tr.innerHTML =
                    '<td>' + htmlEncode(item.LICENCIA) + '</td>' +
                    '<td>' + htmlEncode(item.TIPO_LICENCIA) + '</td>' +
                    '<td>' + htmlEncode(item.NOMBRE) + '</td>' +
                    '<td>' + htmlEncode(item.VERSION) + '</td>' +
                    '<td>' + htmlEncode(item.SUSCRIPCION) + '</td>' +
                    '<td>' + htmlEncode(item.FEC_INI) + '</td>' +
                    '<td>' + htmlEncode(item.FEC_FIN) + '</td>' +
                    '<td class="' + perpColor + '">' + htmlEncode(item.PERPETUA) + '</td>' +
                    '<td class="' + venceColor + '">' + htmlEncode(item.VENCE_LICENCIA) + '</td>' +
                    '<td class="text-center"><button type="button" class="btn btn-info btn-sm btn-accion" onclick="toggleRow(\'details-' + item.ID_LI + '\');"><i class="bi bi-plus-circle"></i> Ver Detalles</button></td>';
                tbody.appendChild(tr);

                // Detail row
                var detailTr = document.createElement("tr");
                detailTr.id = "details-" + item.ID_LI;
                detailTr.style.display = "none";
                detailTr.className = "detail-row";

                var detailCell = document.createElement("td");
                detailCell.colSpan = 10;

                if (item.detalles && item.detalles.length > 0) {
                    var detailTableHtml = '<table class="table table-sm table-striped detail-table mb-0"><thead><tr>' +
                        '<th>TIPO CI</th><th>NOMBRE CI</th><th>NRO SERIE</th><th>PROPIETARIO</th><th>DESCRIPCION CI</th>' +
                        '<th>SEDE</th><th>LOCAL</th><th>AREA</th><th>NRO PISO</th><th>NRO AMBIENTE</th>' +
                        '</tr></thead><tbody>';
                    for (var j = 0; j < item.detalles.length; j++) {
                        var d = item.detalles[j];
                        detailTableHtml += '<tr>' +
                            '<td>' + htmlEncode(d.TIPO_CI) + '</td>' +
                            '<td>' + htmlEncode(d.NOMBRE_CI) + '</td>' +
                            '<td>' + htmlEncode(d.NRO_SERIE) + '</td>' +
                            '<td>' + htmlEncode(d.PROPIETARIO) + '</td>' +
                            '<td>' + htmlEncode(d.DESCRIPCION_CI) + '</td>' +
                            '<td>' + htmlEncode(d.SEDE) + '</td>' +
                            '<td>' + htmlEncode(d.LOCAL) + '</td>' +
                            '<td>' + htmlEncode(d.AREA) + '</td>' +
                            '<td>' + htmlEncode(d.NRO_PISO) + '</td>' +
                            '<td>' + htmlEncode(d.NRO_AMBIENTE) + '</td>' +
                            '</tr>';
                    }
                    detailTableHtml += '</tbody></table>';
                    detailCell.innerHTML = detailTableHtml;
                } else {
                    detailCell.innerHTML = '<div class="text-muted p-2">Cargando detalles...</div>';
                }

                detailTr.appendChild(detailCell);
                tbody.appendChild(detailTr);
            }

            generarPaginacion(totalPaginas, pagina);
            document.getElementById("pageInfoLicencia").textContent = 'Pagina ' + pagina + ' de ' + totalPaginas + ' (Total: ' + filteredData.length + ' registros)';
        }

        function generarPaginacion(totalPaginas, pagina) {
            var ul = document.getElementById("paginationControls");
            if (!ul) return;
            ul.innerHTML = '';

            if (totalPaginas <= 1) {
                return;
            }

            var sb = '';

            if (pagina > 1) {
                sb += '<li class="page-item"><a class="page-link" href="javascript:Paginar(' + (pagina - 1) + ')">Anterior</a></li>';
            } else {
                sb += '<li class="page-item disabled"><span class="page-link">Anterior</span></li>';
            }

            var inicio = Math.max(1, pagina - 2);
            var fin = Math.min(totalPaginas, pagina + 2);

            if (inicio > 1) {
                sb += '<li class="page-item"><a class="page-link" href="javascript:Paginar(1)">1</a></li>';
                if (inicio > 2) sb += '<li class="page-item disabled"><span class="page-link">...</span></li>';
            }

            for (var i = inicio; i <= fin; i++) {
                if (i === pagina) {
                    sb += '<li class="page-item active"><span class="page-link">' + i + '</span></li>';
                } else {
                    sb += '<li class="page-item"><a class="page-link" href="javascript:Paginar(' + i + ')">' + i + '</a></li>';
                }
            }

            if (fin < totalPaginas) {
                if (fin < totalPaginas - 1) sb += '<li class="page-item disabled"><span class="page-link">...</span></li>';
                sb += '<li class="page-item"><a class="page-link" href="javascript:Paginar(' + totalPaginas + ')">' + totalPaginas + '</a></li>';
            }

            if (pagina < totalPaginas) {
                sb += '<li class="page-item"><a class="page-link" href="javascript:Paginar(' + (pagina + 1) + ')">Siguiente</a></li>';
            } else {
                sb += '<li class="page-item disabled"><span class="page-link">Siguiente</span></li>';
            }

            ul.innerHTML = sb;
        }

        window.addEventListener('load', function () {
            var jsonField = document.getElementById("datosJson");
            var jsonData = jsonField ? jsonField.value : '';
            if (jsonData && jsonData.trim() !== "") {
                try {
                    allData = JSON.parse(jsonData);
                    filteredData = allData;
                    Paginar(1);
                } catch (e) {
                    console.error("Error al parsear JSON:", e);
                }
            }

            $("#txtBuscarLicencia").on("keyup", function () {
                filtrarTabla(this.value);
            });
        });
    </script>
</head>
<body onload="MostrarMensaje()">

    <uc1:NavBar ID="NavBar1" runat="server" />

    <div class="top-spacer"></div>

    <form id="form1" runat="server">
        <div class="container mt-4">
            <div class="table-wrapper">
                <h4 class="mb-4"><i class="bi bi-file-earmark-lock me-2"></i>Reporte de Licencias de Elementos de Configuracion</h4>

                <div class="row mb-3">
                    <div class="col-md-6">
                        <div class="input-group">
                            <span class="input-group-text bg-white border-end-0">
                                <i class="bi bi-search text-muted"></i>
                            </span>
                            <input type="text" id="txtBuscarLicencia" class="form-control border-start-0 search-input"
                                placeholder="Buscar por licencia, nombre, version o suscripcion..." />
                        </div>
                    </div>
                    <div class="col-md-6 text-end">
                        <span id="lblTotalRegistros" class="text-muted"></span>
                    </div>
                </div>

                <div class="table-responsive" style="max-height: 600px; overflow-y: auto;">
                    <table class="table table-modern table-hover" id="tblListaLicencias">
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
                                <th>ACCION</th>
                            </tr>
                        </thead>
                        <tbody id="tbodyLicencias">
                        </tbody>
                    </table>
                </div>

                <div class="pagination-wrapper">
                    <nav><ul class="pagination mb-0" id="paginationControls"></ul></nav>
                </div>
                <div class="page-info" id="pageInfoLicencia"></div>
            </div>

            <asp:HiddenField ID="__mensaje" runat="server" />
            <asp:HiddenField ID="__pagina" runat="server" />
            <asp:HiddenField ID="datosJson" runat="server" ClientIDMode="Static" />
        </div>
    </form>

    <script type="text/javascript" src="../Otros_css_js/resaltar.js"></script>
</body>
</html>
