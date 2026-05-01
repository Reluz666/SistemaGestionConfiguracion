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
    <!-- DataTables.net CSS -->
    <link href="https://cdn.jsdelivr.net/npm/datatables.net-bs5@2.0.1/css/dataTables.bootstrap5.min.css" rel="stylesheet" />

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

        /* ===== TABLA - moderna pero SIN DataTables interfering con asp:Table ===== */
        .table-wrapper {
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 4px 25px rgba(0, 0, 0, 0.08);
            padding: 1rem;
            border: 1px solid rgba(0, 0, 0, 0.05);
            overflow-x: auto;
        }

        .table-modern-grid {
            border-collapse: separate !important;
            border-spacing: 0;
            width: 100%;
            min-width: 900px;
        }

        .table-modern-grid thead tr th {
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

        .table-modern-grid thead tr th:first-child {
            border-radius: 10px 0 0 10px;
        }

        .table-modern-grid thead tr th:last-child {
            border-radius: 0 10px 10px 0;
        }

        .table-modern-grid tbody tr td {
            padding: 0.5rem 0.45rem !important;
            border: none;
            border-bottom: 1px solid #f1f1f1;
            vertical-align: middle;
            font-size: 0.8rem;
            color: #2d3436;
            background: #fff;
        }

        .table-modern-grid tbody tr:hover td {
            background: rgba(233, 69, 96, 0.04);
        }

        .table-modern-grid tbody tr:last-child td {
            border-bottom: none;
        }

        /* Link button "Editar" en la tabla */
        .btn-link-personal {
            color: #d40924;
            font-weight: 700;
            font-size: 0.8rem;
            text-decoration: none;
            cursor: pointer;
            background: rgba(212, 9, 36, 0.08);
            padding: 0.25rem 0.6rem;
            border-radius: 6px;
            border: 1px solid rgba(212, 9, 36, 0.3);
            transition: all 0.2s ease;
            display: inline-block;
        }

        .btn-link-personal:hover {
            background: rgba(212, 9, 36, 0.15);
            border-color: #d40924;
            text-decoration: none;
            transform: translateY(-1px);
        }

        /* Subclass for asp:Table to apply same styling */
        #Table_ {
            border-collapse: separate !important;
            border-spacing: 0;
            width: 100%;
            min-width: 900px;
        }

        #Table_ thead tr th {
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

        #Table_ tbody tr:hover td {
            background: rgba(233, 69, 96, 0.04) !important;
        }

        #Table_ tbody tr td {
            padding: 0.5rem 0.45rem !important;
            border: none !important;
            border-bottom: 1px solid #f1f1f1 !important;
            vertical-align: middle;
            font-size: 0.8rem;
            color: #2d3436;
        }

        .estado-activo { color: #00b894; font-weight: 600; }
        .estado-inactivo { color: #e94560; font-weight: 600; }

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
</head>
<body onload="MostrarMensaje()">

    <!-- ========== NAVBAR ========== -->
    <nav class="navbar navbar-expand-lg navbar-modern fixed-top">
        <div class="container-fluid">
            <a class="navbar-brand" href="../menu.aspx">
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

    <!-- ========== CONTENT ========== -->
    <div class="top-spacer"></div>

    <form id="form1" runat="server">

    <div class ="container">
         <div class="table-responsive" >
             <table class="table text-center" >
                <thead>
                  <tr>
                    <td style="text-align: center; color: #FFFFFF; background-color: #000000;" colspan="3"> INGRESE DATOS LOCAL JUDICIAL</td>

                  </tr>
                  <tr>
                        <td style="text-align: left; color: #FFFFFF; background-color: #000000;"
                            class="style2" colspan="3"> Codigo</td>



                  </tr>
                  <tr>
                        <td style="text-align: left;"
                            class="style2" colspan="3">
                             <asp:TextBox ID="Codigo_Local" runat="server" CssClass="form-control input-sm" MaxLength="6" Autocomplete = "off" placeholder="Ingrese Codigo Local Judicial" onchange=""
                        onkeypress="SoloNumeros()"></asp:TextBox>
                             <asp:RequiredFieldValidator ID="rfvCodigo_Local" runat="server" ControlToValidate="Codigo_Local" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </td>


                   </tr>
                  <tr>
                        <td style="text-align: left; color: #FFFFFF; background-color: #000000;"
                            class="style2" colspan="3">
                             Nombre</td>


                   </tr>
                  <tr>
                        <td style="text-align: left; color: #FFFFFF;"
                            class="style2" colspan="3">
                             <asp:TextBox ID="Nombre_Local" runat="server" CssClass="form-control input-sm" MaxLength="50" Autocomplete = "off" placeholder="Ingrese Nombre Local Judicial" onchange="CambiaLetraMayuscula('Nombre_Local')"
                        onkeypress="SoloLetrasMinusculas()"></asp:TextBox>
                             <asp:RequiredFieldValidator ID="rfvNombre_Local" runat="server" ControlToValidate="Nombre_Local" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </td>


                   </tr>
                  <tr>
                        <td style="text-align: left; color: #FFFFFF; background-color: #000000;"
                            class="style2" colspan="3">
                             Direccion</td>


                   </tr>
                  <tr>
                        <td style="text-align: left; color: #FFFFFF;"
                            class="style2" colspan="3">
                             <asp:TextBox ID="Direccion_Local" runat="server" CssClass="form-control input-sm" MaxLength="50" Autocomplete = "off" placeholder="Ingrese Dicreccion Local Judicial" onchange="CambiaLetraMayuscula('Direccion_Local')"
                        onkeypress="SoloLetrasMinusculas()"></asp:TextBox>
                             <asp:RequiredFieldValidator ID="rfvDireccion_Local" runat="server" ControlToValidate="Direccion_Local" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </td>


                   </tr>
                  <tr>
                        <td style="text-align: left; color: #FFFFFF; background-color: #000000;"
                            class="style2" colspan="3">
                             Sede</td>


                   </tr>
                  <tr>
                        <td style="text-align: left; color: #FFFFFF;"
                            class="style2" colspan="3">
                             <asp:DropDownList ID="Sede" runat="server" CssClass="form-control input-sm"
                                        AppendDataBoundItems="True"
                                       >
                                        <asp:ListItem Value="-1">_____SELECCIONE SEDE_____</asp:ListItem>
                                    </asp:DropDownList>
                             <asp:RequiredFieldValidator ID="rfvSede" runat="server" ControlToValidate="Sede" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                             <asp:RegularExpressionValidator ID="revSede" runat="server" BackColor="White"
                        ControlToValidate="Sede" Display="Dynamic" ErrorMessage="*" ForeColor="Red"
                        SetFocusOnError="True" ValidationExpression="[1-999]"></asp:RegularExpressionValidator>
                        </td>


                   </tr>
                  <tr>
                        <td style="text-align: left; color: #FFFFFF; background-color: #000000;"
                            class="style2" colspan="3">
                             Ubicacion Geografica</td>


                   </tr>
                  <tr>
                        <td style="text-align: left; color: #FFFFFF;"
                            class="style2" colspan="3">
                             <asp:TextBox ID="Ubicacion_Geografica" runat="server" CssClass="form-control input-sm" MaxLength="25" Autocomplete = "off" placeholder="Ingrese Ubicacion Geografica Local Judicial" onchange="CambiaLetraMayuscula('NOMBRE_CARGO')"
                        onkeypress="SoloLetrasMinusculas()"></asp:TextBox>
                             <asp:RequiredFieldValidator ID="rfvUbicacion_Geografica" runat="server" ControlToValidate="Ubicacion_Geografica" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                             <asp:ImageButton ID="ibtnBUSCAR_PROPIETARIO" runat="server" CausesValidation="False" CssClass="btn btn-info btn-xs" ImageUrl="~/Imagnes/buscar.ico" ToolTip="Buscar Propietario" OnClientClick="abrir_ventana_busca_Ubicacion_Geografica();" />
                             <asp:HiddenField ID="hfCodigo_Ubicacion_Geografica" runat="server" Value="0" />
                        </td>


                   </tr>
                  <tr>
                        <td style="text-align: left; color: #FFFFFF; background-color: #000000;"
                            class="style2" colspan="3">
                             Telefono</td>


                   </tr>
                  <tr>
                        <td style="text-align: left; color: #FFFFFF; background-color: #FFFFFF;"
                            class="style2" colspan="3">
                             <asp:TextBox ID="Telefono_local" runat="server" CssClass="form-control input-sm" MaxLength="50" Autocomplete = "off" placeholder="Ingrese Telefono" onchange=""
                        onkeypress="SoloNumeros()"></asp:TextBox>
                             <asp:RequiredFieldValidator ID="rfvTelefono_local" runat="server" ControlToValidate="Telefono_local" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </td>


                   </tr>
                  <tr>
                        <td style="text-align: left; color: #FFFFFF; background-color: #000000;"
                            class="style2" colspan="3">
                             Pagiina Web</td>


                   </tr>
                  <tr>
                        <td style="text-align: left; color: #FFFFFF; background-color: #FFFFFF;"
                            class="style2" colspan="3">
                             <asp:TextBox ID="Pagnia_Web_Local" runat="server" CssClass="form-control input-sm" MaxLength="50" Autocomplete = "off" placeholder="Ingrese Pagiina Web" onchange=""
                        onkeypress=""></asp:TextBox>
                             <asp:RequiredFieldValidator ID="rfvPagnia_Web_Local" runat="server" ControlToValidate="Pagnia_Web_Local" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                             <asp:RegularExpressionValidator ID="revPagnia_Web_Local" runat="server" ControlToValidate="Pagnia_Web_Local" ErrorMessage="Direccion Pagina Web Incorrecta" ForeColor="Red" ValidationExpression="(http|http(s)?://)?([\w-]+\.)+[\w-]+[.com|.in|.org]+(\?[\&amp;=]*)?"</asp:RegularExpressionValidator>
                        </td>


                   </tr>
                  <tr>
                        <td style="text-align: left; color: #FFFFFF; background-color: #000000;"
                            class="style2" colspan="3">
                             Email</td>


                   </tr>
                  <tr>
                        <td style="text-align: left; color: #FFFFFF; background-color: #FFFFFF;"
                            class="style2" colspan="3">
                             <asp:TextBox ID="Email_Local" runat="server" CssClass="form-control input-sm" MaxLength="50" Autocomplete = "off" placeholder="Ingrese Email" onchange=""
                        onkeypress=""></asp:TextBox>
                             <asp:RequiredFieldValidator ID="rfvEmail_Local" runat="server" ControlToValidate="Email_Local" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                             <asp:RegularExpressionValidator ID="revEmail_Local" runat="server" ControlToValidate="Email_Local" ErrorMessage="Email Incorrecto" ForeColor="Red" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                        </td>


                   </tr>
                  <tr>
                        <td style="text-align: left; color: #FFFFFF; background-color: #000000;"
                            class="style2" colspan="3">
                             Nro. Total de Elementos de Configuracion en Posecion</td>


                   </tr>
                  <tr>
                        <td style="text-align: left; color: #FFFFFF; background-color: #FFFFFF;"
                            class="style2" colspan="3">
                             <asp:TextBox ID="Total_CIS_Local" runat="server" CssClass="form-control input-sm" MaxLength="50" Autocomplete = "off" placeholder="Ingrese Nro. Total de Elementos de Configuracion en Posecion" onchange=""
                        onkeypress="SoloNumeros()"></asp:TextBox>
                             <asp:RequiredFieldValidator ID="rfvTotal_CIS_Local" runat="server" ControlToValidate="Total_CIS_Local" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </td>


                   </tr>
                  <tr>
                        <td style="text-align: left"
                            class="style2">
                             &nbsp;</td>
                         <td style="text-align: left"
                            class="style2">
                             &nbsp;</td>


                         <td style="text-align: left"
                            class="style2"> &nbsp;</td>



                   </tr>
                  <tr>
                <td colspan="3" style="text-align: center">
                   <asp:Button ID="btnRegistrar" runat="server"
                       style="font-family: Calibri; color: #000000; font-size: medium"
                        Text="Registrar"
                        onclientclick="return Confirmar('¿Desea registrar Local?');"
                        CssClass="btn btn-success" Visible="False" OnClick="btnRegistrar_Click" />
                    &nbsp;
                    <asp:Button ID="btnModificar" runat="server"
                        style="font-family: Calibri; color: #000000; font-size: medium"
                        Text="Modificar"  onclientclick="return Confirmar('¿Desea modificar Local?');" CssClass="btn btn-warning" Visible="False" OnClick="btnModificar_Click" />
                    &nbsp;
                    <asp:Button ID="btnEliminar" runat="server"
                        style="font-family: Calibri; color: #000000; font-size: medium"
                        Text="Eliminar"  onclientclick="return Confirmar('¿Desea eliminar Local?');" class="btn btn-danger" Visible="False" OnClick="btnEliminar_Click" />
                    &nbsp;
                    <asp:Button ID="btnCancelar" runat="server" class="btn btn-primary"
                        style="font-family: Calibri;  font-size: medium" Text="Cancelar" CausesValidation="False" Visible="False" OnClick="btnCancelar_Click"
                         />
                    </td>
            </tr>
                 </thead>
             </table>
    </div> </div>

    <div class ="container">
         <div class="table-responsive" >
             <table class="table text-center">
        <tr>
            <td style="text-align: left;"">
                            <asp:CheckBox ID="cbnl" runat="server" CssClass="form-check-input position-static&quot" Font-Size="X-Small" Text="Nombre Local" onChange="Activa(1);"/>
                        </td>
            <td style="text-align: left;"">
                            <asp:CheckBox ID="cbs" runat="server" CssClass="form-check-input position-static&quot" Font-Size="X-Small" Text="Sede" onChange="Activa(2);"/>
                        </td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td style="text-align: left;"">
                             <asp:TextBox ID="nl" runat="server" CssClass="form-control input-sm" MaxLength="50" Autocomplete = "off" placeholder="Ingrese Nombre Local Judicial a Buscar" onchange=""
                        onkeypress="" Enabled="False"></asp:TextBox>
                        </td>
            <td>
                             <asp:DropDownList ID="ddls" runat="server" CssClass="form-control input-sm"
                                        AppendDataBoundItems="True" Enabled="False"
                                       onChange="Activa();">
                                        <asp:ListItem Value="-1">_____SELECCIONE SEDE_____</asp:ListItem>
                                    </asp:DropDownList>
                             </td>
            <td>
                            <asp:LinkButton ID="lbtnBuscar" runat="server" CausesValidation="False" class="btn btn-info" OnClick="lbtnBuscar_Click" Text="Buscar  &lt;span class='glyphicon glyphicon-search'&gt;&lt;/span&gt;" UseSubmitBehavior="False" />
                            <asp:Button ID="btnActualizarInformacion" runat="server" class="btn btn-success" CssClass="btn btn-warning" onclick="btnActualizarInformacion_Click" Text="Actualizar Informacion" CausesValidation="False" />
                        </td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td colspan="4">

                        <asp:Table ID="Table_" runat="server" CssClass="form-control input"
                            class="table table-hover table-condensed" BackColor="White" BorderColor="White"
                            CellPadding="6" CellSpacing="2" Font-Size="Small" GridLines="Both" Width="100%"
                            style="text-align: left; font-size: x-small;">
                            <asp:TableRow ID="TableRow1" runat="server">
                                <asp:TableCell ID="tcID_LOCAL"  runat="server" BackColor="Black" BorderColor="Black"
                                    ForeColor="White" Width="7%" Visible="false">ID LOCAL</asp:TableCell>

                                <asp:TableCell ID="tcLOCAL_CODIGO"  runat="server" BackColor="Black" BorderColor="Black"
                                    ForeColor="White"  Width="15%">LOCAL CODIGO</asp:TableCell>

                                <asp:TableCell ID="tcLOCAL_NOMBRE"  runat="server" BackColor="Black" BorderColor="Black"
                                    ForeColor="White"  Width="15%">LOCAL NOMBRE</asp:TableCell>

                               <asp:TableCell ID="tcLOCAL_DIRECCION"  runat="server" BackColor="Black" BorderColor="Black"
                                    ForeColor="White"  Width="15%">LOCAL DIRECCION</asp:TableCell>

                               <asp:TableCell ID="tcSEDE"  runat="server" BackColor="Black" BorderColor="Black"
                                    ForeColor="White"  Width="15%">SEDE</asp:TableCell>

                               <asp:TableCell ID="tcID_UBI"  runat="server" BackColor="Black" BorderColor="Black"
                                    ForeColor="White"  Width="15%" Visible="false">ID UBI</asp:TableCell>

                               <asp:TableCell ID="tcUBICACION_GEOGRAFICA"  runat="server" BackColor="Black" BorderColor="Black"
                                    ForeColor="White"  Width="15%">UBICACION GEOGRAFICA</asp:TableCell>

                               <asp:TableCell ID="tcTELEFONO"  runat="server" BackColor="Black" BorderColor="Black"
                                    ForeColor="White"  Width="15%">TELEFONO</asp:TableCell>

                               <asp:TableCell ID="tcPAGINA_WEB"  runat="server" BackColor="Black" BorderColor="Black"
                                    ForeColor="White"  Width="15%">PAGINA WEB</asp:TableCell>

                               <asp:TableCell ID="tcEMAIL"  runat="server" BackColor="Black" BorderColor="Black"
                                    ForeColor="White"  Width="15%">EMAIL</asp:TableCell>

                               <asp:TableCell ID="tcTOTAL_CIS"  runat="server" BackColor="Black" BorderColor="Black"
                                    ForeColor="White"  Width="15%">TOTAL CIS</asp:TableCell>

                                <asp:TableCell ID="SELECCIONAR_LOCAL" runat="server" BackColor="Black" BorderColor="Black"
                                    ForeColor="White" Width="7%">SELECCIONAR LOCAL</asp:TableCell>

                            </asp:TableRow>
                        </asp:Table>

                    </td>

        </tr>

        <tr>
            <td colspan="3">
                    <asp:HiddenField ID="__mensaje" runat="server" />
                    <asp:HiddenField ID="__pagina" runat="server" />
                    <asp:HiddenField ID="Id_Local" runat="server" Value="0"
                        EnableViewState="False" />
                    </td>
            <td>
                    &nbsp;</td>
        </tr>
    </table>
    </div> </div>

    </form>

    <!-- Bootstrap 5.3 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    </body>
</html>
