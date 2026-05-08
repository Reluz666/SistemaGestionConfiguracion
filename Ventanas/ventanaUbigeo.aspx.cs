using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ElementosConfiguracion : System.Web.UI.Page
{
    private String Ruta = System.Configuration.ConfigurationManager.ConnectionStrings["CadenaConeccion"].ToString();
    System.Web.UI.WebControls.TableRow tRow;

    Lista _Lista = new Lista();

    private void Listar_Ubigeo(string _DEPARTAMENTO, string _PROVINCIA, string MENSAJE)
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");

        try
        {
            policia.clsaccesodatos servidor = new policia.clsaccesodatos();
            servidor.cadenaconexion = Ruta;

            if (servidor.abrirconexion() == true)
            {
                DataTable dt = servidor.consultar("[dbo].[pr_ListaUbigeo]", _DEPARTAMENTO, _PROVINCIA).Tables[0];
                servidor.cerrarconexion();

                if (dt.Rows.Count == 0)
                {
                    _Lista.ShowMessage(__mensaje, __pagina, MENSAJE, "");
                    datosJson.Value = "[]";
                }
                else
                {
                    System.Text.StringBuilder sb = new System.Text.StringBuilder();
                    sb.Append("[");

                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        if (i > 0) sb.Append(",");
                        DataRow row = dt.Rows[i];
                        sb.Append("{");
                        sb.Append("\"ID\":\"" + JsonEncode(row["ID"].ToString()) + "\",");
                        sb.Append("\"CODIGO\":\"" + JsonEncode(row["CODIGO"].ToString()) + "\",");
                        sb.Append("\"DEPARTAMENTO\":\"" + JsonEncode(row["DEPARTAMENTO"].ToString()) + "\",");
                        sb.Append("\"PROVINCIA\":\"" + JsonEncode(row["PROVINCIA"].ToString()) + "\",");
                        sb.Append("\"DISTRITO\":\"" + JsonEncode(row["DISTRITO"].ToString()) + "\"");
                        sb.Append("}");
                    }

                    sb.Append("]");
                    datosJson.Value = sb.ToString();
                }
            }
            else
            {
                servidor.cerrarconexion();
                _Lista.ShowMessage(__mensaje, __pagina, servidor.getMensageError(), "../CerrarSession.aspx");
                datosJson.Value = "[]";
            }
        }
        catch (Exception)
        {
            _Lista.ShowMessage(__mensaje, __pagina, "Error inesperado al intentar conectarnos con el servidor.", "../CerrarSession.aspx");
            datosJson.Value = "[]";
        }
    }

    private string JsonEncode(string str)
    {
        if (string.IsNullOrEmpty(str)) return "";
        return str.Replace("\\", "\\\\")
                   .Replace("\"", "\\\"")
                   .Replace("\n", "\\n")
                   .Replace("\r", "\\r")
                   .Replace("\t", "\\t")
                   .Replace("<", "\\u003c")
                   .Replace(">", "\\u003e");
    }

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void Page_init(object sender, EventArgs e)
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");

        Cargar_Datos(this.ddld, "[dbo].[pr_Obtener_Ubigeo_Departamento]", "Error, al intentar recuperar Departamentos.");
        if (this.__mensaje.Value.ToString().Trim() != "")
        {
            return;
        }

        if (Session["OpcionBusqueda"] == null)
        {
            // No list by default, wait for user selection
        }
        else
        {
            Object[] ob = (Object[])Session["OpcionBusqueda"];
            this.cbd.Checked = (bool)ob[1];
            this.ddld.Enabled = (bool)ob[1];
            for (int i = 0; i < this.ddld.Items.Count; i++)
            {
                if (this.ddld.Items[i].Text == ob[0].ToString().Trim())
                    this.ddld.SelectedIndex = i;
            }
            ddld_SelectedIndexChanged(sender, e);

            this.cbp.Checked = (bool)ob[3];
            this.ddlp.Enabled = (bool)ob[3];
            for (int i = 0; i < this.ddlp.Items.Count; i++)
            {
                if (this.ddlp.Items[i].Text == ob[2].ToString().Trim())
                    this.ddlp.SelectedIndex = i;
            }
            this.Listar_Ubigeo(ob[0].ToString().Trim(),
            ob[2].ToString().Trim(),
            "No hay informacion con los criterios seleccionados");
        }
    }

    protected void cbd_CheckedChanged(object sender, EventArgs e)
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");
        this.ddld.Enabled = this.cbd.Checked;
        this.ddld.SelectedIndex = -1;
    }

    protected void lbtnBuscar_Click(object sender, EventArgs e)
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");

        Object[] ob;

        bool ok = cbd.Checked == true && cbp.Checked == true;
        if (ok == false)
        {
            _Lista.ShowMessage(__mensaje, __pagina, "Seleccione depatamento y provincia para empezar la busqueda.", "");
            return;
        }

        if (this.ddld.SelectedValue == "-1")
        {
            _Lista.ShowMessage(__mensaje, __pagina, "Seleccione depatamento.", "");
            return;
        }
        if (this.ddlp.SelectedValue == "-1")
        {
            _Lista.ShowMessage(__mensaje, __pagina, "Seleccione provincia.", "");
            return;
        }

        ob = new Object[] {
             ddld.SelectedValue.Trim(), this.cbd.Checked,
             ddlp.SelectedValue.Trim(), this.cbp.Checked
        };
        Session["OpcionBusqueda"] = ob;

        Response.Clear();
        Response.Redirect("ventanaUbigeo.aspx");
        Response.Flush();

        _Lista.ShowMessage(__mensaje, __pagina, "", "");
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
                    dt = servidor.consultar(Procedimeinto_Almacenado, p[0]).Tables[0];
                }
                if (dt.Rows.Count == 0)
                {
                    servidor.cerrarconexion();
                    this.__mensaje.Value = Mensaje;
                    this.__pagina.Value = "";
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

    protected void btnActualizarInformacion_Click(object sender, EventArgs e)
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");
        Session["OpcionBusqueda"] = null;
        Response.Clear();
        Response.Redirect("ventanaUbigeo.aspx");
        Response.Flush();
        _Lista.ShowMessage(__mensaje, __pagina, "", "");
    }

    protected void cbp_CheckedChanged(object sender, EventArgs e)
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");
        this.ddlp.Enabled = this.cbp.Checked;
        this.ddlp.SelectedIndex = -1;
    }

    protected void ddld_SelectedIndexChanged(object sender, EventArgs e)
    {
        this.__mensaje.Value = "";
        this.__pagina.Value = "";
        this.ddlp.Items.Clear();
        this.ddlp.Items.Insert(0, "_____SELECCIONE PROVINCIA_____");
        this.ddlp.Items[0].Value = "-1";
        this.ddlp.SelectedIndex = -1;
        string Provincia = ddld.SelectedValue;
        if (Provincia == "-1")
        {
            this.__mensaje.Value = "Seleccione Provincia";
            this.__pagina.Value = "";
            return;
        }
        Cargar_Datos(this.ddlp, "[dbo].[pr_Obtener_Ubigeo_Provincia]", "Error, al intentar recuperar Provincias.", new Object[] { Provincia });
        if (this.__mensaje.Value.ToString().Trim() != "")
        {
            return;
        }
    }
}