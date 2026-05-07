<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RelacionesElementosConfiguracion.aspx.cs" Inherits="RelacionesElementosConfiguracion" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>Relacion Elementos Configuracion</title>

    <!-- Bootstrap 5.3 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet" />
    <!-- Global Styles -->
    <link href="CssJs/global-styles.css" rel="stylesheet" />

    <style>
        /* ===== SPACER ===== */
        .top-spacer { height: 100px; }

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

        .auto-style1 {
            width: 309px;
        }
    </style>

    <script lang="javascript" type="text/javascript">
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

        function Confirmar(men) {
            if (!confirm(men))
                return false;
        }
    </script>

    <script type="text/javascript" src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body onload="MostrarMensaje()">

    <!-- ========== NAVBAR ========== -->
    <nav class="navbar navbar-expand-lg navbar-modern fixed-top">
        <div class="container-fluid">
            <a class="navbar-brand" href="Menu.aspx">
                <i class="bi bi-house-door-fill me-1"></i>Inicio
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                    data-bs-target="#navbarNav" aria-controls="navbarNav"
                    aria-expanded="false" aria-label="Navegaci&oacute;n">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">

                    <!-- Mantenimiento -->
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="mantenimientoDropdown"
                           role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            <i class="bi bi-briefcase-fill me-1"></i>Mantenimiento
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="mantenimientoDropdown">
                            <li><a class="dropdown-item" href="Personal.aspx">Personal</a></li>
                            <li class="dropdown-submenu">
                                <a class="dropdown-item dropdown-toggle" href="#">Tablas Instituci&oacute;n</a>
                                <ul class="dropdown-menu">
                                    <li><a class="dropdown-item" href="Sede.aspx">Sede</a></li>
                                    <li><a class="dropdown-item" href="Local.aspx">Local</a></li>
                                    <li><a class="dropdown-item" href="Area.aspx">&Aacute;rea</a></li>
                                    <li><a class="dropdown-item" href="Dependencia.aspx">Dependencia</a></li>
                                </ul>
                            </li>
                            <li class="dropdown-submenu">
                                <a class="dropdown-item dropdown-toggle" href="#">Tablas Personal</a>
                                <ul class="dropdown-menu">
                                    <li><a class="dropdown-item" href="Cargo.aspx">Cargo</a></li>
                                    <li><a class="dropdown-item" href="ProfecionOcupacion.aspx">Profesi&oacute;n - Ocupaci&oacute;n</a></li>
                                </ul>
                            </li>
                            <li><hr class="dropdown-divider" /></li>
                            <li class="dropdown-submenu">
                                <a class="dropdown-item dropdown-toggle" href="#">Tablas Elemento Configuraci&oacute;n</a>
                                <ul class="dropdown-menu">
                                    <li><a class="dropdown-item" href="Modelo.aspx">Modelo</a></li>
                                    <li><a class="dropdown-item" href="Marca.aspx">Marca</a></li>
                                    <li><a class="dropdown-item" href="DescripcionElementoConfiguracion.aspx">Descripci&oacute;n Elemento Configuraci&oacute;n</a></li>
                                    <li><a class="dropdown-item" href="TiposElementoConfiguracion.aspx">Tipos Elemento Configuraci&oacute;n</a></li>
                                    <li><a class="dropdown-item" href="TipoRelacionElementoConfiguracion.aspx">Tipo Relaci&oacute;n Elemento Configuraci&oacute;n</a></li>
                                    <li><a class="dropdown-item" href="TipoComponeneteCI.aspx">Tipo Componente Elemento Configuraci&oacute;n</a></li>
                                    <li><a class="dropdown-item" href="EstadoActualCI.aspx">Estado Actual Elemento Configuraci&oacute;n</a></li>
                                </ul>
                            </li>
                        </ul>
                    </li>

                    <!-- Gesti&oacute;n de Configuraci&oacute;n -->
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="gestionDropdown"
                           role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            <i class="bi bi-person-lines-fill me-1"></i>Gesti&oacute;n de Configuraci&oacute;n
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="gestionDropdown">
                            <li><a class="dropdown-item" href="ElementosConfiguracion.aspx">Elementos de Configuraci&oacute;n</a></li>
                            <li><a class="dropdown-item" href="RelacionesElementosConfiguracion.aspx">Relaci&oacute;n de Elementos de Configuraci&oacute;n</a></li>
                            <li><hr class="dropdown-divider" /></li>
                            <li><a class="dropdown-item" href="CIsAsignarComponenetes.aspx">Asignar Componentes Elementos de Configuraci&oacute;n</a></li>
                            <li><hr class="dropdown-divider" /></li>
                            <li><a class="dropdown-item" href="LicenciasElementoConfiguracion.aspx">Licencias de Elementos de Configuraci&oacute;n</a></li>
                            <li><hr class="dropdown-divider" /></li>
                            <li><a class="dropdown-item" href="SeguimientosElementoConfiguracion.aspx">Seguimiento de Elementos de Configuraci&oacute;n</a></li>
                        </ul>
                    </li>

                    <!-- Reportes -->
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="reportesDropdown"
                           role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            <i class="bi bi-file-earmark-bar-graph-fill me-1"></i>Reportes
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="reportesDropdown">
                            <li><a class="dropdown-item" href="../Reportes/ReporteElementosConfiguracion.aspx">Reporte de Elementos de Configuraci&oacute;n</a></li>
                            <li><a class="dropdown-item" href="../Reportes/ReporteRelacionesElementosConfiguracion.aspx">Reporte de Relaciones de Elementos de Configuraci&oacute;n</a></li>
                            <li><a class="dropdown-item" href="../Reportes/ReporteSeguimientosElementoConfiguracion.aspx">Reporte de Seguimientos de Elementos de Configuraci&oacute;n</a></li>
                            <li><a class="dropdown-item" href="../Reportes/ReporteLicenciasElementoConfiguracion.aspx">Reporte de Licencias de Elementos de Configuraci&oacute;n</a></li>
                            <li><a class="dropdown-item" href="../Reportes/ReporteCIsSeguidos.aspx">Reporte de Elementos de Configuraci&oacute;n Seguidos</a></li>
                            <li><a class="dropdown-item" href="../Reportes/ReporteComponentesAsignados.aspx">Reporte de Componentes de Elementos de Configuraci&oacute;n Asignados</a></li>
                            <li><hr class="dropdown-divider" /></li>
                            <li><a class="dropdown-item" href="../Reportes/ReporteDatosCorrectosCI.aspx">Reporte de Datos Correctos de Elementos de Configuraci&oacute;n</a></li>
                            <li><a class="dropdown-item" href="../Reportes/ReporteDatosIncorrectosCI.aspx">Reporte de Datos Incorrectos de Elementos de Configuraci&oacute;n</a></li>
                            <li><a class="dropdown-item" href="../Reportes/ReporteCIsInformacionContenidaEnCMDB.aspx">Reporte de Informaci&oacute;n de Elementos de Configuraci&oacute;n Contenidas en la CMDB</a></li>
                        </ul>
                    </li>

                    <!-- Configuraciones -->
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="configDropdown"
                           role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            <i class="bi bi-gear-fill me-1"></i>Configuraciones
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="configDropdown">
                            <li><a class="dropdown-item" href="Usuario.aspx">Usuarios</a></li>
                            <li><a class="dropdown-item" href="../Configuracion/Usuarios.aspx">Permisos</a></li>
                            <li><hr class="dropdown-divider" /></li>
                            <li><a class="dropdown-item" href="CerrarSession.aspx" style="color: #e94560;">Cerrar Sesi&oacute;n</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Espaciador para navbar fija -->
    <div class="top-spacer"></div>

    <!-- ========== FORMULARIO ========== -->
    <form id="form1" runat="server">
        <div class="container">
            <div class="table-wrapper">
               <div class="container-fluid">
                    <table class="table table text-center">
                        <tr>
                            <td style="text-align: left" colspan="5">
                                <asp:HyperLink ID="hlNuevaRelacionElementoConfiguracion" runat="server" NavigateUrl="~/RelacionElementosConfiguracion.aspx?Operacion=N">Nueva Relacion Elemento Configuracion</asp:HyperLink>
                            </td>
                            <td style="text-align: left">
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td style="text-align: left" >
                                <asp:CheckBox ID="cbnci" runat="server" CssClass="form-check-input position-static&quot" Font-Size="X-Small" Text="Nombre CI" AutoPostBack="True" OnCheckedChanged="cbnci_CheckedChanged"/>
                            </td>
                            <td style="text-align: left" >
                                <asp:CheckBox ID="cbtci" runat="server" CssClass="form-check-input position-static&quot" Font-Size="X-Small" Text="Tipo CI" AutoPostBack="True" OnCheckedChanged="cbtci_CheckedChanged"/>
                            </td>
                            <td style="text-align: left" >
                                <asp:CheckBox ID="cbeci" runat="server" CssClass="form-check-input position-static&quot" Font-Size="X-Small" Text="Estado CI" AutoPostBack="True" OnCheckedChanged="cbeci_CheckedChanged"/>
                            </td>
                            <td style="text-align: left" class="auto-style1" >
                                <asp:CheckBox ID="cbpci" runat="server" CssClass="form-check-input position-static&quot" Font-Size="X-Small" Text="Propietario CI" AutoPostBack="True" OnCheckedChanged="cbpci_CheckedChanged"/>
                            </td>
                            <td style="text-align: left" class="auto-style1" >
                                <asp:CheckBox ID="cbdci" runat="server" CssClass="form-check-input position-static&quot" Font-Size="X-Small" Text="Descripcion CI" AutoPostBack="True" OnCheckedChanged="cbdci_CheckedChanged"/>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                 <asp:TextBox ID="txtnci" runat="server" CssClass="form-control input-sm" MaxLength="25" Autocomplete = "off" placeholder="Ingresar Nombre" onchange=""
                            onkeypress="" Enabled="False"></asp:TextBox>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddltci" runat="server" CssClass="form-control input-sm"
                                            AppendDataBoundItems="True" Enabled="False"
                                           >
                                            <asp:ListItem Value="-1">_____SELECCIONE TIPO CI_____</asp:ListItem>
                                        </asp:DropDownList>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddleci" runat="server" CssClass="form-control input-sm"
                                            AppendDataBoundItems="True" Enabled="False"
                                           >
                                            <asp:ListItem Value="-1">_____SELECCIONE ESTADO CI_____</asp:ListItem>
                                        </asp:DropDownList>
                            </td>
                            <td class="auto-style1">
                                 <asp:TextBox ID="txtpci" runat="server" CssClass="form-control input-sm" MaxLength="25" Autocomplete = "off" placeholder="Ingresar Nombre" onchange=""
                            onkeypress="" Enabled="False"></asp:TextBox>
                            </td>
                            <td class="auto-style1">
                                <asp:DropDownList ID="ddldci" runat="server" CssClass="form-control input-sm"
                                            AppendDataBoundItems="True" Enabled="False"
                                           >
                                            <asp:ListItem Value="-1">_____SELECCIONE DESCRIPCION CI_____</asp:ListItem>
                                        </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: left" >
                                <asp:CheckBox ID="cbs" runat="server" CssClass="form-check-input position-static&quot" Font-Size="X-Small" Text="Sede" AutoPostBack="True" OnCheckedChanged="cbs_CheckedChanged" />
                            </td>
                            <td style="text-align: left" >
                                <asp:CheckBox ID="cbl" runat="server" CssClass="form-check-input position-static&quot" Font-Size="X-Small" Text="Local" AutoPostBack="True" OnCheckedChanged="cbl_CheckedChanged1" />
                            </td>
                            <td style="text-align: left" >
                                <asp:CheckBox ID="cba" runat="server" CssClass="form-check-input position-static&quot" Font-Size="X-Small" Text="Area" OnCheckedChanged="cba_CheckedChanged" CausesValidation="True"/>
                            </td>
                            <td style="text-align: left" >
                                &nbsp;</td>
                            <td class="auto-style1">
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td style="text-align: left" >
                                <asp:DropDownList ID="ddls" runat="server" CssClass="form-control input-sm"
                                            AppendDataBoundItems="True" OnSelectedIndexChanged="ddls_SelectedIndexChanged" AutoPostBack="True" Enabled="False"
                                           >
                                            <asp:ListItem Value="-1">_____SELECCIONE SEDE_____</asp:ListItem>
                                        </asp:DropDownList>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddll" runat="server" CssClass="form-control input-sm"
                                            AppendDataBoundItems="True" AutoPostBack="True" OnSelectedIndexChanged="ddll_SelectedIndexChanged" Enabled="False"
                                           >
                                            <asp:ListItem Value="-1">_____SELECCIONE LOCAL_____</asp:ListItem>
                                        </asp:DropDownList>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddla" runat="server" CssClass="form-control input-sm"
                                            AppendDataBoundItems="True" Enabled="False"
                                           >
                                            <asp:ListItem Value="-1">_____SELECCIONE AREA_____</asp:ListItem>
                                        </asp:DropDownList>
                            </td>
                            <td class="auto-style1">
                                <asp:LinkButton ID="lbtnBuscar" runat="server" CausesValidation="False" class="btn btn-info" Text="Buscar  &lt;span class='glyphicon glyphicon-search'&gt;&lt;/span&gt;" UseSubmitBehavior="False" OnClick="lbtnBuscar_Click" />
                                <asp:Button ID="btnActualizarInformacion" runat="server" class="btn btn-success" CssClass="btn btn-warning" onclick="btnActualizarInformacion_Click" Text="Actualizar Informacion" />
                            </td>
                            <td class="auto-style1">
                                &nbsp;</td>
                        </tr>
                        <tr>
                        <td colspan="5">
                            <asp:Table ID="Table_" runat="server" BackColor="White"
                                class="table table-condensed"
                            BorderColor="White" CellPadding="2" CellSpacing="0" Font-Size="X-Small"
                            GridLines="Both" style="text-align: left">
                            <asp:TableRow ID="CABECERA" runat="server">
                                <asp:TableCell ID="_ID_RELACION" runat="server" BackColor="#FFFFC0" BorderColor="#FFFFC0"
                                         ForeColor="Green" Visible="False">ID CI</asp:TableCell>

                                <asp:TableCell ID="_PADRE_ID" runat="server" BackColor="Black" BorderColor="Black"
                                    ForeColor="White" Visible="False">PADRE ID</asp:TableCell>

                                <asp:TableCell ID="_PADRE_CI" runat="server" BackColor="Black" BorderColor="Black"
                                    ForeColor="White" >PADRE ELEMENETO CONFIGURACION</asp:TableCell>

                                <asp:TableCell ID="_HIJO_ID" runat="server" BackColor="Black" BorderColor="Black"
                                    ForeColor="White" Visible="False">HIJO ID</asp:TableCell>

                                 <asp:TableCell ID="_HIJO_CI" runat="server" BackColor="Black" BorderColor="Black"
                                    ForeColor="White" >HIJO ELEMENETO CONFIGURACION</asp:TableCell>

                                 <asp:TableCell ID="_TIPO_RELACION" runat="server" BackColor="Black" BorderColor="Black"
                                    ForeColor="White" >TIPO RELACION</asp:TableCell>


                                <asp:TableCell ID="EDITAR" runat="server" BackColor="Black" BorderColor="Black"
                                    ForeColor="White" Width="3%" HorizontalAlign="Center">RELACION</asp:TableCell>
                            </asp:TableRow>
                        </asp:Table>
                        </td>
                        <td>
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td colspan="5" >
                            <asp:HiddenField ID="__pagina" runat="server" />
                            <asp:HiddenField ID="__mensaje" runat="server" />
                            <asp:HiddenField ID="datosJson" runat="server" />
                        </td>
                        <td >
                            &nbsp;</td>
                    </tr>
                    </table>
               </div>
            </div>
        </div>
    </form>

    <!-- Scripts -->
    <script type="text/javascript" src="../Otros_css_js/resaltar.js"></script>

    <!-- ========== LIST VIEW SECTION ========== -->
    <div class="container mt-4" id="listViewSection">
        <div class="card">
            <div class="card-header bg-primary text-white">
                <h5 class="mb-0"><i class="bi bi-list-ul me-2"></i>Lista de Relaciones de Elementos de Configuracion</h5>
            </div>
            <div class="card-body">
                <!-- Search Input -->
                <div class="row mb-3">
                    <div class="col-md-6">
                        <div class="input-group">
                            <span class="input-group-text"><i class="bi bi-search"></i></span>
                            <input type="text" id="txtBuscarLista" class="form-control" placeholder="Buscar por nombre, tipo, estado, propietario..." onkeyup="filtrarLista()" />
                            <button class="btn btn-outline-secondary" type="button" onclick="filtrarLista()">Buscar</button>
                        </div>
                    </div>
                    <div class="col-md-6 text-end">
                        <span id="lblTotalRegistros" class="text-muted"></span>
                    </div>
                </div>

                <!-- Table -->
                <div class="table-responsive">
                    <table class="table table-striped table-hover table-bordered" id="tblListaRelaciones">
                        <thead class="table-dark">
                            <tr>
                                <th>ID</th>
                                <th>Nombre CI</th>
                                <th>Tipo CI</th>
                                <th>Estado CI</th>
                                <th>Propietario</th>
                                <th>Sede</th>
                                <th>Local</th>
                                <th>Area</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody id="tbodyListaRelaciones">
                        </tbody>
                    </table>
                </div>

                <!-- Pagination -->
                <div class="row align-items-center">
                    <div class="col-md-6">
                        <nav>
                            <ul class="pagination mb-0" id="paginationControls">
                            </ul>
                        </nav>
                    </div>
                    <div class="col-md-6 text-end">
                        <span id="lblPaginacion" class="text-muted"></span>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        // ========== LIST VIEW PAGINATION AND SEARCH ==========
        var currentPage = 1;
        var itemsPerPage = 10;
        var allData = [];
        var filteredData = [];

        function cargarDatosJson() {
            var jsonData = document.getElementById('datosJson').value;
            if (jsonData && jsonData.trim() !== '') {
                try {
                    allData = JSON.parse(jsonData);
                    filteredData = allData;
                    renderizarTabla();
                } catch (e) {
                    console.error('Error parsing JSON:', e);
                }
            }
        }

        function filtrarLista() {
            var searchTerm = document.getElementById('txtBuscarLista').value.toLowerCase().trim();
            if (searchTerm === '') {
                filteredData = allData;
            } else {
                filteredData = allData.filter(function(item) {
                    var nombreCI = (item.NOMBRE_CI || '').toLowerCase();
                    var tipoCI = (item.TIPO_CI || '').toLowerCase();
                    var estadoCI = (item.ESTADO_CI || '').toLowerCase();
                    var propietario = (item.PROPIETARIO_CI || '').toLowerCase();
                    var sede = (item.SEDE || '').toLowerCase();
                    var local = (item.LOCAL || '').toLowerCase();
                    var area = (item.AREA || '').toLowerCase();
                    var tipoRelacion = (item.TIPO_RELACION || '').toLowerCase();

                    return nombreCI.indexOf(searchTerm) !== -1 ||
                           tipoCI.indexOf(searchTerm) !== -1 ||
                           estadoCI.indexOf(searchTerm) !== -1 ||
                           propietario.indexOf(searchTerm) !== -1 ||
                           sede.indexOf(searchTerm) !== -1 ||
                           local.indexOf(searchTerm) !== -1 ||
                           area.indexOf(searchTerm) !== -1 ||
                           tipoRelacion.indexOf(searchTerm) !== -1;
                });
            }
            currentPage = 1;
            renderizarTabla();
        }

        function renderizarTabla() {
            var tbody = document.getElementById('tbodyListaRelaciones');
            tbody.innerHTML = '';

            var startIndex = (currentPage - 1) * itemsPerPage;
            var endIndex = startIndex + itemsPerPage;
            var pageData = filteredData.slice(startIndex, endIndex);

            if (pageData.length === 0) {
                tbody.innerHTML = '<tr><td colspan="9" class="text-center text-muted">No se encontraron registros</td></tr>';
                document.getElementById('lblTotalRegistros').textContent = 'Total: 0 registros';
                return;
            }

            for (var i = 0; i < pageData.length; i++) {
                var item = pageData[i];
                var row = document.createElement('tr');
                row.innerHTML =
                    '<td>' + (item.ID_RELACION || '') + '</td>' +
                    '<td>' + (item.NOMBRE_CI || '') + '</td>' +
                    '<td>' + (item.TIPO_CI || '') + '</td>' +
                    '<td>' + (item.ESTADO_CI || '') + '</td>' +
                    '<td>' + (item.PROPIETARIO_CI || '') + '</td>' +
                    '<td>' + (item.SEDE || '') + '</td>' +
                    '<td>' + (item.LOCAL || '') + '</td>' +
                    '<td>' + (item.AREA || '') + '</td>' +
                    '<td><a href="RelacionElementosConfiguracion.aspx?Operacion=M&IDR=' + item.ID_RELACION + '" class="btn btn-sm btn-primary"><i class="bi bi-pencil"></i> Editar</a></td>';
                tbody.appendChild(row);
            }

            document.getElementById('lblTotalRegistros').textContent = 'Total: ' + filteredData.length + ' registros';
            renderizarPaginacion();
        }

        function renderizarPaginacion() {
            var pagination = document.getElementById('paginationControls');
            pagination.innerHTML = '';

            var totalPages = Math.ceil(filteredData.length / itemsPerPage);
            if (totalPages <= 1) {
                document.getElementById('lblPaginacion').textContent = '';
                return;
            }

            // Previous button
            var prevLi = document.createElement('li');
            prevLi.className = 'page-item' + (currentPage === 1 ? ' disabled' : '');
            prevLi.innerHTML = '<a class="page-link" href="#" onclick="irPagina(' + (currentPage - 1) + '); return false;">Anterior</a>';
            pagination.appendChild(prevLi);

            // Page numbers
            var maxVisible = 5;
            var startPage = Math.max(1, currentPage - Math.floor(maxVisible / 2));
            var endPage = Math.min(totalPages, startPage + maxVisible - 1);

            if (endPage - startPage < maxVisible - 1) {
                startPage = Math.max(1, endPage - maxVisible + 1);
            }

            if (startPage > 1) {
                var firstLi = document.createElement('li');
                firstLi.className = 'page-item';
                firstLi.innerHTML = '<a class="page-link" href="#" onclick="irPagina(1); return false;">1</a>';
                pagination.appendChild(firstLi);
                if (startPage > 2) {
                    var ellipsisLi = document.createElement('li');
                    ellipsisLi.className = 'page-item disabled';
                    ellipsisLi.innerHTML = '<span class="page-link">...</span>';
                    pagination.appendChild(ellipsisLi);
                }
            }

            for (var p = startPage; p <= endPage; p++) {
                var li = document.createElement('li');
                li.className = 'page-item' + (p === currentPage ? ' active' : '');
                li.innerHTML = '<a class="page-link" href="#" onclick="irPagina(' + p + '); return false;">' + p + '</a>';
                pagination.appendChild(li);
            }

            if (endPage < totalPages) {
                if (endPage < totalPages - 1) {
                    var ellipsisLi = document.createElement('li');
                    ellipsisLi.className = 'page-item disabled';
                    ellipsisLi.innerHTML = '<span class="page-link">...</span>';
                    pagination.appendChild(ellipsisLi);
                }
                var lastLi = document.createElement('li');
                lastLi.className = 'page-item';
                lastLi.innerHTML = '<a class="page-link" href="#" onclick="irPagina(' + totalPages + '); return false;">' + totalPages + '</a>';
                pagination.appendChild(lastLi);
            }

            // Next button
            var nextLi = document.createElement('li');
            nextLi.className = 'page-item' + (currentPage === totalPages ? ' disabled' : '');
            nextLi.innerHTML = '<a class="page-link" href="#" onclick="irPagina(' + (currentPage + 1) + '); return false;">Siguiente</a>';
            pagination.appendChild(nextLi);

            document.getElementById('lblPaginacion').textContent = 'Pagina ' + currentPage + ' de ' + totalPages;
        }

        function irPagina(page) {
            var totalPages = Math.ceil(filteredData.length / itemsPerPage);
            if (page < 1 || page > totalPages) return;
            currentPage = page;
            renderizarTabla();
        }

        // Load data on page load
        $(document).ready(function() {
            cargarDatosJson();
        });
    </script>

</body>
</html>
