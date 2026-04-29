<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Local.aspx.cs" Inherits="TiposElementoConfiguracion" UnobtrusiveValidationMode="None" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Local</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>    
    <meta charset="utf-8"/>    
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>

    <!-- Bootstrap -->
    <link href="../bootstrap/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="CssJs/Menu.css" rel="stylesheet" />

    <script  src="../Otros_css_js/resaltar.js" type="text/javascript"></script>
    <link rel="stylesheet" href="../Otros_css_js/estilo.css" type="text/css" />

     <style>
        .dropdown-submenu {
            position: relative;
        }

            .dropdown-submenu > .dropdown-menu {
                top: 0;
                left: 100%;
                margin-top: -6px;
                margin-left: -2px;
            }

            .dropdown-submenu:hover > .dropdown-menu {
                display: block;
            }

            .dropdown-submenu > a:after {
                content: "";
                margin-top: 6px;
                margin-right: -10px;
                float: right;
                border-left: 4px solid;
                border-top: 4px solid transparent;
                border-bottom: 4px solid transparent;
            }
    </style>

    <script lang="javascript" type="text/javascript">

        function abrir_ventana_busca_Ubicacion_Geografica() {
            window.document.getElementById("hfCodigo_Ubicacion_Geografica").value = 0;
            window.document.getElementById("Ubicacion_Geografica").value = "";
            var options = 'channelmode=1,directories=0,fullscreen=0,location=0,menubar=0,resizable=0,titlebar=0,toolbar=0,edge=Raised,status=no,scrollbars=1,width=1400,height=550,top=50px, left=140px';
            window.open('Ventanas/ventanaUbigeo.aspx', '', options);
        }

        function MostrarMensaje() {
            var mensaje = document.getElementById("__mensaje").value;
            if (mensaje != "") {
                alert(mensaje);
                if (document.getElementById("__pagina").value != "")
                    location.href = document.getElementById("__pagina").value;

            }

            document.getElementById('<%= Ubicacion_Geografica.ClientID %>').readOnly = true;

        }

        function window_load() {
            MostrarMensaje()
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

        function SoloLetrasMinusculas() {
            if (!((event.keyCode >= 97 && event.keyCode <= 122) || event.keyCode == 32 || event.keyCode == 193 || event.keyCode == 201 || event.keyCode == 205 || event.keyCode == 209 || event.keyCode == 211 || event.keyCode == 218 || event.keyCode == 220 || event.keyCode == 241)) {
                event.returnValue = false;
            }
        }

        function CambiaLetraMayuscula(Caja) {
            document.getElementById(Caja).value = document.getElementById(Caja).value.toUpperCase();
        }

        function Activa(Opcion) {
            if (Opcion==1){
            document.getElementById("nl").value = ""
            if (document.getElementById('cbnl').checked == true) {
                document.getElementById("nl").disabled = ""               
            } else {
                document.getElementById("nl").disabled = "disabled"                
            }
            document.getElementById("nl").focus()
            } else if (Opcion == 2) {
                if (document.getElementById('cbs').checked == true) {
                    document.getElementById("ddls").disabled = ""
                } else {
                    document.getElementById("ddls").disabled = "disabled"
                }
             
            }

        }
    </script>    
    
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <style type="text/css">
        .position-static" {
            text-align: left;
        }
    </style>
</head>
<body onload ="MostrarMensaje()"> 

 <nav class="navbar navbar-custom navbar-fixed-top" role="navigation">
        <!-- El logotipo y el icono que despliega el menú se agrupan
       para mostrarlos mejor en los dispositivos móviles -->
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse"
                data-target=".navbar-ex1-collapse">
                <span class="sr-only">Desplegar navegación</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="../menu.aspx"><span class="glyphicon glyphicon-home"></span>&nbsp;Inicio</a>
            <%--<a class="navbar-brand" href="menu.aspx"><span><img src="imagenes/001-home.png" /></span>  Inicio</a>--%>
        </div>


        <!-- -->
        <!-- Agrupar los enlaces de navegación, los formularios y cualquier
       otro elemento que se pueda ocultar al minimizar la barra -->
        <div class="collapse navbar-collapse navbar-ex1-collapse">
            <ul class="nav navbar-nav">
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown"><span class="glyphicon glyphicon-briefcase"></span>&nbsp;Mantenimiento <b class="caret"></b>
                    </a>
                    <ul class="dropdown-menu">
                        <li><a href="Personal.aspx" runat="server" id="trabajadores_aspx">Personal</a></li>
                        <li class="dropdown-submenu">
                            <a href="#">Tablas Institucion</a>
                            <ul class="dropdown-menu">
                                <li><a href="Sede.aspx" runat="server" id="a4">Sede</a></li>
                                <li><a href="Local.aspx" runat="server" id="A5">Local</a></li>
                                <li><a href="Area.aspx" runat="server" id="A6">Area</a></li>
                                <li><a href="Dependencia.aspx" runat="server" id="A8">Dependencia</a></li>
                            </ul>
                        </li>
                        <li class="dropdown-submenu">
                            <a href="#">Tablas Personal</a>
                            <ul class="dropdown-menu">
                                <li><a href="Cargo.aspx" runat="server" id="area_trabajo_aspx">Cargo</a></li>
                                <li><a href="ProfecionOcupacion.aspx" runat="server" id="Sub_Area_aspx">Profesion - Ocupacion</a></li>                               
                            </ul>
                        </li>
                        <li class="divider"></li>
                        <li class="dropdown-submenu">
                            <a href="#">Tablas Elemento Configuracion/a>
                            <ul class="dropdown-menu">
                                <li><a href="Modelo.aspx" runat="server" id="A14">Modelo</a></li>
                                <li><a href="Marca.aspx" runat="server" id="A13">Marca</a></li>
                                <li><a href="DescripcionElementoConfiguracion.aspx" runat="server" id="A9">Descripci&oacute;n Elemento Configuraci&oacute;n</a></li>
                                <li><a href="TiposElementoConfiguracion.aspx" runat="server" id="A10">Tipos Elemento Configuraci&oacute;n</a></li> 
                                <li><a href="TipoRelacionElementoConfiguracion.aspx" runat="server" id="A11">Tipo Relaci&oacute;n Elemento Configuraci&oacute;n</a></li>
                                <li><a href="TipoComponeneteCI.aspx" runat="server" id="A12">Tipo Componenete Elemento Configuraci&oacute;n</a></li> 
                                <li><a href="EstadoActualCI.aspx" runat="server" id="A15">Estado Actual Elemento Configuraci&oacute;n</a></li>                                                                                                                             
                            </ul>
                        </li>
                    </ul>
                </li>
            </ul>


            <ul class="nav navbar-nav">
                <!--<li class="active"><a href="#">Enlace #1</a></li>
                <li><a href="#">Enlace #2</a></li>-->
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" style="color: white"><span class="glyphicon glyphicon-user"></span>&nbsp;Gesti&oacute;n de Configuraci&oacute;n <b class="caret"></b>
                    </a>
                    <ul class="dropdown-menu">
                        
                        <li><a href="ElementosConfiguracion.aspx" runat="server" id="ElementosConfiguracion_aspx">Elementos de Configuracio&oacute;n</a></li>
                        <li><a href="RelacionesElementosConfiguracion.aspx" runat="server" id="PrendaMovimientos_aspx">Relacio&oacute;n de Elementos de Configuracio&oacute;n</a></li>
                        <li class="divider"></li>
                        <li><a href="CIsAsignarComponenetes.aspx" runat="server" id="A3">Asignar Componentes Elementos de Configuraci&oacute;n</a></li>
                        <li class="divider"></li>
                        <li><a href="LicenciasElementoConfiguracion.aspx" runat="server" id="A1">Licencias de Elementos de Configuraci&oacute;n</a></li>
                        <li class="divider"></li>
                        <li><a href="SeguimientosElementoConfiguracion.aspx" runat="server" id="_Asistencias_aspx">Seguimiento de Elementos de Configuraci&oacute;n</a></li>                        
                    </ul>
                </li>
            </ul>

            <ul class="nav navbar-nav">
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown"><span class="glyphicon glyphicon-file"></span>&nbsp;Reportes <b class="caret"></b>
                    </a>
                    <ul class="dropdown-menu">
                        <li><a href="../Reportes/ReporteElementosConfiguracion.aspx" runat="server" id="A16">Reporte de Elementos de Configuraci&oacute;n</a></li>
                        <li><a href="../Reportes/ReporteRelacionesElementosConfiguracion.aspx" runat="server" id="A17">Reporte de Relaciones de Elementos de Configuraci&oacute;n</a></li>
                        <li><a href="../Reportes/ReporteSeguimientosElementoConfiguracion.aspx" runat="server" id="A18">Reporte de Seguimientos de Elementos de Configuraci&oacute;n</a></li>
                        <li><a href="../Reportes/ReporteLicenciasElementoConfiguracion.aspx" runat="server" id="A19">Reporte de Licencias de Elementos de Configuraci&oacute;n</a></li>
                        <li><a href="../Reportes/ReporteCIsSeguidos.aspx" runat="server" id="A24">Reporte de Elementos de Configuraci&oacute;n Seguidos</a></li>
                        <li><a href="../Reportes/ReporteComponentesAsignados.aspx" runat="server" id="A20">Reporte de Componentes de Elementos de Configuraci&oacute;n Asignados</a></li>
                        <li class="divider"></li>
                        
                        <li><a href="../Reportes/ReporteDatosCorrectosCI.aspx" runat="server" id="A21">Reporte de Datos Correctos de Elementos de Configuraci&oacute;n</a></li>
                        <li><a href="../Reportes/ReporteDatosIncorrectosCI .aspx" runat="server" id="A22">Reporte de Datos Incorrectos de Elementos de Configuraci&oacute;n</a></li>
                        <li><a href="../Reportes/ReporteCIsInformacionContenidaEnCMDB .aspx" runat="server" id="A23">Reporte de Informaci&oacute;n de Elementos de Configuraci&oacute;n Contenidas en la CMDB</a></li>
                             
                        
                    </ul>
                </li>
            </ul>


            <ul class="nav navbar-nav">

                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" style="color: black"><span class="glyphicon glyphicon-wrench"></span>&nbsp;Configuraciones <b class="caret"></b>
                    </a>
                    <ul class="dropdown-menu">
                        <li><a href="Usuario.aspx" runat="server" id="usuarios_aspx">Usuarios</a></li>
                        <li><a href="../Configuracion/Usuarios.aspx" runat="server" id="permisos_aspx">Permisos</a></li>
                        <li class="divider"></li>
                        <li><a href="CerrarSession.aspx" style="text-align: left; color: red;">Cerrar Sesion</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </nav>

    <%--  ......NO CAMBIAR.........  --%>
    <div class="section">
        <div class="container">
            <div class="row main-low-margin">
                <div class="col-md-10 col-md-offset-1 col-sm-10 col-sm-offset-1">
                    <h3>-</h3>
                </div>
            </div>
        </div>
    </div>

    <form id="form1" runat="server">

    <div class ="container">
         <div class="table-responsive" >
             <table class="table text-center" >
                <thead>                       
                  <tr>
                    <td style="text-align: center; color: #FFFFFF; background-color: #000000;" colspan="3"> INGRESE DATOS LOCAL JUDICIAL</td>
                   
                  </tr>
                  <tr>
                        <td style="text-align: left; color: #FFFFFF; background-color: #000000;" 
                            class="style2" colspan="3"> Codigo</td>
                            
                        
                                  
                        
                                 
                        
                        </tr>
                  <tr>
                        <td style="text-align: left;" 
                            class="style2" colspan="3"> 
                             <asp:TextBox ID="Codigo_Local" runat="server" CssClass="form-control input-sm" MaxLength="6" Autocomplete = "off" placeholder="Ingrese Codigo Local Judicial" onchange="" 
                        onkeypress="SoloNumeros()"></asp:TextBox>
                             <asp:RequiredFieldValidator ID="rfvCodigo_Local" runat="server" ControlToValidate="Codigo_Local" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </td>
                        
       
                        
                   </tr>
                  <tr>
                        <td style="text-align: left; color: #FFFFFF; background-color: #000000;" 
                            class="style2" colspan="3"> 
                             Nombre</td>
                        
       
                        
                   </tr>
                  <tr>
                        <td style="text-align: left; color: #FFFFFF;" 
                            class="style2" colspan="3"> 
                             <asp:TextBox ID="Nombre_Local" runat="server" CssClass="form-control input-sm" MaxLength="50" Autocomplete = "off" placeholder="Ingrese Nombre Local Judicial" onchange="CambiaLetraMayuscula('Nombre_Local')" 
                        onkeypress="SoloLetrasMinusculas()"></asp:TextBox>
                             <asp:RequiredFieldValidator ID="rfvNombre_Local" runat="server" ControlToValidate="Nombre_Local" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </td>
                        
       
                        
                   </tr>
                  <tr>
                        <td style="text-align: left; color: #FFFFFF; background-color: #000000;" 
                            class="style2" colspan="3"> 
                             Direccion</td>
                        
       
                        
                   </tr>
                  <tr>
                        <td style="text-align: left; color: #FFFFFF;" 
                            class="style2" colspan="3"> 
                             <asp:TextBox ID="Direccion_Local" runat="server" CssClass="form-control input-sm" MaxLength="50" Autocomplete = "off" placeholder="Ingrese Dicreccion Local Judicial" onchange="CambiaLetraMayuscula('Direccion_Local')" 
                        onkeypress="SoloLetrasMinusculas()"></asp:TextBox>
                             <asp:RequiredFieldValidator ID="rfvDireccion_Local" runat="server" ControlToValidate="Direccion_Local" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </td>
                        
       
                        
                   </tr>
                  <tr>
                        <td style="text-align: left; color: #FFFFFF; background-color: #000000;" 
                            class="style2" colspan="3"> 
                             Sede</td>
                        
       
                        
                   </tr>
                  <tr>
                        <td style="text-align: left; color: #FFFFFF;" 
                            class="style2" colspan="3"> 
                             <asp:DropDownList ID="Sede" runat="server" CssClass="form-control input-sm" 
                                        AppendDataBoundItems="True" 
                                       >
                                        <asp:ListItem Value="-1">_____SELECCIONE SEDE_____</asp:ListItem>
                                    </asp:DropDownList>
                             <asp:RequiredFieldValidator ID="rfvSede" runat="server" ControlToValidate="Sede" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                             <asp:RegularExpressionValidator ID="revSede" runat="server" BackColor="White" 
                        ControlToValidate="Sede" Display="Dynamic" ErrorMessage="*" ForeColor="Red" 
                        SetFocusOnError="True" ValidationExpression="[1-999]"></asp:RegularExpressionValidator>
                        </td>
                        
       
                        
                   </tr>
                  <tr>
                        <td style="text-align: left; color: #FFFFFF; background-color: #000000;" 
                            class="style2" colspan="3"> 
                             Ubicacion Geografica</td>
                        
       
                        
                   </tr>
                  <tr>
                        <td style="text-align: left; color: #FFFFFF;" 
                            class="style2" colspan="3"> 
                             <asp:TextBox ID="Ubicacion_Geografica" runat="server" CssClass="form-control input-sm" MaxLength="25" Autocomplete = "off" placeholder="Ingrese Ubicacion Geografica Local Judicial" onchange="CambiaLetraMayuscula('NOMBRE_CARGO')" 
                        onkeypress="SoloLetrasMinusculas()"></asp:TextBox>
                             <asp:RequiredFieldValidator ID="rfvUbicacion_Geografica" runat="server" ControlToValidate="Ubicacion_Geografica" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                             <asp:ImageButton ID="ibtnBUSCAR_PROPIETARIO" runat="server" CausesValidation="False" CssClass="btn btn-info btn-xs" ImageUrl="~/Imagnes/buscar.ico" ToolTip="Buscar Propietario" OnClientClick="abrir_ventana_busca_Ubicacion_Geografica();" />
                             <asp:HiddenField ID="hfCodigo_Ubicacion_Geografica" runat="server" Value="0" />
                        </td>
                        
       
                        
                   </tr>
                  <tr>
                        <td style="text-align: left; color: #FFFFFF; background-color: #000000;" 
                            class="style2" colspan="3"> 
                             Telefono</td>
                        
       
                        
                   </tr>
                  <tr>
                        <td style="text-align: left; color: #FFFFFF; background-color: #FFFFFF;" 
                            class="style2" colspan="3"> 
                             <asp:TextBox ID="Telefono_local" runat="server" CssClass="form-control input-sm" MaxLength="50" Autocomplete = "off" placeholder="Ingrese Telefono" onchange="" 
                        onkeypress="SoloNumeros()"></asp:TextBox>
                             <asp:RequiredFieldValidator ID="rfvTelefono_local" runat="server" ControlToValidate="Telefono_local" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </td>
                        
       
                        
                   </tr>
                  <tr>
                        <td style="text-align: left; color: #FFFFFF; background-color: #000000;" 
                            class="style2" colspan="3"> 
                             Pagiina Web</td>
                        
       
                        
                   </tr>
                  <tr>
                        <td style="text-align: left; color: #FFFFFF; background-color: #FFFFFF;" 
                            class="style2" colspan="3"> 
                             <asp:TextBox ID="Pagnia_Web_Local" runat="server" CssClass="form-control input-sm" MaxLength="50" Autocomplete = "off" placeholder="Ingrese Pagiina Web" onchange="" 
                        onkeypress=""></asp:TextBox>
                             <asp:RequiredFieldValidator ID="rfvPagnia_Web_Local" runat="server" ControlToValidate="Pagnia_Web_Local" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                             <asp:RegularExpressionValidator ID="revPagnia_Web_Local" runat="server" ControlToValidate="Pagnia_Web_Local" ErrorMessage="Direccion Pagina Web Incorrecta" ForeColor="Red" ValidationExpression="(http|http(s)?://)?([\w-]+\.)+[\w-]+[.com|.in|.org]+(\?[\&amp;=]*)?"></asp:RegularExpressionValidator>
                        </td>
                        
       
                        
                   </tr>
                  <tr>
                        <td style="text-align: left; color: #FFFFFF; background-color: #000000;" 
                            class="style2" colspan="3"> 
                             Email</td>
                        
       
                        
                   </tr>
                  <tr>
                        <td style="text-align: left; color: #FFFFFF; background-color: #FFFFFF;" 
                            class="style2" colspan="3"> 
                             <asp:TextBox ID="Email_Local" runat="server" CssClass="form-control input-sm" MaxLength="50" Autocomplete = "off" placeholder="Ingrese Email" onchange="" 
                        onkeypress=""></asp:TextBox>
                             <asp:RequiredFieldValidator ID="rfvEmail_Local" runat="server" ControlToValidate="Email_Local" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                             <asp:RegularExpressionValidator ID="revEmail_Local" runat="server" ControlToValidate="Email_Local" ErrorMessage="Email Incorrecto" ForeColor="Red" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                        </td>
                        
       
                        
                   </tr>
                  <tr>
                        <td style="text-align: left; color: #FFFFFF; background-color: #000000;" 
                            class="style2" colspan="3"> 
                             Nro. Total de Elementos de Configuracion en Posecion</td>
                        
       
                        
                   </tr>
                  <tr>
                        <td style="text-align: left; color: #FFFFFF; background-color: #FFFFFF;" 
                            class="style2" colspan="3"> 
                             <asp:TextBox ID="Total_CIS_Local" runat="server" CssClass="form-control input-sm" MaxLength="50" Autocomplete = "off" placeholder="Ingrese Nro. Total de Elementos de Configuracion en Posecion" onchange="" 
                        onkeypress="SoloNumeros()"></asp:TextBox>
                             <asp:RequiredFieldValidator ID="rfvTotal_CIS_Local" runat="server" ControlToValidate="Total_CIS_Local" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </td>
                        
       
                        
                   </tr>
                  <tr>
                        <td style="text-align: left" 
                            class="style2">  
                             &nbsp;</td>
                         <td style="text-align: left" 
                            class="style2">  
                             &nbsp;</td>

                                  
                        
                         <td style="text-align: left" 
                            class="style2"> &nbsp;</td>
                        

                        
                   </tr>
                  <tr>
                <td colspan="3" style="text-align: center">
                   <asp:Button ID="btnRegistrar" runat="server" 
                       style="font-family: Calibri; color: #000000; font-size: medium" 
                        Text="Registrar" 
                        onclientclick="return Confirmar('¿Desea registrar Local?');" 
                        CssClass="btn btn-success" Visible="False" OnClick="btnRegistrar_Click" />
                    &nbsp;
                    <asp:Button ID="btnModificar" runat="server" 
                        style="font-family: Calibri; color: #000000; font-size: medium" 
                        Text="Modificar"  onclientclick="return Confirmar('¿Desea modificar Local?');" CssClass="btn btn-warning" Visible="False" OnClick="btnModificar_Click" />
                    &nbsp;
                    <asp:Button ID="btnEliminar" runat="server" 
                        style="font-family: Calibri; color: #000000; font-size: medium" 
                        Text="Eliminar"  onclientclick="return Confirmar('¿Desea eliminar Local?');" class="btn btn-danger" Visible="False" OnClick="btnEliminar_Click" />
                    &nbsp;
                    <asp:Button ID="btnCancelar" runat="server" class="btn btn-primary" 
                        style="font-family: Calibri;  font-size: medium" Text="Cancelar" CausesValidation="False" Visible="False" OnClick="btnCancelar_Click" 
                         />
                    </td>
            </tr>
                 </thead>
             </table>
    </div> </div>

    <div class ="container">
         <div class="table-responsive" >
             <table class="table text-center">
        <tr>
            <td style="text-align: left;"">
                            <asp:CheckBox ID="cbnl" runat="server" CssClass="form-check-input position-static&quot" Font-Size="X-Small" Text="Nombre Local" onChange="Activa(1);"/>
                        </td>
            <td style="text-align: left;"">
                            <asp:CheckBox ID="cbs" runat="server" CssClass="form-check-input position-static&quot" Font-Size="X-Small" Text="Sede" onChange="Activa(2);"/>
                        </td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td style="text-align: left;"">
                             <asp:TextBox ID="nl" runat="server" CssClass="form-control input-sm" MaxLength="50" Autocomplete = "off" placeholder="Ingrese Nombre Local Judicial a Buscar" onchange="" 
                        onkeypress="" Enabled="False"></asp:TextBox>
                        </td>
            <td>
                             <asp:DropDownList ID="ddls" runat="server" CssClass="form-control input-sm" 
                                        AppendDataBoundItems="True" Enabled="False" 
                                       onChange="Activa();">
                                        <asp:ListItem Value="-1">_____SELECCIONE SEDE_____</asp:ListItem>
                                    </asp:DropDownList>
                             </td>
            <td>
                            <asp:LinkButton ID="lbtnBuscar" runat="server" CausesValidation="False" class="btn btn-info" OnClick="lbtnBuscar_Click" Text="Buscar  &lt;span class='glyphicon glyphicon-search'&gt;&lt;/span&gt;" UseSubmitBehavior="False" />
                            <asp:Button ID="btnActualizarInformacion" runat="server" class="btn btn-success" CssClass="btn btn-warning" onclick="btnActualizarInformacion_Click" Text="Actualizar Informacion" CausesValidation="False" />
                        </td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td colspan="4">
                        
                        <asp:Table ID="Table_" runat="server" CssClass="form-control input" 
                            class="table table-hover table-condensed" BackColor="White" BorderColor="White" 
                            CellPadding="6" CellSpacing="2" Font-Size="Small" GridLines="Both" Width="100%" 
                            style="text-align: left; font-size: x-small;">
                            <asp:TableRow ID="TableRow1" runat="server">
                                <asp:TableCell ID="tcID_LOCAL"  runat="server" BackColor="Black" BorderColor="Black" 
                                    ForeColor="White" Width="7%" Visible="false">ID LOCAL</asp:TableCell>

                                <asp:TableCell ID="tcLOCAL_CODIGO"  runat="server" BackColor="Black" BorderColor="Black" 
                                    ForeColor="White"  Width="15%">LOCAL CODIGO</asp:TableCell>

                                <asp:TableCell ID="tcLOCAL_NOMBRE"  runat="server" BackColor="Black" BorderColor="Black" 
                                    ForeColor="White"  Width="15%">LOCAL NOMBRE</asp:TableCell>
                                    
                               <asp:TableCell ID="tcLOCAL_DIRECCION"  runat="server" BackColor="Black" BorderColor="Black" 
                                    ForeColor="White"  Width="15%">LOCAL DIRECCION</asp:TableCell>  
                                
                               <asp:TableCell ID="tcSEDE"  runat="server" BackColor="Black" BorderColor="Black" 
                                    ForeColor="White"  Width="15%">SEDE</asp:TableCell> 
                                    
                               <asp:TableCell ID="tcID_UBI"  runat="server" BackColor="Black" BorderColor="Black" 
                                    ForeColor="White"  Width="15%" Visible="false">ID UBI</asp:TableCell>  
                                   
                               <asp:TableCell ID="tcUBICACION_GEOGRAFICA"  runat="server" BackColor="Black" BorderColor="Black" 
                                    ForeColor="White"  Width="15%">UBICACION GEOGRAFICA</asp:TableCell>   
                                    
                               <asp:TableCell ID="tcTELEFONO"  runat="server" BackColor="Black" BorderColor="Black" 
                                    ForeColor="White"  Width="15%">TELEFONO</asp:TableCell> 
                                    
                               <asp:TableCell ID="tcPAGINA_WEB"  runat="server" BackColor="Black" BorderColor="Black" 
                                    ForeColor="White"  Width="15%">PAGINA WEB</asp:TableCell>  
                                    
                               <asp:TableCell ID="tcEMAIL"  runat="server" BackColor="Black" BorderColor="Black" 
                                    ForeColor="White"  Width="15%">EMAIL</asp:TableCell>  
                                    
                               <asp:TableCell ID="tcTOTAL_CIS"  runat="server" BackColor="Black" BorderColor="Black" 
                                    ForeColor="White"  Width="15%">TOTAL CIS</asp:TableCell>                                         

                                <asp:TableCell ID="SELECCIONAR_LOCAL" runat="server" BackColor="Black" BorderColor="Black" 
                                    ForeColor="White" Width="7%">SELECCIONAR LOCAL</asp:TableCell>

                            </asp:TableRow>
                        </asp:Table>
                        
                    </td>
            
        </tr>
       
        <tr>
            <td colspan="3">
                    <asp:HiddenField ID="__mensaje" runat="server" />
                    <asp:HiddenField ID="__pagina" runat="server" />
                    <asp:HiddenField ID="Id_Local" runat="server" Value="0" 
                        EnableViewState="False" />
                    </td>
            <td>
                    &nbsp;</td>
        </tr>
    </table>
    </div> </div>

    </form>

    <script lang ="JavaScript" type="text/javascript">
        ResaltarFila('Table_');
    </script>	

     <script type="text/javascript" src="../bootstrap/js/jquery-1.12.4.min.js"></script>
     <script type="text/javascript" src="../bootstrap/js/bootstrap.min.js"></script>
 
    </body>
</html>
