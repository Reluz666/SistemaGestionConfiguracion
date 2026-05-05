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
        .hero-section {
            background: linear-gradient(135deg, #1a1a2e 0%, #16213e 100%);
            color: white;
            padding: 4rem 2rem;
            border-radius: 16px;
            margin-bottom: 2rem;
            text-align: center;
        }
        .hero-section h1 {
            font-weight: 300;
            font-size: 2.5rem;
            margin-bottom: 1rem;
        }
        .hero-section p {
            opacity: 0.9;
            font-size: 1.1rem;
        }
        .feature-card {
            background: white;
            border-radius: 12px;
            padding: 1.5rem;
            box-shadow: 0 4px 15px rgba(0,0,0,0.08);
            transition: transform 0.2s, box-shadow 0.2s;
            height: 100%;
            border: none;
        }
        .feature-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.12);
        }
        .feature-card .icon {
            width: 60px;
            height: 60px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.8rem;
            margin-bottom: 1rem;
        }
        .feature-card h5 {
            font-weight: 600;
            color: #2d3436;
            margin-bottom: 0.5rem;
        }
        .feature-card p {
            color: #7f8c8d;
            font-size: 0.9rem;
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
            <h4 class="mb-3"><i class="bi bi-lightning me-2"></i>Acceso Rapido</h4>
            <div class="row g-4 mb-5">
                <div class="col-md-3 col-sm-6">
                    <a href="ElementosConfiguracion.aspx" class="text-decoration-none">
                        <div class="feature-card">
                            <div class="icon" style="background: rgba(52, 152, 219, 0.15); color: #3498db;">
                                <i class="bi bi-box-seam"></i>
                            </div>
                            <h5>Elementos de Configuracion</h5>
                            <p>Gestionar CI del sistema</p>
                        </div>
                    </a>
                </div>
                <div class="col-md-3 col-sm-6">
                    <a href="RelacionesElementosConfiguracion.aspx" class="text-decoration-none">
                        <div class="feature-card">
                            <div class="icon" style="background: rgba(46, 204, 113, 0.15); color: #2ecc71;">
                                <i class="bi bi-diagram-3"></i>
                            </div>
                            <h5>Relaciones</h5>
                            <p>Vincular elementos entre si</p>
                        </div>
                    </a>
                </div>
                <div class="col-md-3 col-sm-6">
                    <a href="LicenciasElementoConfiguracion.aspx" class="text-decoration-none">
                        <div class="feature-card">
                            <div class="icon" style="background: rgba(231, 76, 60, 0.15); color: #e74c3c;">
                                <i class="bi bi-file-earmark-lock"></i>
                            </div>
                            <h5>Licencias</h5>
                            <p>Control de licencias</p>
                        </div>
                    </a>
                </div>
                <div class="col-md-3 col-sm-6">
                    <a href="SeguimientosElementoConfiguracion.aspx" class="text-decoration-none">
                        <div class="feature-card">
                            <div class="icon" style="background: rgba(243, 156, 18, 0.15); color: #f39c12;">
                                <i class="bi bi-clipboard-check"></i>
                            </div>
                            <h5>Seguimientos</h5>
                            <p>Historial de cambios</p>
                        </div>
                    </a>
                </div>
            </div>

            <h4 class="mb-3"><i class="bi bi-briefcase me-2"></i>Mantenimiento</h4>
            <div class="row g-4 mb-5">
                <div class="col-md-3 col-sm-6">
                    <a href="Personal.aspx" class="text-decoration-none">
                        <div class="feature-card">
                            <div class="icon" style="background: rgba(155, 89, 182, 0.15); color: #9b59b6;">
                                <i class="bi bi-people"></i>
                            </div>
                            <h5>Personal</h5>
                            <p>Gestionar trabajadores</p>
                        </div>
                    </a>
                </div>
                <div class="col-md-3 col-sm-6">
                    <a href="Usuario.aspx" class="text-decoration-none">
                        <div class="feature-card">
                            <div class="icon" style="background: rgba(233, 69, 96, 0.15); color: #e94560;">
                                <i class="bi bi-person-gear"></i>
                            </div>
                            <h5>Usuarios</h5>
                            <p>Administracion de usuarios</p>
                        </div>
                    </a>
                </div>
                <div class="col-md-3 col-sm-6">
                    <a href="Sede.aspx" class="text-decoration-none">
                        <div class="feature-card">
                            <div class="icon" style="background: rgba(26, 188, 156, 0.15); color: #1abc9c;">
                                <i class="bi bi-building"></i>
                            </div>
                            <h5>Sedes</h5>
                            <p>Organizacion territorial</p>
                        </div>
                    </a>
                </div>
                <div class="col-md-3 col-sm-6">
                    <a href="Area.aspx" class="text-decoration-none">
                        <div class="feature-card">
                            <div class="icon" style="background: rgba(52, 73, 94, 0.15); color: #34495e;">
                                <i class="bi bi-grid"></i>
                            </div>
                            <h5>Areas</h5>
                            <p>Departamentos y areas</p>
                        </div>
                    </a>
                </div>
            </div>

            <h4 class="mb-3"><i class="bi bi-file-earmark-bar-graph me-2"></i>Reportes</h4>
            <div class="row g-4">
                <div class="col-md-4 col-sm-6">
                    <a href="../Reportes/ReporteElementosConfiguracion.aspx" class="text-decoration-none">
                        <div class="feature-card">
                            <div class="icon" style="background: rgba(52, 152, 219, 0.15); color: #3498db;">
                                <i class="bi bi-file-earmark-bar-graph"></i>
                            </div>
                            <h5>Reporte de Elementos</h5>
                            <p>Resumen general de CIs</p>
                        </div>
                    </a>
                </div>
                <div class="col-md-4 col-sm-6">
                    <a href="../Reportes/ReporteSeguimientosElementoConfiguracion.aspx" class="text-decoration-none">
                        <div class="feature-card">
                            <div class="icon" style="background: rgba(243, 156, 18, 0.15); color: #f39c12;">
                                <i class="bi bi-file-earmark-text"></i>
                            </div>
                            <h5>Reporte de Seguimientos</h5>
                            <p>Historial de modificaciones</p>
                        </div>
                    </a>
                </div>
                <div class="col-md-4 col-sm-6">
                    <a href="../Reportes/ReporteLicenciasElementoConfiguracion.aspx" class="text-decoration-none">
                        <div class="feature-card">
                            <div class="icon" style="background: rgba(231, 76, 60, 0.15); color: #e74c3c;">
                                <i class="bi bi-file-earmark-lock"></i>
                            </div>
                            <h5>Reporte de Licencias</h5>
                            <p>Estado de licencias</p>
                        </div>
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