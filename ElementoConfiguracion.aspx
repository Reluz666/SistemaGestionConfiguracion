<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ElementoConfiguracion.aspx.cs" Inherits="ElementoConfiguracion" UnobtrusiveValidationMode="None" %>
<%@ Register src="NavBar.ascx" tagname="NavBar" tagprefix="uc1" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <title>Elemento de Configuración</title>

    <!-- Bootstrap 5.3 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet" />
    <!-- Global Styles -->
    <link href="CssJs/global-styles.css" rel="stylesheet" />

    <style>
        .auto-style1 { background-color: #f8f9fa; }
    </style>

    <script lang="javascript" type="text/javascript">
        function abrir_ventana_busca_Tipos_ElementoConfiguracion() {
            window.document.getElementById("ID_TIPO_ELEMENTO_CONFIGURACION").value = 0;
            window.document.getElementById("TIPO_ELEMENTO_CONFIGURACION").value = "";
            window.document.getElementById("NRO_SERIE").value = "";
            window.document.getElementById("IP").value = "";
            var options = 'channelmode=1,directories=0,fullscreen=0,location=0,menubar=0,resizable=0,titlebar=0,toolbar=0,edge=Raised,status=no,scrollbars=1,width=1000,height=550,top=50px, left=175px';
            window.open('Ventanas/ventanaTiposElementoConfiguracion.aspx', '', options);
        }

        function abrir_ventana_busca_Personal() {
            window.document.getElementById("ID_PROPIETARIO").value = 0;
            window.document.getElementById("PROPIETARIO").value = "";
            var options = 'channelmode=1,directories=0,fullscreen=0,location=0,menubar=0,resizable=0,titlebar=0,toolbar=0,edge=Raised,status=no,scrollbars=1,width=1000,height=550,top=50px, left=175px';
            window.open('Ventanas/ventanaPropietarioElementoConfiguracion.aspx', '', options);
        }

        function abrir_ventana_busca_Localizacion_Fisica() {
            window.document.getElementById("ID_LOCALIZACION_FISICA").value = 0;
            window.document.getElementById("LOCALIZACION_FISICA").value = "";
            var options = 'channelmode=1,directories=0,fullscreen=0,location=0,menubar=0,resizable=0,titlebar=0,toolbar=0,edge=Raised,status=no,scrollbars=1,width=1000,height=550,top=50px, left=175px';
            window.open('Ventanas/ventanaLocalizacionFisica.aspx', '', options);
        }

        function MostrarMensaje() {
            var mensaje = document.getElementById("__mensaje").value;
            if (mensaje != "") {
                mostrarToast(mensaje, 'info');
                if (document.getElementById("__pagina").value != "") {
                    setTimeout(function() { location.href = document.getElementById("__pagina").value; }, 2000);
                }
            }
            document.getElementById('<%= PROPIETARIO.ClientID %>').readOnly = true;
            document.getElementById('<%= LOCALIZACION_FISICA.ClientID %>').readOnly = true;
            document.getElementById('<%= FECHA_REGISTRO.ClientID %>').readOnly = true;
            document.getElementById('<%= RESPONSABLE_REGISTRO.ClientID %>').readOnly = true;
        }

        function Confirmar(men) {
            return confirm(men);
        }

        function SoloNumeros() {
            if ((event.keyCode < 48) || (event.keyCode > 57)) {
                event.returnValue = false;
            }
        }

        function SoloNumeros_() {
            if (!((event.keyCode >= 48 && event.keyCode <= 57) || event.keyCode == 46)) {
                event.returnValue = false;
            }
        }

        function SoloLetrasMinusculas() {
            if (!((event.keyCode >= 97 && event.keyCode <= 122) || event.keyCode == 32 || event.keyCode == 193 || event.keyCode == 201 || event.keyCode == 205 || event.keyCode == 209 || event.keyCode == 211 || event.keyCode == 218 || event.keyCode == 220 || event.keyCode == 241)) {
                event.returnValue = false;
            }
        }

        function CambiaLetraMayuscula(Caja) {
            document.getElementById(Caja).value = document.getElementById(Caja).value.toUpperCase();
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

            var toastHtml = `
                <div id="${toastId}" class="toast" role="alert" aria-live="assertive" aria-atomic="true" data-bs-autohide="true" data-bs-delay="5000">
                    <div class="toast-header ${bgClass} text-white">
                        <i class="bi ${iconClass} me-2"></i>
                        <strong class="me-auto">Sistema</strong>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="toast" aria-label="Cerrar"></button>
                    </div>
                    <div class="toast-body">${mensaje}</div>
                </div>
            `;
            container.insertAdjacentHTML('beforeend', toastHtml);
            var toastElement = document.getElementById(toastId);
            var toast = new bootstrap.Toast(toastElement);
            toast.show();
            toastElement.addEventListener('hidden.bs.toast', function() { toastElement.remove(); });
        }
    </script>

    <script type="text/javascript" src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body onload="MostrarMensaje()">

    <!-- Toast Container -->
    <div class="toast-container" id="toastContainer"></div>

    <uc1:NavBar ID="NavBar1" runat="server" />

    <!-- Espaciador -->
    <div class="top-spacer"></div>

    <!-- Contenido Principal -->
    <form id="form1" runat="server">
        <div class="container">
            <!-- Breadcrumb -->
            <nav aria-label="breadcrumb" class="breadcrumb-nav">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="Menu.aspx"><i class="bi bi-house-door"></i> Inicio</a></li>
                    <li class="breadcrumb-item"><a href="ElementosConfiguracion.aspx">Elementos de Configuración</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Nuevo Elemento</li>
                </ol>
            </nav>

            <!-- Card Formulario -->
            <div class="form-card">
                <div class="card-header">
                    <i class="bi bi-plus-circle-fill me-2"></i>Ingrese Datos Elemento Configuración
                </div>
                <div class="card-body p-3">
                    <div class="row g-3">
                        <!-- Tipo -->
                        <div class="col-md-6 col-sm-6">
                            <label class="form-label-modern">Tipo</label>
                            <asp:DropDownList ID="TIPOCI" runat="server" CssClass="form-control form-control-modern"
                                        AppendDataBoundItems="True" AutoPostBack="True" OnSelectedIndexChanged="TIPOCI_SelectedIndexChanged">
                                <asp:ListItem Value="-1">Seleccione una opción</asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="rfvTipoCI" runat="server" ControlToValidate="TIPOCI" ErrorMessage="Seleccione un tipo" CssClass="validator-error"></asp:RequiredFieldValidator>
                        </div>

                        <!-- Sub Tipo -->
                        <div class="col-md-6 col-sm-6">
                            <label class="form-label-modern">Sub Tipo</label>
                            <asp:DropDownList ID="DESCRIPCION_ELEMENTO_CONFIGURACION" runat="server" CssClass="form-control form-control-modern" AppendDataBoundItems="True">
                                <asp:ListItem Value="-1">Seleccione una opción</asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="rfvDESCRIPCION_ELEMENTO_CONFIGURACION" runat="server" ControlToValidate="DESCRIPCION_ELEMENTO_CONFIGURACION" ErrorMessage="Seleccione una descripción" CssClass="validator-error"></asp:RequiredFieldValidator>
                        </div>

                        <!-- Nombre -->
                        <div class="col-md-6 col-sm-6">
                            <label class="form-label-modern">Nombre</label>
                            <asp:TextBox ID="NOMBRE_ELEMENTO_CONFIGURACION" runat="server" CssClass="form-control form-control-modern"
                                MaxLength="99" Autocomplete="off" placeholder="Ingresar Elemento Configuración"
                                onchange="CambiaLetraMayuscula('NOMBRE_ELEMENTO_CONFIGURACION')"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvNOMBRE_ELEMENTO_CONFIGURACION" runat="server" ControlToValidate="NOMBRE_ELEMENTO_CONFIGURACION" ErrorMessage="Ingrese nombre" CssClass="validator-error"></asp:RequiredFieldValidator>
                        </div>

                        <!-- Nro. Serie -->
                        <div class="col-md-6 col-sm-6">
                            <label class="form-label-modern">Nro. Serie</label>
                            <asp:TextBox ID="NRO_SERIE" runat="server" CssClass="form-control form-control-modern"
                                MaxLength="30" Autocomplete="off" placeholder="Ingresar Nro. Serie"
                                onchange="CambiaLetraMayuscula('NRO_SERIE')"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvNRO_SERIE" runat="server" ControlToValidate="NRO_SERIE" ErrorMessage="Ingrese número de serie" CssClass="validator-error"></asp:RequiredFieldValidator>
                        </div>

                        <!-- Fabricante o Proveedor -->
                        <div class="col-md-6 col-sm-6">
                            <label class="form-label-modern">Fabricante o Proveedor</label>
                            <asp:TextBox ID="FABRICANTE_O_PROVEEDOR" runat="server" CssClass="form-control form-control-modern"
                                Autocomplete="off" placeholder="Ingresar Fabricante o Proveedor"
                                onchange="CambiaLetraMayuscula('FABRICANTE_O_PROVEEDOR')"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvFABRICANTE_O_PROVEEDOR" runat="server" ControlToValidate="FABRICANTE_O_PROVEEDOR" ErrorMessage="Ingrese fabricante o proveedor" CssClass="validator-error"></asp:RequiredFieldValidator>
                        </div>

                        <!-- Marca -->
                        <div class="col-md-6 col-sm-6">
                            <label class="form-label-modern">Marca</label>
                            <asp:DropDownList ID="MARCA" runat="server" CssClass="form-control form-control-modern" AppendDataBoundItems="True">
                                <asp:ListItem Value="-1">Seleccione una opción</asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="rfvMARCA" runat="server" ControlToValidate="MARCA" ErrorMessage="Seleccione marca" CssClass="validator-error"></asp:RequiredFieldValidator>
                        </div>

                        <!-- Modelo -->
                        <div class="col-md-6 col-sm-6">
                            <label class="form-label-modern">Modelo</label>
                            <asp:DropDownList ID="MODELO" runat="server" CssClass="form-control form-control-modern" AppendDataBoundItems="True">
                                <asp:ListItem Value="-1">Seleccione una opción</asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="rfvMODELO" runat="server" ControlToValidate="MODELO" ErrorMessage="Seleccione modelo" CssClass="validator-error"></asp:RequiredFieldValidator>
                        </div>

                        <!-- Dirección IP -->
                        <div class="col-md-6 col-sm-6">
                            <label class="form-label-modern">Dirección IP</label>
                            <asp:TextBox ID="IP" runat="server" CssClass="form-control form-control-modern"
                                MaxLength="15" Autocomplete="off" placeholder="Ingresar Dirección IP"
                                onchange="CambiaLetraMayuscula('IP')" onkeypress="SoloNumeros_();"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvIP" runat="server" ControlToValidate="IP" ErrorMessage="Ingrese dirección IP" CssClass="validator-error"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="revIP" runat="server" ControlToValidate="IP" ErrorMessage="IP incorrecta" ValidationExpression="^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$" CssClass="validator-error"></asp:RegularExpressionValidator>
                        </div>

                        <!-- Gateway -->
                        <div class="col-md-6 col-sm-6">
                            <label class="form-label-modern">Gateway</label>
                            <asp:TextBox ID="GATEWAY" runat="server" CssClass="form-control form-control-modern"
                                MaxLength="15" Autocomplete="off" placeholder="Ingresar Dirección Gateway"
                                onchange="CambiaLetraMayuscula('GATEWAY')" onkeypress="SoloNumeros_();"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvGATEWAY" runat="server" ControlToValidate="GATEWAY" ErrorMessage="Ingrese gateway" CssClass="validator-error"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="revGateway" runat="server" ControlToValidate="GATEWAY" ErrorMessage="Gateway incorrecto" ValidationExpression="^((25[0-5]|2[0-4][0-9]|[0-1]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[0-1]?[0-9][0-9]?)$" CssClass="validator-error"></asp:RegularExpressionValidator>
                        </div>

                        <!-- Grupo de Trabajo -->
                        <div class="col-md-6 col-sm-6">
                            <label class="form-label-modern">Grupo de Trabajo</label>
                            <asp:TextBox ID="GRUPO_TRABAJO" runat="server" CssClass="form-control form-control-modern"
                                MaxLength="99" Autocomplete="off" placeholder="Ingresar Grupo Trabajo"
                                onchange="CambiaLetraMayuscula('GRUPO_TRABAJO')"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvGRUPO_TRABAJO" runat="server" ControlToValidate="GRUPO_TRABAJO" ErrorMessage="Ingrese grupo de trabajo" CssClass="validator-error"></asp:RequiredFieldValidator>
                        </div>

                        <!-- Estado -->
                        <div class="col-md-6 col-sm-6">
                            <label class="form-label-modern">Estado</label>
                            <asp:DropDownList ID="ESTADO_ELEMENTO_CONFIGURACION" runat="server" CssClass="form-control form-control-modern" AppendDataBoundItems="True">
                                <asp:ListItem Value="-1">Seleccione una opción</asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="rfvESTADO_ELEMENTO_CONFIGURACION" runat="server" ControlToValidate="ESTADO_ELEMENTO_CONFIGURACION" ErrorMessage="Seleccione estado" CssClass="validator-error"></asp:RequiredFieldValidator>
                        </div>

                        <!-- Propietario -->
                        <div class="col-md-6 col-sm-6">
                            <label class="form-label-modern">Propietario</label>
                            <div class="input-group">
                                <asp:TextBox ID="PROPIETARIO" runat="server" CssClass="form-control form-control-modern"
                                    MaxLength="60" Autocomplete="off" placeholder="Buscar propietario"></asp:TextBox>
                                <asp:ImageButton ID="ibtnBUSCAR_PROPIETARIO" runat="server" CssClass="btn btn-primary" ImageUrl="~/Imagenes/buscar.ico" ToolTip="Buscar Propietario" OnClientClick="abrir_ventana_busca_Personal(); return false;" />
                            </div>
                            <asp:RequiredFieldValidator ID="rfvPROPIETARIO" runat="server" ControlToValidate="PROPIETARIO" ErrorMessage="Seleccione propietario" CssClass="validator-error"></asp:RequiredFieldValidator>
                            <asp:HiddenField ID="ID_PROPIETARIO" runat="server" Value="0" EnableViewState="False" />
                        </div>

                        <!-- Impacto Comercial -->
                        <div class="col-md-6 col-sm-6">
                            <label class="form-label-modern">Impacto Comercial</label>
                            <asp:DropDownList ID="IMPACTO_COMERCIAL_ELELEMTO_CONFIGURACION" runat="server" CssClass="form-control form-control-modern" AppendDataBoundItems="True">
                                <asp:ListItem Value="-1">Seleccione una opción</asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="rfvIMPACTO_COMERCIAL_ELELEMTO_CONFIGURACION" runat="server" ControlToValidate="IMPACTO_COMERCIAL_ELELEMTO_CONFIGURACION" ErrorMessage="Seleccione impacto comercial" CssClass="validator-error"></asp:RequiredFieldValidator>
                        </div>

                        <!-- Localización Física -->
                        <div class="col-md-6 col-sm-6">
                            <label class="form-label-modern">Localización Física</label>
                            <div class="input-group">
                                <asp:TextBox ID="LOCALIZACION_FISICA" runat="server" CssClass="form-control form-control-modern"
                                    MaxLength="60" Autocomplete="off" placeholder="Buscar localización" TextMode="MultiLine"></asp:TextBox>
                                <asp:ImageButton ID="ibtnBUSCAR_LOCALIZACION_FISICA" runat="server" CssClass="btn btn-primary" ImageUrl="~/Imagenes/buscar.ico" ToolTip="Buscar Localización Física" OnClientClick="abrir_ventana_busca_Localizacion_Fisica(); return false;" />
                            </div>
                            <asp:RequiredFieldValidator ID="rfvLOCALIZACION_FISICA" runat="server" ControlToValidate="LOCALIZACION_FISICA" ErrorMessage="Seleccione localización" CssClass="validator-error"></asp:RequiredFieldValidator>
                            <asp:HiddenField ID="ID_LOCALIZACION_FISICA" runat="server" Value="0" EnableViewState="False" />
                        </div>

                        <!-- Nivel de Prioridad -->
                        <div class="col-md-6 col-sm-6">
                            <label class="form-label-modern">Nivel de Prioridad</label>
                            <asp:DropDownList ID="NIVEL_PRIORIDAD" runat="server" CssClass="form-control form-control-modern" AppendDataBoundItems="True">
                                <asp:ListItem Value="-1">Seleccione una opción</asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="rfvNIVEL_PRIORIDAD" runat="server" ControlToValidate="NIVEL_PRIORIDAD" ErrorMessage="Seleccione prioridad" CssClass="validator-error"></asp:RequiredFieldValidator>
                        </div>

                        <!-- Fecha Registro -->
                        <div class="col-md-6 col-sm-6">
                            <label class="form-label-modern">Fecha Registro</label>
                            <asp:TextBox ID="FECHA_REGISTRO" runat="server" CssClass="form-control form-control-modern"
                                MaxLength="30" Autocomplete="off" placeholder="Fecha de registro"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvFECHA_REGISTRO" runat="server" ControlToValidate="FECHA_REGISTRO" ErrorMessage="Ingrese fecha" CssClass="validator-error"></asp:RequiredFieldValidator>
   </div>

                        <!-- Responsable Registro -->
                        <div class="col-md-6 col-sm-6">
                            <label class="form-label-modern">Responsable Registro</label>
                            <asp:TextBox ID="RESPONSABLE_REGISTRO" runat="server" CssClass="form-control form-control-modern"
                                MaxLength="30" Autocomplete="off" placeholder="Responsable del registro"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvRESPONSABLE_REGISTRO" runat="server" ControlToValidate="RESPONSABLE_REGISTRO" ErrorMessage="Ingrese responsable" CssClass="validator-error"></asp:RequiredFieldValidator>
                            <asp:HiddenField ID="ID_RESPONSABLE_REGISTRO" runat="server" Value="0" EnableViewState="False" />
                        </div>
                    </div>

                    <!-- Botones de Acción -->
                    <div class="d-flex flex-wrap gap-2 justify-content-center mt-4">
                        <asp:Button ID="btnRegistrar" runat="server" Text="Aceptar"
                            CssClass="btn btn-success btn-modern"
                            onclientclick="return Confirmar('¿Desea guardar datos elemento configuración?');"
                            OnClick="btnRegistrar_Click" />
                        <asp:Button ID="btnCancelar" runat="server" Text="Cancelar" CssClass="btn btn-secondary btn-modern"
                            CausesValidation="False" PostBackUrl="~/ElementosConfiguracion.aspx" OnClick="btnCancelar_Click" />
                    </div>
                </div>
            </div>

            <!-- Hidden Fields -->
            <asp:HiddenField ID="__mensaje" runat="server" />
            <asp:HiddenField ID="__pagina" runat="server" />
            <asp:HiddenField ID="ID_ELEMENTO_CONFIGURACION" runat="server" Value="0" EnableViewState="False" />
            <asp:HiddenField ID="_operacion" runat="server" Value="0" EnableViewState="False" />
        </div>
    </form>

</body>
</html>