<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Area.aspx.cs" Inherits="TiposElementoConfiguracion" UnobtrusiveValidationMode="None" %>

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
                                <asp:ImageButton ID="ibtnBUSCAR_LOCAL_JUDICIAL" runat="server" CausesValidation="False"
                                                 CssClass="btn btn-info btn-modern" ImageUrl="~/Imagnes/buscar.ico"
                                                 ToolTip="Buscar Local Judicial" OnClientClick="abrir_ventana_busca_Local_Judicial();" />
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

            <!-- Card Buscador -->
            <div class="form-card mt-4">
                <div class="card-header">
                    <i class="bi bi-search me-2"></i>Buscar &Aacute;rea
                </div>
                <div class="card-body p-3">
                    <div class="row g-2 mb-2">
                        <div class="col-md-3 col-sm-6">
                            <div class="form-check">
                                <asp:CheckBox ID="cbs" runat="server" CssClass="form-check-input" Text="Sede" onChange="Activa(1);"/>
                            </div>
                            <asp:DropDownList ID="ddls" runat="server" CssClass="form-control form-control-modern mt-2"
                                              AppendDataBoundItems="True" Enabled="False" onChange="Activa();"
                                              AutoPostBack="True" OnSelectedIndexChanged="ddls_SelectedIndexChanged">
                                <asp:ListItem Value="-1">_____SELECCIONE SEDE_____</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="col-md-3 col-sm-6">
                            <div class="form-check">
                                <asp:CheckBox ID="cbl" runat="server" CssClass="form-check-input" Text="Local" onChange="Activa(2);"/>
                            </div>
                            <asp:DropDownList ID="ddll" runat="server" CssClass="form-control form-control-modern mt-2"
                                              AppendDataBoundItems="True" Enabled="False" onChange="Activa();">
                                <asp:ListItem Value="-1">_____SELECCIONE LOCAL_____</asp:ListItem>
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
                        <asp:TableCell ID="tcID_AREA" runat="server" BackColor="Black" BorderColor="Black"
                                      ForeColor="White" Width="7%" Visible="false">ID AREA</asp:TableCell>

                        <asp:TableCell ID="tcSEDE" runat="server" BackColor="Black" BorderColor="Black"
                                       ForeColor="White" Width="15%">SEDE</asp:TableCell>

                        <asp:TableCell ID="tcLOCAL" runat="server" BackColor="Black" BorderColor="Black"
                                       ForeColor="White" Width="15%">LOCAL</asp:TableCell>

                        <asp:TableCell ID="tcDIRECCION_LOCAL" runat="server" BackColor="Black" BorderColor="Black"
                                       ForeColor="White" Width="15%">DIRECCI&Oacute;N LOCAL</asp:TableCell>

                        <asp:TableCell ID="tcCODIGO_AREA" runat="server" BackColor="Black" BorderColor="Black"
                                       ForeColor="White" Width="15%">C&Oacute;DIGO AREA</asp:TableCell>

                        <asp:TableCell ID="tcAREA" runat="server" BackColor="Black" BorderColor="Black"
                                       ForeColor="White" Width="15%">&Aacute;REA</asp:TableCell>

                        <asp:TableCell ID="tcNRO_PISO" runat="server" BackColor="Black" BorderColor="Black"
                                       ForeColor="White" Width="15%">NRO PISO</asp:TableCell>

                        <asp:TableCell ID="tcNRO_AMBIENTE" runat="server" BackColor="Black" BorderColor="Black"
                                       ForeColor="White" Width="15%">NRO AMBIENTE</asp:TableCell>

                        <asp:TableCell ID="SELECCIONAR_AREA" runat="server" BackColor="Black" BorderColor="Black"
                                       ForeColor="White" Width="7%">SELECCIONAR AREA</asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
            </div>

            <!-- Hidden Fields -->
            <asp:HiddenField ID="__mensaje" runat="server" />
            <asp:HiddenField ID="__pagina" runat="server" />
            <asp:HiddenField ID="Id_Area" runat="server" Value="0" EnableViewState="False" />

        </div>
    </form>

    <script type="text/javascript" src="Otros_css_js/resaltar.js"></script>

</body>
</html>
