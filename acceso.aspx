<%@ Page Language="C#" AutoEventWireup="true" CodeFile="acceso.aspx.cs" Inherits="acceso" UnobtrusiveValidationMode="None" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="es">
<head runat="server">
    <link rel="icon" type="image/ico" href="Imagenes/Sistema__.ico" />
    <title>Acceso al Sistema</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <style>
        :root {
            --page-bg: #f4f1ec;
            --ink: #18202a;
            --muted: #697382;
            --line: #d9dee7;
            --surface: #ffffff;
            --surface-soft: #f8fafc;
            --brand: #bf1725;
            --brand-dark: #87111c;
            --brand-soft: #fff0f1;
            --focus: rgba(191, 23, 37, 0.22);
            --shadow: 0 24px 70px rgba(24, 32, 42, 0.16);
        }

        * {
            box-sizing: border-box;
        }

        html,
        body {
            min-height: 100%;
        }

        body {
            margin: 0;
            color: var(--ink);
            font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
            background: var(--page-bg);
        }

        button,
        input {
            font: inherit;
        }

        .login-page {
            min-height: 100vh;
            display: grid;
            grid-template-columns: minmax(0, 1.1fr) minmax(360px, 480px);
            background:
                linear-gradient(90deg, rgba(15, 22, 32, 0.78), rgba(15, 22, 32, 0.48)),
                url("Imagenes/fondo1.jpg") center / cover no-repeat;
        }

        .institutional-panel {
            min-height: 100vh;
            display: flex;
            align-items: flex-end;
            padding: clamp(32px, 6vw, 78px);
        }

        .institutional-copy {
            width: min(620px, 100%);
            color: #ffffff;
            text-shadow: 0 2px 18px rgba(0, 0, 0, 0.34);
        }

        .system-kicker {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 18px;
            font-size: 12px;
            font-weight: 700;
            letter-spacing: 0.12em;
            text-transform: uppercase;
        }

        .system-kicker::before {
            content: "";
            width: 34px;
            height: 2px;
            background: #ffffff;
            border-radius: 2px;
        }

        .institutional-copy h1 {
            margin: 0;
            max-width: 580px;
            font-size: clamp(34px, 5vw, 58px);
            line-height: 1.02;
            font-weight: 750;
            letter-spacing: 0;
        }

        .institutional-copy p {
            max-width: 520px;
            margin: 18px 0 0;
            color: rgba(255, 255, 255, 0.86);
            font-size: 17px;
            line-height: 1.65;
        }

        .auth-panel {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 32px;
            background: transparent;
        }

        .login-card {
            width: min(100%, 420px);
            background: var(--surface);
            border: 1px solid rgba(24, 32, 42, 0.08);
            border-radius: 8px;
            box-shadow: var(--shadow);
            overflow: hidden;
        }

        .login-card-header {
            padding: 28px 32px 22px;
            border-bottom: 1px solid var(--line);
            background:
                linear-gradient(180deg, #ffffff, #fbfcfd),
                var(--surface);
        }

        .brand-lockup {
            display: flex;
            align-items: center;
            gap: 14px;
            margin-bottom: 24px;
        }

        .brand-mark {
            width: 46px;
            height: 46px;
            display: grid;
            place-items: center;
            border-radius: 8px;
            color: #ffffff;
            background: linear-gradient(145deg, var(--brand), var(--brand-dark));
            box-shadow: 0 10px 24px rgba(191, 23, 37, 0.28);
            font-size: 18px;
            font-weight: 800;
            letter-spacing: 0;
        }

        .brand-name {
            margin: 0;
            font-size: 14px;
            line-height: 1.35;
            font-weight: 750;
            color: var(--ink);
        }

        .brand-subtitle {
            margin: 2px 0 0;
            color: var(--muted);
            font-size: 12px;
            line-height: 1.4;
        }

        .login-card-header h2 {
            margin: 0;
            font-size: 25px;
            line-height: 1.18;
            font-weight: 750;
            letter-spacing: 0;
            color: var(--ink);
        }

        .login-card-header .intro {
            margin: 10px 0 0;
            color: var(--muted);
            font-size: 14px;
            line-height: 1.55;
        }

        .login-card-body {
            padding: 28px 32px 30px;
        }

        .login-alert {
            display: none;
            margin: 0 0 18px;
            padding: 12px 14px;
            border: 1px solid #f0b7bd;
            border-radius: 8px;
            color: #7d1019;
            background: var(--brand-soft);
            font-size: 13px;
            line-height: 1.45;
        }

        .login-alert.is-visible {
            display: block;
        }

        .form-field {
            margin-bottom: 18px;
        }

        .field-label {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 8px;
            color: #293241;
            font-size: 13px;
            font-weight: 700;
        }

        .field-control {
            position: relative;
        }

        .field-control::before {
            content: "";
            position: absolute;
            left: 15px;
            top: 50%;
            width: 9px;
            height: 9px;
            border-radius: 50%;
            background: #aab2bf;
            transform: translateY(-50%);
            pointer-events: none;
        }

        .field-control:focus-within::before {
            background: var(--brand);
        }

        .form-input {
            width: 100%;
            height: 48px;
            padding: 0 15px 0 40px;
            color: var(--ink);
            background: var(--surface-soft);
            border: 1px solid #cfd6e1;
            border-radius: 8px;
            outline: none;
            font-size: 15px;
            transition: border-color 0.18s ease, box-shadow 0.18s ease, background 0.18s ease;
        }

        .form-input::placeholder {
            color: #8d96a3;
        }

        .form-input:hover {
            border-color: #aeb8c7;
            background: #ffffff;
        }

        .form-input:focus {
            border-color: var(--brand);
            background: #ffffff;
            box-shadow: 0 0 0 4px var(--focus);
        }

        .validator-error {
            display: block;
            margin-top: 7px;
            color: #9a1320 !important;
            font-size: 12px;
            font-weight: 650;
            line-height: 1.4;
        }

        .login-actions {
            margin-top: 24px;
        }

        .btn-login {
            width: 100%;
            min-height: 50px;
            padding: 0 20px;
            border: 0;
            border-radius: 8px;
            color: #ffffff;
            background: linear-gradient(135deg, var(--brand), var(--brand-dark));
            box-shadow: 0 14px 28px rgba(191, 23, 37, 0.24);
            cursor: pointer;
            font-size: 14px;
            font-weight: 800;
            letter-spacing: 0.02em;
            transition: transform 0.16s ease, box-shadow 0.16s ease, filter 0.16s ease;
        }

        .btn-login:hover,
        .btn-login:focus {
            filter: brightness(1.04);
            transform: translateY(-1px);
            box-shadow: 0 18px 34px rgba(191, 23, 37, 0.3);
            outline: none;
        }

        .btn-login:focus-visible {
            box-shadow: 0 0 0 4px var(--focus), 0 18px 34px rgba(191, 23, 37, 0.3);
        }

        .btn-login:active {
            transform: translateY(0);
            box-shadow: 0 10px 22px rgba(191, 23, 37, 0.24);
        }

        .secure-note {
            display: flex;
            gap: 10px;
            align-items: flex-start;
            margin: 18px 0 0;
            color: var(--muted);
            font-size: 12px;
            line-height: 1.5;
        }

        .secure-note::before {
            content: "";
            flex: 0 0 auto;
            width: 8px;
            height: 8px;
            margin-top: 5px;
            border-radius: 50%;
            background: #2f9e44;
            box-shadow: 0 0 0 4px rgba(47, 158, 68, 0.12);
        }

        .footer-copy {
            margin-top: 26px;
            color: #7b8492;
            font-size: 12px;
            line-height: 1.45;
            text-align: center;
        }

        @media (max-width: 900px) {
            .login-page {
                grid-template-columns: 1fr;
                background:
                    linear-gradient(180deg, rgba(15, 22, 32, 0.78), rgba(15, 22, 32, 0.5)),
                    url("Imagenes/fondo1.jpg") center top / cover no-repeat;
            }

            .institutional-panel {
                min-height: auto;
                padding: 34px 24px 10px;
                align-items: flex-start;
            }

            .institutional-copy {
                max-width: 680px;
            }

            .institutional-copy h1 {
                font-size: clamp(30px, 8vw, 44px);
            }

            .institutional-copy p {
                font-size: 15px;
            }

            .auth-panel {
                min-height: auto;
                align-items: flex-start;
                padding: 18px 18px 28px;
                background: transparent;
            }
        }

        @media (max-width: 480px) {
            .institutional-panel {
                padding: 28px 18px 8px;
            }

            .system-kicker {
                font-size: 11px;
                margin-bottom: 12px;
            }

            .institutional-copy p {
                display: none;
            }

            .login-card-header,
            .login-card-body {
                padding-left: 22px;
                padding-right: 22px;
            }

            .login-card-header {
                padding-top: 24px;
            }

            .brand-lockup {
                margin-bottom: 18px;
            }
        }

        @media (prefers-reduced-motion: reduce) {
            *,
            *::before,
            *::after {
                transition-duration: 0.01ms !important;
                animation-duration: 0.01ms !important;
                scroll-behavior: auto !important;
            }
        }
    </style>

    <script type="text/javascript">
        function MostrarMensaje() {
            var mensaje = document.getElementById("__mensaje").value;
            var pagina = document.getElementById("__pagina").value;
            var panel = document.getElementById("loginAlert");

            if (mensaje !== "") {
                if (panel) {
                    panel.textContent = mensaje;
                    panel.className = "login-alert is-visible";
                    panel.setAttribute("role", "alert");
                } else {
                    alert(mensaje);
                }

                if (pagina !== "") {
                    location.href = pagina;
                }
            }
        }

            </script>
</head>
<body onload="MostrarMensaje()">
    <main class="login-page">
        <section class="institutional-panel" aria-label="Sistema de gestion de configuracion">
            <div class="institutional-copy">
                <div class="system-kicker">Sistema GCS</div>
                <h1>Gesti&oacute;n de configuraci&oacute;n institucional</h1>
                <p>Acceso seguro para administrar elementos de configuraci&oacute;n, servicios, seguimientos y reportes de la CMDB.</p>
            </div>
        </section>

        <section class="auth-panel" aria-label="Inicio de sesion">
            <div>
                <div class="login-card">
                    <div class="login-card-header">
                        <div class="brand-lockup">
                            <img src="Images/logo.svg" alt="Logo" style="width: 46px; height: 46px; border-radius: 8px;" />
                            <div>
                                <p class="brand-name">Corte Superior de Justicia de Lambayeque</p>
                                <p class="brand-subtitle">Plataforma interna</p>
                            </div>
                        </div>
                        <h2>Acceso al sistema</h2>
                        <p class="intro">Ingrese sus credenciales institucionales para continuar.</p>
                    </div>

                    <div class="login-card-body">
                        <form id="frmAcceso" runat="server">
                            <div id="loginAlert" class="login-alert" aria-live="polite"></div>

                            <div class="form-field">
                                <label class="field-label" for="login">Usuario</label>
                                <div class="field-control">
                                    <asp:TextBox ID="login" runat="server"
                                        placeholder="Ingrese su usuario"
                                        autocomplete="username"
                                        CssClass="form-input"></asp:TextBox>
                                </div>
                                <asp:RequiredFieldValidator ID="rfvlogin" runat="server"
                                    ControlToValidate="login" Display="Dynamic"
                                    ErrorMessage="Ingrese su nombre de usuario"
                                    CssClass="validator-error">
                                </asp:RequiredFieldValidator>
                            </div>

                            <div class="form-field">
                                <label class="field-label" for="password">Contrase&ntilde;a</label>
                                <div class="field-control">
                                    <asp:TextBox ID="password" runat="server"
                                        TextMode="Password"
                                        placeholder="Ingrese su contrase&ntilde;a"
                                        autocomplete="current-password"
                                        CssClass="form-input"></asp:TextBox>
                                </div>
                                <asp:RequiredFieldValidator ID="rfvpassword" runat="server"
                                    ControlToValidate="password" Display="Dynamic"
                                    ErrorMessage="Ingrese su contrase&ntilde;a"
                                    CssClass="validator-error">
                                </asp:RequiredFieldValidator>
                            </div>

                            <div class="login-actions">
                                <asp:Button ID="Aceptar" runat="server"
                                    Text="Ingresar al sistema"
                                    CssClass="btn-login"
                                    OnClick="Aceptar_Click">
                                </asp:Button>
                            </div>

                            <p class="secure-note">Use solamente cuentas autorizadas. La actividad del sistema puede ser auditada.</p>

                            <asp:HiddenField ID="__mensaje" runat="server" />
                            <asp:HiddenField ID="__pagina" runat="server" />
                        </form>
                    </div>
                </div>

                <div class="footer-copy">
                    Corte Superior de Justicia de Lambayeque<br />
                    Todos los derechos reservados. &copy; <%= DateTime.Now.Year %>
                </div>
            </div>
        </section>
    </main>
</body>
</html>
