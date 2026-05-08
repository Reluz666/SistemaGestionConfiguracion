<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Personal.aspx.cs" Inherits="Personal" UnobtrusiveValidationMode="None" %>
<%@ Register src="NavBar.ascx" tagname="NavBar" tagprefix="uc1" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>Personal</title>

    <!-- Bootstrap 5.3 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet" />
    <!-- Global Styles -->
    <link href="CssJs/global-styles.css" rel="stylesheet" />

    <style>
        /* Solo estilos específicos de tabla para Personal */
        #TablePersonal {
            border-collapse: separate !important;
            border-spacing: 0;
            width: 100%;
            min-width: 900px;
        }

        #TablePersonal thead tr th {
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

        #TablePersonal tbody tr:hover td {
            background: rgba(233, 69, 96, 0.04) !important;
        }

        #TablePersonal tbody tr td {
            padding: 0.5rem 0.45rem !important;
            border: none !important;
            border-bottom: 1px solid #f1f1f1 !important;
            vertical-align: middle;
            font-size: 0.8rem;
            color: #2d3436;
        }

        .estado-activo { color: #198754; font-weight: 600; }
        .estado-inactivo { color: #dc3545; font-weight: 600; }

        /* ===== PAGINACION ===== */
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

    <script type="text/javascript" src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <script type="text/javascript" src="src/js/utils.js"></script>
    <script type="text/javascript" src="src/js/grid-utils.js"></script>

    <script lang="javascript" type="text/javascript">
        // ===== VARIABLES GLOBALES PARA LISTA DE PERSONAL =====
        var listaCurrentPage = 1;
        var listaRowsPerPage = 10;

        // Grid configuration for Personal list
        var personalGridConfig = {
            tableId: 'tblListaPersonal',
            tbodyId: 'tbodyListaPersonal',
            searchInputId: 'txtBuscarPersonal',
            paginationWrapperId: 'paginationListaPersonal',
            pageInfoId: 'pageInfoPersonal',
            counterId: 'lblContadorPersonal',
            dataFieldId: 'datosJson',
            rowsPerPage: 10,
            searchFields: ['CODIGO', 'NOMBRE', 'APELLIDO_PATERNO', 'APELLIDO_MATERNO', 'NRO_DOC_IDENT', 'AREA', 'DEPENDENCIA', 'CARGO', 'SEDE', 'LOCAL'],
            columnRenderer: function(item) {
                var estadoClass = item.ESTADO === 'ACTIVO' ? 'estado-activo' : 'estado-inactivo';
                return '<td>' + htmlEncode(item.CODIGO) + '</td>' +
                    '<td>' + htmlEncode(item.NOMBRE) + ' ' + htmlEncode(item.APELLIDO_PATERNO) + ' ' + htmlEncode(item.APELLIDO_MATERNO) + '</td>' +
                    '<td>' + htmlEncode(item.TIPO_DOC_IDENT) + '</td>' +
                    '<td>' + htmlEncode(item.NRO_DOC_IDENT) + '</td>' +
                    '<td>' + htmlEncode(item.PROFESION) + '</td>' +
                    '<td>' + htmlEncode(item.TELEFONO) + '</td>' +
                    '<td>' + htmlEncode(item.EMAIL) + '</td>' +
                    '<td>' + htmlEncode(item.SEDE) + '</td>' +
                    '<td>' + htmlEncode(item.LOCAL) + '</td>' +
                    '<td>' + htmlEncode(item.AREA) + '</td>' +
                    '<td>' + htmlEncode(item.DEPENDENCIA) + '</td>' +
                    '<td>' + htmlEncode(item.CARGO) + '</td>' +
                    '<td class="' + estadoClass + '">' + htmlEncode(item.ESTADO) + '</td>' +
                    '<td class="text-center"><button type="button" class="btn btn-primary btn-sm btn-accion" onclick="seleccionarPersonal(\'' + item.ID_PERSONAL + '\');"><i class="bi bi-pencil-square"></i></button></td>';
            },
            onRowClick: function(item) {
                seleccionarPersonal(item.ID_PERSONAL);
            }
        };

        // Initialize the grid when page loads
        function initPersonalGrid() {
            GridUtils.createGrid(personalGridConfig);
        }

        // ===== FUNCIONES PARA LISTA DE PERSONAL CON BUSQUEDA Y PAGINACION =====

        function seleccionarPersonal(idPersonal) {
            // Get data from grid state
            var gridState = GridUtils.getState('tblListaPersonal');
            var datosPersonalJson = gridState ? gridState.data : [];
            // Find the row with matching ID_PERSONAL
            for (var i = 0; i < datosPersonalJson.length; i++) {
                if (datosPersonalJson[i].ID_PERSONAL === idPersonal) {
                    var item = datosPersonalJson[i];
                    // Populate form fields
                    document.getElementById('ID_PERSONAL').value = item.ID_PERSONAL;
                    document.getElementById('Codigo').value = item.CODIGO;
                    document.getElementById('Nombre').value = item.NOMBRE;
                    document.getElementById('ApellidoPat').value = item.APELLIDO_PATERNO;
                    document.getElementById('ApellidoMat').value = item.APELLIDO_MATERNO;
                    document.getElementById('NroDocIdent').value = item.NRO_DOC_IDENT;
                    document.getElementById('Telefono').value = item.TELEFONO;
                    document.getElementById('Email').value = item.EMAIL;
                    // SetEstado checkbox
                    var estadoCheck = document.getElementById('Estado');
                    estadoCheck.checked = item.ESTADO === 'ACTIVO';
                    // Select basic dropdown options (no cascade needed)
                    setDropdownByText('TipoDocIdent', item.TIPO_DOC_IDENT);
                    setDropdownByText('Profesion', item.PROFESION);
                    setDropdownByText('Dependencia', item.DEPENDENCIA);
                    setDropdownByText('Cargo', item.CARGO);
                    // Set Sede - this triggers cascading dropdowns via ASP.NET postback
                    setDropdownByText('Sede', item.SEDE);
                    // Trigger cascade: Sede -> Local -> Area
                    setTimeout(function() {
                        try {
                            __doPostBack('Sede', '');
                        } catch(e) {}
                        setTimeout(function() {
                            setDropdownByText('Local', item.LOCAL);
                            setTimeout(function() {
                                try {
                                    __doPostBack('Local', '');
                                } catch(e) {}
                                setTimeout(function() {
                                    setDropdownByText('Area', item.AREA);
                                }, 200);
                            }, 200);
                        }, 200);
                    }, 100);
                    // Show buttons and scroll to form
                    document.getElementById('btnRegistrar').style.display = 'none';
                    document.getElementById('btnModificar').style.display = '';
                    document.getElementById('btnEliminar').style.display = '';
                    // Scroll to form and set focus to first input field
                    var formCards = document.querySelectorAll('.form-card');
                    if (formCards.length > 1) {
                        var firstInput = formCards[1].querySelector('input[type="text"]');
                        if (firstInput) {
                            formCards[1].scrollIntoView();
                            firstInput.focus();
                        } else {
                            formCards[1].scrollIntoView();
                        }
                    }
                    return;
                }
            }
        }

        function setDropdownByText(dropdownId, text) {
            var dropdown = document.getElementById(dropdownId);
            if (!dropdown) return;
            for (var i = 0; i < dropdown.options.length; i++) {
                if (dropdown.options[i].text === text) {
                    dropdown.selectedIndex = i;
                    return;
                }
            }
        }
    </script>
</head>
<body onload="MostrarMensaje()">

    <uc1:NavBar ID="NavBar1" runat="server" />

    <form id="form1" runat="server">
        <div class="container">

            <!-- ========== LISTA DE PERSONAL CON BUSQUEDA Y PAGINACION ========== -->
            <div class="form-card">
                <div class="card-header">
                    <i class="bi bi-list-ul me-2"></i>Lista de Personal
                </div>
                <div class="card-body p-3">
                    <!-- Buscador -->
                    <div class="row mb-3">
                        <div class="col-md-8">
                            <div class="input-group">
                                <span class="input-group-text bg-white border-end-0">
                                    <i class="bi bi-search text-muted"></i>
                                </span>
                                <input type="text" id="txtBuscarPersonal" class="form-control border-start-0 search-input" ClientIDMode="Static"
                                       placeholder="Buscar por C&oacute;digo, Nombre, Apellido, DNI, &Aacute;rea, Dependencia, Cargo..."
                                       onkeyup="filtrarTablaPersonal()" />
                                <button class="btn btn-outline-secondary" type="button" onclick="document.getElementById('txtBuscarPersonal').value=''; filtrarTablaPersonal();">
                                    <i class="bi bi-x-lg"></i>
                                </button>
                            </div>
                        </div>
                        <div class="col-md-4 text-end">
                            <span id="lblContadorPersonal" class="form-text text-muted"></span>
                        </div>
                    </div>

                    <!-- Tabla HTML para lista de Personal -->
                    <div class="table-wrapper" style="max-height: 500px; overflow-y: auto;">
                        <table id="tblListaPersonal" class="table table-modern table-hover" style="min-width: 1000px;">
                            <thead>
                                <tr>
                                    <th style="width: 60px;">C&Oacute;DIGO</th>
                                    <th style="width: 150px;">NOMBRE COMPLETO</th>
                                    <th style="width: 80px;">TIPO DOC</th>
                                    <th style="width: 90px;">NRO. DOC</th>
                                    <th style="width: 100px;">PROFESI&Oacute;N</th>
                                    <th style="width: 80px;">TEL&Eacute;FONO</th>
                                    <th style="width: 140px;">EMAIL</th>
                                    <th style="width: 100px;">SEDE</th>
                                    <th style="width: 80px;">LOCAL</th>
                                    <th style="width: 100px;">&Aacute;REA</th>
                                    <th style="width: 120px;">DEPENDENCIA</th>
                                    <th style="width: 100px;">CARGO</th>
                                    <th style="width: 70px;">ESTADO</th>
                                    <th style="width: 80px;">ACCI&Oacute;N</th>
                                </tr>
                            </thead>
                            <tbody id="tbodyListaPersonal">
                            </tbody>
                        </table>
                    </div>

                    <!-- Paginacion para lista -->
                    <div class="pagination-wrapper">
                        <ul id="paginationListaPersonal" class="pagination" style="flex-wrap: wrap;"></ul>
                    </div>
                    <div class="page-info" id="pageInfoPersonal"></div>
                </div>
            </div>

            <!-- Card Formulario -->
            <div class="form-card" id="formCardDatos">
                <div class="card-header">
                    <i class="bi bi-person-plus-fill me-2"></i>Ingrese Datos del Personal
                </div>
                <div class="card-body p-3">

                    <!-- Fila 1: C&oacute;digo, Nombre, Apellido Pat., Apellido Mat. -->
                    <div class="row g-2 mb-2">
                        <div class="col-md-3 col-sm-6">
                            <label class="form-label-modern">C&oacute;digo</label>
                            <asp:TextBox ID="Codigo" runat="server" CssClass="form-control form-control-modern"
                                         MaxLength="5" Autocomplete="off" placeholder="Ingrese c&oacute;digo"
                                         onkeypress="SoloNumeros()" />
                            <asp:RequiredFieldValidator ID="rfvCodigo" runat="server" ControlToValidate="Codigo"
                                                       ErrorMessage="*" CssClass="validator-error" />
                            <asp:RegularExpressionValidator ID="revCodigo" runat="server" ControlToValidate="Codigo"
                                                             ErrorMessage="C&oacute;digo debe tener 5 d&iacute;gitos"
                                                             CssClass="validator-error"
                                                             ValidationExpression="\d{5}" />
                        </div>
                        <div class="col-md-3 col-sm-6">
                            <label class="form-label-modern">Nombre</label>
                            <asp:TextBox ID="Nombre" runat="server" CssClass="form-control form-control-modern"
                                         MaxLength="25" Autocomplete="off" placeholder="Ingrese nombre"
                                         onchange="CambiaLetraMayuscula('Nombre')" onkeypress="SoloLetrasMinusculas()" />
                            <asp:RequiredFieldValidator ID="rfvNombre" runat="server" ControlToValidate="Nombre"
                                                       ErrorMessage="*" CssClass="validator-error" />
                        </div>
                        <div class="col-md-3 col-sm-6">
                            <label class="form-label-modern">Apellido Paterno</label>
                            <asp:TextBox ID="ApellidoPat" runat="server" CssClass="form-control form-control-modern"
                                         MaxLength="25" Autocomplete="off" placeholder="Apellido paterno"
                                         onchange="CambiaLetraMayuscula('ApellidoPat')" onkeypress="SoloLetrasMinusculas()" />
                            <asp:RequiredFieldValidator ID="rfvApellidoPat" runat="server" ControlToValidate="ApellidoPat"
                                                       ErrorMessage="*" CssClass="validator-error" />
                        </div>
                        <div class="col-md-3 col-sm-6">
                            <label class="form-label-modern">Apellido Materno</label>
                            <asp:TextBox ID="ApellidoMat" runat="server" CssClass="form-control form-control-modern"
                                         MaxLength="25" Autocomplete="off" placeholder="Apellido materno"
                                         onchange="CambiaLetraMayuscula('ApellidoMat')" onkeypress="SoloLetrasMinusculas()" />
                            <asp:RequiredFieldValidator ID="rfvApellidoMat" runat="server" ControlToValidate="ApellidoMat"
                                                       ErrorMessage="*" CssClass="validator-error" />
                        </div>
                    </div>

                    <!-- Fila 2: Tipo Doc., Nro Doc., Profesi&oacute;n, Tel&eacute;fono -->
                    <div class="row g-2 mb-2">
                        <div class="col-md-3 col-sm-6">
                            <label class="form-label-modern">Tipo Doc. Ident.</label>
                            <asp:DropDownList ID="TipoDocIdent" runat="server" CssClass="form-control form-control-modern"
                                             AppendDataBoundItems="True">
                                <asp:ListItem Value="-1">Seleccione una opción</asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="rfvTipoDocIdent" runat="server" ControlToValidate="TipoDocIdent"
                                                       ErrorMessage="*" CssClass="validator-error" />
                        </div>
                        <div class="col-md-3 col-sm-6">
                            <label class="form-label-modern">Nro. Doc. Ident.</label>
                            <asp:TextBox ID="NroDocIdent" runat="server" CssClass="form-control form-control-modern"
                                         MaxLength="25" Autocomplete="off" placeholder="N&uacute;mero de documento"
                                         onkeypress="SoloNumeros()" />
                            <asp:RequiredFieldValidator ID="rfvNroDocIdent" runat="server" ControlToValidate="NroDocIdent"
                                                       ErrorMessage="*" CssClass="validator-error" />
                        </div>
                        <div class="col-md-3 col-sm-6">
                            <label class="form-label-modern">Profesi&oacute;n</label>
                            <asp:DropDownList ID="Profesion" runat="server" CssClass="form-control form-control-modern"
                                             AppendDataBoundItems="True">
                                <asp:ListItem Value="-1">Seleccione una opción</asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="rfvProfesion" runat="server" ControlToValidate="Profesion"
                                                       ErrorMessage="*" CssClass="validator-error" />
                        </div>
                        <div class="col-md-3 col-sm-6">
                            <label class="form-label-modern">Tel&eacute;fono</label>
                            <asp:TextBox ID="Telefono" runat="server" CssClass="form-control form-control-modern"
                                         MaxLength="9" Autocomplete="off" placeholder="N&uacute;mero telef&oacute;nico"
                                         onkeypress="SoloNumeros()" />
                            <asp:RequiredFieldValidator ID="rfvTelefono" runat="server" ControlToValidate="Telefono"
                                                       ErrorMessage="*" CssClass="validator-error" />
                        </div>
                    </div>

                    <!-- Fila 3: Email, Sede, Local, &Aacute;rea -->
                    <div class="row g-2 mb-2">
                        <div class="col-md-3 col-sm-6">
                            <label class="form-label-modern">Email</label>
                            <asp:TextBox ID="Email" runat="server" CssClass="form-control form-control-modern"
                                         MaxLength="100" placeholder="email@ejemplo.com" />
                            <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="Email"
                                                       ErrorMessage="*" CssClass="validator-error" />
                            <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="Email"
                                                             Display="Dynamic" ErrorMessage="Email incorrecto"
                                                             CssClass="validator-error"
                                                             ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" />
                        </div>
                        <div class="col-md-3 col-sm-6">
                            <label class="form-label-modern">Sede</label>
                            <asp:DropDownList ID="Sede" runat="server" CssClass="form-control form-control-modern"
                                             AppendDataBoundItems="True" AutoPostBack="True"
                                             OnSelectedIndexChanged="Sede_SelectedIndexChanged">
                                <asp:ListItem Value="-1">Seleccione una opción</asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="rfvSede" runat="server" ControlToValidate="Sede"
                                                       ErrorMessage="*" CssClass="validator-error" />
                            <asp:RegularExpressionValidator ID="revSede" runat="server" ControlToValidate="Sede"
                                                             Display="Dynamic" ErrorMessage="*"
                                                             CssClass="validator-error"
                                                             ValidationExpression="\d{1,999}" />
                        </div>
                        <div class="col-md-3 col-sm-6">
                            <label class="form-label-modern">Local</label>
                            <asp:DropDownList ID="Local" runat="server" CssClass="form-control form-control-modern"
                                             AppendDataBoundItems="True" AutoPostBack="True"
                                             OnSelectedIndexChanged="Local_SelectedIndexChanged">
                                <asp:ListItem Value="-1">Seleccione una opción</asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="rfvLocal" runat="server" ControlToValidate="Local"
                                                       ErrorMessage="*" CssClass="validator-error" />
                            <asp:RegularExpressionValidator ID="revLocal" runat="server" ControlToValidate="Local"
                                                             Display="Dynamic" ErrorMessage="*"
                                                             CssClass="validator-error"
                                                             ValidationExpression="\d{1,999}" />
                        </div>
                        <div class="col-md-3 col-sm-6">
                            <label class="form-label-modern">&Aacute;rea</label>
                            <asp:DropDownList ID="Area" runat="server" CssClass="form-control form-control-modern"
                                             AppendDataBoundItems="True">
                                <asp:ListItem Value="-1">Seleccione una opción</asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="rfvArea" runat="server" ControlToValidate="Area"
                                                       ErrorMessage="*" CssClass="validator-error" />
                            <asp:RegularExpressionValidator ID="revArea" runat="server" ControlToValidate="Area"
                                                             Display="Dynamic" ErrorMessage="*"
                                                             CssClass="validator-error"
                                                             ValidationExpression="\d{1,999}" />
                        </div>
                    </div>

                    <!-- Fila 4: Dependencia, Cargo, Estado -->
                    <div class="row g-3 mb-4">
                        <div class="col-md-4 col-sm-6">
                            <label class="form-label-modern">Dependencia</label>
                            <asp:DropDownList ID="Dependencia" runat="server" CssClass="form-control form-control-modern"
                                             AppendDataBoundItems="True">
                                <asp:ListItem Value="-1">Seleccione una opción</asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="rfvDependencia" runat="server" ControlToValidate="Dependencia"
                                                       ErrorMessage="*" CssClass="validator-error" />
                            <asp:RegularExpressionValidator ID="revDependencia" runat="server" ControlToValidate="Dependencia"
                                                             Display="Dynamic" ErrorMessage="*"
                                                             CssClass="validator-error"
                                                             ValidationExpression="\d{1,999}" />
                        </div>
                        <div class="col-md-4 col-sm-6">
                            <label class="form-label-modern">Cargo</label>
                            <asp:DropDownList ID="Cargo" runat="server" CssClass="form-control form-control-modern"
                                             AppendDataBoundItems="True">
                                <asp:ListItem Value="-1">Seleccione una opción</asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="rfvCargo" runat="server" ControlToValidate="Cargo"
                                                       ErrorMessage="*" CssClass="validator-error" />
                        </div>
                        <div class="col-md-4 col-sm-6 d-flex align-items-end">
                            <div class="form-check">
                                <asp:CheckBox ID="Estado" runat="server" CssClass="form-check-input" />
                                <label class="form-check-label ms-2 form-label-modern" for="Estado">Activo</label>
                            </div>
                        </div>
                    </div>

                    <!-- Botones de acci&oacute;n -->
                    <div class="d-flex flex-wrap gap-2 justify-content-center">
                        <asp:Button ID="btnRegistrar" runat="server" Text="Registrar" CssClass="btn btn-success btn-modern"
                                    OnClick="btnRegistrar_Click"
                                    OnClientClick="return Confirmar('¿Desea registrar Personal?');" />
                        <asp:Button ID="btnModificar" runat="server" Text="Modificar" CssClass="btn btn-warning btn-modern"
                                    OnClick="btnModificar_Click"
                                    OnClientClick="return Confirmar('¿Desea modificar Personal?');" />
                        <asp:Button ID="btnEliminar" runat="server" Text="Eliminar" CssClass="btn btn-danger btn-modern"
                                    OnClick="btnEliminar_Click"
                                    OnClientClick="return Confirmar('¿Desea eliminar Personal?');" />
                        <asp:Button ID="btnCancelar" runat="server" Text="Cancelar" CssClass="btn btn-secondary btn-modern"
                                    OnClick="btnCancelar_Click" CausesValidation="False" />
                    </div>
                </div>
            </div>

            <!-- Hidden Fields -->
            <asp:HiddenField ID="__mensaje" runat="server" />
            <asp:HiddenField ID="__pagina" runat="server" />
            <asp:HiddenField ID="ID_PERSONAL" runat="server" Value="0" EnableViewState="False" />
            <asp:HiddenField ID="datosJson" runat="server" EnableViewState="False" ClientIDMode="Static" />

        </div>
    </form>

    <!-- Scripts -->
    <script type="text/javascript" src="Otros_css_js/resaltar.js"></script>

    <script type="text/javascript">
        if (window.addEventListener) {
            window.addEventListener('load', function() {
                initPersonalGrid();
            }, false);
        } else if (window.attachEvent) {
            window.attachEvent('onload', function() {
                initPersonalGrid();
            });
        }
    </script>

</body>
</html>
