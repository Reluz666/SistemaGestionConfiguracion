<%@ Page Language="C#" AutoEventWireup="true" CodeFile="acceso.aspx.cs" Inherits="acceso" UnobtrusiveValidationMode="None" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="icon" type="image/ico" href="imagenes/acceso.png" />
    <title>Acceso al Sistema</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <!-- Bootstrap 5.3 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet" />

    <style>
        :root {
            --primary: #d40924;
            --primary-dark: #a80d1c;
            --primary-light: #e84054;
            --dark-bg: #0d0d0d;
            --card-bg: #1a1a1a;
            --text-light: #f0f0f0;
            --text-muted: #9a9a9a;
            --border-color: #2d2d2d;
        }

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: var(--dark-bg);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        /* ===== FONDO ANIMADO ===== */
        .bg-pattern {
            position: fixed;
            inset: 0;
            z-index: 0;
            background:
                radial-gradient(ellipse at 20% 50%, rgba(212, 9, 36, 0.15) 0%, transparent 50%),
                radial-gradient(ellipse at 80% 20%, rgba(212, 9, 36, 0.08) 0%, transparent 40%),
                var(--dark-bg);
            overflow: hidden;
        }

        .bg-pattern::before {
            content: '';
            position: absolute;
            inset: 0;
            background-image:
                linear-gradient(rgba(212, 9, 36, 0.03) 1px, transparent 1px),
                linear-gradient(90deg, rgba(212, 9, 36, 0.03) 1px, transparent 1px);
            background-size: 40px 40px;
        }

        /* ===== LAYOUT PRINCIPAL ===== */
        .login-wrapper {
            position: relative;
            z-index: 1;
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2rem 1rem;
        }

        /* ===== CARD DE LOGIN ===== */
        .login-card {
            background: var(--card-bg);
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.5);
            overflow: hidden;
            width: 100%;
            max-width: 420px;
            border: 1px solid var(--border-color);
            animation: slideUp 0.5s ease;
        }

        @keyframes slideUp {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }

        /* ===== HEADER DEL CARD ===== */
        .login-card-header {
            background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
            padding: 0;
            position: relative;
            overflow: hidden;
        }

        .login-card-header::before {
            content: '';
            position: absolute;
            inset: 0;
            background: linear-gradient(to bottom, transparent 60%, rgba(0,0,0,0.4) 100%);
            z-index: 1;
        }

        .login-card-header img {
            width: 100%;
            height: 180px;
            object-fit: cover;
            display: block;
        }

        .login-logo {
            position: absolute;
            bottom: -35px;
            left: 50%;
            transform: translateX(-50%);
            width: 70px;
            height: 70px;
            background: var(--primary);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            border: 3px solid var(--card-bg);
            z-index: 2;
            box-shadow: 0 4px 15px rgba(0,0,0,0.4);
        }

        .login-logo i {
            font-size: 2rem;
            color: #fff;
        }

        .login-title {
            display: none;
        }

        /* ===== CUERPO DEL CARD ===== */
        .login-card-body {
            padding: 2.5rem 2.5rem 2.5rem;
        }

        /* ===== INPUT GROUP ===== */
        .input-group-modern {
            margin-bottom: 1.5rem;
            position: relative;
        }

        .input-group-modern label {
            display: block;
            color: var(--text-light);
            font-size: 0.85rem;
            font-weight: 500;
            margin-bottom: 0.5rem;
            letter-spacing: 0.3px;
        }

        .input-icon-wrapper {
            position: relative;
        }

        .input-icon-wrapper i {
            position: absolute;
            left: 14px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-muted);
            font-size: 1rem;
            transition: color 0.3s;
        }

        .input-icon-wrapper .form-control {
            padding-left: 44px !important;
            height: 48px;
        }

        .form-control-modern {
            width: 100%;
            background: #111;
            border: 2px solid var(--border-color);
            border-radius: 12px;
            color: var(--text-light);
            font-size: 0.95rem;
            padding: 0.75rem 1rem;
            transition: all 0.3s ease;
        }

        .form-control-modern:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 4px rgba(212, 9, 36, 0.15);
            background: #1e1e1e;
            color: #ffffff;
        }

        .form-control-modern::placeholder {
            color: var(--text-muted);
        }

        .form-control-modern:focus ~ i,
        .input-group-modern:focus-within i {
            color: var(--primary);
        }

        /* ===== BOTON DE INGRESO ===== */
        .btn-ingresar {
            width: 100%;
            height: 50px;
            background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
            border: none;
            border-radius: 12px;
            color: #fff;
            font-size: 1rem;
            font-weight: 600;
            letter-spacing: 0.5px;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            position: relative;
            overflow: hidden;
            margin-top: 0.5rem;
        }

        .btn-ingresar::before {
            content: '';
            position: absolute;
            inset: 0;
            background: linear-gradient(135deg, var(--primary-light) 0%, var(--primary) 100%);
            opacity: 0;
            transition: opacity 0.3s;
        }

        .btn-ingresar:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(212, 9, 36, 0.4);
        }

        .btn-ingresar:hover::before {
            opacity: 1;
        }

        .btn-ingresar span {
            position: relative;
            z-index: 1;
        }

        .btn-ingresar:active {
            transform: translateY(0);
        }

        /* ===== VALIDATORS ===== */
        .validator-error {
            color: #ff4d6a;
            font-size: 0.8rem;
            font-weight: 500;
            margin-top: 0.4rem;
            display: flex;
            align-items: center;
            gap: 0.25rem;
        }

        .validator-error i {
            font-size: 0.75rem;
        }

        /* ===== FOOTER ===== */
        .login-footer {
            text-align: center;
            padding: 1.5rem 1rem;
            position: relative;
            z-index: 1;
        }

        .login-footer p {
            color: var(--text-muted);
            font-size: 0.8rem;
            margin: 0;
        }

        .login-footer .brand {
            color: var(--primary);
            font-weight: 600;
        }

        /* ===== FOOTER FIJO ===== */
        .footer-copy {
            text-align: center;
            padding: 1rem;
            background: rgba(0,0,0,0.3);
            border-top: 1px solid var(--border-color);
            position: relative;
            z-index: 1;
        }

        .footer-copy p {
            color: var(--text-muted);
            font-size: 0.78rem;
            margin: 0;
        }

        /* ===== RESPONSIVE ===== */
        @media (max-width: 480px) {
            .login-card-header {
                padding: 1.5rem 1.5rem 2rem;
            }
            .login-card-body {
                padding: 1.5rem 2rem 2rem;
            }
            .login-title {
                font-size: 0.95rem;
            }
        }

        /* ===== ANIMACIONES DE ENTRADA ===== */
        .input-group-modern {
            animation: fadeInUp 0.5s ease backwards;
        }

        .input-group-modern:nth-child(1) { animation-delay: 0.1s; }
        .input-group-modern:nth-child(2) { animation-delay: 0.2s; }
        .input-group-modern:nth-child(3) { animation-delay: 0.3s; }

        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(15px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>

    <script type="text/javascript">
        function MostrarMensaje() {
            var mensaje = document.getElementById("__mensaje").value;
            if (mensaje != "") {
                alert(mensaje);
                var pagina = document.getElementById("__pagina").value;
                if (pagina !== "") location.href = pagina;
            }
        }

        function SoloLetrasMinusculas(e) {
            if (!(event.keyCode >= 97 && event.keyCode <= 122 || event.keyCode == 32
                || event.keyCode == 193 || event.keyCode == 201 || event.keyCode == 205
                || event.keyCode == 209 || event.keyCode == 211 || event.keyCode == 218
                || event.keyCode == 220)) event.keyCode = 0;
        }

        function CambiaLetraMayuscula(Caja) {
            document.getElementById(Caja).value = document.getElementById(Caja).value.toUpperCase();
        }
    </script>
</head>
<body onload="MostrarMensaje()">

    <!-- Fondo animado -->
    <div class="bg-pattern"></div>

    <div class="login-wrapper">
        <div class="login-card">

            <!-- Header -->
            <div class="login-card-header">
                <img src="imagenes/fondo1.jpg" alt="Corte Superior de Justicia de Lambayeque" />
                <div class="login-logo">
                    <i class="bi bi-shield-lock-fill"></i>
                </div>
            </div>

            <!-- Body -->
            <div class="login-card-body">
                <form id="frmAcceso" runat="server">

                    <div class="input-group-modern">
                        <label for="login">
                            <i class="bi bi-person-fill me-1"></i>Usuario
                        </label>
                        <div class="input-icon-wrapper">
                            <asp:TextBox ID="login" runat="server"
                                placeholder="Ingrese su usuario"
                                autocomplete="off"
                                CssClass="form-control form-control-modern"
                                onchange="CambiaLetraMayuscula('login')"
                                onkeypress="SoloLetrasMinusculas(event)"
                                onkeydown="if(event.keyCode==13) event.keyCode=9;" >DANGELO</asp:TextBox>
                            <i class="bi bi-person"></i>
                        </div>
                        <asp:RequiredFieldValidator ID="rfvlogin" runat="server"
                            ControlToValidate="login" Display="Dynamic"
                            ErrorMessage="Ingrese su nombre de usuario"
                            CssClass="validator-error">
                        </asp:RequiredFieldValidator>
                    </div>

                    <div class="input-group-modern">
                        <label for="password">
                            <i class="bi bi-lock-fill me-1"></i>Contrase&ntilde;a
                        </label>
                        <div class="input-icon-wrapper">
                            <asp:TextBox ID="password" runat="server"
                                TextMode="Password"
                                placeholder="Ingrese su contrase&ntilde;a"
                                autocomplete="off"
                                CssClass="form-control form-control-modern"
                                onchange="CambiaLetraMayuscula('password')"
                                onkeydown="if(event.keyCode==13) event.keyCode=9;">123</asp:TextBox>
                            <i class="bi bi-lock"></i>
                        </div>
                        <asp:RequiredFieldValidator ID="rfvpassword" runat="server"
                            ControlToValidate="password" Display="Dynamic"
                            ErrorMessage="Ingrese su contrase&ntilde;a"
                            CssClass="validator-error">
                        </asp:RequiredFieldValidator>
                    </div>

                    <asp:Button ID="Aceptar" runat="server"
                        Text="INGRESAR AL SISTEMA"
                        CssClass="btn-ingresar"
                        OnClick="Aceptar_Click">
                    </asp:Button>

                    <asp:HiddenField ID="__mensaje" runat="server" />
                    <asp:HiddenField ID="__pagina" runat="server" />
                </form>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <div class="footer-copy">
        <p>
            Corte Superior de Justicia de Lambayeque | Todos los derechos reservados.
            &copy; <%= DateTime.Now.Year %>
        </p>
    </div>

    <!-- Scripts -->
    <script type="text/javascript" src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
