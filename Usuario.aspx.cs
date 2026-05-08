using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SEGURIDAD;
using Servicios;
using System.Data;

public partial class Usuario : System.Web.UI.Page
{
    private String Ruta = System.Configuration.ConfigurationManager.ConnectionStrings["CadenaConeccion"].ToString();
    Lista _Lista = new Lista();
    System.Data.DataTable dt;

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

        bool rpta = this.VERIFICAR_PERMISO_ACCESO_PAGINA_WEB(Convert.ToInt32(Datos[0]), "Usuario.aspx");
        if (rpta == false)
        {
            this.__mensaje.Value = "Ud. no tiene permiso para ACCEDER esta pagina web.";
            this.__pagina.Value = "CerrarSession.aspx";
            return;
        }

        Cargar_Datos(this.Cargo, "[dbo].[pr_Obtener_Cargos]", "Error, al intentar recuperar Cargos.");
        if (this.__mensaje.Value.ToString().Trim() != "") return;

        Cargar_Datos(this.Sede, "[dbo].[pr_Obtener_Sedes]", "Error, al intentar recuperar Sedes Judiciales.");
        if (this.__mensaje.Value.ToString().Trim() != "") return;

        ListarUsuario();
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Convert.ToInt32(this.ID_USUARIO.Value.Trim()) == 0)
        {
            this.btnRegistrar.Visible = true;
            this.btnCancelar.Visible = true;
            oculta(false);
        }
    }

    private void Matenimiento_Usuario(int _Id_Uusario, string _Nombre, string _ApePat, string _ApeMat, string _Telefono,
        string _Email, string _Login, string _Password, bool _Estado, int _Id_Cargo, int _Id_Area, string operacion)
    {
        policia.clsaccesodatos servidor = new policia.clsaccesodatos();
        servidor.cadenaconexion = Ruta;
        try
        {
            if (servidor.abrirconexiontrans() == true)
            {
                servidor.ejecutar("[dbo].[pr_MatenimientoUusraio]", false, _Id_Uusario, _Nombre.Trim(), _ApePat.Trim(),
                    _ApeMat.Trim(), _Telefono.Trim(), _Email.Trim(), _Login.Trim(), _Password.Trim(), _Estado,
                    _Id_Cargo, _Id_Area, operacion, 0, "");
                if (servidor.getRespuesta() == 1)
                {
                    servidor.cerrarconexiontrans();
                    ShowMessage(servidor.getMensaje(), "Usuario.aspx");
                }
                else
                {
                    servidor.cancelarconexiontrans();
                    ShowMessage(servidor.getMensaje(), "Usuario.aspx");
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

    private void ListarUsuario()
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");
        try
        {
            policia.clsaccesodatos servidor = new policia.clsaccesodatos();
            servidor.cadenaconexion = Ruta;
            if (servidor.abrirconexion() == true)
            {
                dt = servidor.consultar("[dbo].[pr_ListaUsuarios]").Tables[0];
                servidor.cerrarconexion();

                if (dt.Rows.Count == 0)
                {
                    datosJson.Value = "[]";
                    _Lista.ShowMessage(__mensaje, __pagina, "No hay Usuarios registrados.", "");
                }
                else
                {
                    System.Text.StringBuilder sb = new System.Text.StringBuilder();
                    sb.Append("[");

                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        if (i > 0) sb.Append(",");
                        DataRow row = dt.Rows[i];
                        sb.Append("{");
                        sb.Append("\"ID\":\"" + JsonEncode(row["ID"].ToString()) + "\",");
                        sb.Append("\"NOMBRE\":\"" + JsonEncode(row["NOMBRE"].ToString() + " " + row["APEPAT"].ToString() + " " + row["APEMAT"].ToString()) + "\",");
                        sb.Append("\"CARGO\":\"" + JsonEncode(row["CARGO"].ToString()) + "\",");
                        sb.Append("\"TELEFONO\":\"" + JsonEncode(row["TELEFONO"].ToString()) + "\",");
                        sb.Append("\"EMAIL\":\"" + JsonEncode(row["EMAIL"].ToString()) + "\",");
                        sb.Append("\"LOGIN\":\"" + JsonEncode(row["LOGIN"].ToString()) + "\",");
                        sb.Append("\"ESTADO\":\"" + JsonEncode(row["ESTADO"].ToString()) + "\"");
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

    protected void visualiza_datos_usuario(object sender, EventArgs e)
    {
        this.__mensaje.Value = "";
        this.__pagina.Value = "";
        System.Web.UI.WebControls.Button b = (System.Web.UI.WebControls.Button)sender;
        String Registro = b.CommandArgument.Trim();
        String[] Datos = Registro.Split(',');
        this.ID_USUARIO.Value = Datos[0];
        this.Nombre.Text = Datos[1];
        this.ApePat.Text = Datos[2];
        this.ApeMat.Text = Datos[3];
        this.Telefono.Text = Datos[4];
        this.Email.Text = Datos[5];
        this.Login.Text = Datos[6];
        encriptar en = new encriptar();
        String strTextoDesencriptado = en.DesEncriptarCadena(Datos[7]);
        this.Password.Text = strTextoDesencriptado;
        this.Estado.Checked = Datos[8] == "ACTIVO" ? true : false;
        for (int i = 0; i < this.Cargo.Items.Count; i++)
        {
            if (this.Cargo.Items[i].Text.ToString().Trim() == Datos[9].Trim())
            {
                this.Cargo.SelectedIndex = i;
            }
        }
        for (int i = 0; i < this.Sede.Items.Count; i++)
        {
            if (this.Sede.Items[i].Text.ToString().Trim() == Datos[10].Trim())
            {
                this.Sede.SelectedIndex = i;
            }
        }
        Sede_SelectedIndexChanged(sender, e);
        for (int i = 0; i < this.Local.Items.Count; i++)
        {
            if (this.Local.Items[i].Text.ToString().Trim() == Datos[11].Trim())
            {
                this.Local.SelectedIndex = i;
            }
        }
        Local_SelectedIndexChanged(sender, e);
        for (int i = 0; i < this.Area.Items.Count; i++)
        {
            if (this.Area.Items[i].Text.ToString().Trim() == Datos[12].Trim())
            {
                this.Area.SelectedIndex = i;
            }
        }
        this.btnRegistrar.Visible = false;
        this.btnCancelar.Visible = true;
        oculta(true);
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
        bool rpta = this.VERIFICAR_PERMISOS_DERECHOS_ACCESO_PAGINA_WEB(Convert.ToInt32(Datos[0]), "Usuario.aspx", "NUEVO");
        if (rpta == false)
        {
            this.__mensaje.Value = "Ud. no esta autorizado para registrar datos en esta pagina web.";
            this.__pagina.Value = "CerrarSession.aspx";
            return;
        }

        Boolean ok;
        ok = rfvNombre.IsValid;
        ok = ok && rfvApePat.IsValid;
        ok = ok && rfvApeMat.IsValid;
        ok = ok && rfvTelefono.IsValid;
        ok = ok && rfvEmail.IsValid;
        ok = ok && revEmail.IsValid;
        ok = ok && rfvLogin.IsValid;
        ok = ok && rfvPassword.IsValid;
        ok = ok && rfvCargo.IsValid;
        ok = ok && revCargo.IsValid;
        if (ok == false) return;

        encriptar en = new encriptar();
        String strTextoEncriptado = en.EncriptarCadena(this.Password.Text.Trim());
        Matenimiento_Usuario(Convert.ToInt32(this.ID_USUARIO.Value.Trim()),
            this.Nombre.Text.Trim(), this.ApePat.Text.Trim(), this.ApeMat.Text.Trim(),
            this.Telefono.Text.Trim(), this.Email.Text.Trim(), this.Login.Text.Trim(),
            strTextoEncriptado, this.Estado.Checked,
            Convert.ToInt32(this.Cargo.SelectedValue), Convert.ToInt32(this.Area.SelectedValue),
            "N");
    }

    protected void btnModificar_Click(object sender, EventArgs e)
    {
        this.__mensaje.Value = "";
        this.__pagina.Value = "";

        string[] Datos = (string[])Session["__JSAR__"];
        bool rpta = this.VERIFICAR_PERMISOS_DERECHOS_ACCESO_PAGINA_WEB(Convert.ToInt32(Datos[0]), "Usuario.aspx", "MODIFICAR");
        if (rpta == false)
        {
            this.__mensaje.Value = "Ud. no esta autorizado para MODIFICAR datos en esta pagina web.";
            this.__pagina.Value = "CerrarSession.aspx";
            return;
        }

        Boolean ok;
        ok = rfvNombre.IsValid;
        ok = ok && rfvApePat.IsValid;
        ok = ok && rfvApeMat.IsValid;
        ok = ok && rfvTelefono.IsValid;
        ok = ok && rfvEmail.IsValid;
        ok = ok && revEmail.IsValid;
        ok = ok && rfvLogin.IsValid;
        ok = ok && rfvPassword.IsValid;
        ok = ok && rfvCargo.IsValid;
        ok = ok && revCargo.IsValid;
        if (ok == false) return;

        encriptar en = new encriptar();
        String strTextoEncriptado = en.EncriptarCadena(this.Password.Text.Trim());
        Matenimiento_Usuario(Convert.ToInt32(this.ID_USUARIO.Value.Trim()),
            this.Nombre.Text.Trim(), this.ApePat.Text.Trim(), this.ApeMat.Text.Trim(),
            this.Telefono.Text.Trim(), this.Email.Text.Trim(), this.Login.Text.Trim(),
            strTextoEncriptado, this.Estado.Checked,
            Convert.ToInt32(this.Cargo.SelectedValue), Convert.ToInt32(this.Area.SelectedValue),
            "M");
    }

    protected void btnEliminar_Click(object sender, EventArgs e)
    {
        this.__mensaje.Value = "";
        this.__pagina.Value = "";

        string[] Datos = (string[])Session["__JSAR__"];
        bool rpta = this.VERIFICAR_PERMISOS_DERECHOS_ACCESO_PAGINA_WEB(Convert.ToInt32(Datos[0]), "Usuario.aspx", "ELIMINAR");
        if (rpta == false)
        {
            this.__mensaje.Value = "Ud. no esta autorizado para eliminar datos en esta pagina web.";
            this.__pagina.Value = "CerrarSession.aspx";
            return;
        }

        Boolean ok;
        ok = rfvNombre.IsValid;
        ok = ok && rfvApePat.IsValid;
        ok = ok && rfvApeMat.IsValid;
        ok = ok && rfvTelefono.IsValid;
        ok = ok && rfvEmail.IsValid;
        ok = ok && revEmail.IsValid;
        ok = ok && rfvLogin.IsValid;
        ok = ok && rfvPassword.IsValid;
        ok = ok && rfvCargo.IsValid;
        ok = ok && revCargo.IsValid;
        if (ok == false) return;

        Matenimiento_Usuario(Convert.ToInt32(this.ID_USUARIO.Value.Trim()),
            this.Nombre.Text.Trim(), this.ApePat.Text.Trim(), this.ApeMat.Text.Trim(),
            this.Telefono.Text.Trim(), this.Email.Text.Trim(), this.Login.Text.Trim(),
            this.Password.Text.Trim(), this.Estado.Checked,
            Convert.ToInt32(this.Cargo.SelectedValue), Convert.ToInt32(this.Area.SelectedValue),
            "E");
    }

    protected void btnCancelar_Click(object sender, EventArgs e)
    {
        string[] Datos = (string[])Session["__JSAR__"];
        bool rpta = this.VERIFICAR_PERMISOS_DERECHOS_ACCESO_PAGINA_WEB(Convert.ToInt32(Datos[0]), "Usuario.aspx", "CANCELAR");
        if (rpta == false)
        {
            this.__mensaje.Value = "Ud. no esta autorizado para CANCELAR datos en esta pagina web.";
            this.__pagina.Value = "CerrarSession.aspx";
            return;
        }

        this.Response.Redirect("Usuario.aspx");
    }

    protected void Sede_SelectedIndexChanged(object sender, EventArgs e)
    {
        this.__mensaje.Value = "";
        this.__pagina.Value = "";
        this.Local.Items.Clear();
        this.Local.Items.Insert(0, "_____SELECCIONE LOCAL_____");
        this.Local.Items[0].Value = "-1";
        this.Area.Items.Clear();
        this.Area.Items.Insert(0, "_____SELECCIONE AREA_____");
        this.Area.Items[0].Value = "-1";
        int Codigo_Sede = Convert.ToInt32(Sede.SelectedValue);
        if (Codigo_Sede == -1)
        {
            this.__mensaje.Value = "Seleccione Sede Judicial para ver Locales Judiciales";
            this.__pagina.Value = "";
            return;
        }
        Cargar_Datos(this.Local, "[dbo].[pr_Obtener_Locales]", "Error, al intentar recuperar Locales Judiciales.", new Object[] { Codigo_Sede });
    }

    protected void Local_SelectedIndexChanged(object sender, EventArgs e)
    {
        this.__mensaje.Value = "";
        this.__pagina.Value = "";
        this.Area.Items.Clear();
        this.Area.Items.Insert(0, "_____SELECCIONE AREA_____");
        this.Area.Items[0].Value = "-1";
        int Codigo_Local = Convert.ToInt32(Local.SelectedValue);
        if (Codigo_Local == -1)
        {
            this.__mensaje.Value = "Seleccione Local Judicial para ver Areas Judiciales";
            this.__pagina.Value = "";
            return;
        }
        Cargar_Datos(this.Area, "[dbo].[pr_Obtener_Areas]", "Error, al intentar recuperar Areas Judiciales.", new Object[] { Codigo_Local });
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
