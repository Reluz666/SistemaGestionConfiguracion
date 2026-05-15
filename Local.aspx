<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Local.aspx.cs" Inherits="Local" UnobtrusiveValidationMode="None" %>
<%@ Register src="NavBar.ascx" tagname="NavBar" tagprefix="uc1" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>Local</title>

    <!-- Bootstrap 5.3 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet" />
    <!-- Global Styles -->
    <link href="CssJs/global-styles.css" rel="stylesheet" />

    <style>
        /* ===== PAGINACION MANUAL (Bootstrap-only, sin DataTables) ===== */
        .pagination-wrapper {
            display: flex;
            justify-content: center;
            margin-top: 1.5rem;
        }

        .position-static {
            text-align: left;
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
        function abrir_ventana_busca_Ubicacion_Geografica() {
            window.document.getElementById("hfCodigo_Ubicacion_Geografica").value = 0;
            window.document.getElementById("Ubicacion_Geografica").value = "";
            var options = 'channelmode=1,directories=0,fullscreen=0,location=0,menubar=0,resizable=0,titlebar=0,toolbar=0,edge=Raised,status=no,scrollbars=1,width=1400,height=550,top=50px, left=140px';
            window.open('Ventanas/ventanaUbigeo.aspx', '', options);
        }

        function MostrarMensaje() {
            var mensaje = document.getElementById("__mensaje").value;
            if (mensaje != "") {
                alert(mensaje);
                if (document.getElementById("__pagina").value != "")
                    location.href = document.getElementById("__pagina").value;

            }

            document.getElementById('<%= Ubicacion_Geografica.ClientID %>').readOnly = true;

        }

        function window_load() {
            MostrarMensaje()
        }

        function Confirmar(men) {
            if (!confirm(men))
                return false;

        }

        function SoloNumeros() {
            if ((event.keyCode < 48) || (event.keyCode > 57)) {
                event.returnValue = false;
         }
        }

        function Activa(Opcion) {
            if (Opcion==1){
            document.getElementById("nl").value = ""
            if (document.getElementById('cbnl').checked == true) {
                document.getElementById("nl").disabled = ""
            } else {
                document.getElementById("nl").disabled = "disabled"
            }
            document.getElementById("nl").focus()
            } else if (Opcion == 2) {
                if (document.getElementById('cbs').checked == true) {
                    document.getElementById("ddls").disabled = ""
                } else {
                    document.getElementById("ddls").disabled = "disabled"
                }

            }

        }
    </script>

    <script type="text/javascript" src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body onload="MostrarMensaje()">

    <uc1:NavBar ID="NavBar1" runat="server" />

    <!-- ========== LIST VIEW SECTION ========== -->
    <div class="container">
        <div class="form-card mt-4">
            <div class="card-header">
                <i class="bi bi-list-ul me-2"></i>Lista de Locales
            </div>
            <div class="card-body p-3">
                <!-- Buscador -->
                <div class="row mb-3">
                    <div class="col-md-6">
                        <div class="input-group">
                            <span class="input-group-text bg-white border-end-0">
                                <i class="bi bi-search text-muted"></i>
                            </span>
                            <input type="text" id="txtBuscarLocal" class="form-control border-start-0 search-input"
                                   placeholder="Buscar por c&oacute;digo, nombre, direcci&oacute;n o sede..."
                                   onkeyup="filtrarLocales()" />
                        </div>
                    </div>
                    <div class="col-md-6 text-end">
                        <span id="lblTotalRegistros" class="text-muted"></span>
                    </div>
                </div>

                <!-- Tabla HTML para lista -->
                <div class="table-wrapper" style="max-height: 500px; overflow-y: auto;">
                    <table id="tblListaLocales" class="table table-modern table-hover">
                        <thead>
                            <tr>
                                <th width="12%">C&Oacute;DIGO</th>
                                <th width="18%">NOMBRE</th>
                                <th width="20%">DIRECCI&Oacute;N</th>
                                <th width="15%">SEDE</th>
                                <th width="15%">UBICACI&Oacute;N GEOGR&Aacute;FICA</th>
                                <th width="10%">TEL&Eacute;FONO</th>
                                <th width="10%">TOTAL CIS</th>
                            </tr>
                        </thead>
                        <tbody id="tbodyLocales">
                        </tbody>
                    </table>
                </div>

                <!-- Paginacion -->
                <div class="pagination-wrapper" id="paginationLocal">
                </div>
                <div class="page-info" id="pageInfoLocal"></div>
            </div>
        </div>
    </div>

    <!-- ========== FORMULARIO ========== -->
    <form id="form1" runat="server">
        <div class="container">

            <!-- Card Formulario -->
            <div class="form-card">
                <div class="card-header">
                    <i class="bi bi-building me-2"></i>Ingrese Datos Local Judicial
                </div>
                <div class="card-body p-3">

                    <!-- Fila 1: Codigo -->
                    <div class="row g-2 mb-2">
                        <div class="col-md-6 col-sm-6">
                            <label class="form-label-modern">C&oacute;digo</label>
                            <asp:TextBox ID="Codigo_Local" runat="server" CssClass="form-control form-control-modern"
                                         MaxLength="6" Autocomplete="off" placeholder="Ingrese c&oacute;digo local judicial"
                                         onkeypress="SoloNumeros()" />
                            <asp:RequiredFieldValidator ID="rfvCodigo_Local" runat="server" ControlToValidate="Codigo_Local"
                                                       ErrorMessage="*" CssClass="validator-error" />
                        </div>
                    </div>

                    <!-- Fila 2: Nombre -->
                    <div class="row g-2 mb-2">
                        <div class="col-md-6 col-sm-6">
                            <label class="form-label-modern">Nombre</label>
                            <asp:TextBox ID="Nombre_Local" runat="server" CssClass="form-control form-control-modern"
                                         MaxLength="50" Autocomplete="off" placeholder="Ingrese nombre local judicial" />
                            <asp:RequiredFieldValidator ID="rfvNombre_Local" runat="server" ControlToValidate="Nombre_Local"
                                                       ErrorMessage="*" CssClass="validator-error" />
                        </div>
                    </div>

                    <!-- Fila 3: Direccion -->
                    <div class="row g-2 mb-2">
                        <div class="col-md-6 col-sm-6">
                            <label class="form-label-modern">Direcci&oacute;n</label>
                            <asp:TextBox ID="Direccion_Local" runat="server" CssClass="form-control form-control-modern"
                                         MaxLength="50" Autocomplete="off" placeholder="Ingrese direcci&oacute;n local judicial" />
                            <asp:RequiredFieldValidator ID="rfvDireccion_Local" runat="server" ControlToValidate="Direccion_Local"
                                                       ErrorMessage="*" CssClass="validator-error" />
                        </div>
                    </div>

                    <!-- Fila 4: Sede -->
                    <div class="row g-2 mb-2">
                        <div class="col-md-6 col-sm-6">
                            <label class="form-label-modern">Sede</label>
                            <asp:DropDownList ID="Sede" runat="server" CssClass="form-control form-control-modern"
                                             AppendDataBoundItems="True">
                                <asp:ListItem Value="-1">Seleccione una opción</asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="rfvSede" runat="server" ControlToValidate="Sede"
                                                       ErrorMessage="*" CssClass="validator-error" />
                            <asp:RegularExpressionValidator ID="revSede" runat="server" ControlToValidate="Sede"
                                                             Display="Dynamic" ErrorMessage="*"
                                                             CssClass="validator-error"
                                                             ValidationExpression="[1-999]" />
                        </div>
                    </div>

                    <!-- Fila 5: Ubicacion Geografica -->
                    <div class="row g-2 mb-2">
                        <div class="col-md-6 col-sm-6">
                            <label class="form-label-modern">Ubicaci&oacute;n Geogr&aacute;fica</label>
                            <div class="input-group">
                                <asp:TextBox ID="Ubicacion_Geografica" runat="server" CssClass="form-control form-control-modern"
                                             MaxLength="25" Autocomplete="off" placeholder="Ingrese ubicaci&oacute;n geogr&aacute;fica local judicial" />
                                <asp:Button ID="ibtnBUSCAR_PROPIETARIO" runat="server" CausesValidation="False"
                                                 CssClass="btn btn-info btn-modern"
                                                 ToolTip="Buscar Propietario" OnClientClick="abrir_ventana_busca_Ubicacion_Geografica();" Text="..." />
                            </div>
                            <asp:RequiredFieldValidator ID="rfvUbicacion_Geografica" runat="server" ControlToValidate="Ubicacion_Geografica"
                                                       ErrorMessage="*" CssClass="validator-error" />
                            <asp:HiddenField ID="hfCodigo_Ubicacion_Geografica" runat="server" Value="0" />
                        </div>
                    </div>

                    <!-- Fila 6: Telefono -->
                    <div class="row g-2 mb-2">
                        <div class="col-md-6 col-sm-6">
                            <label class="form-label-modern">Tel&eacute;fono</label>
                            <asp:TextBox ID="Telefono_local" runat="server" CssClass="form-control form-control-modern"
                                         MaxLength="50" Autocomplete="off" placeholder="Ingrese tel&eacute;fono"
                                         onkeypress="SoloNumeros()" />
                            <asp:RequiredFieldValidator ID="rfvTelefono_local" runat="server" ControlToValidate="Telefono_local"
                                                       ErrorMessage="*" CssClass="validator-error" />
                        </div>
                    </div>

                    <!-- Fila 7: Pagina Web -->
                    <div class="row g-2 mb-2">
                        <div class="col-md-6 col-sm-6">
                            <label class="form-label-modern">P&aacute;gina Web</label>
                            <asp:TextBox ID="Pagnia_Web_Local" runat="server" CssClass="form-control form-control-modern"
                                         MaxLength="50" Autocomplete="off" placeholder="Ingrese p&aacute;gina web"
                                         onkeypress="" />
                            <asp:RequiredFieldValidator ID="rfvPagnia_Web_Local" runat="server" ControlToValidate="Pagnia_Web_Local"
                                                       ErrorMessage="*" CssClass="validator-error" />
                            <asp:RegularExpressionValidator ID="revPagnia_Web_Local" runat="server" ControlToValidate="Pagnia_Web_Local"
                                                             ErrorMessage="Direcci&oacute;n p&aacute;gina web incorrecta"
                                                             CssClass="validator-error"
                                                             ValidationExpression="https?://[\w\-\.]+(\/[\w\-\./\?]*)?" />
                        </div>
                    </div>

                    <!-- Fila 8: Email -->
                    <div class="row g-2 mb-2">
                        <div class="col-md-6 col-sm-6">
                            <label class="form-label-modern">Email</label>
                            <asp:TextBox ID="Email_Local" runat="server" CssClass="form-control form-control-modern"
                                         MaxLength="50" Autocomplete="off" placeholder="Ingrese email"
                                         onkeypress="" />
                            <asp:RequiredFieldValidator ID="rfvEmail_Local" runat="server" ControlToValidate="Email_Local"
                                                       ErrorMessage="*" CssClass="validator-error" />
                            <asp:RegularExpressionValidator ID="revEmail_Local" runat="server" ControlToValidate="Email_Local"
                                                             ErrorMessage="Email incorrecto"
                                                             CssClass="validator-error"
                                                             ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" />
                        </div>
                    </div>

                    <!-- Fila 9: Total CIS -->
                    <div class="row g-3 mb-4">
                        <div class="col-md-6 col-sm-6">
                            <label class="form-label-modern">Nro. Total de Elementos de Configuraci&oacute;n en Posesi&oacute;n</label>
                            <asp:TextBox ID="Total_CIS_Local" runat="server" CssClass="form-control form-control-modern"
                                         MaxLength="50" Autocomplete="off" placeholder="Ingrese n&uacute;mero total de elementos de configuraci&oacute;n en posesi&oacute;n"
                                         onkeypress="SoloNumeros()" />
                            <asp:RequiredFieldValidator ID="rfvTotal_CIS_Local" runat="server" ControlToValidate="Total_CIS_Local"
                                                       ErrorMessage="*" CssClass="validator-error" />
                        </div>
                    </div>

                    <!-- Botones de accion -->
                    <div class="d-flex flex-wrap gap-2 justify-content-center">
                        <asp:Button ID="btnRegistrar" runat="server" Text="Registrar" CssClass="btn btn-success btn-modern"
                                    OnClick="btnRegistrar_Click"
                                    OnClientClick="return Confirmar('¿Desea registrar Local?');" />
                        <asp:Button ID="btnModificar" runat="server" Text="Modificar" CssClass="btn btn-warning btn-modern"
                                    OnClick="btnModificar_Click"
                                    OnClientClick="return Confirmar('¿Desea modificar Local?');" />
                        <asp:Button ID="btnEliminar" runat="server" Text="Eliminar" CssClass="btn btn-danger btn-modern"
                                    OnClick="btnEliminar_Click"
                                    OnClientClick="return Confirmar('¿Desea eliminar Local?');" />
                        <asp:Button ID="btnCancelar" runat="server" Text="Cancelar" CssClass="btn btn-secondary btn-modern"
                                    OnClick="btnCancelar_Click" CausesValidation="False" />
                    </div>
                </div>
            </div>

            <!-- Hidden Fields -->
            <asp:HiddenField ID="__mensaje" runat="server" />
            <asp:HiddenField ID="__pagina" runat="server" />
            <asp:HiddenField ID="Id_Local" runat="server" Value="0" EnableViewState="False" />
            <asp:HiddenField ID="datosJson" runat="server" Value="" EnableViewState="False" />

        </div>
    </form>

    <script type="text/javascript">
        // ========== VARIABLES GLOBALES PARA LISTA ==========
        var datosCompletos = [];
        var paginaActual = 1;
        var tamanioPagina = 10;
        var datosJsonControl = null;

        // ========== INICIALIZACION AL CARGAR PAGINA ==========
        function inicializarDatos() {
            datosJsonControl = document.getElementById('<%= datosJson.ClientID %>');
            if (datosJsonControl && datosJsonControl.value) {
                try {
                    datosCompletos = JSON.parse(datosJsonControl.value);
                    Paginar(1);
                } catch (e) {
                    console.error('Error parsing JSON:', e);
                }
            }
        }

        // ========== FILTRAR ==========
        function filtrarTabla(texto) {
            texto = texto.toUpperCase();
            var datosFiltrados = [];

            for (var i = 0; i < datosCompletos.length; i++) {
                var row = datosCompletos[i];
                var textoFila = Object.values(row).join(' ').toUpperCase();
                if (textoFila.indexOf(texto) > -1) {
                    datosFiltrados.push(row);
                }
            }

            paginaActual = 1;
            renderizarTabla(datosFiltrados);
            var totalPaginas = Math.ceil(datosFiltrados.length / tamanioPagina);
            generarPaginacion(totalPaginas, paginaActual);
            document.getElementById('lblTotalRegistros').textContent = 'Total: ' + datosFiltrados.length + ' elementos';
        }

        // Alias para compatibilidad
        function filtrarLocales() {
            filtrarTabla(document.getElementById('txtBuscarLocal').value);
        }

        // ========== PAGINAR ==========
        function Paginar(pagina) {
            paginaActual = pagina;
            var inicio = (pagina - 1) * tamanioPagina;
            var fin = inicio + tamanioPagina;
            var datosPagina = datosCompletos.slice(inicio, fin);

            renderizarTabla(datosPagina);

            var totalPaginas = Math.ceil(datosCompletos.length / tamanioPagina);
            generarPaginacion(totalPaginas, pagina);
            document.getElementById('pageInfoLocal').textContent = 'Pagina ' + pagina + ' de ' + totalPaginas + ' (Total: ' + datosCompletos.length + ' registros)';
            document.querySelector('.table-wrapper').scrollIntoView({ behavior: 'smooth' });
        }

        // ========== RENDERIZAR TABLA ==========
        function renderizarTabla(datos) {
            var tbody = document.getElementById('tbodyLocales');
            if (!tbody) return;

            var sb = '';

            if (datos.length === 0) {
                tbody.innerHTML = '<tr><td colspan="7" class="text-center text-muted py-4">No se encontraron elementos</td></tr>';
                return;
            }

            for (var i = 0; i < datos.length; i++) {
                var row = datos[i];
                sb += '<tr onclick="seleccionarLocal(\'' + row.id + '\',\'' + row.codigo + '\',\'' + row.nombre + '\',\'' + row.direccion + '\',\'' + row.sede + '\',\'' + row.idUbi + '\',\'' + row.ubiGeo + '\',\'' + row.telefono + '\',\'' + row.paginaWeb + '\',\'' + row.email + '\',\'' + row.totalCis + '\')" style="cursor:pointer;">';
                sb += '<td>' + htmlEncode(row.codigo) + '</td>';
                sb += '<td>' + htmlEncode(row.nombre) + '</td>';
                sb += '<td>' + htmlEncode(row.direccion) + '</td>';
                sb += '<td>' + htmlEncode(row.sede) + '</td>';
                sb += '<td>' + htmlEncode(row.ubiGeo) + '</td>';
                sb += '<td>' + htmlEncode(row.telefono) + '</td>';
                sb += '<td>' + htmlEncode(row.totalCis) + '</td>';
                sb += '</tr>';
            }

            tbody.innerHTML = sb;
        }

        function htmlEncode(str) {
            if (!str) return '';
            return String(str).replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/"/g, '&quot;');
        }

        // ========== GENERAR PAGINACION ==========
        function generarPaginacion(totalPaginas, pagina) {
            var pagination = document.getElementById('paginationLocal');
            if (!pagination) return;
            if (totalPaginas <= 1) {
                pagination.innerHTML = '';
                return;
            }

            var sb = '<nav><ul class="pagination mb-0">';

            // Anterior
            if (pagina > 1) {
                sb += '<li class="page-item"><a class="page-link" href="javascript:Paginar(' + (pagina - 1) + ')">Anterior</a></li>';
            } else {
                sb += '<li class="page-item disabled"><span class="page-link">Anterior</span></li>';
            }

            // Numeros de pagina (rango de 2 antes y despues)
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

            // Siguiente
            if (pagina < totalPaginas) {
                sb += '<li class="page-item"><a class="page-link" href="javascript:Paginar(' + (pagina + 1) + ')">Siguiente</a></li>';
            } else {
                sb += '<li class="page-item disabled"><span class="page-link">Siguiente</span></li>';
            }

            sb += '</ul></nav>';
            pagination.innerHTML = sb;
        }

        // ========== SELECCIONAR LOCAL DESDE LISTA ==========
        function seleccionarLocal(id, codigo, nombre, direccion, sede, idUbi, ubiGeo, telefono, paginaWeb, email, totalCis) {
            document.getElementById('<%= Id_Local.ClientID %>').value = id;
            document.getElementById('<%= Codigo_Local.ClientID %>').value = codigo;
            document.getElementById('<%= Nombre_Local.ClientID %>').value = nombre;
            document.getElementById('<%= Direccion_Local.ClientID %>').value = direccion;

            // Seleccionar sede en dropdown
            var sedeDropdown = document.getElementById('<%= Sede.ClientID %>');
            if (sedeDropdown) {
                for (var i = 0; i < sedeDropdown.options.length; i++) {
                    if (sedeDropdown.options[i].text.trim() === sede.trim()) {
                        sedeDropdown.selectedIndex = i;
                        break;
                    }
                }
            }

            document.getElementById('<%= hfCodigo_Ubicacion_Geografica.ClientID %>').value = idUbi;
            document.getElementById('<%= Ubicacion_Geografica.ClientID %>').value = ubiGeo;
            document.getElementById('<%= Telefono_local.ClientID %>').value = telefono;
            document.getElementById('<%= Pagnia_Web_Local.ClientID %>').value = paginaWeb;
            document.getElementById('<%= Email_Local.ClientID %>').value = email;
            document.getElementById('<%= Total_CIS_Local.ClientID %>').value = totalCis;

            // Mostrar botones modificar/eliminar y ocultar registrar
            document.getElementById('<%= btnRegistrar.ClientID %>').style.display = 'none';
            document.getElementById('<%= btnCancelar.ClientID %>').style.display = '';

            // Scroll al formulario
            document.querySelector('.form-card').scrollIntoView({ behavior: 'smooth' });
        }

        // Asignar al cargar pagina
        if (window.addEventListener) {
            window.addEventListener('load', inicializarDatos, false);
        } else if (window.attachEvent) {
            window.attachEvent('onload', inicializarDatos);
        }
    </script>

</body>
</html>
