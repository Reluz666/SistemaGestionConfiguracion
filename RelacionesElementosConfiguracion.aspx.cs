using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.Web.Script.Serialization;

public partial class RelacionesElementosConfiguracion : System.Web.UI.Page
{
    private String Ruta = System.Configuration.ConfigurationManager.ConnectionStrings["CadenaConeccion"].ToString();
    Lista _Lista = new Lista();

    protected void Page_Load(object sender, EventArgs e)
    {
    }

    protected void Page_Init(object sender, EventArgs e)
    {
        string[] Datos = (string[])Session["__JSAR__"];

        if (Datos == null)
        {
            this.__mensaje.Value = "Ud. no esta autorizado para ingresar a esta página, inicie sesion por favor.";
            this.__pagina.Value = "CerrarSession.aspx";
            return;
        }

        bool rpta = this.VERIFICAR_PERMISO_ACCESO_PAGINA_WEB(Convert.ToInt32(Datos[0]),
        "RelacionesElementosConfiguracion.aspx");
        if (rpta == false)
        {
            this.__mensaje.Value = "Ud. no tiene permiso para ACCEDER esta pagina web.";
            this.__pagina.Value = "CerrarSession.aspx";
            return;
        }

        Cargar_Datos_Json();
    }

    private void Cargar_Datos_Json()
    {
        try
        {
            policia.clsaccesodatos servidor = new policia.clsaccesodatos();
            servidor.cadenaconexion = Ruta;

            if (servidor.abrirconexion() == true)
            {
                DataTable dt = servidor.consultar("[dbo].[pr_ListaRelacionElementosConfiguracion]",
                "", "", "", "", "", "", "", "").Tables[0];

                if (dt.Rows.Count > 0)
                {
                    List<Dictionary<string, object>> jsonList = new List<Dictionary<string, object>>();
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        Dictionary<string, object> row = new Dictionary<string, object>();
                        row["ID_RELACION"] = dt.Rows[i]["ID_RELACION"].ToString();
                        row["NOMBRE_CI"] = dt.Rows[i]["PADRE CI"].ToString();
                        row["TIPO_CI"] = dt.Rows[i]["PADRE TIPO CI"].ToString();
                        row["ESTADO_CI"] = dt.Rows[i]["PADRE ESTADO CI"].ToString();
                        row["PROPIETARIO_CI"] = dt.Rows[i]["PADRE PROPIETARIO CI"].ToString();
                        row["SEDE"] = dt.Rows[i]["PADRE SEDE"].ToString();
                        row["LOCAL"] = dt.Rows[i]["PADRE LOCAL"].ToString();
                        row["AREA"] = dt.Rows[i]["PADRE AREA"].ToString();
                        row["TIPO_RELACION"] = dt.Rows[i]["TIPO RELACION"].ToString();
                        jsonList.Add(row);
                    }

                    JavaScriptSerializer serializer = new JavaScriptSerializer();
                    datosJson.Value = serializer.Serialize(jsonList);
                }
                else
                {
                    datosJson.Value = "[]";
                }

                servidor.cerrarconexion();
            }
            else
            {
                servidor.cerrarconexion();
                datosJson.Value = "[]";
            }
        }
        catch (Exception)
        {
            datosJson.Value = "[]";
        }
    }

    public bool VERIFICAR_PERMISOS_DERECHOS_ACCESO_PAGINA_WEB(int _ID_USUARIO, string _PAGINA_WEB, string _DERECHO)
    {
        bool ok = true;
        DataTable dt;
        try
        {
            policia.clsaccesodatos servidor = new policia.clsaccesodatos();
            servidor.cadenaconexion = Ruta;
            if (servidor.abrirconexion() == true)
            {
                dt = servidor.consultar("[dbo].[pr_VERIFICAR_PERMISOS_DERECHOS_ACCESO_PAGINA_WEB]", _ID_USUARIO, _PAGINA_WEB, _DERECHO).Tables[0];
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
