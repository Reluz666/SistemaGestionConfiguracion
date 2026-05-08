using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;

public partial class RelacionesElementosConfiguracion : System.Web.UI.Page
{
    //private String Ruta = "SERVER=JOSE-PC;DATABASE=GCS;Encrypt=False;INTEGRATED SECURITY=True;packet size=4096;";
    private String Ruta = System.Configuration.ConfigurationManager.ConnectionStrings["CadenaConeccion"].ToString();

    Lista _Lista = new Lista();

    private int Obtener_Nro_Total_CIs_registrados_relativos_a_servicios_TI_CMDB()
    {
        int Cantidad = 0;

        try
        {
            policia.clsaccesodatos servidor = new policia.clsaccesodatos();
            servidor.cadenaconexion = Ruta;
            if (servidor.abrirconexion() == true)
            {
                System.Data.DataTable dt;
                dt = servidor.consultar("[dbo].[prNro_Total_CIs_registrados_relativos_a_servicios_TI_CMDB.]").Tables[0];
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

    private void Listar_Relacion_Elementos_Configuracion(string PADRE_CI,
    string PADRE_TIPO_CI,
    string PADRE_ESTADO_CI,
    string PADRE_PROPIETARIO_CI,
    string PADRE_DESCRIPCION_CI,
    string PADRE_SEDE,
    string PADRE_LOCAL,
    string PADRE_AREA,
    string MENSAJE)
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");

        try
        {
            policia.clsaccesodatos servidor = new policia.clsaccesodatos();
            servidor.cadenaconexion = Ruta;

            if (servidor.abrirconexion() == true)
            {
                DataTable dt = servidor.consultar("[dbo].[pr_Reporte_De_CIS_Relativo_A_Servicios]",
                PADRE_CI,
                PADRE_TIPO_CI,
                PADRE_ESTADO_CI,
                PADRE_PROPIETARIO_CI,
                PADRE_DESCRIPCION_CI,
                PADRE_SEDE,
                PADRE_LOCAL,
                PADRE_AREA).Tables[0];

                if (dt.Rows.Count == 0)
                {
                    servidor.cerrarconexion();
                    _Lista.ShowMessage(__mensaje, __pagina, MENSAJE, "");
                    datosJson.Value = "[]";
                }
                else
                {
                    int T = Obtener_Nro_Total_CIs_registrados_relativos_a_servicios_TI_CMDB();
                    int A = dt.Rows.Count;
                    int X = (A * 100) / T;

                    this.T.Text = "Nro. Total de los CIs registrados que son relativos a los servicios de TI en la CMDB: " + T.ToString();
                    this.A.Text = "Nro. de CIs relativos a uno o más servicios de TI: " + A.ToString();
                    this.X.Text = "% de CIs relativo a servicios: " + X.ToString();

                    // Apply dedup logic and build JSON data
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        string ant = dt.Rows[i]["PADRE DESCRIPCION CI"].ToString();
                        for (int j = i + 1; j < dt.Rows.Count; j++)
                        {
                            string sig = dt.Rows[j]["PADRE DESCRIPCION CI"].ToString();
                            if (ant.Equals(sig))
                            {
                                DataRow FilaTabla = dt.Rows[j];
                                FilaTabla.BeginEdit();
                                FilaTabla["PADRE CI"] = "";
                                FilaTabla["PADRE TIPO CI"] = "";
                                FilaTabla.EndEdit();
                                dt.AcceptChanges();
                                A = A - 1;
                            }
                        }
                    }

                    // Build JSON for client-side rendering
                    var jsonData = new List<Dictionary<string, string>>();
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        var row = new Dictionary<string, string>();

                        // Build PADRE CI HTML
                        if (dt.Rows[i]["PADRE CI"].ToString().Trim() == "")
                        {
                            row["PADRE CI"] = "";
                            row["PADRE_CI_HTML"] = "";
                        }
                        else
                        {
                            row["PADRE CI"] = dt.Rows[i]["PADRE CI"].ToString();
                            row["PADRE_CI_HTML"] = "<span class='color-blue'><b>Nombre: </b>" + dt.Rows[i]["PADRE CI"].ToString() + "</span> " +
                                "<b>Tipo:</b> " + dt.Rows[i]["PADRE TIPO CI"].ToString() + " " +
                                "<b>Nro Serie: </b>" + dt.Rows[i]["PADRE NRO SERIE"].ToString() + " " +
                                "<b>Direccion IP: </b>" + dt.Rows[i]["PADRE IP"].ToString() + " " +
                                "<b>Direccion Gateway: </b>" + dt.Rows[i]["PADRE GATEWAY"].ToString() + " " +
                                "<b>Grupo de Trabajo: </b>" + dt.Rows[i]["PADRE GRUPO TRABAJO"].ToString() + " " +
                                "<b>Fabricante / Proveedor: </b>" + dt.Rows[i]["PADRE FABICANTE / PROVEEDOR"].ToString() + " " +
                                "<b>Estado:</b> " + dt.Rows[i]["PADRE ESTADO CI"].ToString() + " " +
                                "<b>Propietario:</b> " + dt.Rows[i]["PADRE PROPIETARIO CI"].ToString() + "<br/>" +
                                "<b>Descripcion: </b>" + dt.Rows[i]["PADRE DESCRIPCION CI"].ToString() + " " +
                                "<b>Prioridad: </b>" + dt.Rows[i]["PADRE NIVEL PRIORIDAD"].ToString() + " " +
                                "<b>Sede: </b>" + dt.Rows[i]["PADRE SEDE"].ToString() + " " +
                                "<b>Local: </b>" + dt.Rows[i]["PADRE LOCAL"].ToString() + "<br/>" +
                                "<span class='color-red'><b>Area: </b>" + dt.Rows[i]["PADRE AREA"].ToString() + " " +
                                "<b>Nro. Piso: </b>" + dt.Rows[i]["PADRE NRO PISO"].ToString() + " " +
                                "<b>Nro. Ambiente: </b>" + dt.Rows[i]["PADRE NRO AMBIENTE"].ToString() + " " +
                                "<b>Ubicacion: </b>" + dt.Rows[i]["PADRE UBICACION"].ToString() + "</span><br/>" +
                                "<span class='color-red'><b>Direccion: </b>" + dt.Rows[i]["PADRE DIRECCION LOCAL"].ToString() + "</span>";
                        }

                        // Build HIJO CI HTML
                        row["HIJO CI"] = dt.Rows[i]["HIJO CI"].ToString();
                        row["HIJO_CI_HTML"] = "<span class='color-blue'><b>Nombre: </b>" + dt.Rows[i]["HIJO CI"].ToString() + "</span> " +
                            "<b>Tipo:</b> " + dt.Rows[i]["HIJO TIPO CI"].ToString() + " " +
                            "<b>Nro Serie: </b>" + dt.Rows[i]["HIJO NRO SERIE"].ToString() + " " +
                            "<b>Direccion IP: </b>" + dt.Rows[i]["HIJO IP"].ToString() + " " +
                            "<b>Direccion Gateway: </b>" + dt.Rows[i]["HIJO GATEWAY"].ToString() + " " +
                            "<b>Grupo de Trabajo: </b>" + dt.Rows[i]["HIJO GRUPO TRABAJO"].ToString() + " " +
                            "<b>Fabricante / Proveedor: </b>" + dt.Rows[i]["HIJO FABRICANTE / PROVEEDOR"].ToString() + " " +
                            "<b>Estado:</b> " + dt.Rows[i]["HIJO ESTADO CI"].ToString() + " " +
                            "<b>Propietario:</b> " + dt.Rows[i]["HIJO PROPIETARIO CI"].ToString() + "<br/>" +
                            "<b>Descripcion: </b>" + dt.Rows[i]["HIJO DESCRIPCION CI"].ToString() + " " +
                            "<b>Prioridad: </b>" + dt.Rows[i]["HIJO NIVEL PRIORIDAD"].ToString() + " " +
                            "<b>Sede: </b>" + dt.Rows[i]["HIJO SEDE"].ToString() + " " +
                            "<b>Local: </b>" + dt.Rows[i]["HIJO LOCAL"].ToString() + "<br/>" +
                            "<span class='color-red'><b>Area: </b>" + dt.Rows[i]["HIJO AREA"].ToString() + " " +
                            "<b>Nro. Piso: </b>" + dt.Rows[i]["HIJO NRO PISO"].ToString() + " " +
                            "<b>Nro. Ambiente: </b>" + dt.Rows[i]["HIJO NRO AMBIENTE"].ToString() + " " +
                            "<b>Ubicacion: </b>" + dt.Rows[i]["HIJO UBICACION"].ToString() + "</span><br/>" +
                            "<span class='color-red'><b>Direccion: </b>" + dt.Rows[i]["HIJO DIRECCION LOCAL"].ToString() + "</span>";

                        row["TIPO RELACION"] = dt.Rows[i]["TIPO RELACION"].ToString();

                        // Add PADRE AREA for search
                        row["PADRE AREA"] = dt.Rows[i]["PADRE AREA"].ToString();
                        row["HIJO AREA"] = dt.Rows[i]["HIJO AREA"].ToString();

                        jsonData.Add(row);
                    }

                    var serializer = new JavaScriptSerializer();
                    datosJson.Value = serializer.Serialize(jsonData);

                    // Store for printing
                    IMPRIMIR.Page.Session.Add("Imprimir", new Object[] { "REPORTE_DE_CIS_RELATIVO_A_SERVICIOS", dt, "REPORTE DE ELEMENTOS DE CONFIGURACION RELATIVO A SERVICIOS", T, A, X });

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
            this.__pagina.Value = "../CerrarSession.aspx";
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

        if (Session["OpcionBusqueda"] == null)
        {
            this.Listar_Relacion_Elementos_Configuracion("",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "No hay relacion de elementos de configuracion");
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

            this.Listar_Relacion_Elementos_Configuracion(ob[0].ToString().Trim(),
            ob[2].ToString().Trim(),
            ob[4].ToString().Trim(),
            ob[6].ToString().Trim(),
            ob[8].ToString().Trim(),
            ob[10].ToString().Trim(),
            ob[12].ToString().Trim(),
            ob[14].ToString().Trim(),
            "No hay relacion de elementos de configuracion, con los criterios seleccionados");
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

    protected void cbl_CheckedChanged(object sender, EventArgs e)
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");
        ddll.Enabled = cbl.Checked;
        this.ddll.SelectedIndex = -1;
        this.ddll.Focus();
    }

    protected void lbtnBuscar_Click(object sender, EventArgs e)
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");

        String _NOMBRE_CI = "";
        String _PROPIETARIO_CI = "";

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
            _Lista.ShowMessage(__mensaje, __pagina, "Seleccione criterio(s) de busqueda.", "");
            return;
        }

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
                _Lista.ShowMessage(__mensaje, __pagina, "Seleccione estado CI.", "");
                ddleci.Focus();
                return;
            }
        }
        else if (cbpci.Checked == true)
        {
            _PROPIETARIO_CI = txtpci.Text.Trim();
            if (_PROPIETARIO_CI.Trim().Length == 0)
            {
                _Lista.ShowMessage(__mensaje, __pagina, "Ingrese propietario del elemento de configuracion.", "");
                txtpci.Focus();
                return;
            }
        }
        else if (cbdci.Checked == true)
        {
            if (ddldci.SelectedValue == (-1).ToString())
            {
                _Lista.ShowMessage(__mensaje, __pagina, "Seleccione descripcion CI.", "");
                ddldci.Focus();
                return;
            }
        }
        else if (cbs.Checked == true)
        {
            if (ddls.SelectedValue == (-1).ToString())
            {
                _Lista.ShowMessage(__mensaje, __pagina, "Seleccione sede.", "");
                ddls.Focus();
                return;
            }
        }
        else if (cbl.Checked == true)
        {
            if (ddll.SelectedValue == (-1).ToString())
            {
                _Lista.ShowMessage(__mensaje, __pagina, "Seleccione local.", "");
                ddll.Focus();
                return;
            }
        }
        else if (cba.Checked == true)
        {
            if (ddla.SelectedValue == (-1).ToString())
            {
                _Lista.ShowMessage(__mensaje, __pagina, "Seleccione area.", "");
                ddla.Focus();
                return;
            }
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
        Response.Redirect("Reporte_De_CIS_Relativo_A_Servicios.aspx");
        Response.Flush();
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
        Response.Redirect("Reporte_De_CIS_Relativo_A_Servicios.aspx");
        Response.Flush();
    }

    protected void cbnci_CheckedChanged(object sender, EventArgs e)
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");
        txtnci.Enabled = this.cbnci.Checked;
        txtnci.Text = "";
        txtnci.Focus();
    }

    protected void cbtci_CheckedChanged(object sender, EventArgs e)
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");
        ddltci.Enabled = this.cbtci.Checked;
        ddltci.SelectedIndex = -1;
        ddltci.Focus();
    }

    protected void cbeci_CheckedChanged(object sender, EventArgs e)
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");
        ddleci.Enabled = this.cbeci.Checked;
        ddleci.SelectedIndex = -1;
        ddleci.Focus();
    }

    protected void cbpci_CheckedChanged(object sender, EventArgs e)
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");
        txtpci.Enabled = this.cbpci.Checked;
        txtpci.Text = "";
        txtpci.Focus();
    }

    protected void cbdci_CheckedChanged(object sender, EventArgs e)
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");
        ddldci.Enabled = this.cbdci.Checked;
        ddldci.SelectedIndex = -1;
        ddldci.Focus();
    }

    protected void cbs_CheckedChanged(object sender, EventArgs e)
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");
        ddls.Enabled = this.cbs.Checked;
        ddls.SelectedIndex = -1;
        ddls.Focus();
    }

    protected void cbl_CheckedChanged1(object sender, EventArgs e)
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");
        ddll.Enabled = this.cbl.Checked;
        ddll.SelectedIndex = -1;
        ddll.Focus();
    }

    protected void cba_CheckedChanged(object sender, EventArgs e)
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");
        ddla.Enabled = this.cba.Checked;
        ddla.SelectedIndex = -1;
        ddla.Focus();
    }
}
