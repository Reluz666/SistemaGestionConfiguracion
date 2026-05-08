<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ReporteRelacionesElementosConfiguracion.aspx.cs" Inherits="ReporteRelacionesElementosConfiguracion" %>
<%@ Register src="../NavBar.ascx" tagname="NavBar" tagprefix="uc1" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>Reporte Relaciones de Elementos de Configuracion</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet" />
    <link href="../CssJs/global-styles.css" rel="stylesheet" />

    <style>
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
        .ci-content {
            line-height: 1.4;
            font-size: 0.75rem;
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

        var allData = [];
        var currentPage = 1;
        var pageSize = 10;
        var filteredData = [];

        function filtrarTabla(texto) {
            texto = texto.toUpperCase();
            var datosFiltrados = [];

            for (var i = 0; i < allData.length; i++) {
                var row = allData[i];
                var textoFila = (row.PADRE_CI || '') + ' ' + (row.PADRE_TIPO_CI || '') + ' ' +
                    (row.PADRE_ESTADO_CI || '') + ' ' + (row.PADRE_PROPIETARIO_CI || '') + ' ' +
                    (row.SEDE || '') + ' ' + (row.LOCAL || '') + ' ' + (row.AREA || '') + ' ' +
                    (row.TIPO_RELACION || '') + ' ' + (row.HIJO_CI || '') + ' ' +
                    (row.HIJO_TIPO_CI || '') + ' ' + (row.HIJO_ESTADO_CI || '');
                if (textoFila.toUpperCase().indexOf(texto) > -1) {
                    datosFiltrados.push(row);
                }
            }

            filteredData = datosFiltrados;
            currentPage = 1;
            Paginar(1);
            document.getElementById('lblTotal').textContent = 'Total: ' + datosFiltrados.length + ' elementos';
        }

        function Paginar(pagina) {
            currentPage = pagina;
            var tbody = document.getElementById("tbodyRelaciones");
            if (!tbody) return;

            var totalPaginas = Math.ceil(filteredData.length / pageSize);
            var inicio = (pagina - 1) * pageSize;
            var fin = inicio + pageSize;
            var datosPagina = filteredData.slice(inicio, fin);

            var lblTotal = document.getElementById("lblTotalRegistros");
            if (lblTotal) lblTotal.textContent = 'Total: ' + filteredData.length + ' elementos';

            tbody.innerHTML = "";

            if (datosPagina.length === 0) {
                tbody.innerHTML = '<tr><td colspan="6" class="text-center text-muted py-4">No se encontraron relaciones</td></tr>';
                document.getElementById("pageInfoRelacion").textContent = '';
                return;
            }

            for (var i = 0; i < datosPagina.length; i++) {
                var item = datosPagina[i];
                var tr = document.createElement("tr");

                var padreContent = '<span class="color-blue"><b>Nombre: </b>' + htmlEncode(item.PADRE_CI) + '</span><br>' +
                    '<b>Tipo:</b> ' + htmlEncode(item.PADRE_TIPO_CI) + '<br>' +
                    '<b>Nro Serie: </b>' + htmlEncode(item.PADRE_NRO_SERIE) + '<br>' +
                    '<b>Direccion IP: </b>' + htmlEncode(item.PADRE_IP) + '<br>' +
                    '<b>Direccion Gateway: </b>' + htmlEncode(item.PADRE_GATEWAY) + '<br>' +
                    '<b>Grupo de Trabajo: </b>' + htmlEncode(item.PADRE_GRUPO_TRABAJO) + '<br>' +
                    '<b>Fabricante / Proveedor: </b>' + htmlEncode(item.PADRE_FABRICANTE) + '<br>' +
                    '<b>Estado:</b> ' + htmlEncode(item.PADRE_ESTADO_CI) + '<br>' +
                    '<b>Propietario:</b> ' + htmlEncode(item.PADRE_PROPIETARIO_CI) + '<br>' +
                    '<b>Descripcion: </b>' + htmlEncode(item.PADRE_DESCRIPCION_CI) + '<br>' +
                    '<b>Prioridad: </b>' + htmlEncode(item.PADRE_PRIORIDAD) + '<br>' +
                    '<span class="color-blue"><b>Sede: </b>' + htmlEncode(item.PADRE_SEDE) + '</span> / ' +
                    '<span class="color-blue"><b>Local: </b>' + htmlEncode(item.PADRE_LOCAL) + '</span><br>' +
                    '<span class="color-red"><b>Area: </b>' + htmlEncode(item.PADRE_AREA) + '</span><br>' +
                    '<span class="color-red"><b>Nro. Piso: </b>' + htmlEncode(item.PADRE_NRO_PISO) + '</span> / ' +
                    '<span class="color-red"><b>Nro. Ambiente: </b>' + htmlEncode(item.PADRE_NRO_AMBIENTE) + '</span><br>' +
                    '<span class="color-red"><b>Ubicacion: </b>' + htmlEncode(item.PADRE_UBICACION) + '</span><br>' +
                    '<span class="color-red"><b>Direccion: </b>' + htmlEncode(item.PADRE_DIRECCION) + '</span>';

                var hijoContent = '<span class="color-blue"><b>Nombre: </b>' + htmlEncode(item.HIJO_CI) + '</span><br>' +
                    '<b>Tipo:</b> ' + htmlEncode(item.HIJO_TIPO_CI) + '<br>' +
                    '<b>Nro Serie: </b>' + htmlEncode(item.HIJO_NRO_SERIE) + '<br>' +
                    '<b>Direccion IP: </b>' + htmlEncode(item.HIJO_IP) + '<br>' +
                    '<b>Direccion Gateway: </b>' + htmlEncode(item.HIJO_GATEWAY) + '<br>' +
                    '<b>Grupo de Trabajo: </b>' + htmlEncode(item.HIJO_GRUPO_TRABAJO) + '<br>' +
                    '<b>Fabricante / Proveedor: </b>' + htmlEncode(item.HIJO_FABRICANTE) + '<br>' +
                    '<b>Estado:</b> ' + htmlEncode(item.HIJO_ESTADO_CI) + '<br>' +
                    '<b>Propietario:</b> ' + htmlEncode(item.HIJO_PROPIETARIO_CI) + '<br>' +
                    '<b>Descripcion: </b>' + htmlEncode(item.HIJO_DESCRIPCION_CI) + '<br>' +
                    '<b>Prioridad: </b>' + htmlEncode(item.HIJO_PRIORIDAD) + '<br>' +
                    '<span class="color-blue"><b>Sede: </b>' + htmlEncode(item.HIJO_SEDE) + '</span> / ' +
                    '<span class="color-blue"><b>Local: </b>' + htmlEncode(item.HIJO_LOCAL) + '</span><br>' +
                    '<span class="color-red"><b>Area: </b>' + htmlEncode(item.HIJO_AREA) + '</span><br>' +
                    '<span class="color-red"><b>Nro. Piso: </b>' + htmlEncode(item.HIJO_NRO_PISO) + '</span> / ' +
                    '<span class="color-red"><b>Nro. Ambiente: </b>' + htmlEncode(item.HIJO_NRO_AMBIENTE) + '</span><br>' +
                    '<span class="color-red"><b>Ubicacion: </b>' + htmlEncode(item.HIJO_UBICACION) + '</span><br>' +
                    '<span class="color-red"><b>Direccion: </b>' + htmlEncode(item.HIJO_DIRECCION) + '</span>';

                tr.innerHTML =
                    '<td class="ci-content">' + padreContent + '</td>' +
                    '<td class="ci-content">' + hijoContent + '</td>' +
                    '<td>' + htmlEncode(item.TIPO_RELACION) + '</td>';
                tbody.appendChild(tr);
            }

            generarPaginacion(totalPaginas, pagina);
            document.getElementById("pageInfoRelacion").textContent = 'Pagina ' + pagina + ' de ' + totalPaginas + ' (Total: ' + filteredData.length + ' registros)';
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

            $("#txtBusqueda").on("keyup", function () {
                filtrarTabla(this.value);
            });
        });
    </script>
</head>
<body onload="MostrarMensaje()">

    <uc1:NavBar ID="NavBar1" runat="server" />

    <form id="form1" runat="server">
        <div class="container">
            <div class="form-card">
                <div class="card-header">
                    <i class="bi bi-link-45deg me-2"></i>Reporte Relaciones de Elementos de Configuracion
                </div>
                <div class="card-body p-3">
                    <div class="table-wrapper">

                <div class="row mb-3">
                    <div class="col-md-8">
                        <div class="input-group">
                            <span class="input-group-text bg-white border-end-0">
                                <i class="bi bi-search text-muted"></i>
                            </span>
                            <input type="text" id="txtBusqueda" class="form-control border-start-0 search-input"
                                placeholder="Buscar en todos los campos..." />
                            <button class="btn btn-outline-secondary" type="button" onclick="document.getElementById('txtBusqueda').value=''; filtrarTabla('');">
                                <i class="bi bi-x-lg"></i>
                            </button>
                        </div>
                    </div>
                    <div class="col-md-4 text-end">
                        <span id="lblTotalRegistros" class="text-muted"></span>
                    </div>
                </div>

                <div class="table-responsive" style="max-height: 600px; overflow-y: auto;">
                    <table class="table table-modern table-hover" id="tblRelaciones">
                        <thead>
                            <tr>
                                <th style="width: 45%;">PADRE ELEMENTO CONFIGURACION</th>
                                <th style="width: 45%;">HIJO ELEMENTO CONFIGURACION</th>
                                <th style="width: 10%;">TIPO RELACION</th>
                            </tr>
                        </thead>
                        <tbody id="tbodyRelaciones">
                        </tbody>
                    </table>
                </div>

                <div class="pagination-wrapper">
                    <nav><ul class="pagination mb-0" id="paginationControls"></ul></nav>
                </div>
                <div class="page-info" id="pageInfoRelacion"></div>
            </div>

            <asp:HiddenField ID="__mensaje" runat="server" />
            <asp:HiddenField ID="__pagina" runat="server" />
            <asp:HiddenField ID="datosJson" runat="server" ClientIDMode="Static" />
        </div>
    </form>

</body>
</html>
