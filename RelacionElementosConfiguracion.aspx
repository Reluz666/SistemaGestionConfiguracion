<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RelacionElementosConfiguracion.aspx.cs" Inherits="RelacionElementosConfiguracion"  UnobtrusiveValidationMode="None" %>
<%@ Register src="NavBar.ascx" tagname="NavBar" tagprefix="uc1" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>Relacion Elementos Configuracion</title>

    <!-- Bootstrap 5.3 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet" />
    <!-- Global Styles -->
    <link href="CssJs/global-styles.css" rel="stylesheet" />

    <style>
        /* ===== SPACER ===== */
        .top-spacer { height: 100px; }

        /* ===== RESPONSIVE ===== */
        @media (max-width: 991px) {
            .navbar-modern .dropdown-submenu > .dropdown-menu {
                position: static;
                margin-top: 0;
                margin-left: 1rem;
                box-shadow: none;
            }
            .form-card { padding: 1.5rem; }
            .table-wrapper { padding: 1rem; }
        }

        @media (max-width: 576px) {
            .btn-modern { width: 100%; margin-bottom: 0.5rem; }
        }

        .auto-style1 {
            color: #FFFFFF;
        }
    </style>

    <script lang="javascript" type="text/javascript">

        function abrir_ventana_Obtener_Elementos_Configuracion(Opcion) {
            if (Opcion == 1) {
                window.document.getElementById("ID_CI_P").value = 0;
                window.document.getElementById("Nombre_CI_P").value = "";
                window.document.getElementById("Tipo_CI_P").value = "";
                window.document.getElementById("Estado_CI_P").value = "";
                window.document.getElementById("Propietario_CI_P").value = "";
                window.document.getElementById("Descripcion_CI_P").value = "";
                window.document.getElementById("Sede_P").value = "";
                window.document.getElementById("Local_P").value = "";
                window.document.getElementById("Area_P").value = "";
                window.document.getElementById("NroPiso_P").value = "";
                window.document.getElementById("NroAmbiente_P").value = "";
                window.document.getElementById("Ubicacion_P").value = "";
                window.document.getElementById("Direccion_P").value = "";
                window.document.getElementById("NivelPrioridad_CI_P").value = "";
            } else if (Opcion == 2) {
                window.document.getElementById("ID_CI_H").value = 0;
                window.document.getElementById("Nombre_CI_H").value = "";
                window.document.getElementById("Tipo_CI_H").value = "";
                window.document.getElementById("Estado_CI_H").value = "";
                window.document.getElementById("Propietario_CI_H").value = "";
                window.document.getElementById("Descripcion_CI_H").value = "";
                window.document.getElementById("Sede_H").value = "";
                window.document.getElementById("Local_H").value = "";
                window.document.getElementById("Area_H").value = "";
                window.document.getElementById("NroPiso_H").value = "";
                window.document.getElementById("NroAmbiente_H").value = "";
                window.document.getElementById("Ubicacion_H").value = "";
                window.document.getElementById("Direccion_H").value = "";
                window.document.getElementById("NivelPrioridad_CI_H").value = "";
            }
            var options = 'channelmode=1,directories=0,fullscreen=0,location=0,menubar=0,resizable=0,titlebar=0,toolbar=0,edge=Raised,status=no,scrollbars=1,width=1000,height=550,top=50px, left=175px';
            window.open('Ventanas/ventanaObtenerElemtosConfiguracion.aspx?Nivel=' + Opcion, '', options);
        }

        function cerrar_ventana() {
            window.close();
        }

        function MostrarMensaje() {
            var mensaje = document.getElementById("__mensaje").value;
            if (mensaje != "") {
                alert(mensaje);
                if (document.getElementById("__pagina").value != "")
                    location.href = document.getElementById("__pagina").value;

            }
            document.getElementById('<%= Nombre_CI_P.ClientID %>').readOnly = true;
            document.getElementById('<%= Tipo_CI_P.ClientID %>').readOnly = true;
            document.getElementById('<%= Estado_CI_P.ClientID %>').readOnly = true;
            document.getElementById('<%= Propietario_CI_P.ClientID %>').readOnly = true;
            document.getElementById('<%= Descripcion_CI_P.ClientID %>').readOnly = true;
            document.getElementById('<%= Sede_P.ClientID %>').readOnly = true;
            document.getElementById('<%= Local_P.ClientID %>').readOnly = true;
            document.getElementById('<%= Area_P.ClientID %>').readOnly = true;
            document.getElementById('<%= NroPiso_P.ClientID %>').readOnly = true;
            document.getElementById('<%= NroAmbiente_P.ClientID %>').readOnly = true;
            document.getElementById('<%= Ubicacion_P.ClientID %>').readOnly = true;
            document.getElementById('<%= Direccion_P.ClientID %>').readOnly = true;
            document.getElementById('<%= NivelPrioridad_CI_P.ClientID %>').readOnly = true;

            document.getElementById('<%= Nombre_CI_H.ClientID %>').readOnly = true;
            document.getElementById('<%= Tipo_CI_H.ClientID %>').readOnly = true;
            document.getElementById('<%= Estado_CI_H.ClientID %>').readOnly = true;
            document.getElementById('<%= Propietario_CI_H.ClientID %>').readOnly = true;
            document.getElementById('<%= Descripcion_CI_H.ClientID %>').readOnly = true;
            document.getElementById('<%= Sede_H.ClientID %>').readOnly = true;
            document.getElementById('<%= Local_H.ClientID %>').readOnly = true;
            document.getElementById('<%= Area_H.ClientID %>').readOnly = true;
            document.getElementById('<%= NroPiso_H.ClientID %>').readOnly = true;
            document.getElementById('<%= NroAmbiente_H.ClientID %>').readOnly = true;
            document.getElementById('<%= Ubicacion_H.ClientID %>').readOnly = true;
            document.getElementById('<%= Direccion_H.ClientID %>').readOnly = true;
            document.getElementById('<%= NivelPrioridad_CI_H.ClientID %>').readOnly = true;

        }

        function window_load() {
            MostrarMensaje()
        }

        function Confirmar(men) {
            if (!confirm(men))
                return false;

        }

    </script>

    <script type="text/javascript" src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body onload ="MostrarMensaje()">

    <uc1:NavBar ID="NavBar1" runat="server" />

    <!-- Espaciador para navbar fija -->
    <div class="top-spacer"></div>

    <!-- ========== FORMULARIO ========== -->
    <form id="form1" runat="server">
        <div class="container">

            <!-- Card Formulario -->
            <div class="form-card">
                <div class="card-header">
                    <i class="bi bi-link-45deg me-2"></i>Ingrese Datos Relacion Elementos de Configuracion
                </div>
                <div class="card-body p-3">

                    <!-- Padre -->
                    <h6 class="mb-3"><i class="bi bi-person-badge me-2"></i>Datos Elemento Padre</h6>
                    <div class="row g-3 mb-3">
                        <div class="col-md-4 col-sm-6">
                            <label class="form-label-modern">Nombre CI</label>
                            <asp:TextBox ID="Nombre_CI_P" runat="server" CssClass="form-control form-control-modern" MaxLength="30" Autocomplete="off" placeholder=""></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvNombre_CI_P" runat="server" ControlToValidate="Nombre_CI_P" ErrorMessage="*" CssClass="validator-error" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </div>
                        <div class="col-md-4 col-sm-6">
                            <label class="form-label-modern">Tipo CI</label>
                            <asp:TextBox ID="Tipo_CI_P" runat="server" CssClass="form-control form-control-modern" MaxLength="30" Autocomplete="off" placeholder=""></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvTipo_CI_P" runat="server" ControlToValidate="Tipo_CI_P" ErrorMessage="*" CssClass="validator-error" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </div>
                        <div class="col-md-4 col-sm-6">
                            <label class="form-label-modern">Estado CI</label>
                            <asp:TextBox ID="Estado_CI_P" runat="server" CssClass="form-control form-control-modern" MaxLength="30" Autocomplete="off" placeholder=""></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvEstado_CI_P" runat="server" ControlToValidate="Estado_CI_P" ErrorMessage="*" CssClass="validator-error" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </div>
                        <div class="col-md-4 col-sm-6">
                            <label class="form-label-modern">Propietario CI</label>
                            <asp:TextBox ID="Propietario_CI_P" runat="server" CssClass="form-control form-control-modern" MaxLength="30" Autocomplete="off" placeholder=""></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvPropietario_CI_P" runat="server" ControlToValidate="Propietario_CI_P" ErrorMessage="*" CssClass="validator-error" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </div>
                        <div class="col-md-4 col-sm-6">
                            <label class="form-label-modern">Descripcion CI</label>
                            <asp:TextBox ID="Descripcion_CI_P" runat="server" CssClass="form-control form-control-modern" MaxLength="30" Autocomplete="off" placeholder=""></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvDescripcion_CI_P" runat="server" ControlToValidate="Descripcion_CI_P" ErrorMessage="*" CssClass="validator-error" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </div>
                        <div class="col-md-4 col-sm-6">
                            <label class="form-label-modern">Nivel Prioridad CI</label>
                            <asp:TextBox ID="NivelPrioridad_CI_P" runat="server" CssClass="form-control form-control-modern" MaxLength="30" Autocomplete="off" placeholder=""></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvNivelPrioridad_CI_P" runat="server" ControlToValidate="NivelPrioridad_CI_P" ErrorMessage="*" CssClass="validator-error" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </div>
                        <div class="col-md-4 col-sm-6">
                            <label class="form-label-modern">Sede</label>
                            <asp:TextBox ID="Sede_P" runat="server" CssClass="form-control form-control-modern" MaxLength="30" Autocomplete="off" placeholder=""></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvSede_P" runat="server" ControlToValidate="Sede_P" ErrorMessage="*" CssClass="validator-error" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </div>
                        <div class="col-md-4 col-sm-6">
                            <label class="form-label-modern">Local</label>
                            <asp:TextBox ID="Local_P" runat="server" CssClass="form-control form-control-modern" MaxLength="30" Autocomplete="off" placeholder=""></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvLocal_P" runat="server" ControlToValidate="Local_P" ErrorMessage="*" CssClass="validator-error" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </div>
                        <div class="col-md-4 col-sm-6">
                            <label class="form-label-modern">Area</label>
                            <asp:TextBox ID="Area_P" runat="server" CssClass="form-control form-control-modern" MaxLength="30" Autocomplete="off" placeholder=""></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvArea_P" runat="server" ControlToValidate="Area_P" ErrorMessage="*" CssClass="validator-error" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </div>
                        <div class="col-md-4 col-sm-6">
                            <label class="form-label-modern">Nro. Piso</label>
                            <asp:TextBox ID="NroPiso_P" runat="server" CssClass="form-control form-control-modern" MaxLength="30" Autocomplete="off" placeholder=""></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvNroPiso_P" runat="server" ControlToValidate="NroPiso_P" ErrorMessage="*" CssClass="validator-error" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </div>
                        <div class="col-md-4 col-sm-6">
                            <label class="form-label-modern">Nro. Ambiente</label>
                            <asp:TextBox ID="NroAmbiente_P" runat="server" CssClass="form-control form-control-modern" MaxLength="30" Autocomplete="off" placeholder=""></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvNroAmbiente_P" runat="server" ControlToValidate="NroAmbiente_P" ErrorMessage="*" CssClass="validator-error" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </div>
                        <div class="col-md-4 col-sm-6">
                            <label class="form-label-modern">Ubicacion</label>
                            <asp:TextBox ID="Ubicacion_P" runat="server" CssClass="form-control form-control-modern" MaxLength="30" Autocomplete="off" placeholder=""></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvUbicacion_P" runat="server" ControlToValidate="Ubicacion_P" ErrorMessage="*" CssClass="validator-error" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </div>
                        <div class="col-md-4 col-sm-6">
                            <label class="form-label-modern">Direccion</label>
                            <asp:TextBox ID="Direccion_P" runat="server" CssClass="form-control form-control-modern" MaxLength="30" Autocomplete="off" placeholder=""></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvDireccion_P" runat="server" ControlToValidate="Direccion_P" ErrorMessage="*" CssClass="validator-error" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </div>
                        <div class="col-md-12 col-sm-12">
                            <asp:HiddenField ID="ID_CI_P" runat="server" Value="0" EnableViewState="False" />
                            <asp:Button ID="btnBuscar_CI_P" runat="server" Text="Buscar Elementos Configuracion Padre" class="btn btn-info btn-modern" CausesValidation="False" OnClientClick="abrir_ventana_Obtener_Elementos_Configuracion(1);"/>
                        </div>
                    </div>

                    <hr class="my-4" />

                    <!-- Hijo -->
                    <h6 class="mb-3"><i class="bi bi-person-badge-fill me-2"></i>Datos Elemento Hijo</h6>
                    <div class="row g-3 mb-3">
                        <div class="col-md-4 col-sm-6">
                            <label class="form-label-modern">Nombre CI</label>
                            <asp:TextBox ID="Nombre_CI_H" runat="server" CssClass="form-control form-control-modern" MaxLength="30" Autocomplete="off" placeholder=""></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvNombre_CI_H" runat="server" ControlToValidate="Nombre_CI_H" ErrorMessage="*" CssClass="validator-error" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </div>
                        <div class="col-md-4 col-sm-6">
                            <label class="form-label-modern">Tipo CI</label>
                            <asp:TextBox ID="Tipo_CI_H" runat="server" CssClass="form-control form-control-modern" MaxLength="30" Autocomplete="off" placeholder=""></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvTipo_CI_H" runat="server" ControlToValidate="Tipo_CI_H" ErrorMessage="*" CssClass="validator-error" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </div>
                        <div class="col-md-4 col-sm-6">
                            <label class="form-label-modern">Estado CI</label>
                            <asp:TextBox ID="Estado_CI_H" runat="server" CssClass="form-control form-control-modern" MaxLength="30" Autocomplete="off" placeholder=""></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvEstado_CI_H" runat="server" ControlToValidate="Estado_CI_H" ErrorMessage="*" CssClass="validator-error" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </div>
                        <div class="col-md-4 col-sm-6">
                            <label class="form-label-modern">Propietario CI</label>
                            <asp:TextBox ID="Propietario_CI_H" runat="server" CssClass="form-control form-control-modern" MaxLength="30" Autocomplete="off" placeholder=""></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvPropietario_CI_H" runat="server" ControlToValidate="Propietario_CI_H" ErrorMessage="*" CssClass="validator-error" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </div>
                        <div class="col-md-4 col-sm-6">
                            <label class="form-label-modern">Descripcion CI</label>
                            <asp:TextBox ID="Descripcion_CI_H" runat="server" CssClass="form-control form-control-modern" MaxLength="30" Autocomplete="off" placeholder=""></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvDescripcion_CI_H" runat="server" ControlToValidate="Descripcion_CI_H" ErrorMessage="*" CssClass="validator-error" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </div>
                        <div class="col-md-4 col-sm-6">
                            <label class="form-label-modern">Nivel Prioridad CI</label>
                            <asp:TextBox ID="NivelPrioridad_CI_H" runat="server" CssClass="form-control form-control-modern" MaxLength="30" Autocomplete="off" placeholder=""></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvNivelPrioridad_CI_H" runat="server" ControlToValidate="NivelPrioridad_CI_H" ErrorMessage="*" CssClass="validator-error" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </div>
                        <div class="col-md-4 col-sm-6">
                            <label class="form-label-modern">Sede</label>
                            <asp:TextBox ID="Sede_H" runat="server" CssClass="form-control form-control-modern" MaxLength="30" Autocomplete="off" placeholder=""></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvSede_H" runat="server" ControlToValidate="Sede_H" ErrorMessage="*" CssClass="validator-error" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </div>
                        <div class="col-md-4 col-sm-6">
                            <label class="form-label-modern">Local</label>
                            <asp:TextBox ID="Local_H" runat="server" CssClass="form-control form-control-modern" MaxLength="30" Autocomplete="off" placeholder=""></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvLocal_H" runat="server" ControlToValidate="Local_H" ErrorMessage="*" CssClass="validator-error" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </div>
                        <div class="col-md-4 col-sm-6">
                            <label class="form-label-modern">Area</label>
                            <asp:TextBox ID="Area_H" runat="server" CssClass="form-control form-control-modern" MaxLength="30" Autocomplete="off" placeholder=""></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvArea_H" runat="server" ControlToValidate="Area_H" ErrorMessage="*" CssClass="validator-error" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </div>
                        <div class="col-md-4 col-sm-6">
                            <label class="form-label-modern">Nro. Piso</label>
                            <asp:TextBox ID="NroPiso_H" runat="server" CssClass="form-control form-control-modern" MaxLength="30" Autocomplete="off" placeholder=""></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvNroPiso_H" runat="server" ControlToValidate="NroPiso_H" ErrorMessage="*" CssClass="validator-error" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </div>
                        <div class="col-md-4 col-sm-6">
                            <label class="form-label-modern">Nro. Ambiente</label>
                            <asp:TextBox ID="NroAmbiente_H" runat="server" CssClass="form-control form-control-modern" MaxLength="30" Autocomplete="off" placeholder=""></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvNroAmbiente_H" runat="server" ControlToValidate="NroAmbiente_H" ErrorMessage="*" CssClass="validator-error" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </div>
                        <div class="col-md-4 col-sm-6">
                            <label class="form-label-modern">Ubicacion</label>
                            <asp:TextBox ID="Ubicacion_H" runat="server" CssClass="form-control form-control-modern" MaxLength="30" Autocomplete="off" placeholder=""></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvUbicacion_H" runat="server" ControlToValidate="Ubicacion_H" ErrorMessage="*" CssClass="validator-error" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </div>
                        <div class="col-md-4 col-sm-6">
                            <label class="form-label-modern">Direccion</label>
                            <asp:TextBox ID="Direccion_H" runat="server" CssClass="form-control form-control-modern" MaxLength="30" Autocomplete="off" placeholder=""></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvDireccion_H" runat="server" ControlToValidate="Direccion_H" ErrorMessage="*" CssClass="validator-error" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </div>
                        <div class="col-md-12 col-sm-12">
                            <asp:HiddenField ID="ID_CI_H" runat="server" Value="0" EnableViewState="False" />
                            <asp:Button ID="btnBuscar_CI_H" runat="server" Text="Buscar Elementos Configuracion Hijo" class="btn btn-info btn-modern" CausesValidation="False" OnClientClick="abrir_ventana_Obtener_Elementos_Configuracion(2);"/>
                        </div>
                    </div>

                    <hr class="my-4" />

                    <!-- Tipo Relacion -->
                    <div class="row g-3 mb-3">
                        <div class="col-md-6 col-sm-12">
                            <label class="form-label-modern">Tipo Relacion Elemento Configuracion</label>
                            <asp:DropDownList ID="ddlTipoRelecion_CI_P_H" runat="server" CssClass="form-control form-control-modern" AppendDataBoundItems="True">
                                        <asp:ListItem Value="-1">_____SELECCIONE TIPO RELACION ELEMENTO CONFIGURACION_____</asp:ListItem>
                                    </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="rfvddlTipoRelecion_CI_P_H" runat="server" ControlToValidate="ddlTipoRelecion_CI_P_H" ErrorMessage="*" CssClass="validator-error" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="revddlTipoRelecion_CI_P_H" runat="server" BackColor="White"
                        ControlToValidate="ddlTipoRelecion_CI_P_H" Display="Dynamic" ErrorMessage="*" CssClass="validator-error" ForeColor="Red"
                        SetFocusOnError="True" ValidationExpression="\d{1,99}"></asp:RegularExpressionValidator>
                        </div>
                    </div>

                    <!-- Botones de accion -->
                    <div class="d-flex flex-wrap gap-2 justify-content-center">
                        <asp:Button ID="btnRegistrar" runat="server"
                            style="font-family: Calibri; color: #000000; font-size: medium"
                            Text="Aceptar"
                            onclientclick="return Confirmar('¿Desea guardar relacion elementos configuracion?');"
                            CssClass="btn btn-success btn-modern" OnClick="btnRegistrar_Click" />
                        <asp:Button ID="btnCancelar" runat="server" class="btn btn-danger btn-modern"
                            style="font-family: Calibri;  font-size: medium" Text="Cancelar" CausesValidation="False" PostBackUrl="~/RelacionesElementosConfiguracion.aspx"
                             />
                    </div>
                </div>
            </div>

            <!-- Hidden Fields -->
            <asp:HiddenField ID="__pagina" runat="server" />
            <asp:HiddenField ID="__mensaje" runat="server" />
            <asp:HiddenField ID="ID_RELACION" runat="server" Value="0" EnableViewState="False" />
            <asp:HiddenField ID="_operacion" runat="server" Value="0" EnableViewState="False" />

        </div>
    </form>

    <!-- Scripts -->
    <script type="text/javascript" src="../Otros_css_js/resaltar.js"></script>

</body>
</html>