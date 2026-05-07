using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.Web.Script.Serialization;

public partial class RelacionesElementosConfiguracion : System.Web.UI.Page
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
                DataTable dt = servidor.consultar("[dbo].[pr_ListaRelacionElementosConfiguracion]",
                "", "", "", "", "", "", "", "").Tables[0];

                if (dt.Rows.Count > 0)
                {
                    List<Dictionary<string, object>> jsonList = new List<Dictionary<string, object>>();
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        Dictionary<string, object> row = new Dictionary<string, object>();
                        row["ID_RELACION"] = dt.Rows[i]["ID_RELACION"].ToString();
                        row["NOMBRE_CI"] = dt.Rows[i]["PADRE CI"].ToString();
                        row["TIPO_CI"] = dt.Rows[i]["PADRE TIPO CI"].ToString();
                        row["ESTADO_CI"] = dt.Rows[i]["PADRE ESTADO CI"].ToString();
                        row["PROPIETARIO_CI"] = dt.Rows[i]["PADRE PROPIETARIO CI"].ToString();
                        row["SEDE"] = dt.Rows[i]["PADRE SEDE"].ToString();
                        row["LOCAL"] = dt.Rows[i]["PADRE LOCAL"].ToString();
                        row["AREA"] = dt.Rows[i]["PADRE AREA"].ToString();
                        row["TIPO_RELACION"] = dt.Rows[i]["TIPO RELACION"].ToString();
                        jsonList.Add(row);
                    }

                    JavaScriptSerializer serializer = new JavaScriptSerializer();
                    datosJson.Value = serializer.Serialize(jsonList);
                }
                else
                {
                    datosJson.Value = "[]";
                }

                servidor.cerrarconexion();
            }
            else
            {
                servidor.cerrarconexion();
                datosJson.Value = "[]";
            }
        }
        catch (Exception ex)
        {
            datosJson.Value = "[]";
        }
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
                DataTable dt = servidor.consultar("[dbo].[pr_ListaRelacionElementosConfiguracion]", 
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

                                    tCell.Text = dt.Rows[i]["ID_RELACION"].ToString();

                                    tCell.Visible = false;

                                    tRow.Cells.Add(tCell);

                                    break;

                                case 1:

                                    tCell.Text = dt.Rows[i]["PADRE ID"].ToString();

                                    tCell.HorizontalAlign = HorizontalAlign.Left;

                                    //tCell.BackColor = System.Drawing.Color.LemonChiffon;

                                    tCell.Visible = false;

                                    tRow.Cells.Add(tCell);

                                    break;

                                case 2:

                                    tCell.Text = "<font color=blue><b>Nombre: </b>" + dt.Rows[i]["PADRE CI"].ToString() + "</font> &nbsp;&nbsp; <b>Tipo:</b> " + dt.Rows[i]["PADRE TIPO CI"].ToString() + "&nbsp;&nbsp; <b>Nro Serie: </b>" +  dt.Rows[i]["PADRE NRO SERIE"].ToString() + "&nbsp;&nbsp; <b>Direccion IP: </b>" + dt.Rows[i]["PADRE IP"].ToString() + "&nbsp;&nbsp; <b>Direccion Gateway: </b>" + dt.Rows[i]["PADRE GATEWAY"].ToString() + "&nbsp;&nbsp; <b>Grupo de Trabajo: </b>" + dt.Rows[i]["PADRE GRUPO TRABAJO"].ToString() + "&nbsp;&nbsp; <b>Fabricante / Proveedor: </b>" + dt.Rows[i]["PADRE FABICANTE / PROVEEDOR"].ToString() + "&nbsp;&nbsp; <b>Estado:</b> " + dt.Rows[i]["PADRE ESTADO CI"].ToString() + "&nbsp;&nbsp; <b>Propietario:</b> " + dt.Rows[i]["PADRE PROPIETARIO CI"].ToString() +"<BR>";
                                    tCell.Text += "<b>Descripcion: </b>" + dt.Rows[i]["PADRE DESCRIPCION CI"].ToString() + "&nbsp;&nbsp;<b>Prioridad: </b>" + dt.Rows[i]["PADRE NIVEL PRIORIDAD"].ToString() + "&nbsp;&nbsp;<b>Sede: </b>" + dt.Rows[i]["PADRE SEDE"].ToString() + "&nbsp;&nbsp;<b>Local: </b>" + dt.Rows[i]["PADRE LOCAL"].ToString() + "<BR>";
                                    tCell.Text += "<font color=red><b>Area: </b>" + dt.Rows[i]["PADRE AREA"].ToString() + "&nbsp;&nbsp;<b>Nro. Piso: </b>" + dt.Rows[i]["PADRE NRO PISO"].ToString() + "&nbsp;&nbsp;<b>Nro. Ambiente: </b>" + dt.Rows[i]["PADRE NRO AMBIENTE"].ToString() + "&nbsp;&nbsp;<b>Ubicacion: </b>" + dt.Rows[i]["PADRE UBICACION"].ToString() + "</font><BR>";
                                    tCell.Text += "<font color=red><b>Direccion: </b>" + dt.Rows[i]["PADRE DIRECCION LOCAL"].ToString() + "</font>";
                                    tCell.HorizontalAlign = HorizontalAlign.Left;

                                //tCell.BackColor = System.Drawing.Color.LemonChiffon;

                                    tCell.Visible = true;
                                    tRow.Cells.Add(tCell);

                                    break;

                                case 3:

                                    tCell.Text = dt.Rows[i]["HIJO ID"].ToString();

                                    tCell.HorizontalAlign = HorizontalAlign.Left;

                                    //tCell.BackColor = System.Drawing.Color.LemonChiffon;

                                    tCell.Visible = false;

                                    tRow.Cells.Add(tCell);

                                    break;                                

                                case 4:

                                     tCell.Text = "<font color=blue><b>Nombre: </b>" + dt.Rows[i]["HIJO CI"].ToString() + "</font>&nbsp;&nbsp; <b>Tipo:</b> " + dt.Rows[i]["HIJO TIPO CI"].ToString() + "&nbsp;&nbsp; <b>Nro Serie: </b>" + dt.Rows[i]["HIJO NRO SERIE"].ToString() + "&nbsp;&nbsp; <b>Direccion IP: </b>" + dt.Rows[i]["HIJO IP"].ToString() + "&nbsp;&nbsp; <b>Direccion Gateway: </b>" + dt.Rows[i]["HIJO GATEWAY"].ToString() + "&nbsp;&nbsp; <b>Grupo de Trabajo: </b>" + dt.Rows[i]["HIJO GRUPO TRABAJO"].ToString() + "&nbsp;&nbsp; <b>Fabricante / Proveedor: </b>" + dt.Rows[i]["HIJO FABRICANTE / PROVEEDOR"].ToString() + "&nbsp;&nbsp; <b>Estado:</b> " + dt.Rows[i]["HIJO ESTADO CI"].ToString() + "&nbsp;&nbsp; <b>Propietario:</b> " + dt.Rows[i]["HIJO PROPIETARIO CI"].ToString() +"<BR>";
                                     tCell.Text += "<b>Descripcion: </b>" + dt.Rows[i]["HIJO DESCRIPCION CI"].ToString() + "&nbsp;&nbsp;<b>Prioridad: </b>" + dt.Rows[i]["HIJO NIVEL PRIORIDAD"].ToString() + "&nbsp;&nbsp;<b>Sede: </b>" + dt.Rows[i]["HIJO SEDE"].ToString() + "&nbsp;&nbsp;<b>Local: </b>" + dt.Rows[i]["HIJO LOCAL"].ToString() + "<BR>";
                                     tCell.Text += "<font color=red><b>Area: </b>" + dt.Rows[i]["HIJO AREA"].ToString() + "&nbsp;&nbsp;<b>Nro. Piso: </b>" + dt.Rows[i]["HIJO NRO PISO"].ToString() + "&nbsp;&nbsp;<b>Nro. Ambiente: </b>" + dt.Rows[i]["HIJO NRO AMBIENTE"].ToString() + "&nbsp;&nbsp;<b>Ubicacion: </b>" + dt.Rows[i]["HIJO UBICACION"].ToString() + "</font> <BR>";
                                     tCell.Text += "<font color=red><b>Direccion: </b>" + dt.Rows[i]["HIJO DIRECCION LOCAL"].ToString() + "</font>" ;
                                     tCell.HorizontalAlign = HorizontalAlign.Left;

                                    //tCell.BackColor = System.Drawing.Color.LemonChiffon;

                                    tCell.Visible = true;

                                    tRow.Cells.Add(tCell);

                                    break;

                                case 5:

                                    tCell.Text = dt.Rows[i]["TIPO RELACION"].ToString();

                                    tCell.HorizontalAlign = HorizontalAlign.Left;

                                    //tCell.BackColor = System.Drawing.Color.LemonChiffon;

                                    tCell.Visible = true;

                                    tRow.Cells.Add(tCell);

                                    break;

                                case 6:
                                    //verificar permiso para enviar datos.
                                    string[] Datos = (string[])Session["__JSAR__"];
                                    bool rpta = this.VERIFICAR_PERMISOS_DERECHOS_ACCESO_PAGINA_WEB(Convert.ToInt32(Datos[0]),
                                    "RelacionesElementosConfiguracion.aspx", "EDITAR");

                                    if (rpta == true)
                                    {
                                        System.Web.UI.WebControls.HyperLink h = new System.Web.UI.WebControls.HyperLink();

                                        h.Height = 25;

                                        h.Text = "Editar";

                                        h.BorderStyle = BorderStyle.None;

                                        h.NavigateUrl = "~/RelacionElementosConfiguracion.aspx?Operacion=M&IDR=" + dt.Rows[i]["ID_RELACION"].ToString();

                                        tCell.HorizontalAlign = HorizontalAlign.Center;

                                        tCell.Controls.Add(h);

                                        tRow.Cells.Add(tCell);
                                    }
                                    else
                                    {
                                        tCell.Text = "SIN PERMISO PARA EDITAR";
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

    protected void Page_init(object sender, EventArgs e) {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");

        // Load all relaciones for the list view JSON
        Cargar_Datos_Json();

        string[] Datos = (string[])Session["__JSAR__"];

        if (Datos == null)
        {

            this.__mensaje.Value = "Ud. no esta autorizado para ingresar a esta página, inicie sesion por favor.";

            this.__pagina.Value = "CerrarSession.aspx";

            return;

        }

        //verificar permiso para acceder a esta pagina.
        bool rpta = this.VERIFICAR_PERMISO_ACCESO_PAGINA_WEB(Convert.ToInt32(Datos[0]),
        "RelacionesElementosConfiguracion.aspx");
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
        }else {
            Object[] ob = (Object[])Session["OpcionBusqueda"];
            this.cbnci.Checked = (bool)ob[1];
            this.txtnci.Enabled = (bool)ob[1];
            this.txtnci.Text = (string)ob[0];

            this.cbtci.Checked = (bool)ob[3];
            ddltci.Enabled= (bool)ob[3];
            for (int i = 0; i < this.ddltci.Items.Count; i++)
            {
                if (this.ddltci.Items[i].Text == ob[2].ToString().Trim())
                    this.ddltci.SelectedIndex = i;
            }

            this.cbeci.Checked = (bool)ob[5];
            ddleci.Enabled= (bool)ob[5];
            for (int i = 0; i < this.ddleci.Items.Count; i++)
            {
                if (this.ddleci.Items[i].Text == ob[4].ToString().Trim())
                    this.ddleci.SelectedIndex = i;
            }

            this.cbpci.Checked = (bool)ob[7];
            txtpci.Enabled = (bool)ob[7];
            this.txtpci.Text = (string)ob[6];

            this.cbdci.Checked = (bool)ob[9];
            ddldci.Enabled= (bool)ob[9];
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
        catch (Exception ex)
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

        //verificar permiso para eliminar datos.
        string[] Datos = (string[])Session["__JSAR__"];
        bool rpta = this.VERIFICAR_PERMISOS_DERECHOS_ACCESO_PAGINA_WEB(Convert.ToInt32(Datos[0]),
        "RelacionesElementosConfiguracion.aspx", "BUSCAR");
        if (rpta == false)
        {
            this.__mensaje.Value = "Ud. no esta autorizado para BUSCAR datos en esta pagina web.";
            this.__pagina.Value = "CerrarSession.aspx";
            return;
        }

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
        Response.Redirect("RelacionesElementosConfiguracion.aspx");
        Response.Flush();

        _Lista.ShowMessage(__mensaje, __pagina, "", "");

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
        "RelacionesElementosConfiguracion.aspx", "ACTUALIZAR");
        if (rpta == false)
        {
            this.__mensaje.Value = "Ud. no esta autorizado para ACTUALIZAR INFORMACION datos en esta pagina web.";
            this.__pagina.Value = "CerrarSession.aspx";
            return;
        }

        Session["OpcionBusqueda"] = null;
        Response.Clear();
        Response.Redirect("RelacionesElementosConfiguracion.aspx");
        Response.Flush();
        _Lista.ShowMessage(__mensaje, __pagina, "", "");
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