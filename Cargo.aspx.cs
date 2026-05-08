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

    Lista _Lista = new Lista();
    System.Data.DataTable dt;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Convert.ToInt32(this.ID_CARGO.Value.Trim()) == 0)
        {
            this.btnRegistrar.Visible = true;
            this.btnCancelar.Visible = true;
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
        bool rpta = this.VERIFICAR_PERMISO_ACCESO_PAGINA_WEB(Convert.ToInt32(Datos[0]), "Cargo.aspx");
        if (rpta == false)
        {
            this.__mensaje.Value = "Ud. no tiene permiso para ACCEDER esta pagina web.";
            this.__pagina.Value = "CerrarSession.aspx";
            return;
        }

        Lista_Cargos();
    }

    private void ShowMessage(string msg, string paginaweb)
    {
        this.__mensaje.Value = msg;
        this.__pagina.Value = paginaweb;
    }

    private void Lista_Cargos()
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");
        try
        {
            policia.clsaccesodatos servidor = new policia.clsaccesodatos();
            servidor.cadenaconexion = Ruta;
            if (servidor.abrirconexion() == true)
            {
                dt = servidor.consultar("[dbo].[pr_Lista_Cargos]").Tables[0];
                servidor.cerrarconexion();

                if (dt.Rows.Count == 0)
                {
                    datosJson.Value = "[]";
                    _Lista.ShowMessage(__mensaje, __pagina, "No hay Cargos registrados.", "");
                }
                else
                {
                    // Convert DataTable to JSON-like structure
                    System.Text.StringBuilder sb = new System.Text.StringBuilder();
                    sb.Append("[");

                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        if (i > 0) sb.Append(",");
                        DataRow row = dt.Rows[i];
                        sb.Append("{");
                        sb.Append("\"ID_CARGO\":\"" + JsonEncode(row["CODIGO"].ToString()) + "\",");
                        sb.Append("\"NOMBRE_CARGO\":\"" + JsonEncode(row["NOMBRE"].ToString()) + "\"");
                        sb.Append("}");
                    }

                    sb.Append("]");
                    datosJson.Value = sb.ToString();
                }
            }
            else
            {
                servidor.cerrarconexion();
                datosJson.Value = "[]";
                this.__mensaje.Value = servidor.getMensageError();
                this.__pagina.Value = "CerrarSession.aspx";
            }
        }
        catch (Exception)
        {
            datosJson.Value = "[]";
            this.__mensaje.Value = "Error inesperado al intentar conectarnos con el servidor.";
            this.__pagina.Value = "CerrarSession.aspx";
        }
    }

    private string JsonEncode(string str)
    {
        if (string.IsNullOrEmpty(str)) return "";
        return str.Replace("\\", "\\\\")
                   .Replace("\"", "\\\"")
                   .Replace("\n", "\\n")
                   .Replace("\r", "\\r")
                   .Replace("\t", "\\t")
                   .Replace("<", "\\u003c")
                   .Replace(">", "\\u003e");
    }

    protected void visualiza_datos_tipos_elemento_configuracion(object sender, EventArgs e)
    {
        this.__mensaje.Value = "";
        this.__pagina.Value = "";
        System.Web.UI.WebControls.Button b = (System.Web.UI.WebControls.Button)sender;
        String Registro = b.CommandArgument.Trim();
        String[] Datos = Registro.Split(',');
        this.ID_CARGO.Value = Datos[0];
        this.NOMBRE_CARGO.Text = Datos[1];
        this.btnRegistrar.Visible = false;
        this.btnCancelar.Visible = true;
        oculta(true);
    }

    private void Matenimiento_Cargo(int _ID_CARGO,
        string _NOMBRE_CARGO,
        string operacion)
    {
        policia.clsaccesodatos servidor = new policia.clsaccesodatos();
        servidor.cadenaconexion = Ruta;
        try
        {
            servidor.cadenaconexion = Ruta;
            if (servidor.abrirconexiontrans() == true)
            {
                servidor.ejecutar("[dbo].[pr_MatenimientoCargo]",
                                    false,
                                    _ID_CARGO,
                                    _NOMBRE_CARGO.Trim(),
                                    operacion,
                                    0, "");
                if (servidor.getRespuesta() == 1)
                {
                    servidor.cerrarconexiontrans();
                    ShowMessage(servidor.getMensaje(), "Cargo.aspx");
                }
                else
                {
                    servidor.cancelarconexiontrans();
                    ShowMessage(servidor.getMensaje(), "Cargo.aspx");
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
        "Cargo.aspx", "NUEVO");
        if (rpta == false)
        {
            this.__mensaje.Value = "Ud. no esta autorizado para registrar datos en esta pagina web.";
            this.__pagina.Value = "CerrarSession.aspx";
            return;
        }

        Boolean ok;
        ok = rfvNOMBRE_CARGO.IsValid;
        if (ok == false)
        {
            return;
        }

        Matenimiento_Cargo(Convert.ToInt32(this.ID_CARGO.Value.Trim()),
            this.NOMBRE_CARGO.Text.Trim(),
            "N");
    }

    protected void btnModificar_Click(object sender, EventArgs e)
    {
        this.__mensaje.Value = "";
        this.__pagina.Value = "";

        //verificar permiso para REGISTRAR datos.
        string[] Datos = (string[])Session["__JSAR__"];
        bool rpta = this.VERIFICAR_PERMISOS_DERECHOS_ACCESO_PAGINA_WEB(Convert.ToInt32(Datos[0]),
        "Cargo.aspx", "MODIFICAR");
        if (rpta == false)
        {
            this.__mensaje.Value = "Ud. no esta autorizado para MODIFICAR datos en esta pagina web.";
            this.__pagina.Value = "CerrarSession.aspx";
            return;
        }

        Boolean ok;
        ok = rfvNOMBRE_CARGO.IsValid;
        if (ok == false)
        {
            return;
        }

        Matenimiento_Cargo(Convert.ToInt32(this.ID_CARGO.Value.Trim()),
            this.NOMBRE_CARGO.Text.Trim(),
             "M");
    }

    protected void btnEliminar_Click(object sender, EventArgs e)
    {
        this.__mensaje.Value = "";
        this.__pagina.Value = "";

        //verificar permiso para eliminar datos.
        string[] Datos = (string[])Session["__JSAR__"];
        bool rpta = this.VERIFICAR_PERMISOS_DERECHOS_ACCESO_PAGINA_WEB(Convert.ToInt32(Datos[0]),
        "Cargo.aspx", "ELIMINAR");
        if (rpta == false)
        {
            this.__mensaje.Value = "Ud. no esta autorizado para eliminar datos en esta pagina web.";
            this.__pagina.Value = "CerrarSession.aspx";
            return;
        }

        Boolean ok;
        ok = rfvNOMBRE_CARGO.IsValid;
        if (ok == false)
        {
            return;
        }

        Matenimiento_Cargo(Convert.ToInt32(this.ID_CARGO.Value.Trim()),
            this.NOMBRE_CARGO.Text.Trim(),
             "E");
    }

    protected void btnCancelar_Click(object sender, EventArgs e)
    {
        //verificar permiso para eliminar datos.
        string[] Datos = (string[])Session["__JSAR__"];
        bool rpta = this.VERIFICAR_PERMISOS_DERECHOS_ACCESO_PAGINA_WEB(Convert.ToInt32(Datos[0]),
        "Cargo.aspx", "CANCELAR");
        if (rpta == false)
        {
            this.__mensaje.Value = "Ud. no esta autorizado para CANCELAR datos en esta pagina web.";
            this.__pagina.Value = "CerrarSession.aspx";
            return;
        }

        this.Response.Redirect("Cargo.aspx");
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