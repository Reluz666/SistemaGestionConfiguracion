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
            --slate-950: #0f172a;
            --slate-900: #1e293b;
            --slate-700: #334155;
            --slate-500: #64748b;
            --slate-200: #e2e8f0;
            --slate-100: #f1f5f9;
            --slate-50: #f8fafc;
            --accent: #2563eb;
            --accent-light: #dbeafe;
        }

        body {
            background: var(--slate-100);
            font-family: system-ui, -apple-system, sans-serif;
        }

        .hero-section {
            background: var(--slate-950);
            color: white;
            padding: 3rem 2rem;
            margin-bottom: 2.5rem;
        }

        .hero-section h1 {
            font-weight: 600;
            font-size: 1.75rem;
            letter-spacing: -0.02em;
            margin: 0;
        }

        .hero-section p {
            color: var(--slate-500);
            font-size: 1rem;
            margin: 0.5rem 0 0 0;
        }

        .section-header {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            margin-bottom: 1.25rem;
            padding-bottom: 0.75rem;
            border-bottom: 1px solid var(--slate-200);
        }

        .section-header h2 {
            font-size: 0.8rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            color: var(--slate-700);
            margin: 0;
        }

        .nav-card {
            background: white;
            border-radius: 8px;
            padding: 1.25rem;
            box-shadow: 0 1px 3px rgba(0,0,0,0.08);
            transition: box-shadow 0.2s ease-out, transform 0.2s ease-out;
            text-decoration: none;
            display: block;
            color: inherit;
        }

        .nav-card:hover {
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            transform: translateY(-2px);
        }

        .nav-card .card-icon {
            width: 36px;
            height: 36px;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.1rem;
            margin-bottom: 0.75rem;
        }

        .nav-card h5 {
            font-size: 0.95rem;
            font-weight: 600;
            color: var(--slate-900);
            margin-bottom: 0.25rem;
        }

        .nav-card p {
            font-size: 0.8rem;
            color: var(--slate-500);
            margin: 0;
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
    </script>
</head>
<body onload="MostrarMensaje()">
    <!-- Toast Container -->
    <div class="toast-container" id="toastContainer"></div>

    <form id="form1" runat="server">
        <div class="top-spacer" style="height: 80px;"></div>
        <div class="container">
            <!-- Hero Section -->
            <div class="hero-section">
                <h1><i class="bi bi-gear-fill me-3"></i>Bienvenido al Sistema de Gestion de Configuracion</h1>
                <p>Administra elementos de configuracion, licencias, seguimientos y mas</p>
            </div>

            <!-- Quick Access Cards -->
            <div class="section-header">
                <h2>Acceso Rapido</h2>
            </div>
            <div class="row g-3 mb-5">
                <div class="col-6 col-md-3">
                    <a href="ElementosConfiguracion.aspx" class="nav-card">
                        <div class="card-icon" style="background: var(--accent-light); color: var(--accent);">
                            <i class="bi bi-box-seam"></i>
                        </div>
                        <h5>Elementos de Configuracion</h5>
                        <p>Gestionar CI del sistema</p>
                    </a>
                </div>
                <div class="col-6 col-md-3">
                    <a href="RelacionesElementosConfiguracion.aspx" class="nav-card">
                        <div class="card-icon" style="background: #dcfce7; color: #16a34a;">
                            <i class="bi bi-diagram-3"></i>
                        </div>
                        <h5>Relaciones</h5>
                        <p>Vincular elementos entre si</p>
                    </a>
                </div>
                <div class="col-6 col-md-3">
                    <a href="LicenciasElementoConfiguracion.aspx" class="nav-card">
                        <div class="card-icon" style="background: #fee2e2; color: #dc2626;">
                            <i class="bi bi-file-earmark-lock"></i>
                        </div>
                        <h5>Licencias</h5>
                        <p>Control de licencias</p>
                    </a>
                </div>
                <div class="col-6 col-md-3">
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
                <h2>Mantenimiento</h2>
            </div>
            <div class="row g-3 mb-5">
                <div class="col-6 col-md-3">
                    <a href="Personal.aspx" class="nav-card">
                        <div class="card-icon" style="background: #f3e8ff; color: #9333ea;">
                            <i class="bi bi-people"></i>
                        </div>
                        <h5>Personal</h5>
                        <p>Gestionar trabajadores</p>
                    </a>
                </div>
                <div class="col-6 col-md-3">
                    <a href="Usuario.aspx" class="nav-card">
                        <div class="card-icon" style="background: #fce7f3; color: #be185d;">
                            <i class="bi bi-person-gear"></i>
                        </div>
                        <h5>Usuarios</h5>
                        <p>Administracion de usuarios</p>
                    </a>
                </div>
                <div class="col-6 col-md-3">
                    <a href="Sede.aspx" class="nav-card">
                        <div class="card-icon" style="background: #ccfbf1; color: #0d9488;">
                            <i class="bi bi-building"></i>
                        </div>
                        <h5>Sedes</h5>
                        <p>Organizacion territorial</p>
                    </a>
                </div>
                <div class="col-6 col-md-3">
                    <a href="Area.aspx" class="nav-card">
                        <div class="card-icon" style="background: var(--slate-200); color: var(--slate-700);">
                            <i class="bi bi-grid"></i>
                        </div>
                        <h5>Areas</h5>
                        <p>Departamentos y areas</p>
                    </a>
                </div>
            </div>

            <div class="section-header">
                <h2>Reportes</h2>
            </div>
            <div class="row g-3">
                <div class="col-6 col-md-4">
                    <a href="../Reportes/ReporteElementosConfiguracion.aspx" class="nav-card">
                        <div class="card-icon" style="background: var(--accent-light); color: var(--accent);">
                            <i class="bi bi-file-earmark-bar-graph"></i>
                        </div>
                        <h5>Reporte de Elementos</h5>
                        <p>Resumen general de CIs</p>
                    </a>
                </div>
                <div class="col-6 col-md-4">
                    <a href="../Reportes/ReporteSeguimientosElementoConfiguracion.aspx" class="nav-card">
                        <div class="card-icon" style="background: #fef3c7; color: #d97706;">
                            <i class="bi bi-file-earmark-text"></i>
                        </div>
                        <h5>Reporte de Seguimientos</h5>
                        <p>Historial de modificaciones</p>
                    </a>
                </div>
                <div class="col-6 col-md-4">
                    <a href="../Reportes/ReporteLicenciasElementoConfiguracion.aspx" class="nav-card">
                        <div class="card-icon" style="background: #fee2e2; color: #dc2626;">
                            <i class="bi bi-file-earmark-lock"></i>
                        </div>
                        <h5>Reporte de Licencias</h5>
                        <p>Estado de licencias</p>
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