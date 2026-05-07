using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Local : System.Web.UI.Page
{
    private String Ruta = System.Configuration.ConfigurationManager.ConnectionStrings["CadenaConeccion"].ToString();
    Lista _Lista = new Lista();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Convert.ToInt32(this.Id_Local.Value.Trim()) == 0)
        {
            this.btnRegistrar.Visible = true;
            this.btnCancelar.Visible = true;
            oculta(false);
        }
        CargarDatosJson();
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

        bool rpta = this.VERIFICAR_PERMISO_ACCESO_PAGINA_WEB(Convert.ToInt32(Datos[0]),
        "Local.aspx");
        if (rpta == false)
        {
            this.__mensaje.Value = "Ud. no tiene permiso para ACCEDER esta pagina web.";
            this.__pagina.Value = "CerrarSession.aspx";
            return;
        }

        Cargar_Datos(this.Sede, "[dbo].[pr_Obtener_Sedes]", "Error, al intentar recuperar Sedes Judiciales.");
    }

    private void ShowMessage(string msg, string paginaweb)
    {
        this.__mensaje.Value = msg;
        this.__pagina.Value = paginaweb;
    }

    private void CargarDatosJson()
    {
        try
        {
            policia.clsaccesodatos servidor = new policia.clsaccesodatos();
            servidor.cadenaconexion = Ruta;
            if (servidor.abrirconexion() == true)
            {
                DataTable dt = servidor.consultar("[dbo].[pr_Lista_Locales]", "", "").Tables[0];
                if (dt.Rows.Count > 0)
                {
                    System.Text.StringBuilder json = new System.Text.StringBuilder();
                    json.Append("[");
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        if (i > 0) json.Append(",");
                        json.Append("{");
                        json.Append("\"id\":\"" + dt.Rows[i]["ID LOCAL"].ToString().Trim() + "\",");
                        json.Append("\"codigo\":\"" + System.Web.HttpUtility.JavaScriptStringEncode(dt.Rows[i]["LOCAL CODIGO"].ToString().Trim()) + "\",");
                        json.Append("\"nombre\":\"" + System.Web.HttpUtility.JavaScriptStringEncode(dt.Rows[i]["LOCAL NOMBRE"].ToString().Trim()) + "\",");
                        json.Append("\"direccion\":\"" + System.Web.HttpUtility.JavaScriptStringEncode(dt.Rows[i]["LOCAL DIRECCION"].ToString().Trim()) + "\",");
                        json.Append("\"sede\":\"" + System.Web.HttpUtility.JavaScriptStringEncode(dt.Rows[i]["SEDE"].ToString().Trim()) + "\",");
                        json.Append("\"idUbi\":\"" + dt.Rows[i]["ID UBI"].ToString().Trim() + "\",");
                        json.Append("\"ubiGeo\":\"" + System.Web.HttpUtility.JavaScriptStringEncode(dt.Rows[i]["UBICACION GEOGRAFICA"].ToString().Trim()) + "\",");
                        json.Append("\"telefono\":\"" + System.Web.HttpUtility.JavaScriptStringEncode(dt.Rows[i]["TELEFONO"].ToString().Trim()) + "\",");
                        json.Append("\"paginaWeb\":\"" + System.Web.HttpUtility.JavaScriptStringEncode(dt.Rows[i]["PAGINA WEB"].ToString().Trim()) + "\",");
                        json.Append("\"email\":\"" + System.Web.HttpUtility.JavaScriptStringEncode(dt.Rows[i]["EMAIL"].ToString().Trim()) + "\",");
                        json.Append("\"totalCis\":\"" + dt.Rows[i]["TOTAL CIS"].ToString().Trim() + "\"");
                        json.Append("}");
                    }
                    json.Append("]");
                    this.datosJson.Value = json.ToString();
                }
                else
                {
                    this.datosJson.Value = "[]";
                }
                servidor.cerrarconexion();
            }
            else
            {
                servidor.cerrarconexion();
                this.datosJson.Value = "[]";
            }
        }
        catch (Exception)
        {
            this.datosJson.Value = "[]";
        }
    }

    protected void visualiza_datos_local(object sender, EventArgs e)
    {
        this.__mensaje.Value = "";
        this.__pagina.Value = "";
        System.Web.UI.WebControls.Button b = (System.Web.UI.WebControls.Button)sender;
        String Registro = b.CommandArgument.Trim();
        String[] Datos = Registro.Split(',');
        this.Id_Local.Value = Datos[0];
        this.Codigo_Local.Text = Datos[1];
        this.Nombre_Local.Text = Datos[2];
        this.Direccion_Local.Text = Datos[3];
        for (int i = 0; i < this.Sede.Items.Count; i++)
        {
            if (this.Sede.Items[i].Text.ToString().Trim() == Datos[4].Trim())
            {
                this.Sede.SelectedIndex = i;
            }
        }
        this.hfCodigo_Ubicacion_Geografica.Value = Datos[5];
        this.Ubicacion_Geografica.Text = Datos[6];
        this.Telefono_local.Text = Datos[7];
        this.Pagnia_Web_Local.Text = Datos[8];
        this.Email_Local.Text = Datos[9];
        this.Total_CIS_Local.Text = Datos[10];
        this.btnRegistrar.Visible = false;
        this.btnCancelar.Visible = true;
        oculta(true);
    }

    private void Matenimiento_Local(int _Id_Local,
        string _Codigo_Local,
        string _Nombre_Local,
        string _Direccion_Local,
        int _Id_Sede,
        string _Cod_Ubi,
        string _Telefono_local,
        string _Pagnia_Web_Local,
        string _Email_Local,
        int _Total_CIS_Local,
        string operacion)
    {
        policia.clsaccesodatos servidor = new policia.clsaccesodatos();
        servidor.cadenaconexion = Ruta;
        try
        {
            servidor.cadenaconexion = Ruta;
            if (servidor.abrirconexiontrans() == true)
            {
                servidor.ejecutar("[dbo].[pr_MatenimientoLocal]",
                                    false,
                                    _Id_Local,
                                    _Codigo_Local.Trim(),
                                    _Nombre_Local.Trim(),
                                    _Direccion_Local.Trim(),
                                    _Id_Sede,
                                    _Cod_Ubi.Trim(),
                                    _Telefono_local.Trim(),
                                    _Pagnia_Web_Local.Trim(),
                                    _Email_Local.Trim(),
                                     _Total_CIS_Local,
                                    operacion,
                                    0, "");
                if (servidor.getRespuesta() == 1)
                {
                    servidor.cerrarconexiontrans();
                    ShowMessage(servidor.getMensaje(), "Local.aspx");
                }
                else
                {
                    servidor.cancelarconexiontrans();
                    ShowMessage(servidor.getMensaje(), "Local.aspx");
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

        string[] Datos = (string[])Session["__JSAR__"];
        bool rpta = this.VERIFICAR_PERMISOS_DERECHOS_ACCESO_PAGINA_WEB(Convert.ToInt32(Datos[0]),
        "Local.aspx", "NUEVO");
        if (rpta == false)
        {
            this.__mensaje.Value = "Ud. no esta autorizado para registrar datos en esta pagina web.";
            this.__pagina.Value = "CerrarSession.aspx";
            return;
        }

        Boolean ok;
        ok = rfvCodigo_Local.IsValid;
        ok = ok && rfvTelefono_local.IsValid;
        ok = ok && rfvPagnia_Web_Local.IsValid;
        ok = ok && revPagnia_Web_Local.IsValid;
        ok = ok && rfvEmail_Local.IsValid;
        ok = ok && revEmail_Local.IsValid;
        ok = ok && rfvTotal_CIS_Local.IsValid;

        if (ok == false)
        {
            return;
        }

        Matenimiento_Local(Convert.ToInt32(this.Id_Local.Value.Trim()),
            this.Codigo_Local.Text.Trim(),
            this.Nombre_Local.Text.Trim(),
            this.Direccion_Local.Text.Trim(),
            Convert.ToInt32(this.Sede.SelectedValue),
            this.hfCodigo_Ubicacion_Geografica.Value.Trim(),
             this.Telefono_local.Text.Trim(),
            this.Pagnia_Web_Local.Text.Trim(),
            this.Email_Local.Text.Trim(),
             Convert.ToInt32(this.Total_CIS_Local.Text.Trim()),
            "N");
    }

    protected void btnModificar_Click(object sender, EventArgs e)
    {
        this.__mensaje.Value = "";
        this.__pagina.Value = "";

        string[] Datos = (string[])Session["__JSAR__"];
        bool rpta = this.VERIFICAR_PERMISOS_DERECHOS_ACCESO_PAGINA_WEB(Convert.ToInt32(Datos[0]),
        "Local.aspx", "MODIFICAR");
        if (rpta == false)
        {
            this.__mensaje.Value = "Ud. no esta autorizado para MODIFICAR datos en esta pagina web.";
            this.__pagina.Value = "CerrarSession.aspx";
            return;
        }

        Boolean ok;
        ok = rfvCodigo_Local.IsValid;
        ok = ok && rfvTelefono_local.IsValid;
        ok = ok && rfvPagnia_Web_Local.IsValid;
        ok = ok && revPagnia_Web_Local.IsValid;
        ok = ok && rfvEmail_Local.IsValid;
        ok = ok && revEmail_Local.IsValid;
        ok = ok && rfvTotal_CIS_Local.IsValid;

        if (ok == false)
        {
            return;
        }

        if (Telefono_local.Text.Trim().Length < 6)
        {
            this.__mensaje.Value = "Numero Telefonico debe Tener como Minimo 6 Numeros.";
            this.__pagina.Value = "";
            Telefono_local.Focus();
            return;
        }

        Matenimiento_Local(Convert.ToInt32(this.Id_Local.Value.Trim()),
            this.Codigo_Local.Text.Trim(),
            this.Nombre_Local.Text.Trim(),
            this.Direccion_Local.Text.Trim(),
            Convert.ToInt32(this.Sede.SelectedValue),
            this.hfCodigo_Ubicacion_Geografica.Value.Trim(),
            this.Telefono_local.Text.Trim(),
            this.Pagnia_Web_Local.Text.Trim(),
            this.Email_Local.Text.Trim(),
             Convert.ToInt32(this.Total_CIS_Local.Text.Trim()),
             "M");
    }

    protected void btnEliminar_Click(object sender, EventArgs e)
    {
        this.__mensaje.Value = "";
        this.__pagina.Value = "";

        string[] Datos = (string[])Session["__JSAR__"];
        bool rpta = this.VERIFICAR_PERMISOS_DERECHOS_ACCESO_PAGINA_WEB(Convert.ToInt32(Datos[0]),
        "Local.aspx", "ELIMINAR");
        if (rpta == false)
        {
            this.__mensaje.Value = "Ud. no esta autorizado para eliminar datos en esta pagina web.";
            this.__pagina.Value = "CerrarSession.aspx";
            return;
        }

        Boolean ok;
        ok = rfvCodigo_Local.IsValid;
        if (ok == false)
        {
            return;
        }

        Matenimiento_Local(Convert.ToInt32(this.Id_Local.Value.Trim()),
            this.Codigo_Local.Text.Trim(),
            this.Nombre_Local.Text.Trim(),
            this.Direccion_Local.Text.Trim(),
            Convert.ToInt32(this.Sede.SelectedValue),
            this.hfCodigo_Ubicacion_Geografica.Value.Trim(),
             this.Telefono_local.Text.Trim(),
            this.Pagnia_Web_Local.Text.Trim(),
            this.Email_Local.Text.Trim(),
             Convert.ToInt32(this.Total_CIS_Local.Text.Trim()),
             "E");
    }

    protected void btnCancelar_Click(object sender, EventArgs e)
    {
        string[] Datos = (string[])Session["__JSAR__"];
        bool rpta = this.VERIFICAR_PERMISOS_DERECHOS_ACCESO_PAGINA_WEB(Convert.ToInt32(Datos[0]),
        "Local.aspx", "CANCELAR");
        if (rpta == false)
        {
            this.__mensaje.Value = "Ud. no esta autorizado para CANCELAR datos en esta pagina web.";
            this.__pagina.Value = "CerrarSession.aspx";
            return;
        }
        this.Response.Redirect("Local.aspx");
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