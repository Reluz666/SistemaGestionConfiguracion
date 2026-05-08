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
    private String Ruta = System.Configuration.ConfigurationManager.ConnectionStrings["CadenaConeccion"].ToString();
    Lista _Lista = new Lista();

    private void Cargar_Datos(System.Web.UI.WebControls.DropDownList ddl, String Procedimiento_Almacenado, String Mensaje, params Object[] p)
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
                    dt = servidor.consultar(Procedimiento_Almacenado).Tables[0];
                }
                else
                {
                    dt = servidor.consultar(Procedimiento_Almacenado, Convert.ToInt32(p[0])).Tables[0];
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

    private List<Dictionary<string, string>> Listar_Elementos_Configuracion(String OPCION_BUSQUEDA, String AREA, String Mensaje)
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");
        var result = new List<Dictionary<string, string>>();

        try
        {
            policia.clsaccesodatos servidor = new policia.clsaccesodatos();
            servidor.cadenaconexion = Ruta;

            if (servidor.abrirconexion() == true)
            {
                DataTable dt = servidor.consultar("[dbo].[pr_Reporte_CIs_Información_Contenidas_En_CMDB]", OPCION_BUSQUEDA, AREA).Tables[0];

                if (dt.Rows.Count == 0)
                {
                    servidor.cerrarconexion();
                    _Lista.ShowMessage(__mensaje, __pagina, Mensaje, "");
                }
                else
                {
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        var row = new Dictionary<string, string>();
                        row["ID CI"] = dt.Rows[i]["ID CI"].ToString();
                        row["NOMBRE CI"] = dt.Rows[i]["NOMBRE CI"].ToString();
                        row["NOMBRE TIPO CI"] = dt.Rows[i]["NOMBRE TIPO CI"].ToString();
                        row["NRO SERIE"] = dt.Rows[i]["NRO SERIE"].ToString();
                        row["FABRICANTE / PROVEEDOR"] = dt.Rows[i]["FABRICANTE / PROVEEDOR"].ToString();
                        row["MARCA"] = dt.Rows[i]["MARCA"].ToString();
                        row["MODELO"] = dt.Rows[i]["MODELO"].ToString();
                        row["IP"] = dt.Rows[i]["IP"].ToString();
                        row["GATEWAY"] = dt.Rows[i]["GATEWAY"].ToString();
                        row["GRUPO TRABAJO"] = dt.Rows[i]["GRUPO TRABAJO"].ToString();
                        row["ESTADO CI"] = dt.Rows[i]["ESTADO CI"].ToString();
                        row["PROPIETARIO"] = dt.Rows[i]["PROPIETARIO"].ToString();
                        row["DESCRIPCION CI"] = dt.Rows[i]["DESCRIPCION CI"].ToString();
                        row["IMPACTO CI"] = dt.Rows[i]["IMPACTO CI"].ToString();
                        row["NIVEL PRIORIDAD"] = dt.Rows[i]["NIVEL PRIORIDAD"].ToString();
                        row["SEDE"] = dt.Rows[i]["SEDE"].ToString();
                        row["LOCAL"] = dt.Rows[i]["LOCAL"].ToString();
                        row["UBICACION LOCAL"] = dt.Rows[i]["UBICACION LOCAL"].ToString();
                        row["DIRECCION LOCAL"] = dt.Rows[i]["DIRECCION LOCAL"].ToString();
                        row["AREA"] = dt.Rows[i]["AREA"].ToString();
                        row["NRO PISO"] = dt.Rows[i]["NRO PISO"].ToString();
                        row["NRO AMBIENTE"] = dt.Rows[i]["NRO AMBIENTE"].ToString();
                        row["FEC. CREACION CI"] = dt.Rows[i]["FEC. CREACION CI"].ToString();
                        row["RESPONSABLE"] = dt.Rows[i]["RESPONSABLE"].ToString();
                        result.Add(row);
                    }
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

        return result;
    }

    private List<Dictionary<string, string>> Listar_Licencias(String OPCION_BUSQUEDA, String AREA, String Mensaje)
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");
        var result = new List<Dictionary<string, string>>();

        try
        {
            policia.clsaccesodatos servidor = new policia.clsaccesodatos();
            servidor.cadenaconexion = Ruta;

            if (servidor.abrirconexion() == true)
            {
                DataTable dt = servidor.consultar("[dbo].[pr_Reporte_CIs_Información_Contenidas_En_CMDB]", OPCION_BUSQUEDA, AREA).Tables[0];

                if (dt.Rows.Count == 0)
                {
                    servidor.cerrarconexion();
                    _Lista.ShowMessage(__mensaje, __pagina, Mensaje, "");
                }
                else
                {
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        var row = new Dictionary<string, string>();
                        row["AREA"] = dt.Rows[i]["AREA"].ToString();
                        row["LICENCIA"] = dt.Rows[i]["LICENCIA"].ToString();
                        row["NOMBRE"] = dt.Rows[i]["NOMBRE"].ToString();
                        row["VERSION"] = dt.Rows[i]["VERSION"].ToString();
                        row["SUSCRIPCION"] = dt.Rows[i]["SUSCRIPCION"].ToString();
                        row["FEC. INI."] = dt.Rows[i]["FEC. INI."].ToString();
                        row["FEC. FIN"] = dt.Rows[i]["FEC. FIN"].ToString();
                        row["PERPETUA"] = dt.Rows[i]["PERPETUA"].ToString();
                        row["DESCRIPCION"] = dt.Rows[i]["DESCRIPCION"].ToString();
                        row["VENCE LICENCIA"] = dt.Rows[i]["VENCE LICENCIA"].ToString();
                        result.Add(row);
                    }
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

        return result;
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
            this.__mensaje.Value = "Ud. no esta autorizado para ingresar a esta pagina, inicie sesion por favor.";
            this.__pagina.Value = "CerrarSession.aspx";
            return;
        }

        Cargar_Datos(this.ddls, "[dbo].[pr_Obtener_Sedes]", "Error, al intentar recuperar Sedes Judiciales.");
        if (this.__mensaje.Value.ToString().Trim() != "")
        {
            return;
        }

        if (Session["OpcionBusqueda"] == null)
        {
            var dataElementos = this.Listar_Elementos_Configuracion("1", "", "No hay Elementos Configuracion");
            var dataLicencias = this.Listar_Licencias("2", "", "No hay Licencias");
            var serializer = new JavaScriptSerializer();
            this.datosJsonElementos.Value = serializer.Serialize(dataElementos);
            this.datosJsonLicencias.Value = serializer.Serialize(dataLicencias);
        }
        else
        {
            Object[] ob = (Object[])Session["OpcionBusqueda"];
            this.cbs.Checked = (bool)ob[1];
            ddls.Enabled = (bool)ob[1];
            for (int i = 0; i < this.ddls.Items.Count; i++)
            {
                if (this.ddls.Items[i].Text == ob[0].ToString().Trim())
                    this.ddls.SelectedIndex = i;
            }

            ddls_SelectedIndexChanged(sender, e);

            this.cbl.Checked = (bool)ob[3];
            ddll.Enabled = (bool)ob[3];
            for (int i = 0; i < this.ddll.Items.Count; i++)
            {
                if (this.ddll.Items[i].Text == ob[2].ToString().Trim())
                    this.ddll.SelectedIndex = i;
            }

            ddll_SelectedIndexChanged(sender, e);

            this.cba.Checked = (bool)ob[5];
            ddla.Enabled = (bool)ob[5];
            for (int i = 0; i < this.ddla.Items.Count; i++)
            {
                if (this.ddla.Items[i].Text == ob[4].ToString().Trim())
                    this.ddla.SelectedIndex = i;
            }

            var elemData = this.Listar_Elementos_Configuracion("1", ob[4].ToString().Trim(),
                "No hay Elementos Configuracion con los criterios seleccionados");
            var licData = this.Listar_Licencias("2", ob[4].ToString().Trim(), "No hay Licencias");
            var ser = new JavaScriptSerializer();
            this.datosJsonElementos.Value = ser.Serialize(elemData);
            this.datosJsonLicencias.Value = ser.Serialize(licData);
        }

        double T = Convert.ToDouble(Datos[17].ToString());
        this.Label1.Text += " <b>" + Datos[17].ToString() + "</b>";

        // Calculate A from JSON data count
        var ser2 = new JavaScriptSerializer();
        var elemCount = string.IsNullOrEmpty(this.datosJsonElementos.Value) ? new List<Dictionary<string, string>>() : ser2.Deserialize<List<Dictionary<string, string>>>(this.datosJsonElementos.Value);
        var licCount = string.IsNullOrEmpty(this.datosJsonLicencias.Value) ? new List<Dictionary<string, string>>() : ser2.Deserialize<List<Dictionary<string, string>>>(this.datosJsonLicencias.Value);
        double A = elemCount.Count + licCount.Count;

        this.Label2.Text += " <b>" + A.ToString() + "</b>";

        double X = T > 0 ? (A * 100) / T : 0;

        string msg = "";
        if (X >= 95)
        {
            msg = "% ideal de CIs contenidas en la CMDB";
            this.Label3.Text += "<font color='blue'> <b>" + X.ToString() + "</b> " + msg + "</font>";
        }
        else if (X >= 80 && X < 95)
        {
            msg = "% promedio de Cis contenidas en la CMDB";
            this.Label3.Text += "<font color='green'> <b>" + X.ToString() + "</b> " + msg + "</font>";
        }
        else if (X < 80)
        {
            msg = "% deficiente de CIs contenidas en la CMDB";
            this.Label3.Text += "<font color='red'> <b>" + X.ToString() + "</b> " + msg + "</font>";
        }
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

        bool ok = (cbs.Checked == false ||
        cbl.Checked == false ||
        cba.Checked == false
        );
        if (ok == true)
        {
            _Lista.ShowMessage(__mensaje, __pagina, "Seleccione criterio(s) de busqueda.", "");
            return;
        }

        if (cbs.Checked == true && cbl.Checked == true && cba.Checked == true)
        {
            if (Convert.ToInt32(ddls.SelectedValue) == -1)
            {
                _Lista.ShowMessage(__mensaje, __pagina, "Seleccione Sede Para Ver Locales Judiciales.", "");
                return;
            }
            if (Convert.ToInt32(ddll.SelectedValue) == -1)
            {
                _Lista.ShowMessage(__mensaje, __pagina, "Seleccione Local Judicial Para Ver Areas Judiciales.", "");
                return;
            }
            if (Convert.ToInt32(ddla.SelectedValue) == -1)
            {
                _Lista.ShowMessage(__mensaje, __pagina, "Seleccione Area Judicial.", "");
                return;
            }
        }

        ob = new Object[] {
             Convert.ToInt32(ddls.SelectedValue)==-1?"": ddls.SelectedItem.Text, this.cbs.Checked,
             Convert.ToInt32(ddll.SelectedValue)==-1?"": ddll.SelectedItem.Text, this.cbl.Checked,
             Convert.ToInt32(ddla.SelectedValue)==-1?"": ddla.SelectedItem.Text, this.cba.Checked
        };
        Session["OpcionBusqueda"] = ob;

        Response.Clear();
        Response.Redirect("ReporteCIsInformacionContenidaEnCMDB.aspx");
        Response.Flush();

        _Lista.ShowMessage(__mensaje, __pagina, "", "");
    }

    protected void ddls_SelectedIndexChanged(object sender, EventArgs e)
    {
        this.__mensaje.Value = "";
        this.__pagina.Value = "";
        this.ddll.Items.Clear();
        this.ddll.Items.Insert(0, "Seleccione una opción");
        this.ddll.Items[0].Value = "-1";
        this.ddla.Items.Clear();
        this.ddla.Items.Insert(0, "Seleccione una opción");
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
        this.ddla.Items.Insert(0, "Seleccione una opción");
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
        Response.Redirect("ReporteCIsInformacionContenidaEnCMDB.aspx");
        Response.Flush();
        _Lista.ShowMessage(__mensaje, __pagina, "", "");
    }
}
