<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Area.aspx.cs" Inherits="Area" UnobtrusiveValidationMode="None" %>
<%@ Register src="NavBar.ascx" tagname="NavBar" tagprefix="uc1" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>Area</title>

    <!-- Bootstrap 5.3 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet" />
    <!-- Global Styles -->
    <link href="CssJs/global-styles.css" rel="stylesheet" />

    <style>
        /* ===== PAGINACION MANUAL ===== */
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
    </style>

    <script lang="javascript" type="text/javascript">
        function abrir_ventana_busca_Local_Judicial() {
            window.document.getElementById("hfCodigo_Local_Judicial").value = 0;
            window.document.getElementById("Local_Judicial").value = "";
            var options = 'channelmode=1,directories=0,fullscreen=0,location=0,menubar=0,resizable=0,titlebar=0,toolbar=0,edge=Raised,status=no,scrollbars=1,width=1400,height=550,top=50px, left=140px';
            window.open('Ventanas/ventanaLocal.aspx', '', options);
        }

        function MostrarMensaje() {
            var mensaje = document.getElementById("__mensaje").value;
            if (mensaje != "") {
                alert(mensaje);
                var pagina = document.getElementById("__pagina").value;
                if (pagina !== "") location.href = pagina;
            }
            document.getElementById('<%= Local_Judicial.ClientID %>').readOnly = true;
        }

        function Confirmar(men) {
            if (!confirm(men)) return false;
            return true;
        }

        function SoloNumeros() {
            if ((event.keyCode < 48) || (event.keyCode > 57)) {
                event.returnValue = false;
            }
        }

        function SoloLetrasMinusculas() {
            if (!((event.keyCode >= 97 && event.keyCode <= 122) || event.keyCode == 32
                || event.keyCode == 193 || event.keyCode == 201 || event.keyCode == 205
                || event.keyCode == 209 || event.keyCode == 211 || event.keyCode == 218
                || event.keyCode == 220 || event.keyCode == 241)) {
                event.returnValue = false;
            }
        }

        function CambiaLetraMayuscula(Caja) {
            document.getElementById(Caja).value = document.getElementById(Caja).value.toUpperCase();
        }

        // ========== LISTA AREAS CON PAGINACION ==========
        var datosAreas = [];
        var itemsPorPagina = 10;
        var paginaActual = 1;

        function cargarDatosAreas() {
            var input = document.getElementById('datosJson');
            if (input && input.value) {
                try {
                    datosAreas = JSON.parse(input.value);
                    filtrarAreas();
                } catch (e) {
                    console.error('Error parsing JSON:', e);
                }
            }
        }

        function filtrarAreas() {
            var textoBusqueda = document.getElementById('txtBuscarArea').value.toLowerCase().trim();
            var datosFiltrados;

            if (textoBusqueda === "") {
                datosFiltrados = datosAreas;
            } else {
                datosFiltrados = datosAreas.filter(function(item) {
                    return item.CODIGOAREA.toLowerCase().indexOf(textoBusqueda) !== -1 ||
                           item.AREA.toLowerCase().indexOf(textoBusqueda) !== -1 ||
                           item.SEDE.toLowerCase().indexOf(textoBusqueda) !== -1 ||
                           item.LOCAL.toLowerCase().indexOf(textoBusqueda) !== -1 ||
                           item.DIRECCIONLOCAL.toLowerCase().indexOf(textoBusqueda) !== -1;
                });
            }

            paginaActual = 1;
            mostrarPagina(datosFiltrados);
            generarPaginacion(Math.ceil(datosFiltrados.length / itemsPorPagina), datosFiltrados.length);
            document.getElementById('lblTotalAreas').textContent = 'Total: ' + datosFiltrados.length + ' elementos';
        }

        function mostrarPagina(datos) {
            var tbody = document.getElementById('tbodyAreas');
            var totalPaginas = Math.ceil(datos.length / itemsPorPagina);
            var inicio = (paginaActual - 1) * itemsPorPagina;
            var fin = inicio + itemsPorPagina;
            var datosPagina = datos.slice(inicio, fin);

            // Limpiar tabla
            tbody.innerHTML = '';

            if (datosPagina.length === 0) {
                tbody.innerHTML = '<tr><td colspan="8" class="text-center text-muted py-4">No se encontraron elementos</td></tr>';
                return;
            }

            // Llenar tabla
            for (var i = 0; i < datosPagina.length; i++) {
                var item = datosPagina[i];
                var row = document.createElement('tr');
                row.innerHTML =
                    '<td>' + htmlEncode(item.SEDE) + '</td>' +
                    '<td>' + htmlEncode(item.LOCAL) + '</td>' +
                    '<td>' + htmlEncode(item.DIRECCIONLOCAL) + '</td>' +
                    '<td>' + htmlEncode(item.CODIGOAREA) + '</td>' +
                    '<td>' + htmlEncode(item.AREA) + '</td>' +
                    '<td>' + htmlEncode(item.NROPISO) + '</td>' +
                    '<td>' + htmlEncode(item.NROAMBIENTE) + '</td>' +
                    '<td class="text-center"><button type="button" class="btn btn-primary btn-sm btn-accion me-1" onclick="seleccionarArea(\'' + item.IDAREA + '\', \'' + item.CODIGOAREA + '\', \'' + item.AREA.replace(/'/g, "\\'") + '\', \'' + item.NROPISO + '\', \'' + item.NROAMBIENTE + '\', \'' + item.IDLOCAL + '\', \'' + item.LOCAL.replace(/'/g, "\\'") + '\')"><i class="bi bi-pencil-square"></i> Seleccionar</button></td>';
                tbody.appendChild(row);
            }
        }

        function htmlEncode(str) {
            if (!str) return '';
            return String(str).replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/"/g, '&quot;');
        }

        function generarPaginacion(totalPaginas, totalItems) {
            var pagination = document.getElementById('paginationAreas');
            var pageInfo = document.getElementById('pageInfoArea');
            if (!pagination) return;

            pagination.innerHTML = '';
            if (totalPaginas <= 1) {
                pageInfo.textContent = '';
                return;
            }

            var sb = '<nav><ul class="pagination mb-0">';

            // Anterior
            if (paginaActual > 1) {
                sb += '<li class="page-item"><a class="page-link" href="javascript:PaginarAreas(' + (paginaActual - 1) + ')">Anterior</a></li>';
            } else {
                sb += '<li class="page-item disabled"><span class="page-link">Anterior</span></li>';
            }

            // Numeros de pagina (rango de 2 antes y despues)
            var inicio = Math.max(1, paginaActual - 2);
            var fin = Math.min(totalPaginas, paginaActual + 2);

            if (inicio > 1) {
                sb += '<li class="page-item"><a class="page-link" href="javascript:PaginarAreas(1)">1</a></li>';
                if (inicio > 2) sb += '<li class="page-item disabled"><span class="page-link">...</span></li>';
            }

            for (var i = inicio; i <= fin; i++) {
                if (i === paginaActual) {
                    sb += '<li class="page-item active"><span class="page-link">' + i + '</span></li>';
                } else {
                    sb += '<li class="page-item"><a class="page-link" href="javascript:PaginarAreas(' + i + ')">' + i + '</a></li>';
                }
            }

            if (fin < totalPaginas) {
                if (fin < totalPaginas - 1) sb += '<li class="page-item disabled"><span class="page-link">...</span></li>';
                sb += '<li class="page-item"><a class="page-link" href="javascript:PaginarAreas(' + totalPaginas + ')">' + totalPaginas + '</a></li>';
            }

            // Siguiente
            if (paginaActual < totalPaginas) {
                sb += '<li class="page-item"><a class="page-link" href="javascript:PaginarAreas(' + (paginaActual + 1) + ')">Siguiente</a></li>';
            } else {
                sb += '<li class="page-item disabled"><span class="page-link">Siguiente</span></li>';
            }

            sb += '</ul></nav>';
            pagination.innerHTML = sb;

            pageInfo.textContent = 'Pagina ' + paginaActual + ' de ' + totalPaginas + ' (Total: ' + totalItems + ' registros)';
        }

        function PaginarAreas(pagina) {
            var textoBusqueda = document.getElementById('txtBuscarArea').value.toLowerCase().trim();
            var datosFiltrados;

            if (textoBusqueda === "") {
                datosFiltrados = datosAreas;
            } else {
                datosFiltrados = datosAreas.filter(function(item) {
                    return item.CODIGOAREA.toLowerCase().indexOf(textoBusqueda) !== -1 ||
                           item.AREA.toLowerCase().indexOf(textoBusqueda) !== -1 ||
                           item.SEDE.toLowerCase().indexOf(textoBusqueda) !== -1 ||
                           item.LOCAL.toLowerCase().indexOf(textoBusqueda) !== -1 ||
                           item.DIRECCIONLOCAL.toLowerCase().indexOf(textoBusqueda) !== -1;
                });
            }

            paginaActual = pagina;
            mostrarPagina(datosFiltrados);
            generarPaginacion(Math.ceil(datosFiltrados.length / itemsPorPagina), datosFiltrados.length);
            document.querySelector('.table-wrapper').scrollIntoView({ behavior: 'smooth' });
        }

        function seleccionarArea(idArea, codigoArea, area, nroPiso, nroAmbiente, idLocal, local) {
            document.getElementById('Id_Area').value = idArea;
            document.getElementById('Codigo_Area').value = codigoArea;
            document.getElementById('Descripcion_Area').value = area;
            document.getElementById('Nro_Piso').value = nroPiso;
            document.getElementById('Nro_Ambiente').value = nroAmbiente;
            document.getElementById('hfCodigo_Local_Judicial').value = idLocal;
            document.getElementById('Local_Judicial').value = local;

            document.getElementById('btnRegistrar').style.display = 'none';
            document.getElementById('btnModificar').style.display = '';
            document.getElementById('btnEliminar').style.display = '';
            document.getElementById('btnCancelar').style.display = '';

            // Scroll al formulario
            document.querySelector('.form-card').scrollIntoView({ behavior: 'smooth' });
        }

        // Cargar datos al iniciar la pagina
        window.addEventListener('load', function() {
            cargarDatosAreas();
        });

        function Activa(Opcion) {
            if (Opcion == 1) {
                if (document.getElementById('cbs').checked == true) {
                    document.getElementById("ddls").disabled = ""
                } else {
                    document.getElementById("ddls").selectedIndex = 0
                    document.getElementById("ddls").disabled = "disabled"
                }
            } else if (Opcion == 2) {
                if (document.getElementById('cbl').checked == true) {
                    document.getElementById("ddll").disabled = ""
                } else {
                    document.getElementById("ddll").selectedIndex = 0
                    document.getElementById("ddll").disabled = "disabled"
                }
            }
        }
    </script>

    <script type="text/javascript" src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body onload="MostrarMensaje()">

    <uc1:NavBar ID="NavBar1" runat="server" />

    <!-- ========== FORMULARIO ========== -->
    <form id="form1" runat="server">
        <div class="container">

            <!-- Card Formulario -->
            <div class="form-card">
                <div class="card-header">
                    <i class="bi bi-grid-3x3-gap me-2"></i>Ingrese Datos &Aacute;rea
                </div>
                <div class="card-body p-3">

                    <!-- Fila 1: Codigo -->
                    <div class="row g-2 mb-2">
                        <div class="col-md-6 col-sm-6">
                            <label class="form-label-modern">C&oacute;digo</label>
                            <asp:TextBox ID="Codigo_Area" runat="server" CssClass="form-control form-control-modern"
                                         MaxLength="6" Autocomplete="off" placeholder="Ingrese c&oacute;digo &aacute;rea"
                                         onkeypress="SoloNumeros()" />
                            <asp:RequiredFieldValidator ID="rfvCodigo_Area" runat="server" ControlToValidate="Codigo_Area"
                                                       ErrorMessage="*" CssClass="validator-error" />
                        </div>
                    </div>

                    <!-- Fila 2: Nombre -->
                    <div class="row g-2 mb-2">
                        <div class="col-md-6 col-sm-6">
                            <label class="form-label-modern">Nombre</label>
                            <asp:TextBox ID="Descripcion_Area" runat="server" CssClass="form-control form-control-modern"
                                         MaxLength="50" Autocomplete="off" placeholder="Ingrese nombre &aacute;rea"
                                         onchange="CambiaLetraMayuscula('Descripcion_Area')" onkeypress="SoloLetrasMinusculas()" />
                            <asp:RequiredFieldValidator ID="rfvDescripcion_Area" runat="server" ControlToValidate="Descripcion_Area"
                                                       ErrorMessage="*" CssClass="validator-error" />
                        </div>
                    </div>

                    <!-- Fila 3: Nro Piso -->
                    <div class="row g-2 mb-2">
                        <div class="col-md-3 col-sm-6">
                            <label class="form-label-modern">Nro. Piso</label>
                            <asp:TextBox ID="Nro_Piso" runat="server" CssClass="form-control form-control-modern"
                                         MaxLength="1" Autocomplete="off" placeholder="N&uacute;mero piso"
                                         onkeypress="SoloNumeros()" />
                            <asp:RequiredFieldValidator ID="rfvNro_Piso" runat="server" ControlToValidate="Nro_Piso"
                                                       ErrorMessage="*" CssClass="validator-error" />
                        </div>
                    </div>

                    <!-- Fila 4: Nro Ambiente -->
                    <div class="row g-2 mb-2">
                        <div class="col-md-3 col-sm-6">
                            <label class="form-label-modern">Nro. Ambiente</label>
                            <asp:TextBox ID="Nro_Ambiente" runat="server" CssClass="form-control form-control-modern"
                                         MaxLength="3" Autocomplete="off" placeholder="N&uacute;mero ambiente"
                                         onkeypress="SoloNumeros()" />
                            <asp:RequiredFieldValidator ID="rfvNro_Ambiente" runat="server" ControlToValidate="Nro_Ambiente"
                                                       ErrorMessage="*" CssClass="validator-error" />
                        </div>
                    </div>

                    <!-- Fila 5: Local Judicial -->
                    <div class="row g-3 mb-4">
                        <div class="col-md-6 col-sm-6">
                            <label class="form-label-modern">Local Judicial</label>
                            <div class="input-group">
                                <asp:TextBox ID="Local_Judicial" runat="server" CssClass="form-control form-control-modern"
                                             MaxLength="25" Autocomplete="off" placeholder="Ingrese local judicial"
                                             onchange="CambiaLetraMayuscula('Local_Judicial')" onkeypress="SoloLetrasMinusculas()" />
                                <asp:Button ID="ibtnBUSCAR_LOCAL_JUDICIAL" runat="server" CausesValidation="False"
                                                 CssClass="btn btn-info btn-modern"
                                                 ToolTip="Buscar Local Judicial" OnClientClick="abrir_ventana_busca_Local_Judicial();" Text="..." />
                            </div>
                            <asp:RequiredFieldValidator ID="rfvLocal_Judicial" runat="server" ControlToValidate="Local_Judicial"
                                                       ErrorMessage="*" CssClass="validator-error" />
                            <asp:HiddenField ID="hfCodigo_Local_Judicial" runat="server" Value="0" />
                        </div>
                    </div>

                    <!-- Botones de accion -->
                    <div class="d-flex flex-wrap gap-2 justify-content-center">
                        <asp:Button ID="btnRegistrar" runat="server" Text="Registrar" CssClass="btn btn-success btn-modern"
                                    OnClick="btnRegistrar_Click"
                                    OnClientClick="return Confirmar('¿Desea registrar &Aacute;rea?');" />
                        <asp:Button ID="btnModificar" runat="server" Text="Modificar" CssClass="btn btn-warning btn-modern"
                                    OnClick="btnModificar_Click"
                                    OnClientClick="return Confirmar('¿Desea modificar &Aacute;rea?');" />
                        <asp:Button ID="btnEliminar" runat="server" Text="Eliminar" CssClass="btn btn-danger btn-modern"
                                    OnClick="btnEliminar_Click"
                                    OnClientClick="return Confirmar('¿Desea eliminar &Aacute;rea?');" />
                        <asp:Button ID="btnCancelar" runat="server" Text="Cancelar" CssClass="btn btn-secondary btn-modern"
                                    OnClick="btnCancelar_Click" CausesValidation="False" />
                    </div>
                </div>
            </div>

            <!-- ========== LISTA DE AREAS CON BUSQUEDA Y PAGINACION ========== -->
            <div class="form-card mt-4" id="listaAreasSection">
                <div class="card-header">
                    <i class="bi bi-list-ul me-2"></i>Listado de &Aacute;reas
                </div>
                <div class="card-body p-3">
                    <!-- Buscador -->
                    <div class="row mb-3">
                        <div class="col-md-6 col-sm-6">
                            <div class="input-group">
                                <span class="input-group-text bg-white border-end-0">
                                    <i class="bi bi-search text-muted"></i>
                                </span>
                                <input type="text" id="txtBuscarArea" class="form-control border-start-0 search-input"
                                    placeholder="Buscar por c&oacute;digo, nombre, sede o local..."
                                    onkeyup="filtrarAreas()" />
                            </div>
                        </div>
                        <div class="col-md-6 col-sm-6 text-end">
                            <span id="lblTotalAreas" class="badge bg-secondary"></span>
                        </div>
                    </div>

                    <!-- Tabla HTML de Areas -->
                    <div class="table-responsive">
                        <table class="table table-modern table-hover" id="tblAreas">
                            <thead>
                                <tr>
                                    <th>SEDE</th>
                                    <th>LOCAL</th>
                                    <th>DIRECCI&Oacute;N LOCAL</th>
                                    <th>C&Oacute;DIGO AREA</th>
                                    <th>&Aacute;REA</th>
                                    <th>NRO PISO</th>
                                    <th>NRO AMBIENTE</th>
                                    <th>ACCI&Oacute;N</th>
                                </tr>
                            </thead>
                            <tbody id="tbodyAreas">
                            </tbody>
                        </table>
                    </div>

                    <!-- Paginacion -->
                    <div class="pagination-wrapper" id="paginationAreas">
                    </div>
                    <div class="page-info" id="pageInfoArea"></div>
                </div>
            </div>

            <!-- Hidden Fields -->
            <asp:HiddenField ID="__mensaje" runat="server" />
            <asp:HiddenField ID="__pagina" runat="server" />
            <asp:HiddenField ID="Id_Area" runat="server" Value="0" EnableViewState="False" />
            <asp:HiddenField ID="datosJson" runat="server" />

        </div>
    </form>

    <script type="text/javascript" src="Otros_css_js/resaltar.js"></script>

</body>
</html>
