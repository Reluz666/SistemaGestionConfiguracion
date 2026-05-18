<%@ Page Language="C#" AutoEventWireup="true" CodeFile="LicenciaElementoConfiguracion.aspx.cs" Inherits="Licencia_Elemento_Configuracion" UnobtrusiveValidationMode="None" %>
<%@ Register src="NavBar.ascx" tagname="NavBar" tagprefix="uc1" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>Licencia Elemento Configuracion</title>

    <!-- Bootstrap 5.3 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet" />
    <!-- Global Styles -->
    <link href="CssJs/global-styles.css" rel="stylesheet" />

    <style>
        /* ===== NAVBAR ===== */
        .navbar-modern {
            background: linear-gradient(135deg, #1a1a2e 0%, #16213e 100%);
            border: none;
            box-shadow: 0 2px 15px rgba(0, 0, 0, 0.15);
            padding: 0.8rem 1rem;
        }

        .navbar-modern .navbar-brand {
            color: #fff !important;
            font-weight: 600;
            font-size: 1.2rem;
        }

        .navbar-modern .navbar-brand:hover {
            color: #e94560 !important;
        }

        .navbar-modern .nav-link {
            color: rgba(255, 255, 255, 0.85) !important;
            font-weight: 500;
            padding: 0.6rem 1rem !important;
            border-radius: 8px;
            transition: color 0.2s, background 0.2s;
        }

        .navbar-modern .nav-link:hover {
            color: #fff !important;
            background: rgba(255, 255, 255, 0.1);
        }

        .navbar-modern .dropdown-menu {
            background: #1a1a2e;
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 12px;
            padding: 0.5rem;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.3);
        }

        .navbar-modern .dropdown-item {
            color: rgba(255, 255, 255, 0.8);
            border-radius: 8px;
            padding: 0.5rem 1rem;
            transition: all 0.2s;
        }

        .navbar-modern .dropdown-item:hover {
            background: rgba(233, 69, 96, 0.2);
            color: #fff;
        }

        .navbar-modern .dropdown-submenu {
            position: relative;
        }

        .navbar-modern .dropdown-submenu > .dropdown-toggle::after {
            border-left: 0.3em solid;
            border-top: 0.3em solid transparent;
            border-bottom: 0.3em solid transparent;
            margin-left: auto;
        }

        .navbar-modern .dropdown-submenu > .dropdown-menu {
            top: 0;
            left: 100%;
            margin-top: -6px;
            margin-left: 2px;
            border-radius: 12px;
        }

        .navbar-modern .dropdown-submenu:hover > .dropdown-menu {
            display: block;
        }

        /* ===== FORMULARIO ===== */
        .form-card {
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 4px 25px rgba(0, 0, 0, 0.08);
            padding: 2rem;
            margin-bottom: 2rem;
            border: 1px solid rgba(0, 0, 0, 0.05);
        }

        .form-card .card-header {
            background: linear-gradient(135deg, #1a1a2e 0%, #16213e 100%);
            color: #fff;
            border-radius: 12px 12px 0 0;
            padding: 1.2rem 1.5rem;
            font-weight: 600;
            font-size: 1.1rem;
            border: none;
        }

        .form-label-modern {
            font-weight: 500;
            color: #2d3436;
            margin-bottom: 0.4rem;
            font-size: 0.9rem;
        }

        .form-control-modern {
            border: 2px solid #e9ecef;
            border-radius: 10px;
            padding: 0.6rem 1rem;
            transition: border-color 0.3s, box-shadow 0.3s;
            font-size: 0.95rem;
        }

        .form-control-modern:focus {
            border-color: #e94560;
            box-shadow: 0 0 0 4px rgba(233, 69, 96, 0.1);
            outline: none;
        }

        .form-control-modern::placeholder {
            color: #adb5bd;
        }

        select.form-control-modern {
            cursor: pointer;
        }

        /* ===== TABLA ===== */
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

        /* ===== BOTONES ===== */
        .btn-modern {
            padding: 0.6rem 1.5rem;
            border-radius: 10px;
            font-weight: 600;
            font-size: 0.95rem;
            transition: all 0.3s ease;
            border: none;
        }

        .btn-modern:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
        }

        /* ===== VALIDATORS ===== */
        .validator-error {
            color: #e94560;
            font-size: 0.8rem;
            font-weight: 500;
        }


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
    </style>

    <script lang="javascript" type="text/javascript">
        function abrir_ventana_Elementos_Configuracion_Software() {
            window.document.getElementById("ID_ELEMENTO_CONFIGURACION").value = 0;
            window.document.getElementById("TIPO_CI").value = "";
            window.document.getElementById("NOMBRE_CI").value = "";
            window.document.getElementById("NRO_SERIE").value = "";
            window.document.getElementById("PROPIETARIO_CI").value = "";
            window.document.getElementById("DESCRIPCION_CI").value = "";

            window.document.getElementById("__mensaje").value = "";
            window.document.getElementById("__pagina").value = "";
            var options = 'channelmode=1,directories=0,fullscreen=0,location=0,menubar=0,resizable=0,titlebar=0,toolbar=0,edge=Raised,status=no,scrollbars=1,width=1000,height=550,top=50px, left=175px';
            window.open('Ventanas/ventanaElementosConfiguracionSoftware.aspx', options);
        }

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
            document.getElementById('<%= txtFechaInicioVersion.ClientID %>').readOnly = true;
            document.getElementById('<%= txtFechaFinVersion.ClientID %>').readOnly = true;

            document.getElementById('<%= TIPO_CI.ClientID %>').readOnly = true;
            document.getElementById('<%= NOMBRE_CI.ClientID %>').readOnly = true;
            document.getElementById('<%= NRO_SERIE.ClientID %>').readOnly = true;
            document.getElementById('<%= PROPIETARIO_CI.ClientID %>').readOnly = true;
            document.getElementById('<%= DESCRIPCION_CI.ClientID %>').readOnly = true;

            document.getElementById("btnFechaInicioVersion").disabled = "disabled"
            document.getElementById("btnFechaFinVersion").disabled = "disabled"

            var TL = document.getElementById("ddlTIPO_LICENCIA_CI").options[document.getElementById("ddlTIPO_LICENCIA_CI").selectedIndex].text;
            var SL = document.getElementById("ddlSUSCRIPCION_LICENCIA_CI").options[document.getElementById("ddlSUSCRIPCION_LICENCIA_CI").selectedIndex].text;
            if (TL == 'PROPIETARIO' && SL != 'NINGUNA' && SL != 'Seleccione una opción') {
                document.getElementById("btnFechaInicioVersion").disabled = ""
                document.getElementById("btnFechaFinVersion").disabled = ""
            }
        }
    </script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body onload="MostrarMensaje()">

    <uc1:NavBar ID="NavBar1" runat="server" />

    <!-- ========== FORMULARIO ========== -->
    <form id="form1" runat="server" class="form-horizontal" role="form">
        <div class="container mt-4">
            <!-- ===== DATOS LICENCIA ===== -->
            <div class="form-card">
                <div class="card-header">
                    <i class="bi bi-file-earmark-plus-fill me-2"></i>Ingrese Datos Licencia
                </div>
                <div class="card-body p-4">
                    <div class="row g-3">
                        <!-- Tipo Licencia -->
                        <div class="col-md-6">
                            <label class="form-label-modern">Tipo Licencia</label>
                            <asp:DropDownList ID="ddlTIPO_LICENCIA_CI" runat="server" CssClass="form-control form-control-modern"
                                AppendDataBoundItems="True" AutoPostBack="True" OnSelectedIndexChanged="ddlTIPO_LICENCIA_CI_SelectedIndexChanged">
                                <asp:ListItem Value="-1">Seleccione una opción</asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="rfvTIPO_LICENCIA_CI" runat="server" ControlToValidate="ddlTIPO_LICENCIA_CI" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                        </div>
                        <!-- Suscripcion Licencia -->
                        <div class="col-md-6">
                            <label class="form-label-modern">Suscripcion Licencia</label>
                            <asp:DropDownList ID="ddlSUSCRIPCION_LICENCIA_CI" runat="server" CssClass="form-control form-control-modern"
                                AppendDataBoundItems="True" AutoPostBack="True" OnSelectedIndexChanged="ddlSUSCRIPCION_LICENCIA_CI_SelectedIndexChanged">
                                <asp:ListItem Value="-1">Seleccione una opción</asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="rfvSUSCRIPCION_LICENCIA_CI" runat="server" ControlToValidate="ddlSUSCRIPCION_LICENCIA_CI" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                        </div>
                        <!-- Nombre -->
                        <div class="col-md-6">
                            <label class="form-label-modern">Nombre</label>
                            <asp:TextBox ID="NOMBRE" runat="server" CssClass="form-control form-control-modern" MaxLength="25" Autocomplete="off" placeholder="Ingresar Nombre Licencia"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvNOMBRE" runat="server" ControlToValidate="NOMBRE" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                        </div>
                        <!-- Version -->
                        <div class="col-md-6">
                            <label class="form-label-modern">Version</label>
                            <asp:TextBox ID="VERSION" runat="server" CssClass="form-control form-control-modern" MaxLength="25" Autocomplete="off" placeholder="Ingresar Version"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvVERSION" runat="server" ControlToValidate="VERSION" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                        </div>
                        <!-- Fecha Inicio -->
                        <div class="col-md-4">
                            <label class="form-label-modern">Fecha Inicio</label>
                            <div class="input-group">
                                <asp:TextBox ID="txtFechaInicioVersion" runat="server" CssClass="form-control form-control-modern" placeholder="Fec. inicio"></asp:TextBox>
                                <input id="btnFechaInicioVersion" type="button" value="..." class="btn btn-outline-secondary" style="width:40px;" />
                            </div>
                            <asp:RequiredFieldValidator ID="rfvFechaInicioVersion" runat="server" ControlToValidate="txtFechaInicioVersion" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                        </div>
                        <!-- Fecha Fin -->
                        <div class="col-md-4">
                            <label class="form-label-modern">Fecha Fin</label>
                            <div class="input-group">
                                <asp:TextBox ID="txtFechaFinVersion" runat="server" CssClass="form-control form-control-modern" placeholder="Fec. fin"></asp:TextBox>
                                <input id="btnFechaFinVersion" type="button" value="..." class="btn btn-outline-secondary" style="width:40px;" />
                            </div>
                            <asp:RequiredFieldValidator ID="rfvFechaFinVersion" runat="server" ControlToValidate="txtFechaFinVersion" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                            <asp:CompareValidator ID="cvFechas" runat="server" ControlToCompare="txtFechaInicioVersion" ControlToValidate="txtFechaFinVersion" ErrorMessage="Fec. Inicio debe ser menor" ForeColor="Red" Operator="GreaterThanEqual"></asp:CompareValidator>
                        </div>
                        <!-- Perpetua -->
                        <div class="col-md-4">
                            <label class="form-label-modern">Licencia Perpetua</label>
                            <div class="form-check form-switch mt-2">
                                <asp:CheckBox ID="LICENCIA_PERPETUA" runat="server" CssClass="form-check-input" Text="Si / No" />
                            </div>
                        </div>
                        <!-- Descripcion -->
                        <div class="col-12">
                            <label class="form-label-modern">Descripcion</label>
                            <asp:TextBox ID="DESCRIPCION" runat="server" CssClass="form-control form-control-modern" MaxLength="25" Autocomplete="off" placeholder="Ingresar Descripcion"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvDESCRIPCION" runat="server" ControlToValidate="DESCRIPCION" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                        </div>
                    </div>
                </div>
            </div>

            <!-- ===== DATOS ELEMENTO CONFIGURACION SOFTWARE ===== -->
            <div class="form-card">
                <div class="card-header">
                    <i class="bi bi-box-seam me-2"></i>Datos Elemento Configuracion Software
                </div>
                <div class="card-body p-4">
                    <div class="row g-3 align-items-end">
                        <div class="col-md-10">
                            <asp:HiddenField ID="ID_ELEMENTO_CONFIGURACION" runat="server" Value="0" EnableViewState="False" />
                            <div class="row g-3">
                                <div class="col-md-2">
                                    <label class="form-label-modern">Tipo CI</label>
                                    <asp:TextBox ID="TIPO_CI" runat="server" CssClass="form-control form-control-modern" ReadOnly="true"></asp:TextBox>
                                </div>
                                <div class="col-md-3">
                                    <label class="form-label-modern">Nombre CI</label>
                                    <asp:TextBox ID="NOMBRE_CI" runat="server" CssClass="form-control form-control-modern" ReadOnly="true"></asp:TextBox>
                                </div>
                                <div class="col-md-2">
                                    <label class="form-label-modern">Nro. Serie</label>
                                    <asp:TextBox ID="NRO_SERIE" runat="server" CssClass="form-control form-control-modern" ReadOnly="true"></asp:TextBox>
                                </div>
                                <div class="col-md-2">
                                    <label class="form-label-modern">Propietario</label>
                                    <asp:TextBox ID="PROPIETARIO_CI" runat="server" CssClass="form-control form-control-modern" ReadOnly="true"></asp:TextBox>
                                </div>
                                <div class="col-md-3">
                                    <label class="form-label-modern">Descripcion</label>
                                    <asp:TextBox ID="DESCRIPCION_CI" runat="server" CssClass="form-control form-control-modern" ReadOnly="true"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-2 text-end">
                            <asp:Button ID="btnBucar" runat="server" Text="Buscar CI" CssClass="btn btn-info btn-modern w-100" OnClick="btnBucar_Click" UseSubmitBehavior="False" />
                        </div>
                    </div>

                    <div class="mt-3">
                        <asp:Button ID="btnAgregarCI" runat="server" Text="Agregar Elemento Configuracion" CssClass="btn btn-primary btn-modern" CausesValidation="False" OnClick="btnAgregarCI_Click" />
                    </div>

                    <!-- Tabla de CIs agregados -->
                    <div class="table-responsive mt-3">
                        <asp:Table ID="Table_" runat="server" CssClass="table table-modern table-hover">
                            <asp:TableRow ID="TableRow1" runat="server">
                                <asp:TableCell ID="tcID_RE" runat="server" BackColor="Black" ForeColor="White" Visible="false">ID RE</asp:TableCell>
                                <asp:TableCell ID="tcIdCi" runat="server" BackColor="Black" ForeColor="White" Visible="false">ID CI</asp:TableCell>
                                <asp:TableCell ID="tcTipo_CI" runat="server" BackColor="Black" ForeColor="White">TIPO CI</asp:TableCell>
                                <asp:TableCell ID="tcNombre_CI" runat="server" BackColor="Black" ForeColor="White">NOMBRE CI</asp:TableCell>
                                <asp:TableCell ID="tcNro_Serie" runat="server" BackColor="Black" ForeColor="White">NRO. SERIE</asp:TableCell>
                                <asp:TableCell ID="tcPropietario_CI" runat="server" BackColor="Black" ForeColor="White">PROPIETARIO CI</asp:TableCell>
                                <asp:TableCell ID="tcDescripcion_CI" runat="server" BackColor="Black" ForeColor="White">DESCRIPCION CI</asp:TableCell>
                                <asp:TableCell ID="seleccionar_personal" runat="server" BackColor="Black" ForeColor="White" HorizontalAlign="Center">ACCION</asp:TableCell>
                            </asp:TableRow>
                        </asp:Table>
                    </div>
                </div>
            </div>

            <!-- ===== BOTONES ACCION ===== -->
            <div class="form-card">
                <div class="card-body p-3 text-center">
                    <asp:Button ID="btnRegistrar" runat="server" Text="Aceptar" CssClass="btn btn-success btn-modern me-2" Style="min-width:120px;" OnClick="btnRegistrar_Click" />
                    <asp:Button ID="btnCancelar" runat="server" Text="Cancelar" CssClass="btn btn-danger btn-modern" CausesValidation="False" PostBackUrl="~/LicenciasElementoConfiguracion.aspx" />

                    <asp:HiddenField ID="__mensaje" runat="server" />
                    <asp:HiddenField ID="__pagina" runat="server" />
                    <asp:HiddenField ID="_operacion" runat="server" Value="N" EnableViewState="False" />
                    <asp:HiddenField ID="hfFILA_DETALLE_RELACION_LICENCIA_ELEMENTO_CONFIGURACION" runat="server" Value="-1" />
                    <asp:HiddenField ID="hfID_LICENCIA_ELE_CONF" runat="server" Value="-1" />
                </div>
            </div>
        </div>

        <!-- ========== LISTA DE LICENCIAS CON BUSQUEDA Y PAGINACION ========== -->
        <div class="container-fluid mt-4">
            <div class="form-card">
                <div class="card-header">
                    <i class="bi bi-list-ul me-2"></i>Lista de Licencias
                </div>
                <div class="card-body p-3">
                    <!-- Buscador -->
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <div class="input-group">
                                <span class="input-group-text"><i class="bi bi-search"></i></span>
                                <input type="text" id="txtBuscarLicencia" class="form-control" placeholder="Buscar por nombre, tipo, suscripcion..." autocomplete="off" />
                            </div>
                        </div>
                        <div class="col-md-6 text-end">
                            <span id="lblContador" class="badge bg-secondary"></span>
                        </div>
                    </div>

                    <!-- Tabla de Resultados -->
                    <div class="table-responsive">
                        <table class="table table-hover table-condensed table-modern-grid" id="tblListaLicencias" style="display:none;">
                            <thead>
                                <tr>
                                    <th>LICENCIA</th>
                                    <th>TIPO LICENCIA</th>
                                    <th>NOMBRE</th>
                                    <th>VERSION</th>
                                    <th>SUSCRIPCION</th>
                                    <th>FEC. INI.</th>
                                    <th>FEC. FIN</th>
                                    <th>PERPETUA</th>
                                    <th>DESCRIPCION</th>
                                    <th>VENCE</th>
                                    <th>ACCION</th>
                                </tr>
                            </thead>
                            <tbody id="tbodyLicencias"></tbody>
                        </table>
                        <div id="divSinResultados" class="alert alert-info text-center" style="display:none;">
                            No se encontraron licencias.
                        </div>
                    </div>

                    <!-- Paginacion -->
                    <div class="row mt-3">
                        <div class="col-md-12">
                            <nav>
                                <ul class="pagination justify-content-center" id="ulPaginacion"></ul>
                            </nav>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- HiddenField para datos JSON -->
        <asp:HiddenField ID="datosJson" runat="server" />

        <!-- Hidden button to handle edit postback from JavaScript -->
        <asp:Button ID="btnEditarLista" runat="server" OnClick="btnEditarLista_Click" Style="display:none;" />

    </form>

    <script type="text/javascript" src="../Otros_css_js/resaltar.js"></script>

    <script type="text/javascript">
        Calendar.setup({
            inputField: "txtFechaInicioVersion",
            trigger: "btnFechaInicioVersion",
            onSelect: function () { this.hide() },
            showTime: 12,
            dateFormat: "%d/%m/%Y"
        });
        Calendar.setup({
            inputField: "txtFechaFinVersion",
            trigger: "btnFechaFinVersion",
            onSelect: function () { this.hide() },
            showTime: 12,
            dateFormat: "%d/%m/%Y"
        });
    </script>

    <!-- Script para lista con busqueda y paginacion -->
    <script type="text/javascript">
        var datosLicencias = [];
        var paginaActual = 1;
        var itemsPorPagina = 10;

        function cargarDatos() {
            try {
                var jsonVal = document.getElementById('datosJson').value;
                if (jsonVal && jsonVal.trim() !== '') {
                    datosLicencias = JSON.parse(jsonVal);
                } else {
                    datosLicencias = [];
                }
            } catch (e) {
                datosLicencias = [];
            }
        }

        function formatearFecha(fechaStr) {
            if (!fechaStr || fechaStr.trim() === '') return '---';
            try {
                var fecha = new Date(fechaStr);
                var dia = fecha.getDate().toString().padStart(2, '0');
                var mes = (fecha.getMonth() + 1).toString().padStart(2, '0');
                var anio = fecha.getFullYear();
                return dia + '/' + mes + '/' + anio;
            } catch (e) {
                return fechaStr;
            }
        }

        function renderizarTabla() {
            var filtro = document.getElementById('txtBuscarLicencia').value.toUpperCase();
            var datosFiltrados = datosLicencias.filter(function (item) {
                if (!filtro) return true;
                return (item.NOMBRE && item.NOMBRE.toUpperCase().indexOf(filtro) !== -1) ||
                       (item['TIPO LICENCIA'] && item['TIPO LICENCIA'].toUpperCase().indexOf(filtro) !== -1) ||
                       (item.SUSCRIPCION && item.SUSCRIPCION.toUpperCase().indexOf(filtro) !== -1) ||
                       (item.DESCRIPCION && item.DESCRIPCION.toUpperCase().indexOf(filtro) !== -1) ||
                       (item.VERSION && item.VERSION.toUpperCase().indexOf(filtro) !== -1);
            });

            var tbl = document.getElementById('tblListaLicencias');
            var tbody = document.getElementById('tbodyLicencias');
            var divSinResultados = document.getElementById('divSinResultados');
            var lblContador = document.getElementById('lblContador');

            if (datosFiltrados.length === 0) {
                tbl.style.display = 'none';
                divSinResultados.style.display = 'block';
                lblContador.textContent = '';
                return;
            }

            tbl.style.display = 'table';
            divSinResultados.style.display = 'none';
            lblContador.textContent = 'Total: ' + datosFiltrados.length + ' licencia(s)';

            var totalPaginas = Math.ceil(datosFiltrados.length / itemsPorPagina);
            var inicio = (paginaActual - 1) * itemsPorPagina;
            var fin = inicio + itemsPorPagina;
            var datosPagina = datosFiltrados.slice(inicio, fin);

            tbody.innerHTML = '';
            for (var i = 0; i < datosPagina.length; i++) {
                var item = datosPagina[i];
                var perpetua = item.PERPETUA || '';
                var vence = item['VENCE LICENCIA'] || '';
                var tr = document.createElement('tr');
                tr.innerHTML = '<td>' + (item.LICENCIA || '') + '</td>' +
                    '<td>' + (item['TIPO LICENCIA'] || '') + '</td>' +
                    '<td>' + (item.NOMBRE || '') + '</td>' +
                    '<td>' + (item.VERSION || '') + '</td>' +
                    '<td>' + (item.SUSCRIPCION || '') + '</td>' +
                    '<td>' + formatearFecha(item['FEC. INI.']) + '</td>' +
                    '<td>' + formatearFecha(item['FEC. FIN']) + '</td>' +
                    '<td style="color:' + (perpetua === 'SI' ? 'blue' : 'red') + '">' + perpetua + '</td>' +
                    '<td>' + (item.DESCRIPCION || '') + '</td>' +
                    '<td style="color:' + (vence === 'LICENCIA VENCIDA' ? 'red' : (vence === 'LICENCIA NO VENCE' ? 'green' : 'blue')) + '">' + vence + '</td>' +
                    '<td><button type="button" class="btn btn-primary btn-sm" onclick="editarLicencia(\'' + (item.LICENCIA || '') + '\')">Editar</button></td>';
                tbody.appendChild(tr);
            }

            renderizarPaginacion(totalPaginas, datosFiltrados.length);
        }

        function renderizarPaginacion(totalPaginas, totalItems) {
            var ul = document.getElementById('ulPaginacion');
            ul.innerHTML = '';

            if (totalPaginas <= 1) return;

            var liPrev = document.createElement('li');
            liPrev.className = 'page-item' + (paginaActual === 1 ? ' disabled' : '');
            liPrev.innerHTML = '<a class="page-link" href="#" onclick="irPagina(' + (paginaActual - 1) + '); return false;">&laquo; Anterior</a>';
            ul.appendChild(liPrev);

            var maxBotones = 5;
            var inicio = Math.max(1, paginaActual - Math.floor(maxBotones / 2));
            var fin = Math.min(totalPaginas, inicio + maxBotones - 1);
            if (fin - inicio + 1 < maxBotones) {
                inicio = Math.max(1, fin - maxBotones + 1);
            }

            if (inicio > 1) {
                var li = document.createElement('li');
                li.className = 'page-item';
                li.innerHTML = '<a class="page-link" href="#" onclick="irPagina(1); return false;">1</a>';
                ul.appendChild(li);
                if (inicio > 2) {
                    var liPuntos = document.createElement('li');
                    liPuntos.className = 'page-item disabled';
                    liPuntos.innerHTML = '<a class="page-link" href="#">...</a>';
                    ul.appendChild(liPuntos);
                }
            }

            for (var i = inicio; i <= fin; i++) {
                var li = document.createElement('li');
                li.className = 'page-item' + (i === paginaActual ? ' active' : '');
                li.innerHTML = '<a class="page-link" href="#" onclick="irPagina(' + i + '); return false;">' + i + '</a>';
                ul.appendChild(li);
            }

            if (fin < totalPaginas) {
                if (fin < totalPaginas - 1) {
                    var liPuntos = document.createElement('li');
                    liPuntos.className = 'page-item disabled';
                    liPuntos.innerHTML = '<a class="page-link" href="#">...</a>';
                    ul.appendChild(liPuntos);
                }
                var li = document.createElement('li');
                li.className = 'page-item';
                li.innerHTML = '<a class="page-link" href="#" onclick="irPagina(' + totalPaginas + '); return false;">' + totalPaginas + '</a>';
                ul.appendChild(li);
            }

            var liSig = document.createElement('li');
            liSig.className = 'page-item' + (paginaActual === totalPaginas ? ' disabled' : '');
            liSig.innerHTML = '<a class="page-link" href="#" onclick="irPagina(' + (paginaActual + 1) + '); return false;">Siguiente &raquo;</a>';
            ul.appendChild(liSig);
        }

        function irPagina(numPagina) {
            paginaActual = numPagina;
            renderizarTabla();
        }

        function editarLicencia(idLicencia) {
            __doPostBack('btnEditarLista', idLicencia);
        }

        function initLista() {
            cargarDatos();
            renderizarTabla();
            document.getElementById('txtBuscarLicencia').addEventListener('keyup', function () {
                paginaActual = 1;
                renderizarTabla();
            });
        }

        if (window.addEventListener) {
            window.addEventListener('load', initLista, false);
        } else if (window.attachEvent) {
            window.attachEvent('onload', initLista);
        }
    </script>

</body>
</html>
