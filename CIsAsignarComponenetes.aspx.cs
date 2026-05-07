using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class CIsAsignarComponenetes : System.Web.UI.Page
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
            return;
        }

        bool rpta = this.VERIFICAR_PERMISO_ACCESO_PAGINA_WEB(Convert.ToInt32(Datos[0]),
        "CIsAsignarComponenetes.aspx");
        if (rpta == false)
        {
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
                DataTable dt = servidor.consultar("[dbo].[pr_ListaElementosConfiguracionAsignarComponenetes]",
                    "", "", "", "", "", "", "", "", "", "", "").Tables[0];

                if (dt.Rows.Count == 0)
                {
                    datosJson.Value = "[]";
                    servidor.cerrarconexion();
                }
                else
                {
                    System.Text.StringBuilder sb = new System.Text.StringBuilder();
                    sb.Append("[");
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        if (i > 0) sb.Append(",");
                        sb.Append("{");
                        sb.Append("\"ID_CI\":\"" + System.Web.HttpUtility.HtmlEncode(dt.Rows[i]["ID CI"].ToString()) + "\",");
                        sb.Append("\"NOMBRE_CI\":\"" + System.Web.HttpUtility.HtmlEncode(dt.Rows[i]["NOMBRE CI"].ToString()) + "\",");
                        sb.Append("\"NOMBRE_TIPO_CI\":\"" + System.Web.HttpUtility.HtmlEncode(dt.Rows[i]["NOMBRE TIPO CI"].ToString()) + "\",");
                        sb.Append("\"NRO_SERIE\":\"" + System.Web.HttpUtility.HtmlEncode(dt.Rows[i]["NRO SERIE"].ToString()) + "\",");
                        sb.Append("\"MARCA\":\"" + System.Web.HttpUtility.HtmlEncode(dt.Rows[i]["MARCA"].ToString()) + "\",");
                        sb.Append("\"MODELO\":\"" + System.Web.HttpUtility.HtmlEncode(dt.Rows[i]["MODELO"].ToString()) + "\",");
                        sb.Append("\"ESTADO_CI\":\"" + System.Web.HttpUtility.HtmlEncode(dt.Rows[i]["ESTADO CI"].ToString()) + "\",");
                        sb.Append("\"DESCRIPCION_CI\":\"" + System.Web.HttpUtility.HtmlEncode(dt.Rows[i]["DESCRIPCION CI"].ToString()) + "\",");
                        sb.Append("\"SEDE\":\"" + System.Web.HttpUtility.HtmlEncode(dt.Rows[i]["SEDE"].ToString()) + "\",");
                        sb.Append("\"LOCAL\":\"" + System.Web.HttpUtility.HtmlEncode(dt.Rows[i]["LOCAL"].ToString()) + "\",");
                        sb.Append("\"AREA\":\"" + System.Web.HttpUtility.HtmlEncode(dt.Rows[i]["AREA"].ToString()) + "\"");
                        sb.Append("}");
                    }
                    sb.Append("]");
                    datosJson.Value = sb.ToString();
                    servidor.cerrarconexion();
                }
            }
            else
            {
                datosJson.Value = "[]";
                servidor.cerrarconexion();
            }
        }
        catch (Exception)
        {
            datosJson.Value = "[]";
        }
    }

    private void Cargar_Datos(System.Web.UI.WebControls.DropDownList ddl, String Procedimeinto_Almacenado, String Mensaje, params Object[] p)
    {
        try
        {
            policia.clsaccesodatos servidor = new policia.clsaccesodatos();
            servidor.cadenaconexion = Ruta;
            if (servidor.abrirconexion() == true)
            {
                System.Data.DataTable dt;
                if (p.Length == 0)
                {
                    dt = servidor.consultar(Procedimeinto_Almacenado).Tables[0];
                }
                else
                {
                    dt = servidor.consultar(Procedimeinto_Almacenado, Convert.ToInt32(p[0])).Tables[0];
                }
                if (dt.Rows.Count == 0)
                {
                    servidor.cerrarconexion();
                }
                else
                {
                    ddl.DataSource = dt;
                    ddl.DataTextField = "NOMBRE";
                    ddl.DataValueField = "CODIGO";
                    ddl.DataBind();
                    servidor.cerrarconexion();
                }
            }
            else
            {
                servidor.cerrarconexion();
            }
        }
        catch (Exception)
        {
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
            }
        }
        catch (Exception)
        {
            ok = false;
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
            }
        }
        catch (Exception)
        {
            ok = false;
        }
        return ok;
    }
}