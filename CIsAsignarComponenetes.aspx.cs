using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ElementosConfiguracion : System.Web.UI.Page
{
    //private String Ruta = "SERVER=JOSE-PC;DATABASE=GCS;Encrypt=False;INTEGRATED SECURITY=True;packet size=4096;";
    private String Ruta = System.Configuration.ConfigurationManager.ConnectionStrings["CadenaConeccion"].ToString();
    System.Web.UI.WebControls.TableRow tRow;

    Lista _Lista = new Lista();

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
        catch (Exception ex)
        {
            datosJson.Value = "[]";
        }
    }

    private void Listar_Elementos_Configuracion(String NOMBRE_CI, String TIPO_CI, String ESTADO_CI,
    String PROPIETARIO_CI, String DESCRIPCION_CI, String IMPACTO_CI, String SEDE, String LOCAL, String AREA, String NRO_SERIE, String MARCA, String Mensaje)
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");

        for (int i = 1; i < this.Table_.Rows.Count; i++)
        {
            this.Table_.Rows[i].Cells.Clear();
        }

        try
        {
            policia.clsaccesodatos servidor = new policia.clsaccesodatos();

            servidor.cadenaconexion = Ruta;

            if (servidor.abrirconexion() == true)
            {
                DataTable dt = servidor.consultar(" [dbo].[pr_ListaElementosConfiguracionAsignarComponenetes]", NOMBRE_CI, TIPO_CI, ESTADO_CI, PROPIETARIO_CI, DESCRIPCION_CI, IMPACTO_CI, SEDE, LOCAL, AREA, NRO_SERIE, MARCA).Tables[0];

                if (dt.Rows.Count == 0)
                {
                    servidor.cerrarconexion();

                    _Lista.ShowMessage(__mensaje, __pagina, Mensaje, "");
                }
                else
                {
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        tRow = new TableRow();

                        for (int j = 0; j < Table_.Rows[i].Cells.Count; j++)//Cabecera de la tabla
                        {
                            TableCell tCell = new TableCell();
                            tRow.BorderColor = System.Drawing.Color.Black;

                            switch (j)
                            {

                                case 0:

                                    tCell.Text = dt.Rows[i]["ID CI"].ToString();

                                    tCell.Visible = false;

                                    tRow.Cells.Add(tCell);

                                    break;

                                case 1:

                                    tCell.Text = dt.Rows[i]["NOMBRE CI"].ToString();

                                    tCell.HorizontalAlign = HorizontalAlign.Left;

                                    //tCell.BackColor = System.Drawing.Color.LemonChiffon;

                                    tCell.Visible = true;

                                    tRow.Cells.Add(tCell);

                                    break;

                                case 2:

                                    tCell.Text = dt.Rows[i]["ID TIPO CI"].ToString();

                                    tCell.HorizontalAlign = HorizontalAlign.Left;

                                    //tCell.BackColor = System.Drawing.Color.LemonChiffon;

                                    tCell.Visible = false;

                                    tRow.Cells.Add(tCell);

                                    break;

                                case 3:

                                    tCell.Text = dt.Rows[i]["NOMBRE TIPO CI"].ToString();

                                    tCell.HorizontalAlign = HorizontalAlign.Left;

                                    //tCell.BackColor = System.Drawing.Color.LemonChiffon;

                                    tCell.Visible = true;

                                    tRow.Cells.Add(tCell);

                                    break;

                                case 4:

                                    tCell.Text = dt.Rows[i]["NRO SERIE"].ToString();

                                    tCell.HorizontalAlign = HorizontalAlign.Left;

                                    //tCell.BackColor = System.Drawing.Color.LemonChiffon;

                                    tCell.Visible = true;

                                    tRow.Cells.Add(tCell);

                                    break;

                                case 5:

                                    tCell.Text = "<font color=red>" + dt.Rows[i]["MARCA"].ToString() + "</font> / <font color=blue>" + dt.Rows[i]["MODELO"].ToString() + "</font>";

                                    tCell.HorizontalAlign = HorizontalAlign.Left;

                                    //tCell.BackColor = System.Drawing.Color.LemonChiffon;

                                    tCell.Visible = true;

                                    tRow.Cells.Add(tCell);

                                    break;

                                case 6:

                                    if (dt.Rows[i]["ESTADO CI"].ToString().Equals("ACTIVO"))
                                    {
                                        tCell.ForeColor = System.Drawing.Color.Blue;
                                    }
                                    else
                                    {
                                        tCell.ForeColor = System.Drawing.Color.Red;
                                    }

                                    tCell.Text = dt.Rows[i]["ESTADO CI"].ToString();

                                    tCell.HorizontalAlign = HorizontalAlign.Left;

                                    //tCell.BackColor = System.Drawing.Color.LemonChiffon;

                                    tCell.Visible = true;

                                    tRow.Cells.Add(tCell);

                                    break;

                               

                                case 7:

                                    tCell.Text = dt.Rows[i]["DESCRIPCION CI"].ToString();

                                    tCell.HorizontalAlign = HorizontalAlign.Left;

                                    //tCell.BackColor = System.Drawing.Color.LemonChiffon;

                                    tCell.Visible = true;

                                    tRow.Cells.Add(tCell);

                                    break;

                                case 8:

                                    tCell.Text = dt.Rows[i]["SEDE"].ToString();

                                    tCell.HorizontalAlign = HorizontalAlign.Left;

                                    //tCell.BackColor = System.Drawing.Color.LemonChiffon;

                                    tCell.Visible = true;

                                    tRow.Cells.Add(tCell);

                                    break;

                                case 9:

                                    tCell.Text = dt.Rows[i]["LOCAL"].ToString();

                                    tCell.HorizontalAlign = HorizontalAlign.Left;

                                    //tCell.BackColor = System.Drawing.Color.LemonChiffon;

                                    tCell.Visible = true;

                                    tRow.Cells.Add(tCell);

                                    break;

                                case 10:

                                    tCell.Text = dt.Rows[i]["UBICACION LOCAL"].ToString();

                                    tCell.HorizontalAlign = HorizontalAlign.Left;

                                    //tCell.BackColor = System.Drawing.Color.LemonChiffon;

                                    tCell.Visible = true;

                                    tRow.Cells.Add(tCell);

                                    break;

                                case 11:

                                    tCell.Text = dt.Rows[i]["DIRECCION LOCAL"].ToString();

                                    tCell.HorizontalAlign = HorizontalAlign.Left;

                                    //tCell.BackColor = System.Drawing.Color.LemonChiffon;

                                    tCell.Visible = true;

                                    tRow.Cells.Add(tCell);

                                    break;

                                case 12:

                                    tCell.Text = dt.Rows[i]["AREA"].ToString();

                                    tCell.HorizontalAlign = HorizontalAlign.Left;

                                    //tCell.BackColor = System.Drawing.Color.LemonChiffon;

                                    tCell.Visible = true;

                                    tRow.Cells.Add(tCell);

                                    break;

                                case 13:

                                    tCell.Text = dt.Rows[i]["NRO PISO"].ToString();

                                    tCell.HorizontalAlign = HorizontalAlign.Left;

                                    //tCell.BackColor = System.Drawing.Color.LemonChiffon;

                                    tCell.Visible = true;

                                    tRow.Cells.Add(tCell);

                                    break;

                                case 14:

                                    tCell.Text = dt.Rows[i]["NRO AMBIENTE"].ToString();

                                    tCell.HorizontalAlign = HorizontalAlign.Left;

                                    //tCell.BackColor = System.Drawing.Color.LemonChiffon;

                                    tCell.Visible = true;

                                    tRow.Cells.Add(tCell);

                                    break;


                                case 15:

                                    //verificar permiso para enviar datos.
                                    string[] Datos = (string[])Session["__JSAR__"];
                                    bool rpta = this.VERIFICAR_PERMISOS_DERECHOS_ACCESO_PAGINA_WEB(Convert.ToInt32(Datos[0]),
                                    "CIsAsignarComponenetes.aspx", "GENERAR");

                                    if (rpta == true)
                                    {
                                        System.Web.UI.WebControls.HyperLink h = new System.Web.UI.WebControls.HyperLink();

                                        h.Height = 25;

                                        h.Text = "COPONENTES";

                                        h.BorderStyle = BorderStyle.None;

                                        h.Attributes.Add("onclick", "return Confirmar('¿Desea generar componentes para el CI seleccionadol?');");

                                        h.NavigateUrl = "~/ComponenteCI.aspx?IDCI=" + dt.Rows[i]["ID CI"].ToString();

                                        tCell.HorizontalAlign = HorizontalAlign.Center;

                                        tCell.Controls.Add(h);

                                        tRow.Cells.Add(tCell);
                                    }
                                    else
                                    {
                                        tCell.Text = "SIN PERMISO PARA GENERAR COMPONENTES CI";
                                        tCell.ForeColor = System.Drawing.Color.Red;
                                        tCell.Font.Bold = true;
                                        tCell.Visible = true;
                                        tRow.Cells.Add(tCell);
                                    }

                                    break;

                            }
                        }

                        this.Table_.Rows.Add(tRow);
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
        catch (Exception ex)
        {
            _Lista.ShowMessage(__mensaje, __pagina, "Error inesperado al intentar conectarnos con el servidor.", "../CerrarSession.aspx");
        }
    }
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void Page_init(object sender, EventArgs e)
    {
        // Cargar datos JSON para la lista con busqueda y paginacion
        Cargar_Datos_Json();

        _Lista.ShowMessage(__mensaje, __pagina, "", "");

        string[] Datos = (string[])Session["__JSAR__"];

        if (Datos == null)
        {

            this.__mensaje.Value = "Ud. no esta autorizado para ingresar a esta página, inicie sesion por favor.";

            this.__pagina.Value = "CerrarSession.aspx";

            return;

        }

        //verificar permiso para acceder a esta pagina.
        bool rpta = this.VERIFICAR_PERMISO_ACCESO_PAGINA_WEB(Convert.ToInt32(Datos[0]),
        "CIsAsignarComponenetes.aspx");
        if (rpta == false)
        {
            this.__mensaje.Value = "Ud. no tiene permiso para ACCEDER esta pagina web.";
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
            this.Listar_Elementos_Configuracion("","","", "", "", "", "", "", "", "", "", "No hay Elementos Configuracion");
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

        //this.Listar_Elementos_Configuracion("","","", "","","","","","", "No hay Elementos Configuracion");
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

    protected void lbtnBuscar_Click(object sender, EventArgs e)
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");

        //verificar permiso para eliminar datos.
        string[] Datos = (string[])Session["__JSAR__"];
        bool rpta = this.VERIFICAR_PERMISOS_DERECHOS_ACCESO_PAGINA_WEB(Convert.ToInt32(Datos[0]),
        "CIsAsignarComponenetes.aspx", "BUSCAR");
        if (rpta == false)
        {
            this.__mensaje.Value = "Ud. no esta autorizado para BUSCAR datos en esta pagina web.";
            this.__pagina.Value = "CerrarSession.aspx";
            return;
        }

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
        if(ok==false) {
            _Lista.ShowMessage(__mensaje, __pagina, "Seleccione criterio(s) de busqueda.", "");
            return;
        }

        String _NOMBRE_CI = "";
        String _NRO_SERIE = "";
        if (cbnci.Checked == true)
        {
            _NOMBRE_CI = txtnci.Text.Trim();
            if(_NOMBRE_CI.Trim().Length==0) {
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
        }else if (cbns.Checked == true)
        {
           _NRO_SERIE = txtns.Text.Trim();
            if (_NRO_SERIE.Trim().Length == 0)
            {
                _Lista.ShowMessage(__mensaje, __pagina, "Ingrese Nro Serie elemento de configuracion.", "");
                txtns.Focus();
                return;
            }

        }
        //this.Listar_Elementos_Configuracion(_NOMBRE_CI, _TIPO_CI, _ESTADO_CI, _PROPIETARIO_CI, _DESCRIPCION_CI, _IMPACTO_CI, _SEDE, _LOCAL, _AREA, "No hay Elementos de Configuracion con el criterio o criterios seleccionados.");

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
        Response.Redirect("CIsAsignarComponenetes.aspx");
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
        catch (Exception ex)
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

        //verificar permiso para enviar datos.
        string[] Datos = (string[])Session["__JSAR__"];
        bool rpta = this.VERIFICAR_PERMISOS_DERECHOS_ACCESO_PAGINA_WEB(Convert.ToInt32(Datos[0]),
        "CIsAsignarComponenetes.aspx", "ACTUALIZAR");
        if (rpta == false)
        {
            this.__mensaje.Value = "Ud. no esta autorizado para ACTUALIZAR INFORMACION en esta pagina web.";
            this.__pagina.Value = "CerrarSession.aspx";
            return;
        }

        Session["OpcionBusqueda"] = null;
        Response.Clear();
        Response.Redirect("CIsAsignarComponenetes.aspx");
        Response.Flush();
        _Lista.ShowMessage(__mensaje, __pagina, "", "");
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
        catch (Exception ex)
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
        catch (Exception ex)
        {
            ok = false;
            this.__mensaje.Value = "Error inesperado al intentar conectarnos con el servidor.";
            this.__pagina.Value = "";
        }
        return ok;
    }
}