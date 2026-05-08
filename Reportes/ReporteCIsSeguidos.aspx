<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ReporteCIsSeguidos.aspx.cs" Inherits="ElementosConfiguracion" UnobtrusiveValidationMode="None" %>

<%@ Register src="../NavBar.ascx" tagname="NavBar" tagprefix="uc1" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>Reporte De CIs Seguidos</title>

    <!-- Bootstrap 5.3 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet" />
    <!-- Global Styles -->
    <link href="CssJs/global-styles.css" rel="stylesheet" />

    <style>
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

        /* ===== COLOR CLASSES ===== */
        .color-blue { color: #0066cc; }
        .color-red { color: #cc0000; }

        /* ===== TFOOT STATS ===== */
        .table-modern-grid tfoot tr td {
            background: #f8f9fa !important;
            font-weight: 600;
            font-size: 0.8rem;
            padding: 0.6rem 0.5rem !important;
            border-top: 2px solid #dee2e6 !important;
        }

        .stats-total { color: #198754; }
        .stats-correct { color: #0066cc; }
        .stats-percentage { color: #e94560; font-weight: 700; }

        /* ===== SPACER ===== */
        .top-spacer { height: 100px; }

        /* ===== RESPONSIVE ===== */
        @media (max-width: 991px) {
            .table-wrapper { padding: 1rem; }
        }
    </style>

    <script type="text/javascript" src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script type="text/javascript" src="src/js/utils.js"></script>
    <script type="text/javascript" src="src/js/grid-utils.js"></script>

    <script lang="javascript" type="text/javascript">
        // Grid configuration for CIs Seguidos
        var cisSeguidosGridConfig = {
            tableId: 'tblCIsSeguidos',
            tbodyId: 'tbodyCIsSeguidos',
            searchInputId: 'txtBuscarCIsSeguidos',
            paginationWrapperId: 'paginationCIsSeguidos',
            pageInfoId: 'pageInfoCIsSeguidos',
            counterId: 'lblContadorCIsSeguidos',
            dataFieldId: 'datosJson',
            rowsPerPage: 10,
            searchFields: ['AREA', 'TIPO CI', 'DESCRIPCION CI', 'NOMBRE CI', 'ESTADO ACTUAL'],
            columnRenderer: function(item) {
                var nroPisoAmbienteHtml = item.NRO_PISO_AMBIENTE_HTML || htmlEncode(item['NRO PISO'] + ' / ' + item['NRO AMBIENTE']);
                return '<td>' + htmlEncode(item['AREA']) + '</td>' +
                    '<td>' + nroPisoAmbienteHtml + '</td>' +
                    '<td>' + htmlEncode(item['TIPO CI']) + '</td>' +
                    '<td>' + htmlEncode(item['DESCRIPCION CI']) + '</td>' +
                    '<td>' + htmlEncode(item['NOMBRE CI']) + '</td>' +
                    '<td>' + htmlEncode(item['ESTADO ACTUAL']) + '</td>' +
                    '<td>' + htmlEncode(item['OBSERVACION']) + '</td>' +
                    '<td>' + htmlEncode(item['FECHA SEGUIMIENTO']) + '</td>';
            }
        };

        function initCIsSeguidosGrid() {
            GridUtils.createGrid(cisSeguidosGridConfig);
        }

        function abrir_ventana_imprimir_reporte(Opcion) {
            if (Verificar_Datos_tabla(Opcion)) {
                window.name = "Lista de Personal";
                var options = 'channelmode=1,directories=0,fullscreen=0,location=0,menubar=0,resizable=no,titlebar=0,toolbar=0,edge=Raised,status=no,scrollbars=1,width=1000,height=500,top=70px, left=175px';
                window.open('Reporte.aspx', '', options);
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
            var tabla = document.getElementById("tblCIsSeguidos");
            var tabla_longitud = (tabla.rows.length) - 2; // -1 for header, -1 for footer
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
    </script>
</head>
<body onload="MostrarMensaje()">

    <uc1:NavBar ID="NavBar1" runat="server" />

    <form id="form1" runat="server">
        <div class="container">
            <div class="top-spacer"></div>

            <!-- ========== FILTROS ========== -->
            <div class="form-card">
                <div class="card-header">
                    <i class="bi bi-funnel me-2"></i>Filtros de Busqueda
                </div>
                <div class="card-body p-3">
                    <div class="row g-3">
                        <div class="col-md-3 col-sm-6">
                            <asp:CheckBox ID="cbfs" runat="server" CssClass="form-check-input" Text="Fecha Seguimiento" AutoPostBack="True" OnCheckedChanged="cbfs_CheckedChanged"/>
                        </div>
                        <div class="col-md-3 col-sm-6">
                            <asp:CheckBox ID="cbtci" runat="server" CssClass="form-check-input" Text="Tipo CI" AutoPostBack="True" OnCheckedChanged="cbtci_CheckedChanged"/>
                        </div>
                        <div class="col-md-3 col-sm-6">
                            <asp:CheckBox ID="cbdci" runat="server" CssClass="form-check-input" Text="Descripcion CI" AutoPostBack="True" OnCheckedChanged="cbdci_CheckedChanged"/>
                        </div>
                        <div class="col-md-3 col-sm-6">
                            <asp:CheckBox ID="cba" runat="server" CssClass="form-check-input" Text="Area" AutoPostBack="True" OnCheckedChanged="cba_CheckedChanged"/>
                        </div>
                    </div>
                    <div class="row g-3 mt-2">
                        <div class="col-md-3 col-sm-6">
                            <strong>Fecha Inicio:</strong>
                            <asp:TextBox ID="txtFechaInicioSeguimiento" runat="server" CssClass="form-control form-control-modern" placeholder="Ingrese fec. inicio" Enabled="False"></asp:TextBox>
                            <input id="btnFechaInicioSeguimiento" type="button" value="..." style="height: 25px; width: 25px;" class="form-check" />
                        </div>
                        <div class="col-md-3 col-sm-6">
                            <strong>Fecha Fin:</strong>
                            <asp:TextBox ID="txtFechaFinSeguimiento" runat="server" CssClass="form-control form-control-modern" placeholder="Ingrese fec. fin" Enabled="False"></asp:TextBox>
                            <input id="btnFechaFinSeguimineto" type="button" value="..." style="height: 25px; width: 25px;" class="form-check" />
                        </div>
                        <div class="col-md-3 col-sm-6">
                            <asp:DropDownList ID="ddltci" runat="server" CssClass="form-control form-control-modern" AppendDataBoundItems="True" Enabled="False" OnSelectedIndexChanged="ddltci_SelectedIndexChanged" AutoPostBack="True">
                                <asp:ListItem Value="-1">_____SELECCIONE TIPO CI_____</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="col-md-3 col-sm-6">
                            <asp:DropDownList ID="ddldci" runat="server" CssClass="form-control form-control-modern" AppendDataBoundItems="True" Enabled="False">
                                <asp:ListItem Value="-1">_____SELECCIONE DESCRIPCION CI_____</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div class="row g-3 mt-2">
                        <div class="col-md-3 col-sm-6">
                            <asp:DropDownList ID="ddla" runat="server" CssClass="form-control form-control-modern" AppendDataBoundItems="True" Enabled="False">
                                <asp:ListItem Value="-1">_____SELECCIONE AREA_____</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="col-12 text-center">
                            <asp:LinkButton ID="lbtnBuscar" runat="server" CausesValidation="False" class="btn btn-info btn-modern me-2" Text="Buscar" UseSubmitBehavior="False" OnClick="lbtnBuscar_Click" />
                            <asp:HyperLink ID="IMPRIMIR" runat="server" BorderStyle="None" class="btn btn-info btn-modern" NavigateUrl="" onClick="abrir_ventana_imprimir_reporte(2);">Imprimir reporte</asp:HyperLink>
                        </div>
                    </div>
                </div>
            </div>

            <!-- ========== TABLA ========== -->
            <div class="form-card">
                <div class="card-header">
                    <i class="bi bi-table me-2"></i>Reporte De CIs Seguidos
                </div>
                <div class="card-body p-3">
                    <!-- Buscador -->
                    <div class="row mb-3">
                        <div class="col-md-8">
                            <div class="input-group">
                                <span class="input-group-text bg-white border-end-0">
                                    <i class="bi bi-search text-muted"></i>
                                </span>
                                <input type="text" id="txtBuscarCIsSeguidos" class="form-control border-start-0" ClientIDMode="Static"
                                       placeholder="Buscar por Area, Tipo CI, Descripcion, Nombre..."
                                       onkeyup="filtrarTabla()" />
                                <button class="btn btn-outline-secondary" type="button" onclick="document.getElementById('txtBuscarCIsSeguidos').value=''; filtrarTabla();">
                                    <i class="bi bi-x-lg"></i>
                                </button>
                            </div>
                        </div>
                        <div class="col-md-4 text-end">
                            <span id="lblContadorCIsSeguidos" class="form-text text-muted"></span>
                        </div>
                    </div>

                    <!-- Tabla HTML -->
                    <div class="table-wrapper" style="max-height: 500px; overflow-y: auto;">
                        <table id="tblCIsSeguidos" class="table table-modern table-hover" style="min-width: 1000px;">
                            <thead>
                                <tr>
                                    <th style="width: 10%;">AREA</th>
                                    <th style="width: 12%;">NRO PISO / NRO AMBIENTE</th>
                                    <th style="width: 10%;">TIPO CI</th>
                                    <th style="width: 12%;">DESCRIPCION CI</th>
                                    <th style="width: 12%;">NOMBRE CI</th>
                                    <th style="width: 10%;">ESTADO ACTUAL</th>
                                    <th style="width: 12%;">OBSERVACION</th>
                                    <th style="width: 10%;">FECHA SEGUIMIENTO</th>
                                </tr>
                            </thead>
                            <tbody id="tbodyCIsSeguidos">
                            </tbody>
                            <tfoot>
                                <tr>
                                    <td colspan="8" id="tfootCIsSeguidos"></td>
                                </tr>
                            </tfoot>
                        </table>
                    </div>

                    <!-- Paginacion -->
                    <div class="pagination-wrapper">
                        <ul id="paginationCIsSeguidos" class="pagination" style="flex-wrap: wrap;"></ul>
                    </div>
                    <div class="page-info" id="pageInfoCIsSeguidos"></div>
                </div>
            </div>

            <!-- Hidden Fields -->
            <asp:HiddenField ID="__pagina" runat="server" />
            <asp:HiddenField ID="__mensaje" runat="server" />
            <asp:HiddenField ID="datosJson" runat="server" EnableViewState="False" ClientIDMode="Static" />
            <asp:HiddenField ID="statsJson" runat="server" EnableViewState="False" ClientIDMode="Static" />
        </div>
    </form>

    <script type="text/javascript" src="src/js/jscal2.js"></script>
    <script type="text/javascript">
        Calendar.setup({
            inputField: "txtFechaInicioSeguimiento",
            trigger: "btnFechaInicioSeguimiento",
            onSelect: function () { this.hide() },
            showTime: 12,
            dateFormat: "%d/%m/%Y"
        });
        Calendar.setup({
            inputField: "txtFechaFinSeguimiento",
            trigger: "btnFechaFinSeguimineto",
            onSelect: function () { this.hide() },
            showTime: 12,
            dateFormat: "%d/%m/%Y"
        });

        if (window.addEventListener) {
            window.addEventListener('load', function() {
                initCIsSeguidosGrid();
            }, false);
        } else if (window.attachEvent) {
            window.attachEvent('onload', function() {
                initCIsSeguidosGrid();
            });
        }
    </script>
</body>
</html>
