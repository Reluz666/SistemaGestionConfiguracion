<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CIsComponentesAsignados.aspx.cs" Inherits="CIsComponentesAsignados"  UnobtrusiveValidationMode="None" %>
<%@ Register src="NavBar.ascx" tagname="NavBar" tagprefix="uc1" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>Componentes Asignados Elementos de Configuracion</title>

    <!-- Bootstrap 5.3 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet" />
    <!-- Global Styles -->
    <link href="CssJs/global-styles.css" rel="stylesheet" />

    <style>
        /* Estilos especificos para CIsComponentesAsignados */
        .auto-style1 {
            width: 309px;
        }
        /* List Section Styles */
        .list-section {
            margin-top: 20px;
        }
        .list-section .card {
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .list-section .input-group-text {
            background-color: #fff;
            border-right: 0;
        }

        /* ===== GUIA ESTILO TABLAS ===== */
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

        .table-sm td, .table-sm th {
            padding: 0.5rem;
        }
    </style>

    <script type="text/javascript" src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>

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
</head>
<body onload="MostrarMensaje()">

    <uc1:NavBar ID="NavBar1" runat="server" />

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
                                <asp:HyperLink ID="hlNuevoElementoConfiguracion" runat="server" NavigateUrl="~/CIsAsignarComponenetes.aspx">Nuevo Componente Elemento Configuracion</asp:HyperLink>
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
                                <asp:CheckBox ID="cbns" runat="server" CssClass="form-check-input position-static&quot" Font-Size="X-Small" Text="Nro. Serie" AutoPostBack="True" OnCheckedChanged="cbns_CheckedChanged"/>
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
                                 <asp:TextBox ID="txtns" runat="server" CssClass="form-control input-sm" MaxLength="25" Autocomplete = "off" placeholder="Ingresar Nro Serie CI" onchange=""
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
                                <asp:CheckBox ID="cbm" runat="server" CssClass="form-check-input position-static&quot" Font-Size="X-Small" Text="Marca" AutoPostBack="True" OnCheckedChanged="cbm_CheckedChanged"/>
                            </td>
                            <td style="text-align: left" >
                                <asp:CheckBox ID="cbs" runat="server" CssClass="form-check-input position-static&quot" Font-Size="X-Small" Text="Sede" AutoPostBack="True" OnCheckedChanged="cbs_CheckedChanged"/>
                            </td>
                            <td style="text-align: left" >
                                <asp:CheckBox ID="cbl" runat="server" CssClass="form-check-input position-static&quot" Font-Size="X-Small" Text="Local" AutoPostBack="True" OnCheckedChanged="cbl_CheckedChanged"/>
                            </td>
                            <td style="text-align: left" >
                                <asp:CheckBox ID="cba" runat="server" CssClass="form-check-input position-static&quot" Font-Size="X-Small" Text="Area" AutoPostBack="True" OnCheckedChanged="cba_CheckedChanged"/>
                            </td>
                            <td class="auto-style1">
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td style="text-align: left" >
                                <asp:DropDownList ID="ddlm" runat="server" CssClass="form-control input-sm"
                                            AppendDataBoundItems="True" Enabled="False"
                                           >
                                            <asp:ListItem Value="-1">_____SELECCIONE MARCA_____</asp:ListItem>
                                        </asp:DropDownList>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddls" runat="server" CssClass="form-control input-sm"
                                            AppendDataBoundItems="True" Enabled="False" OnSelectedIndexChanged="ddls_SelectedIndexChanged"
                                           >
                                            <asp:ListItem Value="-1">_____SELECCIONE SEDE_____</asp:ListItem>
                                        </asp:DropDownList>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddll" runat="server" CssClass="form-control input-sm"
                                            AppendDataBoundItems="True" AutoPostBack="True" Enabled="False" OnSelectedIndexChanged="ddll_SelectedIndexChanged"
                                           >
                                            <asp:ListItem Value="-1">_____SELECCIONE LOCAL_____</asp:ListItem>
                                        </asp:DropDownList>
                            </td>
                            <td class="auto-style1">
                                <asp:DropDownList ID="ddla" runat="server" CssClass="form-control input-sm"
                                            AppendDataBoundItems="True" Enabled="False"
                                           >
                                            <asp:ListItem Value="-1">_____SELECCIONE AREA_____</asp:ListItem>
                                        </asp:DropDownList>
                            </td>
                    <asp:HiddenField ID="__pagina" runat="server" />
                    <asp:HiddenField ID="__mensaje" runat="server" />
                    <asp:HiddenField ID="datosJson" runat="server" />
                </div>
            </div>
        </div>
    </form>

    <script type="text/javascript" src="Otros_css_js/resaltar.js"></script>

    <script type="text/javascript">
        // ========== LIST SECTION WITH SEARCH AND PAGINATION ==========
        var todosLosComponentes = [];
        var itemsPorPagina = 10;
        var paginaActual = 1;

        $(document).ready(function () {
            // Load data from hidden field
            var datosJson = document.getElementById('datosJson');
            if (datosJson && datosJson.value) {
                try {
                    todosLosComponentes = JSON.parse(datosJson.value);
                    renderizarTabla();
                } catch (e) {
                    console.error('Error parsing JSON:', e);
                }
            }

            // Search input event
            $('#txtBuscarComponente').on('keyup', function () {
                filtrarYRenderizar();
            });

            // Clear search button
            $('#btnLimpiarBusqueda').on('click', function () {
                $('#txtBuscarComponente').val('');
                filtrarYRenderizar();
            });
        });

        function filtrarYRenderizar() {
            var textoBusqueda = $('#txtBuscarComponente').val().toLowerCase().trim();

            if (textoBusqueda === '') {
                renderizarTabla();
            } else {
                var filtrados = todosLosComponentes.filter(function (item) {
                    return item.TIPO_COMPONENTE.toLowerCase().indexOf(textoBusqueda) !== -1 ||
                           item.DESCRIPCION.toLowerCase().indexOf(textoBusqueda) !== -1 ||
                           item.FABRICANTE.toLowerCase().indexOf(textoBusqueda) !== -1 ||
                           item.NRO_SERIE.toLowerCase().indexOf(textoBusqueda) !== -1 ||
                           item.MODELO.toLowerCase().indexOf(textoBusqueda) !== -1 ||
                           item.MARCA.toLowerCase().indexOf(textoBusqueda) !== -1;
                });
                renderizarTablaFiltrada(filtrados);
            }
        }

        function renderizarTablaFiltrada(datos) {
            var tbody = $('#tbodyComponentes');
            tbody.empty();

            if (datos.length === 0) {
                $('#divNoResults').removeClass('d-none');
                $('#tblComponentes').addClass('d-none');
                $('#spanInfoPagina').text('Mostrando 0 de 0');
                $('#ulPaginacion').empty();
                return;
            }

            $('#divNoResults').addClass('d-none');
            $('#tblComponentes').removeClass('d-none');

            // Paginate filtered results
            var totalPaginas = Math.ceil(datos.length / itemsPorPagina);
            if (paginaActual > totalPaginas) paginaActual = 1;

            var inicio = (paginaActual - 1) * itemsPorPagina;
            var fin = inicio + itemsPorPagina;
            var datosPagina = datos.slice(inicio, fin);

            // Render rows
            $.each(datosPagina, function (index, item) {
                var row = '<tr>' +
                    '<td>' + item.TIPO_COMPONENTE + '</td>' +
                    '<td>' + item.DESCRIPCION + '</td>' +
                    '<td>' + item.FABRICANTE + '</td>' +
                    '<td>' + item.NRO_SERIE + '</td>' +
                    '<td>' + item.MODELO + '</td>' +
                    '<td>' + item.MARCA + '</td>' +
                    '</tr>';
                tbody.append(row);
            });

            // Update info
            var totalMostrados = datos.length === 0 ? 0 : inicio + 1;
            var finRegistro = Math.min(fin, datos.length);
            $('#spanInfoPagina').text('Mostrando ' + totalMostrados + ' - ' + finRegistro + ' de ' + datos.length);

            // Render pagination
            renderizarPaginacion(totalPaginas, datos);
        }

        function renderizarTabla() {
            var tbody = $('#tbodyComponentes');
            tbody.empty();

            if (todosLosComponentes.length === 0) {
                $('#divNoResults').removeClass('d-none');
                $('#tblComponentes').addClass('d-none');
                $('#spanInfoPagina').text('Mostrando 0 de 0');
                $('#ulPaginacion').empty();
                return;
            }

            $('#divNoResults').addClass('d-none');
            $('#tblComponentes').removeClass('d-none');

            // Calculate pagination
            var totalPaginas = Math.ceil(todosLosComponentes.length / itemsPorPagina);
            if (paginaActual > totalPaginas) paginaActual = 1;

            var inicio = (paginaActual - 1) * itemsPorPagina;
            var fin = Math.min(inicio + itemsPorPagina, todosLosComponentes.length);

            // Render rows
            for (var i = inicio; i < fin; i++) {
                var item = todosLosComponentes[i];
                var row = '<tr>' +
                    '<td>' + item.TIPO_COMPONENTE + '</td>' +
                    '<td>' + item.DESCRIPCION + '</td>' +
                    '<td>' + item.FABRICANTE + '</td>' +
                    '<td>' + item.NRO_SERIE + '</td>' +
                    '<td>' + item.MODELO + '</td>' +
                    '<td>' + item.MARCA + '</td>' +
                    '</tr>';
                tbody.append(row);
            }

            // Update info
            var totalMostrados = todosLosComponentes.length === 0 ? 0 : inicio + 1;
            $('#spanInfoPagina').text('Mostrando ' + totalMostrados + ' - ' + fin + ' de ' + todosLosComponentes.length);

            // Render pagination
            renderizarPaginacion(totalPaginas, todosLosComponentes);
        }

        function renderizarPaginacion(totalPaginas, datosActuales) {
            var ul = $('#ulPaginacion');
            ul.empty();

            if (totalPaginas <= 1) {
                return;
            }

            var maxBotones = 5;
            var inicioRango = Math.max(1, paginaActual - Math.floor(maxBotones / 2));
            var finRango = Math.min(totalPaginas, inicioRango + maxBotones - 1);

            if (finRango - inicioRango < maxBotones - 1) {
                inicioRango = Math.max(1, finRango - maxBotones + 1);
            }

            // Previous button
            var prevDisabled = paginaActual === 1 ? 'disabled' : '';
            ul.append('<li class="page-item ' + prevDisabled + '"><a class="page-link" href="#" aria-label="Anterior"><span aria-hidden="true">&laquo;</span></a></li>');

            // Page numbers
            for (var i = inicioRango; i <= finRango; i++) {
                var activeClass = i === paginaActual ? 'active' : '';
                ul.append('<li class="page-item ' + activeClass + '"><a class="page-link" href="#">' + i + '</a></li>');
            }

            // Next button
            var nextDisabled = paginaActual === totalPaginas ? 'disabled' : '';
            ul.append('<li class="page-item ' + nextDisabled + '"><a class="page-link" href="#" aria-label="Siguiente"><span aria-hidden="true">&raquo;</span></a></li>');

            // Bind click events
            $('#ulPaginacion li.page-item a').not('.disabled').on('click', function (e) {
                e.preventDefault();
                var texto = $(this).text().trim();
                var textoLower = texto.toLowerCase();

                if (textoLower === '«') {
                    textoLower = 'anterior';
                } else if (textoLower === '»') {
                    textoLower = 'siguiente';
                }

                if (textoLower === 'anterior') {
                    if (paginaActual > 1) {
                        paginaActual--;
                        var textoBusqueda = $('#txtBuscarComponente').val().toLowerCase().trim();
                        if (textoBusqueda === '') {
                            renderizarTabla();
                        } else {
                            var filtrados = todosLosComponentes.filter(function (item) {
                                return item.TIPO_COMPONENTE.toLowerCase().indexOf(textoBusqueda) !== -1 ||
                                       item.DESCRIPCION.toLowerCase().indexOf(textoBusqueda) !== -1 ||
                                       item.FABRICANTE.toLowerCase().indexOf(textoBusqueda) !== -1 ||
                                       item.NRO_SERIE.toLowerCase().indexOf(textoBusqueda) !== -1 ||
                                       item.MODELO.toLowerCase().indexOf(textoBusqueda) !== -1 ||
                                       item.MARCA.toLowerCase().indexOf(textoBusqueda) !== -1;
                            });
                            renderizarTablaFiltrada(filtrados);
                        }
                    }
                } else if (textoLower === 'siguiente') {
                    if (paginaActual < totalPaginas) {
                        paginaActual++;
                        var textoBusqueda = $('#txtBuscarComponente').val().toLowerCase().trim();
                        if (textoBusqueda === '') {
                            renderizarTabla();
                        } else {
                            var filtrados = todosLosComponentes.filter(function (item) {
                                return item.TIPO_COMPONENTE.toLowerCase().indexOf(textoBusqueda) !== -1 ||
                                       item.DESCRIPCION.toLowerCase().indexOf(textoBusqueda) !== -1 ||
                                       item.FABRICANTE.toLowerCase().indexOf(textoBusqueda) !== -1 ||
                                       item.NRO_SERIE.toLowerCase().indexOf(textoBusqueda) !== -1 ||
                                       item.MODELO.toLowerCase().indexOf(textoBusqueda) !== -1 ||
                                       item.MARCA.toLowerCase().indexOf(textoBusqueda) !== -1;
                            });
                            renderizarTablaFiltrada(filtrados);
                        }
                    }
                } else {
                    var nuevaPagina = parseInt(texto);
                    if (!isNaN(nuevaPagina) && nuevaPagina >= 1 && nuevaPagina <= totalPaginas) {
                        paginaActual = nuevaPagina;
                        var textoBusqueda = $('#txtBuscarComponente').val().toLowerCase().trim();
                        if (textoBusqueda === '') {
                            renderizarTabla();
                        } else {
                            var filtrados = todosLosComponentes.filter(function (item) {
                                return item.TIPO_COMPONENTE.toLowerCase().indexOf(textoBusqueda) !== -1 ||
                                       item.DESCRIPCION.toLowerCase().indexOf(textoBusqueda) !== -1 ||
                                       item.FABRICANTE.toLowerCase().indexOf(textoBusqueda) !== -1 ||
                                       item.NRO_SERIE.toLowerCase().indexOf(textoBusqueda) !== -1 ||
                                       item.MODELO.toLowerCase().indexOf(textoBusqueda) !== -1 ||
                                       item.MARCA.toLowerCase().indexOf(textoBusqueda) !== -1;
                            });
                            renderizarTablaFiltrada(filtrados);
                        }
                    }
                }
            });
        }
    </script>

</body>
</html>
