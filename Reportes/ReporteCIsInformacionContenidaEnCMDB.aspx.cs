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

    private void Listar_Elementos_Configuracion(String OPCION_BUSQUEDA, String AREA, String  Mensaje)
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
                dt = servidor.consultar("[dbo].[pr_Reporte_CIs_Información_Contenidas_En_CMDB]", OPCION_BUSQUEDA, AREA).Tables[0];

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

        }
        catch (Exception)
        {
            _Lista.ShowMessage(__mensaje, __pagina, "Error inesperado al intentar conectarnos con el servidor.", "../CerrarSession.aspx");
        }
    }

    private void Listar_Licencias(String OPCION_BUSQUEDA, String AREA, String Mensaje)
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");

        for (int i = 1; i < this.Table_1.Rows.Count; i++)
        {
            this.Table_1.Rows[i].Cells.Clear();
        }

        try
        {
            policia.clsaccesodatos servidor = new policia.clsaccesodatos();

        servidor.cadenaconexion = Ruta;

        if (servidor.abrirconexion() == true)
        {
            dt = servidor.consultar("[dbo].[pr_Reporte_CIs_Información_Contenidas_En_CMDB]", OPCION_BUSQUEDA, AREA).Tables[0];

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

                    for (int j = 0; j < Table_1.Rows[i].Cells.Count; j++)//Cabecera de la tabla
                    {
                        TableCell tCell = new TableCell();
                        tRow.BorderColor = System.Drawing.Color.Black;

                        switch (j)
                        {

                            case 0:

                                tCell.Text = dt.Rows[i]["AREA"].ToString();

                                tCell.Visible = true;

                                tRow.Cells.Add(tCell);

                                break;

                            case 1:

                                tCell.Text = dt.Rows[i]["LICENCIA"].ToString();

                                tCell.HorizontalAlign = HorizontalAlign.Left;

                                //tCell.BackColor = System.Drawing.Color.LemonChiffon;

                                tCell.Visible = true;

                                tRow.Cells.Add(tCell);

                                break;

                            case 2:

                                tCell.Text = dt.Rows[i]["NOMBRE"].ToString();

                                tCell.HorizontalAlign = HorizontalAlign.Left;

                                //tCell.BackColor = System.Drawing.Color.LemonChiffon;

                                tCell.Visible = true;

                                tRow.Cells.Add(tCell);

                                break;

                            case 3:

                                tCell.Text = dt.Rows[i]["VERSION"].ToString();

                                tCell.HorizontalAlign = HorizontalAlign.Left;

                                //tCell.BackColor = System.Drawing.Color.LemonChiffon;

                                tCell.Visible = true;

                                tRow.Cells.Add(tCell);

                                break;

                            case 4:

                                tCell.Text = dt.Rows[i]["SUSCRIPCION"].ToString();

                                tCell.HorizontalAlign = HorizontalAlign.Left;

                                //tCell.BackColor = System.Drawing.Color.LemonChiffon;

                                tCell.Visible = true;

                                tRow.Cells.Add(tCell);

                                break;

                            case 5:

                                tCell.Text = dt.Rows[i]["FEC. INI."].ToString();

                                tCell.HorizontalAlign = HorizontalAlign.Left;

                                //tCell.BackColor = System.Drawing.Color.LemonChiffon;

                                tCell.Visible = true;

                                tRow.Cells.Add(tCell);

                                break;

                            case 6:

                                tCell.Text = dt.Rows[i]["FEC. FIN"].ToString();

                                tCell.HorizontalAlign = HorizontalAlign.Left;

                                //tCell.BackColor = System.Drawing.Color.LemonChiffon;

                                tCell.Visible = true;

                                tRow.Cells.Add(tCell);

                                break;

                            case 7:

                                tCell.Text = dt.Rows[i]["PERPETUA"].ToString();

                                tCell.HorizontalAlign = HorizontalAlign.Left;

                                //tCell.BackColor = System.Drawing.Color.LemonChiffon;

                                tCell.Visible = true;

                                tRow.Cells.Add(tCell);

                                break;

                            case 8:

                                tCell.Text = dt.Rows[i]["DESCRIPCION"].ToString();

                                tCell.HorizontalAlign = HorizontalAlign.Left;

                                //tCell.BackColor = System.Drawing.Color.LemonChiffon;

                                tCell.Visible = true;

                                tRow.Cells.Add(tCell);

                                break;

                            case 9:

                                tCell.Text = dt.Rows[i]["VENCE LICENCIA"].ToString();

                                tCell.HorizontalAlign = HorizontalAlign.Left;

                                //tCell.BackColor = System.Drawing.Color.LemonChiffon;

                                tCell.Visible = true;

                                tRow.Cells.Add(tCell);

                                break;

                            

                        }
                    }

                    this.Table_1.Rows.Add(tRow);
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

        Cargar_Datos(this.ddls, "[dbo].[pr_Obtener_Sedes]", "Error, al intentar recuperar Sedes Judiciales.");
        if (this.__mensaje.Value.ToString().Trim() != "")
        {
            return;
        }

        if (Session["OpcionBusqueda"] == null)
        {
            this.Listar_Elementos_Configuracion("1", "", "No hay Elementos Configuracion");
            this.Listar_Licencias("2", "", "No hay Licenciasn");
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
            
            this.Listar_Elementos_Configuracion("1",ob[4].ToString().Trim(),
            "No hay Elementos Configuracion con los criterios seleccionados");

            this.Listar_Licencias("2", ob[4].ToString().Trim(), "No hay Licenciasn");
        }
        double T = Convert.ToDouble(Datos[17].ToString());

        this.Label1.Text += " <b>" + Datos[17].ToString() + "<b>";

        double A = Convert.ToDouble((Table_.Rows.Count - 1) + (Table_1.Rows.Count - 1));

        this.Label2.Text += " <b>" + A.ToString() + "<b>";

        double X = (A * 100) / T;

        string msg = "";

        if(X>=95) {
            msg = "% ideal de CIs contenidas en la CMDB";
            this.Label3.Text += "<font color=blue> <b>" + X.ToString() + "<b> " + msg + "</font>";
        }
        else if (X>=80 && X<95) {
            msg = "% promedio de Cis contenidas en la CMDB";
            this.Label3.Text += "<font color=gren> <b>" + X.ToString() + "<b> " + msg + "</font>";
        }
        else if(X<80) {
            msg = "% deficiente de CIs contenidas en la CMDB";
            this.Label3.Text += "<font color=red> <b>" + X.ToString() + "<b> " + msg + "</font>";
        }

        

        //this.Listar_Elementos_Configuracion("","","", "","","","","","", "No hay Elementos Configuracion");
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

    protected void lbtnBuscar_Click(object sender, EventArgs e) {

        _Lista.ShowMessage(__mensaje, __pagina, "", "");

        Object[] ob;

        bool ok = (cbs.Checked == false ||
        cbl.Checked == false ||
        cba.Checked == false
        );
        if (ok == true) {
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
        Response.Redirect("ReporteCIsInformacionContenidaEnCMDB.aspx");
        Response.Flush();

        _Lista.ShowMessage(__mensaje, __pagina, "", "");
    }
}