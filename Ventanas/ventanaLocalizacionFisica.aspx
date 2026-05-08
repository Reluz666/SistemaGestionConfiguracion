<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ventanaLocalizacionFisica.aspx.cs" Inherits="Ventanas_ventanaLocalizacionFisica" UnobtrusiveValidationMode="None" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Localizacion Fisica</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet" />

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
        .btn-success { background: #198754; color: #fff; }
        .pagination-wrapper {
            display: flex;
            justify-content: center;
            margin-top: 1.5rem;
        }
        .page-info {
            text-align: center;
            margin-top: 1rem;
            color: #6c757d;
            font-size: 0.9rem;
        }
    </style>

    <script lang="javascript" type="text/javascript">

        function AREA(_ID,
                          _AREA,
                          _SEDE,
                          _LOCAL,
                          _UBICACION,
                          _DIRECCION,
                          _NRO_PISO,
                          _NRO_AMBIENTE) {
            window.opener.document.getElementById("ID_LOCALIZACION_FISICA").value = _ID;
            window.opener.document.getElementById("LOCALIZACION_FISICA").value = "Area :" + _AREA + "\nSede: " + _SEDE + "\nLocal: " + _LOCAL + "\nUbicacion: " + _UBICACION + "\nDireccion: " + _DIRECCION + "\nNro. Piso: " + _NRO_PISO + "\nNro. Ambiente: " + _NRO_AMBIENTE;
            window.close();
        }

        function cerrar_ventana() {
            window.close();
        }

        function MostrarMensaje() {
            var mensaje = document.getElementById("__mensaje").value;
            if (mensaje != "") {
                alert(mensaje);
                if (document.getElementById("__pagina").value != "")
                    location.href = document.getElementById("__pagina").value;
            }
        }

        function window_load() {
            MostrarMensaje()
        }

        function Confirmar(men) {
            if (!confirm(men))
                return false;
        }
    </script>
</head>
<body onload="MostrarMensaje()">
    <form id="form1" runat="server">
        <div class="container py-4">
            <div class="table-wrapper">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h4 class="mb-0"><i class="bi bi-geo-alt me-2"></i>Localizaci&oacute;n F&iacute;sica</h4>
                </div>

                <div class="row mb-3">
                    <div class="col-md-6">
                        <div class="input-group">
                            <span class="input-group-text bg-white border-end-0">
                                <i class="bi bi-search text-muted"></i>
                            </span>
                            <input type="text" id="txtBusqueda" class="form-control border-start-0 search-input"
                                placeholder="Buscar en todos los campos..." onkeyup="filtrarTabla(this.value)" />
                        </div>
                    </div>
                    <div class="col-md-6 text-end">
                        <span id="lblTotal" class="text-muted small"></span>
                    </div>
                </div>

                <div class="table-responsive">
                    <table id="tblDatos" class="table table-modern table-hover">
                        <thead>
                            <tr>
                                <th>SEDE</th>
                                <th>LOCAL</th>
                                <th>DISTRITO</th>
                                <th>PROVINCIA</th>
                                <th>DEPARTAMENTO</th>
                                <th>DIRECCION LOCAL</th>
                                <th>AREA</th>
                                <th>NRO PISO</th>
                                <th>NRO AMBIENTE</th>
                                <th class="text-center">SELECCIONAR</th>
                            </tr>
                        </thead>
                        <tbody id="tbodyDatos">
                        </tbody>
                    </table>
                </div>

                <div class="pagination-wrapper" id="pagination"></div>
                <div class="page-info" id="pageInfo"></div>
            </div>

            <asp:HiddenField ID="__mensaje" runat="server" />
            <asp:HiddenField ID="__pagina" runat="server" />
            <asp:HiddenField ID="datosJson" runat="server" Value="" />
        </div>
    </form>

    <script type="text/javascript" src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <script lang="javascript" type="text/javascript">
        var datosCompletos = [];
        var paginaActual = 1;
        var tamanioPagina = 10;

        function filtrarTabla(texto) {
            texto = texto.toUpperCase();
            var datosFiltrados = [];

            for (var i = 0; i < datosCompletos.length; i++) {
                var row = datosCompletos[i];
                var textoFila = row.SEDE + ' ' + row.LOCAL + ' ' + row.DISTRITO + ' ' +
                    row.PROVINCIA + ' ' + row.DEPARTAMENTO + ' ' + row['DIRECCION LOCAL'] + ' ' +
                    row.AREA + ' ' + row['NRO PISO'] + ' ' + row['NRO AMBIENTE'];
                if (textoFila.toUpperCase().indexOf(texto) > -1) {
                    datosFiltrados.push(row);
                }
            }

            paginaActual = 1;
            renderizarTabla(datosFiltrados);
            var totalPaginas = Math.ceil(datosFiltrados.length / tamanioPagina);
            generarPaginacion(totalPaginas, paginaActual);
            document.getElementById('lblTotal').textContent = 'Total: ' + datosFiltrados.length + ' elementos';
            document.getElementById('pageInfo').textContent = 'Pagina 1 de ' + totalPaginas + ' (Total: ' + datosFiltrados.length + ' registros)';
        }

        function Paginar(pagina) {
            paginaActual = pagina;
            var inicio = (pagina - 1) * tamanioPagina;
            var fin = inicio + tamanioPagina;
            var datosPagina = datosCompletos.slice(inicio, fin);

            renderizarTabla(datosPagina);

            var totalPaginas = Math.ceil(datosCompletos.length / tamanioPagina);
            generarPaginacion(totalPaginas, pagina);
            document.getElementById('pageInfo').textContent = 'Pagina ' + pagina + ' de ' + totalPaginas + ' (Total: ' + datosCompletos.length + ' registros)';
            document.querySelector('.table-wrapper').scrollIntoView({ behavior: 'smooth' });
        }

        function renderizarTabla(datos) {
            var tbody = document.getElementById('tbodyDatos');
            var sb = '';

            if (datos.length === 0) {
                tbody.innerHTML = '<tr><td colspan="10" class="text-center text-muted py-4">No se encontraron elementos</td></tr>';
                return;
            }

            for (var i = 0; i < datos.length; i++) {
                var row = datos[i];
                sb += '<tr>';
                sb += '<td>' + htmlEncode(row.SEDE) + '</td>';
                sb += '<td>' + htmlEncode(row.LOCAL) + '</td>';
                sb += '<td>' + htmlEncode(row.DISTRITO) + '</td>';
                sb += '<td>' + htmlEncode(row.PROVINCIA) + '</td>';
                sb += '<td>' + htmlEncode(row.DEPARTAMENTO) + '</td>';
                sb += '<td>' + htmlEncode(row['DIRECCION LOCAL']) + '</td>';
                sb += '<td>' + htmlEncode(row.AREA) + '</td>';
                sb += '<td>' + htmlEncode(row['NRO PISO']) + '</td>';
                sb += '<td>' + htmlEncode(row['NRO AMBIENTE']) + '</td>';
                sb += '<td class="text-center">';
                sb += '<button type="button" class="btn btn-success btn-sm btn-accion" onclick="AREA(\'' + htmlEncode(row.ID) + '\',\'' + htmlEncode(row.AREA) + '\',\'' + htmlEncode(row.SEDE) + '\',\'' + htmlEncode(row.LOCAL) + '\',\'' + htmlEncode(row.DISTRITO) + ' / ' + htmlEncode(row.PROVINCIA) + ' / ' + htmlEncode(row.DEPARTAMENTO) + '\',\'' + htmlEncode(row['DIRECCION LOCAL']) + '\',\'' + htmlEncode(row['NRO PISO']) + '\',\'' + htmlEncode(row['NRO AMBIENTE']) + '\')">Seleccionar</button>';
                sb += '</td>';
                sb += '</tr>';
            }

            tbody.innerHTML = sb;
        }

        function htmlEncode(str) {
            if (!str) return '';
            return String(str).replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/"/g, '&quot;').replace(/'/g, '&#39;');
        }

        function generarPaginacion(totalPaginas, pagina) {
            var pagination = document.getElementById('pagination');
            if (!pagination) return;

            if (totalPaginas <= 1) {
                pagination.innerHTML = '';
                return;
            }

            var sb = '<nav><ul class="pagination mb-0">';

            if (pagina > 1) {
                sb += '<li class="page-item"><a class="page-link" href="javascript:Paginar(' + (pagina - 1) + ')">Anterior</a></li>';
            } else {
                sb += '<li class="page-item disabled"><span class="page-link">Anterior</span></li>';
            }

            var inicio = Math.max(1, pagina - 2);
            var fin = Math.min(totalPaginas, pagina + 2);

            if (inicio > 1) {
                sb += '<li class="page-item"><a class="page-link" href="javascript:Paginar(1)">1</a></li>';
                if (inicio > 2) {
                    sb += '<li class="page-item disabled"><span class="page-link">...</span></li>';
                }
            }

            for (var i = inicio; i <= fin; i++) {
                if (i === pagina) {
                    sb += '<li class="page-item active"><span class="page-link">' + i + '</span></li>';
                } else {
                    sb += '<li class="page-item"><a class="page-link" href="javascript:Paginar(' + i + ')">' + i + '</a></li>';
                }
            }

            if (fin < totalPaginas) {
                if (fin < totalPaginas - 1) {
                    sb += '<li class="page-item disabled"><span class="page-link">...</span></li>';
                }
                sb += '<li class="page-item"><a class="page-link" href="javascript:Paginar(' + totalPaginas + ')">' + totalPaginas + '</a></li>';
            }

            if (pagina < totalPaginas) {
                sb += '<li class="page-item"><a class="page-link" href="javascript:Paginar(' + (pagina + 1) + ')">Siguiente</a></li>';
            } else {
                sb += '<li class="page-item disabled"><span class="page-link">Siguiente</span></li>';
            }

            sb += '</ul></nav>';
            pagination.innerHTML = sb;
        }

        function inicializarDatos() {
            var datosJsonField = document.getElementById('datosJson');
            if (datosJsonField && datosJsonField.value) {
                try {
                    datosCompletos = JSON.parse(datosJsonField.value);
                    Paginar(1);
                } catch (e) {
                    console.error('Error parsing JSON:', e);
                }
            }
        }

        if (window.addEventListener) {
            window.addEventListener('load', inicializarDatos, false);
        } else if (window.attachEvent) {
            window.attachEvent('onload', inicializarDatos);
        }
    </script>
</body>
</html>