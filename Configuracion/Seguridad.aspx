<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Seguridad.aspx.cs" Inherits="Configuracion_Seguridad" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="hDiagostico" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>Seguridad</title>

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

        function window_load() {
            MostrarMensaje()
        }

        function Confirmar(men) {
            if (!confirm(men))
                return false;
        }

        function BloqueaIngresoDatos() {
            event.returnValue = false;
        }

        function SoloNumeros() {
            if ((event.keyCode < 48) || (event.keyCode > 57)) {
                event.returnValue = false;
            }
        }

        function SoloLetras(e) {
            if (!(event.keyCode >= 65 && event.keyCode <= 90 || event.keyCode == 32 || event.keyCode == 193 || event.keyCode == 201 || event.keyCode == 205 || event.keyCode == 209 || event.keyCode == 211 || event.keyCode == 218 || event.keyCode == 220)) {
                event.keyCode = 0;
            }
        }

        function SoloLetrasMinusculas() {
            if (!((event.keyCode >= 97 && event.keyCode <= 122) || event.keyCode == 32 || event.keyCode == 193 || event.keyCode == 201 || event.keyCode == 205 || event.keyCode == 209 || event.keyCode == 211 || event.keyCode == 218 || event.keyCode == 220 || event.keyCode == 241)) {
                event.returnValue = false;
            }
        }

        function LetrasNumeros() {
            if (!((event.keyCode >= 48 && event.keyCode <= 57) || event.keyCode >= 65 && event.keyCode <= 90 || event.keyCode >= 97 && event.keyCode <= 122 || event.keyCode == 32 || event.keyCode == 193 || event.keyCode == 201 || event.keyCode == 205 || event.keyCode == 209 || event.keyCode == 211 || event.keyCode == 218 || event.keyCode == 220)) {
                event.returnValue = false;
            }
        }

        function SoloDecimales(e, Punto, Texto) {
            if (event.keyCode == 8)
                ;
            else if (event.keyCode == 46) {
                if (Punto == false)
                    event.keyCode = 0;
                else {
                    for (i = 0; i < Texto.value.length; i++) {
                        if (Texto.value.charCodeAt(i) == 46) {
                            event.keyCode = 0;
                        }
                    }
                }
            }
            else if (!(event.keyCode >= 48 && event.keyCode <= 57)) {
                event.keyCode = 0;
            }
        }

        function CambiaLetraMayuscula(Caja) {
            document.getElementById(Caja).value = document.getElementById(Caja).value.toUpperCase();
        }

        function Activa(Celda,Letra,Fila,Coumna) {
            if (document.getElementById(Celda).checked == true) {
                Rpta = confirm("Desea Activar Autorizacion y Permisos Para Ingresar al Sistema?");
                if (Rpta == 1) {
                    for (j = 4; j < 19; j++) {
                        document.getElementById(Letra + Fila.toString() + j.toString()).checked = true;
                    }
                }
                else {
                    document.getElementById(Celda).checked = false;
                }
            }
            else {
                Rpta = confirm("Desea Desactivar Autorizacion y Permisos Para Ingresar al Sistema?");
                if (Rpta == 1) {
                    for (j = 4; j < 19; j++) {
                        document.getElementById(Letra + Fila.toString() + j.toString()).checked = false;
                    }
                }
                else {
                    document.getElementById(Celda).checked = true;
                }
            }
        }

        function abrir_ventana_imprimir_reporte(Opcion) {
            if (Verificar_Datos_tabla(Opcion)) {
                window.name = "Autorizacion y Permisos Para Ingresar al Sistema";
                var options = 'channelmode=1,directories=0,fullscreen=0,location=0,menubar=0,resizable=no,titlebar=0,toolbar=0,edge=Raised,status=no,scrollbars=1,width=1000,height=500,top=70px, left=175px';
                window.open('../Reportes/Reporte.aspx', '', options);
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
            var tabla = document.getElementById("tSeguridad");
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
                            <li><a class="dropdown-item" href="Usuarios.aspx">Permisos</a></li>
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

    <form id="frmSeguridad" runat="server">
       <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

        <div class="form-group">
            <div class="container">
                <div class="table-responsive">
                    <center><asp:Label ID="lblTitulo" runat="server" Text="<b>Datos Usuario</b>"></asp:Label></center>
                    <div class="col-md-12 col-sm-12">
                        <div class="form-group col-md-4 col-sm-4">
                            <b>Colaborador</b><br />
                            <asp:Label ID="lblCOLABORADOR" runat="server" Text=""></asp:Label>
                        </div>
                        <div class="form-group col-md-4 col-sm-4">
                            <b>Cargo</b><br />
                            <asp:Label ID="lblCARGO" runat="server" Text=""></asp:Label>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="form-group" style="left: 30px; position: absolute;">
             <div class="container" style="width:1450px">
                 <div class="table-responsive"  style="width:1450px">
                           <center><asp:Label ID="lblTitulo2" runat="server" Text="<b>Autorizacion y Permisos Para Ingresar al Sistema</b>"></asp:Label></center>
                           <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                <ContentTemplate>
                                        <asp:Table ID="tSeguridad" runat="server"
                                                            CssClass="table table-bordered table-hover text-center  table-striped"
                                                            BackColor="White" CellPadding="2" CellSpacing="0"
                                                            Font-Size="8pt" GridLines="Both"
                                                            Style="text-align: left" Font-Names="Arial">

                                                            <asp:TableRow ID="trDetalleTarea" runat="server" Visible="true">
                                                                <asp:TableCell ID="tc_CODIGO_AUTORIZACION" runat="server" BackColor="Black" BorderColor="Black"
                                                                    ForeColor="White" Visible="false" Width="2%">COD. AUTORIZACION</asp:TableCell>

                                                                <asp:TableCell ID="tcCODIGO_FORMULARIO" runat="server" BackColor="Black" BorderColor="Black"
                                                                    ForeColor="White" Visible="false" Width="2%">COD. FORMULARIO</asp:TableCell>

                                                               <asp:TableCell ID="tcAUTORIZACION" runat="server" BackColor="Black" BorderColor="Black"
                                                                    ForeColor="White" Visible="true" Width="2%">AUTORIZACION</asp:TableCell>

                                                               <asp:TableCell ID="tcNOMBRE_FORMULARIO" runat="server" BackColor="Black" BorderColor="Black"
                                                                    ForeColor="White" Visible="true" Width="2%">PAGINA WEB</asp:TableCell>

                                                            </asp:TableRow>
                                        </asp:Table>
                                </ContentTemplate>
                           </asp:UpdatePanel>
                   </div>
                   <div class="form-group col-md-12" style="text-align: center">
                        <asp:LinkButton ID="lbEnviar" runat="server" class="btn btn-primary"
                            onclick="lbEnviar_Click"
                            onclientclick="return Confirmar('Desea guardar los datos de Seguridad?');"
                            Width="100px">Enviar</asp:LinkButton>
                        <asp:LinkButton ID="lbCancelar" runat="server" class="btn btn-danger"
                            CausesValidation="False" Width="100px" onclick="lbCancelar_Click">Cancelar</asp:LinkButton>
                        <asp:LinkButton ID="IMPRIMIR" runat="server" class="btn btn-info"
                            onclick="IMPRIMIR_Click"
                            Width="120px" CausesValidation="False"
                            onclientclick="abrir_ventana_imprimir_reporte(2);" Visible="False">Imprimir reporte</asp:LinkButton>
                   </div>
             </div>
        </div>

        <asp:HiddenField ID="__mensaje" runat="server" />
        <asp:HiddenField ID="__pagina" runat="server" />

    </form>

    <!-- Scripts -->
    <script type="text/javascript" src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script type="text/javascript" src="../Otros_css_js/jquery-3.1.1.slim.min.js"></script>
    <script type="text/javascript" src="../Otros_css_js/restables.js"></script>
    <script type="text/javascript">
        window.addEventListener("load", convertirPrimerTR);

        $(document).ready(function () {
            $('table').resTables();
        });

        function convertirPrimerTR() {
            var tr = document.querySelector("tbody tr");
            var thead = tr.cloneNode(true);
            for (var i = 0; i < thead.children.length; i++) {
                var th = document.createElement("th");
                th.innerHTML = thead.children[i].innerHTML;
                thead.replaceChild(th, thead.children[i]);
            }
            var nuevoThead = document.createElement("thead");
            nuevoThead.appendChild(thead);
            var tabla = document.querySelector("table");
            tabla.insertBefore(nuevoThead, tabla.firstChild);
            tr.remove();
        }
    </script>

</body>
</html>
