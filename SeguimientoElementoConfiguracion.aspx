<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SeguimientoElementoConfiguracion.aspx.cs" Inherits="TiposElementoConfiguracion" UnobtrusiveValidationMode="None" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Seguimiento Elemento Configuracion</title>
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
        function abrir_ventana_busca_Elemento_Configuracion_Para_Seguimiento() {
            window.document.getElementById("hfID_ELEMENTO_CONFIGURACION").value = 0;
            window.document.getElementById("tbNombre_Tipo_NroSerie").value = "";
            window.document.getElementById("tbFabricante_Marca_Modelo").value = "";
            window.document.getElementById("tbEstado_Descripcion_Sede").value = "";
            window.document.getElementById("tbLocal_Ubicacion_Direccion").value = "";
            window.document.getElementById("tbArea_NroPiso_NroAmbiente").value = "";
            var options = 'channelmode=1,directories=0,fullscreen=0,location=0,menubar=0,resizable=0,titlebar=0,toolbar=0,edge=Raised,status=no,scrollbars=1,width=1500,height=700,top=50px, left=10px';
            window.open('Ventanas/ventanaElementosConfiguracionParaSeguimiento.aspx', '', options);
        }

        function abrir_ventana_busca_Relacion_CI_Con_Otros_CIS() {
            if (window.document.getElementById("hfID_ELEMENTO_CONFIGURACION").value > 0) {
                var options = 'channelmode=1,directories=0,fullscreen=0,location=0,menubar=0,resizable=0,titlebar=0,toolbar=0,edge=Raised,status=no,scrollbars=1,width=1500,height=700,top=50px, left=10px';
                window.open('Ventanas/ventanaRelacionCIConOtrosCIS.aspx?CI=' + window.document.getElementById("hfID_ELEMENTO_CONFIGURACION").value, '', options);
            } else {
                alert('Seleccione CI para buscar relacion con otros CIs');
            }
            
        }
        

        function MostrarMensaje() {
            var mensaje = document.getElementById("__mensaje").value;
            if (mensaje != "") {
                alert(mensaje);
                if (document.getElementById("__pagina").value != "")
                    location.href = document.getElementById("__pagina").value;

            }
            document.getElementById('<%= tbNombre_Tipo_NroSerie.ClientID %>').readOnly = true;
            document.getElementById('<%= tbFabricante_Marca_Modelo.ClientID %>').readOnly = true;
            document.getElementById('<%= tbEstado_Descripcion_Sede.ClientID %>').readOnly = true;
            document.getElementById('<%= tbLocal_Ubicacion_Direccion.ClientID %>').readOnly = true;
            document.getElementById('<%= tbArea_NroPiso_NroAmbiente.ClientID %>').readOnly = true;

            document.getElementById('<%= RESPONSABLE_SEGUIMIENTO.ClientID %>').readOnly = true;
            document.getElementById('<%=FECHA_SEGUIMIENTO.ClientID %>').readOnly = true;
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

        
    </script>    
    
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <style type="text/css">
        .position-static" { text-align: left;
        }
        .position-static" {
            color: #000000;
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
                                <li><a href="ProfecionOcupacion.aspx" runat="server" id="Sub_Area_aspx">Profecion - Ocupacion</a></li>                               
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
                    <td style="text-align: center; color: #FFFFFF; background-color: #000000;" colspan="2"> INGRESE DATOS SEGUIMIENTO ELEMENTO CONFIGURACION</td>
                   
                  </tr>
                  <tr>
                        <td style="text-align: left; color: #FFFFFF; background-color: #000000;" 
                            class="style2" colspan="2"> Elemento Configuracion</td>
                            
                        
                                  
                        
                                 
                        
                        </tr>
                  <tr>
                        <td style="text-align: left; color:black;" 
                             colspan="2"> 
                             <asp:Panel ID="Panel1" runat="server">
                                 <asp:TextBox ID="tbNombre_Tipo_NroSerie" runat="server" CssClass="form-control input-sm" BorderColor="White" BorderStyle="None" Font-Size="Small" Font-Bold="True" ></asp:TextBox>
                                 <asp:TextBox ID="tbFabricante_Marca_Modelo" runat="server" CssClass="form-control input-sm" BorderColor="White" Font-Bold="True"></asp:TextBox>
                                 <asp:TextBox ID="tbEstado_Descripcion_Sede" runat="server" CssClass="form-control input-sm" BorderColor="White" BorderStyle="None" Font-Bold="True"></asp:TextBox>
                                 <asp:TextBox ID="tbLocal_Ubicacion_Direccion" runat="server" CssClass="form-control input-sm" BorderColor="White" BorderStyle="None" Font-Bold="True"></asp:TextBox>
                                 <asp:TextBox ID="tbArea_NroPiso_NroAmbiente" runat="server" CssClass="form-control input-sm" BorderColor="White" BorderStyle="None" Font-Bold="True"></asp:TextBox>
                                 <asp:HiddenField ID="hfID_ELEMENTO_CONFIGURACION" runat="server" Value="0" />
                                 <asp:ImageButton ID="ibtnBUSCAR_ELEMENTOL_JCONFIGURACION" runat="server" CausesValidation="False" CssClass="btn btn-info btn-xs" ImageUrl="~/Imagnes/buscar.ico" OnClientClick="abrir_ventana_busca_Elemento_Configuracion_Para_Seguimiento();" ToolTip="Buscar Elemento de Configuracion" OnClick="ibtnBUSCAR_ELEMENTOL_JCONFIGURACION_Click" />
                                 </asp:Panel>
                        </td>
                        
       
                        
                   </tr>
                  <tr>
                        <td style="text-align: left; color: #FFFFFF; background-color: #000000;" 
                            class="style2" > 
                             Responsable Seguimiento    
                        </td> 
                        <td style="text-align: left; color: #FFFFFF; background-color: #000000;" 
                            class="style2" > 
                             Fecha Seguimiento</td>
                        
                   </tr>
                  <tr>
                        <td style="text-align: left; color: #FFFFFF; background-color: #FFFFFF;" 
                            class="style2" > 
                             <asp:TextBox ID="RESPONSABLE_SEGUIMIENTO" runat="server" CssClass="form-control input-sm" MaxLength="40" Autocomplete = "off" placeholder="Ingrese Responsable Seguimiento Elemento Configuracion" onchange="CambiaLetraMayuscula('RESPONSABLE_SEGUIMIENTO')" 
                        onkeypress="SoloLetrasMinusculas()" Width="500px"></asp:TextBox>
                             <asp:RequiredFieldValidator ID="rfvRESPONSABLE_SEGUIMIENTO" runat="server" ControlToValidate="RESPONSABLE_SEGUIMIENTO" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
       
                        
                                 <asp:HiddenField ID="hfID_RESPONSABLE_SEGUIMIENTO" runat="server" Value="0" />
       
                        </td>
                        <td style="text-align: left; color: #FFFFFF; background-color: #FFFFFF;" 
                            class="style2" > 

                             <asp:TextBox ID="FECHA_SEGUIMIENTO" runat="server" CssClass="form-control input-sm" MaxLength="40" Autocomplete = "off" placeholder="Ingrese Fecha Seguimiento Elemento Configuracion" onchange="CambiaLetraMayuscula('RESPONSABLE_SEGUIMIENTO')" 
                        onkeypress="SoloLetrasMinusculas()" Width="150px"></asp:TextBox>

                             <asp:RequiredFieldValidator ID="rfvRESPONSABLE_SEGUIMIENTO0" runat="server" ControlToValidate="RESPONSABLE_SEGUIMIENTO" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
       
                        
                        </td>
                   </tr>
                  <tr>
                        <td style="text-align: left; color: #FFFFFF; background-color: #000000;" 
                            class="style2" > 
                             Clasificacion Datos</td>
                        <td style="text-align: left; color: #FFFFFF; background-color: #000000;" 
                            class="style2" > 
                             Estado Actual</td>
       
                        
                   </tr>
                  <tr>
                        <td style="text-align: left; color: #FFFFFF;" 
                            class="style2" > 
                             <asp:DropDownList ID="CLASIFICACION_DATOS_CIS" runat="server" CssClass="form-control input-sm" 
                                        AppendDataBoundItems="True" Width="500px" 
                                       >
                                        <asp:ListItem Value="-1">_____SELECCIONE CLASIFICACION DATOS_____</asp:ListItem>
                                    </asp:DropDownList>
                             <asp:RequiredFieldValidator ID="rfvCLASIFICACION_DATOS_CIS" runat="server" ControlToValidate="CLASIFICACION_DATOS_CIS" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                             <asp:RegularExpressionValidator ID="revCLASIFICACION_DATOS_CIS" runat="server" BackColor="White" 
                        ControlToValidate="CLASIFICACION_DATOS_CIS" Display="Dynamic" ErrorMessage="*" ForeColor="Red" 
                        SetFocusOnError="True" ValidationExpression="[1-999]"></asp:RegularExpressionValidator>
                        </td>
                        <td rowspan="9" style="text-align: left; color: #FFFFFF;"  class="style2" >

                            <asp:CheckBoxList ID="cblEstado_Actual_CIs" runat="server" Width="550px" CssClass="form-check-input position-static&amp;quot" CellPadding="1" CellSpacing="1" Font-Size="Small" ForeColor="Black" RepeatColumns="2" RepeatDirection="Horizontal">
                                <asp:ListItem></asp:ListItem>
                                <asp:ListItem></asp:ListItem>
                                <asp:ListItem></asp:ListItem>
                                <asp:ListItem></asp:ListItem>
                                <asp:ListItem></asp:ListItem>
                                <asp:ListItem></asp:ListItem>
                                <asp:ListItem></asp:ListItem>
                                <asp:ListItem></asp:ListItem>
                                <asp:ListItem></asp:ListItem>
                                <asp:ListItem></asp:ListItem>
                            </asp:CheckBoxList>

                        </td>
       
                        
                   </tr>
                  <tr>
                        <td style="text-align: left; color: #FFFFFF; background-color: #000000;" 
                            class="style2" > 
                             Relacion con otros CIs</td>
                        
                   </tr>
                  <tr>
                        <td style="text-align: left; color: #FFFFFF;" 
                            class="style2" > 
                                 <asp:ImageButton ID="ibtnBUSCAR_RELACION_CI_OTROS_CIS" runat="server" CausesValidation="False" CssClass="btn btn-info btn-xs" ImageUrl="~/Imagnes/buscar.ico" OnClientClick="abrir_ventana_busca_Relacion_CI_Con_Otros_CIS();" ToolTip="Visualizar Elemento de Configuracion Relacionados con otros Elementos de Configuracion" OnClick="ibtnBUSCAR_ELEMENTOL_JCONFIGURACION_Click" />
                             <asp:CheckBox ID="RELACION_OTROS_CIS" runat="server" CssClass="form-check-input position-static&quot" ForeColor="Black" Text="SI / NO" />
                             <br />
                        </td>
                        
       
                        
                   </tr>
                  <tr>
                        <td style="text-align: left; color: #FFFFFF; background-color: #000000;" 
                            class="style2"> 
                             Cumple con Politicas de Gestion de Configuracion de la Organizacion                    
       
                        
                   </tr>
                  <tr>
                        <td style="text-align: left; color: #FFFFFF;" 
                            class="style2" > 
                             <asp:CheckBox ID="CUMPLE_POLITICAS_GESTION_CONFIGURACION_ORGANIZACION" runat="server" CssClass="form-check-input position-static&quot" ForeColor="Black" Text="SI / NO" />
                        </td>
                        
       
                        
                   </tr>
                  <tr>
                        <td style="text-align: left; color: #FFFFFF; background-color: #000000;" 
                            class="style2" > 
                             Observacion</td>
                        
       
                        
                   </tr>
                  <tr>
                        <td style="text-align: left; color: #FFFFFF;" 
                            class="style2" > 
                             <asp:TextBox ID="OBSERVACION_SEGUIMIENTO" runat="server" CssClass="form-control input-sm" MaxLength="25" Autocomplete = "off" placeholder="Ingrese Observacion Seguimiento Elemento Configuracion" onchange="CambiaLetraMayuscula('OBSERVACION_SEGUIMIENTO')" 
                        onkeypress="" Font-Size="Small" ForeColor="#3366FF" Height="100px" TextMode="MultiLine" Width="500px"></asp:TextBox>
                             <asp:RequiredFieldValidator ID="rfvOBSERVACION_SEGUIMIENTO" runat="server" ControlToValidate="RESPONSABLE_SEGUIMIENTO" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
       
                        
                        </td>
                        
       
                        
                   </tr>
                 
                 
                  <tr>
                        <td style="text-align: left; color: #FFFFFF;" 
                            class="style2" > 
                    <asp:HiddenField ID="__mensaje" runat="server" />
                    <asp:HiddenField ID="__pagina" runat="server" />
                    <asp:HiddenField ID="ID_SEGUIMIENTO" runat="server" Value="-1" 
                        EnableViewState="False" />
                    <asp:HiddenField ID="_operacion" runat="server" Value="N" 
                        EnableViewState="False" />
                        </td>
                        
       
                        
                   </tr>
                 
                 
                  <tr>
                        <td style="text-align: center; color: #FFFFFF;" 
                            class="style2"  colspan="2"> 
                   <asp:Button ID="btnRegistrar" runat="server" 
                       style="font-family: Calibri; color: #000000; font-size: medium" 
                        Text="Aceptar" 
                        onclientclick="return Confirmar('¿Desea guardar datos seguimiento elemento configuracion?');" 
                        CssClass="btn btn-success" OnClick="btnRegistrar_Click" />
                            <asp:Button ID="btnCancelar" runat="server" class="btn btn-primary" 
                        style="font-family: Calibri;  font-size: medium" Text="Cancelar" CausesValidation="False" OnClick="btnCancelar_Click" 
                         />
                        </td>
                        
       
                        
                   </tr>
                 
                 
                 </thead>
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
