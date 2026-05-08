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

    private void Elementos_Configuracion_Seguidos(string Nombre_CI, string Tipo_CI, string Nro_Serie, string Descripcion_CI, string Sede, string Local, string Area, string Responsable, string Clasificacion_Datos, string Relacion_otros_CIs, string Fecha_Inicio, string Fecha_Fin, string Estado_Actual_CIs, String Mensaje)
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");

        try
        {
            policia.clsaccesodatos servidor = new policia.clsaccesodatos();
            servidor.cadenaconexion = Ruta;

            if (servidor.abrirconexion() == true)
            {
                DataTable dt = servidor.consultar("[dbo].[pr_ReporteDatosIncorrectosCI]", Nombre_CI, Tipo_CI, Nro_Serie, Descripcion_CI, Sede, Local, Area, Responsable, Clasificacion_Datos, Relacion_otros_CIs, Fecha_Inicio, Fecha_Fin, Estado_Actual_CIs).Tables[0];
                if (dt.Rows.Count == 0)
                {
                    servidor.cerrarconexion();
                    _Lista.ShowMessage(__mensaje, __pagina, Mensaje, "");
                }
                else
                {
                    int Cantidad_CIs_CMDB = Obtener_Cantidad_CIs_CMDB();
                    int CantidadCorrectos = dt.Rows.Count;

                    // Add summary rows
                    dt.Rows.Add("CANTIDAD DE CIs EN LA CMDB:", Cantidad_CIs_CMDB.ToString(), "", "", null);
                    dt.Rows.Add("CANTIDAD DE CIs CON DATOS INCORRECTOS:", CantidadCorrectos.ToString(), "", "", null);
                    int x = (CantidadCorrectos * 100) / Cantidad_CIs_CMDB;
                    dt.Rows.Add("% DE CIs CON DATOS INCORRECTOS:", x.ToString() + "%", "", "", null);

                    string msg = "";
                    if (cbfs.Checked == true)
                    {
                        msg = "REPORTE DE CIs CON DATOS INCORRECTOS COMPRENDIDO DESDE EL " + txtFechaInicioSeguimiento.Text.Trim() + " HASTA EL " + txtFechaFinSeguimiento.Text.Trim();
                    }
                    IMPRIMIR.Page.Session.Add("Imprimir", new Object[] { "REPORTE_DATOS_INCORRECTOS_CIs", dt, msg });

                    // Serialize DataTable to JSON for client-side grid
                    JavaScriptSerializer serializer = new JavaScriptSerializer();
                    string jsonData = serializer.Serialize(GetDataTableArray(dt));
                    datosJson.Value = jsonData;

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

    private List<Dictionary<string, object>> GetDataTableArray(DataTable dt)
    {
        List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
        foreach (DataRow dr in dt.Rows)
        {
            Dictionary<string, object> row = new Dictionary<string, object>();
            foreach (DataColumn col in dt.Columns)
            {
                row[col.ColumnName] = dr[col] != DBNull.Value ? dr[col].ToString() : "";
            }
            rows.Add(row);
        }
        return rows;
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

        Cargar_Datos(this.ddltci, "[dbo].[pr_Obtener_Tipos_Elemento_Configuracion_2]", "Error, al intentar recuperar Estado Elemento Configuracion.");
        if (this.__mensaje.Value.ToString().Trim() != "")
        {
            return;
        }

        if (Session["OpcionBusqueda"] == null)
        {
            // No action on initial load
        }
        else
        {
            Object[] ob = (Object[])Session["OpcionBusqueda"];

            this.cbtci.Checked = (bool)ob[3];
            ddltci.Enabled = (bool)ob[3];
            for (int i = 0; i < this.ddltci.Items.Count; i++)
            {
                if (this.ddltci.Items[i].Text == ob[2].ToString().Trim())
                    this.ddltci.SelectedIndex = i;
            }

            this.cbdci.Checked = (bool)ob[7];
            ddldci.Enabled = (bool)ob[7];
            for (int i = 0; i < this.ddldci.Items.Count; i++)
            {
                if (this.ddldci.Items[i].Text == ob[6].ToString().Trim())
                    this.ddldci.SelectedIndex = i;
            }

            this.cbfs.Checked = (bool)ob[22];
            txtFechaInicioSeguimiento.Enabled = (bool)ob[22];
            txtFechaFinSeguimiento.Enabled = (bool)ob[22];
            txtFechaInicioSeguimiento.Text = ob[20].ToString().Trim();
            txtFechaFinSeguimiento.Text = ob[21].ToString().Trim();

            this.Elementos_Configuracion_Seguidos(ob[0].ToString().Trim(),
            ob[2].ToString().Trim(),
            ob[4].ToString().Trim(),
            ob[6].ToString().Trim(),
            ob[8].ToString().Trim(),
            ob[10].ToString().Trim(),
            ob[12].ToString().Trim(),
            ob[14].ToString().Trim(),
            ob[16].ToString().Trim(),
            ob[18].ToString().Trim(),
            ob[20].ToString().Trim(),
            ob[21].ToString().Trim(),
            ob[23].ToString().Trim(),
            "No hay Elementos Configuracion con los criterios seleccionados");
        }
    }

    protected void cbtci_CheckedChanged(object sender, EventArgs e)
    {
        Session["OpcionBusqueda"] = null;
        _Lista.ShowMessage(__mensaje, __pagina, "", "");
        ddltci.Enabled = cbtci.Checked; ddltci.SelectedIndex = 0; ddltci.Focus();
        this.ddldci.Items.Clear();
        this.ddldci.Items.Insert(0, "______SELECCIONE DESCRIPCION CI_____");
        this.ddldci.Items[0].Value = "-1";
    }

    protected void cbdci_CheckedChanged(object sender, EventArgs e)
    {
        Session["OpcionBusqueda"] = null;
        _Lista.ShowMessage(__mensaje, __pagina, "", "");
        ddldci.Enabled = cbdci.Checked; ddldci.SelectedIndex = 0; ddldci.Focus();
    }

    protected void cbfs_CheckedChanged(object sender, EventArgs e)
    {
        Session["OpcionBusqueda"] = null;
        _Lista.ShowMessage(__mensaje, __pagina, "", "");
        txtFechaInicioSeguimiento.Enabled = cbfs.Checked; txtFechaInicioSeguimiento.Text = "";
        txtFechaFinSeguimiento.Enabled = cbfs.Checked; txtFechaFinSeguimiento.Text = "";
    }

    protected void lbtnBuscar_Click(object sender, EventArgs e)
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");

        Object[] ob;

        bool ok = cbtci.Checked == true ||
        cbdci.Checked == true ||
        cbfs.Checked == true;
        if (ok == false)
        {
            _Lista.ShowMessage(__mensaje, __pagina, "Seleccione criterio(s) de busqueda.", "");
            return;
        }

        if (cbtci.Checked == true && cbfs.Checked == false)
        {
            _Lista.ShowMessage(__mensaje, __pagina, "Seleccione fecha seguimiento.", "");
            return;
        }

        if (cbtci.Checked == true)
        {
            if (ddltci.Items[ddltci.SelectedIndex].Value == (-1).ToString())
            {
                _Lista.ShowMessage(__mensaje, __pagina, "Seleccione tipo CI.", "");
                ddltci.Focus();
                return;
            }
        }

        if (cbdci.Checked == true)
        {
            if (ddldci.Items[ddldci.SelectedIndex].Value == (-1).ToString())
            {
                _Lista.ShowMessage(__mensaje, __pagina, "Seleccione Descripcion CI.", "");
                ddldci.Focus();
                return;
            }
        }

        if (cbfs.Checked == true)
        {
            if (txtFechaInicioSeguimiento.Text.Trim() == "")
            {
                _Lista.ShowMessage(__mensaje, __pagina, "Ingrese Fecha Inicio Seguimineto CI.", "");
                txtFechaInicioSeguimiento.Focus();
                return;
            }
            if (txtFechaFinSeguimiento.Text.Trim() == "")
            {
                _Lista.ShowMessage(__mensaje, __pagina, "Ingrese Fecha Fin Seguimineto CI.", "");
                txtFechaFinSeguimiento.Focus();
                return;
            }
        }
        if (cbfs.Checked == true)
        {
            if (!(Convert.ToDateTime(txtFechaInicioSeguimiento.Text.Trim()) <= Convert.ToDateTime(txtFechaFinSeguimiento.Text.Trim())))
            {
                _Lista.ShowMessage(__mensaje, __pagina, "Fecha Inicio Seguimineto CI de ser menor o igual a la  Fecha Fin Seguimineto CI.", "");
                return;
            }
        }

        ob = new Object[] {
             "", false,
             Convert.ToInt32(ddltci.SelectedValue)==-1?"": ddltci.SelectedItem.Text, this.cbtci.Checked,
            "", false,
             Convert.ToInt32(ddldci.SelectedValue)==-1?"": ddldci.SelectedItem.Text, this.cbdci.Checked,
             "", false,
             "", false,
             "", false,
             "", false,
             "", false,
            "", false,
             txtFechaInicioSeguimiento.Text.Trim(),txtFechaFinSeguimiento.Text.Trim(), this.cbfs.Checked,
             "", false,
        };
        Session["OpcionBusqueda"] = ob;

        Response.Clear();
        Response.Redirect("ReporteDatosIncorrectosCI.aspx");
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

    private int Obtener_Cantidad_CIs_CMDB()
    {
        int Cantidad = 0;

        try
        {
            policia.clsaccesodatos servidor = new policia.clsaccesodatos();
            servidor.cadenaconexion = Ruta;
            if (servidor.abrirconexion() == true)
            {
                System.Data.DataTable dt;
                dt = servidor.consultar("[dbo].[prCantidad_CIs_CMDB]").Tables[0];
                if (dt.Rows.Count == 0)
                {
                    servidor.cerrarconexion();
                    this.__mensaje.Value = "Error al intentar obtener fecha del sistema";
                    this.__pagina.Value = "";
                }
                else
                {
                    Cantidad = Convert.ToInt32(dt.Rows[0].ItemArray[0]);
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
        return Cantidad;
    }

    protected void ddltci_SelectedIndexChanged(object sender, EventArgs e)
    {
        this.__mensaje.Value = "";
        this.__pagina.Value = "";
        this.ddldci.Items.Clear();
        this.ddldci.Items.Insert(0, "______SELECCIONE DESCRIPCION CI_____");
        this.ddldci.Items[0].Value = "-1";
        int Codigo_TipoCI = Convert.ToInt32(ddltci.SelectedValue);
        if (Codigo_TipoCI == -1)
        {
            this.__mensaje.Value = "Seleccione Tipo Elemento Configuracion";
            this.__pagina.Value = "";
            return;
        }
        Cargar_Datos(this.ddldci, "[dbo].[pr_Descripcion_Elemento_Configuracion_2]", "Error, al intentar recuperar Descripcion Elemento Configuracion.", new Object[] { Codigo_TipoCI });
        if (this.__mensaje.Value.ToString().Trim() != "")
        {
            return;
        }
    }
}
