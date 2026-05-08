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

    private void Listar_Elementos_Configuracion(String NOMBRE_CI, String TIPO_CI, String ESTADO_CI,
    String PROPIETARIO_CI, String DESCRIPCION_CI, String SEDE, String LOCAL, String AREA, String Mensaje)
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");

        try
        {
            policia.clsaccesodatos servidor = new policia.clsaccesodatos();
            servidor.cadenaconexion = Ruta;

            if (servidor.abrirconexion() == true)
            {
                DataTable dt = servidor.consultar("[dbo].[pr_ListaElementosConfiguracion_2]", NOMBRE_CI, TIPO_CI, ESTADO_CI, PROPIETARIO_CI, DESCRIPCION_CI, SEDE, LOCAL, AREA).Tables[0];
                servidor.cerrarconexion();

                if (dt.Rows.Count == 0)
                {
                    _Lista.ShowMessage(__mensaje, __pagina, Mensaje, "");
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
                        sb.Append("\"ID CI\":\"" + JsonEncode(row["ID CI"].ToString()) + "\",");
                        sb.Append("\"NOMBRE CI\":\"" + JsonEncode(row["NOMBRE CI"].ToString()) + "\",");
                        sb.Append("\"NRO SERIE\":\"" + JsonEncode(row["NRO SERIE"].ToString()) + "\",");
                        sb.Append("\"NOMBRE TIPO CI\":\"" + JsonEncode(row["NOMBRE TIPO CI"].ToString()) + "\",");
                        sb.Append("\"ESTADO CI\":\"" + JsonEncode(row["ESTADO CI"].ToString()) + "\",");
                        sb.Append("\"PROPIETARIO\":\"" + JsonEncode(row["PROPIETARIO"].ToString()) + "\",");
                        sb.Append("\"DESCRIPCION CI\":\"" + JsonEncode(row["DESCRIPCION CI"].ToString()) + "\",");
                        sb.Append("\"SEDE\":\"" + JsonEncode(row["SEDE"].ToString()) + "\",");
                        sb.Append("\"LOCAL\":\"" + JsonEncode(row["LOCAL"].ToString()) + "\",");
                        sb.Append("\"UBICACION LOCAL\":\"" + JsonEncode(row["UBICACION LOCAL"].ToString()) + "\",");
                        sb.Append("\"DIRECCION LOCAL\":\"" + JsonEncode(row["DIRECCION LOCAL"].ToString()) + "\",");
                        sb.Append("\"AREA\":\"" + JsonEncode(row["AREA"].ToString()) + "\",");
                        sb.Append("\"NRO PISO\":\"" + JsonEncode(row["NRO PISO"].ToString()) + "\",");
                        sb.Append("\"NRO AMBIENTE\":\"" + JsonEncode(row["NRO AMBIENTE"].ToString()) + "\"");
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

        Cargar_Datos(this.ddltci, "[dbo].[pr_Obtener_Tipos_Elemento_Configuracion_2]", "Error, al intentar recuperar Estado Elemento Configuracion.");
        if (this.__mensaje.Value.ToString().Trim() != "")
        {
            return;
        }
        Cargar_Datos(this.ddleci, "[dbo].[pr_Obtener_Estado_Elemento_Configuracion]", "Error, al intentar recuperar Estado Elemento Configuracion.");
        if (this.__mensaje.Value.ToString().Trim() != "")
        {
            return;
        }
        Cargar_Datos(this.ddldci, "[dbo].[pr_Descripcion_Elemento_Configuracion]", "Error, al intentar recuperar Descripcion Elemento Configuracion.");
        if (this.__mensaje.Value.ToString().Trim() != "")
        {
            return;
        }

        Cargar_Datos(this.ddls, "[dbo].[pr_Obtener_Sedes]", "Error, al intentar recuperar Sedes Judiciales.");
        if (this.__mensaje.Value.ToString().Trim() != "")
        {
            return;
        }

        if (Session["OpcionBusqueda"] == null)
        {
            this.Listar_Elementos_Configuracion("", "", "", "", "", "", "", "", "No hay Elementos Configuracion");
        }
        else
        {
            Object[] ob = (Object[])Session["OpcionBusqueda"];
            this.cbnci.Checked = (bool)ob[1];
            this.txtnci.Enabled = (bool)ob[1];
            this.txtnci.Text = (string)ob[0];

            this.cbtci.Checked = (bool)ob[3];
            ddltci.Enabled = (bool)ob[3];
            for (int i = 0; i < this.ddltci.Items.Count; i++)
            {
                if (this.ddltci.Items[i].Text == ob[2].ToString().Trim())
                    this.ddltci.SelectedIndex = i;
            }

            this.cbeci.Checked = (bool)ob[5];
            ddleci.Enabled = (bool)ob[5];
            for (int i = 0; i < this.ddleci.Items.Count; i++)
            {
                if (this.ddleci.Items[i].Text == ob[4].ToString().Trim())
                    this.ddleci.SelectedIndex = i;
            }

            this.cbpci.Checked = (bool)ob[7];
            txtpci.Enabled = (bool)ob[7];
            this.txtpci.Text = (string)ob[6];

            this.cbdci.Checked = (bool)ob[9];
            ddldci.Enabled = (bool)ob[9];
            for (int i = 0; i < this.ddldci.Items.Count; i++)
            {
                if (this.ddldci.Items[i].Text == ob[8].ToString().Trim())
                    this.ddldci.SelectedIndex = i;
            }

            this.cbs.Checked = (bool)ob[11];
            ddls.Enabled = (bool)ob[11];
            for (int i = 0; i < this.ddls.Items.Count; i++)
            {
                if (this.ddls.Items[i].Text == ob[10].ToString().Trim())
                    this.ddls.SelectedIndex = i;
            }

            ddls_SelectedIndexChanged(sender, e);

            this.cbl.Checked = (bool)ob[13];
            ddll.Enabled = (bool)ob[13];
            for (int i = 0; i < this.ddll.Items.Count; i++)
            {
                if (this.ddll.Items[i].Text == ob[12].ToString().Trim())
                    this.ddll.SelectedIndex = i;
            }

            ddll_SelectedIndexChanged(sender, e);

            this.cba.Checked = (bool)ob[15];
            ddla.Enabled = (bool)ob[15];
            for (int i = 0; i < this.ddla.Items.Count; i++)
            {
                if (this.ddla.Items[i].Text == ob[14].ToString().Trim())
                    this.ddla.SelectedIndex = i;
            }

            this.Listar_Elementos_Configuracion(ob[0].ToString().Trim(),
            ob[2].ToString().Trim(),
            ob[4].ToString().Trim(),
            ob[6].ToString().Trim(),
            ob[8].ToString().Trim(),
            ob[10].ToString().Trim(),
            ob[12].ToString().Trim(),
            ob[14].ToString().Trim(),
            "No hay Elementos Configuracion con los criterios seleccionados");
        }
    }

    protected void cbnci_CheckedChanged(object sender, EventArgs e)
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");
        this.txtnci.Enabled = this.cbnci.Checked;
        this.txtnci.Text = "";
        this.txtnci.Focus();
    }

    protected void cbtci_CheckedChanged(object sender, EventArgs e)
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");
        ddltci.Enabled = cbtci.Checked;
        this.ddltci.SelectedIndex = -1;
        this.ddltci.Focus();
    }

    protected void cbeci_CheckedChanged(object sender, EventArgs e)
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");
        ddleci.Enabled = cbeci.Checked;
        this.ddleci.SelectedIndex = -1;
        this.ddleci.Focus();
    }

    protected void cbpci_CheckedChanged(object sender, EventArgs e)
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");
        txtpci.Enabled = cbpci.Checked;
        this.txtnci.Text = "";
        this.txtpci.Focus();
    }

    protected void cbdci_CheckedChanged(object sender, EventArgs e)
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");
        ddldci.Enabled = cbdci.Checked;
        this.ddldci.SelectedIndex = -1;
        this.ddldci.Focus();
    }

    protected void cbs_CheckedChanged(object sender, EventArgs e)
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");
        ddls.Enabled = cbs.Checked;
        this.ddls.SelectedIndex = -1;
        this.ddls.Focus();
    }

    protected void cbl_CheckedChanged(object sender, EventArgs e)
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");
        ddll.Enabled = cbl.Checked;
        this.ddll.SelectedIndex = -1;
        this.ddll.Focus();
    }

    protected void cba_CheckedChanged(object sender, EventArgs e)
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");
        ddla.Enabled = cba.Checked;
        this.ddla.SelectedIndex = -1;
        this.ddla.Focus();
    }

    protected void lbtnBuscar_Click(object sender, EventArgs e)
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");

        Object[] ob;

        bool ok = (cbnci.Checked == true ||
        cbtci.Checked == true ||
        cbeci.Checked == true ||
        cbpci.Checked == true ||
        cbdci.Checked == true ||
        cbs.Checked == true ||
        cbl.Checked == true ||
        cba.Checked == true);
        if (ok == false)
        {
            _Lista.ShowMessage(__mensaje, __pagina, "Seleccione criterio(s) de busqueda.", "../ElementosConfiguracion.aspx");
            return;
        }

        ob = new Object[] {
             txtnci.Text.Trim(), this.cbnci.Checked,
             Convert.ToInt32(ddltci.SelectedValue)==-1?"": ddltci.SelectedItem.Text, this.cbtci.Checked,
             Convert.ToInt32(ddleci.SelectedValue)==-1?"": ddleci.SelectedItem.Text, this.cbeci.Checked,
             txtpci.Text.Trim(), this.cbpci.Checked,
             Convert.ToInt32(ddldci.SelectedValue)==-1?"": ddldci.SelectedItem.Text, this.cbdci.Checked,
             Convert.ToInt32(ddls.SelectedValue)==-1?"": ddls.SelectedItem.Text, this.cbs.Checked,
             Convert.ToInt32(ddll.SelectedValue)==-1?"": ddll.SelectedItem.Text, this.cbl.Checked,
             Convert.ToInt32(ddla.SelectedValue)==-1?"": ddla.SelectedItem.Text, this.cba.Checked
        };
        Session["OpcionBusqueda"] = ob;

        Response.Clear();
        Response.Redirect("ventanaElementosConfiguracionSoftware.aspx");
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
                    dt = servidor.consultar(Procedimeinto_Almacenado, Convert.ToInt32(p[0])).Tables[0];
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

    protected void ddls_SelectedIndexChanged(object sender, EventArgs e)
    {
        this.__mensaje.Value = "";
        this.__pagina.Value = "";
        this.ddll.Items.Clear();
        this.ddll.Items.Insert(0, "_____SELECCIONE LOCAL_____");
        this.ddll.Items[0].Value = "-1";
        this.ddla.Items.Clear();
        this.ddla.Items.Insert(0, "_____SELECCIONE AREA_____");
        this.ddla.Items[0].Value = "-1";
        int Codigo_Sede = Convert.ToInt32(ddls.SelectedValue);
        if (Codigo_Sede == -1)
        {
            this.__mensaje.Value = "Seleccione Sede Judicial para ver Locales Judiciales";
            this.__pagina.Value = "";
            return;
        }
        Cargar_Datos(this.ddll, "[dbo].[pr_Obtener_Locales]", "Error, al intentar recuperar Locales Judiciales.", new Object[] { Codigo_Sede });
        if (this.__mensaje.Value.ToString().Trim() != "")
        {
            return;
        }
    }

    protected void ddll_SelectedIndexChanged(object sender, EventArgs e)
    {
        this.__mensaje.Value = "";
        this.__pagina.Value = "";
        this.ddla.Items.Clear();
        this.ddla.Items.Insert(0, "_____SELECCIONE AREA_____");
        this.ddla.Items[0].Value = "-1";
        int Codigo_Local = Convert.ToInt32(ddll.SelectedValue);
        if (Codigo_Local == -1)
        {
            this.__mensaje.Value = "Seleccione Local Judicial para ver Areas Judiciales";
            this.__pagina.Value = "";
            return;
        }
        Cargar_Datos(this.ddla, "[dbo].[pr_Obtener_Areas]", "Error, al intentar recuperar Areas Judiciales.", new Object[] { Codigo_Local });
        if (this.__mensaje.Value.ToString().Trim() != "")
        {
            return;
        }
    }

    protected void btnActualizarInformacion_Click(object sender, EventArgs e)
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");
        Session["OpcionBusqueda"] = null;
        Response.Clear();
        Response.Redirect("ventanaElementosConfiguracionSoftware.aspx");
        Response.Flush();
        _Lista.ShowMessage(__mensaje, __pagina, "", "");
    }
}