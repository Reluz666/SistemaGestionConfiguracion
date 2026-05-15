<%@ Control Language="C#" AutoEventWireup="true" CodeFile="NavBar.ascx.cs" Inherits="NavBar" %>

<!-- ========== NAVBAR MODERNO ========== -->
<nav class="navbar navbar-expand-lg navbar-modern fixed-top">
    <div class="container-fluid">
        <a class="navbar-brand" href="../Menu.aspx">
            <img src="../Images/logo.svg" alt="Logo" style="height: 28px; width: 28px; margin-right: 6px;" />
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
                        <li><a class="dropdown-item" href="../Personal.aspx">Personal</a></li>
                        <li class="dropdown-submenu">
                            <a class="dropdown-item dropdown-toggle" href="#">Tablas Instituci&oacute;n</a>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="../Sede.aspx">Sede</a></li>
                                <li><a class="dropdown-item" href="../Local.aspx">Local</a></li>
                                <li><a class="dropdown-item" href="../Area.aspx">&Aacute;rea</a></li>
                                <li><a class="dropdown-item" href="../Dependencia.aspx">Dependencia</a></li>
                            </ul>
                        </li>
                        <li class="dropdown-submenu">
                            <a class="dropdown-item dropdown-toggle" href="#">Tablas Personal</a>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="../Cargo.aspx">Cargo</a></li>
                                <li><a class="dropdown-item" href="../ProfecionOcupacion.aspx">Profesi&oacute;n - Ocupaci&oacute;n</a></li>
                            </ul>
                        </li>
                        <li><hr class="dropdown-divider" /></li>
                        <li class="dropdown-submenu">
                            <a class="dropdown-item dropdown-toggle" href="#">Tablas Elemento Configuraci&oacute;n</a>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="../Modelo.aspx">Modelo</a></li>
                                <li><a class="dropdown-item" href="../Marca.aspx">Marca</a></li>
                                <li><a class="dropdown-item" href="../DescripcionElementoConfiguracion.aspx">Descripci&oacute;n Elemento Configuraci&oacute;n</a></li>
                                <li><a class="dropdown-item" href="../TiposElementoConfiguracion.aspx">Tipos Elemento Configuraci&oacute;n</a></li>
                                <li><a class="dropdown-item" href="../TipoRelacionElementoConfiguracion.aspx">Tipo Relaci&oacute;n Elemento Configuraci&oacute;n</a></li>
                                <li><a class="dropdown-item" href="../TipoComponeneteCI.aspx">Tipo Componente Elemento Configuraci&oacute;n</a></li>
                                <li><a class="dropdown-item" href="../EstadoActualCI.aspx">Estado Actual Elemento Configuraci&oacute;n</a></li>
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
                        <li><a class="dropdown-item" href="../ElementosConfiguracion.aspx">Elementos de Configuraci&oacute;n</a></li>
                        <li><a class="dropdown-item" href="../RelacionesElementosConfiguracion.aspx">Relaci&oacute;n de Elementos de Configuraci&oacute;n</a></li>
                        <li><hr class="dropdown-divider" /></li>
                        <li><a class="dropdown-item" href="../CIsAsignarComponenetes.aspx">Asignar Componentes Elementos de Configuraci&oacute;n</a></li>
                        <li><hr class="dropdown-divider" /></li>
                        <li><a class="dropdown-item" href="../LicenciasElementoConfiguracion.aspx">Licencias de Elementos de Configuraci&oacute;n</a></li>
                        <li><hr class="dropdown-divider" /></li>
                        <li><a class="dropdown-item" href="../SeguimientosElementoConfiguracion.aspx">Seguimiento de Elementos de Configuraci&oacute;n</a></li>
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
                        <li><a class="dropdown-item" href="../Reportes/Reporte_CIS_Relacionados_Con_Otros_CIS.aspx">Reporte de CIS Relacionados con Otros CIS</a></li>
                        <li><a class="dropdown-item" href="../Reportes/Reporte_De_CIS_Relativo_A_Servicios.aspx">Reporte de CIS Relativo a Servicios</a></li>
                        <li><a class="dropdown-item" href="../Reportes/ReporteCIsInformacionContenidaEnCMDB.aspx">Reporte de Informaci&oacute;n de Elementos de Configuraci&oacute;n contenidos en la CMDB</a></li>
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
                        <li><a class="dropdown-item" href="CerrarSession.aspx" style="color: #e94560;">Cerrar Sesi&oacute;n</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- Espaciador para navbar fija -->
<div class="top-spacer"></div>
