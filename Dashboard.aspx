<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Dashboard.aspx.cs" Inherits="Dashboard" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="icon" type="image/ico" href="../Imagenes/Sistema__.ico" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Dashboard - Sistema de Gestión de Configuración</title>
    <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" />
    <link href="CssJs/Menu.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet" />

    <style>
        body { background: #f4f6f9; font-family: 'Segoe UI', Tahoma, sans-serif; padding-top: 70px; }
        .stat-card { background: white; border-radius: 10px; padding: 20px; box-shadow: 0 2px 8px rgba(0,0,0,0.08); margin-bottom: 20px; transition: transform 0.2s; cursor: pointer; }
        .stat-card:hover { transform: translateY(-3px); box-shadow: 0 4px 12px rgba(0,0,0,0.12); }
        .stat-card .icon { font-size: 2.5em; color: #2c3e50; }
        .stat-card .number { font-size: 2em; font-weight: bold; color: #2c3e50; }
        .stat-card .label { color: #7f8c8d; font-size: 0.9em; text-transform: uppercase; letter-spacing: 0.5px; }
        .stat-card.elementos { border-left: 4px solid #3498db; }
        .stat-card.elementos .icon { color: #3498db; }
        .stat-card.relaciones { border-left: 4px solid #2ecc71; }
        .stat-card.relaciones .icon { color: #2ecc71; }
        .stat-card.licencias { border-left: 4px solid #e74c3c; }
        .stat-card.licencias .icon { color: #e74c3c; }
        .stat-card.seguimientos { border-left: 4px solid #f39c12; }
        .stat-card.seguimientos .icon { color: #f39c12; }
        .stat-card.personal { border-left: 4px solid #9b59b6; }
        .stat-card.personal .icon { color: #9b59b6; }
        .stat-card.componentes { border-left: 4px solid #1abc9c; }
        .stat-card.componentes .icon { color: #1abc9c; }
        .panel-custom { background: white; border-radius: 10px; box-shadow: 0 2px 8px rgba(0,0,0,0.08); margin-bottom: 20px; }
        .panel-custom .panel-heading { background: #2c3e50; color: white; border-radius: 10px 10px 0 0; padding: 15px 20px; font-weight: 600; }
        .panel-custom .panel-body { padding: 20px; }
        .activity-item { padding: 12px 0; border-bottom: 1px solid #ecf0f1; }
        .activity-item:last-child { border-bottom: none; }
        .activity-item .time { color: #95a5a6; font-size: 0.85em; }
        .activity-item .desc { color: #2c3e50; font-weight: 500; }
        .quick-access { display: flex; flex-wrap: wrap; gap: 10px; }
        .quick-btn { background: #3498db; color: white; border: none; border-radius: 8px; padding: 12px 20px; font-weight: 600; text-decoration: none; transition: background 0.2s; display: inline-flex; align-items: center; gap: 8px; }
        .quick-btn:hover { background: #2980b9; color: white; }
        .quick-btn.green { background: #2ecc71; }
        .quick-btn.green:hover { background: #27ae60; }
        .quick-btn.red { background: #e74c3c; }
        .quick-btn.red:hover { background: #c0392b; }
        .quick-btn.orange { background: #f39c12; }
        .quick-btn.orange:hover { background: #d68910; }
        .quick-btn.purple { background: #9b59b6; }
        .quick-btn.purple:hover { background: #8e44ad; }
        .quick-btn.teal { background: #1abc9c; }
        .quick-btn.teal:hover { background: #16a085; }
        .welcome-banner { background: linear-gradient(135deg, #2c3e50 0%, #3498db 100%); color: white; border-radius: 10px; padding: 30px; margin-bottom: 25px; }
        .welcome-banner h2 { margin: 0 0 10px 0; font-weight: 300; }
        .welcome-banner p { margin: 0; opacity: 0.9; }
        .section-title { color: #2c3e50; font-weight: 600; margin-bottom: 15px; font-size: 1.1em; margin-top: 20px; }
        .date-badge { background: #ecf0f1; padding: 3px 8px; border-radius: 4px; font-size: 0.85em; color: #7f8c8d; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <nav class="navbar navbar-custom navbar-fixed-top">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
                <span class="sr-only">Desplegar navegación</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="Menu.aspx"><span class="glyphicon glyphicon-home"></span>&nbsp;Inicio</a>
        </div>
        <div class="collapse navbar-collapse navbar-ex1-collapse">
            <ul class="nav navbar-nav">
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown"><span class="glyphicon glyphicon-briefcase"></span>&nbsp;Mantenimiento <b class="caret"></b></a>
                    <ul class="dropdown-menu">
                        <li><a href="Personal.aspx">Personal</a></li>
                        <li class="dropdown-submenu">
                            <a href="#">Tablas Institucion</a>
                            <ul class="dropdown-menu">
                                <li><a href="Sede.aspx">Sede</a></li>
                                <li><a href="Local.aspx">Local</a></li>
                                <li><a href="Area.aspx">Area</a></li>
                                <li><a href="Dependencia.aspx">Dependencia</a></li>
                            </ul>
                        </li>
                        <li class="dropdown-submenu">
                            <a href="#">Tablas Personal</a>
                            <ul class="dropdown-menu">
                                <li><a href="Cargo.aspx">Cargo</a></li>
                                <li><a href="ProfecionOcupacion.aspx">Profecion - Ocupacion</a></li>
                            </ul>
                        </li>
                        <li class="dropdown-submenu">
                            <a href="#">Tablas Elemento Configuracion</a>
                            <ul class="dropdown-menu">
                                <li><a href="Modelo.aspx">Modelo</a></li>
                                <li><a href="Marca.aspx">Marca</a></li>
                                <li><a href="DescripcionElementoConfiguracion.aspx">Descripci&oacute;n Elemento Configuraci&oacute;n</a></li>
                                <li><a href="TiposElementoConfiguracion.aspx">Tipos Elemento Configuraci&oacute;n</a></li>
                                <li><a href="TipoRelacionElementoConfiguracion.aspx">Tipo Relaci&oacute;n Elemento Configuraci&oacute;n</a></li>
                                <li><a href="TipoComponeneteCI.aspx">Tipo Componenete Elemento Configuraci&oacute;n</a></li>
                                <li><a href="EstadoActualCI.aspx">Estado Actual Elemento Configuraci&oacute;n</a></li>
                            </ul>
                        </li>
                    </ul>
                </li>
            </ul>
            <ul class="nav navbar-nav">
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" style="color: white"><span class="glyphicon glyphicon-user"></span>&nbsp;Gestión de Configuración <b class="caret"></b></a>
                    <ul class="dropdown-menu">
                        <li><a href="ElementosConfiguracion.aspx">Elementos de Configuración</a></li>
                        <li><a href="RelacionesElementosConfiguracion.aspx">Relación de Elementos</a></li>
                        <li><a href="CIsAsignarComponenetes.aspx">Asignar Componentes</a></li>
                        <li><a href="LicenciasElementoConfiguracion.aspx">Licencias</a></li>
                        <li><a href="SeguimientosElementoConfiguracion.aspx">Seguimientos</a></li>
                    </ul>
                </li>
            </ul>
            <ul class="nav navbar-nav">
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown"><span class="glyphicon glyphicon-file"></span>&nbsp;Reportes <b class="caret"></b></a>
                    <ul class="dropdown-menu">
                        <li><a href="../Reportes/ReporteElementosConfiguracion.aspx">Reporte de Elementos</a></li>
                        <li><a href="../Reportes/ReporteRelacionesElementosConfiguracion.aspx">Reporte de Relaciones</a></li>
                        <li><a href="../Reportes/ReporteSeguimientosElementoConfiguracion.aspx">Reporte de Seguimientos</a></li>
                        <li><a href="../Reportes/ReporteLicenciasElementoConfiguracion.aspx">Reporte de Licencias</a></li>
                        <li><a href="../Reportes/ReporteCIsSeguidos.aspx">Reporte de Elementos Seguidos</a></li>
                        <li><a href="../Reportes/ReporteComponentesAsignados.aspx">Reporte de Componentes Asignados</a></li>
                        <li class="divider"></li>
                        <li><a href="../Reportes/ReporteDatosCorrectosCI.aspx">Reporte de Datos Correctos</a></li>
                        <li><a href="../Reportes/ReporteDatosIncorrectosCI.aspx">Reporte de Datos Incorrectos</a></li>
                        <li><a href="../Reportes/ReporteCIsInformacionContenidaEnCMDB.aspx">Reporte de Información en CMDB</a></li>
                        <li><a href="../Reportes/Reporte_De_CIS_Relativo_A_Servicios.aspx">Reporte CIS Relativo a Servicios</a></li>
                        <li><a href="../Reportes/Reporte_CIS_Relacionados_Con_Otros_CIS.aspx">Reporte CIS Relacionados</a></li>
                    </ul>
                </li>
            </ul>
            <ul class="nav navbar-nav">
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" style="color: black"><span class="glyphicon glyphicon-wrench"></span>&nbsp;Configuraciones <b class="caret"></b></a>
                    <ul class="dropdown-menu">
                        <li><a href="Usuario.aspx">Usuarios</a></li>
                        <li><a href="../Configuracion/Usuarios.aspx">Permisos</a></li>
                        <li><a href="CerrarSession.aspx" style="color: red;">Cerrar Sesion</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </nav>

    <div class="container">
        <!-- Welcome Banner -->
        <div class="welcome-banner">
            <h2><i class="bi bi-speedometer2"></i> Bienvenido al Sistema de Gestión de Configuración</h2>
            <p>Panel de control y métricas generales del sistema</p>
            <span class="date-badge"><i class="bi bi-calendar3"></i> <asp:Label ID="lblFecha" runat="server"></asp:Label></span>
        </div>

        <!-- Stats Row 1 -->
        <div class="row">
            <div class="col-md-4">
                <div class="stat-card elementos" onclick="window.location.href='ElementosConfiguracion.aspx'">
                    <div class="row">
                        <div class="col-xs-3"><span class="icon"><i class="bi bi-box-seam"></i></span></div>
                        <div class="col-xs-9 text-right">
                            <div class="number"><asp:Label ID="lblTotalEC" runat="server" Text="0"></asp:Label></div>
                            <div class="label">Elementos de Configuración</div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="stat-card relaciones" onclick="window.location.href='RelacionesElementosConfiguracion.aspx'">
                    <div class="row">
                        <div class="col-xs-3"><span class="icon"><i class="bi bi-diagram-3"></i></span></div>
                        <div class="col-xs-9 text-right">
                            <div class="number"><asp:Label ID="lblTotalRelaciones" runat="server" Text="0"></asp:Label></div>
                            <div class="label">Relaciones de Elementos</div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="stat-card licencias" onclick="window.location.href='LicenciasElementoConfiguracion.aspx'">
                    <div class="row">
                        <div class="col-xs-3"><span class="icon"><i class="bi bi-file-earmark-lock"></i></span></div>
                        <div class="col-xs-9 text-right">
                            <div class="number"><asp:Label ID="lblTotalLicencias" runat="server" Text="0"></asp:Label></div>
                            <div class="label">Licencias Activas</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Stats Row 2 -->
        <div class="row">
            <div class="col-md-4">
                <div class="stat-card seguimientos" onclick="window.location.href='SeguimientosElementoConfiguracion.aspx'">
                    <div class="row">
                        <div class="col-xs-3"><span class="icon"><i class="bi bi-clipboard-check"></i></span></div>
                        <div class="col-xs-9 text-right">
                            <div class="number"><asp:Label ID="lblTotalSeguimientos" runat="server" Text="0"></asp:Label></div>
                            <div class="label">Seguimientos Registrados</div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="stat-card personal" onclick="window.location.href='Personal.aspx'">
                    <div class="row">
                        <div class="col-xs-3"><span class="icon"><i class="bi bi-people"></i></span></div>
                        <div class="col-xs-9 text-right">
                            <div class="number"><asp:Label ID="lblTotalPersonal" runat="server" Text="0"></asp:Label></div>
                            <div class="label">Personal Registrado</div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="stat-card componentes" onclick="window.location.href='CIsComponentesAsignados.aspx'">
                    <div class="row">
                        <div class="col-xs-3"><span class="icon"><i class="bi bi-cpu"></i></span></div>
                        <div class="col-xs-9 text-right">
                            <div class="number"><asp:Label ID="lblTotalComponentes" runat="server" Text="0"></asp:Label></div>
                            <div class="label">Componentes Asignados</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Activity and Quick Access -->
        <div class="row">
            <!-- Recent Activity -->
            <div class="col-md-6">
                <div class="panel-custom">
                    <div class="panel-heading"><i class="bi bi-clock-history"></i> Últimos Elementos de Configuración</div>
                    <div class="panel-body">
                        <asp:GridView ID="gvUltimosEC" runat="server" AutoGenerateColumns="false" GridLines="None" ShowHeader="false" BorderWidth="0">
                            <Columns>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <div class="activity-item">
                                            <div class="time"><%# Eval("FECHA_REGISTRO", "{0:dd/MM/yyyy HH:mm}") %></div>
                                            <div class="desc"><%# Eval("NOMBRE_ELEMENTO_CONFIGURACION") %></div>
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </div>

            <!-- Recent Seguimientos -->
            <div class="col-md-6">
                <div class="panel-custom">
                    <div class="panel-heading"><i class="bi bi-clipboard-plus"></i> Últimos Seguimientos</div>
                    <div class="panel-body">
                        <asp:GridView ID="gvUltimosSeguimientos" runat="server" AutoGenerateColumns="false" GridLines="None" ShowHeader="false" BorderWidth="0">
                            <Columns>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <div class="activity-item">
                                            <div class="time"><%# Eval("FECHA_SEGUIMIENTO", "{0:dd/MM/yyyy HH:mm}") %></div>
                                            <div class="desc"><%# Eval("NOMBRE_EC") %></div>
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </div>
        </div>

        <!-- Quick Access -->
        <div class="row">
            <div class="col-md-12">
                <div class="panel-custom">
                    <div class="panel-heading"><i class="bi bi-lightning"></i> Acceso Rápido</div>
                    <div class="panel-body">
                        <p class="section-title" style="margin-top: 0;">Operaciones Principales</p>
                        <div class="quick-access">
                            <a href="ElementosConfiguracion.aspx" class="quick-btn"><i class="bi bi-plus-circle"></i> Nuevo Elemento</a>
                            <a href="RelacionesElementosConfiguracion.aspx" class="quick-btn green"><i class="bi bi-diagram-3"></i> Nueva Relación</a>
                            <a href="CIsAsignarComponenetes.aspx" class="quick-btn teal"><i class="bi bi-cpu"></i> Asignar Componente</a>
                            <a href="SeguimientosElementoConfiguracion.aspx" class="quick-btn orange"><i class="bi bi-clipboard-plus"></i> Nuevo Seguimiento</a>
                            <a href="LicenciasElementoConfiguracion.aspx" class="quick-btn red"><i class="bi bi-file-earmark-plus"></i> Nueva Licencia</a>
                        </div>
                        <p class="section-title">Gestión de Maestros</p>
                        <div class="quick-access">
                            <a href="Personal.aspx" class="quick-btn purple"><i class="bi bi-person-plus"></i> Personal</a>
                            <a href="Usuario.aspx" class="quick-btn"><i class="bi bi-person-gear"></i> Usuarios</a>
                            <a href="Marca.aspx" class="quick-btn green"><i class="bi bi-building"></i> Marcas</a>
                            <a href="Modelo.aspx" class="quick-btn"><i class="bi bi-collection"></i> Modelos</a>
                        </div>
                        <p class="section-title">Reportes</p>
                        <div class="quick-access">
                            <a href="../Reportes/ReporteElementosConfiguracion.aspx" class="quick-btn"><i class="bi bi-file-earmark-bar-graph"></i> Reporte Elementos</a>
                            <a href="../Reportes/ReporteSeguimientosElementoConfiguracion.aspx" class="quick-btn orange"><i class="bi bi-file-earmark-text"></i> Reporte Seguimientos</a>
                            <a href="../Reportes/ReporteDatosIncorrectosCI.aspx" class="quick-btn red"><i class="bi bi-exclamation-triangle"></i> Datos Incorrectos</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="bootstrap/js/jquery-1.12.4.min.js"></script>
    <script src="bootstrap/js/bootstrap.min.js"></script>
    </form>
</body>
</html>