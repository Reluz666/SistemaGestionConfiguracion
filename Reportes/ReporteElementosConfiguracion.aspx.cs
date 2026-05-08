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

    DataTable dt;

    Lista _Lista = new Lista();

    private void Listar_Elementos_Configuracion(String NOMBRE_CI, String TIPO_CI, String ESTADO_CI,
    String PROPIETARIO_CI, String DESCRIPCION_CI, String IMPACTO_CI, String SEDE, String LOCAL, String AREA, String RESPONSABLE, String NIVEL_PRIORIDAD, String MARCA, String MODELO, String FECHA_INICIO_CREACION_CI, String FECHA_FIN_CREACION_CI, String Mensaje)
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");

        for (int i = 1; i < this.Table_.Rows.Count; i++)
        {
            this.Table_.Rows[i].Cells.Clear();
        }

        //try
        //{
            policia.clsaccesodatos servidor = new policia.clsaccesodatos();

            servidor.cadenaconexion = Ruta;

            if (servidor.abrirconexion() == true)
            {
                dt = servidor.consultar(" [dbo].[pr_ReporteElementosConfiguracion]", NOMBRE_CI, TIPO_CI, ESTADO_CI, PROPIETARIO_CI, DESCRIPCION_CI, IMPACTO_CI, SEDE, LOCAL, AREA, RESPONSABLE, NIVEL_PRIORIDAD, MARCA, MODELO, FECHA_INICIO_CREACION_CI, FECHA_FIN_CREACION_CI).Tables[0];

                if (dt.Rows.Count == 0)
                {
                    servidor.cerrarconexion();

                    _Lista.ShowMessage(__mensaje, __pagina, Mensaje, "");
                }
                else
                {
                    IMPRIMIR.Page.Session.Add("Imprimir", new Object[] { "REPORTE_ELEMENTOS_CONFIGURACION", dt, "REPORTE DE ELEMENTOS DE CONFIGURACION" });
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

                                    tCell.Text = dt.Rows[i]["NOMBRE TIPO CI"].ToString();

                                    tCell.HorizontalAlign = HorizontalAlign.Left;

                                    //tCell.BackColor = System.Drawing.Color.LemonChiffon;

                                    tCell.Visible = true;

                                    tRow.Cells.Add(tCell);

                                    break;

                                case 3:

                                    tCell.Text = dt.Rows[i]["NRO SERIE"].ToString();

                                    tCell.HorizontalAlign = HorizontalAlign.Left;

                                    //tCell.BackColor = System.Drawing.Color.LemonChiffon;

                                    tCell.Visible = true;

                                    tRow.Cells.Add(tCell);

                                    break;

                                case 4:

                                    tCell.Text = dt.Rows[i]["FABRICANTE / PROVEEDOR"].ToString();

                                    tCell.HorizontalAlign = HorizontalAlign.Left;

                                    //tCell.BackColor = System.Drawing.Color.LemonChiffon;

                                    tCell.Visible = true;

                                    tRow.Cells.Add(tCell);

                                    break;

                                case 5:

                                    tCell.Text = "<font color=blue><b>" + dt.Rows[i]["MARCA"].ToString() + "</b></font> / <font color=red><b>" + dt.Rows[i]["MODELO"].ToString() + "</b></font>";

                                    tCell.HorizontalAlign = HorizontalAlign.Left;

                                    //tCell.BackColor = System.Drawing.Color.LemonChiffon;

                                    tCell.Visible = true;

                                    tRow.Cells.Add(tCell);

                                    break;

                                case 6:

                                    tCell.Text = dt.Rows[i]["IP"].ToString();

                                    tCell.HorizontalAlign = HorizontalAlign.Left;

                                    //tCell.BackColor = System.Drawing.Color.LemonChiffon;

                                    tCell.Visible = true;

                                    tRow.Cells.Add(tCell);

                                    break;

                                case 7:

                                    tCell.Text = dt.Rows[i]["GATEWAY"].ToString();

                                    tCell.HorizontalAlign = HorizontalAlign.Left;

                                    //tCell.BackColor = System.Drawing.Color.LemonChiffon;

                                    tCell.Visible = true;

                                    tRow.Cells.Add(tCell);

                                    break;

                                case 8:

                                    tCell.Text = dt.Rows[i]["GRUPO TRABAJO"].ToString();

                                    tCell.HorizontalAlign = HorizontalAlign.Left;

                                    //tCell.BackColor = System.Drawing.Color.LemonChiffon;

                                    tCell.Visible = true;

                                    tRow.Cells.Add(tCell);

                                    break;

                                case 9:

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
                             
                                case 10:

                                    tCell.Text = dt.Rows[i]["PROPIETARIO"].ToString();

                                    tCell.HorizontalAlign = HorizontalAlign.Left;

                                    //tCell.BackColor = System.Drawing.Color.LemonChiffon;

                                    tCell.Visible = true;

                                    tRow.Cells.Add(tCell);

                                    break;

                                case 11:

                                    tCell.Text = dt.Rows[i]["DESCRIPCION CI"].ToString();

                                    tCell.HorizontalAlign = HorizontalAlign.Left;

                                    //tCell.BackColor = System.Drawing.Color.LemonChiffon;

                                    tCell.Visible = true;

                                    tRow.Cells.Add(tCell);

                                    break;

                                case 12:

                                    tCell.Text = dt.Rows[i]["IMPACTO CI"].ToString() + "<b>  /  </b>" + dt.Rows[i]["NIVEL PRIORIDAD"].ToString();

                                    tCell.HorizontalAlign = HorizontalAlign.Left;

                                    //tCell.BackColor = System.Drawing.Color.LemonChiffon;

                                    tCell.Visible = true;

                                    tRow.Cells.Add(tCell);

                                    break;

                                case 13:

                                    tCell.Text = "<FONT COLOR=BLUE><B>" + dt.Rows[i]["SEDE"].ToString() + "</B></FONT> /<BR><FONT COLOR=RED><B>" + dt.Rows[i]["LOCAL"].ToString() + "</B></FONT>";

                                    tCell.HorizontalAlign = HorizontalAlign.Left;

                                    //tCell.BackColor = System.Drawing.Color.LemonChiffon;

                                    tCell.Visible = true;

                                    tRow.Cells.Add(tCell);

                                    break;

                                case 14:

                                    tCell.Text = dt.Rows[i]["UBICACION LOCAL"].ToString();

                                    tCell.HorizontalAlign = HorizontalAlign.Left;

                                    //tCell.BackColor = System.Drawing.Color.LemonChiffon;

                                    tCell.Visible = false;

                                    tRow.Cells.Add(tCell);

                                    break;

                                case 15:

                                    tCell.Text = dt.Rows[i]["DIRECCION LOCAL"].ToString();

                                    tCell.HorizontalAlign = HorizontalAlign.Left;

                                    //tCell.BackColor = System.Drawing.Color.LemonChiffon;

                                    tCell.Visible = false;

                                    tRow.Cells.Add(tCell);

                                    break;                               

                                case 16:

                                    tCell.Text = dt.Rows[i]["AREA"].ToString();

                                    tCell.HorizontalAlign = HorizontalAlign.Left;

                                    //tCell.BackColor = System.Drawing.Color.LemonChiffon;

                                    tCell.Visible = true;

                                    tRow.Cells.Add(tCell);

                                    break;

                                case 17:

                                    tCell.Text = "<FONT COLOR=BLUE><B>" + dt.Rows[i]["NRO PISO"].ToString() + "</B></FONT> / " + "<FONT COLOR=RED><B>" + dt.Rows[i]["NRO AMBIENTE"].ToString() + "</B></FONT>";

                                    tCell.HorizontalAlign = HorizontalAlign.Left;

                                    //tCell.BackColor = System.Drawing.Color.LemonChiffon;

                                    tCell.Visible = true;

                                    tRow.Cells.Add(tCell);

                                    break;

                                case 18:

                                    tCell.Text = dt.Rows[i]["FEC. CREACION CI"].ToString();

                                    tCell.HorizontalAlign = HorizontalAlign.Left;

                                    //tCell.BackColor = System.Drawing.Color.LemonChiffon;

                                    tCell.Visible = true;

                                    tRow.Cells.Add(tCell);

                                    break;

                                case 19:

                                    tCell.Text = dt.Rows[i]["RESPONSABLE"].ToString();

                                    tCell.HorizontalAlign = HorizontalAlign.Left;

                                    //tCell.BackColor = System.Drawing.Color.LemonChiffon;

                                    tCell.Visible = true;

                                    tRow.Cells.Add(tCell);

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

        //}
        //catch (Exception)
        //{
        //    _Lista.ShowMessage(__mensaje, __pagina, "Error inesperado al intentar conectarnos con el servidor.", "../CerrarSession.aspx");
        //}
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
        Cargar_Datos(this.ddlici, "[dbo].[pr_Impacto_Comercial_Elemento_Configuracion_Hardware]", "Error, al intentar recuperar Impactos Comercial Elemento Configuracion.");
        if (this.__mensaje.Value.ToString().Trim() != "")
        {
            return;
        }
        Cargar_Datos(this.ddls, "[dbo].[pr_Obtener_Sedes]", "Error, al intentar recuperar Sedes Judiciales.");
        if (this.__mensaje.Value.ToString().Trim() != "")
        {
            return;
        }
        Cargar_Datos(this.ddlr, "[dbo].[pr_Obtener_Usuarios]", "Error, al intentar recuperar Responsables.");
        if (this.__mensaje.Value.ToString().Trim() != "")
        {
            return;
        }
        Cargar_Datos(this.ddlnp, "[dbo].[pr_Obtener_Niveles_Prioridad]", "Error, al intentar recuperar Nivel Prioridad.");
        if (this.__mensaje.Value.ToString().Trim() != "")
        {
            return;
        }
        Cargar_Datos(this.ddlm, "[dbo].[pr_Obtener_Marcas]", "Error, al intentar recuperar Marcas.");
        if (this.__mensaje.Value.ToString().Trim() != "")
        {
            return;
        }
        Cargar_Datos(this.ddlmo, "[dbo].[pr_Obtener_Modelos]", "Error, al intentar recuperar Modelos.");
        if (this.__mensaje.Value.ToString().Trim() != "")
        {
            return;
        }

        if (Session["OpcionBusqueda"] == null)
        {
            this.Listar_Elementos_Configuracion("", "", "","","","", "", "", "", "", "", "", "", "", "", "No hay Elementos Configuracion");
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

            this.cbici.Checked = (bool)ob[17];
            ddlici.Enabled = (bool)ob[17];
            for (int i = 0; i < this.ddlici.Items.Count; i++)
            {
                if (this.ddlici.Items[i].Text == ob[16].ToString().Trim())
                    this.ddlici.SelectedIndex = i;
            }

            this.cbr.Checked = (bool)ob[19];
            ddlr.Enabled = (bool)ob[19];
            for (int i = 0; i < this.ddlr.Items.Count; i++)
            {
                if (this.ddlr.Items[i].Text == ob[18].ToString().Trim())
                    this.ddlr.SelectedIndex = i;
            }

            this.cbnp.Checked = (bool)ob[21];
            ddlnp.Enabled = (bool)ob[21];
            for (int i = 0; i < this.ddlnp.Items.Count; i++)
            {
                if (this.ddlnp.Items[i].Text == ob[20].ToString().Trim())
                    this.ddlnp.SelectedIndex = i;
            }

            this.cbm.Checked = (bool)ob[23];
            ddlm.Enabled = (bool)ob[23];
            for (int i = 0; i < this.ddlm.Items.Count; i++)
            {
                if (this.ddlm.Items[i].Text == ob[22].ToString().Trim())
                    this.ddlm.SelectedIndex = i;
            }

            this.cbmo.Checked = (bool)ob[25];
            ddlmo.Enabled = (bool)ob[25];
            for (int i = 0; i < this.ddlmo.Items.Count; i++)
            {
                if (this.ddlmo.Items[i].Text == ob[24].ToString().Trim())
                    this.ddlmo.SelectedIndex = i;
            }

            this.cbf.Checked = (bool)ob[28];
            txtfi.Enabled = (bool)ob[28];
            txtff.Enabled = (bool)ob[28];
            txtfi.Text = ob[26].ToString().Trim();
            txtff.Text = ob[27].ToString().Trim();

            this.Listar_Elementos_Configuracion(ob[0].ToString().Trim(),
            ob[2].ToString().Trim(),
            ob[4].ToString().Trim(),
            ob[6].ToString().Trim(),
            ob[8].ToString().Trim(),
            ob[16].ToString().Trim(),
            ob[10].ToString().Trim(),
            ob[12].ToString().Trim(),
            ob[14].ToString().Trim(),
            ob[18].ToString().Trim(),
            ob[20].ToString().Trim(),
            ob[22].ToString().Trim(),
            ob[24].ToString().Trim(),
            ob[26].ToString().Trim(),
            ob[27].ToString().Trim(),
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

    protected void cbici_CheckedChanged(object sender, EventArgs e)
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");
        ddlici.Enabled = cbici.Checked;
        this.ddlici.SelectedIndex = -1;
        this.ddlici.Focus();
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
        cbici.Checked == true ||
        cbs.Checked == true ||
        cbl.Checked == true ||
        cba.Checked == true ||
        cbr.Checked == true ||
        cbnp.Checked == true ||
        cbm.Checked == true ||
        cbmo.Checked == true ||
        cbf.Checked == true);
        if(ok==false) {
            _Lista.ShowMessage(__mensaje, __pagina, "Seleccione criterio(s) de busqueda.", "");
            return;
        }

        String _NOMBRE_CI = "";
        String _TIPO_CI = "";
        String _ESTADO_CI = "";
        String _PROPIETARIO_CI = "";
        String _DESCRIPCION_CI = "";
        String _IMPACTO_CI = "";
        String _SEDE = "";
        String _LOCAL = "";
        String _AREA = "";
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
            _TIPO_CI = ddltci.SelectedItem.Text;   
            //if(ddltci.SelectedValue==(-1).ToString()) {
            //    _Lista.ShowMessage(__mensaje, __pagina, "Seleccione tipo CI.", "");
            //    ddltci.Focus();
            //    return;
            //}         
        }
        else if (cbeci.Checked == true)
        {
            _ESTADO_CI = ddleci.SelectedItem.Text;
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
            _DESCRIPCION_CI = ddldci.SelectedItem.Text;
        }
        else if (cbici.Checked == true)
        {
            _IMPACTO_CI = ddlici.SelectedItem.Text;
        }
        else if (cbs.Checked == true)
        {
            _SEDE = ddls.SelectedItem.Text;
        }
        else if (cbl.Checked == true)
        {
            _LOCAL = ddll.SelectedItem.Text;
        }
        else if (cba.Checked == true)
        {
            _AREA = ddla.SelectedItem.Text;
        }
        else if (cbf.Checked == true)
        {
            if (this.txtfi.Text.Trim() == "")
            {
                _Lista.ShowMessage(__mensaje, __pagina, "Ingrese fecha inicio creacion CI.", "");
                return;
            }
            if (this.txtff.Text.Trim() == "")
            {
                _Lista.ShowMessage(__mensaje, __pagina, "Ingrese fecha fin creacion CI.", "");
                return;
            }
        }

        if (cbf.Checked == true)
        {
            if (!(Convert.ToDateTime(this.txtfi.Text.Trim()) <= Convert.ToDateTime(this.txtff.Text.Trim())))
            {
                _Lista.ShowMessage(__mensaje, __pagina, "Fecha inicio suscripcion debe ser menor o igual que la fecha fin suscripccion.", "");
                return;
            }
        }
        //this.Listar_Elementos_Configuracion(_NOMBRE_CI, _TIPO_CI, _ESTADO_CI, _PROPIETARIO_CI, _DESCRIPCION_CI, _IMPACTO_CI, _SEDE, _LOCAL, _AREA, "No hay Elementos de Configuracion con el criterio o criterios seleccionados.");

        ob = new Object[] {
             txtnci.Text.Trim(), this.cbnci.Checked,
             Convert.ToInt32(ddltci.SelectedValue)==-1?"": ddltci.SelectedItem.Text, this.cbtci.Checked,
             Convert.ToInt32(ddleci.SelectedValue)==-1?"": ddleci.SelectedItem.Text, this.cbeci.Checked,
             txtpci.Text.Trim(), this.cbpci.Checked,
             Convert.ToInt32(ddldci.SelectedValue)==-1?"": ddldci.SelectedItem.Text, this.cbdci.Checked,
             
             Convert.ToInt32(ddls.SelectedValue)==-1?"": ddls.SelectedItem.Text, this.cbs.Checked,
             Convert.ToInt32(ddll.SelectedValue)==-1?"": ddll.SelectedItem.Text, this.cbl.Checked,
             Convert.ToInt32(ddla.SelectedValue)==-1?"": ddla.SelectedItem.Text, this.cba.Checked,
             Convert.ToInt32(ddlici.SelectedValue)==-1?"": ddlici.SelectedItem.Text, this.cbici.Checked,
             Convert.ToInt32(ddlr.SelectedValue)==-1?"": ddlr.SelectedItem.Text, this.cbr.Checked,
             Convert.ToInt32(ddlnp.SelectedValue)==-1?"": ddlnp.SelectedItem.Text, this.cbnp.Checked,
             Convert.ToInt32(ddlm.SelectedValue)==-1?"": ddlm.SelectedItem.Text, this.cbm.Checked,
             Convert.ToInt32(ddlmo.SelectedValue)==-1?"": ddlmo.SelectedItem.Text, this.cbmo.Checked,
             this.txtfi.Text,this.txtff.Text, this.cbf.Checked
        };
        Session["OpcionBusqueda"] = ob;

        Response.Clear();
        Response.Redirect("ReporteElementosConfiguracion.aspx");
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
        Response.Redirect("ReporteElementosConfiguracion.aspx");
        Response.Flush();
        _Lista.ShowMessage(__mensaje, __pagina, "", "");
    }

    protected void cbr_CheckedChanged(object sender, EventArgs e)
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");
        ddlr.Enabled = cbr.Checked;
        this.ddlr.SelectedIndex = -1;
        this.ddlr.Focus();
    }

    protected void cbnp_CheckedChanged(object sender, EventArgs e)
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");
        ddlnp.Enabled = cbnp.Checked;
        this.ddlnp.SelectedIndex = -1;
        this.ddlnp.Focus();
    }

    protected void cbm_CheckedChanged(object sender, EventArgs e)
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");
        ddlm.Enabled = cbm.Checked;
        this.ddlm.SelectedIndex = -1;
        this.ddlm.Focus();
    }

    protected void cbmo_CheckedChanged(object sender, EventArgs e)
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");
        ddlmo.Enabled = cbmo.Checked;
        this.ddlmo.SelectedIndex = -1;
        this.ddlmo.Focus();
    }

    protected void cbf_CheckedChanged(object sender, EventArgs e)
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");
        txtfi.Text = "";
        txtfi.Enabled = cbf.Checked;
        txtff.Text = "";
        txtff.Enabled = cbf.Checked;
    }
}