<%@ Page Language="C#" AutoEventWireup="true" CodeFile="LicenciasElementoConfiguracion.aspx.cs" Inherits="LicenciasElementoConfiguracion" UnobtrusiveValidationMode="None" %>
<%@ Register src="NavBar.ascx" tagname="NavBar" tagprefix="uc1" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>Licencia Elemento Configuracion</title>

    <!-- Bootstrap 5.3 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet" />
    <!-- Global Styles -->
    <link href="CssJs/global-styles.css" rel="stylesheet" />

    <style>
        /* ===== NAVBAR ===== */
        .navbar-modern {
            background: linear-gradient(135deg, #1a1a2e 0%, #16213e 100%);
            border: none;
            box-shadow: 0 2px 15px rgba(0, 0, 0, 0.15);
            padding: 0.8rem 1rem;
        }

        .navbar-modern .navbar-brand {
            color: #fff !important;
            font-weight: 600;
            font-size: 1.2rem;
        }

        .navbar-modern .navbar-brand:hover {
            color: #e94560 !important;
        }

        .navbar-modern .nav-link {
            color: rgba(255, 255, 255, 0.85) !important;
            font-weight: 500;
            padding: 0.6rem 1rem !important;
            border-radius: 8px;
            transition: color 0.2s, background 0.2s;
        }

        .navbar-modern .nav-link:hover {
            color: #fff !important;
            background: rgba(255, 255, 255, 0.1);
        }

        .navbar-modern .dropdown-menu {
            background: #1a1a2e;
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 12px;
            padding: 0.5rem;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.3);
        }

        .navbar-modern .dropdown-item {
            color: rgba(255, 255, 255, 0.8);
            border-radius: 8px;
            padding: 0.5rem 1rem;
            transition: all 0.2s;
        }

        .navbar-modern .dropdown-item:hover {
            background: rgba(233, 69, 96, 0.2);
            color: #fff;
        }

        .navbar-modern .dropdown-submenu {
            position: relative;
        }

        .navbar-modern .dropdown-submenu > .dropdown-toggle::after {
            border-left: 0.3em solid;
            border-top: 0.3em solid transparent;
            border-bottom: 0.3em solid transparent;
            margin-left: auto;
        }

        .navbar-modern .dropdown-submenu > .dropdown-menu {
            top: 0;
            left: 100%;
            margin-top: -6px;
            margin-left: 2px;
            border-radius: 12px;
        }

        .navbar-modern .dropdown-submenu:hover > .dropdown-menu {
            display: block;
        }

        /* ===== FORMULARIO ===== */
        .form-card {
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 4px 25px rgba(0, 0, 0, 0.08);
            padding: 2rem;
            margin-bottom: 2rem;
            border: 1px solid rgba(0, 0, 0, 0.05);
        }

        .form-card .card-header {
            background: linear-gradient(135deg, #1a1a2e 0%, #16213e 100%);
            color: #fff;
            border-radius: 12px 12px 0 0;
            padding: 1.2rem 1.5rem;
            font-weight: 600;
            font-size: 1.1rem;
            border: none;
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

        .estado-activo { color: #198754; font-weight: 600; }
        .estado-inactivo { color: #dc3545; font-weight: 600; }

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

        .pagination-wrapper {
            display: flex;
            justify-content: center;
            margin-top: 1.5rem;
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

    <script lang="javascript" type="text/javascript">
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

    <script type="text/javascript" src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body onload="MostrarMensaje()">

    <uc1:NavBar ID="NavBar1" runat="server" />

    <!-- ========== FORMULARIO ========== -->
    <form id="form1" runat="server">
        <asp:HiddenField ID="__mensaje" runat="server" />
        <asp:HiddenField ID="__pagina" runat="server" />
        <asp:HiddenField ID="datosJson" runat="server" ClientIDMode="Static" />

        <!-- ========== LISTA CON BUSQUEDA Y PAGINACION ========== -->
        <div class="container mt-4" id="listSection">
            <div class="table-wrapper">
                <div class="form-card">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <div>
                            <i class="bi bi-list-ul me-2"></i>Lista de Licencias
                        </div>
                        <div>
                            <asp:Button ID="btnNuevaLicencia" runat="server" OnClick="btnNuevaLicencia_Click"
                                Text="Nueva Licencia Elemento Configuración" CssClass="btn btn-success btn-modern" />
                        </div>
                    </div>
                    <div class="card-body">
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

                        <div class="table-responsive">
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
                </div>
            </div>
        </div>
    </form>

    <script type="text/javascript">
        function toggleRow(rowId) {
            var row = document.getElementById(rowId);
            if (row.style.display === "none" || row.style.display === "") {
                row.style.display = "table-row";
            } else {
                row.style.display = "none";
            }
        }
    </script>

    <script type="text/javascript" src="../Otros_css_js/resaltar.js"></script>

    <script type="text/javascript">
        Calendar.setup({
            inputField: "txtFechaInicioSuscripcion",
            trigger: "btnFechaInicioSuscripcion",
            onSelect: function () { this.hide() },
            showTime: 12,
            dateFormat: "%d/%m/%Y"
        });
        Calendar.setup({
            inputField: "txtFechaFinSuscripcion",
            trigger: "btnFechaFinSuscripcion",
            onSelect: function () { this.hide() },
            showTime: 12,
            dateFormat: "%d/%m/%Y"
        });
    </script>

    <script type="text/javascript">
        // ===== Variables globales =====
        var allData = [];
        var currentPage = 1;
        var pageSize = 10;
        var filteredData = [];

        function htmlEncode(str) {
            if (!str) return '';
            return String(str).replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/"/g, '&quot;');
        }

        // ===== Inicializacion al cargar la pagina =====
        function inicializarDatos() {
            var jsonField = document.getElementById("datosJson");
            var jsonData = jsonField ? jsonField.value : '';
            console.log('datosJson value length:', jsonData ? jsonData.length : 'empty/not found');
            if (jsonData && jsonData.trim() !== "") {
                try {
                    allData = JSON.parse(jsonData);
                    filteredData = allData;
                    Paginar(1);
                    console.log('Loaded', allData.length, 'records');
                } catch (e) {
                    console.error("Error al parsear JSON:", e);
                }
            }
        }

        if (window.addEventListener) {
            window.addEventListener('load', inicializarDatos, false);
        } else if (window.attachEvent) {
            window.attachEvent('onload', inicializarDatos);
        }

        function filtrarTabla(texto) {
            texto = texto.toUpperCase();
            var datosFiltrados = [];

            for (var i = 0; i < allData.length; i++) {
                var row = allData[i];
                var textoFila = Object.values(row).join(' ').toUpperCase();
                if (textoFila.indexOf(texto) > -1) {
                    datosFiltrados.push(row);
                }
            }

            filteredData = datosFiltrados;
            currentPage = 1;
            Paginar(1);
        }

        // Evento de busqueda con delegacion
        document.addEventListener('keyup', function (e) {
            if (e.target.id === 'txtBuscarLicencia') {
                filtrarTabla(e.target.value);
            }
        });

        function Paginar(pagina) {
            currentPage = pagina;
            var tbody = document.getElementById("tbodyLicencias");
            if (!tbody) return;

            var totalPaginas = Math.ceil(filteredData.length / pageSize);
            var inicio = (pagina - 1) * pageSize;
            var fin = inicio + pageSize;
            var datosPagina = filteredData.slice(inicio, fin);

            // Actualizar etiqueta de total
            var lblTotal = document.getElementById("lblTotalRegistros");
            if (lblTotal) lblTotal.textContent = 'Total: ' + filteredData.length + ' elementos';

            tbody.innerHTML = "";

            if (datosPagina.length === 0) {
                tbody.innerHTML = '<tr><td colspan="9" class="text-center text-muted py-4">No se encontraron elementos</td></tr>';
                document.getElementById("pageInfoLicencia").textContent = '';
                return;
            }

            // Generar filas
            for (var i = 0; i < datosPagina.length; i++) {
                var item = datosPagina[i];
                var tr = document.createElement("tr");

                var perpColor = item.PERPETUA === "SI" ? "#0066cc" : "#cc0000";
                var venceColor = "";
                if (item.VENCE_LICENCIA === "LICENCIA VENCIDA") {
                    venceColor = "#cc0000";
                } else if (item.VENCE_LICENCIA === "LICENCIA NO DUELE") {
                    venceColor = "#008800";
                } else {
                    venceColor = "#0066cc";
                }

                tr.innerHTML =
                    '<td>' + htmlEncode(item.LICENCIA) + '</td>' +
                    '<td>' + htmlEncode(item.TIPO_LICENCIA) + '</td>' +
                    '<td>' + htmlEncode(item.NOMBRE) + '</td>' +
                    '<td>' + htmlEncode(item.VERSION) + '</td>' +
                    '<td>' + htmlEncode(item.SUSCRIPCION) + '</td>' +
                    '<td>' + htmlEncode(item.FEC_INI) + '</td>' +
                    '<td>' + htmlEncode(item.FEC_FIN) + '</td>' +
                    '<td style="color:' + perpColor + '; font-weight:600;">' + htmlEncode(item.PERPETUA) + '</td>' +
                    '<td style="color:' + venceColor + '; font-weight:600;">' + htmlEncode(item.VENCE_LICENCIA) + '</td>';
                tbody.appendChild(tr);
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

            // Anterior
            if (pagina > 1) {
                sb += '<li class="page-item"><a class="page-link" href="javascript:Paginar(' + (pagina - 1) + ')">Anterior</a></li>';
            } else {
                sb += '<li class="page-item disabled"><span class="page-link">Anterior</span></li>';
            }

            // Numeros de pagina
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

            // Siguiente
            if (pagina < totalPaginas) {
                sb += '<li class="page-item"><a class="page-link" href="javascript:Paginar(' + (pagina + 1) + ')">Siguiente</a></li>';
            } else {
                sb += '<li class="page-item disabled"><span class="page-link">Siguiente</span></li>';
            }

            ul.innerHTML = sb;
        }
    </script>

</body>
</html>
