<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ReporteComponentesAsignados.aspx.cs" Inherits="ElementosConfiguracion" UnobtrusiveValidationMode="None" %>

<%@ Register src="../NavBar.ascx" tagname="NavBar" tagprefix="uc1" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>Reporte Componentes Asignados</title>

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
        .estado-activo { color: #0066cc; font-weight: 600; }
        .estado-inactivo { color: #cc0000; font-weight: 600; }

        /* ===== EXPANDABLE DETAIL ROW ===== */
        .detail-row {
            display: none;
        }

        .detail-row td {
            padding: 0 !important;
            background: #f8f9fa !important;
        }

        .detail-inner {
            padding: 1rem;
            margin: 0.5rem;
            background: #fff;
            border-radius: 8px;
            border: 1px solid #e9ecef;
        }

        .detail-inner table {
            margin-bottom: 0;
        }

        .detail-inner thead tr th {
            background: #495057 !important;
            font-size: 0.65rem;
            padding: 0.4rem 0.4rem !important;
        }

        .detail-inner tbody tr td {
            font-size: 0.75rem;
            padding: 0.3rem 0.4rem !important;
        }

        .toggle-btn {
            cursor: pointer;
            color: #0066cc;
            font-size: 1rem;
            padding: 0.25rem 0.5rem;
            border: 1px solid #0066cc;
            border-radius: 4px;
            background: transparent;
        }

        .toggle-btn:hover {
            background: rgba(0, 102, 204, 0.1);
        }

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
        // Grid configuration for Componentes Asignados
        var componentesGridConfig = {
            tableId: 'tblComponentes',
            tbodyId: 'tbodyComponentes',
            searchInputId: 'txtBuscarComponentes',
            paginationWrapperId: 'paginationComponentes',
            pageInfoId: 'pageInfoComponentes',
            counterId: 'lblContadorComponentes',
            dataFieldId: 'datosJson',
            rowsPerPage: 10,
            searchFields: ['NOMBRE CI', 'NOMBRE TIPO CI', 'FABRICANTE / PROVEEDOR', 'AREA', 'ESTADO CI'],
            columnRenderer: function(item) {
                var estadoClass = item['ESTADO CI'] === 'ACTIVO' ? 'estado-activo' : 'estado-inactivo';
                var componentesCount = item.COMPONENTE_COUNT || 0;
                var toggleBtn = '<button type="button" class="toggle-btn" onclick="toggleDetail(\'' + item['ID CI'] + '\')">+</button>';
                return '<td>' + htmlEncode(item['NOMBRE CI']) + '</td>' +
                    '<td>' + htmlEncode(item['NOMBRE TIPO CI']) + '</td>' +
                    '<td>' + htmlEncode(item['NRO SERIE']) + '</td>' +
                    '<td>' + htmlEncode(item['FABRICANTE / PROVEEDOR']) + '</td>' +
                    '<td>' + item['MARCA_MODELO_HTML'] + '</td>' +
                    '<td>' + htmlEncode(item['IP']) + '</td>' +
                    '<td>' + htmlEncode(item['GATEWAY']) + '</td>' +
                    '<td>' + htmlEncode(item['GRUPO TRABAJO']) + '</td>' +
                    '<td class="' + estadoClass + '">' + htmlEncode(item['ESTADO CI']) + '</td>' +
                    '<td>' + htmlEncode(item['PROPIETARIO']) + '</td>' +
                    '<td>' + htmlEncode(item['DESCRIPCION CI']) + '</td>' +
                    '<td>' + item['IMPACTO_PRIORIDAD_HTML'] + '</td>' +
                    '<td>' + item['SEDE_LOCAL_HTML'] + '</td>' +
                    '<td>' + htmlEncode(item['AREA']) + '</td>' +
                    '<td>' + htmlEncode(item['NRO PISO']) + '</td>' +
                    '<td>' + htmlEncode(item['NRO AMBIENTE']) + '</td>' +
                    '<td class="text-center">' + toggleBtn + ' <span class="badge bg-secondary">' + componentesCount + '</span></td>';
            }
        };

        function initComponentesGrid() {
            GridUtils.createGrid(componentesGridConfig);
        }

        // Toggle detail row visibility
        function toggleDetail(idCI) {
            var detailRow = document.getElementById('detail-' + idCI);
            if (detailRow) {
                if (detailRow.style.display === 'none' || detailRow.style.display === '') {
                    detailRow.style.display = 'table-row';
                } else {
                    detailRow.style.display = 'none';
                }
            }
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
            var tabla = document.getElementById("tblComponentes");
            var tabla_longitud = (tabla.rows.length) - 1;
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
                            <asp:CheckBox ID="cbnci" runat="server" CssClass="form-check-input" Text="Nombre CI" AutoPostBack="True" OnCheckedChanged="cbnci_CheckedChanged"/>
                        </div>
                        <div class="col-md-3 col-sm-6">
                            <asp:CheckBox ID="cbtci" runat="server" CssClass="form-check-input" Text="Tipo CI" AutoPostBack="True" OnCheckedChanged="cbtci_CheckedChanged"/>
                        </div>
                        <div class="col-md-3 col-sm-6">
                            <asp:CheckBox ID="cbeci" runat="server" CssClass="form-check-input" Text="Estado CI" AutoPostBack="True" OnCheckedChanged="cbeci_CheckedChanged"/>
                        </div>
                        <div class="col-md-3 col-sm-6">
                            <asp:CheckBox ID="cbns" runat="server" CssClass="form-check-input" Text="Nro. Serie" AutoPostBack="True" OnCheckedChanged="cbns_CheckedChanged"/>
                        </div>
                    </div>
                    <div class="row g-3 mt-2">
                        <div class="col-md-3 col-sm-6">
                            <asp:TextBox ID="txtnci" runat="server" CssClass="form-control form-control-modern" MaxLength="25" Autocomplete="off" placeholder="Ingresar Nombre" Enabled="False"></asp:TextBox>
                        </div>
                        <div class="col-md-3 col-sm-6">
                            <asp:DropDownList ID="ddltci" runat="server" CssClass="form-control form-control-modern" AppendDataBoundItems="True" Enabled="False">
                                <asp:ListItem Value="-1">_____SELECCIONE TIPO CI_____</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="col-md-3 col-sm-6">
                            <asp:DropDownList ID="ddleci" runat="server" CssClass="form-control form-control-modern" AppendDataBoundItems="True" Enabled="False">
                                <asp:ListItem Value="-1">_____SELECCIONE ESTADO CI_____</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="col-md-3 col-sm-6">
                            <asp:TextBox ID="txtns" runat="server" CssClass="form-control form-control-modern" MaxLength="25" Autocomplete="off" placeholder="Ingresar Nro Serie CI" Enabled="False"></asp:TextBox>
                        </div>
                    </div>
                    <div class="row g-3 mt-2">
                        <div class="col-md-3 col-sm-6">
                            <asp:CheckBox ID="cbdci" runat="server" CssClass="form-check-input" Text="Descripcion CI" AutoPostBack="True" OnCheckedChanged="cbdci_CheckedChanged"/>
                        </div>
                        <div class="col-md-3 col-sm-6">
                            <asp:CheckBox ID="cbm" runat="server" CssClass="form-check-input" Text="Marca" AutoPostBack="True" OnCheckedChanged="cbm_CheckedChanged"/>
                        </div>
                        <div class="col-md-3 col-sm-6">
                            <asp:CheckBox ID="cbs" runat="server" CssClass="form-check-input" Text="Sede" AutoPostBack="True" OnCheckedChanged="cbs_CheckedChanged"/>
                        </div>
                        <div class="col-md-3 col-sm-6">
                            <asp:CheckBox ID="cbl" runat="server" CssClass="form-check-input" Text="Local" AutoPostBack="True" OnCheckedChanged="cbl_CheckedChanged"/>
                        </div>
                    </div>
                    <div class="row g-3 mt-2">
                        <div class="col-md-3 col-sm-6">
                            <asp:DropDownList ID="ddldci" runat="server" CssClass="form-control form-control-modern" AppendDataBoundItems="True" Enabled="False">
                                <asp:ListItem Value="-1">_____SELECCIONE DESCRIPCION CI_____</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="col-md-3 col-sm-6">
                            <asp:DropDownList ID="ddlm" runat="server" CssClass="form-control form-control-modern" AppendDataBoundItems="True" Enabled="False">
                                <asp:ListItem Value="-1">_____SELECCIONE MARCA_____</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="col-md-3 col-sm-6">
                            <asp:DropDownList ID="ddls" runat="server" CssClass="form-control form-control-modern" AppendDataBoundItems="True" OnSelectedIndexChanged="ddls_SelectedIndexChanged" AutoPostBack="True" Enabled="False">
                                <asp:ListItem Value="-1">_____SELECCIONE SEDE_____</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="col-md-3 col-sm-6">
                            <asp:DropDownList ID="ddll" runat="server" CssClass="form-control form-control-modern" AppendDataBoundItems="True" AutoPostBack="True" OnSelectedIndexChanged="ddll_SelectedIndexChanged" Enabled="False">
                                <asp:ListItem Value="-1">_____SELECCIONE LOCAL_____</asp:ListItem>
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
                            <asp:LinkButton ID="cba" runat="server" CssClass="form-check-input" Text="Area" OnCheckedChanged="cba_CheckedChanged" />
                        </div>
                    </div>
                    <div class="row g-3 mt-3">
                        <div class="col-12 text-center">
                            <asp:LinkButton ID="lbtnBuscar" runat="server" CausesValidation="False" class="btn btn-info btn-modern me-2" Text="Buscar" UseSubmitBehavior="False" OnClick="lbtnBuscar_Click" />
                            <asp:Button ID="btnActualizarInformacion" runat="server" class="btn btn-success btn-modern me-2" Text="Actualizar Informacion" OnClick="btnActualizarInformacion_Click" />
                            <asp:LinkButton ID="IMPRIMIR" runat="server" CausesValidation="False" class="btn btn-info btn-modern" onclick="IMPRIMIR_Click" onclientclick="abrir_ventana_imprimir_reporte(2);">Imprimir reporte</asp:LinkButton>
                        </div>
                    </div>
                </div>
            </div>

            <!-- ========== TABLA ========== -->
            <div class="form-card">
                <div class="card-header">
                    <i class="bi bi-table me-2"></i>Reporte Componentes Asignados
                </div>
                <div class="card-body p-3">
                    <!-- Buscador -->
                    <div class="row mb-3">
                        <div class="col-md-8">
                            <div class="input-group">
                                <span class="input-group-text bg-white border-end-0">
                                    <i class="bi bi-search text-muted"></i>
                                </span>
                                <input type="text" id="txtBuscarComponentes" class="form-control border-start-0" ClientIDMode="Static"
                                       placeholder="Buscar por Nombre CI, Tipo CI, Fabricante, Area..."
                                       onkeyup="filtrarTabla()" />
                                <button class="btn btn-outline-secondary" type="button" onclick="document.getElementById('txtBuscarComponentes').value=''; filtrarTabla();">
                                    <i class="bi bi-x-lg"></i>
                                </button>
                            </div>
                        </div>
                        <div class="col-md-4 text-end">
                            <span id="lblContadorComponentes" class="form-text text-muted"></span>
                        </div>
                    </div>

                    <!-- Tabla HTML -->
                    <div class="table-wrapper" style="max-height: 600px; overflow-y: auto;">
                        <table id="tblComponentes" class="table table-modern table-hover" style="min-width: 1200px;">
                            <thead>
                                <tr>
                                    <th style="width: 8%;">NOMBRE CI</th>
                                    <th style="width: 7%;">TIPO CI</th>
                                    <th style="width: 7%;">NRO SERIE</th>
                                    <th style="width: 8%;">FABRICANTE</th>
                                    <th style="width: 7%;">MARCA/MODELO</th>
                                    <th style="width: 6%;">IP</th>
                                    <th style="width: 6%;">GATEWAY</th>
                                    <th style="width: 6%;">GRUPO TRABAJO</th>
                                    <th style="width: 5%;">ESTADO CI</th>
                                    <th style="width: 7%;">PROPIETARIO</th>
                                    <th style="width: 7%;">DESCRIPCION CI</th>
                                    <th style="width: 6%;">IMPACTO/PRIORIDAD</th>
                                    <th style="width: 6%;">SEDE/LOCAL</th>
                                    <th style="width: 5%;">AREA</th>
                                    <th style="width: 3%;">NRO PISO</th>
                                    <th style="width: 3%;">NRO AMBIENTE</th>
                                    <th style="width: 6%;">COMPONENTES</th>
                                </tr>
                            </thead>
                            <tbody id="tbodyComponentes">
                            </tbody>
                        </table>
                    </div>

                    <!-- Paginacion -->
                    <div class="pagination-wrapper">
                        <ul id="paginationComponentes" class="pagination" style="flex-wrap: wrap;"></ul>
                    </div>
                    <div class="page-info" id="pageInfoComponentes"></div>
                </div>
            </div>

            <!-- Hidden Fields -->
            <asp:HiddenField ID="__pagina" runat="server" />
            <asp:HiddenField ID="__mensaje" runat="server" />
            <asp:HiddenField ID="datosJson" runat="server" EnableViewState="False" ClientIDMode="Static" />
        </div>
    </form>

    <script type="text/javascript">
        if (window.addEventListener) {
            window.addEventListener('load', function() {
                initComponentesGrid();
            }, false);
        } else if (window.attachEvent) {
            window.attachEvent('onload', function() {
                initComponentesGrid();
            });
        }
    </script>
</body>
</html>
