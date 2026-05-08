<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Sede.aspx.cs" Inherits="TiposElementoConfiguracion" UnobtrusiveValidationMode="None" %>
<%@ Register src="NavBar.ascx" tagname="NavBar" tagprefix="uc1" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>Sede</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet" />
    <link href="CssJs/global-styles.css" rel="stylesheet" />

    <style>
        .table-wrapper {
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 4px 25px rgba(0,0,0,0.08);
            padding: 1.5rem;
            border: 1px solid rgba(0,0,0,0.05);
            margin-top: 1.5rem;
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
        .btn-accion {
            padding: 0.25rem 0.5rem;
            font-size: 0.75rem;
            border-radius: 6px;
            text-decoration: none;
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
        .top-spacer { height: 100px; }
        .pagination-wrapper {
            display: flex;
            justify-content: center;
            margin-top: 1.5rem;
        }
        .page-info {
            text-align: center;
            margin-top: 1rem;
            color: #6c757d;
            font-size: 0.9rem;
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
    </style>

    <script lang="javascript" type="text/javascript">
        function MostrarMensaje() {
            var mensaje = document.getElementById("__mensaje").value;
            if (mensaje != "") {
                alert(mensaje);
                if (document.getElementById("__pagina").value != "")
                    location.href = document.getElementById("__pagina").value;
            }
        }
        function Confirmar(men) { if (!confirm(men)) return false; return true; }
        function SoloNumeros() { if ((event.keyCode < 48) || (event.keyCode > 57)) event.returnValue = false; }
        function SoloLetrasMinusculas() {
            if (!((event.keyCode >= 97 && event.keyCode <= 122) || event.keyCode == 32 || event.keyCode == 193 || event.keyCode == 201 || event.keyCode == 205 || event.keyCode == 209 || event.keyCode == 211 || event.keyCode == 218 || event.keyCode == 220 || event.keyCode == 241)) event.returnValue = false;
        }
        function CambiaLetraMayuscula(Caja) { document.getElementById(Caja).value = document.getElementById(Caja).value.toUpperCase(); }
    </script>

    <script type="text/javascript" src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body onload="MostrarMensaje()">

    <uc1:NavBar ID="NavBar1" runat="server" />
    <div class="top-spacer"></div>

    <form id="form1" runat="server">
        <div class="container">

            <div class="form-card">
                <div class="card-header">
                    <i class="bi bi-building me-2"></i>Ingrese Datos de Sede
                </div>
                <div class="card-body p-3">
                    <div class="row g-2 mb-2">
                        <div class="col-md-3 col-sm-6">
                            <label class="form-label-modern">C&oacute;digo Sede</label>
                            <asp:TextBox ID="CodIgo_Sede" runat="server" CssClass="form-control form-control-modern"
                                         MaxLength="2" Autocomplete="off" placeholder="Ingrese c&oacute;digo"
                                         onkeypress="SoloNumeros()" />
                            <asp:RequiredFieldValidator ID="rfvCodIgo_Sede" runat="server" ControlToValidate="CodIgo_Sede"
                                                       ErrorMessage="*" CssClass="validator-error" />
                        </div>
                        <div class="col-md-6 col-sm-6">
                            <label class="form-label-modern">Nombre Sede</label>
                            <asp:TextBox ID="Descripcion_Sede" runat="server" CssClass="form-control form-control-modern"
                                         MaxLength="25" Autocomplete="off" placeholder="Ingrese nombre sede"
                                         onchange="CambiaLetraMayuscula('Descripcion_Sede')"
                                         onkeypress="SoloLetrasMinusculas()" />
                            <asp:RequiredFieldValidator ID="rfvDescripcion_Sede" runat="server" ControlToValidate="Descripcion_Sede"
                                                       ErrorMessage="*" CssClass="validator-error" />
                        </div>
                    </div>
                    <div class="d-flex flex-wrap gap-2 justify-content-center">
                        <asp:Button ID="btnRegistrar" runat="server" Text="Registrar" CssClass="btn btn-success btn-modern"
                                    Visible="False" OnClick="btnRegistrar_Click"
                                    OnClientClick="return Confirmar('¿Desea registrar sede?');" />
                        <asp:Button ID="btnModificar" runat="server" Text="Modificar" CssClass="btn btn-warning btn-modern"
                                    Visible="False" OnClick="btnModificar_Click"
                                    OnClientClick="return Confirmar('¿Desea modificar sede?');" />
                        <asp:Button ID="btnEliminar" runat="server" Text="Eliminar" CssClass="btn btn-danger btn-modern"
                                    Visible="False" OnClick="btnEliminar_Click"
                                    OnClientClick="return Confirmar('¿Desea eliminar sede?');" />
                        <asp:Button ID="btnCancelar" runat="server" Text="Cancelar" CssClass="btn btn-secondary btn-modern"
                                    Visible="False" OnClick="btnCancelar_Click" CausesValidation="False" />
                    </div>
                </div>
            </div>

            <div class="table-wrapper">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h4 class="mb-0"><i class="bi bi-list-ul me-2"></i>Listado de Sedes</h4>
                </div>

                <div class="row mb-3">
                    <div class="col-md-6">
                        <div class="input-group">
                            <span class="input-group-text bg-white border-end-0">
                                <i class="bi bi-search text-muted"></i>
                            </span>
                            <input type="text" id="txtBusqueda" class="form-control border-start-0 search-input"
                                placeholder="Buscar en todos los campos..." onkeyup="filtrarTabla(this.value)" />
                        </div>
                    </div>
                    <div class="col-md-6 text-end">
                        <span id="lblTotal" class="text-muted small"></span>
                    </div>
                </div>

                <div class="table-responsive">
                    <table id="tblSedes" class="table table-modern table-hover">
                        <thead>
                            <tr>
                                <th>C&Oacute;DIGO</th>
                                <th>NOMBRE SEDE</th>
                                <th>ACCIONES</th>
                            </tr>
                        </thead>
                        <tbody id="tbodySedes">
                        </tbody>
                    </table>
                </div>

                <div class="pagination-wrapper" id="pagination"></div>
                <div class="page-info" id="pageInfo"></div>
            </div>

            <asp:HiddenField ID="__mensaje" runat="server" />
            <asp:HiddenField ID="__pagina" runat="server" />
            <asp:HiddenField ID="Id_Sede" runat="server" Value="0" EnableViewState="False" />
            <asp:HiddenField ID="datosJson" runat="server" Value="" />

        </div>
    </form>

    <script lang="javascript" type="text/javascript">
        var datosCompletos = [];
        var paginaActual = 1;
        var tamanioPagina = 10;

        function filtrarTabla(texto) {
            texto = texto.toUpperCase();
            var datosFiltrados = [];
            for (var i = 0; i < datosCompletos.length; i++) {
                var row = datosCompletos[i];
                var textoFila = (row.CODIGO || '') + ' ' + (row.SEDE || '');
                if (textoFila.toUpperCase().indexOf(texto) > -1) {
                    datosFiltrados.push(row);
                }
            }
            paginaActual = 1;
            renderizarTabla(datosFiltrados);
            var totalPaginas = Math.ceil(datosFiltrados.length / tamanioPagina);
            generarPaginacion(totalPaginas, paginaActual);
            document.getElementById('lblTotal').textContent = 'Total: ' + datosFiltrados.length + ' elementos';
        }

        function Paginar(pagina) {
            paginaActual = pagina;
            var inicio = (pagina - 1) * tamanioPagina;
            var fin = inicio + tamanioPagina;
            var datosPagina = datosCompletos.slice(inicio, fin);
            renderizarTabla(datosPagina);
            var totalPaginas = Math.ceil(datosCompletos.length / tamanioPagina);
            generarPaginacion(totalPaginas, pagina);
            document.getElementById('pageInfo').textContent = 'Pagina ' + pagina + ' de ' + totalPaginas + ' (Total: ' + datosCompletos.length + ' registros)';
            document.querySelector('.table-wrapper').scrollIntoView({ behavior: 'smooth' });
        }

        function renderizarTabla(datos) {
            var tbody = document.getElementById('tbodySedes');
            var sb = '';
            if (datos.length === 0) {
                tbody.innerHTML = '<tr><td colspan="3" class="text-center text-muted py-4">No se encontraron elementos</td></tr>';
                return;
            }
            for (var i = 0; i < datos.length; i++) {
                var row = datos[i];
                sb += '<tr>';
                sb += '<td>' + htmlEncode(row.CODIGO) + '</td>';
                sb += '<td>' + htmlEncode(row.SEDE) + '</td>';
                sb += '<td class="text-center">';
                sb += '<a href="Sede.aspx?Operacion=M&IdSede=' + htmlEncode(row.ID) + '" class="btn btn-primary btn-sm btn-accion me-1">Editar</a>';
                sb += '<a href="Sede.aspx?Operacion=E&IdSede=' + htmlEncode(row.ID) + '" class="btn btn-danger btn-sm btn-accion" onclick="return confirm(\'¿Esta seguro de eliminar esta sede?\');">Eliminar</a>';
                sb += '</td>';
                sb += '</tr>';
            }
            tbody.innerHTML = sb;
        }

        function htmlEncode(str) {
            if (!str) return '';
            return String(str).replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/"/g, '&quot;');
        }

        function generarPaginacion(totalPaginas, pagina) {
            var pagination = document.getElementById('pagination');
            if (!pagination) return;
            if (totalPaginas <= 1) { pagination.innerHTML = ''; return; }
            var sb = '<nav><ul class="pagination mb-0">';
            if (pagina > 1) {
                sb += '<li class="page-item"><a class="page-link" href="javascript:Paginar(' + (pagina - 1) + ')">Anterior</a></li>';
            } else {
                sb += '<li class="page-item disabled"><span class="page-link">Anterior</span></li>';
            }
            var inicio = Math.max(1, pagina - 2);
            var fin = Math.min(totalPaginas, pagina + 2);
            if (inicio > 1) {
                sb += '<li class="page-item"><a class="page-link" href="javascript:Paginar(1)">1</a></li>';
                if (inicio > 2) sb += '<li class="page-item disabled"><span class="page-link">...</span></li>';
            }
            for (var i = inicio; i <= fin; i++) {
                if (i === pagina) {
                    sb += '<li class="page-item active"><span class="page-link">' + i + '</span></li>';
                } else {
                    sb += '<li class="page-item"><a class="page-link" href="javascript:Paginar(' + i + ')">' + i + '</a></li>';
                }
            }
            if (fin < totalPaginas) {
                if (fin < totalPaginas - 1) sb += '<li class="page-item disabled"><span class="page-link">...</span></li>';
                sb += '<li class="page-item"><a class="page-link" href="javascript:Paginar(' + totalPaginas + ')">' + totalPaginas + '</a></li>';
            }
            if (pagina < totalPaginas) {
                sb += '<li class="page-item"><a class="page-link" href="javascript:Paginar(' + (pagina + 1) + ')">Siguiente</a></li>';
            } else {
                sb += '<li class="page-item disabled"><span class="page-link">Siguiente</span></li>';
            }
            sb += '</ul></nav>';
            pagination.innerHTML = sb;
        }

        function inicializarDatos() {
            var datosJsonField = document.getElementById('datosJson');
            if (datosJsonField && datosJsonField.value) {
                try {
                    datosCompletos = JSON.parse(datosJsonField.value);
                    Paginar(1);
                } catch (e) { console.error('Error parsing JSON:', e); }
            }
        }
        if (window.addEventListener) {
            window.addEventListener('load', inicializarDatos, false);
        } else if (window.attachEvent) {
            window.attachEvent('onload', inicializarDatos);
        }
    </script>

</body>
</html>