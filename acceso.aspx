<%@ Page Language="C#" AutoEventWireup="true" CodeFile="acceso.aspx.cs" Inherits="acceso" UnobtrusiveValidationMode="None"%>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
      <link rel="icon" type="image/ico" href="imagenes/acceso.png" />
    <title>Acceso al Sistema</title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->


    <script type="text/javascript">
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

        function BloqueaIngresoDatos() {
            event.returnValue = false;

        }

        function SoloNumeros() {
            if ((event.keyCode < 48) || (event.keyCode > 57)) {
                event.returnValue = false;
            }
           
        }

        function SoloLetras(e) {
            if (!(event.keyCode >= 65 && event.keyCode <= 90 || event.keyCode == 32 || event.keyCode == 193 || event.keyCode == 201 || event.keyCode == 205 || event.keyCode == 209 || event.keyCode == 211 || event.keyCode == 218 || event.keyCode == 220)) {
                event.keyCode = 0;
            }
        }

        function SoloLetrasMinusculas(e) {
            if (!(event.keyCode >= 97 && event.keyCode <= 122 || event.keyCode == 32 || event.keyCode == 193 || event.keyCode == 201 || event.keyCode == 205 || event.keyCode == 209 || event.keyCode == 211 || event.keyCode == 218 || event.keyCode == 220)) {
                event.keyCode = 0;
            }
        }

        function LetrasNumeros(e) {
            if (!(event.keyCode >= 48 && event.keyCode <= 57 || event.keyCode >= 65 && event.keyCode <= 90 || event.keyCode == 32 || event.keyCode == 193 || event.keyCode == 201 || event.keyCode == 205 || event.keyCode == 209 || event.keyCode == 211 || event.keyCode == 218 || event.keyCode == 220)) {
                event.keyCode = 0;
            }
        }

        /*
        Función que permite al usuario ingrese sólo números enteros o reales.
        Parametros: e    , permite obtener el valor de la tecla prsionada.
        Punto, false sólo números enteros;true sólo números reales.
        Texto, texto que contiene el valor numerico. 
        */
        function SoloDecimales(e, Punto, Texto) {
            if (event.keyCode == 8)
                ;
            else if (event.keyCode == 46) {
                if (Punto == false)
                    event.keyCode = 0;
                else {
                    for (i = 0; i < Texto.value.length; i++) {
                        if (Texto.value.charCodeAt(i) == 46) {
                            event.keyCode = 0;
                        }
                    }
                }
            }
            else if (!(event.keyCode >= 48 && event.keyCode <= 57)) {
                event.keyCode = 0;
            }
        }

        function LimpiaImagen() {


        }


        function CambiaLetraMayuscula(Caja) {
            document.getElementById(Caja).value = document.getElementById(Caja).value.toUpperCase();
        }

     </script>

    <style type="text/css">
        .style1
        {
        }
        .style3
        {
            text-align: right;
        }
    </style>

     <style type="text/css">
#bg {
	position: fixed;
	z-index: -1;
	top: -2;
	left: 0;
	width: 100%;
}
</style>

    <script src="bootstrap/js/jquery.min.js"></script>

    <!-- Bootstrap -->
    <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet"/>
     
     <link href="Otros_css_js/w3.css" rel="stylesheet"/>

    
    <script type="text/javascript">
        function updateBackground() {
            screenWidth = $(window).width();
            screenHeight = $(window).height();
            var bg = jQuery("#bg");

            // Proporcion horizontal/vertical. En este caso la imagen es cuadrada
            ratio = 1;

            if (screenWidth / screenHeight > ratio) {
                $(bg).height("auto");
                $(bg).width("100%");
            } else {
                $(bg).width("auto");
                $(bg).height("100%");
            }

            // Si a la imagen le sobra anchura, la centramos a mano
            if ($(bg).width() > 0) {
                $(bg).css('left', (screenWidth - $(bg).width()) / 2);
            }
        }
        $(document).ready(function () {
            // Actualizamos el fondo al cargar la pagina
            updateBackground();
            $(window).bind("resize", function () {
                // Y tambien cada vez que se redimensione el navegador
                updateBackground();
            });
        });
</script>

</head>
   <body onload ="MostrarMensaje()">
        <img src="imagenes/fondo1.jpg" alt="Fondo" id="bg" />
         &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

      <div id="login-overlay" class="modal-dialog">
       
      <div class="modal-content">

          <div class="modal-header">
              <button type="button" class="close" data-dismiss="modal">
              <span aria-hidden="true"></span><span class="sr-only">Close</span></button>
                           
               <center>
                    <h2 class="modal-title" id="myModalLabel">PROCESO DE GESTIÓN DE CONFIGURACION DE SERVICIOS EN LA CORTE SUPERIOR DE JUSTICIA DE LAMBAYEQUE</h2>
               </center> 
          </div>

          <div class="modal-body">
              <div class="row">
                  <div class="col-xs-12">
                      <div class="well">
                          <form id="frmAcceso" runat="server">

                               <div class="form-group">
                               <label for="username" class="control-label">
                                   Usuario</label>
                        <asp:TextBox ID="login" runat="server"  placeholder="Ingresar Usuario"
                        autocomplete = "off" CssClass="form-control input"  onchange="CambiaLetraMayuscula('login')" 
                        onkeypress="SoloLetrasMinusculas(event)"    onKeyDown="if(event.keyCode==13) event.keyCode=9;" >GERENTE</asp:TextBox>

                    <asp:RequiredFieldValidator ID="rfvlogin" runat="server" BackColor="Yellow" 
                        ControlToValidate="login" Display="Dynamic" ErrorMessage="*" ForeColor="Red" 
                        SetFocusOnError="True" ></asp:RequiredFieldValidator>
                          </div>
                              
                              <%--<div class="form-group">
                                  <label for="username" id="login" class="control-label">Usuario</label>
                                  <input type="text" class="form-control" id="rfvlogin" name="username" value="" required="" 
                                      title="Por favor ingrese su usuario" placeholder="Ingrese Usuario"
                                      autocomplete = "off"/>                                                              
                                  <span class="help-block"></span>
                              </div>--%>

                              <div class="form-group">
                              <label for="password" class="control-label">
                               Contraseña</label>
                          <asp:TextBox ID="password" runat="server" TextMode="Password" 
                          placeholder="Ingrese Contraseña"   autocomplete = "off" CssClass="form-control input"  
                         onchange="CambiaLetraMayuscula('password')"  
                              onKeyDown="if(event.keyCode==13) event.keyCode=9;" >123</asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvpassword" runat="server" BackColor="Yellow" 
                        ControlToValidate="password" Display="Dynamic" ErrorMessage="*" ForeColor="Red" 
                        SetFocusOnError="True"></asp:RequiredFieldValidator>

                                 
                              </div>
                           
                               &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                               <asp:Button ID="Aceptar" runat="server" 
                                   Text="Ingresar" type="submit" 
                                   class="btn btn-primary btn-block" onclick="Aceptar_Click">
                             </asp:Button>
                               <asp:HiddenField ID="__mensaje" runat="server" />
                    <asp:HiddenField ID="__pagina" runat="server" />
                          </form>
                      </div>
                  </div>
                  
                
              </div>
          </div>
      </div>
  </div>

        
      
         &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        

 <div id="footer text-center">
                  <h6 style="text-align:center; color:black">

                  <b> Copyright &copy; 
                  <% 
                     
                      
                      Response.Write(DateTime.Now.ToShortDateString());
                                                    
                  %> 
                  Corte Superiro de Justicia de Lambayeque | Todos los derechos reservados.</b></h6> 
                 
            </div>
                                               

            <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
        <!-- Include all compiled plugins (below), or include individual files as needed -->
     <script src="bootstrap/js/jquery-1.12.4.min.js"></script>
     <script src="bootstrap/js/bootstrap.min.js"></script>
</body>
</html>


