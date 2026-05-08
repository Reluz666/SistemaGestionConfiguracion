<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Reporte_CIS_Relacionados_Con_Otros_CIS.aspx.cs" Inherits="RelacionesElementosConfiguracion" %>

<%@ Register src="../NavBar.ascx" tagname="NavBar" tagprefix="uc1" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>Reporte CIS Relacionados Con Otros CIS</title>

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
            padding: 1.5rem;
            margin-bottom: 1.5rem;
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

        /* ===== SPACER ===== */
        .top-spacer { height: 100px; }

        /* ===== RESPONSIVE ===== */
        @media (max-width: 991px) {
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
        // Grid configuration for CIS Relacionados
        var cisGridConfig = {
            tableId: 'tblCisRelacionados',
            tbodyId: 'tbodyCisRelacionados',
            searchInputId: 'txtBuscarCis',
            paginationWrapperId: 'paginationCisRelacionados',
            pageInfoId: 'pageInfoCis',
            counterId: 'lblContadorCis',
            dataFieldId: 'datosJson',
            rowsPerPage: 10,
            searchFields: ['PADRE CI', 'HIJO CI', 'TIPO RELACION'],
            columnRenderer: function(item, rowIndex) {
                // Rich HTML content for PADRE CI column
                var padreCiHtml = '';
                if (item.PADRE_CI.trim() !== '') {
                    padreCiHtml = '<font color="blue"><b>Nombre: </b>' + htmlEncode(item['PADRE CI']) + '</font> &nbsp;&nbsp; <b>Tipo:</b> ' + htmlEncode(item['PADRE TIPO CI']) + '&nbsp;&nbsp; <b>Nro Serie: </b>' + htmlEncode(item['PADRE NRO SERIE']) + '&nbsp;&nbsp; <b>Direccion IP: </b>' + htmlEncode(item['PADRE IP']) + '&nbsp;&nbsp; <b>Direccion Gateway: </b>' + htmlEncode(item['PADRE GATEWAY']) + '&nbsp;&nbsp; <b>Grupo de Trabajo: </b>' + htmlEncode(item['PADRE GRUPO TRABAJO']) + '&nbsp;&nbsp; <b>Fabricante / Proveedor: </b>' + htmlEncode(item['PADRE FABICANTE / PROVEEDOR']) + '&nbsp;&nbsp; <b>Estado:</b> ' + htmlEncode(item['PADRE ESTADO CI']) + '&nbsp;&nbsp; <b>Propietario:</b> ' + htmlEncode(item['PADRE PROPIETARIO CI']) + '<BR>';
                    padreCiHtml += '<b>Descripcion: </b>' + htmlEncode(item['PADRE DESCRIPCION CI']) + '&nbsp;&nbsp;<b>Prioridad: </b>' + htmlEncode(item['PADRE NIVEL PRIORIDAD']) + '&nbsp;&nbsp;<b>Sede: </b>' + htmlEncode(item['PADRE SEDE']) + '&nbsp;&nbsp;<b>Local: </b>' + htmlEncode(item['PADRE LOCAL']) + '<BR>';
                    padreCiHtml += '<font color="red"><b>Area: </b>' + htmlEncode(item['PADRE AREA']) + '&nbsp;&nbsp;<b>Nro. Piso: </b>' + htmlEncode(item['PADRE NRO PISO']) + '&nbsp;&nbsp;<b>Nro. Ambiente: </b>' + htmlEncode(item['PADRE NRO AMBIENTE']) + '&nbsp;&nbsp;<b>Ubicacion: </b>' + htmlEncode(item['PADRE UBICACION']) + '</font><BR>';
                    padreCiHtml += '<font color="red"><b>Direccion: </b>' + htmlEncode(item['PADRE DIRECCION LOCAL']) + '</font>';
                }

                // Rich HTML content for HIJO CI column
                var hijoCiHtml = '<font color="blue"><b>Nombre: </b>' + htmlEncode(item['HIJO CI']) + '</font>&nbsp;&nbsp; <b>Tipo:</b> ' + htmlEncode(item['HIJO TIPO CI']) + '&nbsp;&nbsp; <b>Nro Serie: </b>' + htmlEncode(item['HIJO NRO SERIE']) + '&nbsp;&nbsp; <b>Direccion IP: </b>' + htmlEncode(item['HIJO IP']) + '&nbsp;&nbsp; <b>Direccion Gateway: </b>' + htmlEncode(item['HIJO GATEWAY']) + '&nbsp;&nbsp; <b>Grupo de Trabajo: </b>' + htmlEncode(item['HIJO GRUPO TRABAJO']) + '&nbsp;&nbsp; <b>Fabricante / Proveedor: </b>' + htmlEncode(item['HIJO FABRICANTE / PROVEEDOR']) + '&nbsp;&nbsp; <b>Estado:</b> ' + htmlEncode(item['HIJO ESTADO CI']) + '&nbsp;&nbsp; <b>Propietario:</b> ' + htmlEncode(item['HIJO PROPIETARIO CI']) + '<BR>';
                hijoCiHtml += '<b>Descripcion: </b>' + htmlEncode(item['HIJO DESCRIPCION CI']) + '&nbsp;&nbsp;<b>Prioridad: </b>' + htmlEncode(item['HIJO NIVEL PRIORIDAD']) + '&nbsp;&nbsp;<b>Sede: </b>' + htmlEncode(item['HIJO SEDE']) + '&nbsp;&nbsp;<b>Local: </b>' + htmlEncode(item['HIJO LOCAL']) + '<BR>';
                hijoCiHtml += '<font color="red"><b>Area: </b>' + htmlEncode(item['HIJO AREA']) + '&nbsp;&nbsp;<b>Nro. Piso: </b>' + htmlEncode(item['HIJO NRO PISO']) + '&nbsp;&nbsp;<b>Nro. Ambiente: </b>' + htmlEncode(item['HIJO NRO AMBIENTE']) + '&nbsp;&nbsp;<b>Ubicacion: </b>' + htmlEncode(item['HIJO UBICACION']) + '</font> <BR>';
                hijoCiHtml += '<font color="red"><b>Direccion: </b>' + htmlEncode(item['HIJO DIRECCION LOCAL']) + '</font>';

                return '<td style="display:none;">' + htmlEncode(item.ID_RELACION) + '</td>' +
                    '<td style="display:none;">' + htmlEncode(item['PADRE ID']) + '</td>' +
                    '<td>' + padreCiHtml + '</td>' +
                    '<td style="display:none;">' + htmlEncode(item['HIJO ID']) + '</td>' +
                    '<td>' + hijoCiHtml + '</td>' +
                    '<td>' + htmlEncode(item['TIPO RELACION']) + '</td>';
            }
        };

        function initCisGrid() {
            GridUtils.createGrid(cisGridConfig);
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
            <!-- Filtros de Busqueda -->
            <div class="form-card">
                <div class="card-header">
                    <i class="bi bi-funnel me-2"></i>Filtros de Busqueda
                </div>
                <div class="card-body p-3">
                    <div class="row g-3">
                        <div class="col-md-4">
                            <div class="form-check">
                                <asp:CheckBox ID="cbnci" runat="server" CssClass="form-check-input" Text="Nombre CI" AutoPostBack="True" OnCheckedChanged="cbnci_CheckedChanged"/>
                            </div>
                            <asp:TextBox ID="txtnci" runat="server" CssClass="form-control form-control-modern mt-1" MaxLength="25" Autocomplete="off" placeholder="Ingresar Nombre" Enabled="False" />
                        </div>
                        <div class="col-md-4">
                            <div class="form-check">
                                <asp:CheckBox ID="cbtci" runat="server" CssClass="form-check-input" Text="Tipo CI" AutoPostBack="True" OnCheckedChanged="cbtci_CheckedChanged"/>
                            </div>
                            <asp:DropDownList ID="ddltci" runat="server" CssClass="form-control form-control-modern mt-1" AppendDataBoundItems="True" Enabled="False">
                                <asp:ListItem Value="-1">_____SELECCIONE TIPO CI_____</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="col-md-4">
                            <div class="form-check">
                                <asp:CheckBox ID="cbeci" runat="server" CssClass="form-check-input" Text="Estado CI" AutoPostBack="True" OnCheckedChanged="cbeci_CheckedChanged"/>
                            </div>
                            <asp:DropDownList ID="ddleci" runat="server" CssClass="form-control form-control-modern mt-1" AppendDataBoundItems="True" Enabled="False">
                                <asp:ListItem Value="-1">_____SELECCIONE ESTADO CI_____</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div class="row g-3 mt-2">
                        <div class="col-md-4">
                            <div class="form-check">
                                <asp:CheckBox ID="cbpci" runat="server" CssClass="form-check-input" Text="Propietario CI" AutoPostBack="True" OnCheckedChanged="cbpci_CheckedChanged"/>
                            </div>
                            <asp:TextBox ID="txtpci" runat="server" CssClass="form-control form-control-modern mt-1" MaxLength="25" Autocomplete="off" placeholder="Ingresar Propietario" Enabled="False" />
                        </div>
                        <div class="col-md-4">
                            <div class="form-check">
                                <asp:CheckBox ID="cbdci" runat="server" CssClass="form-check-input" Text="Descripcion CI" AutoPostBack="True" OnCheckedChanged="cbdci_CheckedChanged"/>
                            </div>
                            <asp:DropDownList ID="ddldci" runat="server" CssClass="form-control form-control-modern mt-1" AppendDataBoundItems="True" Enabled="False">
                                <asp:ListItem Value="-1">_____SELECCIONE DESCRIPCION CI_____</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="col-md-4">
                            <div class="form-check">
                                <asp:CheckBox ID="cbs" runat="server" CssClass="form-check-input" Text="Sede" AutoPostBack="True" OnCheckedChanged="cbs_CheckedChanged"/>
                            </div>
                            <asp:DropDownList ID="ddls" runat="server" CssClass="form-control form-control-modern mt-1" AppendDataBoundItems="True" AutoPostBack="True" Enabled="False" OnSelectedIndexChanged="ddls_SelectedIndexChanged">
                                <asp:ListItem Value="-1">_____SELECCIONE SEDE_____</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div class="row g-3 mt-2">
                        <div class="col-md-4">
                            <div class="form-check">
                                <asp:CheckBox ID="cbl" runat="server" CssClass="form-check-input" Text="Local" AutoPostBack="True" OnCheckedChanged="cbl_CheckedChanged1"/>
                            </div>
                            <asp:DropDownList ID="ddll" runat="server" CssClass="form-control form-control-modern mt-1" AppendDataBoundItems="True" AutoPostBack="True" Enabled="False" OnSelectedIndexChanged="ddll_SelectedIndexChanged">
                                <asp:ListItem Value="-1">_____SELECCIONE LOCAL_____</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="col-md-4">
                            <div class="form-check">
                                <asp:CheckBox ID="cba" runat="server" CssClass="form-check-input" Text="Area" AutoPostBack="True" OnCheckedChanged="cba_CheckedChanged"/>
                            </div>
                            <asp:DropDownList ID="ddla" runat="server" CssClass="form-control form-control-modern mt-1" AppendDataBoundItems="True" Enabled="False">
                                <asp:ListItem Value="-1">_____SELECCIONE AREA_____</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="col-md-4 d-flex align-items-end">
                            <div class="d-flex flex-wrap gap-2">
                                <asp:LinkButton ID="lbtnBuscar" runat="server" CausesValidation="False" CssClass="btn btn-info btn-modern" OnClick="lbtnBuscar_Click" Text="Buscar" UseSubmitBehavior="False" />
                                <asp:Button ID="btnActualizarInformacion" runat="server" CssClass="btn btn-warning btn-modern" OnClick="btnActualizarInformacion_Click" Text="Mostrar Todos" />
                                <asp:HyperLink ID="IMPRIMIR" runat="server" BorderStyle="None" CssClass="btn btn-info btn-modern ms-2" NavigateUrl="" onClick="return abrir_ventana_imprimir_reporte(2);">Imprimir reporte</asp:HyperLink>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Tabla de Resultados -->
            <div class="form-card">
                <div class="card-header">
                    <i class="bi bi-diagram-3 me-2"></i>Relaciones de Elementos de Configuracion
                </div>
                <div class="card-body p-3">
                    <!-- Buscador -->
                    <div class="row mb-3">
                        <div class="col-md-8">
                            <div class="input-group">
                                <span class="input-group-text bg-white border-end-0">
                                    <i class="bi bi-search text-muted"></i>
                                </span>
                                <input type="text" id="txtBuscarCis" class="form-control border-start-0 search-input" ClientIDMode="Static"
                                       placeholder="Buscar por PADRE CI, HIJO CI, TIPO RELACION..."
                                       onkeyup="filtrarTablaCis()" />
                                <button class="btn btn-outline-secondary" type="button" onclick="document.getElementById('txtBuscarCis').value=''; filtrarTablaCis();">
                                    <i class="bi bi-x-lg"></i>
                                </button>
                            </div>
                        </div>
                        <div class="col-md-4 text-end">
                            <span id="lblContadorCis" class="form-text text-muted"></span>
                        </div>
                    </div>

                    <!-- Tabla HTML -->
                    <div class="table-wrapper" style="max-height: 500px; overflow-y: auto;">
                        <table id="tblCisRelacionados" class="table table-modern table-hover" style="min-width: 1000px;">
                            <thead>
                                <tr>
                                    <th style="display:none;">ID_RELACION</th>
                                    <th style="display:none;">PADRE_ID</th>
                                    <th style="width: 200px;">PADRE ELEMENTO CONFIGURACION</th>
                                    <th style="display:none;">HIJO_ID</th>
                                    <th style="width: 200px;">HIJO ELEMENTO CONFIGURACION</th>
                                    <th style="width: 100px;">TIPO RELACION</th>
                                </tr>
                            </thead>
                            <tbody id="tbodyCisRelacionados">
                            </tbody>
                        </table>
                    </div>

                    <!-- Paginacion -->
                    <div class="pagination-wrapper">
                        <ul id="paginationCisRelacionados" class="pagination" style="flex-wrap: wrap;"></ul>
                    </div>
                    <div class="page-info" id="pageInfoCis"></div>
                </div>
            </div>

            <!-- Estadisticas -->
            <div class="form-card">
                <div class="card-body p-3">
                    <asp:Label ID="T" runat="server" style="font-weight: 700; display: block; margin-bottom: 0.5rem;"></asp:Label>
                    <asp:Label ID="A" runat="server" style="font-weight: 700; display: block; margin-bottom: 0.5rem;"></asp:Label>
                    <asp:Label ID="X" runat="server" style="font-weight: 700; display: block;"></asp:Label>
                </div>
            </div>

            <!-- Hidden Fields -->
            <asp:HiddenField ID="__pagina" runat="server" />
            <asp:HiddenField ID="__mensaje" runat="server" />
            <asp:HiddenField ID="datosJson" runat="server" EnableViewState="False" ClientIDMode="Static" />
        </div>
    </form>

    <script type="text/javascript" src="Otros_css_js/resaltar.js"></script>

    <script type="text/javascript">
        if (window.addEventListener) {
            window.addEventListener('load', function() {
                initCisGrid();
            }, false);
        } else if (window.attachEvent) {
            window.attachEvent('onload', function() {
                initCisGrid();
            });
        }
    </script>
</body>
</html>
