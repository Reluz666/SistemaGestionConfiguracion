<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ReporteCIsSeguidos.aspx.cs" Inherits="ReporteCIsSeguidos" UnobtrusiveValidationMode="None" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <title>Reporte de CIS Seguidos</title>

    <!-- Bootstrap 5.3 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet"/>
    <!-- Global Styles -->
    <link href="../CssJs/global-styles.css" rel="stylesheet"/>
    <!-- Local Bootstrap for navbar-custom -->
    <link href="../bootstrap/css/bootstrap.min.css" rel="stylesheet"/>

    <style>
        .table-modern {
            border-collapse: separate !important;
            border-spacing: 0;
            width: 100%;
            min-width: 1100px;
        }

        .table-modern thead tr th {
            background: linear-gradient(135deg, #1a1a2e 0%, #16213e 100%);
            color: #fff;
            font-weight: 600;
            font-size: 0.75rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            padding: 0.6rem 0.5rem !important;
            border: none !important;
            white-space: nowrap;
        }

        .table-modern tbody tr:hover td {
            background: rgba(233, 69, 96, 0.04) !important;
        }

        .table-modern tbody tr td {
            padding: 0.5rem 0.45rem !important;
            border: none !important;
            border-bottom: 1px solid #f1f1f1 !important;
            vertical-align: middle;
            font-size: 0.8rem;
            color: #2d3436;
        }

        .table-modern tfoot tr td {
            padding: 0.5rem 0.45rem !important;
            border: none !important;
            font-weight: 600;
            background: #f8f9fa;
            font-size: 0.8rem;
        }

        .table-modern tfoot tr:first-child td {
            border-top: 2px solid #dee2e6 !important;
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

        .text-high { color: #198754; font-weight: 600; }
        .text-medium { color: #ffc107; font-weight: 600; }
        .text-low { color: #dc3545; font-weight: 600; }

        .table-wrapper {
            max-height: 450px;
            overflow-y: auto;
        }
    </style>

    <script type="text/javascript" src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script type="text/javascript" src="../src/js/utils.js"></script>
    <script type="text/javascript" src="../src/js/grid-utils.js"></script>

    <script lang="javascript" type="text/javascript">
        // Grid configuration for ReporteCIsSeguidos
        var cisSeguidosGridConfig = {
            tableId: 'tblCIsSeguidos',
            tbodyId: 'tbodyCIsSeguidos',
            searchInputId: 'txtBuscar',
            paginationWrapperId: 'paginationWrapper',
            pageInfoId: 'pageInfo',
            counterId: 'lblContador',
            dataFieldId: 'datosJson',
            rowsPerPage: 10,
            searchFields: ['AREA', 'NRO_PISO', 'NRO_AMBIENTE', 'TIPO_CI', 'DESCRIPCION_CI', 'NOMBRE_CI', 'ESTADO_ACTUAL', 'OBSERVACION', 'FECHA_SEGUIMIENTO'],
            columnRenderer: function(item) {
                var pisoAmbiente = item.NRO_PISO || '';
                if (item.NRO_AMBIENTE && item.NRO_AMBIENTE !== '') {
                    pisoAmbiente = '<span class="text-high">' + htmlEncode(item.NRO_PISO) + '</span> / <span class="text-low">' + htmlEncode(item.NRO_AMBIENTE) + '</span>';
                }
                return '<td>' + htmlEncode(item.AREA) + '</td>' +
                    '<td>' + pisoAmbiente + '</td>' +
                    '<td>' + htmlEncode(item.TIPO_CI) + '</td>' +
                    '<td>' + htmlEncode(item.DESCRIPCION_CI) + '</td>' +
                    '<td>' + htmlEncode(item.NOMBRE_CI) + '</td>' +
                    '<td>' + htmlEncode(item.ESTADO_ACTUAL) + '</td>' +
                    '<td>' + htmlEncode(item.OBSERVACION) + '</td>' +
                    '<td>' + htmlEncode(item.FECHA_SEGUIMIENTO) + '</td>';
            }
        };

        function initGrid() {
            GridUtils.createGrid(cisSeguidosGridConfig);
        }

        function abrir_ventana_imprimir_reporte() {
            window.name = "ReporteCIsSeguidos";
            var options = 'channelmode=1,directories=0,fullscreen=0,location=0,menubar=0,resizable=no,titlebar=0,toolbar=0,edge=Raised,status=no,scrollbars=1,width=1000,height=500,top=70px,left=175px';
            window.open('Reporte.aspx', '', options);
        }

        if (window.addEventListener) {
            window.addEventListener('load', initGrid, false);
        } else if (window.attachEvent) {
            window.attachEvent('onload', initGrid);
        }
    </script>
</head>
<body onload="MostrarMensaje()">
    <nav class="navbar navbar-custom navbar-fixed-top" role="navigation">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
                <span class="sr-only">Desplegar navegacion</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="../menu.aspx"><span class="glyphicon glyphicon-home"></span>&nbsp;Inicio</a>
        </div>
        <div class="collapse navbar-collapse navbar-ex1-collapse">
            <ul class="nav navbar-nav">
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown"><span class="glyphicon glyphicon-briefcase"></span>&nbsp;Mantenimiento <b class="caret"></b></a>
                    <ul class="dropdown-menu">
                        <li><a href="Personal.aspx" runat="server" id="trabajadores_aspx">Personal</a></li>
                        <li class="dropdown-submenu"><a href="#">Tablas Institucion</a><ul class="dropdown-menu"><li><a href="Sede.aspx" runat="server" id="a4">Sede</a></li><li><a href="Local.aspx" runat="server" id="A5">Local</a></li><li><a href="Area.aspx" runat="server" id="A6">Area</a></li><li><a href="Dependencia.aspx" runat="server" id="A8">Dependencia</a></li></ul></li>
                        <li class="dropdown-submenu"><a href="#">Tablas Personal</a><ul class="dropdown-menu"><li><a href="Cargo.aspx" runat="server" id="area_trabajo_aspx">Cargo</a></li><li><a href="ProfecionOcupacion.aspx" runat="server" id="Sub_Area_aspx">Profecion - Ocupacion</a></li></ul></li>
                        <li class="divider"></li>
                        <li class="dropdown-submenu"><a href="#">Tablas Elemento Configuracion</a><ul class="dropdown-menu"><li><a href="Modelo.aspx" runat="server" id="A14">Modelo</a></li><li><a href="Marca.aspx" runat="server" id="A13">Marca</a></li><li><a href="DescripcionElementoConfiguracion.aspx" runat="server" id="A9">Descripcion Elemento Configuracion</a></li><li><a href="TiposElementoConfiguracion.aspx" runat="server" id="A10">Tipos Elemento Configuracion</a></li><li><a href="TipoRelacionElementoConfiguracion.aspx" runat="server" id="A11">Tipo Relaci&oacute;n Elemento Configuracion</a></li><li><a href="TipoComponeneteCI.aspx" runat="server" id="A12">Tipo Componenete Elemento Configuracion</a></li><li><a href="EstadoActualCI.aspx" runat="server" id="A15">Estado Actual Elemento Configuracion</a></li></ul></li>
                    </ul>
                </li>
            </ul>
            <ul class="nav navbar-nav">
                <li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown" style="color: white"><span class="glyphicon glyphicon-user"></span>&nbsp;Gestion de Configuracion <b class="caret"></b></a><ul class="dropdown-menu"><li><a href="ElementosConfiguracion.aspx" runat="server" id="ElementosConfiguracion_aspx">Elementos de Configuracio&oacute;n</a></li><li><a href="RelacionesElementosConfiguracion.aspx" runat="server" id="PrendaMovimientos_aspx">Relacio&oacute;n de Elementos de Configuracio&oacute;n</a></li><li class="divider"></li><li><a href="CIsAsignarComponenetes.aspx" runat="server" id="A3">Asignar Componentes Elementos de Configuracion</a></li><li class="divider"></li><li><a href="LicenciasElementoConfiguracion.aspx" runat="server" id="A1">Licencias de Elementos de Configuracion</a></li><li class="divider"></li><li><a href="SeguimientosElementoConfiguracion.aspx" runat="server" id="_Asistencias_aspx">Seguimiento de Elementos de Configuracion</a></li></ul></li>
            </ul>
            <ul class="nav navbar-nav">
                <li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown"><span class="glyphicon glyphicon-file"></span>&nbsp;Reportes <b class="caret"></b></a><ul class="dropdown-menu"><li><a href="../Reportes/ReporteElementosConfiguracion.aspx" runat="server" id="A16">Reporte de Elementos de Configuracion</a></li><li><a href="../Reportes/ReporteRelacionesElementosConfiguracion.aspx" runat="server" id="A17">Reporte de Relaciones de Elementos de Configuracion</a></li><li><a href="../Reportes/ReporteSeguimientosElementoConfiguracion.aspx" runat="server" id="A18">Reporte de Seguimientos de Elementos de Configuracion</a></li><li><a href="../Reportes/ReporteLicenciasElementoConfiguracion.aspx" runat="server" id="A19">Reporte de Licencias de Elementos de Configuracion</a></li><li><a href="../Reportes/ReporteCIsSeguidos.aspx" runat="server" id="A24">Reporte de Elementos de Configuracion Seguidos</a></li><li><a href="../Reportes/ReporteComponentesAsignados.aspx" runat="server" id="A20">Reporte de Componentes de Elementos de Configuracion Asignados</a></li><li class="divider"></li><li><a href="../Reportes/ReporteDatosCorrectosCI.aspx" runat="server" id="A21">Reporte de Datos Correctos de Elementos de Configuracion</a></li><li><a href="../Reportes/ReporteDatosIncorrectosCI.aspx" runat="server" id="A22">Reporte de Datos Incorrectos de Elementos de Configuracion</a></li><li><a href="../Reportes/ReporteCIsInformacionContenidaEnCMDB.aspx" runat="server" id="A23">Reporte de Informacion de Elementos de Configuracion Contenidas en la CMDB</a></li></ul></li>
            </ul>
            <ul class="nav navbar-nav"><li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown" style="color: black"><span class="glyphicon glyphicon-wrench"></span>&nbsp;Configuraciones <b class="caret"></b></a><ul class="dropdown-menu"><li><a href="Usuario.aspx" runat="server" id="usuarios_aspx">Usuarios</a></li><li><a href="../Configuracion/Usuarios.aspx" runat="server" id="permisos_aspx">Permisos</a></li><li class="divider"></li><li><a href="CerrarSession.aspx" style="text-align: left; color: red;">Cerrar Sesion</a></li></ul></li></ul>
        </div>
    </nav>

    <form id="form1" runat="server">
        <div class="container" style="margin-top: 80px;">
            <div class="form-card">
                <div class="card-header">
                    <i class="bi bi-people me-2"></i>Reporte de CIs Seguidos
                </div>
                <div class="card-body p-3">
                    <div class="row mb-3">
                        <div class="col-md-8">
                            <div class="input-group">
                                <span class="input-group-text bg-white border-end-0">
                                    <i class="bi bi-search text-muted"></i>
                                </span>
                                <input type="text" id="txtBuscar" class="form-control border-start-0 search-input" ClientIDMode="Static"
                                       placeholder="Buscar por Area, Tipo CI, Descripcion CI, Nombre CI, Estado..." />
                                <button class="btn btn-outline-secondary" type="button" onclick="document.getElementById('txtBuscar').value=''; GridUtils.getState('tblCIsSeguidos') && GridUtils.refresh('tblCIsSeguidos');">
                                    <i class="bi bi-x-lg"></i>
                                </button>
                            </div>
                        </div>
                        <div class="col-md-4 text-end">
                            <span id="lblContador" class="form-text text-muted"></span>
                        </div>
                    </div>

                    <div class="table-wrapper">
                        <table id="tblCIsSeguidos" class="table table-modern table-hover" style="min-width: 1100px;">
                            <thead>
                                <tr>
                                    <th style="width: 120px;">AREA</th>
                                    <th style="width: 100px;">NRO PISO<br/>NRO AMBIENTE</th>
                                    <th style="width: 120px;">TIPO CI</th>
                                    <th style="width: 150px;">DESCRIPCION CI</th>
                                    <th style="width: 150px;">NOMBRE CI</th>
                                    <th style="width: 100px;">ESTADO ACTUAL</th>
                                    <th style="width: 120px;">OBSERVACION</th>
                                    <th style="width: 100px;">FECHA SEGUIMIENTO</th>
                                </tr>
                            </thead>
                            <tbody id="tbodyCIsSeguidos">
                            </tbody>
                            <tfoot id="tfootStats" style="display: none;">
                                <tr>
                                    <td colspan="8" id="statsContent"></td>
                                </tr>
                            </tfoot>
                        </table>
                    </div>

                    <div class="pagination-wrapper">
                        <ul id="paginationWrapper" class="pagination" style="flex-wrap: wrap;"></ul>
                    </div>
                    <div class="page-info" id="pageInfo"></div>

                    <div class="text-end mt-3">
                        <asp:HyperLink ID="IMPRIMIR" runat="server" BorderStyle="None" class="btn btn-info btn-modern" NavigateUrl="" onclick="abrir_ventana_imprimir_reporte();">
                            <i class="bi bi-printer"></i> Imprimir reporte
                        </asp:HyperLink>
                    </div>
                </div>
            </div>
        </div>

        <asp:HiddenField ID="__mensaje" runat="server" />
        <asp:HiddenField ID="__pagina" runat="server" />
        <asp:HiddenField ID="datosJson" runat="server" EnableViewState="False" ClientIDMode="Static" />
        <asp:HiddenField ID="datosStatsJson" runat="server" EnableViewState="False" ClientIDMode="Static" />
    </form>

</body>
</html>
