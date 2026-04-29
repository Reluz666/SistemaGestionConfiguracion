using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Drawing;

public partial class menu : System.Web.UI.Page
{
    //private String Ruta = System.Configuration.ConfigurationManager.AppSettings.Get("CadenaConeccion");
    private String Ruta = System.Configuration.ConfigurationManager.ConnectionStrings["CadenaConeccion"].ToString();

    policia.clsaccesodatos servidor = new policia.clsaccesodatos();

   protected void Page_Load(object sender, EventArgs e)
    {
        //=============================================================================================================
        //Verificamos si el usuario ha iniciado sesion.

        //this.__mensaje.Value = "";

        //this.__pagina.Value = "";

        //string[] Datos = (string[])Session["__JSAR__"];

        //if (Datos == null)
        //{
        //    this.__mensaje.Value = "Ud. no esta autorizado para ingresar a esta página, inicie sesion por favor.";

        //    this.__pagina.Value = "CerrarSession.aspx";

        //    return;
        //}

        //this.lblusurio.Text = "<b>CARGO : </b>" + Datos[9] + "<br>" + "<b>USUARIO : </b>" + Datos[1] + " " + Datos[2] + " " + Datos[3];
        ////=============================================================================================================
    }
}