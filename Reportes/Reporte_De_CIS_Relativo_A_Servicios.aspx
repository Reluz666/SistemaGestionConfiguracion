<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Reporte_De_CIS_Relativo_A_Servicios.aspx.cs" Inherits="Reporte_De_CIS_Relativo_A_Servicios" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Relacion Elementos Configuracion</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>

    <!-- Bootstrap 5.3 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet" />
    <!-- Global Styles -->
    <link href="../CssJs/global-styles.css" rel="stylesheet" />

    <style>
        #tblReporte_wrapper {
            border-collapse: separate !important;
            border-spacing: 0;
            width: 100%;
            min-width: 800px;
        }

        #tblReporte_wrapper thead tr th {
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

        #tblReporte_wrapper tbody tr:hover td {
            background: rgba(233, 69, 96, 0.04) !important;
        }

        #tblReporte_wrapper tbody tr td {
            padding: 0.5rem 0.45rem !important;
            border: none !important;
            border-bottom: 1px solid #f1f1f1 !important;
            vertical-align: middle;
            font-size: 0.8rem;
            color: #2d3436;
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

        .page-info {
            text-align: center;
            margin-top: 1rem;
            color: #6c757d;
            font-size: 0.9rem;
        }

        .stats-row {
            background: #f8f9fa;
            font-weight: 600;
            color: #495057;
        }

        .padre-ci-cell {
            background: #f8f9fa !important;
        }

        .text-blue { color: #0d6efd; }
        .text-red { color: #dc3545; }
        .fw-bold { font-weight: 700; }
    </style>

    <script type="text/javascript" src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script type="text/javascript" src="../src/js/utils.js"></script>
    <script type="text/javascript" src="../src/js/grid-utils.js"></script>

    <script lang="javascript" type="text/javascript">
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
            var tbody = document.getElementById("tbodyReporte");
            var tabla_longitud = tbody ? tbody.rows.length : 0;

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

        function Confirmar(men) {
            if (!confirm(men))
                return false;
        }

        // Grid configuration for Reporte CIS Relativo a Servicios
        var cisServiciosGridConfig = {
            tableId: 'tblReporte',
            tbodyId: 'tbodyReporte',
            searchInputId: 'txtBuscar',
            paginationWrapperId: 'paginationReporte',
            pageInfoId: 'pageInfoReporte',
            counterId: 'lblContador',
            dataFieldId: 'datosJson',
            rowsPerPage: 10,
            searchFields: ['PADRE_CI', 'PADRE_TIPO_CI', 'PADRE_ESTADO_CI', 'PADRE_PROPIETARIO_CI', 'PADRE_SEDE', 'PADRE_LOCAL', 'PADRE_AREA', 'HIJO_CI', 'HIJO_TIPO_CI', 'HIJO_ESTADO_CI', 'HIJO_SEDE', 'HIJO_LOCAL', 'HIJO_AREA', 'TIPO_RELACION'],
            columnRenderer: function(item, index, items) {
                var html = '';

                // ID_RELACION (hidden in original)
                html += '<td class="d-none">' + htmlEncode(item.ID_RELACION) + '</td>';

                // PADRE_ID (hidden in original)
                html += '<td class="d-none">' + htmlEncode(item.PADRE_ID) + '</td>';

                // PADRE_CI - deduplicated
                var showPadre = true;
                if (index > 0 && item.PADRE_DESCRIPCION_CI === items[index - 1].PADRE_DESCRIPCION_CI) {
                    showPadre = false;
                }
                if (showPadre && item.PADRE_CI) {
                    html += '<td class="padre-ci-cell">' +
                        '<span class="text-blue fw-bold">Nombre: </span>' + htmlEncode(item.PADRE_CI) + '&nbsp;&nbsp; ' +
                        '<span class="fw-bold">Tipo:</span> ' + htmlEncode(item.PADRE_TIPO_CI) + '&nbsp;&nbsp; ' +
                        '<span class="fw-bold">Nro Serie: </span>' + htmlEncode(item.PADRE_NRO_SERIE) + '&nbsp;&nbsp; ' +
                        '<span class="fw-bold">Direccion IP: </span>' + htmlEncode(item.PADRE_IP) + '&nbsp;&nbsp; ' +
                        '<span class="fw-bold">Direccion Gateway: </span>' + htmlEncode(item.PADRE_GATEWAY) + '&nbsp;&nbsp; ' +
                        '<span class="fw-bold">Grupo de Trabajo: </span>' + htmlEncode(item.PADRE_GRUPO_TRABAJO) + '&nbsp;&nbsp; ' +
                        '<span class="fw-bold">Fabricante / Proveedor: </span>' + htmlEncode(item.PADRE_FABRICANTE_PROVEEDOR) + '&nbsp;&nbsp; ' +
                        '<span class="fw-bold">Estado:</span> ' + htmlEncode(item.PADRE_ESTADO_CI) + '&nbsp;&nbsp; ' +
                        '<span class="fw-bold">Propietario:</span> ' + htmlEncode(item.PADRE_PROPIETARIO_CI) + '<br>' +
                        '<span class="fw-bold">Descripcion: </span>' + htmlEncode(item.PADRE_DESCRIPCION_CI) + '&nbsp;&nbsp; ' +
                        '<span class="fw-bold">Prioridad: </span>' + htmlEncode(item.PADRE_NIVEL_PRIORIDAD) + '&nbsp;&nbsp; ' +
                        '<span class="fw-bold">Sede: </span>' + htmlEncode(item.PADRE_SEDE) + '&nbsp;&nbsp; ' +
                        '<span class="fw-bold">Local: </span>' + htmlEncode(item.PADRE_LOCAL) + '<br>' +
                        '<span class="text-red fw-bold">Area: </span>' + htmlEncode(item.PADRE_AREA) + '&nbsp;&nbsp; ' +
                        '<span class="fw-bold">Nro. Piso: </span>' + htmlEncode(item.PADRE_NRO_PISO) + '&nbsp;&nbsp; ' +
                        '<span class="fw-bold">Nro. Ambiente: </span>' + htmlEncode(item.PADRE_NRO_AMBIENTE) + '&nbsp;&nbsp; ' +
                        '<span class="fw-bold">Ubicacion: </span>' + htmlEncode(item.PADRE_UBICACION) + '<br>' +
                        '<span class="text-red fw-bold">Direccion: </span>' + htmlEncode(item.PADRE_DIRECCION_LOCAL) +
                        '</td>';
                } else {
                    html += '<td class="padre-ci-cell"></td>';
                }

                // HIJO_ID (hidden in original)
                html += '<td class="d-none">' + htmlEncode(item.HIJO_ID) + '</td>';

                // HIJO_CI
                html += '<td>' +
                    '<span class="text-blue fw-bold">Nombre: </span>' + htmlEncode(item.HIJO_CI) + '&nbsp;&nbsp; ' +
                    '<span class="fw-bold">Tipo:</span> ' + htmlEncode(item.HIJO_TIPO_CI) + '&nbsp;&nbsp; ' +
                    '<span class="fw-bold">Nro Serie: </span>' + htmlEncode(item.HIJO_NRO_SERIE) + '&nbsp;&nbsp; ' +
                    '<span class="fw-bold">Direccion IP: </span>' + htmlEncode(item.HIJO_IP) + '&nbsp;&nbsp; ' +
                    '<span class="fw-bold">Direccion Gateway: </span>' + htmlEncode(item.HIJO_GATEWAY) + '&nbsp;&nbsp; ' +
                    '<span class="fw-bold">Grupo de Trabajo: </span>' + htmlEncode(item.HIJO_GRUPO_TRABAJO) + '&nbsp;&nbsp; ' +
                    '<span class="fw-bold">Fabricante / Proveedor: </span>' + htmlEncode(item.HIJO_FABRICANTE_PROVEEDOR) + '&nbsp;&nbsp; ' +
                    '<span class="fw-bold">Estado:</span> ' + htmlEncode(item.HIJO_ESTADO_CI) + '&nbsp;&nbsp; ' +
                    '<span class="fw-bold">Propietario:</span> ' + htmlEncode(item.HIJO_PROPIETARIO_CI) + '<br>' +
                    '<span class="fw-bold">Descripcion: </span>' + htmlEncode(item.HIJO_DESCRIPCION_CI) + '&nbsp;&nbsp; ' +
                    '<span class="fw-bold">Prioridad: </span>' + htmlEncode(item.HIJO_NIVEL_PRIORIDAD) + '&nbsp;&nbsp; ' +
                    '<span class="fw-bold">Sede: </span>' + htmlEncode(item.HIJO_SEDE) + '&nbsp;&nbsp; ' +
                    '<span class="fw-bold">Local: </span>' + htmlEncode(item.HIJO_LOCAL) + '<br>' +
                    '<span class="text-red fw-bold">Area: </span>' + htmlEncode(item.HIJO_AREA) + '&nbsp;&nbsp; ' +
                    '<span class="fw-bold">Nro. Piso: </span>' + htmlEncode(item.HIJO_NRO_PISO) + '&nbsp;&nbsp; ' +
                    '<span class="fw-bold">Nro. Ambiente: </span>' + htmlEncode(item.HIJO_NRO_AMBIENTE) + '&nbsp;&nbsp; ' +
                    '<span class="fw-bold">Ubicacion: </span>' + htmlEncode(item.HIJO_UBICACION) + '<br>' +
                    '<span class="text-red fw-bold">Direccion: </span>' + htmlEncode(item.HIJO_DIRECCION_LOCAL) +
                    '</td>';

                // TIPO_RELACION
                html += '<td>' + htmlEncode(item.TIPO_RELACION) + '</td>';

                return html;
            }
        };

        function initGrid() {
            GridUtils.createGrid(cisServiciosGridConfig);
        }
    </script>
</head>
<body onload="MostrarMensaje()">
    <nav class="navbar navbar-custom navbar-fixed-top" role="navigation">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse"
                data-target=".navbar-ex1-collapse">
                <span class="sr-only">Desplegar navegación</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="../menu.aspx"><span class="glyphicon glyphicon-home"></span>&nbsp;Inicio</a>
        </div>

        <div class="collapse navbar-collapse navbar-ex1-collapse">
            <ul class="nav navbar-nav">
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown"><span class="glyphicon glyphicon-briefcase"></span>&nbsp;Mantenimiento <b class="caret"></b>
                    </a>
                    <ul class="dropdown-menu">
                        <li><a href="Personal.aspx" runat="server" id="trabajadores_aspx">Personal</a></li>
                        <li class="dropdown-submenu">
                            <a href="#">Tablas Institucion</a>
                            <ul class="dropdown-menu">
                                <li><a href="Sede.aspx" runat="server" id="a4">Sede</a></li>
                                <li><a href="Local.aspx" runat="server" id="A5">Local</a></li>
                                <li><a href="Area.aspx" runat="server" id="A6">Area</a></li>
                                <li><a href="Dependencia.aspx" runat="server" id="A8">Dependencia</a></li>
                            </ul>
                        </li>
                        <li class="dropdown-submenu">
                            <a href="#">Tablas Personal</a>
                            <ul class="dropdown-menu">
                                <li><a href="Cargo.aspx" runat="server" id="area_trabajo_aspx">Cargo</a></li>
                                <li><a href="ProfecionOcupacion.aspx" runat="server" id="Sub_Area_aspx">Profecion - Ocupacion</a></li>
                            </ul>
                        </li>
                        <li class="divider"></li>
                        <li class="dropdown-submenu">
                            <a href="#">Tablas Elemento Configuracion</a>
                            <ul class="dropdown-menu">
                                <li><a href="Modelo.aspx" runat="server" id="A14">Modelo</a></li>
                                <li><a href="Marca.aspx" runat="server" id="A13">Marca</a></li>
                                <li><a href="DescripcionElementoConfiguracion.aspx" runat="server" id="A9">Descripci&oacute;n Elemento Configuraci&oacute;n</a></li>
                                <li><a href="TiposElementoConfiguracion.aspx" runat="server" id="A10">Tipos Elemento Configuraci&oacute;n</a></li>
                                <li><a href="TipoRelacionElementoConfiguracion.aspx" runat="server" id="A11">Tipo Relaci&oacute;n Elemento Configuraci&oacute;n</a></li>
                                <li><a href="TipoComponeneteCI.aspx" runat="server" id="A12">Tipo Componenete Elemento Configuraci&oacute;n</a></li>
                                <li><a href="EstadoActualCI.aspx" runat="server" id="A15">Estado Actual Elemento Configuraci&oacute;n</a></li>
                            </ul>
                        </li>
                    </ul>
                </li>
            </ul>

            <ul class="nav navbar-nav">
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" style="color: white"><span class="glyphicon glyphicon-user"></span>&nbsp;Gesti&oacute;n de Configuraci&oacute;n <b class="caret"></b>
                    </a>
                    <ul class="dropdown-menu">
                        <li><a href="ElementosConfiguracion.aspx" runat="server" id="ElementosConfiguracion_aspx">Elementos de Configuracio&oacute;n</a></li>
                        <li><a href="RelacionesElementosConfiguracion.aspx" runat="server" id="PrendaMovimientos_aspx">Relacio&oacute;n de Elementos de Configuracio&oacute;n</a></li>
                        <li class="divider"></li>
                        <li><a href="CIsAsignarComponenetes.aspx" runat="server" id="A3">Asignar Componentes Elementos de Configuraci&oacute;n</a></li>
                        <li class="divider"></li>
                        <li><a href="LicenciasElementoConfiguracion.aspx" runat="server" id="A1">Licencias de Elementos de Configuraci&oacute;n</a></li>
                        <li class="divider"></li>
                        <li><a href="SeguimientosElementoConfiguracion.aspx" runat="server" id="_Asistencias_aspx">Seguimiento de Elementos de Configuraci&oacute;n</a></li>
                    </ul>
                </li>
            </ul>

            <ul class="nav navbar-nav">
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown"><span class="glyphicon glyphicon-file"></span>&nbsp;Reportes <b class="caret"></b>
                    </a>
                    <ul class="dropdown-menu">
                        <li><a href="../Reportes/ReporteElementosConfiguracion.aspx" runat="server" id="A16">Reporte de Elementos de Configuraci&oacute;n</a></li>
                        <li><a href="../Reportes/ReporteRelacionesElementosConfiguracion.aspx" runat="server" id="A17">Reporte de Relaciones de Elementos de Configuraci&oacute;n</a></li>
                        <li><a href="../Reportes/ReporteSeguimientosElementoConfiguracion.aspx" runat="server" id="A18">Reporte de Seguimientos de Elementos de Configuraci&oacute;n</a></li>
                        <li><a href="../Reportes/ReporteLicenciasElementoConfiguracion.aspx" runat="server" id="A19">Reporte de Licencias de Elementos de Configuraci&oacute;n</a></li>
                        <li><a href="../Reportes/ReporteCIsSeguidos.aspx" runat="server" id="A24">Reporte de Elementos de Configuraci&oacute;n Seguidos</a></li>
                        <li><a href="../Reportes/ReporteComponentesAsignados.aspx" runat="server" id="A20">Reporte de Componentes de Elementos de Configuraci&oacute;n Asignados</a></li>
                        <li class="divider"></li>
                        <li><a href="../Reportes/ReporteDatosCorrectosCI.aspx" runat="server" id="A21">Reporte de Datos Correctos de Elementos de Configuraci&oacute;n</a></li>
                        <li><a href="../Reportes/ReporteDatosIncorrectosCI.aspx" runat="server" id="A22">Reporte de Datos Incorrectos de Elementos de Configuraci&oacute;n</a></li>
                        <li><a href="../Reportes/ReporteCIsInformacionContenidaEnCMDB.aspx" runat="server" id="A23">Reporte de Informaci&oacute;n de Elementos de Configuraci&oacute;n Contenidas en la CMDB</a></li>
                        <li><a href="../Reportes/Reporte_De_CIS_Relativo_A_Servicios.aspx" runat="server" id="A2">Reporte de CIS Relativo A Servicios</a></li>
                    </ul>
                </li>
            </ul>

            <ul class="nav navbar-nav">
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" style="color: black"><span class="glyphicon glyphicon-wrench"></span>&nbsp;Configuraciones <b class="caret"></b>
                    </a>
                    <ul class="dropdown-menu">
                        <li><a href="Usuario.aspx" runat="server" id="usuarios_aspx">Usuarios</a></li>
                        <li><a href="../Configuracion/Usuarios.aspx" runat="server" id="permisos_aspx">Permisos</a></li>
                        <li class="divider"></li>
                        <li><a href="CerrarSession.aspx" style="text-align: left; color: red;">Cerrar Sesion</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </nav>

    <div class="section">
        <div class="container">
            <div class="row main-low-margin">
                <div class="col-md-10 col-md-offset-1 col-sm-10 col-sm-offset-1">
                    <h3>-</h3>
                </div>
            </div>
        </div>
    </div>

    <form id="form1" runat="server">
        <div class="container">
            <!-- Report Card -->
            <div class="form-card">
                <div class="card-header">
                    <i class="bi bi-diagram-3 me-2"></i>Reporte de CIS Relativo a Servicios
                </div>
                <div class="card-body p-3">
                    <!-- Search Bar -->
                    <div class="row mb-3">
                        <div class="col-md-8">
                            <div class="input-group">
                                <span class="input-group-text bg-white border-end-0">
                                    <i class="bi bi-search text-muted"></i>
                                </span>
                                <input type="text" id="txtBuscar" class="form-control border-start-0 search-input" ClientIDMode="Static"
                                       placeholder="Buscar por nombre, tipo, estado, sede, local, area..." />
                                <button class="btn btn-outline-secondary" type="button" onclick="document.getElementById('txtBuscar').value=''; GridUtils.refresh('tblReporte');">
                                    <i class="bi bi-x-lg"></i>
                                </button>
                            </div>
                        </div>
                        <div class="col-md-4 text-end">
                            <span id="lblContador" class="form-text text-muted"></span>
                        </div>
                    </div>

                    <!-- Table -->
                    <div class="table-wrapper" style="max-height: 500px; overflow-y: auto;">
                        <table id="tblReporte" class="table table-modern table-hover" style="min-width: 800px;">
                            <thead>
                                <tr>
                                    <th style="width: 60px;">ID REL</th>
                                    <th style="width: 60px;">PADRE ID</th>
                                    <th style="width: 300px;">PADRE ELEMENTO CONFIGURACION</th>
                                    <th style="width: 60px;">HIJO ID</th>
                                    <th style="width: 300px;">HIJO ELEMENTO CONFIGURACION</th>
                                    <th style="width: 100px;">TIPO RELACION</th>
                                </tr>
                            </thead>
                            <tbody id="tbodyReporte">
                            </tbody>
                        </table>
                    </div>

                    <!-- Pagination -->
                    <div class="pagination-wrapper">
                        <ul id="paginationReporte" class="pagination" style="flex-wrap: wrap;"></ul>
                    </div>
                    <div class="page-info" id="pageInfoReporte"></div>

                    <!-- Stats -->
                    <div class="row mt-3">
                        <div class="col-md-12">
                            <asp:Label ID="T" runat="server" CssClass="form-label fw-bold d-block" ClientIDMode="Static"></asp:Label>
                            <asp:Label ID="A" runat="server" CssClass="form-label fw-bold d-block" ClientIDMode="Static"></asp:Label>
                            <asp:Label ID="X" runat="server" CssClass="form-label fw-bold d-block" ClientIDMode="Static"></asp:Label>
                        </div>
                    </div>

                    <!-- Print Button -->
                    <div class="row mt-3">
                        <div class="col-md-12 text-end">
                            <asp:HyperLink ID="IMPRIMIR" runat="server" BorderStyle="None" class="btn btn-info" NavigateUrl="" onClick="abrir_ventana_imprimir_reporte(2);">
                                <i class="bi bi-printer"></i>&nbsp;Imprimir reporte
                            </asp:HyperLink>
                        </div>
                    </div>
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
                initGrid();
            }, false);
        } else if (window.attachEvent) {
            window.attachEvent('onload', function() {
                initGrid();
            });
        }
    </script>
</body>
</html>
