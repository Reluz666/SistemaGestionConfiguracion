using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;

public partial class Personal : System.Web.UI.Page
{
    private String Ruta = System.Configuration.ConfigurationManager.ConnectionStrings["CadenaConeccion"].ToString();
    System.Data.DataTable dt;

    protected void Page_Init(object sender, EventArgs e)
    {
        this.__mensaje.Value = "";
        this.__pagina.Value = "";

        string[] Datos = (string[])Session["__JSAR__"];

        if (Datos == null)
        {
            this.__mensaje.Value = "Ud. no esta autorizado para ingresar a esta página, inicie sesion por favor.";
            this.__pagina.Value = "CerrarSession.aspx";
            return;
        }

        bool rpta = this.VERIFICAR_PERMISO_ACCESO_PAGINA_WEB(Convert.ToInt32(Datos[0]),
        "Personal.aspx");
        if (rpta == false)
        {
            this.__mensaje.Value = "Ud. no tiene permiso para ACCEDER esta pagina web.";
            this.__pagina.Value = "CerrarSession.aspx";
            return;
        }

        Cargar_Lista_Personal();
    }

    private void Cargar_Lista_Personal()
    {
        try
        {
            policia.clsaccesodatos servidor = new policia.clsaccesodatos();
            servidor.cadenaconexion = Ruta;
            if (servidor.abrirconexion() == true)
            {
                dt = servidor.consultar("[dbo].[pr_ListaPersonal]").Tables[0];
                if (dt.Rows.Count == 0)
                {
                    servidor.cerrarconexion();
                    this.datosJson.Value = "[]";
                }
                else
                {
                    var lista = new List<object>();
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        lista.Add(new {
                            ID_PERSONAL = dt.Rows[i]["ID_PERSONAL"].ToString().Trim(),
                            CODIGO = dt.Rows[i]["CODIGO"].ToString().Trim(),
                            NOMBRE = dt.Rows[i]["NOMBRE"].ToString().Trim(),
                            APELLIDO_PATERNO = dt.Rows[i]["APELLIDO PATERNO"].ToString().Trim(),
                            APELLIDO_MATERNO = dt.Rows[i]["APELLIDO MATERNO"].ToString().Trim(),
                            TIPO_DOC_IDENT = dt.Rows[i]["TIPO DOC. IDENT."].ToString().Trim(),
                            NRO_DOC_IDENT = dt.Rows[i]["NRO. DOC. IDENT."].ToString().Trim(),
                            PROFESION = dt.Rows[i]["PROFESION"].ToString().Trim(),
                            TELEFONO = dt.Rows[i]["TELEFONO"].ToString().Trim(),
                            EMAIL = dt.Rows[i]["EMAIL"].ToString().Trim(),
                            SEDE = dt.Rows[i]["SEDE"].ToString().Trim(),
                            LOCAL = dt.Rows[i]["LOCAL"].ToString().Trim(),
                            AREA = dt.Rows[i]["AREA"].ToString().Trim(),
                            DEPENDENCIA = dt.Rows[i]["DEPENDENCIA"].ToString().Trim(),
                            CARGO = dt.Rows[i]["CARGO"].ToString().Trim(),
                            ESTADO = dt.Rows[i]["ESTADO"].ToString().Trim()
                        });
                    }
                    JavaScriptSerializer serializer = new JavaScriptSerializer();
                    this.datosJson.Value = serializer.Serialize(lista);
                    servidor.cerrarconexion();
                }
            }
            else
            {
                servidor.cerrarconexion();
                this.__mensaje.Value = servidor.getMensageError();
                this.__pagina.Value = "CerrarSession.aspx";
            }
        }
        catch (Exception)
        {
            this.__mensaje.Value = "Error inesperado al intentar conectarnos con el servidor.";
            this.__pagina.Value = "CerrarSession.aspx";
        }
    }

    public bool VERIFICAR_PERMISO_ACCESO_PAGINA_WEB(int _ID_USUARIO, string _PAGINA_WEB)
    {
        bool ok = true;
        DataTable dt;
        try
        {
            policia.clsaccesodatos servidor = new policia.clsaccesodatos();
            servidor.cadenaconexion = Ruta;
            if (servidor.abrirconexion() == true)
            {
                dt = servidor.consultar("[dbo].[pr_VERIFICAR_PERMISO_ACCESO_PAGINA_WEB]", _ID_USUARIO, _PAGINA_WEB).Tables[0];
                if (dt.Rows.Count == 0)
                {
                    dt = null;
                    ok = false;
                    servidor.cerrarconexion();
                }
                else
                {
                    ok = Convert.ToBoolean(dt.Rows[0].ItemArray[0].ToString());
                    servidor.cerrarconexion();
                }
            }
            else
            {
                ok = false;
                servidor.cerrarconexion();
                this.__mensaje.Value = servidor.getMensageError();
                this.__pagina.Value = "";
            }
        }
        catch (Exception)
        {
            ok = false;
            this.__mensaje.Value = "Error inesperado al intentar conectarnos con el servidor.";
            this.__pagina.Value = "";
        }
        return ok;
    }
}
