using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;

public partial class Personal : System.Web.UI.Page
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
            if (!string.IsNullOrWhiteSpace(Mensaje))
            {
                this.__mensaje.Value = Mensaje;
                this.__pagina.Value = "";
            }
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

        bool rpta = this.VERIFICAR_PERMISO_ACCESO_PAGINA_WEB(Convert.ToInt32(Datos[0]),
        "Personal.aspx");
        if (rpta == false)
        {
            this.__mensaje.Value = "Ud. no tiene permiso para ACCEDER esta pagina web.";
            this.__pagina.Value = "CerrarSession.aspx";
            return;
        }

        Cargar_Datos(this.TipoDocIdent, "[dbo].[pr_Obtener_Tipos_Documentos]", "Error, al intentar recuperar Tipos Doc. Ientidad.");
        if (this.__mensaje.Value.ToString().Trim() != "")
        {
            return;
        }
        Cargar_Datos(this.Profesion, "[dbo].[pr_Obtener_Profesion_Ocupacion]", "Error, al intentar recuperar Profesion Ocupacion.");
        if (this.__mensaje.Value.ToString().Trim() != "")
        {
            return;
        }
        Cargar_Datos(this.Sede, "[dbo].[pr_Obtener_Sedes]", "");
        if (this.__mensaje.Value.ToString().Trim() != "") { return; }
        Cargar_Datos(this.Dependencia, "[dbo].[pr_Obtener_Dependencias]", "");
        if (this.__mensaje.Value.ToString().Trim() != "") { return; }
        Cargar_Datos(this.Cargo, "[dbo].[pr_Obtener_Cargos]", "");
        if (this.__mensaje.Value.ToString().Trim() != "") { return; }
        // Cargar Locales y Areas sin filtro para que esten disponibles en el formulario
        Cargar_Datos(this.Local, "[dbo].[pr_Obtener_Locales]", "", 0);
        Cargar_Datos(this.Area, "[dbo].[pr_Obtener_Areas]", "", 0);
        Cargar_Lista_Personal();
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Convert.ToInt32(this.ID_PERSONAL.Value.Trim()) == 0)
        {
            this.btnRegistrar.Visible = true;
            this.btnCancelar.Visible = true;
            oculta(false);
        }
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
        if (this.__mensaje.Value.ToString().Trim() != "")
        {
            return;
        }
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
        if (this.__mensaje.Value.ToString().Trim() != "")
        {
            return;
        }
    }

    private void Cargar_Lista_Personal()
    {
        try
        {
            policia.clsaccesodatos servidor = new policia.clsaccesodatos();
            servidor.cadenaconexion = Ruta;
            if (servidor.abrirconexion() == true)
            {
                dt = servidor.consultar("[dbo].[pr_ListaPersonal]").Tables[0];
                if (dt.Rows.Count == 0)
                {
                    servidor.cerrarconexion();
                    this.datosJson.Value = "[]";
                }
                else
                {
                    var lista = new List<object>();
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        lista.Add(new {
                            ID_PERSONAL = dt.Rows[i]["ID_PERSONAL"].ToString().Trim(),
                            CODIGO = dt.Rows[i]["CODIGO"].ToString().Trim(),
                            NOMBRE = dt.Rows[i]["NOMBRE"].ToString().Trim(),
                            APELLIDO_PATERNO = dt.Rows[i]["APELLIDO PATERNO"].ToString().Trim(),
                            APELLIDO_MATERNO = dt.Rows[i]["APELLIDO MATERNO"].ToString().Trim(),
                            TIPO_DOC_IDENT = dt.Rows[i]["TIPO DOC. IDENT."].ToString().Trim(),
                            NRO_DOC_IDENT = dt.Rows[i]["NRO. DOC. IDENT."].ToString().Trim(),
                            PROFESION = dt.Rows[i]["PROFESION"].ToString().Trim(),
                            TELEFONO = dt.Rows[i]["TELEFONO"].ToString().Trim(),
                            EMAIL = dt.Rows[i]["EMAIL"].ToString().Trim(),
                            SEDE = dt.Rows[i]["SEDE"].ToString().Trim(),
                            LOCAL = dt.Rows[i]["LOCAL"].ToString().Trim(),
                            AREA = dt.Rows[i]["AREA"].ToString().Trim(),
                            DEPENDENCIA = dt.Rows[i]["DEPENDENCIA"].ToString().Trim(),
                            CARGO = dt.Rows[i]["CARGO"].ToString().Trim(),
                            ESTADO = dt.Rows[i]["ESTADO"].ToString().Trim()
                        });
                    }
                    JavaScriptSerializer serializer = new JavaScriptSerializer();
                    this.datosJson.Value = serializer.Serialize(lista);
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

    private void Matenimiento_Personal(int _Id_Personal,
        string _Codigo_Personal,
        string _Nombre_Personal,
        string _ApePat_Personal,
        string _ApeMat_Personal,
        int _Id_Tipo_Documento,
        string _Nro_Dni_Personal,
        int _Id_prof_ocup,
        string _Tel_Personal,
        string _Email_Personal,
        int _Id_Area,
        int _Id_Dependencia,
        bool _Estado_Personal,
        int _Id_Cargo,
        string operacion)
    {
        policia.clsaccesodatos servidor = new policia.clsaccesodatos();
        servidor.cadenaconexion = Ruta;
        try
        {
            if (servidor.abrirconexiontrans() == true)
            {
                servidor.ejecutar("[dbo].[pr_MatenimientoPersonal]",
                                    false,
                                    _Id_Personal,
                                    _Codigo_Personal.Trim(),
                                    _Nombre_Personal.Trim(),
                                    _ApePat_Personal.Trim(),
                                    _ApeMat_Personal.Trim(),
                                    _Id_Tipo_Documento,
                                    _Nro_Dni_Personal.Trim(),
                                    _Id_prof_ocup,
                                    _Tel_Personal.Trim(),
                                    _Email_Personal.Trim(),
                                    _Id_Area,
                                    _Id_Dependencia,
                                    _Estado_Personal,
                                    _Id_Cargo,
                                    operacion,
                                    0, "");
                if (servidor.getRespuesta() == 1)
                {
                    servidor.cerrarconexiontrans();
                    ShowMessage(servidor.getMensaje(), "Personal.aspx");
                }
                else
                {
                    servidor.cancelarconexiontrans();
                    ShowMessage(servidor.getMensaje(), "Personal.aspx");
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

    protected void btnRegistrar_Click(object sender, EventArgs e)
    {
        this.__mensaje.Value = "";
        this.__pagina.Value = "";

        string[] Datos = (string[])Session["__JSAR__"];
        bool rpta = this.VERIFICAR_PERMISOS_DERECHOS_ACCESO_PAGINA_WEB(Convert.ToInt32(Datos[0]),
        "Personal.aspx", "NUEVO");
        if (rpta == false)
        {
            this.__mensaje.Value = "Ud. no esta autorizado para registrar datos en esta pagina web.";
            this.__pagina.Value = "CerrarSession.aspx";
            return;
        }

        Boolean ok;
        ok = rfvCodigo.IsValid;
        ok = ok && revCodigo.IsValid;
        ok = ok && rfvNombre.IsValid;
        ok = ok && rfvApellidoPat.IsValid;
        ok = ok && rfvApellidoMat.IsValid;
        ok = ok && rfvTipoDocIdent.IsValid;
        ok = ok && rfvNroDocIdent.IsValid;
        ok = ok && rfvProfesion.IsValid;
        ok = ok && rfvTelefono.IsValid;
        ok = ok && rfvEmail.IsValid;
        ok = ok && revEmail.IsValid;
        ok = ok && rfvSede.IsValid;
        ok = ok && revSede.IsValid;
        ok = ok && rfvLocal.IsValid;
        ok = ok && revLocal.IsValid;
        ok = ok && rfvArea.IsValid;
        ok = ok && revArea.IsValid;
        ok = ok && rfvDependencia.IsValid;
        ok = ok && revDependencia.IsValid;
        if (ok == false)
        {
            return;
        }
        Matenimiento_Personal(Convert.ToInt32(this.ID_PERSONAL.Value.Trim()),
            this.Codigo.Text.Trim(),
            this.Nombre.Text.Trim(),
            this.ApellidoPat.Text.Trim(),
            this.ApellidoMat.Text.Trim(),
            Convert.ToInt32(this.TipoDocIdent.SelectedValue),
            this.NroDocIdent.Text.Trim(),
            Convert.ToInt32(this.Profesion.SelectedValue),
            this.Telefono.Text.Trim(),
            this.Email.Text.Trim(),
            Convert.ToInt32(this.Area.SelectedValue),
            Convert.ToInt32(this.Dependencia.SelectedValue),
            this.Estado.Checked,
            Convert.ToInt32(this.Cargo.SelectedValue),
            "N");
    }

    protected void btnModificar_Click(object sender, EventArgs e)
    {
        this.__mensaje.Value = "";
        this.__pagina.Value = "";

        string[] Datos = (string[])Session["__JSAR__"];
        bool rpta = this.VERIFICAR_PERMISOS_DERECHOS_ACCESO_PAGINA_WEB(Convert.ToInt32(Datos[0]),
        "Personal.aspx", "MODIFICAR");
        if (rpta == false)
        {
            this.__mensaje.Value = "Ud. no esta autorizado para MODIFICAR datos en esta pagina web.";
            this.__pagina.Value = "CerrarSession.aspx";
            return;
        }

        Boolean ok;
        ok = rfvCodigo.IsValid;
        ok = ok && revCodigo.IsValid;
        ok = ok && rfvNombre.IsValid;
        ok = ok && rfvApellidoPat.IsValid;
        ok = ok && rfvApellidoMat.IsValid;
        ok = ok && rfvTipoDocIdent.IsValid;
        ok = ok && rfvNroDocIdent.IsValid;
        ok = ok && rfvProfesion.IsValid;
        ok = ok && rfvTelefono.IsValid;
        ok = ok && rfvEmail.IsValid;
        ok = ok && revEmail.IsValid;
        ok = ok && rfvSede.IsValid;
        ok = ok && revSede.IsValid;
        ok = ok && rfvLocal.IsValid;
        ok = ok && revLocal.IsValid;
        ok = ok && rfvArea.IsValid;
        ok = ok && revArea.IsValid;
        ok = ok && rfvDependencia.IsValid;
        ok = ok && revDependencia.IsValid;
        if (ok == false)
        {
            return;
        }
        Matenimiento_Personal(Convert.ToInt32(this.ID_PERSONAL.Value.Trim()),
            this.Codigo.Text.Trim(),
            this.Nombre.Text.Trim(),
            this.ApellidoPat.Text.Trim(),
            this.ApellidoMat.Text.Trim(),
            Convert.ToInt32(this.TipoDocIdent.SelectedValue),
            this.NroDocIdent.Text.Trim(),
            Convert.ToInt32(this.Profesion.SelectedValue),
            this.Telefono.Text.Trim(),
            this.Email.Text.Trim(),
            Convert.ToInt32(this.Area.SelectedValue),
            Convert.ToInt32(this.Dependencia.SelectedValue),
            this.Estado.Checked,
            Convert.ToInt32(this.Cargo.SelectedValue),
            "M");
    }

    protected void btnEliminar_Click(object sender, EventArgs e)
    {
        this.__mensaje.Value = "";
        this.__pagina.Value = "";

        string[] Datos = (string[])Session["__JSAR__"];
        bool rpta = this.VERIFICAR_PERMISOS_DERECHOS_ACCESO_PAGINA_WEB(Convert.ToInt32(Datos[0]),
        "Personal.aspx", "ELIMINAR");
        if (rpta == false)
        {
            this.__mensaje.Value = "Ud. no esta autorizado para eliminar datos en esta pagina web.";
            this.__pagina.Value = "CerrarSession.aspx";
            return;
        }

        Boolean ok;
        ok = rfvCodigo.IsValid;
        ok = ok && revCodigo.IsValid;
        ok = ok && rfvNombre.IsValid;
        ok = ok && rfvApellidoPat.IsValid;
        ok = ok && rfvApellidoMat.IsValid;
        ok = ok && rfvTipoDocIdent.IsValid;
        ok = ok && rfvNroDocIdent.IsValid;
        ok = ok && rfvProfesion.IsValid;
        ok = ok && rfvTelefono.IsValid;
        ok = ok && rfvEmail.IsValid;
        ok = ok && revEmail.IsValid;
        ok = ok && rfvSede.IsValid;
        ok = ok && revSede.IsValid;
        ok = ok && rfvLocal.IsValid;
        ok = ok && revLocal.IsValid;
        ok = ok && rfvArea.IsValid;
        ok = ok && revArea.IsValid;
        ok = ok && rfvDependencia.IsValid;
        ok = ok && revDependencia.IsValid;
        if (ok == false)
        {
            return;
        }
        Matenimiento_Personal(Convert.ToInt32(this.ID_PERSONAL.Value.Trim()),
            this.Codigo.Text.Trim(),
            this.Nombre.Text.Trim(),
            this.ApellidoPat.Text.Trim(),
            this.ApellidoMat.Text.Trim(),
            Convert.ToInt32(this.TipoDocIdent.SelectedValue),
            this.NroDocIdent.Text.Trim(),
            Convert.ToInt32(this.Profesion.SelectedValue),
            this.Telefono.Text.Trim(),
            this.Email.Text.Trim(),
            Convert.ToInt32(this.Area.SelectedValue),
            Convert.ToInt32(this.Dependencia.SelectedValue),
            this.Estado.Checked,
            Convert.ToInt32(this.Cargo.SelectedValue),
            "E");
    }

    protected void btnCancelar_Click(object sender, EventArgs e)
    {
        string[] Datos = (string[])Session["__JSAR__"];
        bool rpta = this.VERIFICAR_PERMISOS_DERECHOS_ACCESO_PAGINA_WEB(Convert.ToInt32(Datos[0]),
        "Personal.aspx", "CANCELAR");
        if (rpta == false)
        {
            this.__mensaje.Value = "Ud. no esta autorizado para CANCELAR datos en esta pagina web.";
            this.__pagina.Value = "CerrarSession.aspx";
            return;
        }

        this.Response.Redirect("Personal.aspx");
    }

    protected void visualiza_datos_personal(object sender, EventArgs e)
    {
        this.__mensaje.Value = "";
        this.__pagina.Value = "";
        System.Web.UI.WebControls.LinkButton b = (System.Web.UI.WebControls.LinkButton)sender;
        String Registro = b.CommandArgument.Trim();
        String[] Datos = Registro.Split(',');
        this.ID_PERSONAL.Value = Datos[0];

        for (int i = 0; i < this.Sede.Items.Count; i++)
        {
            if (this.Sede.Items[i].Text.ToString().Trim() == Datos[1].Trim())
            {
                this.Sede.SelectedIndex = i;
            }
        }
        Sede_SelectedIndexChanged(sender, e);

        for (int i = 0; i < this.Local.Items.Count; i++)
        {
            if (this.Local.Items[i].Text.ToString().Trim() == Datos[2].Trim())
            {
                this.Local.SelectedIndex = i;
            }
        }
        Local_SelectedIndexChanged(sender, e);

        for (int i = 0; i < this.Area.Items.Count; i++)
        {
            if (this.Area.Items[i].Text.ToString().Trim() == Datos[3].Trim())
            {
                this.Area.SelectedIndex = i;
            }
        }

        for (int i = 0; i < this.Dependencia.Items.Count; i++)
        {
            if (this.Dependencia.Items[i].Text.ToString().Trim() == Datos[4].Trim())
            {
                this.Dependencia.SelectedIndex = i;
            }
        }
        this.Codigo.Text = Datos[5];
        this.Nombre.Text = Datos[6];
        this.ApellidoPat.Text = Datos[7];
        this.ApellidoMat.Text = Datos[8];

        for (int i = 0; i < this.TipoDocIdent.Items.Count; i++)
        {
            if (this.TipoDocIdent.Items[i].Text.ToString().Trim() == Datos[9].Trim())
            {
                this.TipoDocIdent.SelectedIndex = i;
            }
        }
        this.NroDocIdent.Text = Datos[10];

        for (int i = 0; i < this.Profesion.Items.Count; i++)
        {
            if (this.Profesion.Items[i].Text.ToString().Trim() == Datos[11].Trim())
            {
                this.Profesion.SelectedIndex = i;
            }
        }
        this.Telefono.Text = Datos[12];
        this.Email.Text = Datos[13];
        this.Estado.Checked = Datos[14] == "ACTIVO" ? true : false;

        for (int i = 0; i < this.Cargo.Items.Count; i++)
        {
            if (this.Cargo.Items[i].Text.ToString().Trim() == Datos[15].Trim())
            {
                this.Cargo.SelectedIndex = i;
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