using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class RelacionElementosConfiguracion : System.Web.UI.Page
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
        "RelacionElementosConfiguracion.aspx");
        if (rpta == false)
        {
            this.__mensaje.Value = "Ud. no tiene permiso para ACCEDER esta pagina web.";
            this.__pagina.Value = "CerrarSession.aspx";
            return;
        }

        Cargar_Datos(this.ddlTipoRelecion_CI_P_H, "[dbo].[pr_Obtener_Tipos_Relacion_Elementos_Configuracion]", "Error, al intentar recuperar Estado Elemento Configuracion.");
        if (this.__mensaje.Value.ToString().Trim() != "")
        {
            return;
        }

        //validar operaciones
        String Operacion = Convert.ToString(Request.QueryString.Get("Operacion").Trim());
        if (!(Operacion == "N" || Operacion == "M"))
        {
            ShowMessage("Operacion no permitida", "CerrarSession.aspx");
        }

        if (Operacion == "N")
        {
            ;
        }
        else if (Operacion == "M")
        {
            int Codigo_RCI = Convert.ToInt32(Request.QueryString.Get("IDR").Trim());
            DataTable dt = Consultar_Relacion_Elementos_Configuracion(Codigo_RCI);
            this.ID_RELACION.Value = dt.Rows[0]["ID_RELACION"].ToString();

            this.ID_CI_P.Value = dt.Rows[0]["PADRE ID"].ToString();
            this.Nombre_CI_P.Text= dt.Rows[0]["PADRE CI"].ToString();
            this.Tipo_CI_P.Text= dt.Rows[0]["PADRE TIPO CI"].ToString();
            this.Estado_CI_P.Text = dt.Rows[0]["PADRE ESTADO CI"].ToString();
            this.Propietario_CI_P.Text = dt.Rows[0]["PADRE PROPIETARIO CI"].ToString();
            this.Descripcion_CI_P.Text = dt.Rows[0]["PADRE DESCRIPCION CI"].ToString();
            this.NivelPrioridad_CI_P.Text = dt.Rows[0]["PADRE NIVEL PRIORIDAD"].ToString();
            this.Sede_P.Text = dt.Rows[0]["PADRE SEDE"].ToString();
            this.Local_P.Text = dt.Rows[0]["PADRE LOCAL"].ToString();
            this.Area_P.Text = dt.Rows[0]["PADRE AREA"].ToString();
            this.NroPiso_P.Text = dt.Rows[0]["PADRE NRO PISO"].ToString();
            this.NroAmbiente_P.Text = dt.Rows[0]["PADRE NRO AMBIENTE"].ToString();
            this.Ubicacion_P.Text = dt.Rows[0]["PADRE UBICACION"].ToString();
            this.Direccion_P.Text = dt.Rows[0]["PADRE DIRECCION LOCAL"].ToString();

            this.ID_CI_H.Value = dt.Rows[0]["HIJO ID"].ToString();
            this.Nombre_CI_H.Text = dt.Rows[0]["HIJO CI"].ToString();
            this.Tipo_CI_H.Text = dt.Rows[0]["HIJO TIPO CI"].ToString();
            this.Estado_CI_H.Text = dt.Rows[0]["HIJO ESTADO CI"].ToString();
            this.Propietario_CI_H.Text = dt.Rows[0]["HIJO PROPIETARIO CI"].ToString();
            this.Descripcion_CI_H.Text = dt.Rows[0]["HIJO DESCRIPCION CI"].ToString();
            this.NivelPrioridad_CI_H.Text = dt.Rows[0]["HIJO NIVEL PRIORIDAD"].ToString();
            this.Sede_H.Text = dt.Rows[0]["HIJO SEDE"].ToString();
            this.Local_H.Text = dt.Rows[0]["HIJO LOCAL"].ToString();
            this.Area_H.Text = dt.Rows[0]["HIJO AREA"].ToString();
            this.NroPiso_H.Text = dt.Rows[0]["HIJO NRO PISO"].ToString();
            this.NroAmbiente_H.Text = dt.Rows[0]["HIJO NRO AMBIENTE"].ToString();
            this.Ubicacion_H.Text = dt.Rows[0]["HIJO UBICACION"].ToString();
            this.Direccion_H.Text = dt.Rows[0]["HIJO DIRECCION LOCAL"].ToString();

            for (int i = 0; i < this.ddlTipoRelecion_CI_P_H.Items.Count; i++)
            {
                if (this.ddlTipoRelecion_CI_P_H.Items[i].Text.ToString().Trim() == dt.Rows[0]["TIPO RELACION"].ToString())
                {
                    this.ddlTipoRelecion_CI_P_H.SelectedIndex = i;
                }
            }
        }

        this._operacion.Value = Operacion;       

    }
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnRegistrar_Click(object sender, EventArgs e)
    {
        this.__mensaje.Value = "";
        this.__pagina.Value = "";

        //verificar permiso para REGISTRAR datos.
        string[] Datos = (string[])Session["__JSAR__"];
        bool rpta = this.VERIFICAR_PERMISOS_DERECHOS_ACCESO_PAGINA_WEB(Convert.ToInt32(Datos[0]),
        "RelacionElementosConfiguracion.aspx", "NUEVO");
        if (rpta == false)
        {
            this.__mensaje.Value = "Ud. no esta autorizado para registrar datos en esta pagina web.";
            this.__pagina.Value = "CerrarSession.aspx";
            return;
        }

        Boolean ok;
        ok = rfvNombre_CI_P.IsValid;
        ok = ok && rfvTipo_CI_P.IsValid;
        ok = ok && rfvEstado_CI_P.IsValid;
        ok = ok && rfvPropietario_CI_P.IsValid;
        ok = ok && rfvDescripcion_CI_P.IsValid;
        ok = ok && rfvNivelPrioridad_CI_P.IsValid;
        ok = ok && rfvSede_P.IsValid;
        ok = ok && rfvLocal_P.IsValid;
        ok = ok && rfvArea_P.IsValid;
        ok = ok && rfvNroPiso_P.IsValid;
        ok = ok && rfvNroAmbiente_P.IsValid;
        ok = ok && rfvUbicacion_P.IsValid;
        ok = ok && rfvDireccion_P.IsValid;

        ok = ok && rfvNombre_CI_H.IsValid;
        ok = ok && rfvTipo_CI_H.IsValid;
        ok = ok && rfvEstado_CI_H.IsValid;
        ok = ok && rfvPropietario_CI_H.IsValid;
        ok = ok && rfvDescripcion_CI_H.IsValid;
        ok = ok && rfvNivelPrioridad_CI_H.IsValid;
        ok = ok && rfvSede_H.IsValid;
        ok = ok && rfvLocal_H.IsValid;
        ok = ok && rfvArea_H.IsValid;
        ok = ok && rfvNroPiso_H.IsValid;
        ok = ok && rfvNroAmbiente_H.IsValid;
        ok = ok && rfvUbicacion_H.IsValid;
        ok = ok && rfvDireccion_H.IsValid;

        ok = ok && rfvddlTipoRelecion_CI_P_H.IsValid;
        ok = ok && revddlTipoRelecion_CI_P_H.IsValid;
        if (ok == false)
        {
            return;
        }
        Matenimiento_Relacion_Elemento_Configuracion(Convert.ToInt32(this.ID_RELACION.Value.Trim()),
            Convert.ToInt32(this.ID_CI_P.Value.Trim()),
            Convert.ToInt32(this.ID_CI_H.Value.Trim()),
            Convert.ToInt32(this.ddlTipoRelecion_CI_P_H.SelectedValue),
            this._operacion.Value);
    }

    private void Matenimiento_Relacion_Elemento_Configuracion(int _ID_RELACION,
       int _ELEMENTO_CONFIGURACION_PADRE,
       int _ELEMENTO_CONFIGURACION_HIJO,
       int _COD_TIPO_RELA,
       string operacion)
    {
        policia.clsaccesodatos servidor = new policia.clsaccesodatos();
        servidor.cadenaconexion = Ruta;
        try
        {
            servidor.cadenaconexion = Ruta;
            if (servidor.abrirconexiontrans() == true)
            {
                servidor.ejecutar("[dbo].[pr_MatenimientoRelacionElementoConfiguracion]",
                                    false,
                                    _ID_RELACION,
                                    _ELEMENTO_CONFIGURACION_PADRE,
                                    _ELEMENTO_CONFIGURACION_HIJO,
                                    _COD_TIPO_RELA,
                                    operacion,
                                    0, "");
                if (servidor.getRespuesta() == 1)
                {
                    servidor.cerrarconexiontrans();
                    ShowMessage(servidor.getMensaje(), "RelacionesElementosConfiguracion.aspx");
                }
                else
                {
                    servidor.cancelarconexiontrans();
                    ShowMessage(servidor.getMensaje(), "");
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

    private void ShowMessage(string msg, string paginaweb)
    {
        this.__mensaje.Value = msg;
        this.__pagina.Value = paginaweb;
    }

    private System.Data.DataTable Consultar_Relacion_Elementos_Configuracion(int Id_R)
    {
        System.Data.DataTable dt = null;

        try
        {
            policia.clsaccesodatos servidor = new policia.clsaccesodatos();
            servidor.cadenaconexion = Ruta;
            if (servidor.abrirconexion() == true)
            {
                dt = servidor.consultar("[dbo].[pr_ConsultarRelacionElementosConfiguracion]", Id_R).Tables[0];
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