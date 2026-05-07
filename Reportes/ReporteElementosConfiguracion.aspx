<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ReporteElementosConfiguracion.aspx.cs" Inherits="ElementosConfiguracion"  UnobtrusiveValidationMode="None" %>

<%@ Register src="../NavBar.ascx" tagname="NavBar" tagprefix="uc1" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>Elementos de Configuracion</title>

    <!-- Bootstrap 5.3 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet" />
    <!-- DataTables.net CSS -->
    <link href="https://cdn.jsdelivr.net/npm/datatables.net-bs5@2.0.1/css/dataTables.bootstrap5.min.css" rel="stylesheet" />

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

        .navbar-modern .dropdown-submenu {
            position: relative;
        }

        .navbar-modern .dropdown-submenu > .dropdown-toggle::after {
            border-left: 0.3em solid;
            border-top: 0.3em solid transparent;
            border-bottom: 0.3em solid transparent;
            margin-left: auto;
        }

        .navbar-modern .dropdown-submenu > .dropdown-menu {
            top: 0;
            left: 100%;
            margin-top: -6px;
            margin-left: 2px;
            border-radius: 12px;
        }

        .navbar-modern .dropdown-submenu:hover > .dropdown-menu {
            display: block;
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

        select.form-control-modern {
            cursor: pointer;
        }

        /* ===== TABLA ===== */
        .table-wrapper {
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 4px 25px rgba(0, 0, 0, 0.08);
            padding: 1rem;
            border: 1px solid rgba(0, 0, 0, 0.05);
            overflow-x: auto;
        }

        .table-modern-grid {
            border-collapse: separate !important;
            border-spacing: 0;
            width: 100%;
            min-width: 900px;
        }

        .table-modern-grid thead tr th {
            background: linear-gradient(135deg, #1a1a2e 0%, #16213e 100%);
            color: #fff;
            font-weight: 600;
            font-size: 0.7rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            padding: 0.6rem 0.5rem !important;
            border: none !important;
            white-space: nowrap;
        }

        .table-modern-grid thead tr th:first-child {
            border-radius: 10px 0 0 10px;
        }

        .table-modern-grid thead tr th:last-child {
            border-radius: 0 10px 10px 0;
        }

        .table-modern-grid tbody tr td {
            padding: 0.5rem 0.45rem !important;
            border: none;
            border-bottom: 1px solid #f1f1f1;
            vertical-align: middle;
            font-size: 0.8rem;
            color: #2d3436;
            background: #fff;
        }

        .table-modern-grid tbody tr:hover td {
            background: rgba(233, 69, 96, 0.04);
        }

        .table-modern-grid tbody tr:last-child td {
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

        /* ===== VALIDATORS ===== */
        .validator-error {
            color: #e94560;
            font-size: 0.8rem;
            font-weight: 500;
        }

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

        .auto-style1 { width: 309px; }
    </style>

    <script lang="javascript" type="text/javascript">
        function abrir_ventana_imprimir_reporte(Opcion) {
            if (Verificar_Datos_tabla(Opcion)) {
                window.name = "Lista de Personal";
                var options = 'channelmode=1,directories=0,fullscreen=0,location=0,menubar=0,resizable=no,titlebar=0,toolbar=0,edge=Raised,status=no,scrollbars=1,width=1000,height=500,top=70px, left=175px';
                window.open('../Reportes/Reporte.aspx', '', options);
            }
        }

        function Verificar_Datos_tabla(Opcion) {
            var Pregunta = '';
            var Mensaje = '';
            if (Opcion == 1) {
                Pregunta = "¿Desea exportar los datos a Microsoft Office Excel...?";
                Mensaje = "No hay datos para exportar a Microsoft Office Excel.";
            }
            else if (Opcion == 2) {
                Pregunta = "¿Desea imprimir el reporte?";
                Mensaje = "No hay datos para imprimir el reporte.";
            }
            var tabla = document.getElementById("Table_");
            var tabla_longitud = (tabla.rows.length) - 1;
            var Ok, Rpta;
            Ok = true;
            Rpta = confirm(Pregunta);
            if (Rpta == 1) {
                if (tabla_longitud == 0) {
                    Ok = false;
                    alert(Mensaje);
                }
            }
            else {
                Ok = false;
            }
            return Ok;
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
        }

        function window_load() {
            MostrarMensaje()
        }

        function Confirmar(men) {
            if (!confirm(men))
                return false;
        }
    </script>
</head>
<body onload="MostrarMensaje()">

    <uc1:NavBar ID="NavBar1" runat="server" />

    <form id="form1" runat="server">
        <div class="table-responsive">
           <div class="container-fluid">
                <table class="table table text-center">
                    <tr>
                        <td style="text-align: left" colspan="5">
                            &nbsp;</td>
                        <td style="text-align: left">
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td style="text-align: left" >
                            <asp:CheckBox ID="cbnci" runat="server" CssClass="form-check-input position-static" Font-Size="X-Small" Text="Nombre CI" AutoPostBack="True" OnCheckedChanged="cbnci_CheckedChanged"/>
                        </td>
                        <td style="text-align: left" >
                            <asp:CheckBox ID="cbtci" runat="server" CssClass="form-check-input position-static" Font-Size="X-Small" Text="Tipo CI" AutoPostBack="True" OnCheckedChanged="cbtci_CheckedChanged"/>
                        </td>
                        <td style="text-align: left" >
                            <asp:CheckBox ID="cbeci" runat="server" CssClass="form-check-input position-static" Font-Size="X-Small" Text="Estado CI" AutoPostBack="True" OnCheckedChanged="cbeci_CheckedChanged"/>
                        </td>
                        <td style="text-align: left" class="auto-style1" >
                            <asp:CheckBox ID="cbpci" runat="server" CssClass="form-check-input position-static" Font-Size="X-Small" Text="Propietario CI" AutoPostBack="True" OnCheckedChanged="cbpci_CheckedChanged"/>
                        </td>
                        <td style="text-align: left" class="auto-style1" >
                            <asp:CheckBox ID="cbdci" runat="server" CssClass="form-check-input position-static" Font-Size="X-Small" Text="Descripcion CI" AutoPostBack="True" OnCheckedChanged="cbdci_CheckedChanged"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                             <asp:TextBox ID="txtnci" runat="server" CssClass="form-control input-sm" MaxLength="25" Autocomplete="off" placeholder="Ingresar Nombre" onchange=""
                        onkeypress="" Enabled="False"></asp:TextBox>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddltci" runat="server" CssClass="form-control input-sm"
                                        AppendDataBoundItems="True" Enabled="False"
                                       >
                                        <asp:ListItem Value="-1">_____SELECCIONE TIPO CI_____</asp:ListItem>
                                    </asp:DropDownList>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddleci" runat="server" CssClass="form-control input-sm"
                                        AppendDataBoundItems="True" Enabled="False"
                                       >
                                        <asp:ListItem Value="-1">_____SELECCIONE ESTADO CI_____</asp:ListItem>
                                    </asp:DropDownList>
                        </td>
                        <td class="auto-style1">
                             <asp:TextBox ID="txtpci" runat="server" CssClass="form-control input-sm" MaxLength="25" Autocomplete="off" placeholder="Ingresar Nombre" onchange=""
                        onkeypress="" Enabled="False"></asp:TextBox>
                        </td>
                        <td class="auto-style1">
                            <asp:DropDownList ID="ddldci" runat="server" CssClass="form-control input-sm"
                                        AppendDataBoundItems="True" Enabled="False"
                                       >
                                        <asp:ListItem Value="-1">_____SELECCIONE DESCRIPCION CI_____</asp:ListItem>
                                    </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: left" >
                            <asp:CheckBox ID="cbici" runat="server" CssClass="form-check-input position-static" Font-Size="X-Small" Text="Impacto CI" AutoPostBack="True" OnCheckedChanged="cbici_CheckedChanged"/>
                        </td>
                        <td style="text-align: left" >
                            <asp:CheckBox ID="cbs" runat="server" CssClass="form-check-input position-static" Font-Size="X-Small" Text="Sede" AutoPostBack="True" OnCheckedChanged="cbs_CheckedChanged"/>
                        </td>
                        <td style="text-align: left" >
                            <asp:CheckBox ID="cbl" runat="server" CssClass="form-check-input position-static" Font-Size="X-Small" Text="Local" AutoPostBack="True" OnCheckedChanged="cbl_CheckedChanged"/>
                        </td>
                        <td style="text-align: left" >
                            <asp:CheckBox ID="cba" runat="server" CssClass="form-check-input position-static" Font-Size="X-Small" Text="Area" AutoPostBack="True" OnCheckedChanged="cba_CheckedChanged"/>
                        </td>
                        <td style="text-align: left" >
                            <asp:CheckBox ID="cbr" runat="server" CssClass="form-check-input position-static" Font-Size="X-Small" Text="Responsable" AutoPostBack="True" OnCheckedChanged="cbr_CheckedChanged"/>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: left" >
                            <asp:DropDownList ID="ddlici" runat="server" CssClass="form-control input-sm"
                                        AppendDataBoundItems="True" Enabled="False"
                                       >
                                        <asp:ListItem Value="-1">_____SELECCIONE IMPACTO CI_____</asp:ListItem>
                                    </asp:DropDownList>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddls" runat="server" CssClass="form-control input-sm"
                                        AppendDataBoundItems="True" Enabled="False" OnSelectedIndexChanged="ddls_SelectedIndexChanged"
                                       >
                                        <asp:ListItem Value="-1">_____SELECCIONE SEDE_____</asp:ListItem>
                                    </asp:DropDownList>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddll" runat="server" CssClass="form-control input-sm"
                                        AppendDataBoundItems="True" AutoPostBack="True" Enabled="False" OnSelectedIndexChanged="ddll_SelectedIndexChanged"
                                       >
                                        <asp:ListItem Value="-1">_____SELECCIONE LOCAL_____</asp:ListItem>
                                    </asp:DropDownList>
                        </td>
                        <td class="auto-style1">
                            <asp:DropDownList ID="ddla" runat="server" CssClass="form-control input-sm"
                                        AppendDataBoundItems="True" Enabled="False"
                                       >
                                        <asp:ListItem Value="-1">_____SELECCIONE AREA_____</asp:ListItem>
                                    </asp:DropDownList>
                        </td>
                        <td class="auto-style1">
                            <asp:DropDownList ID="ddlr" runat="server" CssClass="form-control input-sm"
                                        AppendDataBoundItems="True" Enabled="False"
                                       >
                                        <asp:ListItem Value="-1">_____SELECCIONE RESPONSABLE_____</asp:ListItem>
                                    </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: left" >
                            <asp:CheckBox ID="cbnp" runat="server" CssClass="form-check-input position-static" Font-Size="X-Small" Text="Nivel Prioridad" AutoPostBack="True" OnCheckedChanged="cbnp_CheckedChanged"/>
                        </td>
                        <td style="text-align: left" >
                            <asp:CheckBox ID="cbm" runat="server" CssClass="form-check-input position-static" Font-Size="X-Small" Text="Marca" AutoPostBack="True" OnCheckedChanged="cbm_CheckedChanged"/>
                        </td>
                        <td style="text-align: left" >
                            <asp:CheckBox ID="cbmo" runat="server" CssClass="form-check-input position-static" Font-Size="X-Small" Text="Modelo" AutoPostBack="True" OnCheckedChanged="cbmo_CheckedChanged"/>
                        </td>
                        <td style="text-align: left" >
                            <asp:CheckBox ID="cbf" runat="server" CssClass="form-check-input position-static" Font-Size="X-Small" Text="Fecha Registro CI" AutoPostBack="True" OnCheckedChanged="cbf_CheckedChanged"/>
                        </td>
                        <td class="auto-style1">
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td style="text-align: left" >
                            <asp:DropDownList ID="ddlnp" runat="server" CssClass="form-control input-sm"
                                        AppendDataBoundItems="True" Enabled="False"
                                       >
                                        <asp:ListItem Value="-1">_____SELECCIONE NIVEL PRIORIDAD_____</asp:ListItem>
                                    </asp:DropDownList>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlm" runat="server" CssClass="form-control input-sm"
                                        AppendDataBoundItems="True" Enabled="False"
                                       >
                                        <asp:ListItem Value="-1">_____SELECCIONE MARCA_____</asp:ListItem>
                                    </asp:DropDownList>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlmo" runat="server" CssClass="form-control input-sm"
                                        AppendDataBoundItems="True" Enabled="False"
                                       >
                                        <asp:ListItem Value="-1">_____SELECCIONE MODELO_____</asp:ListItem>
                                    </asp:DropDownList>
                        </td>
                        <td style="text-align: left" >
                            <strong>Fec. Ini:</strong><asp:TextBox ID="txtfi" runat="server"
                        class="form-control" placeholder="Ingrese fec. inicio" Width="" onFocus='' onChange='' onBlur='' Enabled="False"></asp:TextBox>

                    <input id="btnfi" type="button"
                        value="..." style="height: 25px; width: 25px;"
                        class="form-check" /></td>
                        <td style="text-align: left" >
                            <strong>Fec. Fin</strong>:<asp:TextBox ID="txtff" runat="server" class="form-control" placeholder="Ingrese fec. fin" onFocus='' onChange='' onBlur='' Enabled="False"></asp:TextBox>
                    <input id="btnff" type="button"
                        value="..." style="height: 25px; width: 25px;" class="form-check" /></td>
                    </tr>
                    <tr>
                        <td style="text-align: left" >
                            &nbsp;</td>
                        <td>
                            &nbsp;</td>
                        <td>
                            &nbsp;</td>
                        <td style="text-align: left" >
                            <asp:LinkButton ID="lbtnBuscar" runat="server" CausesValidation="False" class="btn btn-info" OnClick="lbtnBuscar_Click" Text="Buscar" UseSubmitBehavior="False" />
                            <asp:Button ID="btnActualizarInformacion" runat="server" class="btn btn-success" CssClass="btn btn-warning" onclick="btnActualizarInformacion_Click" Text="Actualizar Informacion" />
                        </td>
                        <td class="auto-style1">
                            <asp:HyperLink ID="IMPRIMIR" runat="server" BorderStyle="None" class="btn btn-info" NavigateUrl="" onClick="abrir_ventana_imprimir_reporte(2);">Imprimir reporte</asp:HyperLink>
                        </td>
                    </tr>
                    <tr>
                    <td colspan="5">
                        <asp:Table ID="Table_" runat="server" BackColor="White"
                            class="table table-condensed"
                        BorderColor="White" CellPadding="2" CellSpacing="0" Font-Size="X-Small"
                        GridLines="Both" style="text-align: left">
                        <asp:TableRow ID="CABECERA" runat="server">
                            <asp:TableCell ID="_ID_CI" runat="server" BackColor="#FFFFC0" BorderColor="#FFFFC0"
                                     ForeColor="Green" Visible="False">ID CI</asp:TableCell>

                            <asp:TableCell ID="_NOMBRE_CI" runat="server" BackColor="Black" BorderColor="Black"
                                ForeColor="White" >NOMBRE CI</asp:TableCell>

                            <asp:TableCell ID="_NOMBRE_TIPO_CI" runat="server" BackColor="Black" BorderColor="Black"
                                ForeColor="White" >TIPO CI</asp:TableCell>

                            <asp:TableCell ID="_NRO_SERIE" runat="server" BackColor="Black" BorderColor="Black"
                                ForeColor="White" >NRO SERIE</asp:TableCell>

                             <asp:TableCell ID="_FABRICANTE_O_PROVEEDOR" runat="server" BackColor="Black" BorderColor="Black"
                                ForeColor="White" >FABRICANTE<br />PROVEEDOR</asp:TableCell>

                             <asp:TableCell ID="_MARCA_MODELO" runat="server" BackColor="Black" BorderColor="Black"
                                ForeColor="White" >MARCA /<br />MODELO</asp:TableCell>

                            <asp:TableCell ID="_IP" runat="server" BackColor="Black" BorderColor="Black"
                                ForeColor="White" >IP</asp:TableCell>

                            <asp:TableCell ID="_GATEWAY" runat="server" BackColor="Black" BorderColor="Black"
                                ForeColor="White" >GATEWAY</asp:TableCell>

                            <asp:TableCell ID="_GRUPO_TRABAJO" runat="server" BackColor="Black" BorderColor="Black"
                                ForeColor="White" >GRUPO<br />TRABAJO</asp:TableCell>

                            <asp:TableCell ID="_ESTADO_CI" runat="server" BackColor="Black" BorderColor="Black"
                                ForeColor="White" >ESTADO CI</asp:TableCell>

                            <asp:TableCell ID="_PROPIETARIO" runat="server" BackColor="Black" BorderColor="Black"
                                ForeColor="White" Visible="True">PROPIETARIO CI</asp:TableCell>

                            <asp:TableCell ID="_DESCRIPCION_CI" runat="server" BackColor="Black" BorderColor="Black"
                                ForeColor="White" >DESCRIPCION CI</asp:TableCell>

                            <asp:TableCell ID="_IMPACTO__PRIORIDAD_CI" runat="server" BackColor="Black" BorderColor="Black"
                                ForeColor="White" >IMPACTO / PRIORIDAD</asp:TableCell>

                            <asp:TableCell ID="_SEDE_LOCAL" runat="server" BackColor="Black" BorderColor="Black"
                                ForeColor="White" >SEDE / <br />LOCAL</asp:TableCell>
                            <asp:TableCell ID="_UBICACION_LOCAL" runat="server" BackColor="Black" BorderColor="Black"
                                ForeColor="White" Visible="false" >UBICACION LOCAL</asp:TableCell>
                            <asp:TableCell ID="_DIRECCION_LOCAL" runat="server" BackColor="Black" BorderColor="Black"
                                ForeColor="White" Visible="false" >DIRECCION LOCAL</asp:TableCell>
                            <asp:TableCell ID="_AREA" runat="server" BackColor="Black" BorderColor="Black"
                                ForeColor="White" >AREA</asp:TableCell>
                            <asp:TableCell ID="_NRO_PISO_AMBIENTE" runat="server" BackColor="Black" BorderColor="Black"
                                ForeColor="White" >NRO<br /> PISO / <br />AMBIENTE</asp:TableCell>
                            <asp:TableCell ID="_FEC_CREACION_CI" runat="server" BackColor="Black" BorderColor="Black"
                                ForeColor="White" >FEC. CREACION</asp:TableCell>
                            <asp:TableCell ID="_RESPONSABLE" runat="server" BackColor="Black" BorderColor="Black"
                                ForeColor="White" >RESPONSABLE REGISTRO CI</asp:TableCell>

                        </asp:TableRow>
                    </asp:Table>
                    </td>
                    <td>
                        &nbsp;</td>
                </tr>
                <tr>
                    <td colspan="5" >
                        <asp:HiddenField ID="__pagina" runat="server" />
                        <asp:HiddenField ID="__mensaje" runat="server" />
                    </td>
                    <td >
                        &nbsp;</td>
                </tr>
                </table>
           </div>
        </div>
    </form>

    <!-- Scripts -->
    <script type="text/javascript" src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>