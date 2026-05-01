<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ReporteComponentesAsignados.aspx.cs" Inherits="ElementosConfiguracion" UnobtrusiveValidationMode="None" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>Reporte Componentes Asignados</title>

    <!-- Bootstrap 5.3 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet" />

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
            .table-wrapper { padding: 1rem; }
        }
    </style>

    <script lang="javascript" type="text/javascript">
        function abrir_ventana_imprimir_reporte(Opcion) {
            if (Verificar_Datos_tabla(Opcion)) {
                window.name = "Lista de Personal";
                var options = 'channelmode=1,directories=0,fullscreen=0,location=0,menubar=0,resizable=no,titlebar=0,toolbar=0,edge=Raised,status=no,scrollbars=1,width=1000,height=500,top=70px, left=175px';
                window.open('Reporte.aspx', '', options);
            }
        }

        function Verificar_Datos_tabla(Opcion) {
            var Pregunta = '';
            var Mensaje = '';
            if (Opcion == 1) {
                Pregunta = "Desea exportar los datos a Microsoft Office Excel...?";
                Mensaje = "No hay datos para exportar a Microsoft Office Excel.";
            }
            else if (Opcion == 2) {
                Pregunta = "Desea imprimir el reporte?";
                Mensaje = "No hay datos para imprimir el reporte.";
            }
            var tabla = document.getElementById("Table_");
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
        }

        function window_load() {
            MostrarMensaje()
        }

        function Confirmar(men) {
            if (!confirm(men))
                return false;
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
                            <li><a class="dropdown-item" href="../Mantenimiento/Personal.aspx">Personal</a></li>
                            <li class="dropdown-submenu">
                                <a class="dropdown-item dropdown-toggle" href="#">Tablas Institucion</a>
                                <ul class="dropdown-menu">
                                    <li><a class="dropdown-item" href="../Mantenimiento/Sede.aspx">Sede</a></li>
                                    <li><a class="dropdown-item" href="../Mantenimiento/Local.aspx">Local</a></li>
                                    <li><a class="dropdown-item" href="../Mantenimiento/Area.aspx">Area</a></li>
                                    <li><a class="dropdown-item" href="../Mantenimiento/Dependencia.aspx">Dependencia</a></li>
                                </ul>
                            </li>
                            <li class="dropdown-submenu">
                                <a class="dropdown-item dropdown-toggle" href="#">Tablas Personal</a>
                                <ul class="dropdown-menu">
                                    <li><a class="dropdown-item" href="../Mantenimiento/Cargo.aspx">Cargo</a></li>
                                    <li><a class="dropdown-item" href="../Mantenimiento/ProfecionOcupacion.aspx">Profecion - Ocupacion</a></li>
                                </ul>
                            </li>
                            <li><hr class="dropdown-divider" /></li>
                            <li class="dropdown-submenu">
                                <a class="dropdown-item dropdown-toggle" href="#">Tablas Elemento Configuracion</a>
                                <ul class="dropdown-menu">
                                    <li><a class="dropdown-item" href="../Mantenimiento/Modelo.aspx">Modelo</a></li>
                                    <li><a class="dropdown-item" href="../Mantenimiento/Marca.aspx">Marca</a></li>
                                    <li><a class="dropdown-item" href="../Mantenimiento/DescripcionElementoConfiguracion.aspx">Descripcion Elemento Configuracion</a></li>
                                    <li><a class="dropdown-item" href="../Mantenimiento/TiposElementoConfiguracion.aspx">Tipos Elemento Configuracion</a></li>
                                    <li><a class="dropdown-item" href="../Mantenimiento/TipoRelacionElementoConfiguracion.aspx">Tipo Relacion Elemento Configuracion</a></li>
                                    <li><a class="dropdown-item" href="../Mantenimiento/TipoComponeneteCI.aspx">Tipo Componente Elemento Configuracion</a></li>
                                    <li><a class="dropdown-item" href="../Mantenimiento/EstadoActualCI.aspx">Estado Actual Elemento Configuracion</a></li>
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
                            <li><a class="dropdown-item" href="../GestionCI/ElementosConfiguracion.aspx">Elementos de Configuracion</a></li>
                            <li><a class="dropdown-item" href="../GestionCI/RelacionesElementosConfiguracion.aspx">Relacion de Elementos de Configuracion</a></li>
                            <li><hr class="dropdown-divider" /></li>
                            <li><a class="dropdown-item" href="../GestionCI/CIsAsignarComponenetes.aspx">Asignar Componentes Elementos de Configuracion</a></li>
                            <li><hr class="dropdown-divider" /></li>
                            <li><a class="dropdown-item" href="../GestionCI/LicenciasElementoConfiguracion.aspx">Licencias de Elementos de Configuracion</a></li>
                            <li><hr class="dropdown-divider" /></li>
                            <li><a class="dropdown-item" href="../GestionCI/SeguimientosElementoConfiguracion.aspx">Seguimiento de Elementos de Configuracion</a></li>
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
                            <li><a class="dropdown-item" href="../Mantenimiento/Usuario.aspx">Usuarios</a></li>
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

    <form id="form1" runat="server">
        <div class="container">
            <div class="table-responsive">
               <div class="table-wrapper">
                <table class="table table text-center">
                    <tr>
                        <td style="text-align: left" colspan="5">
                            &nbsp;</td>
                        <td style="text-align: left">
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td style="text-align: left" >
                            <asp:CheckBox ID="cbnci" runat="server" CssClass="form-check-input position-static" Font-Size="X-Small" Text="Nombre CI" AutoPostBack="True" OnCheckedChanged="cbnci_CheckedChanged"/>
                        </td>
                        <td style="text-align: left" >
                            <asp:CheckBox ID="cbtci" runat="server" CssClass="form-check-input position-static" Font-Size="X-Small" Text="Tipo CI" AutoPostBack="True" OnCheckedChanged="cbtci_CheckedChanged"/>
                        </td>
                        <td style="text-align: left" >
                            <asp:CheckBox ID="cbeci" runat="server" CssClass="form-check-input position-static" Font-Size="X-Small" Text="Estado CI" AutoPostBack="True" OnCheckedChanged="cbeci_CheckedChanged"/>
                        </td>
                        <td style="text-align: left" class="auto-style1" >
                            <asp:CheckBox ID="cbns" runat="server" CssClass="form-check-input position-static" Font-Size="X-Small" Text="Nro. Serie" AutoPostBack="True" OnCheckedChanged="cbns_CheckedChanged"/>
                        </td>
                        <td style="text-align: left" class="auto-style1" >
                            <asp:CheckBox ID="cbdci" runat="server" CssClass="form-check-input position-static" Font-Size="X-Small" Text="Descripcion CI" AutoPostBack="True" OnCheckedChanged="cbdci_CheckedChanged"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                             <asp:TextBox ID="txtnci" runat="server" CssClass="form-control form-control-modern" MaxLength="25" Autocomplete="off" placeholder="Ingresar Nombre" onchange=""
                        onkeypress="" Enabled="False"></asp:TextBox>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddltci" runat="server" CssClass="form-control form-control-modern"
                                        AppendDataBoundItems="True" Enabled="False"
                                       >
                                        <asp:ListItem Value="-1">_____SELECCIONE TIPO CI_____</asp:ListItem>
                                    </asp:DropDownList>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddleci" runat="server" CssClass="form-control form-control-modern"
                                        AppendDataBoundItems="True" Enabled="False"
                                       >
                                        <asp:ListItem Value="-1">_____SELECCIONE ESTADO CI_____</asp:ListItem>
                                    </asp:DropDownList>
                        </td>
                        <td class="auto-style1">
                             <asp:TextBox ID="txtns" runat="server" CssClass="form-control form-control-modern" MaxLength="25" Autocomplete="off" placeholder="Ingresar Nro Serie CI" onchange=""
                        onkeypress="" Enabled="False"></asp:TextBox>
                        </td>
                        <td class="auto-style1">
                            <asp:DropDownList ID="ddldci" runat="server" CssClass="form-control form-control-modern"
                                        AppendDataBoundItems="True" Enabled="False"
                                       >
                                        <asp:ListItem Value="-1">_____SELECCIONE DESCRIPCION CI_____</asp:ListItem>
                                    </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: left" >
                            <asp:CheckBox ID="cbm" runat="server" CssClass="form-check-input position-static" Font-Size="X-Small" Text="Marca" AutoPostBack="True" OnCheckedChanged="cbm_CheckedChanged"/>
                        </td>
                        <td style="text-align: left" >
                            <asp:CheckBox ID="cbs" runat="server" CssClass="form-check-input position-static" Font-Size="X-Small" Text="Sede" AutoPostBack="True" OnCheckedChanged="cbs_CheckedChanged"/>
                        </td>
                        <td style="text-align: left" >
                            <asp:CheckBox ID="cbl" runat="server" CssClass="form-check-input position-static" Font-Size="X-Small" Text="Local" AutoPostBack="True" OnCheckedChanged="cbl_CheckedChanged"/>
                        </td>
                        <td style="text-align: left" >
                            <asp:CheckBox ID="cba" runat="server" CssClass="form-check-input position-static" Font-Size="X-Small" Text="Area" AutoPostBack="True" OnCheckedChanged="cba_CheckedChanged"/>
                        </td>
                        <td class="auto-style1">
                            <asp:LinkButton ID="lbtnBuscar" runat="server" CausesValidation="False" class="btn btn-info btn-modern" OnClick="lbtnBuscar_Click" Text="Buscar" UseSubmitBehavior="False" />
                            <asp:Button ID="btnActualizarInformacion" runat="server" class="btn btn-success btn-modern" onclick="btnActualizarInformacion_Click" Text="Actualizar Informacion" />
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: left" >
                            <asp:DropDownList ID="ddlm" runat="server" CssClass="form-control form-control-modern"
                                        AppendDataBoundItems="True" Enabled="False"
                                       >
                                        <asp:ListItem Value="-1">_____SELECCIONE MARCA_____</asp:ListItem>
                                    </asp:DropDownList>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddls" runat="server" CssClass="form-control form-control-modern"
                                        AppendDataBoundItems="True" Enabled="False" OnSelectedIndexChanged="ddls_SelectedIndexChanged"
                                       >
                                        <asp:ListItem Value="-1">_____SELECCIONE SEDE_____</asp:ListItem>
                                    </asp:DropDownList>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddll" runat="server" CssClass="form-control form-control-modern"
                                        AppendDataBoundItems="True" AutoPostBack="True" Enabled="False" OnSelectedIndexChanged="ddll_SelectedIndexChanged"
                                       >
                                        <asp:ListItem Value="-1">_____SELECCIONE LOCAL_____</asp:ListItem>
                                    </asp:DropDownList>
                        </td>
                        <td class="auto-style1">
                            <asp:DropDownList ID="ddla" runat="server" CssClass="form-control form-control-modern"
                                        AppendDataBoundItems="True" Enabled="False"
                                       >
                                        <asp:ListItem Value="-1">_____SELECCIONE AREA_____</asp:ListItem>
                                    </asp:DropDownList>
                        </td>
                        <td class="auto-style1">
                            <asp:LinkButton ID="IMPRIMIR" runat="server" CausesValidation="False" class="btn btn-info btn-modern" onclick="IMPRIMIR_Click" onclientclick="abrir_ventana_imprimir_reporte(2);" Width="120px">Imprimir reporte</asp:LinkButton>
                        </td>
                    </tr>
                    <tr>
                    <td colspan="5">
                        <asp:Table ID="Table_" runat="server" BackColor="White"
                            class="table table-condensed"
                        BorderColor="White" CellPadding="2" CellSpacing="0" Font-Size="X-Small"
                        GridLines="Both" style="text-align: left">
                        <asp:TableRow ID="CABECERA" runat="server">
                            <asp:TableCell ID="_ID_CI" runat="server" BackColor="#FFFFC0" BorderColor="#FFFFC0"
                                     ForeColor="Green" Visible="False">ID CI</asp:TableCell>

                            <asp:TableCell ID="_NOMBRE_CI" runat="server" BackColor="Black" BorderColor="Black"
                                ForeColor="White" >NOMBRE CI</asp:TableCell>

                            <asp:TableCell ID="_NOMBRE_TIPO_CI" runat="server" BackColor="Black" BorderColor="Black"
                                ForeColor="White" >TIPO CI</asp:TableCell>

                            <asp:TableCell ID="_NRO_SERIE" runat="server" BackColor="Black" BorderColor="Black"
                                ForeColor="White" >NRO SERIE</asp:TableCell>

                            <asp:TableCell ID="_FABRICANTE_PROVEEDOR" runat="server" BackColor="Black" BorderColor="Black"
                                ForeColor="White" >FABRICANTE<br />PROVEEDOR</asp:TableCell>

                            <asp:TableCell ID="_MARCA_MODELO" runat="server" BackColor="Black" BorderColor="Black"
                                ForeColor="White" >MARCA/<br />MODELO</asp:TableCell>

                            <asp:TableCell ID="_IP" runat="server" BackColor="Black" BorderColor="Black"
                                ForeColor="White" >IP</asp:TableCell>

                            <asp:TableCell ID="_GATEWAY" runat="server" BackColor="Black" BorderColor="Black"
                                ForeColor="White" >GATEWAY</asp:TableCell>

                            <asp:TableCell ID="_GRUPO_TRABAJO" runat="server" BackColor="Black" BorderColor="Black"
                                ForeColor="White" >GRUPO<br />TRABAJO</asp:TableCell>

                            <asp:TableCell ID="_ESTADO_CI" runat="server" BackColor="Black" BorderColor="Black"
                                ForeColor="White" >ESTADO CI</asp:TableCell>

                           <asp:TableCell ID="_PROPIETARIO" runat="server" BackColor="Black" BorderColor="Black"
                                ForeColor="White" >PROPIETARIO</asp:TableCell>

                            <asp:TableCell ID="_DESCRIPCION_CI" runat="server" BackColor="Black" BorderColor="Black"
                                ForeColor="White" >DESCRIPCION CI</asp:TableCell>

                             <asp:TableCell ID="_IMPACTO_PRIORIDAD" runat="server" BackColor="Black" BorderColor="Black"
                                ForeColor="White" >IMPACTO/<br />PRIORIDAD</asp:TableCell>

                            <asp:TableCell ID="_SEDE_LOCAL" runat="server" BackColor="Black" BorderColor="Black"
                                ForeColor="White" >SEDE/<br />LOCAL</asp:TableCell>

                            <asp:TableCell ID="_AREA" runat="server" BackColor="Black" BorderColor="Black"
                                ForeColor="White" >AREA</asp:TableCell>
                            <asp:TableCell ID="_NRO_PISO" runat="server" BackColor="Black" BorderColor="Black"
                                ForeColor="White" >NRO PISO</asp:TableCell>
                            <asp:TableCell ID="_NRO_AMBIENTE" runat="server" BackColor="Black" BorderColor="Black"
                                ForeColor="White" >NRO AMBIENTE</asp:TableCell>

                            <asp:TableCell ID="EDITAR" runat="server" BackColor="Black" BorderColor="Black"
                                ForeColor="White" Width="3%" HorizontalAlign="Center">COMPONENTES</asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                    </td>

                </tr>
                    <tr>
                    <td colspan="5">
                        &nbsp;</td>

                </tr>
                    <tr>
                    <td colspan="5">
                        <asp:Table ID="Table_0" runat="server" BackColor="White"
                            class="table table-condensed"
                        BorderColor="White" CellPadding="2" CellSpacing="0" Font-Size="X-Small"
                        GridLines="Both" style="text-align: left">
                        <asp:TableRow ID="CABECERA0" runat="server">
                            <asp:TableCell ID="_ID_COMPONENETE" runat="server" BackColor="#FFFFC0" BorderColor="#FFFFC0"
                                     ForeColor="Green" Visible="False">ID COMPONENETE</asp:TableCell>

                            <asp:TableCell ID="_TIPO_COMPONENTE" runat="server" BackColor="Black" BorderColor="Black"
                                ForeColor="White" >TIPO COMPONENTE</asp:TableCell>

                            <asp:TableCell ID="_IDESCRIPCION" runat="server" BackColor="Black" BorderColor="Black"
                                ForeColor="White">DESCRIPCION</asp:TableCell>

                            <asp:TableCell ID="FABRICANTE" runat="server" BackColor="Black" BorderColor="Black"
                                ForeColor="White" >FABRICANTE</asp:TableCell>

                            <asp:TableCell ID="_NRO_SERIE_" runat="server" BackColor="Black" BorderColor="Black"
                                ForeColor="White" >NRO SERIE</asp:TableCell>

                            <asp:TableCell ID="_MODELO" runat="server" BackColor="Black" BorderColor="Black"
                                ForeColor="White" >MODELO</asp:TableCell>

                             <asp:TableCell ID="_MARCA" runat="server" BackColor="Black" BorderColor="Black"
                                ForeColor="White" >MARCA</asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                    </td>

                </tr>
                <tr>
                    <td colspan="5" >
                        <asp:HiddenField ID="__pagina" runat="server" />
                        <asp:HiddenField ID="__mensaje" runat="server" />
                    </td>

                </tr>
                </table>
               </div>
            </div>
        </div>
    </form>

    <!-- Scripts -->
    <script type="text/javascript" src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script lang ="JavaScript" type="text/javascript">
        ResaltarFila('Table_');
        ResaltarFila('Table_0');
    </script>

</body>
</html>
