<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Menu.aspx.cs" Inherits="_Default" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="icon" type="image/ico" href="../Imagenes/Sistema__.ico" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Configuraciones</title>
    <!-- Bootstrap 5.3 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet" />
    <!-- Global Styles -->
    <link href="CssJs/global-styles.css" rel="stylesheet" />

    <style>
        :root {
            --nav-bg: #1a1a2e;
            --nav-bg-end: #16213e;
            --accent: #e94560;
            --accent-light: rgba(233, 69, 96, 0.1);
            --accent-hover: rgba(233, 69, 96, 0.15);
            --slate-900: #1e293b;
            --slate-700: #334155;
            --slate-500: #64748b;
            --slate-200: #e2e8f0;
            --slate-100: #f8fafc;
        }

        body {
            background: var(--slate-100);
            font-family: system-ui, -apple-system, sans-serif;
            min-height: 100vh;
        }

        /* ===== HERO SECTION ===== */
        .hero-section {
            background: linear-gradient(135deg, var(--nav-bg) 0%, var(--nav-bg-end) 100%);
            color: white;
            padding: 2.5rem 2rem;
            margin-bottom: 2rem;
            border-radius: 0 0 24px 24px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.15);
            position: relative;
            overflow: hidden;
        }

        .hero-section::before {
            content: '';
            position: absolute;
            top: -50%;
            right: -10%;
            width: 400px;
            height: 400px;
            background: var(--accent);
            opacity: 0.05;
            border-radius: 50%;
            pointer-events: none;
        }

        .hero-section .user-badge {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            background: rgba(255, 255, 255, 0.1);
            padding: 0.4rem 0.8rem;
            border-radius: 50px;
            font-size: 0.8rem;
            margin-bottom: 1rem;
            backdrop-filter: blur(10px);
        }

        .hero-section .user-badge i {
            color: var(--accent);
        }

        .hero-section h1 {
            font-weight: 600;
            font-size: 1.6rem;
            letter-spacing: -0.01em;
            margin: 0 0 0.5rem 0;
        }

        .hero-section p {
            color: rgba(255, 255, 255, 0.7);
            font-size: 0.95rem;
            margin: 0;
        }

        .hero-section .date-display {
            color: rgba(255, 255, 255, 0.5);
            font-size: 0.8rem;
            margin-top: 0.75rem;
        }

        /* ===== STATS ROW ===== */
        .stats-row {
            display: flex;
            gap: 1rem;
            margin-bottom: 2rem;
            flex-wrap: wrap;
        }

        .stat-card {
            background: white;
            border-radius: 12px;
            padding: 1rem 1.25rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.06);
            flex: 1;
            min-width: 140px;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }

        .stat-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }

        .stat-card .stat-icon {
            width: 40px;
            height: 40px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.1rem;
        }

        .stat-card .stat-info {
            display: flex;
            flex-direction: column;
        }

        .stat-card .stat-value {
            font-size: 1.25rem;
            font-weight: 700;
            color: var(--slate-900);
            line-height: 1.2;
        }

        .stat-card .stat-label {
            font-size: 0.7rem;
            color: var(--slate-500);
            text-transform: uppercase;
            letter-spacing: 0.03em;
        }

        /* ===== SECTION HEADER ===== */
        .section-header {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            margin-bottom: 1rem;
            padding-bottom: 0.75rem;
            border-bottom: 2px solid var(--slate-200);
        }

        .section-header i {
            color: var(--accent);
            font-size: 1rem;
        }

        .section-header h2 {
            font-size: 0.75rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.08em;
            color: var(--slate-700);
            margin: 0;
        }

        /* ===== NAV CARDS ===== */
        .nav-card {
            background: white;
            border-radius: 12px;
            padding: 1.25rem;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.04);
            transition: all 0.25s ease;
            text-decoration: none;
            display: block;
            color: inherit;
            border: 1px solid transparent;
            position: relative;
            overflow: hidden;
        }

        .nav-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 3px;
            background: var(--accent);
            transform: scaleX(0);
            transform-origin: left;
            transition: transform 0.25s ease;
        }

        .nav-card:hover {
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.1);
            transform: translateY(-3px);
            border-color: var(--accent-light);
        }

        .nav-card:hover::before {
            transform: scaleX(1);
        }

        .nav-card .card-icon {
            width: 42px;
            height: 42px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.2rem;
            margin-bottom: 0.85rem;
            transition: transform 0.25s ease;
        }

        .nav-card:hover .card-icon {
            transform: scale(1.05);
        }

        .nav-card h5 {
            font-size: 0.9rem;
            font-weight: 600;
            color: var(--slate-900);
            margin-bottom: 0.25rem;
        }

        .nav-card p {
            font-size: 0.75rem;
            color: var(--slate-500);
            margin: 0;
            line-height: 1.4;
        }

        /* ===== TOAST STYLES ===== */
        .toast-container {
            position: fixed;
            top: 100px;
            right: 20px;
            z-index: 9999;
        }
    </style>

    <script type="text/javascript">
        function MostrarMensaje() {
            var mensaje = document.getElementById("__mensaje").value;
            if (mensaje != "") {
                mostrarToast(mensaje, 'info');
                if (document.getElementById("__pagina").value != "")
                    location.href = document.getElementById("__pagina").value;
            }
        }

        function mostrarToast(mensaje, tipo) {
            var container = document.getElementById('toastContainer');
            var toastId = 'toast_' + Date.now();
            var iconClass = 'bi-info-circle';
            var bgClass = 'bg-primary';

            switch(tipo) {
                case 'success': iconClass = 'bi-check-circle'; bgClass = 'bg-success'; break;
                case 'error': iconClass = 'bi-x-circle'; bgClass = 'bg-danger'; break;
                case 'warning': iconClass = 'bi-exclamation-triangle'; bgClass = 'bg-warning'; break;
            }

            var toastHtml = '<div id="' + toastId + '" class="toast" role="alert" aria-live="assertive" aria-atomic="true" data-bs-autohide="true" data-bs-delay="5000">' +
                '<div class="toast-header ' + bgClass + ' text-white">' +
                '<i class="bi ' + iconClass + ' me-2"></i>' +
                '<strong class="me-auto">Sistema</strong>' +
                '<button type="button" class="btn-close btn-close-white" data-bs-dismiss="toast" aria-label="Cerrar"></button>' +
                '</div>' +
                '<div class="toast-body">' + mensaje + '</div>' +
                '</div>';
            container.insertAdjacentHTML('beforeend', toastHtml);
            var toastElement = document.getElementById(toastId);
            var toast = new bootstrap.Toast(toastElement);
            toast.show();
            toastElement.addEventListener('hidden.bs.toast', function() { toastElement.remove(); });
        }

        function Confirmar(men) {
            return confirm(men);
        }

        function formatDate() {
            var options = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' };
            return new Date().toLocaleDateString('es-ES', options);
        }

        window.addEventListener('load', function() {
            var dateEl = document.getElementById('currentDate');
            if (dateEl) dateEl.textContent = formatDate();
        });
    </script>
</head>
<body onload="MostrarMensaje()">
    <!-- Toast Container -->
    <div class="toast-container" id="toastContainer"></div>

    <form id="form1" runat="server">
        <div class="top-spacer"></div>
        <div class="container">
            <!-- Hero Section -->
            <div class="hero-section">
                <div class="user-badge">
                    <i class="bi bi-person-fill"></i>
                    <asp:Label ID="lblUsuario" runat="server" Text="Bienvenido"></asp:Label>
                </div>
                <h1><i class="bi bi-gear-fill me-2" style="color: var(--accent);"></i>Sistema de Gestión de Configuración</h1>
                <p>Administra elementos de configuración, licencias, seguimientos y más</p>
                <div class="date-display" id="currentDate"></div>
            </div>

            <!-- Stats Row -->
            <div class="stats-row">
                <div class="stat-card stat-pulse">
                    <div class="stat-icon" style="background: var(--accent-light); color: var(--accent);">
                        <i class="bi bi-box-seam"></i>
                    </div>
                    <div class="stat-info">
                        <span class="stat-value" id="statElementos" runat="server" ClientIDMode="Static">--</span>
                        <span class="stat-label">Elementos CI</span>
                    </div>
                    <div class="stat-indicator active"></div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon" style="background: #dcfce7; color: #16a34a;">
                        <i class="bi bi-diagram-3"></i>
                    </div>
                    <div class="stat-info">
                        <span class="stat-value" id="statRelaciones" runat="server" ClientIDMode="Static">--</span>
                        <span class="stat-label">Relaciones</span>
                    </div>
                    <div class="stat-indicator" style="background: #16a34a;"></div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon" style="background: #fee2e2; color: #dc2626;">
                        <i class="bi bi-file-earmark-lock"></i>
                    </div>
                    <div class="stat-info">
                        <span class="stat-value" id="statLicencias" runat="server" ClientIDMode="Static">--</span>
                        <span class="stat-label">Licencias</span>
                    </div>
                    <div class="stat-indicator" style="background: #dc2626;"></div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon" style="background: #fef3c7; color: #d97706;">
                        <i class="bi bi-people"></i>
                    </div>
                    <div class="stat-info">
                        <span class="stat-value" id="statPersonal" runat="server" ClientIDMode="Static">--</span>
                        <span class="stat-label">Personal</span>
                    </div>
                    <div class="stat-indicator" style="background: #d97706;"></div>
                </div>
            </div>

            <!-- Quick Access Cards -->
            <div class="section-header">
                <i class="bi bi-lightning-charge-fill"></i>
                <h2>Acceso Rápido</h2>
            </div>
            <div class="row g-3 mb-4">
                <div class="col-6 col-lg-3">
                    <a href="ElementosConfiguracion.aspx" class="nav-card">
                        <div class="card-icon" style="background: var(--accent-light); color: var(--accent);">
                            <i class="bi bi-box-seam"></i>
                        </div>
                        <h5>Elementos de Configuración</h5>
                        <p>Gestionar CI del sistema</p>
                    </a>
                </div>
                <div class="col-6 col-lg-3">
                    <a href="RelacionesElementosConfiguracion.aspx" class="nav-card">
                        <div class="card-icon" style="background: #dcfce7; color: #16a34a;">
                            <i class="bi bi-diagram-3"></i>
                        </div>
                        <h5>Relaciones</h5>
                        <p>Vincular elementos entre sí</p>
                    </a>
                </div>
                <div class="col-6 col-lg-3">
                    <a href="LicenciasElementoConfiguracion.aspx" class="nav-card">
                        <div class="card-icon" style="background: #fee2e2; color: #dc2626;">
                            <i class="bi bi-file-earmark-lock"></i>
                        </div>
                        <h5>Licencias</h5>
                        <p>Control de licencias</p>
                    </a>
                </div>
                <div class="col-6 col-lg-3">
                    <a href="SeguimientosElementoConfiguracion.aspx" class="nav-card">
                        <div class="card-icon" style="background: #fef3c7; color: #d97706;">
                            <i class="bi bi-clipboard-check"></i>
                        </div>
                        <h5>Seguimientos</h5>
                        <p>Historial de cambios</p>
                    </a>
                </div>
            </div>

            <div class="section-header">
                <i class="bi bi-briefcase-fill"></i>
                <h2>Mantenimiento</h2>
            </div>
            <div class="row g-3 mb-4">
                <div class="col-6 col-lg-3">
                    <a href="Personal.aspx" class="nav-card">
                        <div class="card-icon" style="background: #f3e8ff; color: #9333ea;">
                            <i class="bi bi-people"></i>
                        </div>
                        <h5>Personal</h5>
                        <p>Gestionar trabajadores</p>
                    </a>
                </div>
                <div class="col-6 col-lg-3">
                    <a href="Usuario.aspx" class="nav-card">
                        <div class="card-icon" style="background: #fce7f3; color: #be185d;">
                            <i class="bi bi-person-gear"></i>
                        </div>
                        <h5>Usuarios</h5>
                        <p>Administración de usuarios</p>
                    </a>
                </div>
                <div class="col-6 col-lg-3">
                    <a href="Sede.aspx" class="nav-card">
                        <div class="card-icon" style="background: #ccfbf1; color: #0d9488;">
                            <i class="bi bi-building"></i>
                        </div>
                        <h5>Sedes</h5>
                        <p>Organización territorial</p>
                    </a>
                </div>
                <div class="col-6 col-lg-3">
                    <a href="Area.aspx" class="nav-card">
                        <div class="card-icon" style="background: var(--slate-200); color: var(--slate-700);">
                            <i class="bi bi-grid"></i>
                        </div>
                        <h5>Áreas</h5>
                        <p>Departamentos y áreas</p>
                    </a>
                </div>
            </div>

            <div class="section-header">
                <i class="bi bi-file-earmark-bar-graph-fill"></i>
                <h2>Reportes</h2>
            </div>
            <div class="row g-3">
                <div class="col-6 col-lg-4">
                    <a href="../Reportes/ReporteElementosConfiguracion.aspx" class="nav-card">
                        <div class="card-icon" style="background: var(--accent-light); color: var(--accent);">
                            <i class="bi bi-file-earmark-bar-graph"></i>
                        </div>
                        <h5>Reporte de Elementos</h5>
                        <p>Resumen general de CIs</p>
                    </a>
                </div>
                <div class="col-6 col-lg-4">
                    <a href="../Reportes/ReporteSeguimientosElementoConfiguracion.aspx" class="nav-card">
                        <div class="card-icon" style="background: #fef3c7; color: #d97706;">
                            <i class="bi bi-file-earmark-text"></i>
                        </div>
                        <h5>Reporte de Seguimientos</h5>
                        <p>Historial de modificaciones</p>
                    </a>
                </div>
                <div class="col-6 col-lg-4">
                    <a href="../Reportes/ReporteLicenciasElementoConfiguracion.aspx" class="nav-card">
                        <div class="card-icon" style="background: #fee2e2; color: #dc2626;">
                            <i class="bi bi-file-earmark-lock"></i>
                        </div>
                        <h5>Reporte de Licencias</h5>
                        <p>Estado de licencias</p>
                    </a>
                </div>
                <div class="col-6 col-lg-4">
                    <a href="../Reportes/Reporte_De_CIS_Relativo_A_Servicios.aspx" class="nav-card">
                        <div class="card-icon" style="background: #dbeafe; color: #2563eb;">
                            <i class="bi bi-diagram-3"></i>
                        </div>
                        <h5>Reporte de CIS Relativo a Servicios</h5>
                        <p>CIS relacionados con servicios</p>
                    </a>
                </div>
                <div class="col-6 col-lg-4">
                    <a href="../Reportes/Reporte_CIS_Relacionados_Con_Otros_CIS.aspx" class="nav-card">
                        <div class="card-icon" style="background: #dcfce7; color: #16a34a;">
                            <i class="bi bi-link-45deg"></i>
                        </div>
                        <h5>Reporte de CIS Relacionados con Otros CIS</h5>
                        <p>Relaciones entre elementos</p>
                    </a>
                </div>
            </div>
        </div>

        <asp:HiddenField ID="__mensaje" runat="server" />
        <asp:HiddenField ID="__pagina" runat="server" />
    </form>

    <script type="text/javascript" src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>