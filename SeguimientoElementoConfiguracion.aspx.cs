using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Threading;
using System.Data;

public partial class TiposElementoConfiguracion : System.Web.UI.Page
{
    //private String Ruta = "SERVER=JOSE-PC;DATABASE=GCS;Encrypt=False;INTEGRATED SECURITY=True;packet size=4096;";
    private String Ruta = System.Configuration.ConfigurationManager.ConnectionStrings["CadenaConeccion"].ToString();
    Lista _Lista = new Lista();

   

    protected void Page_Load(object sender, EventArgs e)
    {
        
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
        "SeguimientoElementoConfiguracion.aspx");
        if (rpta == false)
        {
            this.__mensaje.Value = "Ud. no tiene permiso para ACCEDER esta pagina web.";
            this.__pagina.Value = "CerrarSession.aspx";
            return;
        }

        Cargar_Datos(this.CLASIFICACION_DATOS_CIS, "[dbo].[pr_Obtener_Clasificacion_Datos_Elemento_Configuracion]", "Error, al intentar recuperar Clasificacion Datos Elemento Configuracion.");
        if (this.__mensaje.Value.ToString().Trim() != "")
        {
            return;
        }
        Cargar_Datos_2(this.cblEstado_Actual_CIs, "[dbo].[pr_Obtener_Estado_Actual_Elementos_Configuracion]", "Error, al intentar recuperar Estado Actual Elemento Configuracion.");
        if (this.__mensaje.Value.ToString().Trim() != "")
        {
            return;
        }
        this.hfID_RESPONSABLE_SEGUIMIENTO.Value = Datos[0];
        this.RESPONSABLE_SEGUIMIENTO.Text = Datos[1] + " " + Datos[2] + " " + Datos[3];
        this.FECHA_SEGUIMIENTO.Text = this.Obtener_Fecha_Sistema();
        if (Session["__SEGUIMIENTO_ELEMENTO_CONFIGURACION__"] != null) {
            object[] SEC = (object[])Session["__SEGUIMIENTO_ELEMENTO_CONFIGURACION__"];
            this.hfID_ELEMENTO_CONFIGURACION.Value = SEC[0].ToString().Trim();
            this.tbNombre_Tipo_NroSerie.Text = SEC[1].ToString().Trim();
            this.tbFabricante_Marca_Modelo.Text = SEC[2].ToString().Trim();
            this.tbEstado_Descripcion_Sede.Text = SEC[3].ToString().Trim();
            this.tbLocal_Ubicacion_Direccion.Text = SEC[4].ToString().Trim();
            this.tbArea_NroPiso_NroAmbiente.Text = SEC[5].ToString().Trim();
            this.ID_SEGUIMIENTO.Value = SEC[6].ToString().Trim();
            for (int i = 0; i < this.CLASIFICACION_DATOS_CIS.Items.Count; i++)
            {
                if (this.CLASIFICACION_DATOS_CIS.Items[i].Text.ToString().Trim() == SEC[10].ToString().Trim())
                {
                    this.CLASIFICACION_DATOS_CIS.SelectedIndex = i;

                }
            }
            String[] _EA_ = SEC[11].ToString().Trim().Split('-');
            for (int i = 0; i < _EA_.Length; i++)
            {
                String Estado = _EA_[i].Trim();
                for (int j = 0; j < cblEstado_Actual_CIs.Items.Count; j++)
                {
                    String Estado2 = cblEstado_Actual_CIs.Items[j].Text.Trim();
                    if(Estado== Estado2) {
                        cblEstado_Actual_CIs.Items[j].Selected = true;
                    }
                }
            }
           
            this.RELACION_OTROS_CIS.Checked = SEC[12].ToString().Trim()=="SI"?true:false;
            this.CUMPLE_POLITICAS_GESTION_CONFIGURACION_ORGANIZACION.Checked = SEC[13].ToString().Trim() == "SI" ? true : false;
            this.OBSERVACION_SEGUIMIENTO.Text = SEC[14].ToString().Trim();

        }
    }

    private void ShowMessage(string msg, string paginaweb)
    {
        this.__mensaje.Value = msg;
        this.__pagina.Value = paginaweb;
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

    private void Cargar_Datos_2(System.Web.UI.WebControls.CheckBoxList cbl, String Procedimeinto_Almacenado, String Mensaje, params Object[] p)
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
                    cbl.DataSource = dt;
                    cbl.DataTextField = "NOMBRE";
                    cbl.DataValueField = "CODIGO";
                    cbl.DataBind();
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






    protected void ibtnBUSCAR_ELEMENTOL_JCONFIGURACION_Click(object sender, EventArgs e)
    {
        
    }

    protected void btnRegistrar_Click(object sender, EventArgs e)
    {
        this.__mensaje.Value = "";
        this.__pagina.Value = "";

        //verificar permiso para REGISTRAR datos.
        string[] Datos = (string[])Session["__JSAR__"];
        bool rpta = this.VERIFICAR_PERMISOS_DERECHOS_ACCESO_PAGINA_WEB(Convert.ToInt32(Datos[0]),
        "SeguimientoElementoConfiguracion.aspx", "NUEVO");
        if (rpta == false)
        {
            this.__mensaje.Value = "Ud. no esta autorizado para registrar datos en esta pagina web.";
            this.__pagina.Value = "CerrarSession.aspx";
            return;
        }

        Boolean ok;
        ok = tbNombre_Tipo_NroSerie.Text.Trim()!="";
        ok = ok && tbFabricante_Marca_Modelo.Text.Trim() != "";
        ok = ok && tbEstado_Descripcion_Sede.Text.Trim() != "";
        ok = ok && tbLocal_Ubicacion_Direccion.Text.Trim() != "";
        ok = ok && tbArea_NroPiso_NroAmbiente.Text.Trim() != "";
        ok = ok && rfvRESPONSABLE_SEGUIMIENTO.IsValid;
        ok = ok && rfvRESPONSABLE_SEGUIMIENTO0.IsValid;
        ok = ok && rfvCLASIFICACION_DATOS_CIS.IsValid;
        ok = ok && revCLASIFICACION_DATOS_CIS.IsValid;
        ok = ok && rfvOBSERVACION_SEGUIMIENTO.IsValid;
        if (ok == false)
        {
            return;
        }
        
        try
        {
            if (Convert.ToInt32(this.ID_SEGUIMIENTO.Value) == -1)
            {
                _operacion.Value = "N";
            }
            else
            {
                _operacion.Value = "M";
                
            }
            
            int _CODIGO_SEGUIMIENTO = -1;
            policia.clsaccesodatos servidor = new policia.clsaccesodatos();
            servidor.cadenaconexion = Ruta;
            if (servidor.abrirconexiontrans() == true)
            {
                servidor.ejecutar("[dbo].[pr_MatenimientoSeguimientoElementoConfiguracion]",
                false,
                Convert.ToInt32(this.ID_SEGUIMIENTO.Value),
                Convert.ToInt32(this.hfID_ELEMENTO_CONFIGURACION.Value),
                Convert.ToInt32(this.hfID_RESPONSABLE_SEGUIMIENTO.Value),
                Convert.ToInt32(this.CLASIFICACION_DATOS_CIS.SelectedValue),
                this.RELACION_OTROS_CIS.Checked,                
                this.CUMPLE_POLITICAS_GESTION_CONFIGURACION_ORGANIZACION.Checked,
                this.OBSERVACION_SEGUIMIENTO.Text.Trim(),
                this._operacion.Value.Trim(),
                0, "");
                if (_operacion.Value.Equals("N"))
                {
                    _CODIGO_SEGUIMIENTO = servidor.getRespuesta();
                }
                else if (_operacion.Value.Equals("M"))
                {
                    _CODIGO_SEGUIMIENTO = Convert.ToInt32(this.ID_SEGUIMIENTO.Value);
                    this.Title = _CODIGO_SEGUIMIENTO.ToString();


                }
                if (_CODIGO_SEGUIMIENTO > 0)
                {
                   
                    for (int i = 0; i < this.cblEstado_Actual_CIs.Items.Count; i++)
                    {
                        if (cblEstado_Actual_CIs.Items[i].Selected == true)
                        {
                            servidor.ejecutar("[dbo].[pr_MatenimientoDetalleEstadoActualElementoConfiguracion]",
                                                             false,
                                                             null,
                                                             _CODIGO_SEGUIMIENTO,
                                                             Convert.ToInt32(cblEstado_Actual_CIs.Items[i].Value),
                                                             1,
                                                             this._operacion.Value.Trim(),
                                                             0, "");

                        }else {
                            if (_operacion.Value.Equals("M")){
                                servidor.ejecutar("[dbo].[pr_MatenimientoDetalleEstadoActualElementoConfiguracion]",
                                                                     false,
                                                                     null,
                                                                     _CODIGO_SEGUIMIENTO,
                                                                     Convert.ToInt32(cblEstado_Actual_CIs.Items[i].Value),
                                                                     0,
                                                                     this._operacion.Value.Trim(),
                                                                     0, "");
                            }
                        }
                    }                   
                    if (servidor.getRespuesta() == 1)
                    {
                        Session["OpcionBusqueda"] = null;
                        servidor.cerrarconexiontrans();
                        _Lista.ShowMessage(__mensaje, __pagina, servidor.getMensaje(), "SeguimientosElementoConfiguracion.aspx");
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

    protected void btnCancelar_Click(object sender, EventArgs e)
    {
        //verificar permiso para eliminar datos.
        string[] Datos = (string[])Session["__JSAR__"];
        bool rpta = this.VERIFICAR_PERMISOS_DERECHOS_ACCESO_PAGINA_WEB(Convert.ToInt32(Datos[0]),
        "SeguimientoElementoConfiguracion.aspx", "CANCELAR");
        if (rpta == false)
        {
            this.__mensaje.Value = "Ud. no esta autorizado para CANCELAR datos en esta pagina web.";
            this.__pagina.Value = "CerrarSession.aspx";
            return;
        }

        this.Response.Redirect("SeguimientosElementoConfiguracion.aspx");
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