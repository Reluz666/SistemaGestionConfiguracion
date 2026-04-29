using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class LicenciasElementoConfiguracion : System.Web.UI.Page
{
    //private String Ruta = "SERVER=JOSE-PC;DATABASE=GCS;Encrypt=False;INTEGRATED SECURITY=True;packet size=4096;";
    private String Ruta = System.Configuration.ConfigurationManager.ConnectionStrings["CadenaConeccion"].ToString();
    Lista _Lista = new Lista();

    //Button btnEleminarLicencia = new Button();

    protected void Page_Load(object sender, EventArgs e)
    {
       
    }

    protected void Page_Init(object sender, EventArgs e)
    {

        string[] Datos = (string[])Session["__JSAR__"];

        if (Datos == null)
        {

            this.__mensaje.Value = "Ud. no esta autorizado para ingresar a esta página, inicie sesion por favor.";

            this.__pagina.Value = "CerrarSession.aspx";

            return;

        }

        Cargar_Datos(this.ddltl, "[dbo].[pr_Obtener_Tipo_Liecencia_CI]", "Error, al intentar recuperar Tipos de Licencia Elemento Configuracion.");
        if (this.__mensaje.Value.ToString().Trim() != "")
        {
            return;
        }
        if (Session["OpcionBusqueda"] == null)
        {
            loadLicencias("","","","","");
        }
        else
        {
            Object[] ob = (Object[])Session["OpcionBusqueda"];
            
            this.cbtl.Checked = (bool)ob[1];
            ddltl.Enabled = (bool)ob[1];
            for (int i = 0; i < this.ddltl.Items.Count; i++)
            {
                if (this.ddltl.Items[i].Text == ob[0].ToString().Trim())
                    this.ddltl.SelectedIndex = i;
            }
            ddltl_SelectedIndexChanged(sender, e);

            this.cbs.Checked = (bool)ob[3];
            ddls.Enabled = (bool)ob[3];
            for (int i = 0; i < this.ddls.Items.Count; i++)
            {
                if (this.ddls.Items[i].Text == ob[2].ToString().Trim())
                    this.ddls.SelectedIndex = i;
            }

            this.cbp.Checked = (bool)ob[5];
            ddlp.Enabled = (bool)ob[5];
            for (int i = 0; i < this.ddlp.Items.Count; i++)
            {
                if (this.ddlp.Items[i].Text == ob[4].ToString().Trim())
                    this.ddlp.SelectedIndex = i;
            }

            this.cbf.Checked = (bool)ob[8];
            txtFechaInicioSuscripcion.Enabled = (bool)ob[8];
            txtFechaFinSuscripcion.Enabled = (bool)ob[8];
            txtFechaInicioSuscripcion.Text = ob[6].ToString().Trim();
            txtFechaFinSuscripcion.Text = ob[7].ToString().Trim();

            this.loadLicencias(ob[0].ToString().Trim(),
            ob[2].ToString().Trim(),
            ob[4].ToString().Trim(),
            ob[6].ToString().Trim(),
            ob[7].ToString().Trim());            
        }
       
    }

    protected void Enviar_Datos_Licencia(object sender, EventArgs e)
    {
      
        System.Web.UI.WebControls.Button b = (System.Web.UI.WebControls.Button)sender;
        String Registro = b.CommandArgument.Trim();
        String[] Datos = Registro.Split(',');
        Session["__CABECERA_LICENCIA__"] = new object[] { Datos[0],
        Datos[1],
        Datos[2],
        Datos[3],
        Datos[4],
        Datos[5],
        Datos[6],
        Datos[7].ToLower(),
        Datos[8]
       };

        DataTable dt = getDetalleLicencias(Convert.ToInt32(Datos[0]));
        Session["_DET_RELACION_LICENCIA_CI"] = dt;

        Response.Clear();
        Response.Redirect("LicenciaElementoConfiguracion.aspx");
        Response.Flush();

    }
    private void loadLicencias(string _TIPOLICENCIA, string _SUSCRIPCIONLICENCIA, string _LICENCIAPERPETUA, string _FECHA_INICIO_SUSCRIPCION_LICENCIA, string _FECHA_FIN_SUSCRIPCION_LICENCIA) {
        DataTable dtLicencias = this.getLicencias(_TIPOLICENCIA, _SUSCRIPCIONLICENCIA, _LICENCIAPERPETUA, _FECHA_INICIO_SUSCRIPCION_LICENCIA, _FECHA_FIN_SUSCRIPCION_LICENCIA);

        TableRow headerRow = new TableRow();
        headerRow.Cells.Add(new TableCell { Text = "ID LI", Font = { Bold = true }, ForeColor = System.Drawing.Color.White, BackColor = System.Drawing.Color.Black });
        headerRow.Cells[0].Visible = false;
        headerRow.Cells.Add(new TableCell { Text = "TIPO LICENCIA", Font = { Bold = true }, ForeColor = System.Drawing.Color.White, BackColor = System.Drawing.Color.Black });
        headerRow.Cells.Add(new TableCell { Text = "NOMBRE", Font = { Bold = true }, ForeColor = System.Drawing.Color.White, BackColor = System.Drawing.Color.Black });
        headerRow.Cells.Add(new TableCell { Text = "VERSION", Font = { Bold = true }, ForeColor = System.Drawing.Color.White, BackColor = System.Drawing.Color.Black });
        headerRow.Cells.Add(new TableCell { Text = "SUSCRIPCION", Font = { Bold = true }, ForeColor = System.Drawing.Color.White, BackColor = System.Drawing.Color.Black });
        headerRow.Cells.Add(new TableCell { Text = "FEC. INI.", Font = { Bold = true }, ForeColor = System.Drawing.Color.White, BackColor = System.Drawing.Color.Black });
        headerRow.Cells.Add(new TableCell { Text = "FEC. FIN", Font = { Bold = true }, ForeColor = System.Drawing.Color.White, BackColor = System.Drawing.Color.Black });
        headerRow.Cells.Add(new TableCell { Text = "PERPETUA", Font = { Bold = true }, ForeColor = System.Drawing.Color.White, BackColor = System.Drawing.Color.Black });
        headerRow.Cells.Add(new TableCell { Text = "DESCRIPCION", Font = { Bold = true }, ForeColor = System.Drawing.Color.White, BackColor = System.Drawing.Color.Black });
        headerRow.Cells.Add(new TableCell { Text = "VENCE LICENCIA", Font = { Bold = true }, ForeColor = System.Drawing.Color.White, BackColor = System.Drawing.Color.Black });

        tblLicencias.Rows.Add(headerRow);
        tblLicencias.Font.Size = FontUnit.XSmall;

        foreach (DataRow row in dtLicencias.Rows)
        {
            TableRow conceptoRow = new TableRow();
            //System.Web.UI.WebControls.HyperLink h = new System.Web.UI.WebControls.HyperLink();
            //h.Height = 25;
            //h.Text = "Editar";
            //h.BorderStyle = BorderStyle.None;
            //h.NavigateUrl = "~/LicenciaElementoConfiguracion.aspx?Operacion=M&IDLEC=" + row["ID LI"].ToString();
            //System.Web.UI.WebControls.Button b = new System.Web.UI.WebControls.Button();
            //b.Text = "Editar";
            //b.ToolTip = "Seleccione Liecencia";
            //b.BorderStyle = BorderStyle.None;
            //b.CausesValidation = false;
            //b.UseSubmitBehavior = true;
            //b.CssClass = "btn btn-success";
            //b.CommandArgument = row["ID LI"].ToString() + "," +
            //                    row["LICENCIA"].ToString() + "," +
            //                    row["SUSCRIPCION"].ToString() + "," +
            //                    row["NOMBRE"].ToString() + "," +
            //                    row["VERSION"].ToString() + "," +
            //                    row["FEC. INI."].ToString() + "," +
            //                    row["FEC. FIN"].ToString() + "," +
            //                    row["PERPETUA"].ToString() + "," +
            //                    row["DESCRIPCION"].ToString();
            ////b.PostBackUrl = "ejemplo.aspx?CODIGOEJEMPLO=" + dt.Rows[i]["COD EJEMPLO"].ToString() + "&CODIGOSUBTEMA=" + dt.Rows[i]["COD SUBTEMA"].ToString() + "&SUBTEMA=" + dt.Rows[i]["SUB TEMA"].ToString();
            //b.Click += new System.EventHandler(Enviar_Datos_Licencia);
            //TableCell IDLICell = new TableCell { };
            //IDLICell.Controls.Add(b);

            TableCell IDLICell = new TableCell { Text = row["ID LI"].ToString() };
            TableCell LICENCIACell = new TableCell { Text = row["LICENCIA"].ToString() };
            TableCell NOMBRECell = new TableCell { Text = row["NOMBRE"].ToString() };
            TableCell VERSIONCell = new TableCell { Text = row["VERSION"].ToString() };
            TableCell SUSCRIPCIONCell = new TableCell { Text = row["SUSCRIPCION"].ToString() };
            TableCell FECINICell = new TableCell { Text = row["FEC. INI."].ToString() == "" ? "---" : Convert.ToDateTime(row["FEC. INI."].ToString()).ToShortDateString() };
            TableCell FECFINCell = new TableCell { Text = row["FEC. FIN"].ToString() == "" ? "---" : Convert.ToDateTime(row["FEC. FIN"].ToString()).ToShortDateString() };
            TableCell PERPETUACell = new TableCell { Text = row["PERPETUA"].ToString() };
            TableCell DESCRIPCIONCell = new TableCell { Text = row["DESCRIPCION"].ToString() };
            TableCell VENCELICENCIACell = new TableCell { Text = row["VENCE LICENCIA"].ToString() };
            TableCell accionCell = new TableCell();
           
            // Botón para ver detalles
            Button btnVerDetalles = new Button
            {
                Text = "Ver Detalles",
                CssClass = "btn btn-info",
                CommandArgument = row["ID LI"].ToString(),
                OnClientClick = String.Format("toggleRow('details-{0}');", row["ID LI"]) // Usa String.Format
            };
            btnVerDetalles.Click += new EventHandler(btnVerDetalles_Click); // Controlar los clics del botón
            accionCell.Controls.Add(btnVerDetalles);


            conceptoRow.Cells.Add(IDLICell);
            conceptoRow.Cells[0].Visible = false;
            conceptoRow.Cells.Add(LICENCIACell);
            conceptoRow.Cells.Add(NOMBRECell);
            conceptoRow.Cells.Add(VERSIONCell);
            conceptoRow.Cells.Add(SUSCRIPCIONCell);
            conceptoRow.Cells.Add(FECINICell);
            conceptoRow.Cells.Add(FECFINCell);
            conceptoRow.Cells.Add(PERPETUACell);
            conceptoRow.Cells.Add(DESCRIPCIONCell);
            conceptoRow.Cells.Add(VENCELICENCIACell);

            if (row["PERPETUA"].ToString() == "SI")
                conceptoRow.Cells[7].ForeColor = System.Drawing.Color.Blue;
            else if (row["PERPETUA"].ToString() == "NO")
                conceptoRow.Cells[7].ForeColor = System.Drawing.Color.Red;

            if (row["VENCE LICENCIA"].ToString()== "LICENCIA VENCIDA")
                conceptoRow.Cells[9].ForeColor = System.Drawing.Color.Red;
            else if (row["VENCE LICENCIA"].ToString() == "LICENCIA NO VENCE")
                conceptoRow.Cells[9].ForeColor = System.Drawing.Color.Green;
            else
                conceptoRow.Cells[9].ForeColor = System.Drawing.Color.Blue;
           conceptoRow.Cells.Add(accionCell);
           tblLicencias.Rows.Add(conceptoRow);

            // Crear una fila para los detalles (inicialmente oculta con display: none)
            TableRow detallesRow = new TableRow();
            detallesRow.ID = "details-" + row["ID LI"].ToString();
            detallesRow.Style.Add("display", "none");

            TableCell detallesCell = new TableCell { ColumnSpan = 10 }; // Detalles ocupan toda la fila
            detallesRow.Cells.Add(detallesCell);
            tblLicencias.Rows.Add(detallesRow);
        }


    }

    protected void btnEleiminarLiecencias_Click(object sender, EventArgs e) {
        Button btn = (Button)sender;
        int idLicencia = Convert.ToInt32(btn.CommandArgument);
        try
        {
            policia.clsaccesodatos servidor = new policia.clsaccesodatos();
            servidor.cadenaconexion = Ruta;
            if (servidor.abrirconexiontrans() == true){
                servidor.ejecutar("[dbo].[pr_MatenimientoLicenciaElementoConfiguracion]",
                false,
                idLicencia,
                null,
                null,
                null,
                null,
                null,
                null,
                null,
                null,
                "E",
                0, "");               
                if (servidor.getRespuesta() == 1){
                   servidor.cerrarconexiontrans();                        
                   _Lista.ShowMessage(__mensaje, __pagina, servidor.getMensaje(), "LicenciasElementoConfiguracion.aspx");
                }
                else{
                    servidor.cancelarconexiontrans();
                    _Lista.ShowMessage(__mensaje, __pagina, servidor.getMensaje(), "");
                }                
            }
            else{
                servidor.cancelarconexiontrans();
                _Lista.ShowMessage(__mensaje, __pagina, servidor.getMensageError(), "CerrarSession.aspx");
            }
        }
        catch (Exception)
        {
            _Lista.ShowMessage(__mensaje, __pagina, "Error inesperado al intentar conectarnos con el servidor.", "");
        }
    }
    protected void btnVerDetalles_Click(object sender, EventArgs e)
    {
        Button btn = (Button)sender;
        int idConcepto = Convert.ToInt32(btn.CommandArgument);

        // Buscar la fila correspondiente en la tabla (detallesRow)
        TableRow detallesRow = (TableRow)tblLicencias.FindControl("details-" + idConcepto);
        detallesRow.Font.Size =FontUnit.XSmall;

        if (detallesRow != null)
        {
            // Verificar si la fila está actualmente visible o no
            if (detallesRow.Style["display"] == "none")
            {
                // Si está oculta, cargamos los detalles
                DataTable dtDetalles = getDetalleLicencias(idConcepto);
                TableCell detallesCell = detallesRow.Cells[0];
                detallesCell.Controls.Clear(); // Limpiar cualquier contenido previo

                // Crear una nueva tabla interna para mostrar los detalles
                Table innerTable = new Table
                {
                    CssClass = "table table-striped table-hover"  // Aplicar clases de Bootstrap
                };

                // Crear fila de encabezado para los detalles
                TableRow headerRow = new TableRow();
                headerRow.Cells.Add(new TableCell { Text = "ID RE", Font = { Bold = true }, ForeColor = System.Drawing.Color.White, BackColor = System.Drawing.Color.Black });
                headerRow.Cells[0].Visible = false;
                headerRow.Cells.Add(new TableCell { Text = "ID CI", Font = { Bold = true }, ForeColor = System.Drawing.Color.White, BackColor = System.Drawing.Color.Black });
                headerRow.Cells[1].Visible = false;
                headerRow.Cells.Add(new TableCell { Text = "TIPO CI", Font = { Bold = true }, ForeColor = System.Drawing.Color.White, BackColor = System.Drawing.Color.Black });
                headerRow.Cells.Add(new TableCell { Text = "NOMBRE CI", Font = { Bold = true }, ForeColor = System.Drawing.Color.White, BackColor = System.Drawing.Color.Black });
                headerRow.Cells.Add(new TableCell { Text = "NRO SERIE", Font = { Bold = true }, ForeColor = System.Drawing.Color.White, BackColor = System.Drawing.Color.Black });
                headerRow.Cells.Add(new TableCell { Text = "PROPIETARIO", Font = { Bold = true }, ForeColor = System.Drawing.Color.White, BackColor = System.Drawing.Color.Black });
                headerRow.Cells.Add(new TableCell { Text = "DESCRIPCION CI", Font = { Bold = true }, ForeColor = System.Drawing.Color.White, BackColor = System.Drawing.Color.Black });
                headerRow.Cells.Add(new TableCell { Text = "ID_LICENCIA_ELE_CONF", Font = { Bold = true }, ForeColor = System.Drawing.Color.White, BackColor = System.Drawing.Color.Black });
                headerRow.Cells[7].Visible = false;
                headerRow.Cells.Add(new TableCell { Text = "SEDE", Font = { Bold = true }, ForeColor = System.Drawing.Color.White, BackColor = System.Drawing.Color.Black });
                headerRow.Cells.Add(new TableCell { Text = "LOCAL", Font = { Bold = true }, ForeColor = System.Drawing.Color.White, BackColor = System.Drawing.Color.Black });
                headerRow.Cells.Add(new TableCell { Text = "AREA", Font = { Bold = true }, ForeColor = System.Drawing.Color.White, BackColor = System.Drawing.Color.Black });
                headerRow.Cells.Add(new TableCell { Text = "NRO PISO", Font = { Bold = true }, ForeColor = System.Drawing.Color.White, BackColor = System.Drawing.Color.Black });
                headerRow.Cells.Add(new TableCell { Text = "NRO AMBIENTE", Font = { Bold = true }, ForeColor = System.Drawing.Color.White, BackColor = System.Drawing.Color.Black });

                // Agregar la fila de encabezado a la tabla interna
                innerTable.Rows.Add(headerRow);

                // Iterar sobre cada fila del DataTable de detalles
                foreach (DataRow detalle in dtDetalles.Rows)
                {
                    TableRow detalleRow = new TableRow();
                    detalleRow.Cells.Add(new TableCell { Text = detalle["ID RE"].ToString() });
                    detalleRow.Cells[0].Visible = false;
                    detalleRow.Cells.Add(new TableCell { Text = detalle["ID CI"].ToString() });
                    detalleRow.Cells[1].Visible = false;
                    detalleRow.Cells.Add(new TableCell { Text = detalle["TIPO CI"].ToString() });
                    detalleRow.Cells.Add(new TableCell { Text = detalle["NOMBRE CI"].ToString() });
                    detalleRow.Cells.Add(new TableCell { Text = detalle["NRO SERIE"].ToString() });
                    detalleRow.Cells.Add(new TableCell { Text = detalle["PROPIETARIO"].ToString() });
                    detalleRow.Cells.Add(new TableCell { Text = detalle["DESCRIPCION CI"].ToString() });
                    detalleRow.Cells.Add(new TableCell { Text = detalle["ID_LICENCIA_ELE_CONF"].ToString() });
                    detalleRow.Cells[7].Visible = false;
                    detalleRow.Cells.Add(new TableCell { Text = detalle["SEDE"].ToString() });
                    detalleRow.Cells.Add(new TableCell { Text = detalle["LOCAL"].ToString() });
                    detalleRow.Cells.Add(new TableCell { Text = detalle["AREA"].ToString() });
                    detalleRow.Cells.Add(new TableCell { Text = detalle["NRO PISO"].ToString() });
                    detalleRow.Cells.Add(new TableCell { Text = detalle["NRO AMBIENTE"].ToString() });
                    innerTable.Rows.Add(detalleRow);
                }

                // Agregar la tabla interna a la celda de la fila expandida
                detallesCell.Controls.Add(innerTable);

                
                // Mostrar la fila
                detallesRow.Style["display"] = ""; // Mostrar la fila de detalles
            }
            else
            {
                // Si ya está visible, la ocultamos
                detallesRow.Style["display"] = "none"; // Ocultar la fila de detalles
            }
        }
        
    }


    private DataTable getLicencias(string _TIPOLICENCIA, string _SUSCRIPCIONLICENCIA, string _LICENCIAPERPETUA, string _FECHA_INICIO_SUSCRIPCION_LICENCIA, string _FECHA_FIN_SUSCRIPCION_LICENCIA)
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");
        DataTable dt = null;

        try
        {
            policia.clsaccesodatos servidor = new policia.clsaccesodatos();
            servidor.cadenaconexion = Ruta;
            if (servidor.abrirconexion() == true) {
                dt = servidor.consultar("[dbo].[pr_ListaLicencias]", _TIPOLICENCIA, _SUSCRIPCIONLICENCIA, _LICENCIAPERPETUA, _FECHA_INICIO_SUSCRIPCION_LICENCIA, _FECHA_FIN_SUSCRIPCION_LICENCIA).Tables[0]; 
                if(dt.Rows.Count==0) {
                    this.__mensaje.Value = "No hay licencias con el criterio o criterios seleccionados.";
                    this.__pagina.Value = "";
                }
            }
            else{
                servidor.cerrarconexion();
                this.__mensaje.Value = servidor.getMensageError();
                this.__pagina.Value = "CerrarSession.aspx";
            }
        }
        catch (Exception){
            this.__mensaje.Value = "Error inesperado al intentar conectarnos con el servidor.";
            this.__pagina.Value = "CerrarSession.aspx";
        }
        return dt;
    }

    private DataTable getDetalleLicencias(int ID_LICENCIA_ELE_CONF)
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");
        DataTable dt = null;

        try
        {
            policia.clsaccesodatos servidor = new policia.clsaccesodatos();
            servidor.cadenaconexion = Ruta;
            if (servidor.abrirconexion() == true)
            {
                dt = servidor.consultar("[dbo].[pr_ListaRelacionLicenciaElementosConfiguracion]", ID_LICENCIA_ELE_CONF).Tables[0];
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
        return dt;
    }

    protected void btnNuevaLicencia_Click(object sender, EventArgs e)
    {
        Session["__CABECERA_LICENCIA__"] = null;
        Session["_DET_RELACION_LICENCIA_CI"] = null;
        Response.Clear();
        Response.Redirect("LicenciaElementoConfiguracion.aspx");
        Response.Flush();
    }



    protected void cbtl_CheckedChanged(object sender, EventArgs e)
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");
        ddltl.Enabled = cbtl.Checked;
        this.ddltl.SelectedIndex = -1;
        this.ddltl.Focus();
    }

    protected void cbs_CheckedChanged(object sender, EventArgs e)
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");
        ddls.Enabled = cbs.Checked;
        this.ddls.Items.Clear();
        this.ddls.Items.Insert(0, "_____SELECCIONE SUSCRIPCION LICENCIA_____");
        this.ddls.Items[0].Value = "-1";
        this.ddls.SelectedIndex = -1;
        this.ddls.Focus();
    }

    protected void cbp_CheckedChanged(object sender, EventArgs e)
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");
        ddlp.Enabled = cbp.Checked;
        this.ddlp.SelectedIndex = -1;
        this.ddlp.Focus();
    }



    protected void cbf_CheckedChanged(object sender, EventArgs e)
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");
        txtFechaInicioSuscripcion.Text = "";
        txtFechaInicioSuscripcion.Enabled = cbf.Checked;
        txtFechaFinSuscripcion.Text = "";
        txtFechaFinSuscripcion.Enabled = cbf.Checked;

       

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

    protected void ddltl_SelectedIndexChanged(object sender, EventArgs e)
    {
        this.__mensaje.Value = "";
        this.__pagina.Value = "";
        this.ddls.Items.Clear();
        this.ddls.Items.Insert(0, "_____SELECCIONE SUSCRIPCION LICENCIA_____");
        this.ddls.Items[0].Value = "-1";
        int Codigo_Tipo_Licencia = Convert.ToInt32(ddltl.SelectedValue);
        if (Codigo_Tipo_Licencia == -1)
        {
            this.__mensaje.Value = "Seleccione Tipo Licencia Elemento Configuracion";
            this.__pagina.Value = "";
            return;
        }
        Cargar_Datos(this.ddls, "[dbo].[pr_Obtener_Suscripcion_Licencia_Elemento_Configuracion]", "Error, al intentar recuperar LSuscripcion de Licencia Elemento Configuracion.", new Object[] { Codigo_Tipo_Licencia });
        if (this.__mensaje.Value.ToString().Trim() != "")
        {
            return;
        }
    }

    protected void lbtnBuscar_Click(object sender, EventArgs e)
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");

        Object[] ob;

        bool ok = (cbtl.Checked == true ||
        cbs.Checked == true ||
        cbp.Checked == true ||
        cbf.Checked == true); 
        if (ok == false)
        {
            _Lista.ShowMessage(__mensaje, __pagina, "Seleccione criterio(s) de busqueda.", "");
            return;
        } 
        
        if(cbtl.Checked==true) {
           if(Convert.ToInt32(ddltl.SelectedValue)==-1) {
                _Lista.ShowMessage(__mensaje, __pagina, "Seleccione tipo licencia.", "");
                return;
            }
        }

        if (cbs.Checked == true)
        {
            if (Convert.ToInt32(ddls.SelectedValue) == -1)
            {
                _Lista.ShowMessage(__mensaje, __pagina, "Seleccione tipo licencia y luego seleccione suscripcion.", "");
                return;
            }
        }

       
        if (cbp.Checked == true)
        {
            if (Convert.ToInt32(ddlp.SelectedValue) == -1)
            {
                _Lista.ShowMessage(__mensaje, __pagina, "Seleccione licencia perpetua.", "");
                return;
            }
        }

        if (cbf.Checked == true)
        {
            if (this.txtFechaInicioSuscripcion.Text.Trim() == "")
            {
                _Lista.ShowMessage(__mensaje, __pagina, "Ingrese fecha inicio suscripcion licencia.", "");
                return;
            }
            if (this.txtFechaFinSuscripcion.Text.Trim() == "")
            {
                _Lista.ShowMessage(__mensaje, __pagina, "Ingrese fecha fin suscripcion licencia.", "");
                return;
            }
        }

        if (cbf.Checked == true) {
           if(!(Convert.ToDateTime(this.txtFechaInicioSuscripcion.Text.Trim())<=Convert.ToDateTime(this.txtFechaFinSuscripcion.Text.Trim()))){
                _Lista.ShowMessage(__mensaje, __pagina, "Fecha inicio suscripcion debe ser menor o igual que la fecha fin suscripccion.", "");
                return;
            }
        }

            ob = new Object[] {
             Convert.ToInt32(ddltl.SelectedValue)==-1?"": ddltl.SelectedItem.Text, this.cbtl.Checked,
             Convert.ToInt32(ddls.SelectedValue)==-1?"": ddls.SelectedItem.Text, this.cbs.Checked,
             Convert.ToInt32(ddlp.SelectedValue)==-1?"": ddlp.SelectedItem.Text, this.cbp.Checked,
             this.txtFechaInicioSuscripcion.Text,this.txtFechaFinSuscripcion.Text, this.cbf.Checked
        };
        Session["OpcionBusqueda"] = ob;

        Response.Clear();
        Response.Redirect("LicenciasElementoConfiguracion.aspx");
        Response.Flush();

        _Lista.ShowMessage(__mensaje, __pagina, "", "");
    }

    protected void btnActualizarInformacion_Click(object sender, EventArgs e)
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");
        Session["OpcionBusqueda"] = null;
        Response.Clear();
        Response.Redirect("ReporteLicenciasElementoConfiguracion.aspx");
        Response.Flush();
        _Lista.ShowMessage(__mensaje, __pagina, "", "");
    }

    protected void IMPRIMIR_Click(object sender, EventArgs e)
    {
        DataTable dtLICENCIAS = new DataTable();
        dtLICENCIAS.Columns.Add(new DataColumn("ID LI", typeof(System.Int32)));
        dtLICENCIAS.Columns.Add(new DataColumn("LICENCIA", typeof(System.String)));
        dtLICENCIAS.Columns.Add(new DataColumn("NOMBRE", typeof(System.String)));
        dtLICENCIAS.Columns.Add(new DataColumn("VERSION", typeof(System.String)));
        dtLICENCIAS.Columns.Add(new DataColumn("SUSCRIPCION", typeof(System.String)));
        dtLICENCIAS.Columns.Add(new DataColumn("FEC. INI.", typeof(System.DateTime)));
        dtLICENCIAS.Columns.Add(new DataColumn("FEC. FIN", typeof(System.DateTime)));
        dtLICENCIAS.Columns.Add(new DataColumn("PERPETUA", typeof(System.String)));
        dtLICENCIAS.Columns.Add(new DataColumn("DESCRIPCION", typeof(System.String)));
        dtLICENCIAS.Columns.Add(new DataColumn("VENCE LICENCIA", typeof(System.String)));


        for (int Fila = 1; Fila < this.tblLicencias.Rows.Count; Fila++)
        {
            if (this.tblLicencias.Rows[Fila].Cells[0].Text.Trim() != "")
            {
                dtLICENCIAS.Rows.Add(Convert.ToInt32(this.tblLicencias.Rows[Fila].Cells[0].Text.Trim()),
                                    Convert.ToString(this.tblLicencias.Rows[Fila].Cells[1].Text.Trim()),
                                    Convert.ToString(this.tblLicencias.Rows[Fila].Cells[2].Text.Trim()),
                                    Convert.ToString(this.tblLicencias.Rows[Fila].Cells[3].Text.Trim()),
                                    Convert.ToString(this.tblLicencias.Rows[Fila].Cells[4].Text.Trim()),
                                    Convert.ToDateTime(this.tblLicencias.Rows[Fila].Cells[5].Text.Trim()),
                                    Convert.ToDateTime(this.tblLicencias.Rows[Fila].Cells[6].Text.Trim()),
                                    Convert.ToString(this.tblLicencias.Rows[Fila].Cells[7].Text.Trim()),
                                    Convert.ToString(this.tblLicencias.Rows[Fila].Cells[8].Text.Trim()),
                                    Convert.ToString(this.tblLicencias.Rows[Fila].Cells[9].Text.Trim())

               );
            }
        }

        DataTable dtDETALLE_LICENCIA = new DataTable();
        dtDETALLE_LICENCIA.Columns.Add(new DataColumn("ID RE", typeof(System.Int32)));
        dtDETALLE_LICENCIA.Columns.Add(new DataColumn("ID CI", typeof(System.Int32)));
        dtDETALLE_LICENCIA.Columns.Add(new DataColumn("TIPO CI", typeof(System.String)));
        dtDETALLE_LICENCIA.Columns.Add(new DataColumn("NOMBRE CI", typeof(System.String)));
        dtDETALLE_LICENCIA.Columns.Add(new DataColumn("NRO SERIE", typeof(System.String)));
        dtDETALLE_LICENCIA.Columns.Add(new DataColumn("PROPIETARIO", typeof(System.String)));
        dtDETALLE_LICENCIA.Columns.Add(new DataColumn("DESCRIPCION CI", typeof(System.String)));
        dtDETALLE_LICENCIA.Columns.Add(new DataColumn("ID_LICENCIA_ELE_CONF", typeof(System.Int32)));
        dtDETALLE_LICENCIA.Columns.Add(new DataColumn("SEDE", typeof(System.String)));
        dtDETALLE_LICENCIA.Columns.Add(new DataColumn("LOCAL", typeof(System.String)));
        dtDETALLE_LICENCIA.Columns.Add(new DataColumn("AREA", typeof(System.String)));
        dtDETALLE_LICENCIA.Columns.Add(new DataColumn("NRO PISO", typeof(System.String)));
        dtDETALLE_LICENCIA.Columns.Add(new DataColumn("NRO AMBIENTE", typeof(System.String)));

        for (int i = 1; i < this.tblLicencias.Rows.Count; i++)
        {
            if (this.tblLicencias.Rows[i].Cells[0].Text.Trim() != "")
            {
                DataTable dt = getDetalleLicencias(Convert.ToInt32(this.tblLicencias.Rows[i].Cells[0].Text.Trim()));
                for (int j = 0; j < dt.Rows.Count; j++)
                {
                    dtDETALLE_LICENCIA.Rows.Add(Convert.ToInt32(dt.Rows[j].ItemArray[0].ToString()),
                                                Convert.ToInt32(dt.Rows[j].ItemArray[1]),
                                                Convert.ToString(dt.Rows[j].ItemArray[2]),
                                                Convert.ToString(dt.Rows[j].ItemArray[3]),
                                                Convert.ToString(dt.Rows[j].ItemArray[4]),
                                                Convert.ToString(dt.Rows[j].ItemArray[5]),
                                                Convert.ToString(dt.Rows[j].ItemArray[6]),
                                                Convert.ToInt32(dt.Rows[j].ItemArray[7]),
                                                Convert.ToString(dt.Rows[j].ItemArray[8]),
                                                Convert.ToString(dt.Rows[j].ItemArray[9]),
                                                Convert.ToString(dt.Rows[j].ItemArray[10]),
                                                Convert.ToString(dt.Rows[j].ItemArray[11]),
                                                Convert.ToString(dt.Rows[j].ItemArray[12])
                     );
                }
            }
        }

        Session["Imprimir"] = new Object[] { "REPORTE_LICENCIAS_CI", dtLICENCIAS, "REPORTE DE LICENCIAS DE ELEMENTO CONFIGURACION SOFTWARE", dtDETALLE_LICENCIA };
        //ClientScript.RegisterClientScriptBlock(this.GetType(),"nn", "<script>abrir_ventana_imprimir_reporte(2);</script>");
    }



    
}
