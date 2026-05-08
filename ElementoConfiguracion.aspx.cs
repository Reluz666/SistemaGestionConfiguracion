using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ElementoConfiguracion : System.Web.UI.Page
{
    //private String Ruta = "SERVER=JOSE-PC;DATABASE=GCS;Encrypt=False;INTEGRATED SECURITY=True;packet size=4096;";
    private String Ruta = System.Configuration.ConfigurationManager.ConnectionStrings["CadenaConeccion"].ToString();
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
        "ElementoConfiguracion.aspx");
        if (rpta == false)
        {
            this.__mensaje.Value = "Ud. no tiene permiso para ACCEDER esta pagina web.";
            this.__pagina.Value = "CerrarSession.aspx";
            return;
        }

        Cargar_Datos(this.TIPOCI, "[dbo].[pr_Obtener_Tipos_Elemento_Configuracion_2]", "Error, al intentar recuperar Estado Elemento Configuracion.");
        if (this.__mensaje.Value.ToString().Trim() != "")
        {
            return;
        }
        Cargar_Datos(this.ESTADO_ELEMENTO_CONFIGURACION, "[dbo].[pr_Obtener_Estado_Elemento_Configuracion]", "Error, al intentar recuperar Estado Elemento Configuracion.");
        if (this.__mensaje.Value.ToString().Trim() != "")
        {
            return;
        }
        Cargar_Datos(this.MARCA, "[dbo].[pr_Obtener_Marcas]", "Error, al intentar recuperar Marcas Elemento Configuracion.");
        if (this.__mensaje.Value.ToString().Trim() != "")
        {
            return;
        }
        Cargar_Datos(this.MODELO, "pr_Obtener_Modelos", "Error, al intentar recuperar Modelos Elemento Configuracion.");
        if (this.__mensaje.Value.ToString().Trim() != "")
        {
            return;
        }
        //Cargar_Datos(this.DESCRIPCION_ELEMENTO_CONFIGURACION, "[dbo].[pr_Descripcion_Elemento_Configuracion]", "Error, al intentar recuperar Descripcion Elemento Configuracion.");
        //if (this.__mensaje.Value.ToString().Trim() != "")
        //{
        //    return;
        //}
        Cargar_Datos(this.IMPACTO_COMERCIAL_ELELEMTO_CONFIGURACION, "[dbo].[pr_Impacto_Comercial_Elemento_Configuracion_Hardware]", "Error, al intentar recuperar Impactos Comercial Elemento Configuracion.");
        if (this.__mensaje.Value.ToString().Trim() != "")
        {
            return;
        }
        Cargar_Datos(this.NIVEL_PRIORIDAD, "[dbo].[pr_Obtener_Niveles_Prioridad]", "Error, al intentar recuperar Niveles de Prioridad.");
        if (this.__mensaje.Value.ToString().Trim() != "")
        {
            return;
        }

        //validar operaciones
        String Operacion = Convert.ToString(Request.QueryString.Get("Operacion").Trim());
        if(!(Operacion== "N" || Operacion == "M" || Operacion == "E")) {
            ShowMessage("Operacion no permitida", "CerrarSession.aspx");
        }

        if(Operacion=="N") {
            this.FECHA_REGISTRO.Text = this.Obtener_Fecha_Sistema();
            this.ID_RESPONSABLE_REGISTRO.Value = Datos[0];
            this.RESPONSABLE_REGISTRO.Text = Datos[1] + " " + Datos[2] + " " + Datos[3];
        }else if(Operacion == "M" || Operacion == "E") {
            int Codigo_CI = Convert.ToInt32(Request.QueryString.Get("IDCI").Trim());
            DataTable dt = Consultar_Elementos_Configuracion(Codigo_CI);
            if(dt==null) {
                ShowMessage("Error al intentar consultar los datos del elemento de configuracion", "ElementosConfiguracion.aspx");
                return;
            }
            this.ID_ELEMENTO_CONFIGURACION.Value = dt.Rows[0].ItemArray[0].ToString();
            this.NOMBRE_ELEMENTO_CONFIGURACION.Text= dt.Rows[0].ItemArray[1].ToString();

            for (int i = 0; i < this.TIPOCI.Items.Count; i++)
            {
                if (this.TIPOCI.Items[i].Text.ToString().Trim() == dt.Rows[0].ItemArray[3].ToString())
                {
                    this.TIPOCI.SelectedIndex = i;
                }
            }

            this.NRO_SERIE.Text = dt.Rows[0].ItemArray[21].ToString();
            this.FABRICANTE_O_PROVEEDOR.Text = dt.Rows[0].ItemArray[22].ToString();
            for (int i = 0; i < this.MODELO.Items.Count; i++)
            {
                if (this.MODELO.Items[i].Text.ToString().Trim() == dt.Rows[0].ItemArray[24].ToString().Trim())
                {
                    this.MODELO.SelectedIndex = i;
                }
            }
            for (int i = 0; i < this.MARCA.Items.Count; i++)
            {
                if (this.MARCA.Items[i].Text.ToString().Trim() == dt.Rows[0].ItemArray[23].ToString())
                {
                    this.MARCA.SelectedIndex = i;
                }
            }
            this.IP.Text = dt.Rows[0].ItemArray[25].ToString();
            if(dt.Rows[0].ItemArray[25].ToString()=="NINGUNO") {
                this.IP.ReadOnly = true;
            }
            this.GATEWAY.Text = dt.Rows[0].ItemArray[26].ToString();
            if (dt.Rows[0].ItemArray[26].ToString() == "NINGUNO")
            {
                this.GATEWAY.ReadOnly = true;
            }
            this.GRUPO_TRABAJO.Text = dt.Rows[0].ItemArray[27].ToString();
            for (int i = 0; i < this.ESTADO_ELEMENTO_CONFIGURACION.Items.Count; i++)
            {
                if (this.ESTADO_ELEMENTO_CONFIGURACION.Items[i].Text.ToString().Trim() == dt.Rows[0].ItemArray[4].ToString())
                {
                    this.ESTADO_ELEMENTO_CONFIGURACION.SelectedIndex = i;
                }
            }
            this.ID_PROPIETARIO.Value = dt.Rows[0].ItemArray[5].ToString();
            this.PROPIETARIO.Text = dt.Rows[0].ItemArray[6].ToString();

            TIPOCI_SelectedIndexChanged(sender, e);

            for (int i = 0; i < this.DESCRIPCION_ELEMENTO_CONFIGURACION.Items.Count; i++)
            {
                if (this.DESCRIPCION_ELEMENTO_CONFIGURACION.Items[i].Text.ToString().Trim() == dt.Rows[0].ItemArray[7].ToString())
                {
                    this.DESCRIPCION_ELEMENTO_CONFIGURACION.SelectedIndex = i;
                }
            }
            for (int i = 0; i < this.IMPACTO_COMERCIAL_ELELEMTO_CONFIGURACION.Items.Count; i++)
            {
                if (this.IMPACTO_COMERCIAL_ELELEMTO_CONFIGURACION.Items[i].Text.ToString().Trim() == dt.Rows[0].ItemArray[8].ToString())
                {
                    this.IMPACTO_COMERCIAL_ELELEMTO_CONFIGURACION.SelectedIndex = i;
                }
            }
            this.ID_LOCALIZACION_FISICA.Value = dt.Rows[0].ItemArray[13].ToString();
            this.LOCALIZACION_FISICA.Text="Area: " + dt.Rows[0].ItemArray[14].ToString().Trim();
            this.LOCALIZACION_FISICA.Text+= "\nSede: " + dt.Rows[0].ItemArray[9].ToString().Trim();
            this.LOCALIZACION_FISICA.Text += "\nLocal: " + dt.Rows[0].ItemArray[10].ToString().Trim();
            this.LOCALIZACION_FISICA.Text += "\nUbicacion: " + dt.Rows[0].ItemArray[11].ToString().Trim();
            this.LOCALIZACION_FISICA.Text += "\nDireccion: " + dt.Rows[0].ItemArray[12].ToString().Trim();
            this.LOCALIZACION_FISICA.Text += "\nNro. Piso: " + dt.Rows[0].ItemArray[15].ToString().Trim();
            this.LOCALIZACION_FISICA.Text += "\nNro. Ambiente: " + dt.Rows[0].ItemArray[16].ToString().Trim();
            this.FECHA_REGISTRO.Text = dt.Rows[0].ItemArray[17].ToString().Trim();
            this.ID_RESPONSABLE_REGISTRO.Value = dt.Rows[0].ItemArray[18].ToString();
            this.RESPONSABLE_REGISTRO.Text = dt.Rows[0].ItemArray[19].ToString();
            for (int i = 0; i < this.NIVEL_PRIORIDAD.Items.Count; i++)
            {
                if (this.NIVEL_PRIORIDAD.Items[i].Text.ToString().Trim() == dt.Rows[0].ItemArray[20].ToString())
                {
                    this.NIVEL_PRIORIDAD.SelectedIndex = i;
                }
            }
        }

        this._operacion.Value = Operacion;

    }

    private void ShowMessage(string msg, string paginaweb)
    {
        this.__mensaje.Value = msg;
        this.__pagina.Value = paginaweb;
    }
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnRegistrar_Click(object sender, EventArgs e)
    {
        this.__mensaje.Value = "";
        this.__pagina.Value = "";


        //verificar permiso para enviar datos.
        string[] Datos = (string[])Session["__JSAR__"];
        bool rpta = this.VERIFICAR_PERMISOS_DERECHOS_ACCESO_PAGINA_WEB(Convert.ToInt32(Datos[0]),
        "ElementoConfiguracion.aspx", "ACEPTAR");
        if (rpta == false)
        {
            this.__mensaje.Value = "Ud. no esta autorizado para enviar datos en esta pagina web.";
            this.__pagina.Value = "CerrarSession.aspx";
            return;
        }



        Boolean ok;
        ok = rfvNOMBRE_ELEMENTO_CONFIGURACION.IsValid;

        ok = ok && rfvESTADO_ELEMENTO_CONFIGURACION.IsValid;
        ok = ok && rfvPROPIETARIO.IsValid;
        ok = ok && rfvDESCRIPCION_ELEMENTO_CONFIGURACION.IsValid;
        ok = ok && rfvIMPACTO_COMERCIAL_ELELEMTO_CONFIGURACION.IsValid;
        ok = ok && rfvLOCALIZACION_FISICA.IsValid;
        ok = ok && rfvFECHA_REGISTRO.IsValid;
        ok = ok && rfvRESPONSABLE_REGISTRO.IsValid;
        ok = ok && rfvNIVEL_PRIORIDAD.IsValid;
        ok = ok && rfvNRO_SERIE.IsValid;
        ok = ok && rfvFABRICANTE_O_PROVEEDOR.IsValid;
        ok = ok && rfvMARCA.IsValid;
        ok = ok && rfvMODELO.IsValid;
        ok = ok && rfvIP.IsValid;
        ok = ok && rfvGATEWAY.IsValid;
        ok = ok && rfvGRUPO_TRABAJO.IsValid;
        //Agregado el 12-12-2024.
        if(this.revIP.Enabled == true)
          ok = ok && revIP.IsValid;
        if (this.revGateway.Enabled == true)
            ok = ok && revGateway.IsValid;
        if (ok == false)
        {
            return;
        }
        Matenimiento_Elemento_Configuracion(Convert.ToInt32(this.ID_ELEMENTO_CONFIGURACION.Value.Trim()),
            this.NOMBRE_ELEMENTO_CONFIGURACION.Text.Trim(),
            Convert.ToInt32(this.TIPOCI.SelectedValue),
            Convert.ToInt32(this.ESTADO_ELEMENTO_CONFIGURACION.SelectedValue),
            Convert.ToInt32(this.ID_PROPIETARIO.Value.Trim()),
            Convert.ToInt32(this.DESCRIPCION_ELEMENTO_CONFIGURACION.SelectedValue),
            Convert.ToInt32(this.IMPACTO_COMERCIAL_ELELEMTO_CONFIGURACION.SelectedValue),
            Convert.ToInt32(this.ID_LOCALIZACION_FISICA.Value.Trim()),
            Convert.ToInt32(this.ID_RESPONSABLE_REGISTRO.Value.Trim()),
            Convert.ToInt32(this.NIVEL_PRIORIDAD.SelectedValue),
            this.NRO_SERIE.Text.Trim(),
            this.FABRICANTE_O_PROVEEDOR.Text.Trim(),
            Convert.ToInt32(this.MARCA.SelectedValue),
            Convert.ToInt32(this.MODELO.SelectedValue),
            this.IP.Text.Trim(),
            this.GATEWAY.Text.Trim(),
            this.GRUPO_TRABAJO.Text.Trim(),
            this._operacion.Value.Trim());
    }

    private void Matenimiento_Elemento_Configuracion(int _ID_ELEMENTO_CONFIGURACION,
       string _NOMBRE_ELEMENTO_CONFIGURACION,
       int _ID_TIPO,
       int _ID_ESTADO,
       int _PROPIETARIO,
       int _ID_DESCRIPCION,
       int _ID_IMP_ELE_CONF_HAR,
       int _LOCALIZACION_FISICA,
       int _RESPONSABLE_REGISTRO,
       int _ID_NIVEL,
       String _NRO_SERIE,
       String _FABRICANTE_O_PROVEEDOR,
       int _ID_MAR,
       int _ID_MOD,
       string _IP,
       string _GATEWAY,
       string _GRUPO_TRABAJO,
       string operacion)
    {
        String Operacion = Convert.ToString(Request.QueryString.Get("Operacion").Trim());
        int Codigo_CI=-1;
        if (Operacion.Equals("M"))
        {
            Codigo_CI = Convert.ToInt32(Request.QueryString.Get("IDCI").Trim());
        }

        policia.clsaccesodatos servidor = new policia.clsaccesodatos();
        servidor.cadenaconexion = Ruta;
        try
        {
            servidor.cadenaconexion = Ruta;
            if (servidor.abrirconexiontrans() == true)
            {
                servidor.ejecutar("[dbo].[pr_MatenimientoElementoConfiguracion]",
                                    false,
                                    _ID_ELEMENTO_CONFIGURACION,
                                    _NOMBRE_ELEMENTO_CONFIGURACION.Trim(),
                                    _ID_TIPO,
                                    _ID_ESTADO,
                                    _PROPIETARIO,
                                    _ID_DESCRIPCION,
                                    _ID_IMP_ELE_CONF_HAR,
                                    _LOCALIZACION_FISICA,
                                    _RESPONSABLE_REGISTRO,
                                    _ID_NIVEL,
                                    _NRO_SERIE,
                                    _FABRICANTE_O_PROVEEDOR,
                                    _ID_MAR,
                                    _ID_MOD,
                                    _IP,
                                    _GATEWAY,
                                    _GRUPO_TRABAJO,
                                    operacion,
                                    0, "");
                if (servidor.getRespuesta() == 1)
                {
                    servidor.cerrarconexiontrans();
                    ShowMessage(servidor.getMensaje(), "ElementosConfiguracion.aspx");
                }
                else
                {
                    servidor.cancelarconexiontrans();
                    if (Operacion.Equals("M"))
                    {
                        ShowMessage(servidor.getMensaje(), "ElementoConfiguracion.aspx?Operacion=" + Operacion + "&IDCI=" + Codigo_CI.ToString());
                    }else {
                        ShowMessage(servidor.getMensaje(), "ElementoConfiguracion.aspx?Operacion=" + Operacion );
                    }
                    //ShowMessage(servidor.getMensaje(), "");
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
                dt = servidor.consultar("[dbo].[obtenerfechasistema]").Tables[0];
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


    private System.Data.DataTable Consultar_Elementos_Configuracion(int ID_CI)
    {
        System.Data.DataTable dt = null;

        try
        {
            policia.clsaccesodatos servidor = new policia.clsaccesodatos();
            servidor.cadenaconexion = Ruta;
            if (servidor.abrirconexion() == true)
            {
                dt = servidor.consultar("[dbo].[pr_ConsultarElementosConfiguracion]", ID_CI).Tables[0];
                if (dt.Rows.Count == 0)
                {
                    dt = null;
                    servidor.cerrarconexion();
                    
                }
                               
                servidor.cerrarconexion();
                
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
        return dt;
    }















    protected void TIPOCI_SelectedIndexChanged(object sender, EventArgs e)
    {
        this.__mensaje.Value = "";
        this.__pagina.Value = "";



        //Capturamos el tipo servcio.
        //string TipoServicio = TIPOCI.SelectedItem.Text.Trim();

        //if (TipoServicio != "SERVIDORES"
        //    && TipoServicio != "DISPOSITIVOS DE RED"
        //    && TipoServicio != "EDUIPOS DE ESCRITORIO"
        //     && TipoServicio != "APLICACIONES")
        //{
        //    this.NRO_SERIE.Text = "";
        //    this.NRO_SERIE.ReadOnly = false;
        //    this.MODELO.SelectedIndex = -1;
        //    this.MODELO.Enabled = true;
        //    this.MARCA.SelectedIndex = -1;
        //    this.MARCA.Enabled = true;
        //    this.IP.Text = "";
        //    this.IP.ReadOnly = false;
        //   // agregado el 12 - 12 - 2024
        //    this.revIP.Enabled = true;
        //    this.GATEWAY.Text = "";
        //  //  agregado el 17 - 12 - 2024
        //    this.revGateway.Enabled = true;
        //    this.GATEWAY.ReadOnly = false;
        //    this.GRUPO_TRABAJO.Text = "";
        //    this.GRUPO_TRABAJO.ReadOnly = false;
        //}

        //switch (TipoServicio)
        //{
        //    case "ADMINISTRADORES DE BASE DE DATOS":
        //        for (int i = 0; i < this.MODELO.Items.Count; i++)
        //        {
        //            if (MODELO.Items[i].Text.Equals("NINGUNO"))
        //            {
        //                this.MODELO.SelectedIndex = i;
        //                this.MODELO.Enabled = false;
        //            }
        //        }
        //        for (int i = 0; i < this.MARCA.Items.Count; i++)
        //        {
        //            if (MARCA.Items[i].Text.Equals("NINGUNO"))
        //            {
        //                this.MARCA.SelectedIndex = i;
        //                this.MARCA.Enabled = false;
        //            }
        //        }
        //        this.GATEWAY.Text = "NINGUNO";
        //        this.GATEWAY.ReadOnly = true;
        //        break;
        //    case "APLICACIONES":
        //        for (int i = 0; i < this.MODELO.Items.Count; i++)
        //        {
        //            if (MODELO.Items[i].Text.Equals("NINGUNO"))
        //            {
        //                this.MODELO.SelectedIndex = i;
        //                this.MODELO.Enabled = false;
        //            }
        //        }
        //        for (int i = 0; i < this.MARCA.Items.Count; i++)
        //        {
        //            if (MARCA.Items[i].Text.Equals("NINGUNO"))
        //            {
        //                this.MARCA.SelectedIndex = i;
        //                this.MARCA.Enabled = false;
        //            }
        //        }
        //        this.IP.Text = "NINGUNO";
        //        this.IP.ReadOnly = true;
        //      //  Agregado el 12 - 12 - 2024
        //        this.revIP.Enabled = false;
        //        this.GATEWAY.Text = "NINGUNO";
        //        this.GATEWAY.ReadOnly = true;
        //       // agregado el 8 - 08 - 2025
        //        this.NRO_SERIE.Text = "NINGUNO";
        //        this.NRO_SERIE.Enabled = false;
        //     //   Agregado el 17 - 12 - 2024
        //        this.revGateway.Enabled = false;
        //        break;
        //    case "DIGITALIZADORES":
        //        this.GATEWAY.Text = "NINGUNO";
        //        this.GATEWAY.ReadOnly = true;
        //        break;
        //    case "IMPRESORA":
        //        this.GATEWAY.Text = "0.0.0.0";
        //        this.GATEWAY.ReadOnly = true;
        //        this.NRO_SERIE.Enabled = true;
        //        for (int i = 0; i < this.MODELO.Items.Count; i++)
        //        {
        //            if (MODELO.Items[i].Text.Equals("NINGUNO"))
        //            {
        //                this.MODELO.SelectedIndex = i;
        //                this.MODELO.Enabled = false;
        //            }
        //        }
        //        for (int i = 0; i < this.MARCA.Items.Count; i++)
        //        {
        //            if (MARCA.Items[i].Text.Equals("NINGUNO"))
        //            {
        //                this.MARCA.SelectedIndex = i;
        //                this.MARCA.Enabled = false;
        //            }
        //        }
        //        break;
        //    case "SERVICIOS AL CIUDADANO":
        //        this.NRO_SERIE.Text = "NINGUNO";
        //        this.NRO_SERIE.ReadOnly = true;
        //        for (int i = 0; i < this.MODELO.Items.Count; i++)
        //        {
        //            if (MODELO.Items[i].Text.Equals("NINGUNO"))
        //            {
        //                this.MODELO.SelectedIndex = i;
        //                this.MODELO.Enabled = false;
        //            }
        //        }
        //        for (int i = 0; i < this.MARCA.Items.Count; i++)
        //        {
        //            if (MARCA.Items[i].Text.Equals("NINGUNO"))
        //            {
        //                this.MARCA.SelectedIndex = i;
        //                this.MARCA.Enabled = false;
        //            }
        //        }
        //        this.IP.Text = "NINGUNO";
        //        this.IP.ReadOnly = true;
        //       // Agregado el 12 - 12 - 2024
        //        this.revIP.Enabled = false;
        //        this.GATEWAY.Text = "NINGUNO";
        //        this.GATEWAY.ReadOnly = true;
        //      //  Agregado el 17 - 12 - 2024
        //        this.revGateway.Enabled = false;
        //        this.GRUPO_TRABAJO.Text = "NINGUNO";
        //        this.GRUPO_TRABAJO.ReadOnly = true;
        //        break;
        //    case "SERVICIOS AL PROFESIONAL":
        //        this.NRO_SERIE.Text = "NINGUNO";
        //        this.NRO_SERIE.ReadOnly = true;
        //        for (int i = 0; i < this.MODELO.Items.Count; i++)
        //        {
        //            if (MODELO.Items[i].Text.Equals("NINGUNO"))
        //            {
        //                this.MODELO.SelectedIndex = i;
        //                this.MODELO.Enabled = false;
        //            }
        //        }
        //        for (int i = 0; i < this.MARCA.Items.Count; i++)
        //        {
        //            if (MARCA.Items[i].Text.Equals("NINGUNO"))
        //            {
        //                this.MARCA.SelectedIndex = i;
        //                this.MARCA.Enabled = false;
        //            }
        //        }
        //        this.IP.Text = "NINGUNO";
        //        this.IP.ReadOnly = true;
        //       // Agregado el 12 - 12 - 2024
        //        this.revIP.Enabled = false;
        //        this.GATEWAY.Text = "NINGUNO";
        //        this.GATEWAY.ReadOnly = true;
        //       // Agregado el 17 - 12 - 2024
        //        this.revGateway.Enabled = false;
        //        this.GRUPO_TRABAJO.Text = "NINGUNO";
        //        this.GRUPO_TRABAJO.ReadOnly = true;
        //        break;
        //    case "SISTEMAS OPERATIVOS":
        //        this.NRO_SERIE.Text = "";
        //        this.NRO_SERIE.ReadOnly = false;
        //        for (int i = 0; i < this.MODELO.Items.Count; i++)
        //        {
        //            if (MODELO.Items[i].Text.Equals("NINGUNO"))
        //            {
        //                this.MODELO.SelectedIndex = i;
        //                this.MODELO.Enabled = false;
        //            }
        //        }
        //        for (int i = 0; i < this.MARCA.Items.Count; i++)
        //        {
        //            if (MARCA.Items[i].Text.Equals("NINGUNO"))
        //            {
        //                this.MARCA.SelectedIndex = i;
        //                this.MARCA.Enabled = false;
        //            }
        //        }
        //        this.IP.Text = "NINGUNO";
        //        this.IP.ReadOnly = true;
        //        //Agregado el 12 - 12 - 2024
        //        this.revIP.Enabled = false;
        //        this.GATEWAY.Text = "NINGUNO";
        //        this.GATEWAY.ReadOnly = true;
        //        //Agregado el 17 - 12 - 2024
        //        this.revGateway.Enabled = false;
        //        break;

        //}





        this.DESCRIPCION_ELEMENTO_CONFIGURACION.Items.Clear();
        this.DESCRIPCION_ELEMENTO_CONFIGURACION.Items.Insert(0, "Seleccione una opción");
        this.DESCRIPCION_ELEMENTO_CONFIGURACION.Items[0].Value = "-1";
        int Codigo_TipoCI = Convert.ToInt32(TIPOCI.SelectedValue);
        if (Codigo_TipoCI == -1)
        {
            this.__mensaje.Value = "Seleccione Tipo Elemento Configuracion";
            this.__pagina.Value = "";
            return;
        }
        Cargar_Datos(this.DESCRIPCION_ELEMENTO_CONFIGURACION, "[dbo].[pr_Descripcion_Elemento_Configuracion_2]", "Error, al intentar recuperar Descripcion Elemento Configuracion.", new Object[] { Codigo_TipoCI });
        if (this.__mensaje.Value.ToString().Trim() != "")
        {
            return;
        }
    }

    public bool VERIFICAR_PERMISOS_DERECHOS_ACCESO_PAGINA_WEB(int _ID_USUARIO, string _PAGINA_WEB, string _DERECHO) {
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

    protected void btnCancelar_Click(object sender, EventArgs e)
    {

    }
}