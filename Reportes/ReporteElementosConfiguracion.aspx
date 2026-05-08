<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ReporteElementosConfiguracion.aspx.cs" Inherits="ReporteElementosConfiguracion" UnobtrusiveValidationMode="None" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>Reporte de Elementos de Configuracion</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet" />
    <link href="../bootstrap/css/bootstrap.min.css" rel="stylesheet" />
    <link href="../CssJs/global-styles.css" rel="stylesheet" />

    <style>
        .top-spacer { height: 100px; }
        .table-wrapper {
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 4px 25px rgba(0,0,0,0.08);
            padding: 1.5rem;
            border: 1px solid rgba(0,0,0,0.05);
            overflow-x: auto;
        }
        .table-modern thead th {
            background: linear-gradient(135deg, #1a1a2e 0%, #16213e 100%);
            color: #fff;
            font-weight: 600;
            font-size: 0.65rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            padding: 0.5rem 0.4rem !important;
            border: none !important;
            white-space: nowrap;
        }
        .table-modern tbody td {
            padding: 0.45rem 0.4rem !important;
            border: none;
            border-bottom: 1px solid #f1f1f1;
            vertical-align: middle;
            font-size: 0.75rem;
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
        .color-blue { color: #0066cc; }
        .color-red { color: #cc0000; }
        .fw-bold { font-weight: 700; }
        .btn-imprimir {
            background: #0d6efd;
            color: #fff;
            border: none;
            padding: 0.6rem 1.5rem;
            border-radius: 10px;
            font-weight: 600;
            cursor: pointer;
        }
        .btn-imprimir:hover {
            background: #0b5ed7;
        }
        @media (max-width: 991px) {
            .table-wrapper { padding: 1rem; }
        }
    </style>

    <script type="text/javascript" src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script type="text/javascript" src="../src/js/utils.js"></script>
    <script type="text/javascript" src="../src/js/grid-utils.js"></script>

    <script lang="javascript" type="text/javascript">
        // Grid configuration for Elementos Report
        var elementosGridConfig = {
            tableId: 'tblElementos',
            tbodyId: 'tbodyElementos',
            searchInputId: 'txtBusqueda',
            paginationWrapperId: 'paginationElementos',
            pageInfoId: 'pageInfoElementos',
            counterId: 'lblTotal',
            dataFieldId: 'datosJson',
            rowsPerPage: 10,
            searchFields: ['NOMBRE_CI', 'NOMBRE_TIPO_CI', 'ESTADO_CI', 'PROPIETARIO', 'DESCRIPCION_CI', 'SEDE', 'LOCAL', 'AREA', 'RESPONSABLE'],
            columnRenderer: function(item) {
                var estadoColor = item['ESTADO CI'] === 'ACTIVO' ? 'color-blue' : 'color-red';
                return '<td>' + htmlEncode(item['NOMBRE CI']) + '</td>' +
                    '<td>' + htmlEncode(item['NOMBRE TIPO CI']) + '</td>' +
                    '<td>' + htmlEncode(item['NRO SERIE']) + '</td>' +
                    '<td>' + htmlEncode(item['FABRICANTE / PROVEEDOR']) + '</td>' +
                    '<td><span class="color-blue">' + htmlEncode(item['MARCA']) + '</span> / <span class="color-red">' + htmlEncode(item['MODELO']) + '</span></td>' +
                    '<td>' + htmlEncode(item['IP']) + '</td>' +
                    '<td>' + htmlEncode(item['GATEWAY']) + '</td>' +
                    '<td>' + htmlEncode(item['GRUPO TRABAJO']) + '</td>' +
                    '<td class="' + estadoColor + '">' + htmlEncode(item['ESTADO CI']) + '</td>' +
                    '<td>' + htmlEncode(item['PROPIETARIO']) + '</td>' +
                    '<td>' + htmlEncode(item['DESCRIPCION CI']) + '</td>' +
                    '<td>' + htmlEncode(item['IMPACTO CI']) + ' / ' + htmlEncode(item['NIVEL PRIORIDAD']) + '</td>' +
                    '<td><span class="color-blue">' + htmlEncode(item['SEDE']) + '</span> / <span class="color-red">' + htmlEncode(item['LOCAL']) + '</span></td>' +
                    '<td>' + htmlEncode(item['AREA']) + '</td>' +
                    '<td><span class="color-blue">' + htmlEncode(item['NRO PISO']) + '</span> / <span class="color-red">' + htmlEncode(item['NRO AMBIENTE']) + '</span></td>' +
                    '<td>' + htmlEncode(item['FEC. CREACION CI']) + '</td>' +
                    '<td>' + htmlEncode(item['RESPONSABLE']) + '</td>';
            }
        };

        function initElementosGrid() {
            GridUtils.createGrid(elementosGridConfig);
        }

        function abrir_ventana_imprimir_reporte() {
            var tabla = document.getElementById("tblElementos");
            if (!tabla) return false;
            var tabla_longitud = tabla.rows.length - 1;
            if (tabla_longitud == 0) {
                alert("No hay datos para imprimir el reporte.");
                return false;
            }
            if (confirm("¿Desea imprimir el reporte?")) {
                window.name = "Lista de Elementos";
                var options = 'channelmode=1,directories=0,fullscreen=0,location=0,menubar=0,resizable=no,titlebar=0,toolbar=0,edge=Raised,status=no,scrollbars=1,width=1000,height=500,top=70px, left=175px';
                window.open('Reporte.aspx', '', options);
            }
            return false;
        }

        if (window.addEventListener) {
            window.addEventListener('load', initElementosGrid, false);
        } else if (window.attachEvent) {
            window.attachEvent('onload', initElementosGrid);
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

    <div class="top-spacer"></div>

    <form id="form1" runat="server">
        <div class="container">
            <div class="table-wrapper">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h4 class="mb-0"><i class="bi bi-box-seam me-2"></i>Reporte de Elementos de Configuracion</h4>
                    <button type="button" class="btn-imprimir" onclick="abrir_ventana_imprimir_reporte()">
                        <i class="bi bi-printer me-2"></i>Imprimir reporte
                    </button>
                </div>

                <div class="row mb-3">
                    <div class="col-md-8">
                        <div class="input-group">
                            <span class="input-group-text bg-white border-end-0">
                                <i class="bi bi-search text-muted"></i>
                            </span>
                            <input type="text" id="txtBusqueda" class="form-control border-start-0 search-input"
                                placeholder="Buscar por Nombre CI, Tipo, Estado, Propietario, Descripcion, Sede, Area, Responsable..." />
                            <button class="btn btn-outline-secondary" type="button" onclick="document.getElementById('txtBusqueda').value=''; filtrarTabla();">
                                <i class="bi bi-x-lg"></i>
                            </button>
                        </div>
                    </div>
                    <div class="col-md-4 text-end">
                        <span id="lblTotal" class="form-text text-muted"></span>
                    </div>
                </div>

                <div class="table-responsive" style="max-height: 600px; overflow-y: auto;">
                    <table id="tblElementos" class="table table-modern table-hover" style="min-width: 1800px;">
                        <thead>
                            <tr>
                                <th>NOMBRE CI</th>
                                <th>TIPO CI</th>
                                <th>NRO SERIE</th>
                                <th>FABRICANTE / PROVEEDOR</th>
                                <th>MARCA / MODELO</th>
                                <th>IP</th>
                                <th>GATEWAY</th>
                                <th>GRUPO TRABAJO</th>
                                <th>ESTADO CI</th>
                                <th>PROPIETARIO CI</th>
                                <th>DESCRIPCION CI</th>
                                <th>IMPACTO / PRIORIDAD</th>
                                <th>SEDE / LOCAL</th>
                                <th>AREA</th>
                                <th>NRO PISO / AMBIENTE</th>
                                <th>FEC. CREACION CI</th>
                                <th>RESPONSABLE</th>
                            </tr>
                        </thead>
                        <tbody id="tbodyElementos">
                        </tbody>
                    </table>
                </div>

                <div class="pagination-wrapper" id="paginationElementos"></div>
                <div class="page-info" id="pageInfoElementos"></div>
            </div>

            <asp:HiddenField ID="__mensaje" runat="server" />
            <asp:HiddenField ID="__pagina" runat="server" />
            <asp:HiddenField ID="datosJson" runat="server" ClientIDMode="Static" />
        </div>
    </form>

</body>
</html>
