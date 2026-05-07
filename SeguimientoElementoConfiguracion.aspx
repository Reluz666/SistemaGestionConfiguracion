<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SeguimientoElementoConfiguracion.aspx.cs" Inherits="TiposElementoConfiguracion" UnobtrusiveValidationMode="None" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>Seguimiento Elemento Configuracion</title>

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
    </style>

    <script lang="javascript" type="text/javascript">
        function abrir_ventana_busca_Elemento_Configuracion_Para_Seguimiento() {
            window.document.getElementById("hfID_ELEMENTO_CONFIGURACION").value = 0;
            window.document.getElementById("tbNombre_Tipo_NroSerie").value = "";
            window.document.getElementById("tbFabricante_Marca_Modelo").value = "";
            window.document.getElementById("tbEstado_Descripcion_Sede").value = "";
            window.document.getElementById("tbLocal_Ubicacion_Direccion").value = "";
            window.document.getElementById("tbArea_NroPiso_NroAmbiente").value = "";
            var options = 'channelmode=1,directories=0,fullscreen=0,location=0,menubar=0,resizable=0,titlebar=0,toolbar=0,edge=Raised,status=no,scrollbars=1,width=1500,height=700,top=50px, left=10px';
            window.open('Ventanas/ventanaElementosConfiguracionParaSeguimiento.aspx', '', options);
        }

        function abrir_ventana_busca_Relacion_CI_Con_Otros_CIS() {
            if (window.document.getElementById("hfID_ELEMENTO_CONFIGURACION").value > 0) {
                var options = 'channelmode=1,directories=0,fullscreen=0,location=0,menubar=0,resizable=0,titlebar=0,toolbar=0,edge=Raised,status=no,scrollbars=1,width=1500,height=700,top=50px, left=10px';
                window.open('Ventanas/ventanaRelacionCIConOtrosCIS.aspx?CI=' + window.document.getElementById("hfID_ELEMENTO_CONFIGURACION").value, '', options);
            } else {
                alert('Seleccione CI para buscar relacion con otros CIs');
            }

        }


        function MostrarMensaje() {
            var mensaje = document.getElementById("__mensaje").value;
            if (mensaje != "") {
                alert(mensaje);
                if (document.getElementById("__pagina").value != "")
                    location.href = document.getElementById("__pagina").value;

            }
            document.getElementById('<%= tbNombre_Tipo_NroSerie.ClientID %>').readOnly = true;
            document.getElementById('<%= tbFabricante_Marca_Modelo.ClientID %>').readOnly = true;
            document.getElementById('<%= tbEstado_Descripcion_Sede.ClientID %>').readOnly = true;
            document.getElementById('<%= tbLocal_Ubicacion_Direccion.ClientID %>').readOnly = true;
            document.getElementById('<%= tbArea_NroPiso_NroAmbiente.ClientID %>').readOnly = true;

            document.getElementById('<%= RESPONSABLE_SEGUIMIENTO.ClientID %>').readOnly = true;
            document.getElementById('<%=FECHA_SEGUIMIENTO.ClientID %>').readOnly = true;
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


    </script>

    <script type="text/javascript" src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body onload ="MostrarMensaje()">

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
                    <i class="bi bi-arrow-repeat me-2"></i>Ingrese Datos Seguimiento Elemento Configuracion
                </div>
                <div class="card-body p-3">

                    <!-- Elemento Configuracion -->
                    <div class="row g-3 mb-3">
                        <div class="col-md-12 col-sm-12">
                            <label class="form-label-modern">Elemento Configuracion</label>
                            <asp:Panel ID="Panel1" runat="server">
                                 <asp:TextBox ID="tbNombre_Tipo_NroSerie" runat="server" CssClass="form-control form-control-modern" BorderColor="White" BorderStyle="None" Font-Size="Small" Font-Bold="True" ></asp:TextBox>
                                 <asp:TextBox ID="tbFabricante_Marca_Modelo" runat="server" CssClass="form-control form-control-modern" BorderColor="White" Font-Bold="True"></asp:TextBox>
                                 <asp:TextBox ID="tbEstado_Descripcion_Sede" runat="server" CssClass="form-control form-control-modern" BorderColor="White" BorderStyle="None" Font-Bold="True"></asp:TextBox>
                                 <asp:TextBox ID="tbLocal_Ubicacion_Direccion" runat="server" CssClass="form-control form-control-modern" BorderColor="White" BorderStyle="None" Font-Bold="True"></asp:TextBox>
                                 <asp:TextBox ID="tbArea_NroPiso_NroAmbiente" runat="server" CssClass="form-control form-control-modern" BorderColor="White" BorderStyle="None" Font-Bold="True"></asp:TextBox>
                                 <asp:HiddenField ID="hfID_ELEMENTO_CONFIGURACION" runat="server" Value="0" />
                                 <asp:ImageButton ID="ibtnBUSCAR_ELEMENTOL_JCONFIGURACION" runat="server" CausesValidation="False" CssClass="btn btn-info btn-modern" ImageUrl="~/Imagnes/buscar.ico" OnClientClick="abrir_ventana_busca_Elemento_Configuracion_Para_Seguimiento();" ToolTip="Buscar Elemento de Configuracion" OnClick="ibtnBUSCAR_ELEMENTOL_JCONFIGURACION_Click" />
                            </asp:Panel>
                        </div>
                    </div>

                    <!-- Responsable y Fecha -->
                    <div class="row g-3 mb-3">
                        <div class="col-md-6 col-sm-12">
                            <label class="form-label-modern">Responsable Seguimiento</label>
                            <asp:TextBox ID="RESPONSABLE_SEGUIMIENTO" runat="server" CssClass="form-control form-control-modern" MaxLength="40" Autocomplete="off" placeholder="Ingrese Responsable Seguimiento Elemento Configuracion" onchange="CambiaLetraMayuscula('RESPONSABLE_SEGUIMIENTO')"
                        onkeypress="SoloLetrasMinusculas()" Width="500px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvRESPONSABLE_SEGUIMIENTO" runat="server" ControlToValidate="RESPONSABLE_SEGUIMIENTO" ErrorMessage="*" CssClass="validator-error" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <asp:HiddenField ID="hfID_RESPONSABLE_SEGUIMIENTO" runat="server" Value="0" />
                        </div>
                        <div class="col-md-6 col-sm-12">
                            <label class="form-label-modern">Fecha Seguimiento</label>
                            <asp:TextBox ID="FECHA_SEGUIMIENTO" runat="server" CssClass="form-control form-control-modern" MaxLength="40" Autocomplete="off" placeholder="Ingrese Fecha Seguimiento Elemento Configuracion" onchange="CambiaLetraMayuscula('RESPONSABLE_SEGUIMIENTO')"
                        onkeypress="SoloLetrasMinusculas()" Width="150px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvRESPONSABLE_SEGUIMIENTO0" runat="server" ControlToValidate="RESPONSABLE_SEGUIMIENTO" ErrorMessage="*" CssClass="validator-error" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </div>
                    </div>

                    <!-- Clasificacion Datos y Estado Actual -->
                    <div class="row g-3 mb-3">
                        <div class="col-md-6 col-sm-12">
                            <label class="form-label-modern">Clasificacion Datos</label>
                            <asp:DropDownList ID="CLASIFICACION_DATOS_CIS" runat="server" CssClass="form-control form-control-modern"
                                        AppendDataBoundItems="True" Width="500px"
                                       >
                                        <asp:ListItem Value="-1">_____SELECCIONE CLASIFICACION DATOS_____</asp:ListItem>
                                    </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="rfvCLASIFICACION_DATOS_CIS" runat="server" ControlToValidate="CLASIFICACION_DATOS_CIS" ErrorMessage="*" CssClass="validator-error" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="revCLASIFICACION_DATOS_CIS" runat="server" BackColor="White"
                        ControlToValidate="CLASIFICACION_DATOS_CIS" Display="Dynamic" ErrorMessage="*" CssClass="validator-error" ForeColor="Red"
                        SetFocusOnError="True" ValidationExpression="[1-999]"></asp:RegularExpressionValidator>
                        </div>
                        <div class="col-md-6 col-sm-12">
                            <label class="form-label-modern">Estado Actual</label>
                            <asp:CheckBoxList ID="cblEstado_Actual_CIs" runat="server" Width="550px" CssClass="form-check-input position-static" CellPadding="1" CellSpacing="1" Font-Size="Small" ForeColor="Black" RepeatColumns="2" RepeatDirection="Horizontal">
                                <asp:ListItem></asp:ListItem>
                                <asp:ListItem></asp:ListItem>
                                <asp:ListItem></asp:ListItem>
                                <asp:ListItem></asp:ListItem>
                                <asp:ListItem></asp:ListItem>
                                <asp:ListItem></asp:ListItem>
                                <asp:ListItem></asp:ListItem>
                                <asp:ListItem></asp:ListItem>
                                <asp:ListItem></asp:ListItem>
                                <asp:ListItem></asp:ListItem>
                            </asp:CheckBoxList>
                        </div>
                    </div>

                    <!-- Relacion con otros CIs -->
                    <div class="row g-3 mb-3">
                        <div class="col-md-6 col-sm-12">
                            <label class="form-label-modern">Relacion con otros CIs</label>
                            <asp:ImageButton ID="ibtnBUSCAR_RELACION_CI_OTROS_CIS" runat="server" CausesValidation="False" CssClass="btn btn-info btn-modern" ImageUrl="~/Imagnes/buscar.ico" OnClientClick="abrir_ventana_busca_Relacion_CI_Con_Otros_CIS();" ToolTip="Visualizar Elemento de Configuracion Relacionados con otros Elementos de Configuracion" OnClick="ibtnBUSCAR_ELEMENTOL_JCONFIGURACION_Click" />
                            <asp:CheckBox ID="RELACION_OTROS_CIS" runat="server" CssClass="form-check-input position-static" ForeColor="Black" Text="SI / NO" />
                        </div>
                        <div class="col-md-6 col-sm-12">
                            <label class="form-label-modern">Cumple Politicas de Gestion de Configuracion</label>
                            <asp:CheckBox ID="CUMPLE_POLITICAS_GESTION_CONFIGURACION_ORGANIZACION" runat="server" CssClass="form-check-input position-static" ForeColor="Black" Text="SI / NO" />
                        </div>
                    </div>

                    <!-- Observacion -->
                    <div class="row g-3 mb-3">
                        <div class="col-md-12 col-sm-12">
                            <label class="form-label-modern">Observacion</label>
                            <asp:TextBox ID="OBSERVACION_SEGUIMIENTO" runat="server" CssClass="form-control form-control-modern" MaxLength="25" Autocomplete="off" placeholder="Ingrese Observacion Seguimiento Elemento Configuracion" onchange="CambiaLetraMayuscula('OBSERVACION_SEGUIMIENTO')"
                        onkeypress="" Font-Size="Small" ForeColor="#3366FF" Height="100px" TextMode="MultiLine" Width="500px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvOBSERVACION_SEGUIMIENTO" runat="server" ControlToValidate="RESPONSABLE_SEGUIMIENTO" ErrorMessage="*" CssClass="validator-error" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </div>
                    </div>

                    <!-- Hidden Fields -->
                    <asp:HiddenField ID="__mensaje" runat="server" />
                    <asp:HiddenField ID="__pagina" runat="server" />
                    <asp:HiddenField ID="ID_SEGUIMIENTO" runat="server" Value="-1" EnableViewState="False" />
                    <asp:HiddenField ID="_operacion" runat="server" Value="N" EnableViewState="False" />

                    <!-- Botones de accion -->
                    <div class="d-flex flex-wrap gap-2 justify-content-center">
                        <asp:Button ID="btnRegistrar" runat="server"
                            style="font-family: Calibri; color: #000000; font-size: medium"
                            Text="Aceptar"
                            onclientclick="return Confirmar('¿Desea guardar datos seguimiento elemento configuracion?');"
                            CssClass="btn btn-success btn-modern" OnClick="btnRegistrar_Click" />
                        <asp:Button ID="btnCancelar" runat="server" class="btn btn-secondary btn-modern"
                            style="font-family: Calibri;  font-size: medium" Text="Cancelar" CausesValidation="False" OnClick="btnCancelar_Click"
                             />
                    </div>
                </div>
            </div>

        </div>
    </form>

    <!-- Scripts -->
    <script type="text/javascript" src="../Otros_css_js/resaltar.js"></script>

</body>
</html>