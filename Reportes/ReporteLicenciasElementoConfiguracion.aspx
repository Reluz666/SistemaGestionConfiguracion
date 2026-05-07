<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ReporteLicenciasElementoConfiguracion.aspx.cs" Inherits="LicenciasElementoConfiguracion" UnobtrusiveValidationMode="None" %>

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

        .auto-style1 { width: 309px; }
    </style>

    <script lang="javascript" type="text/javascript">
        function abrir_ventana_imprimir_reporte(Opcion) {
            if (Verificar_Datos_tabla(Opcion)) {
                window.name = "Lista de Personal";
                var options = 'channelmode=1,directories=0,fullscreen=0,location=0,menubar=0,resizable=no,titlebar=0,toolbar=0,edge=Raised,status=no,scrollbars=1,width=1000,height=500,top=70px, left=175px';
                window.open('../Reportes/Reporte.aspx', '', options);
            }
        }

        function Verificar_Datos_tabla(Opcion) {
            var Pregunta = '';
            var Mensaje = '';
            if (Opcion == 1) {
                Pregunta = "¿Desea exportar los datos a Microsoft Office Excel...?";
                Mensaje = "No hay datos para exportar a Microsoft Office Excel.";
            }
            else if (Opcion == 2) {
                Pregunta = "¿Desea imprimir el reporte?";
                Mensaje = "No hay datos para imprimir el reporte.";
            }
            var tabla = document.getElementById("tblLicencias");
            var tabla_longitud = (tabla.rows.length) - 1;
            var Ok, Rpta;
            Ok = true;
            Rpta = confirm(Pregunta);
            if (Rpta == 1) {
                if (tabla_longitud == 0) {
                    Ok = false;
                    alert(Mensaje);
                }
            }
            else {
                Ok = false;
            }
            return Ok;
        }

        function MostrarMensaje() {
            var mensaje = document.getElementById("__mensaje").value;
            if (mensaje != "") {
                alert(mensaje);
                if (document.getElementById("__pagina").value != "")
                    location.href = document.getElementById("__pagina").value;
            }
        }

        function window_load() {
            MostrarMensaje()
        }

        function Confirmar(men) {
            if (!confirm(men))
                return false;
        }

        function toggleRow(rowId) {
            var row = document.getElementById(rowId);
            if (row.style.display === "none" || row.style.display === "") {
                row.style.display = "table-row";
            } else {
                row.style.display = "none";
            }
        }
    </script>
</head>
<body onload="MostrarMensaje();">
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

    <!-- ========== NAVBAR ========== -->
    <nav class="navbar navbar-expand-lg navbar-modern fixed-top">
        <div class="container-fluid">
            <a class="navbar-brand" href="../Menu.aspx">
                <i class="bi bi-house-door-fill me-1"></i>Inicio
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                    data-bs-target="#navbarNav" aria-controls="navbarNav"
                    aria-expanded="false" aria-label="Navegacion">
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
                            <li><a class="dropdown-item" href="../Personal.aspx">Personal</a></li>
                            <li class="dropdown-submenu">
                                <a class="dropdown-item dropdown-toggle" href="#">Tablas Institucion</a>
                                <ul class="dropdown-menu">
                                    <li><a class="dropdown-item" href="../Sede.aspx">Sede</a></li>
                                    <li><a class="dropdown-item" href="../Local.aspx">Local</a></li>
                                    <li><a class="dropdown-item" href="../Area.aspx">Area</a></li>
                                    <li><a class="dropdown-item" href="../Dependencia.aspx">Dependencia</a></li>
                                </ul>
                            </li>
                            <li class="dropdown-submenu">
                                <a class="dropdown-item dropdown-toggle" href="#">Tablas Personal</a>
                                <ul class="dropdown-menu">
                                    <li><a class="dropdown-item" href="../Cargo.aspx">Cargo</a></li>
                                    <li><a class="dropdown-item" href="../ProfecionOcupacion.aspx">Profecion - Ocupacion</a></li>
                                </ul>
                            </li>
                            <li><hr class="dropdown-divider" /></li>
                            <li class="dropdown-submenu">
                                <a class="dropdown-item dropdown-toggle" href="#">Tablas Elemento Configuracion</a>
                                <ul class="dropdown-menu">
                                    <li><a class="dropdown-item" href="../Modelo.aspx">Modelo</a></li>
                                    <li><a class="dropdown-item" href="../Marca.aspx">Marca</a></li>
                                    <li><a class="dropdown-item" href="../DescripcionElementoConfiguracion.aspx">Descripcion Elemento Configuracion</a></li>
                                    <li><a class="dropdown-item" href="../TiposElementoConfiguracion.aspx">Tipos Elemento Configuracion</a></li>
                                    <li><a class="dropdown-item" href="../TipoRelacionElementoConfiguracion.aspx">Tipo Relacion Elemento Configuracion</a></li>
                                    <li><a class="dropdown-item" href="../TipoComponeneteCI.aspx">Tipo Componente Elemento Configuracion</a></li>
                                    <li><a class="dropdown-item" href="../EstadoActualCI.aspx">Estado Actual Elemento Configuracion</a></li>
                                </ul>
                            </li>
                        </ul>
                    </li>

                    <!-- Gestion de Configuracion -->
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="gestionDropdown"
                           role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            <i class="bi bi-person-lines-fill me-1"></i>Gestion de Configuracion
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="gestionDropdown">
                            <li><a class="dropdown-item" href="../ElementosConfiguracion.aspx">Elementos de Configuracion</a></li>
                            <li><a class="dropdown-item" href="../RelacionesElementosConfiguracion.aspx">Relacion de Elementos de Configuracion</a></li>
                            <li><hr class="dropdown-divider" /></li>
                            <li><a class="dropdown-item" href="../CIsAsignarComponenetes.aspx">Asignar Componentes Elementos de Configuracion</a></li>
                            <li><hr class="dropdown-divider" /></li>
                            <li><a class="dropdown-item" href="../LicenciasElementoConfiguracion.aspx">Licencias de Elementos de Configuracion</a></li>
                            <li><hr class="dropdown-divider" /></li>
                            <li><a class="dropdown-item" href="../SeguimientosElementoConfiguracion.aspx">Seguimiento de Elementos de Configuracion</a></li>
                        </ul>
                    </li>

                    <!-- Reportes -->
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="reportesDropdown"
                           role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            <i class="bi bi-file-earmark-bar-graph-fill me-1"></i>Reportes
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="reportesDropdown">
                            <li><a class="dropdown-item" href="ReporteElementosConfiguracion.aspx">Reporte de Elementos de Configuracion</a></li>
                            <li><a class="dropdown-item" href="ReporteRelacionesElementosConfiguracion.aspx">Reporte de Relaciones de Elementos de Configuracion</a></li>
                            <li><a class="dropdown-item" href="ReporteSeguimientosElementoConfiguracion.aspx">Reporte de Seguimientos de Elementos de Configuracion</a></li>
                            <li><a class="dropdown-item" href="ReporteLicenciasElementoConfiguracion.aspx">Reporte de Licencias de Elementos de Configuracion</a></li>
                            <li><a class="dropdown-item" href="ReporteCIsSeguidos.aspx">Reporte de Elementos de Configuracion Seguidos</a></li>
                            <li><a class="dropdown-item" href="ReporteComponentesAsignados.aspx">Reporte de Componentes de Elementos de Configuracion Asignados</a></li>
                            <li><hr class="dropdown-divider" /></li>
                            <li><a class="dropdown-item" href="ReporteDatosCorrectosCI.aspx">Reporte de Datos Correctos de Elementos de Configuracion</a></li>
                            <li><a class="dropdown-item" href="ReporteDatosIncorrectosCI.aspx">Reporte de Datos Incorrectos de Elementos de Configuracion</a></li>
                            <li><a class="dropdown-item" href="ReporteCIsInformacionContenidaEnCMDB.aspx">Reporte de Informacion de Elementos de Configuracion Contenidas en la CMDB</a></li>
                            <li><a class="dropdown-item" href="Reporte_De_CIS_Relativo_A_Servicios.aspx">Reporte de CIS Relativo A Servicios</a></li>
                            <li><a class="dropdown-item" href="Reporte_CIS_Relacionados_Con_Otros_CIS.aspx">Reporte de CIs relacionados con otros CIs</a></li>
                        </ul>
                    </li>

                    <!-- Configuraciones -->
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="configDropdown"
                           role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            <i class="bi bi-gear-fill me-1"></i>Configuraciones
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="configDropdown">
                            <li><a class="dropdown-item" href="../Usuario.aspx">Usuarios</a></li>
                            <li><a class="dropdown-item" href="../Configuracion/Usuarios.aspx">Permisos</a></li>
                            <li><hr class="dropdown-divider" /></li>
                            <li><a class="dropdown-item" href="../CerrarSession.aspx" style="color: #e94560;">Cerrar Sesion</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Espaciador para navbar fija -->
    <div class="top-spacer"></div>

        <div class="container">
            <div class="form-card">
                <div class="table-responsive">
                    <div class="container-fluid">
                <table class="table table text-center">
                    <tr>
                        <td style="text-align: left" colspan="7">
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td style="text-align: left" >
                            <asp:CheckBox ID="cbtl" runat="server" CssClass="form-check-input position-static" Font-Size="X-Small" Text="Tipo Licencia" AutoPostBack="True" OnCheckedChanged="cbtl_CheckedChanged"/>
                        </td>
                        <td style="text-align: left" >
                            <asp:CheckBox ID="cbs" runat="server" CssClass="form-check-input position-static" Font-Size="X-Small" Text="Suscripcion" AutoPostBack="True" OnCheckedChanged="cbs_CheckedChanged"/>
                        </td>
                        <td style="text-align: left" >
                            <asp:CheckBox ID="cbp" runat="server" CssClass="form-check-input position-static" Font-Size="X-Small" Text="Licencia Perpetua" AutoPostBack="True" OnCheckedChanged="cbp_CheckedChanged"/>
                        </td>
                        <td style="text-align: left" class="auto-style1" colspan="4" >
                            <asp:CheckBox ID="cbf" runat="server" CssClass="form-check-input position-static" Font-Size="X-Small" Text="Fecha Vencimiento Suscripcion" AutoPostBack="True" OnCheckedChanged="cbf_CheckedChanged"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:DropDownList ID="ddltl" runat="server" CssClass="form-control input-sm"
                                        AppendDataBoundItems="True" Enabled="False" AutoPostBack="True" OnSelectedIndexChanged="ddltl_SelectedIndexChanged"
                                       >
                                        <asp:ListItem Value="-1">_____SELECCIONE TIPO LICENCIA_____</asp:ListItem>
                                    </asp:DropDownList>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddls" runat="server" CssClass="form-control input-sm"
                                        AppendDataBoundItems="True" Enabled="False"
                                       >
                                        <asp:ListItem Value="-1">_____SELECCIONE SUSCRIPCION LICENCIA_____</asp:ListItem>
                                    </asp:DropDownList>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlp" runat="server" CssClass="form-control input-sm"
                                        AppendDataBoundItems="True" Enabled="False"
                                       >
                                        <asp:ListItem Value="-1">_____SELECCIONE OPCION_____</asp:ListItem>
                                        <asp:ListItem Value="1">SI</asp:ListItem>
                                        <asp:ListItem Value="0">NO</asp:ListItem>
                                    </asp:DropDownList>
                        </td>
                        <td class="auto-style1">
                            <strong>Fec. Ini:</strong></td>
                        <td style="text-align: left" >
                    <asp:TextBox ID="txtFechaInicioSuscripcion" runat="server"
                        class="form-control" placeholder="Ingrese fec. inicio" Width="" onFocus='' onChange='' onBlur='' Enabled="False"></asp:TextBox>

                    <input id="btnFechaInicioSuscripcion" type="button"
                        value="..." style="height: 25px; width: 25px;"
                        class="form-check" /></td>
                        <td>

                            <strong>Fec. Fin</strong>:</td>
                       <td style="text-align: left" >

                    <asp:TextBox ID="txtFechaFinSuscripcion" runat="server" class="form-control" placeholder="Ingrese fec. fin" onFocus='' onChange='' onBlur='' Enabled="False"></asp:TextBox>
                    <input id="btnFechaFinSuscripcion" type="button"
                        value="..." style="height: 25px; width: 25px;" class="form-check" /></td>
                    </tr>
                    <tr>
                        <td style="text-align: left" >
                            &nbsp;</td>
                        <td style="text-align: left" >
                            &nbsp;</td>
                        <td style="text-align: right" >
                            <asp:LinkButton ID="lbtnBuscar" runat="server" CausesValidation="False" class="btn btn-info" Text="Buscar" UseSubmitBehavior="False" OnClick="lbtnBuscar_Click" />
                            </td>
                        <td style="text-align: left" colspan="2" >
                            <asp:Button ID="btnActualizarInformacion" runat="server" class="btn btn-success" CssClass="btn btn-warning" Text="Actualizar Informacion" OnClick="btnActualizarInformacion_Click" />
                            </td>
                        <td style="text-align: left" colspan="2" >
                            <asp:LinkButton ID="IMPRIMIR" runat="server" CausesValidation="False" class="btn btn-info" onclick="IMPRIMIR_Click" onclientclick="abrir_ventana_imprimir_reporte(2);" Width="120px">Imprimir reporte</asp:LinkButton>
                        </td>
                    </tr>
                    </table>
                   </div>
                </div>

                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <asp:Table ID="tblLicencias" runat="server"
                            CssClass="table table-condensed table-responsive" Font-Size="Small">
                        </asp:Table>
                    </ContentTemplate>
                    <Triggers>
                    </Triggers>
                </asp:UpdatePanel>
            </div>
        </div>

        <asp:HiddenField ID="__mensaje" runat="server" />
        <asp:HiddenField ID="__pagina" runat="server" />
    </form>

    <!-- Scripts -->
    <script type="text/javascript" src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>