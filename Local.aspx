<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Local.aspx.cs" Inherits="TiposElementoConfiguracion" UnobtrusiveValidationMode="None" %>

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

        function SoloLetrasMinusculas() {
            if (!((event.keyCode >= 97 && event.keyCode <= 122) || event.keyCode == 32 || event.keyCode == 193 || event.keyCode == 201 || event.keyCode == 205 || event.keyCode == 209 || event.keyCode == 211 || event.keyCode == 218 || event.keyCode == 220 || event.keyCode == 241)) {
                event.returnValue = false;
            }
        }

        function CambiaLetraMayuscula(Caja) {
            document.getElementById(Caja).value = document.getElementById(Caja).value.toUpperCase();
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

    <!-- ========== LIST VIEW SECTION ========== -->
    <div class="container">
        <div class="form-card mt-4">
            <div class="card-header">
                <i class="bi bi-list-ul me-2"></i>Lista de Locales
            </div>
            <div class="card-body p-3">
                <!-- Buscador -->
                <div class="row g-2 mb-3">
                    <div class="col-md-6 col-sm-6">
                        <div class="input-group">
                            <span class="input-group-text"><i class="bi bi-search"></i></span>
                            <input type="text" id="txtBuscarLocal" class="form-control form-control-modern"
                                   placeholder="Buscar por c&oacute;digo, nombre, direcci&oacute;n o sede..."
                                   onkeyup="filtrarLocales()" />
                        </div>
                    </div>
                    <div class="col-md-2 col-sm-3">
                        <span id="lblTotalRegistros" class="badge bg-primary align-middle" style="padding: 0.5rem 1rem; font-size: 0.9rem;"></span>
                    </div>
                </div>

                <!-- Tabla HTML para lista -->
                <div class="table-wrapper" style="max-height: 500px; overflow-y: auto;">
                    <table id="tblListaLocales" class="table table-modern-grid table-hover">
                        <thead style="position: sticky; top: 0; z-index: 1;">
                            <tr style="background-color: #000; color: #fff;">
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
                <div class="pagination-wrapper">
                    <div class="d-flex flex-wrap gap-2 align-items-center">
                        <button type="button" id="btnAnterior" class="btn btn-outline-primary btn-sm" onclick="paginarLocales(-1)" disabled>
                            <i class="bi bi-chevron-left"></i> Anterior
                        </button>
                        <span id="lblPaginacion" class="badge bg-secondary" style="padding: 0.5rem 1rem; font-size: 0.9rem;"></span>
                        <button type="button" id="btnSiguiente" class="btn btn-outline-primary btn-sm" onclick="paginarLocales(1)" disabled>
                            Siguiente <i class="bi bi-chevron-right"></i>
                        </button>
                    </div>
                </div>
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
                                         MaxLength="50" Autocomplete="off" placeholder="Ingrese nombre local judicial"
                                         onchange="CambiaLetraMayuscula('Nombre_Local')" onkeypress="SoloLetrasMinusculas()" />
                            <asp:RequiredFieldValidator ID="rfvNombre_Local" runat="server" ControlToValidate="Nombre_Local"
                                                       ErrorMessage="*" CssClass="validator-error" />
                        </div>
                    </div>

                    <!-- Fila 3: Direccion -->
                    <div class="row g-2 mb-2">
                        <div class="col-md-6 col-sm-6">
                            <label class="form-label-modern">Direcci&oacute;n</label>
                            <asp:TextBox ID="Direccion_Local" runat="server" CssClass="form-control form-control-modern"
                                         MaxLength="50" Autocomplete="off" placeholder="Ingrese direcci&oacute;n local judicial"
                                         onchange="CambiaLetraMayuscula('Direccion_Local')" onkeypress="SoloLetrasMinusculas()" />
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
                                <asp:ListItem Value="-1">_____SELECCIONE SEDE_____</asp:ListItem>
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
                                             MaxLength="25" Autocomplete="off" placeholder="Ingrese ubicaci&oacute;n geogr&aacute;fica local judicial"
                                             onchange="CambiaLetraMayuscula('NOMBRE_CARGO')" onkeypress="SoloLetrasMinusculas()" />
                                <asp:ImageButton ID="ibtnBUSCAR_PROPIETARIO" runat="server" CausesValidation="False"
                                                 CssClass="btn btn-info btn-modern" ImageUrl="~/Imagnes/buscar.ico"
                                                 ToolTip="Buscar Propietario" OnClientClick="abrir_ventana_busca_Ubicacion_Geografica();" />
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

            <!-- Card Buscador -->
            <div class="form-card mt-4">
                <div class="card-header">
                    <i class="bi bi-search me-2"></i>Buscar Local
                </div>
                <div class="card-body p-3">
                    <div class="row g-2 mb-2">
                        <div class="col-md-3 col-sm-6">
                            <div class="form-check">
                                <asp:CheckBox ID="cbnl" runat="server" CssClass="form-check-input" Text="Nombre Local" onChange="Activa(1);"/>
                            </div>
                            <asp:TextBox ID="nl" runat="server" CssClass="form-control form-control-modern mt-2"
                                         MaxLength="50" Autocomplete="off" placeholder="Ingrese nombre local a buscar"
                                         Enabled="False" />
                        </div>
                        <div class="col-md-3 col-sm-6">
                            <div class="form-check">
                                <asp:CheckBox ID="cbs" runat="server" CssClass="form-check-input" Text="Sede" onChange="Activa(2);"/>
                            </div>
                            <asp:DropDownList ID="ddls" runat="server" CssClass="form-control form-control-modern mt-2"
                                              AppendDataBoundItems="True" Enabled="False" onChange="Activa();">
                                <asp:ListItem Value="-1">_____SELECCIONE SEDE_____</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="col-md-3 col-sm-6 d-flex align-items-end">
                            <div class="d-flex flex-wrap gap-2">
                                <asp:LinkButton ID="lbtnBuscar" runat="server" CausesValidation="False" CssClass="btn btn-info btn-modern"
                                                OnClick="lbtnBuscar_Click" UseSubmitBehavior="False">
                                    <i class="bi bi-search"></i> Buscar
                                </asp:LinkButton>
                                <asp:Button ID="btnActualizarInformacion" runat="server" CssClass="btn btn-warning btn-modern"
                                            OnClick="btnActualizarInformacion_Click" Text="Actualizar Informaci&oacute;n" CausesValidation="False" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Tabla de Resultados -->
            <div class="table-wrapper mt-4">
                <asp:Table ID="Table_" runat="server" CssClass="table table-modern-grid table-hover">
                    <asp:TableRow ID="TableRow1" runat="server">
                        <asp:TableCell ID="tcID_LOCAL" runat="server" BackColor="Black" BorderColor="Black"
                                      ForeColor="White" Width="7%" Visible="false">ID LOCAL</asp:TableCell>

                        <asp:TableCell ID="tcLOCAL_CODIGO" runat="server" BackColor="Black" BorderColor="Black"
                                       ForeColor="White" Width="15%">LOCAL C&Oacute;DIGO</asp:TableCell>

                        <asp:TableCell ID="tcLOCAL_NOMBRE" runat="server" BackColor="Black" BorderColor="Black"
                                       ForeColor="White" Width="15%">LOCAL NOMBRE</asp:TableCell>

                        <asp:TableCell ID="tcLOCAL_DIRECCION" runat="server" BackColor="Black" BorderColor="Black"
                                       ForeColor="White" Width="15%">LOCAL DIRECCI&Oacute;N</asp:TableCell>

                        <asp:TableCell ID="tcSEDE" runat="server" BackColor="Black" BorderColor="Black"
                                       ForeColor="White" Width="15%">SEDE</asp:TableCell>

                        <asp:TableCell ID="tcID_UBI" runat="server" BackColor="Black" BorderColor="Black"
                                       ForeColor="White" Width="15%" Visible="false">ID UBI</asp:TableCell>

                        <asp:TableCell ID="tcUBICACION_GEOGRAFICA" runat="server" BackColor="Black" BorderColor="Black"
                                       ForeColor="White" Width="15%">UBICACI&Oacute;N GEOGR&Aacute;FICA</asp:TableCell>

                        <asp:TableCell ID="tcTELEFONO" runat="server" BackColor="Black" BorderColor="Black"
                                       ForeColor="White" Width="15%">TEL&Eacute;FONO</asp:TableCell>

                        <asp:TableCell ID="tcPAGINA_WEB" runat="server" BackColor="Black" BorderColor="Black"
                                       ForeColor="White" Width="15%">P&Aacute;GINA WEB</asp:TableCell>

                        <asp:TableCell ID="tcEMAIL" runat="server" BackColor="Black" BorderColor="Black"
                                       ForeColor="White" Width="15%">EMAIL</asp:TableCell>

                        <asp:TableCell ID="tcTOTAL_CIS" runat="server" BackColor="Black" BorderColor="Black"
                                       ForeColor="White" Width="15%">TOTAL CIS</asp:TableCell>

                        <asp:TableCell ID="SELECCIONAR_LOCAL" runat="server" BackColor="Black" BorderColor="Black"
                                       ForeColor="White" Width="7%">SELECCIONAR LOCAL</asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
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
        var todosLosLocales = [];
        var localesFiltrados = [];
        var paginaActual = 1;
        var elementosPorPagina = 10;
        var datosJsonControl = null;

        // ========== INICIALIZACION AL CARGAR PAGINA ==========
        function inicializarListaLocales() {
            datosJsonControl = document.getElementById('<%= datosJson.ClientID %>');
            if (datosJsonControl && datosJsonControl.value) {
                try {
                    todosLosLocales = JSON.parse(datosJsonControl.value);
                    localesFiltrados = todosLosLocales;
                    filtrarLocales();
                } catch (e) {
                    console.error('Error al parsear datos JSON:', e);
                }
            }
        }

        // ========== FILTRAR LOCALES ==========
        function filtrarLocales() {
            var textoBusqueda = document.getElementById('txtBuscarLocal').value.toLowerCase().trim();
            if (textoBusqueda === '') {
                localesFiltrados = todosLosLocales;
            } else {
                localesFiltrados = todosLosLocales.filter(function(local) {
                    return local.codigo.toLowerCase().indexOf(textoBusqueda) !== -1 ||
                           local.nombre.toLowerCase().indexOf(textoBusqueda) !== -1 ||
                           local.direccion.toLowerCase().indexOf(textoBusqueda) !== -1 ||
                           local.sede.toLowerCase().indexOf(textoBusqueda) !== -1;
                });
            }
            paginaActual = 1;
            renderizarTablaLocales();
        }

        // ========== RENDERIZAR TABLA ==========
        function renderizarTablaLocales() {
            var tbody = document.getElementById('tbodyLocales');
            if (!tbody) return;

            var inicio = (paginaActual - 1) * elementosPorPagina;
            var fin = inicio + elementosPorPagina;
            var localesPagina = localesFiltrados.slice(inicio, fin);

            var html = '';
            if (localesPagina.length === 0) {
                html = '<tr><td colspan="7" class="text-center py-4">No se encontraron registros</td></tr>';
            } else {
                for (var i = 0; i < localesPagina.length; i++) {
                    var local = localesPagina[i];
                    html += '<tr onclick="seleccionarLocal(\'' + local.id + '\',\'' + local.codigo + '\',\'' + local.nombre + '\',\'' + local.direccion + '\',\'' + local.sede + '\',\'' + local.idUbi + '\',\'' + local.ubiGeo + '\',\'' + local.telefono + '\',\'' + local.paginaWeb + '\',\'' + local.email + '\',\'' + local.totalCis + '\')" style="cursor:pointer;">';
                    html += '<td>' + local.codigo + '</td>';
                    html += '<td>' + local.nombre + '</td>';
                    html += '<td>' + local.direccion + '</td>';
                    html += '<td>' + local.sede + '</td>';
                    html += '<td>' + local.ubiGeo + '</td>';
                    html += '<td>' + local.telefono + '</td>';
                    html += '<td>' + local.totalCis + '</td>';
                    html += '</tr>';
                }
            }
            tbody.innerHTML = html;

            // Actualizar total de registros
            var lblTotal = document.getElementById('lblTotalRegistros');
            if (lblTotal) {
                lblTotal.textContent = 'Total: ' + localesFiltrados.length + ' registro(s)';
            }

            // Actualizar paginacion
            actualizarPaginacion();
        }

        // ========== ACTUALIZAR PAGINACION ==========
        function actualizarPaginacion() {
            var totalPaginas = Math.ceil(localesFiltrados.length / elementosPorPagina);
            var lblPaginacion = document.getElementById('lblPaginacion');
            var btnAnterior = document.getElementById('btnAnterior');
            var btnSiguiente = document.getElementById('btnSiguiente');

            if (lblPaginacion) {
                lblPaginacion.textContent = 'P&aacute;gina ' + paginaActual + ' de ' + (totalPaginas > 0 ? totalPaginas : 1);
            }
            if (btnAnterior) {
                btnAnterior.disabled = (paginaActual <= 1);
            }
            if (btnSiguiente) {
                btnSiguiente.disabled = (paginaActual >= totalPaginas);
            }
        }

        // ========== PAGINAR ==========
        function paginarLocales(direccion) {
            var totalPaginas = Math.ceil(localesFiltrados.length / elementosPorPagina);
            if (direccion === -1 && paginaActual > 1) {
                paginaActual--;
            } else if (direccion === 1 && paginaActual < totalPaginas) {
                paginaActual++;
            }
            renderizarTablaLocales();
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
            window.addEventListener('load', inicializarListaLocales);
        } else if (window.attachEvent) {
            window.attachEvent('onload', inicializarListaLocales);
        }
    </script>

</body>
</html>
