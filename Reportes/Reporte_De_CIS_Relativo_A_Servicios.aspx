<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Reporte_De_CIS_Relativo_A_Servicios.aspx.cs" Inherits="RelacionesElementosConfiguracion" %>

<%@ Register src="../NavBar.ascx" tagname="NavBar" tagprefix="uc1" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>Reporte De Elementos De Configuracion Relativo A Servicios</title>

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

        /* ===== STATS ===== */
        .stats-label {
            font-weight: 700;
            font-size: 0.85rem;
            color: #2d3436;
            margin-bottom: 0.5rem;
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
        // Grid configuration for CIS Relativo a Servicios
        var cisRelativoGridConfig = {
            tableId: 'tblCISRelativo',
            tbodyId: 'tbodyCISRelativo',
            searchInputId: 'txtBuscarCISRelativo',
            paginationWrapperId: 'paginationCISRelativo',
            pageInfoId: 'pageInfoCISRelativo',
            counterId: 'lblContadorCISRelativo',
            dataFieldId: 'datosJson',
            rowsPerPage: 10,
            searchFields: ['PADRE CI', 'HIJO CI', 'TIPO RELACION', 'PADRE AREA', 'HIJO AREA'],
            columnRenderer: function(item) {
                var padreCIHtml = item.PADRE_CI_HTML || item['PADRE CI'];
                var hijoCIHtml = item.HIJO_CI_HTML || item['HIJO CI'];
                return '<td>' + padreCIHtml + '</td>' +
                    '<td>' + hijoCIHtml + '</td>' +
                    '<td>' + htmlEncode(item['TIPO RELACION']) + '</td>';
            }
        };

        function initCISRelativoGrid() {
            GridUtils.createGrid(cisRelativoGridConfig);
        }

        function abrir_ventana_imprimir_reporte(Opcion) {
            if (Verificar_Datos_tabla(Opcion)) {
                window.name = "Lista de Personal";
                var options = 'channelmode=1,directories=0,fullscreen=0,location=0,menubar=0,resizable=no,titlebar=0,toolbar=0,edge=Raised,status=no,scrollbars=1,width=1000,height=500,top=70px, left=175px';
                window.open('../Reportes/Reporte.aspx', '', options);
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
            var tabla = document.getElementById("tblCISRelativo");
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

    <!-- ========== NAVBAR ========== -->
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
                            <asp:CheckBox ID="cbpci" runat="server" CssClass="form-check-input" Text="Propietario CI" AutoPostBack="True" OnCheckedChanged="cbpci_CheckedChanged"/>
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
                            <asp:TextBox ID="txtpci" runat="server" CssClass="form-control form-control-modern" MaxLength="25" Autocomplete="off" placeholder="Ingresar Propietario" Enabled="False"></asp:TextBox>
                        </div>
                    </div>
                    <div class="row g-3 mt-2">
                        <div class="col-md-3 col-sm-6">
                            <asp:CheckBox ID="cbdci" runat="server" CssClass="form-check-input" Text="Descripcion CI" AutoPostBack="True" OnCheckedChanged="cbdci_CheckedChanged"/>
                        </div>
                        <div class="col-md-3 col-sm-6">
                            <asp:CheckBox ID="cbs" runat="server" CssClass="form-check-input" Text="Sede" AutoPostBack="True" OnCheckedChanged="cbs_CheckedChanged" />
                        </div>
                        <div class="col-md-3 col-sm-6">
                            <asp:CheckBox ID="cbl" runat="server" CssClass="form-check-input" Text="Local" AutoPostBack="True" OnCheckedChanged="cbl_CheckedChanged1" />
                        </div>
                        <div class="col-md-3 col-sm-6">
                            <asp:CheckBox ID="cba" runat="server" CssClass="form-check-input" Text="Area" OnCheckedChanged="cba_CheckedChanged" />
                        </div>
                    </div>
                    <div class="row g-3 mt-2">
                        <div class="col-md-3 col-sm-6">
                            <asp:DropDownList ID="ddldci" runat="server" CssClass="form-control form-control-modern" AppendDataBoundItems="True" Enabled="False">
                                <asp:ListItem Value="-1">_____SELECCIONE DESCRIPCION CI_____</asp:ListItem>
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
                        <div class="col-md-3 col-sm-6">
                            <asp:DropDownList ID="ddla" runat="server" CssClass="form-control form-control-modern" AppendDataBoundItems="True" Enabled="False">
                                <asp:ListItem Value="-1">_____SELECCIONE AREA_____</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div class="row g-3 mt-3">
                        <div class="col-12 text-center">
                            <asp:LinkButton ID="lbtnBuscar" runat="server" CausesValidation="False" class="btn btn-info btn-modern me-2" Text="Buscar" UseSubmitBehavior="False" OnClick="lbtnBuscar_Click" />
                            <asp:Button ID="btnActualizarInformacion" runat="server" class="btn btn-success btn-modern me-2" Text="Actualizar Informacion" OnClick="btnActualizarInformacion_Click" />
                            <asp:HyperLink ID="IMPRIMIR" runat="server" BorderStyle="None" class="btn btn-info btn-modern" NavigateUrl="" onClick="abrir_ventana_imprimir_reporte(2);">Imprimir reporte</asp:HyperLink>
                        </div>
                    </div>
                </div>
            </div>

            <!-- ========== ESTADISTICAS ========== -->
            <div class="form-card">
                <div class="stats-label">
                    <asp:Label ID="T" runat="server"></asp:Label><br />
                    <asp:Label ID="A" runat="server"></asp:Label><br />
                    <asp:Label ID="X" runat="server"></asp:Label>
                </div>
            </div>

            <!-- ========== TABLA ========== -->
            <div class="form-card">
                <div class="card-header">
                    <i class="bi bi-table me-2"></i>Reporte De Elementos De Configuracion Relativo A Servicios
                </div>
                <div class="card-body p-3">
                    <!-- Buscador -->
                    <div class="row mb-3">
                        <div class="col-md-8">
                            <div class="input-group">
                                <span class="input-group-text bg-white border-end-0">
                                    <i class="bi bi-search text-muted"></i>
                                </span>
                                <input type="text" id="txtBuscarCISRelativo" class="form-control border-start-0" ClientIDMode="Static"
                                       placeholder="Buscar por Padre CI, Hijo CI, Tipo Relacion..."
                                       onkeyup="filtrarTabla()" />
                                <button class="btn btn-outline-secondary" type="button" onclick="document.getElementById('txtBuscarCISRelativo').value=''; filtrarTabla();">
                                    <i class="bi bi-x-lg"></i>
                                </button>
                            </div>
                        </div>
                        <div class="col-md-4 text-end">
                            <span id="lblContadorCISRelativo" class="form-text text-muted"></span>
                        </div>
                    </div>

                    <!-- Tabla HTML -->
                    <div class="table-wrapper" style="max-height: 500px; overflow-y: auto;">
                        <table id="tblCISRelativo" class="table table-modern table-hover" style="min-width: 1000px;">
                            <thead>
                                <tr>
                                    <th style="width: 35%;">PADRE ELEMENTO CONFIGURACION</th>
                                    <th style="width: 35%;">HIJO ELEMENTO CONFIGURACION</th>
                                    <th style="width: 30%;">TIPO RELACION</th>
                                </tr>
                            </thead>
                            <tbody id="tbodyCISRelativo">
                            </tbody>
                        </table>
                    </div>

                    <!-- Paginacion -->
                    <div class="pagination-wrapper">
                        <ul id="paginationCISRelativo" class="pagination" style="flex-wrap: wrap;"></ul>
                    </div>
                    <div class="page-info" id="pageInfoCISRelativo"></div>
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
                initCISRelativoGrid();
            }, false);
        } else if (window.attachEvent) {
            window.attachEvent('onload', function() {
                initCISRelativoGrid();
            });
        }
    </script>
</body>
</html>
