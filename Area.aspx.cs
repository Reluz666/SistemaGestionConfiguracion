using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class TiposElementoConfiguracion : System.Web.UI.Page
{
    //private String Ruta = "SERVER=JOSE-PC;DATABASE=GCS;Encrypt=False;INTEGRATED SECURITY=True;packet size=4096;";
    private String Ruta = System.Configuration.ConfigurationManager.ConnectionStrings["CadenaConeccion"].ToString();

    System.Web.UI.WebControls.TableRow tRow;
    Lista _Lista = new Lista();
    System.Data.DataTable dt;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Convert.ToInt32(this.Id_Area.Value.Trim()) == 0)
        {
            this.btnRegistrar.Visible = true;
            this.btnCancelar.Visible = true;
            oculta(false);
        }
    }

    protected void Page_Init(object sender, EventArgs e)
    {
        this.__mensaje.Value = "";
        this.__pagina.Value = "";

        string[] Datos = (string[])Session["__JSAR__"];

        if (Datos == null)
        {

            this.__mensaje.Value = "Ud. no esta autorizado para ingresar a esta página, inicie sesion por favor.";

            this.__pagina.Value = "CerrarSession.aspx";

            return;

        }

        //verificar permiso para acceder a esta pagina.
        bool rpta = this.VERIFICAR_PERMISO_ACCESO_PAGINA_WEB(Convert.ToInt32(Datos[0]),
        "Area.aspx");
        if (rpta == false)
        {
            this.__mensaje.Value = "Ud. no tiene permiso para ACCEDER esta pagina web.";
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
            this.Lista_Areas("", "", "No hay Locales registrados");
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

            this.Lista_Areas(ob[0].ToString().Trim(),
            ob[2].ToString().Trim(),
            "No hay Locales con los criterios seleccionados");
        }
    }

    private void ShowMessage(string msg, string paginaweb)
    {
        this.__mensaje.Value = msg;
        this.__pagina.Value = paginaweb;
    }
    private void Lista_Areas(string LOCAL_NOMBRE, string SEDE, string MENSAJE)
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");
        //********************** AGREGADO EN REQUE EL 21-03-2023 ***************************
        _Lista.Limpiar_Tabla(Table_);
        try
        {
            policia.clsaccesodatos servidor = new policia.clsaccesodatos();
            servidor.cadenaconexion = Ruta;
            if (servidor.abrirconexion() == true)
            {
                dt = servidor.consultar("[dbo].[pr_Lista_Areas]", LOCAL_NOMBRE, SEDE).Tables[0];
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
                        for (int j = 0; j < 9; j++)//Cabecera de la tabla
                        {
                            TableCell tCell = new TableCell();
                            switch (j)
                            {
                                case 0:
                                    tCell.Text = dt.Rows[i]["ID AREA"].ToString().Trim();
                                    tCell.Visible = false;
                                    tRow.Cells.Add(tCell);
                                    break;
                                case 1:
                                    tCell.Text = dt.Rows[i]["SEDE"].ToString().Trim();
                                    tCell.Visible = true;
                                    tRow.Cells.Add(tCell);
                                    break;
                                case 2:
                                    tCell.Text = dt.Rows[i]["LOCAL"].ToString().Trim();
                                    tCell.Visible = true;
                                    tRow.Cells.Add(tCell);
                                    break;
                                case 3:
                                    tCell.Text = dt.Rows[i]["DIRECCION LOCAL"].ToString().Trim();
                                    tCell.Visible = true;
                                    tRow.Cells.Add(tCell);
                                    break;
                                case 4:
                                    tCell.Text = dt.Rows[i]["CODIGO AREA"].ToString().Trim();
                                    tCell.Visible = true;
                                    tRow.Cells.Add(tCell);
                                    break;
                                case 5:
                                    tCell.Text = dt.Rows[i]["AREA"].ToString().Trim();
                                    tCell.Visible = true;
                                    tRow.Cells.Add(tCell);
                                    break;
                                case 6:
                                    tCell.Text = dt.Rows[i]["NRO PISO"].ToString().Trim();
                                    tCell.Visible = true;
                                    tRow.Cells.Add(tCell);
                                    break;
                                case 7:
                                    tCell.Text = dt.Rows[i]["NRO AMBIENTE"].ToString().Trim();
                                    tCell.Visible = true;
                                    tRow.Cells.Add(tCell);
                                    break;
                                case 8:
                                    //verificar permiso para enviar datos.
                                    string[] Datos = (string[])Session["__JSAR__"];
                                    bool rpta = this.VERIFICAR_PERMISOS_DERECHOS_ACCESO_PAGINA_WEB(Convert.ToInt32(Datos[0]),
                                    "Area.aspx", "SELECCIONAR");

                                    if (rpta == true)
                                    {
                                        System.Web.UI.WebControls.Button b = new System.Web.UI.WebControls.Button();
                                        b.Text = "Area";
                                        b.ToolTip = "Seleccione Area";
                                        b.BorderStyle = BorderStyle.None;
                                        b.CausesValidation = false;
                                        b.UseSubmitBehavior = true;
                                        b.CssClass = "btn btn-dark";
                                        b.CommandArgument = dt.Rows[i]["ID AREA"].ToString().Trim() + "," +
                                                            dt.Rows[i]["SEDE"].ToString().Trim() + "," +
                                                            dt.Rows[i]["LOCAL"].ToString().Trim() + "," +
                                                            dt.Rows[i]["DIRECCION LOCAL"].ToString().Trim() + "," +
                                                            dt.Rows[i]["CODIGO AREA"].ToString().Trim() + "," +
                                                            dt.Rows[i]["AREA"].ToString().Trim() + "," +
                                                            dt.Rows[i]["NRO PISO"].ToString().Trim() + "," +
                                                            dt.Rows[i]["NRO AMBIENTE"].ToString().Trim() + "," +
                                                            dt.Rows[i]["ID LOCAL"].ToString().Trim();
                                        b.Click += new System.EventHandler(visualiza_datos_local);
                                        tCell.HorizontalAlign = HorizontalAlign.Center;
                                        tCell.Controls.Add(b);
                                        tRow.Cells.Add(tCell);
                                    }
                                    else {
                                        tCell.Text = "SIN PERMISO PARA ESTA OPCION";
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

                this.__mensaje.Value = servidor.getMensageError();

                this.__pagina.Value = "CerrarSession.aspx";
            }

        }
        catch (Exception)
        {

            this.__mensaje.Value = "Error inesperado al intentar conectarnos con el servidor.";

            this.__pagina.Value = "CerrarSession.aspx";
        }
    }

    protected void visualiza_datos_local(object sender, EventArgs e)
    {
        this.__mensaje.Value = "";
        this.__pagina.Value = "";
        System.Web.UI.WebControls.Button b = (System.Web.UI.WebControls.Button)sender;
        String Registro = b.CommandArgument.Trim();
        String[] Datos = Registro.Split(',');
        this.Id_Area.Value = Datos[0];
        this.Codigo_Area.Text = Datos[4];
        this.Descripcion_Area.Text = Datos[5];
        this.Nro_Piso.Text = Datos[6];
        this.Nro_Ambiente.Text = Datos[7];

        this.hfCodigo_Local_Judicial.Value = Datos[8];
        this.Local_Judicial.Text = Datos[2];
        this.btnRegistrar.Visible = false;
        this.btnCancelar.Visible = true;
        oculta(true);

    }

    private void Matenimiento_Area(int _Id_Area,
        string _Codigo_Area,
        string _Descripcion_Area,
        string _Nro_Piso,
        string _Nro_Ambiente,
        int _Id_Local,
        string operacion)
    {
        policia.clsaccesodatos servidor = new policia.clsaccesodatos();
        servidor.cadenaconexion = Ruta;
        try
        {
            servidor.cadenaconexion = Ruta;
            if (servidor.abrirconexiontrans() == true)
            {
                servidor.ejecutar("[dbo].[pr_MatenimientoArea]",
                                    false,
                                    _Id_Area,
                                    _Codigo_Area.Trim(),
                                    _Descripcion_Area.Trim(),
                                    _Nro_Piso.Trim(),
                                    _Nro_Ambiente.Trim(),
                                    _Id_Local,
                                    operacion,
                                    0, "");
                if (servidor.getRespuesta() == 1)
                {
                    servidor.cerrarconexiontrans();
                    ShowMessage(servidor.getMensaje(), "Area.aspx");
                }
                else
                {
                    servidor.cancelarconexiontrans();
                    ShowMessage(servidor.getMensaje(), "Area.aspx");
                }
            }
            else
            {
                servidor.cancelarconexiontrans();
                ShowMessage(servidor.getMensageError(), "CerrarSession.aspx");
            }
        }
        catch (Exception)
        {
            servidor.cancelarconexiontrans();
            ShowMessage("Error inesperado al intentar conectarnos con el servidor.", "CerrarSession.aspx");
        }
    }



    private void oculta(bool ok)
    {
        this.btnModificar.Visible = ok;
        this.btnEliminar.Visible = ok;
    }

    protected void btnRegistrar_Click(object sender, EventArgs e)
    {
        this.__mensaje.Value = "";
        this.__pagina.Value = "";

        //verificar permiso para REGISTRAR datos.
        string[] Datos = (string[])Session["__JSAR__"];
        bool rpta = this.VERIFICAR_PERMISOS_DERECHOS_ACCESO_PAGINA_WEB(Convert.ToInt32(Datos[0]),
        "Area.aspx", "NUEVO");
        if (rpta == false)
        {
            this.__mensaje.Value = "Ud. no esta autorizado para registrar datos en esta pagina web.";
            this.__pagina.Value = "CerrarSession.aspx";
            return;
        }

        Boolean ok;
        ok = rfvCodigo_Area.IsValid;
        if (ok == false)
        {
            return;
        }

        Matenimiento_Area(Convert.ToInt32(this.Id_Area.Value.Trim()),
            this.Codigo_Area.Text.Trim(),
            this.Descripcion_Area.Text.Trim(),
            this.Nro_Piso.Text.Trim(),
            this.Nro_Ambiente.Text.Trim(),
            Convert.ToInt32(this.hfCodigo_Local_Judicial.Value.Trim()),
            "N");
    }

    protected void btnModificar_Click(object sender, EventArgs e)
    {
        this.__mensaje.Value = "";
        this.__pagina.Value = "";

        //verificar permiso para REGISTRAR datos.
        string[] Datos = (string[])Session["__JSAR__"];
        bool rpta = this.VERIFICAR_PERMISOS_DERECHOS_ACCESO_PAGINA_WEB(Convert.ToInt32(Datos[0]),
        "Area.aspx", "MODIFICAR");
        if (rpta == false)
        {
            this.__mensaje.Value = "Ud. no esta autorizado para MODIFICAR datos en esta pagina web.";
            this.__pagina.Value = "CerrarSession.aspx";
            return;
        }

        Boolean ok;
        ok = rfvCodigo_Area.IsValid;
        if (ok == false)
        {
            return;
        }

        Matenimiento_Area(Convert.ToInt32(this.Id_Area.Value.Trim()),
            this.Codigo_Area.Text.Trim(),
            this.Descripcion_Area.Text.Trim(),
            this.Nro_Piso.Text.Trim(),
            this.Nro_Ambiente.Text.Trim(),
            Convert.ToInt32(this.hfCodigo_Local_Judicial.Value.Trim()),
            "M");
    }

    protected void btnEliminar_Click(object sender, EventArgs e)
    {
        this.__mensaje.Value = "";
        this.__pagina.Value = "";

        //verificar permiso para eliminar datos.
        string[] Datos = (string[])Session["__JSAR__"];
        bool rpta = this.VERIFICAR_PERMISOS_DERECHOS_ACCESO_PAGINA_WEB(Convert.ToInt32(Datos[0]),
        "Area.aspx", "ELIMINAR");
        if (rpta == false)
        {
            this.__mensaje.Value = "Ud. no esta autorizado para eliminar datos en esta pagina web.";
            this.__pagina.Value = "CerrarSession.aspx";
            return;
        }

        Boolean ok;
        ok = rfvCodigo_Area.IsValid;
        if (ok == false)
        {
            return;
        }

        Matenimiento_Area(Convert.ToInt32(this.Id_Area.Value.Trim()),
           this.Codigo_Area.Text.Trim(),
           this.Descripcion_Area.Text.Trim(),
           this.Nro_Piso.Text.Trim(),
           this.Nro_Ambiente.Text.Trim(),
           Convert.ToInt32(this.hfCodigo_Local_Judicial.Value.Trim()),
          "E");
    }



    protected void btnCancelar_Click(object sender, EventArgs e)
    {
        //verificar permiso para eliminar datos.
        string[] Datos = (string[])Session["__JSAR__"];
        bool rpta = this.VERIFICAR_PERMISOS_DERECHOS_ACCESO_PAGINA_WEB(Convert.ToInt32(Datos[0]),
        "Area.aspx", "CANCELAR");
        if (rpta == false)
        {
            this.__mensaje.Value = "Ud. no esta autorizado para CANCELAR datos en esta pagina web.";
            this.__pagina.Value = "CerrarSession.aspx";
            return;
        }

        this.Response.Redirect("Area.aspx");
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

    protected void lbtnBuscar_Click(object sender, EventArgs e)
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");

        //verificar permiso para eliminar datos.
        string[] Datos = (string[])Session["__JSAR__"];
        bool rpta = this.VERIFICAR_PERMISOS_DERECHOS_ACCESO_PAGINA_WEB(Convert.ToInt32(Datos[0]),
        "Area.aspx", "BUSCAR");
        if (rpta == false)
        {
            this.__mensaje.Value = "Ud. no esta autorizado para BUSCAR datos en esta pagina web.";
            this.__pagina.Value = "CerrarSession.aspx";
            return;
        }

        Object[] ob;

        bool ok = (
        cbs.Checked == true  ||
        cbl.Checked == true);
        if (ok == false)
        {
            _Lista.ShowMessage(__mensaje, __pagina, "Seleccione opciones para empezar la busqueda.", "");
            return;
        }
        if(cbs.Checked == true) {
           if(ddls.SelectedValue== "-1".ToString()) {
                _Lista.ShowMessage(__mensaje, __pagina, "Seleccione sede.", "");
                return;
            }
        }
        if (cbl.Checked == true)
        {
            if (ddll.SelectedValue == "-1".ToString())
            {
                _Lista.ShowMessage(__mensaje, __pagina, "Seleccione local.", "");
                return;
            }
        }

        ob = new Object[] {
             Convert.ToInt32(ddls.SelectedValue)==-1?"": ddls.SelectedItem.Text, this.cbs.Checked,
             Convert.ToInt32(ddll.SelectedValue)==-1?"": ddll.SelectedItem.Text, this.cbl.Checked
        };

        Session["OpcionBusqueda"] = ob;

        Response.Clear();
        Response.Redirect("Area.aspx");
        Response.Flush();

        _Lista.ShowMessage(__mensaje, __pagina, "", "");
    }

    protected void btnActualizarInformacion_Click(object sender, EventArgs e)
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");

        //verificar permiso para enviar datos.
        string[] Datos = (string[])Session["__JSAR__"];
        bool rpta = this.VERIFICAR_PERMISOS_DERECHOS_ACCESO_PAGINA_WEB(Convert.ToInt32(Datos[0]),
        "Area.aspx", "ACTUALIZAR");
        if (rpta == false)
        {
            this.__mensaje.Value = "Ud. no esta autorizado para ACTUALIZAR INFORMACION en esta pagina web.";
            this.__pagina.Value = "CerrarSession.aspx";
            return;
        }

        Session["OpcionBusqueda"] = null;
        Response.Clear();
        Response.Redirect("Area.aspx");
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
        catch (Exception)
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
        catch (Exception)
        {
            ok = false;
            this.__mensaje.Value = "Error inesperado al intentar conectarnos con el servidor.";
            this.__pagina.Value = "";
        }
        return ok;
    }

}