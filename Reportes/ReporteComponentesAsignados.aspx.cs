using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;

public partial class ElementosConfiguracion : System.Web.UI.Page
{
    //private String Ruta = "SERVER=JOSE-PC;DATABASE=GCS;Encrypt=False;INTEGRATED SECURITY=True;packet size=4096;";
    private String Ruta = System.Configuration.ConfigurationManager.ConnectionStrings["CadenaConeccion"].ToString();
    System.Web.UI.WebControls.TableRow tRow;

    Lista _Lista = new Lista();

    private void Listar_Elementos_Configuracion(String NOMBRE_CI, String TIPO_CI, String ESTADO_CI,
    String PROPIETARIO_CI, String DESCRIPCION_CI, String IMPACTO_CI, String SEDE, String LOCAL, String AREA, String NRO_SERIE, String MARCA, String Mensaje)
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");

        try
        {
            policia.clsaccesodatos servidor = new policia.clsaccesodatos();
            servidor.cadenaconexion = Ruta;

            if (servidor.abrirconexion() == true)
            {
                DataTable dt = servidor.consultar("[dbo].[pr_ListaElementosConfiguracionComponenetesAsignados]", NOMBRE_CI, TIPO_CI, ESTADO_CI, PROPIETARIO_CI, DESCRIPCION_CI, IMPACTO_CI, SEDE, LOCAL, AREA, NRO_SERIE, MARCA).Tables[0];

                if (dt.Rows.Count == 0)
                {
                    servidor.cerrarconexion();
                    _Lista.ShowMessage(__mensaje, __pagina, Mensaje, "");
                    datosJson.Value = "[]";
                }
                else
                {
                    Session["CABECERA"] = dt;

                    // Build JSON for client-side rendering with nested components
                    var jsonData = new List<Dictionary<string, object>>();
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        var row = new Dictionary<string, object>();
                        row["ID CI"] = dt.Rows[i]["ID CI"].ToString();
                        row["NOMBRE CI"] = dt.Rows[i]["NOMBRE CI"].ToString();
                        row["NOMBRE TIPO CI"] = dt.Rows[i]["NOMBRE TIPO CI"].ToString();
                        row["NRO SERIE"] = dt.Rows[i]["NRO SERIE"].ToString();
                        row["FABRICANTE / PROVEEDOR"] = dt.Rows[i]["FABRICANTE / PROVEEDOR"].ToString();
                        row["MARCA_MODELO_HTML"] = "<span class='color-red'>" + dt.Rows[i]["MARCA"].ToString() + "</span> / <span class='color-blue'>" + dt.Rows[i]["MODELO"].ToString() + "</span>";
                        row["IP"] = dt.Rows[i]["IP"].ToString();
                        row["GATEWAY"] = dt.Rows[i]["GATEWAY"].ToString();
                        row["GRUPO TRABAJO"] = dt.Rows[i]["GRUPO TRABAJO"].ToString();
                        row["ESTADO CI"] = dt.Rows[i]["ESTADO CI"].ToString();
                        row["PROPIETARIO"] = dt.Rows[i]["PROPIETARIO"].ToString();
                        row["DESCRIPCION CI"] = dt.Rows[i]["DESCRIPCION CI"].ToString();
                        row["IMPACTO_PRIORIDAD_HTML"] = "<span class='color-blue'>" + dt.Rows[i]["IMPACTO CI"].ToString() + "</span> / <span class='color-red'>" + dt.Rows[i]["NIVEL PRIORIDAD"].ToString() + "</span>";
                        row["SEDE_LOCAL_HTML"] = "<span class='color-blue'>" + dt.Rows[i]["SEDE"].ToString() + "</span> / <span class='color-red'>" + dt.Rows[i]["LOCAL"].ToString() + "</span>";
                        row["AREA"] = dt.Rows[i]["AREA"].ToString();
                        row["NRO PISO"] = dt.Rows[i]["NRO PISO"].ToString();
                        row["NRO AMBIENTE"] = dt.Rows[i]["NRO AMBIENTE"].ToString();

                        // Get components for this CI
                        int idCI = Convert.ToInt32(dt.Rows[i]["ID CI"].ToString());
                        DataTable dtComponentes = getDetalleComponentesCI(idCI);

                        var componentes = new List<Dictionary<string, string>>();
                        for (int c = 0; c < dtComponentes.Rows.Count; c++)
                        {
                            var comp = new Dictionary<string, string>();
                            comp["TIPO COMPONENTE"] = dtComponentes.Rows[c]["TIPO COMPONENTE"].ToString();
                            comp["DESCRIPCION"] = dtComponentes.Rows[c]["DESCRIPCION"].ToString();
                            comp["FABRICANTE"] = dtComponentes.Rows[c]["FABRICANTE"].ToString();
                            comp["NRO SERIE"] = dtComponentes.Rows[c]["NRO SERIE"].ToString();
                            comp["MODELO"] = dtComponentes.Rows[c]["MODELO"].ToString();
                            comp["MARCA"] = dtComponentes.Rows[c]["MARCA"].ToString();
                            componentes.Add(comp);
                        }
                        row["COMPONENTE_COUNT"] = componentes.Count;
                        row["COMPONENTES"] = componentes;

                        jsonData.Add(row);
                    }

                    var serializer = new JavaScriptSerializer();
                    datosJson.Value = serializer.Serialize(jsonData);

                    servidor.cerrarconexion();
                }
            }
            else
            {
                servidor.cerrarconexion();
                _Lista.ShowMessage(__mensaje, __pagina, servidor.getMensageError(), "../CerrarSession.aspx");
            }
        }
        catch (Exception)
        {
            _Lista.ShowMessage(__mensaje, __pagina, "Error inesperado al intentar conectarnos con el servidor.", "../CerrarSession.aspx");
        }
    }

    private DataTable getDetalleComponentesCI(int ID)
    {
        DataTable dt = null;
        try
        {
            policia.clsaccesodatos servidor = new policia.clsaccesodatos();
            servidor.cadenaconexion = Ruta;
            if (servidor.abrirconexion() == true)
            {
                dt = servidor.consultar("[dbo].[pr_ConsultarDetalleComponentesCI]", ID).Tables[0];
                servidor.cerrarconexion();
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
        return dt;
    }

    protected void Page_Load(object sender, EventArgs e)
    {
    }

    protected void Page_init(object sender, EventArgs e)
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");

        string[] Datos = (string[])Session["__JSAR__"];

        if (Datos == null)
        {
            this.__mensaje.Value = "Ud. no esta autorizado para ingresar a esta página, inicie sesion por favor.";
            this.__pagina.Value = "CerrarSession.aspx";
            return;
        }

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
        Cargar_Datos(this.ddlm, "[dbo].[pr_Obtener_Marcas]", "Error, al intentar recuperar Marcas Elemento Configuracion.");
        if (this.__mensaje.Value.ToString().Trim() != "")
        {
            return;
        }

        if (Session["OpcionBusqueda"] == null)
        {
            this.Listar_Elementos_Configuracion("", "", "", "", "", "", "", "", "", "", "", "No hay Elementos Configuracion");
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

            this.cbns.Checked = (bool)ob[19];
            this.txtns.Enabled = (bool)ob[19];
            this.txtns.Text = (string)ob[18];

            this.cbm.Checked = (bool)ob[21];
            ddlm.Enabled = (bool)ob[21];
            for (int i = 0; i < this.ddlm.Items.Count; i++)
            {
                if (this.ddlm.Items[i].Text == ob[20].ToString().Trim())
                    this.ddlm.SelectedIndex = i;
            }

            this.Listar_Elementos_Configuracion(ob[0].ToString().Trim(),
            ob[2].ToString().Trim(),
            ob[4].ToString().Trim(),
            "",
            ob[8].ToString().Trim(),
            "",
            ob[10].ToString().Trim(),
            ob[12].ToString().Trim(),
            ob[14].ToString().Trim(),
            ob[18].ToString().Trim(),
            ob[20].ToString().Trim(),
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

    protected void cbns_CheckedChanged(object sender, EventArgs e)
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");
        this.txtns.Enabled = this.cbns.Checked;
        this.txtns.Text = "";
        this.txtns.Focus();
    }

    protected void cbm_CheckedChanged(object sender, EventArgs e)
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");
        ddlm.Enabled = cbm.Checked;
        this.ddlm.SelectedIndex = -1;
        this.ddlm.Focus();
    }

    protected void lbtnBuscar_Click(object sender, EventArgs e)
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");

        Object[] ob;

        bool ok = (cbnci.Checked == true ||
        cbtci.Checked == true ||
        cbeci.Checked == true ||
        cbdci.Checked == true ||
        cbs.Checked == true ||
        cbl.Checked == true ||
        cba.Checked == true ||
        cbns.Checked == true ||
        cbm.Checked == true);
        if (ok == false)
        {
            _Lista.ShowMessage(__mensaje, __pagina, "Seleccione criterio(s) de busqueda.", "");
            return;
        }

        String _NOMBRE_CI = "";
        String _NRO_SERIE = "";
        if (cbnci.Checked == true)
        {
            _NOMBRE_CI = txtnci.Text.Trim();
            if (_NOMBRE_CI.Trim().Length == 0)
            {
                _Lista.ShowMessage(__mensaje, __pagina, "Ingrese nombre elemento de configuracion.", "");
                txtnci.Focus();
                return;
            }
        }
        else if (cbtci.Checked == true)
        {
            if (ddltci.SelectedValue == (-1).ToString())
            {
                _Lista.ShowMessage(__mensaje, __pagina, "Seleccione tipo CI.", "");
                ddltci.Focus();
                return;
            }
        }
        else if (cbeci.Checked == true)
        {
            if (ddleci.SelectedValue == (-1).ToString())
            {
                _Lista.ShowMessage(__mensaje, __pagina, "Seleccione Estado CI.", "");
                ddleci.Focus();
                return;
            }
        }
        else if (cbdci.Checked == true)
        {
            if (ddldci.SelectedValue == (-1).ToString())
            {
                _Lista.ShowMessage(__mensaje, __pagina, "Seleccione Descripcion CI.", "");
                ddldci.Focus();
                return;
            }
        }
        else if (cbs.Checked == true)
        {
            if (ddls.SelectedValue == (-1).ToString())
            {
                _Lista.ShowMessage(__mensaje, __pagina, "Seleccione Sede Judicial.", "");
                ddls.Focus();
                return;
            }
        }
        else if (cbl.Checked == true)
        {
            if (ddll.SelectedValue == (-1).ToString())
            {
                _Lista.ShowMessage(__mensaje, __pagina, "Seleccione Local Judicial.", "");
                ddll.Focus();
                return;
            }
        }
        else if (cba.Checked == true)
        {
            if (ddla.SelectedValue == (-1).ToString())
            {
                _Lista.ShowMessage(__mensaje, __pagina, "Seleccione Area Judicial.", "");
                ddla.Focus();
                return;
            }
        }
        else if (cbns.Checked == true)
        {
            _NRO_SERIE = txtns.Text.Trim();
            if (_NRO_SERIE.Trim().Length == 0)
            {
                _Lista.ShowMessage(__mensaje, __pagina, "Ingrese Nro Serie elemento de configuracion.", "");
                txtns.Focus();
                return;
            }
        }

        ob = new Object[] {
             txtnci.Text.Trim(), this.cbnci.Checked,
             Convert.ToInt32(ddltci.SelectedValue)==-1?"": ddltci.SelectedItem.Text, this.cbtci.Checked,
             Convert.ToInt32(ddleci.SelectedValue)==-1?"": ddleci.SelectedItem.Text, this.cbeci.Checked,
             "", false,
             Convert.ToInt32(ddldci.SelectedValue)==-1?"": ddldci.SelectedItem.Text, this.cbdci.Checked,
             Convert.ToInt32(ddls.SelectedValue)==-1?"": ddls.SelectedItem.Text, this.cbs.Checked,
             Convert.ToInt32(ddll.SelectedValue)==-1?"": ddll.SelectedItem.Text, this.cbl.Checked,
             Convert.ToInt32(ddla.SelectedValue)==-1?"": ddla.SelectedItem.Text, this.cba.Checked,
             "", false,
             txtns.Text.Trim(), this.cbns.Checked,
             Convert.ToInt32(ddlm.SelectedValue)==-1?"": ddlm.SelectedItem.Text, this.cbm.Checked,
        };
        Session["OpcionBusqueda"] = ob;

        Response.Clear();
        Response.Redirect("ReporteComponentesAsignados.aspx");
        Response.Flush();
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
    }

    protected void btnActualizarInformacion_Click(object sender, EventArgs e)
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");
        Session["OpcionBusqueda"] = null;
        Response.Clear();
        Response.Redirect("ReporteComponentesAsignados.aspx");
        Response.Flush();
    }

    protected void IMPRIMIR_Click(object sender, EventArgs e)
    {
        DataTable dtCIs = new DataTable();
        dtCIs = (DataTable)Session["CABECERA"];

        DataTable dtCOMPONENTES = new DataTable();
        dtCOMPONENTES.Columns.Add(new DataColumn("ID COMPONENETE", typeof(System.Int32)));
        dtCOMPONENTES.Columns.Add(new DataColumn("TIPO COMPONENTE", typeof(System.String)));
        dtCOMPONENTES.Columns.Add(new DataColumn("DESCRIPCION", typeof(System.String)));
        dtCOMPONENTES.Columns.Add(new DataColumn("FABRICANTE", typeof(System.String)));
        dtCOMPONENTES.Columns.Add(new DataColumn("NRO SERIE", typeof(System.String)));
        dtCOMPONENTES.Columns.Add(new DataColumn("MODELO", typeof(System.String)));
        dtCOMPONENTES.Columns.Add(new DataColumn("MARCA", typeof(System.String)));
        dtCOMPONENTES.Columns.Add(new DataColumn("ID CI", typeof(System.Int32)));

        for (int i = 0; i < dtCIs.Rows.Count; i++)
        {
            DataTable dt = getDetalleComponentesCI(Convert.ToInt32(dtCIs.Rows[i].ItemArray[0].ToString()));
            foreach (DataRow row in dt.Rows)
            {
                dtCOMPONENTES.ImportRow(row);
            }
        }

        Session["Imprimir"] = new Object[] { "REPORTE_COMPONENTES_CI", dtCIs, "REPORTE DE COMPONENTES DE ELEMENTO CONFIGURACION HARDWARE", dtCOMPONENTES };
    }
}
