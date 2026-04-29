using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Licencia_Elemento_Configuracion : System.Web.UI.Page
{
    //private String Ruta = "SERVER=JOSE-PC;DATABASE=GCS;Encrypt=False;INTEGRATED SECURITY=True;packet size=4096;";
    private String Ruta = System.Configuration.ConfigurationManager.ConnectionStrings["CadenaConeccion"].ToString();
    System.Web.UI.WebControls.TableRow tRow;
    Lista _Lista = new Lista();

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

    protected void Page_Load(object sender, EventArgs e)
    {
        //btnBucar.Attributes.Add("onclick", "");
        btnBucar.OnClientClick = "";
    

    }


    protected void Page_PreRender(object sender, EventArgs e)
    {
        Salvar_Datos_Formulario();
    }


    protected void btnRegistrar_Click(object sender, EventArgs e)
    {
        this.__mensaje.Value = "";
        this.__pagina.Value = "";

        //verificar permiso para REGISTRAR datos.
        string[] Datos = (string[])Session["__JSAR__"];
        bool rpta = this.VERIFICAR_PERMISOS_DERECHOS_ACCESO_PAGINA_WEB(Convert.ToInt32(Datos[0]),
        "LicenciaElementoConfiguracion.aspx", "NUEVO");
        if (rpta == false)
        {
            this.__mensaje.Value = "Ud. no esta autorizado para registrar datos en esta pagina web.";
            this.__pagina.Value = "CerrarSession.aspx";
            return;
        }

        Boolean ok;
        ok = rfvTIPO_LICENCIA_CI.IsValid;
        ok = ok && revTIPO_LICENCIA_CI.IsValid;
        ok = ok && rfvSUSCRIPCION_LICENCIA_CI.IsValid;
        ok = ok && revSUSCRIPCION_LICENCIA_CI.IsValid;
        ok = ok && rfvNOMBRE.IsValid;
        ok = ok && rfvVERSION.IsValid;
        if (rfvFechaInicioVersion.Enabled == true && rfvFechaFinVersion.Enabled == true && cvFechas.Enabled == true)
        {
            ok = ok && rfvFechaInicioVersion.IsValid;
            ok = ok && rfvFechaFinVersion.IsValid;
            ok = ok && cvFechas.IsValid;
        }
        ok = ok && rfvDESCRIPCION.IsValid;
        if (ok == false)
        {
            return;
        }

        String TL = this.ddlTIPO_LICENCIA_CI.SelectedItem.Text.Trim();
        String SL = this.ddlSUSCRIPCION_LICENCIA_CI.SelectedItem.Text.Trim();

        if ((TL == "PROPIETARIO" || TL == "LIBRE" || TL == "CODIGO ABIERTO") && SL == "NINGUNA")
        {
            if (this.LICENCIA_PERPETUA.Checked == false)
            {
                _Lista.ShowMessage(__mensaje, __pagina, "Pra el Tipo Licencia: " + TL + "\ny\nSuscripcion Licencia: " + SL + "\nDebe estar activada la Licencia Perpetua", "");
                return;
            }
        }

        if (TL == "PROPIETARIO" && SL != "NINGUNA")
        {
            if (this.LICENCIA_PERPETUA.Checked == true)
            {
                _Lista.ShowMessage(__mensaje, __pagina, "Pra el Tipo Licencia: " + TL + "\ny\nSuscripcion Licencia: " + SL + "\nDebe estar desactivada la Licencia Perpetua", "");
                return;
            }
        }

        if (_Lista.Verifica_Datos_Tabla((DataTable)Session["_DET_RELACION_LICENCIA_CI"]) == false)
        {
            _Lista.ShowMessage(__mensaje, __pagina, "Tabla Detalle Relacion Licencias Elemento Configuracion no tiene no tiene elementos de configuracion, ingrese datos por favor.", "");
            return;
        }

        try
        {
            if (Convert.ToInt32(this.hfID_LICENCIA_ELE_CONF.Value) == -1)
            {
                this._operacion.Value = "N";
            }
            else
            {
                this._operacion.Value = "M";
            }
            object fi = txtFechaInicioVersion.Text.Trim();
            if (fi.ToString() == "")
            {
                fi = null;
            }
            else
            {
                fi = Convert.ToDateTime(fi);
            }

            object ff = txtFechaFinVersion.Text.Trim();
            if (ff.ToString() == "")
            {
                ff = null;
            }
            else
            {
                ff = Convert.ToDateTime(ff);
            }

            int _CODIGO_LICENCIA_ELE_CONF = -1;
            policia.clsaccesodatos servidor = new policia.clsaccesodatos();
            servidor.cadenaconexion = Ruta;
            if (servidor.abrirconexiontrans() == true)
            {
                servidor.ejecutar("[dbo].[pr_MatenimientoLicenciaElementoConfiguracion]",
                false,
                Convert.ToInt32(this.hfID_LICENCIA_ELE_CONF.Value),
                Convert.ToInt32(this.ddlTIPO_LICENCIA_CI.SelectedValue),
                this.NOMBRE.Text.Trim(),
                this.VERSION.Text.Trim(),
                Convert.ToInt32(this.ddlSUSCRIPCION_LICENCIA_CI.SelectedValue),
                fi,
                ff,
                this.LICENCIA_PERPETUA.Checked,
                this.DESCRIPCION.Text.Trim(),
                this._operacion.Value.Trim(),
                0, "");
                if (_operacion.Value.Equals("N"))
                {
                    _CODIGO_LICENCIA_ELE_CONF = servidor.getRespuesta();
                }
                else if (_operacion.Value.Equals("M"))
                {
                    _CODIGO_LICENCIA_ELE_CONF = Convert.ToInt32(this.hfID_LICENCIA_ELE_CONF.Value);
                }
                if (_CODIGO_LICENCIA_ELE_CONF > 0)
                {
                    for (int i = 1; i < this.Table_.Rows.Count; i++)//en la fila 0 esta la cabecera de la tabla.
                    {
                        servidor.ejecutar("[dbo].[pr_MatenimientoRelacionLicenciaElementoConfiguracion]",
                                                             false,
                                                             Convert.ToInt32(this.Table_.Rows[i].Cells[0].Text.Trim()), //_ID_RELACION
                                                             Convert.ToInt32(this.Table_.Rows[i].Cells[1].Text.Trim()), //_ID_ELEMENTO_CONFIGURACION
                                                             _CODIGO_LICENCIA_ELE_CONF, //_ID_LICENCIA_ELE_CONF
                                                             this._operacion.Value.Trim(),
                                                             0, "");
                    }
                    if (servidor.getRespuesta() == 1)
                    {
                        servidor.cerrarconexiontrans();
                        Session["_DET_RELACION_LICENCIA_CI"] = null;
                        Session["__CABECERA_LICENCIA__"] = null;
                        _Lista.ShowMessage(__mensaje, __pagina, servidor.getMensaje(), "LicenciasElementoConfiguracion.aspx");
                    }
                    else
                    {
                        servidor.cancelarconexiontrans();
                        _Lista.ShowMessage(__mensaje, __pagina, servidor.getMensaje(), "");
                    }
                }
                else
                {
                    servidor.cancelarconexiontrans();
                    _Lista.ShowMessage(__mensaje, __pagina, servidor.getMensaje(), "");
                }
            }
            else
            {
                servidor.cancelarconexiontrans();
                _Lista.ShowMessage(__mensaje, __pagina, servidor.getMensageError(), "CerrarSession.aspx");
            }
        }
        catch (Exception)
        {
            _Lista.ShowMessage(__mensaje, __pagina, "Error inesperado al intentar conectarnos con el servidor.", "");
        }
    }

    protected void btnAgregarCI_Click(object sender, EventArgs e)
    {
        this.__mensaje.Value = "";
        this.__pagina.Value = "";

        //verificar permiso para REGISTRAR datos.
        string[] Datos = (string[])Session["__JSAR__"];
        bool rpta = this.VERIFICAR_PERMISOS_DERECHOS_ACCESO_PAGINA_WEB(Convert.ToInt32(Datos[0]),
        "LicenciaElementoConfiguracion.aspx", "AGREGAR");
        if (rpta == false)
        {
            this.__mensaje.Value = "Ud. no esta autorizado para AGREGAR registros en esta pagina web.";
            this.__pagina.Value = "CerrarSession.aspx";
            return;
        }

        int ID_CI = Convert.ToInt32(this.ID_ELEMENTO_CONFIGURACION.Value);
        if(ID_CI==0) {
            _Lista.ShowMessage(__mensaje, __pagina, "No hay datos elemento configuracion software para agregar a la tabla, haga click en el boton buscar elemento configuracion.", "");
            return;
        }

        object[,] r = new object[1, 2];
        r[0, 0] = new object[] { 2, 3 }; //Columnas a validar: TIPO CI, NOMBRE CI.
        r[0, 1] = new object[] { this.TIPO_CI.Text.Trim(), this.NOMBRE_CI.Text.Trim() };
        if (_Lista.Validar_Datos_Tabla((DataTable)Session["_DET_RELACION_LICENCIA_CI"], r) == true)
        {
            _Lista.ShowMessage(__mensaje, __pagina, "Detalle Licencia Elemento Configuracion.\n\nElemento configuracion ya existe en la tabla", "");
            return;
        }

        DataTable dt = (DataTable)Session["_DET_RELACION_LICENCIA_CI"];
        dt.Rows.Add("-1",
                this.ID_ELEMENTO_CONFIGURACION.Value.Trim(),
                this.TIPO_CI.Text.Trim(),
                this.NOMBRE_CI.Text.Trim(),
                this.NRO_SERIE.Text.Trim(),
                this.PROPIETARIO_CI.Text.Trim(),
                this.DESCRIPCION_CI.Text.Trim()             
                );
        Session["_DET_RELACION_LICENCIA_CI"] = dt;


        Salvar_Datos_Formulario();

        Response.Clear();
        Response.Redirect("LicenciaElementoConfiguracion.aspx");
        Response.Flush();
    }

    void Salvar_Datos_Formulario() {
        Session["__CABECERA_LICENCIA__"] = new object[] {
        hfID_LICENCIA_ELE_CONF.Value,
        ddlTIPO_LICENCIA_CI .SelectedItem.Text,
        ddlSUSCRIPCION_LICENCIA_CI .SelectedItem.Text,
        NOMBRE.Text,
        VERSION.Text,
        txtFechaInicioVersion.Text,
        txtFechaFinVersion.Text,
        LICENCIA_PERPETUA.Checked,
        DESCRIPCION.Text};
    }

    protected void Page_Init(object sender, EventArgs e) {

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
        "LicenciaElementoConfiguracion.aspx");
        if (rpta == false)
        {
            this.__mensaje.Value = "Ud. no tiene permiso para ACCEDER esta pagina web.";
            this.__pagina.Value = "CerrarSession.aspx";
            return;
        }

        Cargar_Datos(this.ddlTIPO_LICENCIA_CI, "[dbo].[pr_Obtener_Tipo_Liecencia_CI]", "Error, al intentar recuperar Tipos de Licencia Elemento Configuracion.");
        if (this.__mensaje.Value.ToString().Trim() != "")
        {
            return;
        }

        

        if (Session["__CABECERA_LICENCIA__"] != null)
        {

            object[] FORMULARIO = (object[])Session["__CABECERA_LICENCIA__"];
            hfID_LICENCIA_ELE_CONF.Value = FORMULARIO[0].ToString().Trim();
            for (int i = 0; i < this.ddlTIPO_LICENCIA_CI.Items.Count; i++)
            {
                if (this.ddlTIPO_LICENCIA_CI.Items[i].Text.ToString().Trim() == FORMULARIO[1].ToString().Trim())
                {
                    this.ddlTIPO_LICENCIA_CI.SelectedIndex = i;
                }
            }
            ddlTIPO_LICENCIA_CI_SelectedIndexChanged(sender, e);
            for (int i = 0; i < this.ddlSUSCRIPCION_LICENCIA_CI.Items.Count; i++)
            {

                if (this.ddlSUSCRIPCION_LICENCIA_CI.Items[i].Text.ToString().Trim() == FORMULARIO[2].ToString().Trim())
                {
                    this.ddlSUSCRIPCION_LICENCIA_CI.SelectedIndex = i;

                }

            }
            ddlSUSCRIPCION_LICENCIA_CI_SelectedIndexChanged(sender, e);
            NOMBRE.Text = FORMULARIO[3].ToString().Trim();
            VERSION.Text = FORMULARIO[4].ToString().Trim();
            txtFechaInicioVersion.Text = FORMULARIO[5].ToString().Trim()==""? "": Convert.ToDateTime(FORMULARIO[5].ToString().Trim()).ToShortDateString();
            txtFechaFinVersion.Text = FORMULARIO[6].ToString().Trim() == "" ? "" : Convert.ToDateTime(FORMULARIO[6].ToString().Trim()).ToShortDateString();
            //LICENCIA_PERPETUA.Checked = Convert.ToBoolean(FORMULARIO[7]);
            LICENCIA_PERPETUA.Checked = FORMULARIO[7].ToString().Trim().Equals("si")? true:false;
            DESCRIPCION.Text = FORMULARIO[8].ToString().Trim();
        }

        if (Session["_DET_RELACION_LICENCIA_CI"] == null)
        {
            Session["_DET_RELACION_LICENCIA_CI"] = _Lista.Crear_Cabecera_Grilla("ID RE",
                "ID CI",
                "TIPO CI",
                "NOMBRE CI",
                "NRO SERIE",
                "PROPIETARIO",
                "DESCRIPCION CI"                
                );
        }

        if (Convert.ToInt32(this.hfID_LICENCIA_ELE_CONF.Value) == -1)
        {
            this.btnRegistrar.OnClientClick = "return Confirmar('¿Desea guardar licencia elementos configuracion?');";
        }
        else
        {
            this.btnRegistrar.OnClientClick = "return Confirmar('¿Desea modificar licencia elementos configuracion?');";
        }


        Listar_Detalle_Relacion_Licencia_Elemento_Configuracion((DataTable)Session["_DET_RELACION_LICENCIA_CI"]);
    }


    private void Listar_Detalle_Relacion_Licencia_Elemento_Configuracion(DataTable dt)
    {
       
        if (dt.Rows.Count == 0)
        {
            _Lista.ShowMessage(__mensaje, __pagina, "No hay detalles realacion licencia para mostrar para mostrar", "");
        }
        else
        {
            if (dt.Rows[0].ItemArray[0].ToString() == "")
            {
                dt.Rows[0].Delete();
            }

            for (int i = 0; i < dt.Rows.Count; i++)
            {
                tRow = new TableRow();
                tRow.BorderColor = System.Drawing.Color.Black;
                for (int j = 0; j < Table_.Rows[i].Cells.Count; j++)//Cabecera de la tabla
                {
                    TableCell tCell = new TableCell();
                    switch (j)
                    {
                        case 0:
                            tCell.Text = dt.Rows[i]["ID RE"].ToString().Trim();
                            tCell.Visible = false;
                            tRow.Cells.Add(tCell);
                            break;
                        case 1:
                            tCell.Text = dt.Rows[i]["ID CI"].ToString().Trim();
                            tCell.Visible = false;
                            tRow.Cells.Add(tCell);
                            break;
                        case 2:
                            tCell.Text = dt.Rows[i]["TIPO CI"].ToString().Trim();
                            tCell.Visible = true;
                            tRow.Cells.Add(tCell);
                            break;
                        case 3:
                            tCell.Text = dt.Rows[i]["NOMBRE CI"].ToString().Trim();
                            tCell.Visible = true;
                            tRow.Cells.Add(tCell);
                            break;
                        case 4:
                            tCell.Text = dt.Rows[i]["NRO SERIE"].ToString().Trim();
                            tCell.Visible = true;
                            tRow.Cells.Add(tCell);
                            break;
                        case 5:
                            tCell.Text = dt.Rows[i]["PROPIETARIO"].ToString().Trim();
                            tCell.Visible = true;
                            tRow.Cells.Add(tCell);
                            break;
                        case 6:
                            tCell.Text = dt.Rows[i]["DESCRIPCION CI"].ToString().Trim();
                            tCell.Visible = true;
                            tRow.Cells.Add(tCell);
                            break;
                        case 7:
                            //verificar permiso para enviar datos.
                            string[] Datos = (string[])Session["__JSAR__"];
                            bool rpta = this.VERIFICAR_PERMISOS_DERECHOS_ACCESO_PAGINA_WEB(Convert.ToInt32(Datos[0]),
                            "LicenciaElementoConfiguracion.aspx", "QUITAR");

                            if (rpta == true)
                            {
                                System.Web.UI.WebControls.Button b = new System.Web.UI.WebControls.Button();
                                b.Attributes.Add("onclick", "return Confirmar('¿Desea quitar registro detalle licencia CI?');");
                                b.Font.Size = FontUnit.XSmall;
                                b.Text = "QUITAR";
                                b.ToolTip = "Seleccione detalle CI";
                                b.BorderStyle = BorderStyle.None;
                                b.CausesValidation = false;
                                b.UseSubmitBehavior = true;
                                b.CssClass = "btn btn-link";
                                b.CommandArgument = i.ToString().Trim();
                                b.Click += new System.EventHandler(Quitar_Datos_Detalle_Licencia);
                                tCell.HorizontalAlign = HorizontalAlign.Center;
                                tCell.Controls.Add(b);
                                tRow.Cells.Add(tCell);
                            }
                            else
                            {
                                tCell.Text = "SIN PERMISO PARA QUITAR REGISTRO";
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
            

        }
    }

    protected void Quitar_Datos_Detalle_Licencia(object sender, EventArgs e)
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");
        System.Web.UI.WebControls.Button b = (System.Web.UI.WebControls.Button)sender;
        int IndiceFila = Convert.ToInt32(b.CommandArgument.Trim());
        if (Convert.ToInt32(((DataTable)Session["_DET_RELACION_LICENCIA_CI"]).Rows[IndiceFila].ItemArray[0]) != -1)
        {
            _Lista.ShowMessage(__mensaje, __pagina, "Detalle Tarea no se puede quitar, solo se pueden quitar registros agregados recientemente.", "");
            return;
        }
        Session["_DET_RELACION_LICENCIA_CI"] = _Lista.Eliminar_Fila_Tabla_Datos((DataTable)Session["_DET_RELACION_LICENCIA_CI"], IndiceFila);
        if (((DataTable)Session["_DET_RELACION_LICENCIA_CI"]).Rows.Count == 0)
        {
            Session["_DET_RELACION_LICENCIA_CI"] = null;
           
        }
        Salvar_Datos_Formulario();
        Response.Clear();
        Response.Redirect("LicenciaElementoConfiguracion.aspx");
        Response.Flush();
    }

    protected void ddlTIPO_LICENCIA_CI_SelectedIndexChanged(object sender, EventArgs e)
    {
        this.__mensaje.Value = "";
        this.__pagina.Value = "";
        this.ddlSUSCRIPCION_LICENCIA_CI.Items.Clear();
        this.ddlSUSCRIPCION_LICENCIA_CI.Items.Insert(0, "_____SELECCIONE SUSCRIPCION LICENCIA ELEMENTO CONFIGURACION_____");
        this.ddlSUSCRIPCION_LICENCIA_CI.Items[0].Value = "-1";
        int Codigo_Tipo_Licencia = Convert.ToInt32(ddlTIPO_LICENCIA_CI.SelectedValue);
        if (Codigo_Tipo_Licencia == -1){
            this.__mensaje.Value = "Seleccione Tipo Licencia Elemento Configuracion";
            this.__pagina.Value = "";
            return;
        }
        Cargar_Datos(this.ddlSUSCRIPCION_LICENCIA_CI, "[dbo].[pr_Obtener_Suscripcion_Licencia_Elemento_Configuracion]", "Error, al intentar recuperar LSuscripcion de Licencia Elemento Configuracion.", new Object[] { Codigo_Tipo_Licencia });
        if (this.__mensaje.Value.ToString().Trim() != "") {
            return;
        }
        Salvar_Datos_Formulario();
    }

    protected void btnBucar_Click(object sender, EventArgs e)
    {
        this.__mensaje.Value = "";
        this.__pagina.Value = "";

        //verificar permiso para eliminar datos.
        string[] Datos = (string[])Session["__JSAR__"];
        bool rpta = this.VERIFICAR_PERMISOS_DERECHOS_ACCESO_PAGINA_WEB(Convert.ToInt32(Datos[0]),
        "LicenciaElementoConfiguracion.aspx", "BUSCAR");
        if (rpta == false)
        {
            this.__mensaje.Value = "Ud. no esta autorizado para BUSCAR datos en esta pagina web.";
            this.__pagina.Value = "CerrarSession.aspx";
            return;
        }

        Boolean ok;
        ok = rfvTIPO_LICENCIA_CI.IsValid;
        ok = ok && revTIPO_LICENCIA_CI.IsValid;
        ok = ok && rfvSUSCRIPCION_LICENCIA_CI.IsValid;
        ok = ok && revSUSCRIPCION_LICENCIA_CI.IsValid;
        ok = ok && rfvNOMBRE.IsValid;
        ok = ok && rfvVERSION.IsValid;
        if (rfvFechaInicioVersion.Enabled == true && rfvFechaFinVersion.Enabled == true && cvFechas.Enabled == true)
        {
            ok = ok && rfvFechaInicioVersion.IsValid;
            ok = ok && rfvFechaFinVersion.IsValid;
            ok = ok && cvFechas.IsValid;
        }
        ok = ok && rfvDESCRIPCION.IsValid;
        if (ok == false)
        {

            return;
        }
        btnBucar.OnClientClick = "abrir_ventana_Elementos_Configuracion_Software()";
        //this.Page.RegisterClientScriptBlock("", "<script lang='javascript'>abrir_ventana_Elementos_Configuracion_Software();</script>");
        //btnBucar.Attributes.Add("onclick", "javascript:abrir_ventana_Elementos_Configuracion_Software();");
    }

    protected void ddlSUSCRIPCION_LICENCIA_CI_SelectedIndexChanged(object sender, EventArgs e)
    {

        txtFechaInicioVersion.Text = "";
        txtFechaFinVersion.Text ="";
        string TL = ddlTIPO_LICENCIA_CI.SelectedItem.Text.Trim();
        string SL = ddlSUSCRIPCION_LICENCIA_CI.SelectedItem.Text.Trim();
        if (TL == "PROPIETARIO" && SL != "NINGUNA" && SL != "_____SELECCIONE SUSCRIPCION LICENCIA ELEMENTO CONFIGURACION_____") {
            this.rfvFechaInicioVersion.Enabled = true;
            this.rfvFechaFinVersion.Enabled = true;
            this.cvFechas.Enabled = true;
        }
        else {
            this.rfvFechaInicioVersion.Enabled = false;
            this.rfvFechaFinVersion.Enabled = false;
            this.cvFechas.Enabled = true;
        } 
        
        
    }

    private void ShowMessage(string msg, string paginaweb)
    {
        this.__mensaje.Value = msg;
        this.__pagina.Value = paginaweb;
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