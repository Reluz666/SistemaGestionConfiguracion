using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using SEGURIDAD;
using Servicios;

public partial class acceso : System.Web.UI.Page
{
    //private String Ruta = "SERVER=JOSE-PC;DATABASE=GCS;Encrypt=False;INTEGRATED SECURITY=True;packet size=4096;";
    private String Ruta = System.Configuration.ConfigurationManager.ConnectionStrings["CadenaConeccion"].ToString();


    protected void Page_Init(object sender, EventArgs e)
    {
       
        this.login.Focus();
    }

    protected void Aceptar_Click(object sender, EventArgs e)
    {
        encriptar en = new encriptar();        
        String strLogin, strPassword;
        strLogin = this.login.Text.Trim();
        strPassword = this.password.Text.Trim();
        try
        {
            policia.clsaccesodatos servidor = new policia.clsaccesodatos();

            servidor.cadenaconexion = Ruta;
            if (servidor.abrirconexiontrans() == true)
            {
                DataTable dt = servidor.consultar("[dbo].[pr_Verificar_Acceso_Sistema_Personal]",
                                    strLogin,
                                    en.EncriptarCadena(strPassword)).Tables[0];
                if (dt.Rows.Count == 0)
                {
                    servidor.cerrarconexion();

                    this.__mensaje.Value = "Login o password ingresado son incorrectos o se encuentra inhabilitado....";
                    this.__pagina.Value = "";
                }
                else
                {
                    Session["__JSAR__"] = new string[] {        dt.Rows[0].ItemArray[0].ToString(),
                                                                 dt.Rows[0].ItemArray[1].ToString(),
                                                                 dt.Rows[0].ItemArray[2].ToString(),
                                                                 dt.Rows[0].ItemArray[3].ToString(),
                                                                 dt.Rows[0].ItemArray[4].ToString(),
                                                                 dt.Rows[0].ItemArray[5].ToString(),
                                                                 dt.Rows[0].ItemArray[6].ToString(),
                                                                 strPassword,                                                                
                                                                 dt.Rows[0].ItemArray[8].ToString(),
                                                                 dt.Rows[0].ItemArray[9].ToString(),
                                                                 dt.Rows[0].ItemArray[10].ToString(),
                                                                 dt.Rows[0].ItemArray[11].ToString(),
                                                                 dt.Rows[0].ItemArray[12].ToString(),
                                                                 dt.Rows[0].ItemArray[13].ToString(),
                                                                 dt.Rows[0].ItemArray[14].ToString(),
                                                                 dt.Rows[0].ItemArray[15].ToString(),
                                                                 dt.Rows[0].ItemArray[16].ToString(),
                                                                  dt.Rows[0].ItemArray[17].ToString()
                                                                 };

                    Response.Clear();
                    Response.Redirect("Dashboard.aspx");
                    Response.Flush();
                }
            }
            else
            {
                servidor.cerrarconexion();
                this.__mensaje.Value = servidor.getMensageError();
                this.__pagina.Value = "";
            }
        }
        catch (Exception)
        {

            this.__mensaje.Value = "Error inesperado al intentar conectarnos con el servidor.";
            this.__pagina.Value = "";
        }
    }

    //protected void login_TextChanged(object sender, EventArgs e)
    //{
    // //login.Attributes.Add("onkeydown", "if(event.which || event.keyCode){if ((event.which == 13) || (event.keyCode == 13)) {document.getElementById('" + Button1.UniqueID + "').click();return false;}} else {return true}; ");
    //    login.Attributes.Add("onkeydown", "if(event.which || event.keyCode){if ((event.which == 13) || (event.keyCode == 13)) ");
    //}

    //protected void password_TextChanged(object sender, EventArgs e)
    //{
    //    password.Attributes.Add("onkeydown", "if(event.which || event.keyCode){if ((event.which == 13) || (event.keyCode == 13)) ");
    //    this.Aceptar.Focus();
    //}

    //protected void Button1_Click1(object sender, EventArgs e)
    //{
    //    // MsgBox("test");
    //}

//        <authentication mode="Forms"> 
//   <forms loginUrl="acceso.aspx" 
//          protection="All" 
//          timeout="1" 
//          name="AppNameCookie" 
//          path="/FormsAuth" 
//          requireSSL="false" 
//          slidingExpiration="true" 
//          defaultUrl="default.aspx" 
//          cookieless="UseCookies" 
//          enableCrossAppRedirects="false" /> 
//</authentication>

   
}
