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

    private void Elementos_Configuracion_Seguidos(string Nombre_CI, string Tipo_CI, string Nro_Serie, string Descripcion_CI, string Sede, string Local, string Area, string Responsable, string Clasificacion_Datos, string Relacion_otros_CIs, string Fecha_Inicio, string Fecha_Fin, string Estado_Actual_CIs, String Mensaje)
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
                DataTable dt = servidor.consultar("[dbo].[pr_ReporteSeguimientoElementosConfiguracion]", Nombre_CI, Tipo_CI, Nro_Serie, Descripcion_CI, Sede, Local, Area, Responsable, Clasificacion_Datos, Relacion_otros_CIs, Fecha_Inicio, Fecha_Fin, Estado_Actual_CIs).Tables[0];

                if (dt.Rows.Count == 0)
                {
                    servidor.cerrarconexion();

                    _Lista.ShowMessage(__mensaje, __pagina, Mensaje, "");
                }
                else
                {
                    IMPRIMIR.Page.Session.Add("Imprimir", new Object[] { "REPORTE_SEGUIMIENTO_CIs", dt, "REPORTE DE SEGUIMIENTO DE ELEMENTOS DE CONFIGURACION" });
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

                                    tCell.Text = dt.Rows[i]["TIPO CI"].ToString();

                                    tCell.HorizontalAlign = HorizontalAlign.Left;

                                    //tCell.BackColor = System.Drawing.Color.LemonChiffon;

                                    tCell.Visible = true;

                                    tRow.Cells.Add(tCell);

                                    break;

                                case 3:

                                    tCell.Text = dt.Rows[i]["NRO. SERIE"].ToString();

                                    tCell.HorizontalAlign = HorizontalAlign.Left;

                                    //tCell.BackColor = System.Drawing.Color.LemonChiffon;

                                    tCell.Visible = true;

                                    tRow.Cells.Add(tCell);

                                    break;

                                case 4:

                                    tCell.Text = dt.Rows[i]["FABRICANTE / PROVEEDOR"].ToString();

                                    tCell.HorizontalAlign = HorizontalAlign.Left;

                                    //tCell.BackColor = System.Drawing.Color.LemonChiffon;

                                    tCell.Visible = false;

                                    tRow.Cells.Add(tCell);

                                    break;

                                case 5:

                                    tCell.Text = dt.Rows[i]["MARCA"].ToString();

                                    tCell.HorizontalAlign = HorizontalAlign.Left;

                                    //tCell.BackColor = System.Drawing.Color.LemonChiffon;

                                    tCell.Visible = false;

                                    tRow.Cells.Add(tCell);

                                    break;

                                case 6:

                                    tCell.Text = dt.Rows[i]["MODELO"].ToString();

                                    tCell.HorizontalAlign = HorizontalAlign.Left;

                                    //tCell.BackColor = System.Drawing.Color.LemonChiffon;

                                    tCell.Visible = false;

                                    tRow.Cells.Add(tCell);

                                    break;

                                case 7:

                                    if (dt.Rows[i]["ESTADO"].ToString().Equals("ACTIVO"))
                                    {
                                        tCell.ForeColor = System.Drawing.Color.Blue;
                                    }
                                    else
                                    {
                                        tCell.ForeColor = System.Drawing.Color.Red;
                                    }

                                    tCell.Text = dt.Rows[i]["ESTADO"].ToString();

                                    tCell.HorizontalAlign = HorizontalAlign.Left;

                                    //tCell.BackColor = System.Drawing.Color.LemonChiffon;

                                    tCell.Visible = false;

                                    tRow.Cells.Add(tCell);

                                    break;                               

                              
                                case 8:

                                    tCell.Text = dt.Rows[i]["DESCRIPCION CI"].ToString();

                                    tCell.HorizontalAlign = HorizontalAlign.Left;

                                    //tCell.BackColor = System.Drawing.Color.LemonChiffon;

                                    tCell.Visible = true;

                                    tRow.Cells.Add(tCell);

                                    break;

                                case 9:

                                    tCell.Text = "<font color=red>" +  dt.Rows[i]["SEDE"].ToString() + "</font>  /  <font color=blue>" + dt.Rows[i]["LOCAL"].ToString() + "</font>";

                                    tCell.HorizontalAlign = HorizontalAlign.Left;

                                    //tCell.BackColor = System.Drawing.Color.LemonChiffon;

                                    tCell.Visible = true;

                                    tRow.Cells.Add(tCell);

                                    break;
                               
                                case 10:

                                    tCell.Text = "<font color=red>" + dt.Rows[i]["UBICACION"].ToString() + "</font>  /  <font color=blue>" + dt.Rows[i]["DIRECCION"].ToString() + "</font>";

                                    tCell.HorizontalAlign = HorizontalAlign.Left;

                                    //tCell.BackColor = System.Drawing.Color.LemonChiffon;

                                    tCell.Visible = true;

                                    tRow.Cells.Add(tCell);

                                    break;                               

                                case 11:

                                    tCell.Text = "<font color=red>" + dt.Rows[i]["AREA"].ToString() + "</font>  /  <font color=blue>" + dt.Rows[i]["NRO PISO"].ToString() + "</font>  /  <font color=black>" + dt.Rows[i]["NRO AMBIENTE"].ToString() + "</font>";

                                    tCell.HorizontalAlign = HorizontalAlign.Left;

                                    //tCell.BackColor = System.Drawing.Color.LemonChiffon;

                                    tCell.Visible = true;

                                    tRow.Cells.Add(tCell);

                                    break;

                                case 12:

                                    tCell.Text = dt.Rows[i]["RESPONSABLE"].ToString();

                                    tCell.HorizontalAlign = HorizontalAlign.Left;

                                    //tCell.BackColor = System.Drawing.Color.LemonChiffon;

                                    tCell.Visible = true;

                                    tRow.Cells.Add(tCell);

                                    break;

                                case 13:

                                    tCell.Text = dt.Rows[i]["FECHA SEGUIMIENTO"].ToString();

                                    tCell.ForeColor = System.Drawing.Color.Green;

                                    tCell.Font.Bold = true;

                                    tCell.HorizontalAlign = HorizontalAlign.Left;

                                    //tCell.BackColor = System.Drawing.Color.LemonChiffon;

                                    tCell.Visible = true;

                                    tRow.Cells.Add(tCell);

                                    break;

                            case 14:

                                    tCell.Text = dt.Rows[i]["CLASIFICACION DATOS"].ToString();

                                    tCell.HorizontalAlign = HorizontalAlign.Left;

                                    //tCell.BackColor = System.Drawing.Color.LemonChiffon;

                                    tCell.Visible = true;

                                    tRow.Cells.Add(tCell);

                                    break;

                            case 15:
                                    String _ESTADO_ = dt.Rows[i]["ESTADO ACTUAL"].ToString().Trim();

                                    _ESTADO_= _ESTADO_.Replace(",", "<br>");

                                    tCell.Text = _ESTADO_;

                                    tCell.HorizontalAlign = HorizontalAlign.Left;

                                    //tCell.BackColor = System.Drawing.Color.LemonChiffon;

                                    tCell.Visible = true;

                                    tRow.Cells.Add(tCell);

                                    break;


                            case 16:
                                    String rcis = dt.Rows[i]["RELACION CIS"].ToString();
                                    if(rcis.Equals("SI")) {
                                        tCell.ForeColor = System.Drawing.Color.Blue;
                                    }else {
                                        tCell.ForeColor = System.Drawing.Color.Red;
                                    }

                                    tCell.Text = rcis;

                                    tCell.HorizontalAlign = HorizontalAlign.Left;

                                    //tCell.BackColor = System.Drawing.Color.LemonChiffon;

                                    tCell.Visible = true;

                                    tRow.Cells.Add(tCell);

                                    break;

                            case 17:
                                    String cp = dt.Rows[i]["CUMPLE POLITICA GESTION CONIGURACION ORGANIZACION"].ToString();
                                    if (cp.Equals("SI"))
                                    {
                                        tCell.ForeColor = System.Drawing.Color.Blue;
                                    }
                                    else
                                    {
                                        tCell.ForeColor = System.Drawing.Color.Red;
                                    }
                                    tCell.Text = cp;

                                    tCell.HorizontalAlign = HorizontalAlign.Left;

                                    //tCell.BackColor = System.Drawing.Color.LemonChiffon;

                                    tCell.Visible = true;

                                    tRow.Cells.Add(tCell);

                                    break;

                            case 18:

                                    tCell.Text = dt.Rows[i]["OBSERVACION"].ToString();

                                    tCell.HorizontalAlign = HorizontalAlign.Left;

                                    //tCell.BackColor = System.Drawing.Color.LemonChiffon;

                                    tCell.Visible = true;

                                    tRow.Cells.Add(tCell);

                                    break;

                            case 19:
                                        string _ESTADO_ACTUAL_ = dt.Rows[i]["ESTADO ACTUAL"].ToString();
                                        string _FSIS_ = Convert.ToDateTime(Obtener_Fecha_Sistema()).ToShortDateString();
                                        string _FS_ = Convert.ToDateTime(dt.Rows[i]["FECHA SEGUIMIENTO"].ToString()).ToShortDateString();
                                        System.Web.UI.WebControls.Button b = new System.Web.UI.WebControls.Button();

                                        if(_FSIS_ != _FS_) {
                                           b.Visible = false;
                                           b.Enabled = false;
                                        }
                                       
                                        b.Height = 25;

                                        b.Text = "EDITAR";
                                        b.ToolTip = "Seleccione Seguimiento CI";

                                        //b.BackColor = System.Drawing.Color.SpringGreen;

                                        b.BorderStyle = BorderStyle.None;

                                        b.CausesValidation = false;

                                        b.UseSubmitBehavior = false;

                                        //b.PostBackUrl = "~/#";

                                   

                                        tCell.HorizontalAlign = HorizontalAlign.Center;

                                        b.CssClass = "btn btn-success";
                                        b.CommandArgument = dt.Rows[i]["ID CI"].ToString() + "," +
                                                        dt.Rows[i]["NOMBRE CI"].ToString() + "," +
                                                        dt.Rows[i]["TIPO CI"].ToString() + "," +
                                                        dt.Rows[i]["NRO. SERIE"].ToString() + "," +
                                                        dt.Rows[i]["FABRICANTE / PROVEEDOR"].ToString() + "," +
                                                        dt.Rows[i]["MARCA"].ToString() + "," +
                                                        dt.Rows[i]["MODELO"].ToString() + "," +
                                                        dt.Rows[i]["ESTADO"].ToString() + "," +
                                                        dt.Rows[i]["DESCRIPCION CI"].ToString() + "," +
                                                        dt.Rows[i]["SEDE"].ToString() + "," +
                                                        dt.Rows[i]["LOCAL"].ToString() + "," +
                                                        dt.Rows[i]["UBICACION"].ToString() + "," +
                                                        dt.Rows[i]["DIRECCION"].ToString() + "," +
                                                        dt.Rows[i]["AREA"].ToString() + "," +
                                                        dt.Rows[i]["NRO PISO"].ToString() + "," +
                                                        dt.Rows[i]["NRO AMBIENTE"].ToString() + "," +
                                                        dt.Rows[i]["ID SEGUIMIENTO"].ToString() + "," +
                                                        dt.Rows[i]["ID RESPONSABLE"].ToString() + "," +
                                                        dt.Rows[i]["RESPONSABLE"].ToString() + "," +
                                                        dt.Rows[i]["FECHA SEGUIMIENTO"].ToString() + "," +
                                                        dt.Rows[i]["CLASIFICACION DATOS"].ToString() + "," +
                                                        _ESTADO_ACTUAL_.Replace(',','-') + "," +
                                                        dt.Rows[i]["RELACION CIS"].ToString() + "," +
                                                        dt.Rows[i]["CUMPLE POLITICA GESTION CONIGURACION ORGANIZACION"].ToString() + "," +
                                                        dt.Rows[i]["OBSERVACION"].ToString();
                                        b.Click += new System.EventHandler(Enviar_Datos_Seguimiento_Elemento_Configuracion);
                                        TableCell IDLICell = new TableCell { };

                                        tCell.Controls.Add(b);

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

    }
        catch (Exception)
        {
            _Lista.ShowMessage(__mensaje, __pagina, "Error inesperado al intentar conectarnos con el servidor.", "../CerrarSession.aspx");
        }
    }


    protected void Enviar_Datos_Seguimiento_Elemento_Configuracion(object sender, EventArgs e)
    {

        System.Web.UI.WebControls.Button b = (System.Web.UI.WebControls.Button)sender;
        String Registro = b.CommandArgument.Trim();
        String[] Datos = Registro.Split(',');
        Session["__SEGUIMIENTO_ELEMENTO_CONFIGURACION__"] = new object[] { Datos[0], //ID CI
        "Nombre: " + Datos[1] + "   Tipo: " + Datos[2] + "   Nro. Serie: " + Datos[3],
        "Fabricante: " + Datos[4] + "   Marca: " + Datos[5] + "   Modelo: " + Datos[6],
        "Estado: " + Datos[7] + "   Descripcion: " + Datos[8] + "   Sede: " + Datos[9],
        "Local: " + Datos[10] + "   Ubicacion: " + Datos[11] + "   Direccion: " + Datos[12],
        "Area: " + Datos[13] + "   Nro. Piso: " + Datos[14] + "   Nro. Ambiente: " + Datos[15],
        Datos[16], //ID SEGUIMIENTO
        Datos[17], //ID RESPONSABLE
        Datos[18], //RESPONSABLE
        Datos[19], //FECHA SEGUIMIENTO
        Datos[20], //CLASIFICACION DATOS
        Datos[21], //ESTADO ACTUAL
        Datos[22], //RELACION CIS
        Datos[23], //CUMPLE POLITICA GESTION CONIGURACION ORGANIZACION
        Datos[24]  //OBSERVACION
       };

        Response.Clear();
        Response.Redirect("SeguimientoElementoConfiguracion.aspx");
        Response.Flush();

       

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
        Cargar_Datos(this.ddlrs, "[dbo].[pr_Obtener_Usuarios]", "Error, al intentar recuperar Responsables.");
        if (this.__mensaje.Value.ToString().Trim() != "")
        {
            return;
        }
        Cargar_Datos(this.ddlcd, "[dbo].[pr_Obtener_Clasificacion_Datos_Elemento_Configuracion]", "Error, al intentar recuperar Clasificacion Datos CIs.");
        if (this.__mensaje.Value.ToString().Trim() != "")
        {
            return;
        }
        Cargar_Datos(this.ddleacis, "[dbo].[pr_Obtener_Estado_Actual_Elementos_Configuracion]", "Error, al intentar recuperar Clasificacion Datos CIs.");
        if (this.__mensaje.Value.ToString().Trim() != "")
        {
            return;
        }
        //Cargar_Datos_2(this.lbea, "[dbo].[pr_Obtener_Estado_Actual_Elementos_Configuracion]", "Error, al intentar recuperar Clasificacion Datos CIs.");
        //if (this.__mensaje.Value.ToString().Trim() != "")
        //{
        //    return;
        //}

        if (Session["OpcionBusqueda"] == null)
        {
            this.Elementos_Configuracion_Seguidos("", "","","","","","","","","","","","","No hay Elementos de Configuracion Seguidos");
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

            this.cbans.Checked = (bool)ob[5];
            this.tbns.Enabled = (bool)ob[5];
            this.tbns.Text = (string)ob[4];

            this.cbdci.Checked = (bool)ob[7];
            ddldci.Enabled = (bool)ob[7];
            for (int i = 0; i < this.ddldci.Items.Count; i++)
            {
                if (this.ddldci.Items[i].Text == ob[6].ToString().Trim())
                    this.ddldci.SelectedIndex = i;
            }


            this.cbs.Checked = (bool)ob[9];
            ddls.Enabled = (bool)ob[9];
            for (int i = 0; i < this.ddls.Items.Count; i++)
            {
                if (this.ddls.Items[i].Text == ob[8].ToString().Trim())
                    this.ddls.SelectedIndex = i;
            }

            ddls_SelectedIndexChanged(sender, e);


            this.cbl.Checked = (bool)ob[11];
            ddll.Enabled = (bool)ob[11];
            for (int i = 0; i < this.ddll.Items.Count; i++)
            {
                if (this.ddll.Items[i].Text == ob[10].ToString().Trim())
                    this.ddll.SelectedIndex = i;
            }

            ddll_SelectedIndexChanged(sender, e);

            this.cba.Checked = (bool)ob[13];
            ddla.Enabled = (bool)ob[13];
            for (int i = 0; i < this.ddla.Items.Count; i++)
            {
                if (this.ddla.Items[i].Text == ob[12].ToString().Trim())
                    this.ddla.SelectedIndex = i;
            }

            this.cbrs.Checked = (bool)ob[15];
            ddlrs.Enabled = (bool)ob[15];
            for (int i = 0; i < this.ddlrs.Items.Count; i++)
            {
                if (this.ddlrs.Items[i].Text == ob[14].ToString().Trim())
                    this.ddlrs.SelectedIndex = i;
            }

            this.cbcd.Checked = (bool)ob[17];
            ddlcd.Enabled = (bool)ob[17];
            for (int i = 0; i < this.ddlcd.Items.Count; i++)
            {
                if (this.ddlcd.Items[i].Text == ob[16].ToString().Trim())
                    this.ddlcd.SelectedIndex = i;
            }

            this.cbrocis.Checked = (bool)ob[19];
            ddlrocis.Enabled = (bool)ob[19];
            for (int i = 0; i < this.ddlrocis.Items.Count; i++)
            {
                if (this.ddlrocis.Items[i].Text == ob[18].ToString().Trim())
                    this.ddlrocis.SelectedIndex = i;
            }

            this.cbfs.Checked = (bool)ob[22];
            txtFechaInicioSeguimiento.Enabled = (bool)ob[22];
            txtFechaFinSeguimiento.Enabled = (bool)ob[22];
            txtFechaInicioSeguimiento.Text = ob[20].ToString().Trim();
            txtFechaFinSeguimiento.Text = ob[21].ToString().Trim();

            this.cbeacis.Checked = (bool)ob[24];
            ddleacis.Enabled = (bool)ob[24];
            for (int i = 0; i < this.ddleacis.Items.Count; i++)
            {
                if (this.ddleacis.Items[i].Text == ob[23].ToString().Trim())
                    this.ddleacis.SelectedIndex = i;
            }

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
















    protected void btnNuevoSeguiminetoCIs_Click(object sender, EventArgs e)
    {
        Session["__SEGUIMIENTO_ELEMENTO_CONFIGURACION__"] = null;
        Response.Clear();
        Response.Redirect("SeguimientoElementoConfiguracion.aspx");
        Response.Flush();
    }

    protected void cbnci_CheckedChanged(object sender, EventArgs e)
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");
        txtnci.Enabled = cbnci.Checked; txtnci.Text = ""; txtnci.Focus();
    }

    protected void cbtci_CheckedChanged(object sender, EventArgs e)
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");
        ddltci.Enabled = cbtci.Checked; ddltci.SelectedIndex=0; ddltci.Focus();
    }

    protected void cbans_CheckedChanged(object sender, EventArgs e)
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");
        tbns.Enabled = cbans.Checked; tbns.Text = ""; tbns.Focus();
    }

    protected void cbdci_CheckedChanged(object sender, EventArgs e)
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");
        ddldci.Enabled = cbdci.Checked; ddldci.SelectedIndex = 0; ddldci.Focus();
    }

    protected void cbs_CheckedChanged(object sender, EventArgs e)
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");
        ddls.Enabled = cbs.Checked; ddls.SelectedIndex = 0; ddls.Focus();
    }

    protected void cbl_CheckedChanged(object sender, EventArgs e)
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");
        ddll.Enabled = cbl.Checked; ddll.SelectedIndex = 0; ddll.Focus();
    }

    protected void cba_CheckedChanged(object sender, EventArgs e)
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");
        ddla.Enabled = cba.Checked; ddla.SelectedIndex = 0; ddla.Focus();
    }

    protected void cbrs_CheckedChanged(object sender, EventArgs e)
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");
        ddlrs.Enabled = cbrs.Checked; ddlrs.SelectedIndex = 0; ddlrs.Focus();
    }

    protected void cbcd_CheckedChanged(object sender, EventArgs e)
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");
        ddlcd.Enabled = cbcd.Checked; ddlcd.SelectedIndex = 0; ddlcd.Focus();
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

    

    protected void cbrocis_CheckedChanged(object sender, EventArgs e)
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");
        ddlrocis.Enabled = cbrocis.Checked; ddlrocis.SelectedIndex = 0; ddlrocis.Focus();
    }

    protected void cbfs_CheckedChanged(object sender, EventArgs e)
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");
        txtFechaInicioSeguimiento.Enabled = cbfs.Checked; txtFechaInicioSeguimiento.Text="";
        txtFechaFinSeguimiento.Enabled = cbfs.Checked; txtFechaFinSeguimiento.Text="";
    }

    protected void lbtnBuscar_Click(object sender, EventArgs e)
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");

        _Lista.Limpiar_Tabla(Table_);

        Object[] ob;

        bool ok = (cbnci.Checked == true ||
        cbtci.Checked == true ||
        cbans.Checked == true ||
        cbdci.Checked == true ||
        cbs.Checked == true ||
        cbl.Checked == true ||
        cba.Checked == true ||
        cbrs.Checked == true ||
        cbcd.Checked == true ||
        cbrocis.Checked == true ||
        cbfs.Checked == true ||
        cbeacis.Checked == true);
        if (ok == false)
        {
            _Lista.ShowMessage(__mensaje, __pagina, "Seleccione criterio(s) de busqueda.", "");
            return;
        }
        if(cbnci.Checked == true) {
           if(txtnci.Text.Trim()=="") {
                _Lista.ShowMessage(__mensaje, __pagina, "Ingrese nombre CI.", "");
                txtnci.Focus();
                return;
            }
        }
        if (cbtci.Checked == true)
        {
            if (ddltci.Items[ddltci.SelectedIndex].Value==(-1).ToString())
            {
                _Lista.ShowMessage(__mensaje, __pagina, "Seleccione tipo CI.", "");
                ddltci.Focus();
                return;
            }
        }
        if (cbans.Checked == true)
        {
            if (tbns.Text.Trim() == "")
            {
                _Lista.ShowMessage(__mensaje, __pagina, "Ingrese Nro. Serie CI.", "");
                tbns.Focus();
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
        if (cbs.Checked == true)
        {
            if (ddls.Items[ddls.SelectedIndex].Value == (-1).ToString())
            {
                _Lista.ShowMessage(__mensaje, __pagina, "Seleccione Sede.", "");
                ddls.Focus();
                return;
            }
        }
        if (cbl.Checked == true)
        {
            if (ddll.Items[ddll.SelectedIndex].Value == (-1).ToString())
            {
                _Lista.ShowMessage(__mensaje, __pagina, "Seleccione Local.", "");
                ddll.Focus();
                return;
            }
        }
        if (cba.Checked == true)
        {
            if (ddla.Items[ddla.SelectedIndex].Value == (-1).ToString())
            {
                _Lista.ShowMessage(__mensaje, __pagina, "Seleccione Area.", "");
                ddla.Focus();
                return;
            }
        }
        if (cbrs.Checked == true)
        {
            if (ddlrs.Items[ddlrs.SelectedIndex].Value == (-1).ToString())
            {
                _Lista.ShowMessage(__mensaje, __pagina, "Seleccione Responsable Seguimineto CIs.", "");
                ddlrs.Focus();
                return;
            }
        }
        if (cbcd.Checked == true)
        {
            if (ddlcd.Items[ddlcd.SelectedIndex].Value == (-1).ToString())
            {
                _Lista.ShowMessage(__mensaje, __pagina, "Seleccione Clasificacion Datos CIs.", "");
                ddlcd.Focus();
                return;
            }
        }
        if (cbrocis.Checked == true)
        {
            if (ddlrocis.Items[ddlrocis.SelectedIndex].Value == (-1).ToString())
            {
                _Lista.ShowMessage(__mensaje, __pagina, "Seleccione Relacion con Otros CIs.", "");
                ddlrocis.Focus();
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
             txtnci.Text.Trim(), this.cbnci.Checked,
             Convert.ToInt32(ddltci.SelectedValue)==-1?"": ddltci.SelectedItem.Text, this.cbtci.Checked,
             tbns.Text.Trim(), this.cbans.Checked,
             Convert.ToInt32(ddldci.SelectedValue)==-1?"": ddldci.SelectedItem.Text, this.cbdci.Checked,
             Convert.ToInt32(ddls.SelectedValue)==-1?"": ddls.SelectedItem.Text, this.cbs.Checked,
             Convert.ToInt32(ddll.SelectedValue)==-1?"": ddll.SelectedItem.Text, this.cbl.Checked,
             Convert.ToInt32(ddla.SelectedValue)==-1?"": ddla.SelectedItem.Text, this.cba.Checked,
             Convert.ToInt32(ddlrs.SelectedValue)==-1?"": ddlrs.SelectedItem.Text, this.cbrs.Checked,
             Convert.ToInt32(ddlcd.SelectedValue)==-1?"": ddlcd.SelectedItem.Text, this.cbcd.Checked,
             ddlrocis.SelectedValue==(-1).ToString()?"": ddlrocis.SelectedItem.Text, this.cbrocis.Checked,
             txtFechaInicioSeguimiento.Text.Trim(),txtFechaFinSeguimiento.Text.Trim(), this.cbfs.Checked,
             Convert.ToInt32(ddleacis.SelectedValue)==-1?"": ddleacis.SelectedItem.Text, this.cbeacis.Checked,
        };
        Session["OpcionBusqueda"] = ob;

        Response.Clear();
        Response.Redirect("ReporteSeguimientosElementoConfiguracion.aspx");
        Response.Flush();

        //_Lista.ShowMessage(__mensaje, __pagina, "", "");
    }

    protected void btnActualizarInformacion_Click(object sender, EventArgs e)
    {
        Session["OpcionBusqueda"] = null;

        Response.Clear();
        Response.Redirect("ReporteSeguimientosElementoConfiguracion.aspx");
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


    private void Cargar_Datos_2(System.Web.UI.WebControls.ListBox lb, String Procedimeinto_Almacenado, String Mensaje, params Object[] p)
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
                    lb.DataSource = dt;
                    lb.DataTextField = "NOMBRE";
                    lb.DataValueField = "CODIGO";
                    lb.DataBind();
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



    protected void cbeacis_CheckedChanged(object sender, EventArgs e)
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");
        ddleacis.Enabled = cbeacis.Checked; ddleacis.SelectedIndex = 0; ddleacis.Focus();
    }

    private String Obtener_Fecha_Sistema()
    {
        String Fecha = "";

        try
        {
            policia.clsaccesodatos servidor = new policia.clsaccesodatos();
            servidor.cadenaconexion = Ruta;
            if (servidor.abrirconexion() == true)
            {
                System.Data.DataTable dt;
                dt = servidor.consultar("[dbo].[obtenerfechasistema_2]").Tables[0];
                if (dt.Rows.Count == 0)
                {
                    servidor.cerrarconexion();
                    this.__mensaje.Value = "Error al intentar obtener fecha del sistema";
                    this.__pagina.Value = "";
                }
                else
                {
                    Fecha = dt.Rows[0].ItemArray[0].ToString();
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
        return Fecha;
    }
}