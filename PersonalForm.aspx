<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PersonalForm.aspx.cs" Inherits="PersonalForm" UnobtrusiveValidationMode="None" %>
<%@ Register src="NavBar.ascx" tagname="NavBar" tagprefix="uc1" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>Personal - Formulario</title>

    <!-- Bootstrap 5.3 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet" />
    <!-- Global Styles -->
    <link href="CssJs/global-styles.css" rel="stylesheet" />

    <style>
        .form-card {
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 4px 25px rgba(0,0,0,0.08);
            margin-top: 1rem;
            overflow: hidden;
        }
        .card-header {
            background: linear-gradient(135deg, #1a1a2e 0%, #16213e 100%);
            color: #fff;
            padding: 1rem 1.5rem;
            font-weight: 600;
        }
        .form-label-modern {
            font-size: 0.85rem;
            font-weight: 600;
            color: #2d3436;
            margin-bottom: 0.3rem;
        }
        .form-control-modern {
            border-radius: 8px;
            border: 2px solid #e9ecef;
            padding: 0.5rem 0.75rem;
            font-size: 0.9rem;
            transition: all 0.3s ease;
        }
        .form-control-modern:focus {
            border-color: #e94560;
            box-shadow: 0 0 0 4px rgba(233,69,96,0.1);
        }
        .btn-modern {
            padding: 0.6rem 1.5rem;
            border-radius: 10px;
            font-weight: 600;
            font-size: 0.95rem;
            transition: all 0.3s ease;
            border: none;
        }
        .btn-success { background: #198754; color: #fff; }
        .btn-warning { background: #ffc107; color: #000; }
        .btn-danger { background: #dc3545; color: #fff; }
        .btn-secondary { background: #6c757d; color: #fff; }
        .btn-modern:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(0,0,0,0.2);
        }
        .validator-error {
            color: #dc3545;
            font-size: 0.8rem;
            margin-top: 0.25rem;
        }
    </style>

    <script type="text/javascript" src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <script lang="javascript" type="text/javascript">
        function MostrarMensaje() {
            var mensaje = document.getElementById("__mensaje").value;
            if (mensaje != "") {
                alert(mensaje);
                if (document.getElementById("__pagina").value != "") {
                    setTimeout(function() { location.href = document.getElementById("__pagina").value; }, 2000);
                }
            }
        }

        function Confirmar(men) {
            return confirm(men);
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
        <div class="container">
            <!-- Breadcrumb -->
            <nav aria-label="breadcrumb" class="breadcrumb-nav">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="Menu.aspx"><i class="bi bi-house-door"></i> Inicio</a></li>
                    <li class="breadcrumb-item"><a href="Personal.aspx">Personal</a></li>
                    <li class="breadcrumb-item active" aria-current="page" id="breadcrumbTitle">Nuevo Personal</li>
                </ol>
            </nav>

            <!-- Card Formulario -->
            <div class="form-card">
                <div class="card-header">
                    <i class="bi bi-person-plus-fill me-2"></i><span id="formTitle">Ingrese Datos del Personal</span>
                </div>
                <div class="card-body p-3">

                    <!-- Fila 1: C&oacute;digo, Nombre, Apellido Pat., Apellido Mat. -->
                    <div class="row g-2 mb-2">
                        <div class="col-md-3 col-sm-6">
                            <label class="form-label-modern">C&oacute;digo</label>
                            <asp:TextBox ID="Codigo" runat="server" CssClass="form-control form-control-modern"
                                         MaxLength="5" Autocomplete="off" placeholder="Ingrese c&oacute;digo"
                                         onkeypress="SoloNumeros()" />
                            <asp:RequiredFieldValidator ID="rfvCodigo" runat="server" ControlToValidate="Codigo"
                                                       ErrorMessage="*" CssClass="validator-error" />
                            <asp:RegularExpressionValidator ID="revCodigo" runat="server" ControlToValidate="Codigo"
                                                             ErrorMessage="C&oacute;digo debe tener 5 d&iacute;gitos"
                                                             CssClass="validator-error"
                                                             ValidationExpression="\d{5}" />
                        </div>
                        <div class="col-md-3 col-sm-6">
                            <label class="form-label-modern">Nombre</label>
                            <asp:TextBox ID="Nombre" runat="server" CssClass="form-control form-control-modern"
                                         MaxLength="25" Autocomplete="off" placeholder="Ingrese nombre" />
                            <asp:RequiredFieldValidator ID="rfvNombre" runat="server" ControlToValidate="Nombre"
                                                       ErrorMessage="*" CssClass="validator-error" />
                        </div>
                        <div class="col-md-3 col-sm-6">
                            <label class="form-label-modern">Apellido Paterno</label>
                            <asp:TextBox ID="ApellidoPat" runat="server" CssClass="form-control form-control-modern"
                                         MaxLength="25" Autocomplete="off" placeholder="Apellido paterno" />
                            <asp:RequiredFieldValidator ID="rfvApellidoPat" runat="server" ControlToValidate="ApellidoPat"
                                                       ErrorMessage="*" CssClass="validator-error" />
                        </div>
                        <div class="col-md-3 col-sm-6">
                            <label class="form-label-modern">Apellido Materno</label>
                            <asp:TextBox ID="ApellidoMat" runat="server" CssClass="form-control form-control-modern"
                                         MaxLength="25" Autocomplete="off" placeholder="Apellido materno" />
                            <asp:RequiredFieldValidator ID="rfvApellidoMat" runat="server" ControlToValidate="ApellidoMat"
                                                       ErrorMessage="*" CssClass="validator-error" />
                        </div>
                    </div>

                    <!-- Fila 2: Tipo Doc., Nro Doc., Profesi&oacute;n, Tel&eacute;fono -->
                    <div class="row g-2 mb-2">
                        <div class="col-md-3 col-sm-6">
                            <label class="form-label-modern">Tipo Doc. Ident.</label>
                            <asp:DropDownList ID="TipoDocIdent" runat="server" CssClass="form-control form-control-modern"
                                             AppendDataBoundItems="True">
                                <asp:ListItem Value="-1">Seleccione una opción</asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="rfvTipoDocIdent" runat="server" ControlToValidate="TipoDocIdent"
                                                       ErrorMessage="*" CssClass="validator-error" />
                        </div>
                        <div class="col-md-3 col-sm-6">
                            <label class="form-label-modern">Nro. Doc. Ident.</label>
                            <asp:TextBox ID="NroDocIdent" runat="server" CssClass="form-control form-control-modern"
                                         MaxLength="25" Autocomplete="off" placeholder="N&uacute;mero de documento"
                                         onkeypress="SoloNumeros()" />
                            <asp:RequiredFieldValidator ID="rfvNroDocIdent" runat="server" ControlToValidate="NroDocIdent"
                                                       ErrorMessage="*" CssClass="validator-error" />
                        </div>
                        <div class="col-md-3 col-sm-6">
                            <label class="form-label-modern">Profesi&oacute;n</label>
                            <asp:DropDownList ID="Profesion" runat="server" CssClass="form-control form-control-modern"
                                             AppendDataBoundItems="True">
                                <asp:ListItem Value="-1">Seleccione una opción</asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="rfvProfesion" runat="server" ControlToValidate="Profesion"
                                                       ErrorMessage="*" CssClass="validator-error" />
                        </div>
                        <div class="col-md-3 col-sm-6">
                            <label class="form-label-modern">Tel&eacute;fono</label>
                            <asp:TextBox ID="Telefono" runat="server" CssClass="form-control form-control-modern"
                                         MaxLength="9" Autocomplete="off" placeholder="N&uacute;mero telef&oacute;nico"
                                         onkeypress="SoloNumeros()" />
                            <asp:RequiredFieldValidator ID="rfvTelefono" runat="server" ControlToValidate="Telefono"
                                                       ErrorMessage="*" CssClass="validator-error" />
                        </div>
                    </div>

                    <!-- Fila 3: Email, Sede, Local, &Aacute;rea -->
                    <div class="row g-2 mb-2">
                        <div class="col-md-3 col-sm-6">
                            <label class="form-label-modern">Email</label>
                            <asp:TextBox ID="Email" runat="server" CssClass="form-control form-control-modern"
                                         MaxLength="100" placeholder="email@ejemplo.com" />
                            <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="Email"
                                                       ErrorMessage="*" CssClass="validator-error" />
                        </div>
                        <div class="col-md-3 col-sm-6">
                            <label class="form-label-modern">Sede</label>
                            <asp:DropDownList ID="Sede" runat="server" CssClass="form-control form-control-modern"
                                             AppendDataBoundItems="True" AutoPostBack="True"
                                             OnSelectedIndexChanged="Sede_SelectedIndexChanged">
                                <asp:ListItem Value="-1">Seleccione una opción</asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="rfvSede" runat="server" ControlToValidate="Sede"
                                                       ErrorMessage="*" CssClass="validator-error" />
                        </div>
                        <div class="col-md-3 col-sm-6">
                            <label class="form-label-modern">Local</label>
                            <asp:DropDownList ID="ddlLocal" runat="server" CssClass="form-control form-control-modern"
                                             AppendDataBoundItems="True" AutoPostBack="True"
                                             OnSelectedIndexChanged="ddlLocal_SelectedIndexChanged">
                                <asp:ListItem Value="-1">Seleccione una opción</asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="rfvLocal" runat="server" ControlToValidate="ddlLocal"
                                                       ErrorMessage="*" CssClass="validator-error" InitialValue="-1" />
                        </div>
                        <div class="col-md-3 col-sm-6">
                            <label class="form-label-modern">&Aacute;rea</label>
                            <asp:DropDownList ID="ddlArea" runat="server" CssClass="form-control form-control-modern"
                                             AppendDataBoundItems="True">
                                <asp:ListItem Value="-1">Seleccione una opción</asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="rfvArea" runat="server" ControlToValidate="ddlArea"
                                                       ErrorMessage="*" CssClass="validator-error" InitialValue="-1" />
                        </div>
                    </div>

                    <!-- Fila 4: Dependencia, Cargo, Estado -->
                    <div class="row g-3 mb-4">
                        <div class="col-md-4 col-sm-6">
                            <label class="form-label-modern">Dependencia</label>
                            <asp:DropDownList ID="Dependencia" runat="server" CssClass="form-control form-control-modern"
                                             AppendDataBoundItems="True">
                                <asp:ListItem Value="-1">Seleccione una opción</asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="rfvDependencia" runat="server" ControlToValidate="Dependencia"
                                                       ErrorMessage="*" CssClass="validator-error" />
                        </div>
                        <div class="col-md-4 col-sm-6">
                            <label class="form-label-modern">Cargo</label>
                            <asp:DropDownList ID="Cargo" runat="server" CssClass="form-control form-control-modern"
                                             AppendDataBoundItems="True">
                                <asp:ListItem Value="-1">Seleccione una opción</asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="rfvCargo" runat="server" ControlToValidate="Cargo"
                                                       ErrorMessage="*" CssClass="validator-error" />
                        </div>
                        <div class="col-md-4 col-sm-6 d-flex align-items-end">
                            <div class="form-check">
                                <asp:CheckBox ID="Estado" runat="server" CssClass="form-check-input" />
                                <label class="form-check-label ms-2 form-label-modern" for="Estado">Activo</label>
                            </div>
                        </div>
                    </div>

                    <!-- Botones de acci&oacute;n -->
                    <div class="d-flex flex-wrap gap-2 justify-content-center">
                        <asp:Button ID="btnRegistrar" runat="server" Text="Registrar" CssClass="btn btn-success btn-modern"
                                    OnClick="btnRegistrar_Click"
                                    OnClientClick="return Confirmar('¿Desea registrar Personal?');" />
                        <asp:Button ID="btnModificar" runat="server" Text="Modificar" CssClass="btn btn-warning btn-modern"
                                    OnClick="btnModificar_Click"
                                    OnClientClick="return Confirmar('¿Desea modificar Personal?');" />
                        <asp:Button ID="btnEliminar" runat="server" Text="Eliminar" CssClass="btn btn-danger btn-modern"
                                    OnClick="btnEliminar_Click"
                                    OnClientClick="return Confirmar('¿Desea eliminar Personal?');" />
                        <asp:Button ID="btnCancelar" runat="server" Text="Cancelar" CssClass="btn btn-secondary btn-modern"
                                    OnClick="btnCancelar_Click" CausesValidation="False" />
                    </div>
                </div>
            </div>
        </div>

        <!-- Hidden Fields -->
        <asp:HiddenField ID="__mensaje" runat="server" />
        <asp:HiddenField ID="__pagina" runat="server" />
        <asp:HiddenField ID="ID_PERSONAL" runat="server" Value="0" EnableViewState="False" />
        <asp:HiddenField ID="Operacion" runat="server" Value="N" />
    </form>

    <!-- Scripts -->
    <script type="text/javascript" src="Otros_css_js/resaltar.js"></script>

    <script type="text/javascript">
        window.addEventListener('load', function() {
            var operacion = document.getElementById('Operacion');
            if (operacion) {
                if (operacion.value === 'E') {
                    document.getElementById('formTitle').textContent = 'Editar Datos del Personal';
                    document.getElementById('breadcrumbTitle').textContent = 'Editar Personal';
                    document.getElementById('btnRegistrar').style.display = 'none';
                    document.getElementById('btnModificar').style.display = '';
                    document.getElementById('btnEliminar').style.display = '';
                } else {
                    document.getElementById('formTitle').textContent = 'Ingrese Datos del Personal';
                    document.getElementById('breadcrumbTitle').textContent = 'Nuevo Personal';
                    document.getElementById('btnRegistrar').style.display = '';
                    document.getElementById('btnModificar').style.display = 'none';
                    document.getElementById('btnEliminar').style.display = 'none';
                }
            }
        });
    </script>
</body>
</html>