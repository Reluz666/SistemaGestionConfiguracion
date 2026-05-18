<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ComponenteCI.aspx.cs" Inherits="TiposElementoConfiguracion" UnobtrusiveValidationMode="None" %>
<%@ Register src="NavBar.ascx" tagname="NavBar" tagprefix="uc1" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>Componente CI</title>

    <!-- Bootstrap 5.3 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet" />
    <!-- Global Styles -->
    <link href="CssJs/global-styles.css" rel="stylesheet" />

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

        /* ===== TABLA ===== */
        .table-wrapper {
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 4px 25px rgba(0,0,0,0.08);
            padding: 1.5rem;
            border: 1px solid rgba(0,0,0,0.05);
        }

        .table-modern thead th {
            background: linear-gradient(135deg, #1a1a2e 0%, #16213e 100%);
            color: #fff;
            font-weight: 600;
            font-size: 0.8rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            padding: 0.75rem 0.5rem !important;
            border: none !important;
            white-space: nowrap;
        }

        .table-modern tbody td {
            padding: 0.6rem 0.5rem !important;
            border-bottom: 1px solid #f1f1f1;
            vertical-align: middle;
            font-size: 0.85rem;
            color: #2d3436;
        }

        .table-modern tbody tr:hover td {
            background: rgba(233,69,96,0.04);
        }

        .table-modern tbody tr:last-child td {
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

        .info-badge {
            background: #f8f9fa;
            border-radius: 10px;
            padding: 1rem;
            margin-bottom: 1.5rem;
            border-left: 4px solid #e94560;
        }

        .info-badge strong {
            color: #e94560;
        }

        /* ===== RESPONSIVE ===== */
        @media (max-width: 991px) {
            .form-card { padding: 1.5rem; }
            .table-wrapper { padding: 1rem; }
        }

        @media (max-width: 576px) {
            .btn-modern { width: 100%; margin-bottom: 0.5rem; }
        }
    </style>

    <script type="text/javascript" src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <script lang="javascript" type="text/javascript">
        function MostrarMensaje() {
            var mensaje = document.getElementById("__mensaje").value;
            if (mensaje != "") {
                alert(mensaje);
                if (document.getElementById("__pagina").value != "")
                    location.href = document.getElementById("__pagina").value;
            }
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
    </script>
</head>
<body onload="MostrarMensaje()">

    <uc1:NavBar ID="NavBar1" runat="server" />

    <form id="form1" runat="server">
        <asp:HiddenField ID="__mensaje" runat="server" />
        <asp:HiddenField ID="__pagina" runat="server" />

        <div class="container mt-4">
            <!-- ===== INFO CI ===== -->
            <div class="info-badge">
                <div class="row">
                    <div class="col-md-6">
                        <p class="mb-1"><i class="bi bi-cpu me-2"></i><strong>Nombre CI:</strong> <asp:Label ID="lblNombreCI" runat="server" CssClass="text-dark"></asp:Label></p>
                        <p class="mb-1"><i class="bi bi-tag me-2"></i><strong>Tipo CI:</strong> <asp:Label ID="lblTipoCI" runat="server" CssClass="text-dark"></asp:Label></p>
                        <p class="mb-1"><i class="bi bi-upc me-2"></i><strong>Nro. Serie:</strong> <asp:Label ID="lblNroSerie" runat="server" CssClass="text-dark"></asp:Label></p>
                    </div>
                    <div class="col-md-6">
                        <p class="mb-1"><i class="bi bi-box me-2"></i><strong>Marca/Modelo:</strong> <asp:Label ID="lblMarcaModelo" runat="server" CssClass="text-dark"></asp:Label></p>
                        <p class="mb-1"><i class="bi bi-geo-alt me-2"></i><strong>Sede/Local:</strong> <asp:Label ID="lblSedeLocal" runat="server" CssClass="text-dark"></asp:Label></p>
                        <p class="mb-1"><i class="bi bi-building me-2"></i><strong>Area:</strong> <asp:Label ID="lblArea" runat="server" CssClass="text-dark"></asp:Label></p>
                    </div>
                </div>
            </div>

            <!-- ===== TABLA DE COMPONENTES ===== -->
            <div class="table-wrapper">
                <div class="form-card">
                    <div class="card-header">
                        <i class="bi bi-box-seam me-2"></i>Componentes del Elemento de Configuracion
                    </div>
                    <div class="card-body p-0">
                        <div class="table-responsive">
                            <asp:Table ID="Table_" runat="server" CssClass="table table-modern table-hover" style="margin-bottom:0;">
                                <asp:TableRow ID="TableRow1" runat="server">
                                    <asp:TableCell ID="tcID" runat="server" BackColor="Black" ForeColor="White" Width="7%" Visible="false">ID</asp:TableCell>
                                    <asp:TableCell ID="tcNOMBRE" runat="server" BackColor="Black" ForeColor="White" Width="15%">NOMBRE</asp:TableCell>
                                    <asp:TableCell ID="tcDESCRIPCION" runat="server" BackColor="Black" ForeColor="White" Width="30%">DESCRIPCION</asp:TableCell>
                                    <asp:TableCell ID="tcFABRICANTE" runat="server" BackColor="Black" ForeColor="White" Width="20%">FABRICANTE</asp:TableCell>
                                    <asp:TableCell ID="tcNRO_SERIE" runat="server" BackColor="Black" ForeColor="White" Width="18%">NRO SERIE</asp:TableCell>
                                    <asp:TableCell ID="tcMARCA" runat="server" BackColor="Black" ForeColor="White" Width="10%">MARCA</asp:TableCell>
                                    <asp:TableCell ID="tcMODELO" runat="server" BackColor="Black" ForeColor="White" Width="15%">MODELO</asp:TableCell>
                                </asp:TableRow>
                            </asp:Table>
                        </div>
                    </div>
                </div>
            </div>

            <!-- ===== BOTONES ===== -->
            <div class="form-card">
                <div class="card-body text-center">
                    <asp:Button ID="btnEnviar" runat="server" OnClick="Button1_Click" Text="Enviar" CssClass="btn btn-success btn-modern me-2" Style="min-width:120px;" />
                    <a href="CIsComponentesAsignados.aspx" class="btn btn-secondary btn-modern">Cancelar</a>
                </div>
            </div>
        </div>
    </form>

    <script type="text/javascript" src="Otros_css_js/resaltar.js"></script>

</body>
</html>
