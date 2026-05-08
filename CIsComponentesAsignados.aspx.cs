using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class CIsComponentesAsignados : System.Web.UI.Page
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
        "CIsComponentesAsignados.aspx");
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
                DataTable dt = servidor.consultar("[dbo].[pr_ListaElementosConfiguracionComponenetesAsignados]",
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

    protected void cbnci_CheckedChanged(object sender, EventArgs e)
    {
        txtnci.Enabled = cbnci.Checked;
        if (!cbnci.Checked) txtnci.Text = "";
        txtnci.Focus();
    }

    protected void cbtci_CheckedChanged(object sender, EventArgs e)
    {
        ddltci.Enabled = cbtci.Checked;
        if (!cbtci.Checked) ddltci.SelectedIndex = -1;
        ddltci.Focus();
    }

    protected void cbeci_CheckedChanged(object sender, EventArgs e)
    {
        ddleci.Enabled = cbeci.Checked;
        if (!cbeci.Checked) ddleci.SelectedIndex = -1;
        ddleci.Focus();
    }

    protected void cbdci_CheckedChanged(object sender, EventArgs e)
    {
        ddldci.Enabled = cbdci.Checked;
        if (!cbdci.Checked) ddldci.SelectedIndex = -1;
        ddldci.Focus();
    }

    protected void cbns_CheckedChanged(object sender, EventArgs e)
    {
        txtns.Enabled = cbns.Checked;
        if (!cbns.Checked) txtns.Text = "";
        txtns.Focus();
    }

    protected void cbm_CheckedChanged(object sender, EventArgs e)
    {
        ddlm.Enabled = cbm.Checked;
        if (!cbm.Checked) ddlm.SelectedIndex = -1;
        ddlm.Focus();
    }

    protected void cbs_CheckedChanged(object sender, EventArgs e)
    {
        ddls.Enabled = cbs.Checked;
        if (!cbs.Checked) ddls.SelectedIndex = -1;
        ddls.Focus();
    }

    protected void cbl_CheckedChanged(object sender, EventArgs e)
    {
        ddll.Enabled = cbl.Checked;
        if (!cbl.Checked) ddll.SelectedIndex = -1;
        ddll.Focus();
    }

    protected void cba_CheckedChanged(object sender, EventArgs e)
    {
        ddla.Enabled = cba.Checked;
        if (!cba.Checked) ddla.SelectedIndex = -1;
        ddla.Focus();
    }

    protected void ddls_SelectedIndexChanged(object sender, EventArgs e)
    {
        ddll.Items.Clear();
        ddll.Items.Insert(0, "Seleccione una opción");
        ddll.Items[0].Value = "-1";
        ddla.Items.Clear();
        ddla.Items.Insert(0, "Seleccione una opción");
        ddla.Items[0].Value = "-1";

        int codigoSede = Convert.ToInt32(ddls.SelectedValue);
        if (codigoSede == -1) return;

        Cargar_Datos(ddll, "[dbo].[pr_Obtener_Locales]", "", codigoSede);
    }

    protected void ddll_SelectedIndexChanged(object sender, EventArgs e)
    {
        ddla.Items.Clear();
        ddla.Items.Insert(0, "Seleccione una opción");
        ddla.Items[0].Value = "-1";

        int codigoLocal = Convert.ToInt32(ddll.SelectedValue);
        if (codigoLocal == -1) return;

        Cargar_Datos(ddla, "[dbo].[pr_Obtener_Areas]", "", codigoLocal);
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