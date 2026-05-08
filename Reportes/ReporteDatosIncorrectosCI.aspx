<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ReporteDatosIncorrectosCI.aspx.cs" Inherits="ElementosConfiguracion" UnobtrusiveValidationMode="None" %>

<%@ Register src="../NavBar.ascx" tagname="NavBar" tagprefix="uc1" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>Reporte Datos Incorrectos CIS</title>

    <!-- Bootstrap 5.3 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet" />
    <!-- Global Styles -->
    <link href="../CssJs/global-styles.css" rel="stylesheet" />

    <style>
        /* Solo estilos especificos adicionales para este reporte */
        .table-modern-grid thead tr th:first-child {
            border-radius: 10px 0 0 10px;
        }

        .table-modern-grid thead tr th:last-child {
            border-radius: 0 10px 10px 0;
        }

        .page-info {
            text-align: center;
            margin-top: 1rem;
            color: #6c757d;
            font-size: 0.9rem;
        }
    </style>

    <script type="text/javascript" src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script type="text/javascript" src="../src/js/utils.js"></script>
    <script type="text/javascript" src="../src/js/grid-utils.js"></script>

    <script lang="javascript" type="text/javascript">
        // Grid configuration for Reporte Datos Incorrectos CI
        var datosIncorrectosGridConfig = {
            tableId: 'tblDatosIncorrectos',
            tbodyId: 'tbodyDatosIncorrectos',
            searchInputId: 'txtBuscar',
            paginationWrapperId: 'paginationDatosIncorrectos',
            pageInfoId: 'pageInfoDatosIncorrectos',
            counterId: 'lblContador',
            dataFieldId: 'datosJson',
            rowsPerPage: 10,
            searchFields: ['AREA', 'TIPO CI', 'DESCRIPCION CI', 'NOMBRE CI', 'FECHA SEGUIMIENTO'],
            columnRenderer: function(item) {
                return '<td>' + htmlEncode(item.AREA) + '</td>' +
                    '<td>' + htmlEncode(item['TIPO CI']) + '</td>' +
                    '<td>' + htmlEncode(item['DESCRIPCION CI']) + '</td>' +
                    '<td>' + htmlEncode(item['NOMBRE CI']) + '</td>' +
                    '<td>' + htmlEncode(item['FECHA SEGUIMIENTO']) + '</td>';
            }
        };

        function initDatosIncorrectosGrid() {
            GridUtils.createGrid(datosIncorrectosGridConfig);
        }

        function abrir_ventana_imprimir_reporte(Opcion) {
            if (Verificar_Datos_tabla(Opcion)) {
                window.name = "Reporte Datos Incorrectos CI";
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
            var gridState = GridUtils.getState('tblDatosIncorrectos');
            var datos = gridState ? gridState.filteredData : [];
            var Ok, Rpta;
            Ok = true;
            Rpta = confirm(Pregunta);
            if (Rpta == 1) {
                if (datos.length === 0) {
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
            <!-- Card Filtros -->
            <div class="form-card">
                <div class="card-header">
                    <i class="bi bi-funnel me-2"></i>Filtros de Busqueda
                </div>
                <div class="card-body p-3">
                    <div class="row g-3 mb-3">
                        <div class="col-md-3">
                            <asp:CheckBox ID="cbfs" runat="server" CssClass="form-check-input position-static" Font-Size="X-Small" Text="Fecha Seguimiento" AutoPostBack="True" OnCheckedChanged="cbfs_CheckedChanged"/>
                        </div>
                        <div class="col-md-3">
                            <asp:CheckBox ID="cbtci" runat="server" CssClass="form-check-input position-static" Font-Size="X-Small" Text="Tipo CI" AutoPostBack="True" OnCheckedChanged="cbtci_CheckedChanged"/>
                        </div>
                        <div class="col-md-3">
                            <asp:CheckBox ID="cbdci" runat="server" CssClass="form-check-input position-static" Font-Size="X-Small" Text="Descripcion CI" AutoPostBack="True" OnCheckedChanged="cbdci_CheckedChanged"/>
                        </div>
                    </div>
                    <div class="row g-3">
                        <div class="col-md-3">
                            <label class="form-label-modern">Fecha Inicio:</label>
                            <asp:TextBox ID="txtFechaInicioSeguimiento" runat="server" class="form-control form-control-modern" placeholder="Ingrese fec. inicio" Enabled="False" />
                            <input id="btnFechaInicioSeguimiento" type="button" value="..." style="height: 25px; width: 25px;" class="btn btn-outline-secondary" />
                        </div>
                        <div class="col-md-3">
                            <label class="form-label-modern">Fecha Fin:</label>
                            <asp:TextBox ID="txtFechaFinSeguimiento" runat="server" class="form-control form-control-modern" placeholder="Ingrese fec. fin" Enabled="False" />
                            <input id="btnFechaFinSeguimineto" type="button" value="..." style="height: 25px; width: 25px;" class="btn btn-outline-secondary" />
                        </div>
                        <div class="col-md-3">
                            <label class="form-label-modern">Tipo CI:</label>
                            <asp:DropDownList ID="ddltci" runat="server" CssClass="form-control form-control-modern" AppendDataBoundItems="True" Enabled="False" OnSelectedIndexChanged="ddltci_SelectedIndexChanged" AutoPostBack="True">
                                <asp:ListItem Value="-1">_____SELECCIONE TIPO CI_____</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="col-md-3">
                            <label class="form-label-modern">Descripcion CI:</label>
                            <asp:DropDownList ID="ddldci" runat="server" CssClass="form-control form-control-modern" AppendDataBoundItems="True" Enabled="False">
                                <asp:ListItem Value="-1">_____SELECCIONE DESCRIPCION CI_____</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div class="row mt-3">
                        <div class="col-12 text-start">
                            <asp:LinkButton ID="lbtnBuscar" runat="server" CausesValidation="False" CssClass="btn btn-info btn-modern" Text="Buscar" UseSubmitBehavior="False" OnClick="lbtnBuscar_Click" />
                            <asp:HyperLink ID="IMPRIMIR" runat="server" BorderStyle="None" CssClass="btn btn-info btn-modern" NavigateUrl="" onClick="abrir_ventana_imprimir_reporte(2);">Imprimir reporte</asp:HyperLink>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Card Lista de Resultados -->
            <div class="form-card">
                <div class="card-header">
                    <i class="bi bi-exclamation-triangle me-2"></i>Lista de CIs con Datos Registrados Incorrectamente
                </div>
                <div class="card-body p-3">
                    <!-- Buscador -->
                    <div class="row mb-3">
                        <div class="col-md-8">
                            <div class="input-group">
                                <span class="input-group-text bg-white border-end-0">
                                    <i class="bi bi-search text-muted"></i>
                                </span>
                                <input type="text" id="txtBuscar" class="form-control border-start-0 search-input" ClientIDMode="Static"
                                       placeholder="Buscar por Area, Tipo CI, Descripcion CI, Nombre CI..." />
                                <button class="btn btn-outline-secondary" type="button" onclick="document.getElementById('txtBuscar').value=''; GridUtils.getState('tblDatosIncorrectos') && GridUtils.refresh('tblDatosIncorrectos');">
                                    <i class="bi bi-x-lg"></i>
                                </button>
                            </div>
                        </div>
                        <div class="col-md-4 text-end">
                            <span id="lblContador" class="form-text text-muted"></span>
                        </div>
                    </div>

                    <!-- Tabla HTML -->
                    <div class="table-wrapper" style="max-height: 500px; overflow-y: auto;">
                        <table id="tblDatosIncorrectos" class="table table-modern-grid table-hover" style="min-width: 900px;">
                            <thead>
                                <tr>
                                    <th>AREA</th>
                                    <th>TIPO CI</th>
                                    <th>DESCRIPCION CI</th>
                                    <th>NOMBRE CI</th>
                                    <th>FECHA SEGUIMIENTO</th>
                                </tr>
                            </thead>
                            <tbody id="tbodyDatosIncorrectos">
                            </tbody>
                        </table>
                    </div>

                    <!-- Paginacion -->
                    <div class="pagination-wrapper">
                        <ul id="paginationDatosIncorrectos" class="pagination" style="flex-wrap: wrap;"></ul>
                    </div>
                    <div class="page-info" id="pageInfoDatosIncorrectos"></div>
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
                initDatosIncorrectosGrid();
            }, false);
        } else if (window.attachEvent) {
            window.attachEvent('onload', function() {
                initDatosIncorrectosGrid();
            });
        }
    </script>

</body>
</html>
