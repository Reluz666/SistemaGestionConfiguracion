using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class PersonalForm : System.Web.UI.Page
{
    private String Ruta = System.Configuration.ConfigurationManager.ConnectionStrings["CadenaConeccion"].ToString();
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

        // Cargar dropdowns
        Cargar_Datos(this.TipoDocIdent, "[dbo].[pr_Obtener_Tipos_Documentos]", "Error, al intentar recuperar Tipos Doc. Ientidad.");
        if (this.__mensaje.Value.ToString().Trim() != "") { return; }
        Cargar_Datos(this.Profesion, "[dbo].[pr_Obtener_Profesion_Ocupacion]", "Error, al intentar recuperar Profesion Ocupacion.");
        if (this.__mensaje.Value.ToString().Trim() != "") { return; }
        Cargar_Datos(this.Sede, "[dbo].[pr_Obtener_Sedes]", "");
        if (this.__mensaje.Value.ToString().Trim() != "") { return; }
        Cargar_Datos(this.Dependencia, "[dbo].[pr_Obtener_Dependencias]", "");
        if (this.__mensaje.Value.ToString().Trim() != "") { return; }
        Cargar_Datos(this.Cargo, "[dbo].[pr_Obtener_Cargos]", "");
        if (this.__mensaje.Value.ToString().Trim() != "") { return; }

        // Cargar locales y areas
        CargarLocalPorSede();
        CargarAreaPorLocal();

        // Determinar operación
        string operacion = Request.QueryString["Operacion"] ?? "N";
        this.Operacion.Value = operacion;

        if (operacion == "E")
        {
            // Editar - cargar datos del personal
            string idPersonalStr = Request.QueryString["Id"];
            if (!string.IsNullOrEmpty(idPersonalStr))
            {
                int idPersonal = Convert.ToInt32(idPersonalStr);
                this.ID_PERSONAL.Value = idPersonal.ToString();
                CargarDatosPersonal(idPersonal);
            }
        }
        else
        {
            // Nuevo
            this.ID_PERSONAL.Value = "0";
            this.Estado.Checked = true;
        }
    }

    private void CargarDatosPersonal(int idPersonal)
    {
        try
        {
            policia.clsaccesodatos servidor = new policia.clsaccesodatos();
            servidor.cadenaconexion = Ruta;
            if (servidor.abrirconexion() == true)
            {
                var dt = servidor.consultar("[dbo].[pr_ListaPersonal]").Tables[0];
                servidor.cerrarconexion();

                var row = dt.AsEnumerable().FirstOrDefault(r => r["ID_PERSONAL"].ToString().Trim() == idPersonal.ToString());
                if (row != null)
                {
                    this.ID_PERSONAL.Value = row["ID_PERSONAL"].ToString().Trim();
                    this.Codigo.Text = row["CODIGO"].ToString().Trim();
                    this.Nombre.Text = row["NOMBRE"].ToString().Trim();
                    this.ApellidoPat.Text = row["APELLIDO PATERNO"].ToString().Trim();
                    this.ApellidoMat.Text = row["APELLIDO MATERNO"].ToString().Trim();
                    this.NroDocIdent.Text = row["NRO. DOC. IDENT."].ToString().Trim();
                    this.Telefono.Text = row["TELEFONO"].ToString().Trim();
                    this.Email.Text = row["EMAIL"].ToString().Trim();
                    this.Estado.Checked = row["ESTADO"].ToString().Trim() == "ACTIVO";

                    SeleccionarDropdownPorTexto(this.TipoDocIdent, row["TIPO DOC. IDENT."].ToString().Trim());
                    SeleccionarDropdownPorTexto(this.Profesion, row["PROFESION"].ToString().Trim());
                    SeleccionarDropdownPorTexto(this.Dependencia, row["DEPENDENCIA"].ToString().Trim());
                    SeleccionarDropdownPorTexto(this.Cargo, row["CARGO"].ToString().Trim());

                    string sedeNom = row["SEDE"].ToString().Trim();
                    string localNom = row["LOCAL"].ToString().Trim();
                    string areaNom = row["AREA"].ToString().Trim();

                    SeleccionarDropdownPorTexto(this.Sede, sedeNom);

                    if (this.Sede.SelectedValue != "-1")
                    {
                        Cargar_Datos(this.ddlLocal, "[dbo].[pr_Obtener_Locales]", "", new Object[] { Convert.ToInt32(this.Sede.SelectedValue) });
                        SeleccionarDropdownPorTexto(this.ddlLocal, localNom);

                        if (this.ddlLocal.SelectedValue != "-1")
                        {
                            Cargar_Datos(this.ddlArea, "[dbo].[pr_Obtener_Areas]", "", new Object[] { Convert.ToInt32(this.ddlLocal.SelectedValue) });
                            SeleccionarDropdownPorTexto(this.ddlArea, areaNom);
                        }
                    }
                }
            }
        }
        catch (Exception)
        {
            // Silenciar errores
        }
    }

    private void SeleccionarDropdownPorTexto(DropDownList ddl, string texto)
    {
        if (string.IsNullOrEmpty(texto)) return;
        foreach (ListItem item in ddl.Items)
        {
            if (item.Text.Trim() == texto.Trim())
            {
                ddl.ClearSelection();
                item.Selected = true;
                return;
            }
        }
    }

    protected void Sede_SelectedIndexChanged(object sender, EventArgs e)
    {
        CargarLocalPorSede();
    }

    protected void ddlLocal_SelectedIndexChanged(object sender, EventArgs e)
    {
        CargarAreaPorLocal();
    }

    private void CargarLocalPorSede()
    {
        if (this.Sede.SelectedValue != "-1")
        {
            Cargar_Datos(this.ddlLocal, "[dbo].[pr_Obtener_Locales]", "", new Object[] { Convert.ToInt32(this.Sede.SelectedValue) });
        }
        else
        {
            this.ddlLocal.Items.Clear();
            this.ddlLocal.Items.Add(new ListItem("Seleccione una opción", "-1"));
        }
        this.ddlArea.Items.Clear();
        this.ddlArea.Items.Add(new ListItem("Seleccione una opción", "-1"));
    }

    private void CargarAreaPorLocal()
    {
        if (this.ddlLocal.SelectedValue != "-1")
        {
            Cargar_Datos(this.ddlArea, "[dbo].[pr_Obtener_Areas]", "", new Object[] { Convert.ToInt32(this.ddlLocal.SelectedValue) });
        }
        else
        {
            this.ddlArea.Items.Clear();
            this.ddlArea.Items.Add(new ListItem("Seleccione una opción", "-1"));
        }
    }

    private bool ValidarCampos()
    {
        if (this.Codigo.Text.Length != 5)
        {
            this.__mensaje.Value = "El código debe tener 5 dígitos.";
            return false;
        }
        if (this.Sede.SelectedValue == "-1" || this.ddlLocal.SelectedValue == "-1" || this.ddlArea.SelectedValue == "-1")
        {
            this.__mensaje.Value = "Debe seleccionar Sede, Local y Área.";
            return false;
        }
        if (this.Dependencia.SelectedValue == "-1")
        {
            this.__mensaje.Value = "Debe seleccionar una Dependencia.";
            return false;
        }
        if (this.Cargo.SelectedValue == "-1")
        {
            this.__mensaje.Value = "Debe seleccionar un Cargo.";
            return false;
        }
        return true;
    }

    protected void btnRegistrar_Click(object sender, EventArgs e)
    {
        if (!ValidarCampos()) return;

        try
        {
            policia.clsaccesodatos servidor = new policia.clsaccesodatos();
            servidor.cadenaconexion = Ruta;
            if (servidor.abrirconexion() == true)
            {
                servidor.consultar("[dbo].[pr_Mantenimiento_Personal]",
                    Convert.ToInt32(this.ID_PERSONAL.Value),
                    this.Codigo.Text.Trim(),
                    this.Nombre.Text.Trim().ToUpper(),
                    this.ApellidoPat.Text.Trim().ToUpper(),
                    this.ApellidoMat.Text.Trim().ToUpper(),
                    Convert.ToInt32(this.TipoDocIdent.SelectedValue),
                    this.NroDocIdent.Text.Trim(),
                    Convert.ToInt32(this.Profesion.SelectedValue),
                    this.Telefono.Text.Trim(),
                    this.Email.Text.Trim(),
                    Convert.ToInt32(this.Sede.SelectedValue),
                    Convert.ToInt32(this.ddlLocal.SelectedValue),
                    Convert.ToInt32(this.ddlArea.SelectedValue),
                    Convert.ToInt32(this.Dependencia.SelectedValue),
                    Convert.ToInt32(this.Cargo.SelectedValue),
                    this.Estado.Checked,
                    "N");
                servidor.cerrarconexion();
                this.__mensaje.Value = "Personal registrado correctamente.";
                this.__pagina.Value = "Personal.aspx";
            }
            else
            {
                servidor.cerrarconexion();
                this.__mensaje.Value = servidor.getMensageError();
            }
        }
        catch (Exception)
        {
            this.__mensaje.Value = "Error al intentar registrar Personal.";
        }
    }

    protected void btnModificar_Click(object sender, EventArgs e)
    {
        if (!ValidarCampos()) return;

        try
        {
            policia.clsaccesodatos servidor = new policia.clsaccesodatos();
            servidor.cadenaconexion = Ruta;
            if (servidor.abrirconexion() == true)
            {
                servidor.consultar("[dbo].[pr_Mantenimiento_Personal]",
                    Convert.ToInt32(this.ID_PERSONAL.Value),
                    this.Codigo.Text.Trim(),
                    this.Nombre.Text.Trim().ToUpper(),
                    this.ApellidoPat.Text.Trim().ToUpper(),
                    this.ApellidoMat.Text.Trim().ToUpper(),
                    Convert.ToInt32(this.TipoDocIdent.SelectedValue),
                    this.NroDocIdent.Text.Trim(),
                    Convert.ToInt32(this.Profesion.SelectedValue),
                    this.Telefono.Text.Trim(),
                    this.Email.Text.Trim(),
                    Convert.ToInt32(this.Sede.SelectedValue),
                    Convert.ToInt32(this.ddlLocal.SelectedValue),
                    Convert.ToInt32(this.ddlArea.SelectedValue),
                    Convert.ToInt32(this.Dependencia.SelectedValue),
                    Convert.ToInt32(this.Cargo.SelectedValue),
                    this.Estado.Checked,
                    "E");
                servidor.cerrarconexion();
                this.__mensaje.Value = "Personal modificado correctamente.";
                this.__pagina.Value = "Personal.aspx";
            }
            else
            {
                servidor.cerrarconexion();
                this.__mensaje.Value = servidor.getMensageError();
            }
        }
        catch (Exception)
        {
            this.__mensaje.Value = "Error al intentar modificar Personal.";
        }
    }

    protected void btnEliminar_Click(object sender, EventArgs e)
    {
        if (!ValidarCampos()) return;

        try
        {
            policia.clsaccesodatos servidor = new policia.clsaccesodatos();
            servidor.cadenaconexion = Ruta;
            if (servidor.abrirconexion() == true)
            {
                servidor.consultar("[dbo].[pr_Mantenimiento_Personal]",
                    Convert.ToInt32(this.ID_PERSONAL.Value),
                    this.Codigo.Text.Trim(),
                    this.Nombre.Text.Trim().ToUpper(),
                    this.ApellidoPat.Text.Trim().ToUpper(),
                    this.ApellidoMat.Text.Trim().ToUpper(),
                    Convert.ToInt32(this.TipoDocIdent.SelectedValue),
                    this.NroDocIdent.Text.Trim(),
                    Convert.ToInt32(this.Profesion.SelectedValue),
                    this.Telefono.Text.Trim(),
                    this.Email.Text.Trim(),
                    Convert.ToInt32(this.Sede.SelectedValue),
                    Convert.ToInt32(this.ddlLocal.SelectedValue),
                    Convert.ToInt32(this.ddlArea.SelectedValue),
                    Convert.ToInt32(this.Dependencia.SelectedValue),
                    Convert.ToInt32(this.Cargo.SelectedValue),
                    this.Estado.Checked,
                    "E");
                servidor.cerrarconexion();
                this.__mensaje.Value = "Personal eliminado correctamente.";
                this.__pagina.Value = "Personal.aspx";
            }
            else
            {
                servidor.cerrarconexion();
                this.__mensaje.Value = servidor.getMensageError();
            }
        }
        catch (Exception)
        {
            this.__mensaje.Value = "Error al intentar eliminar Personal.";
        }
    }

    protected void btnCancelar_Click(object sender, EventArgs e)
    {
        this.Response.Redirect("Personal.aspx");
    }

    public bool VERIFICAR_PERMISOS_DERECHOS_ACCESO_PAGINA_WEB(int _ID_USUARIO, string _PAGINA_WEB, string _DERECHO)
    {
        try
        {
            policia.clsaccesodatos servidor = new policia.clsaccesodatos();
            servidor.cadenaconexion = Ruta;
            if (servidor.abrirconexion() == true)
            {
                DataSet ds = servidor.consultar("[dbo].[pr_Verificar_Permisos_Derechos_Acceso_Pagina_Web]",
                    _ID_USUARIO, _PAGINA_WEB, _DERECHO);
                servidor.cerrarconexion();
                if (ds.Tables[0].Rows.Count > 0)
                {
                    return Convert.ToBoolean(ds.Tables[0].Rows[0][0]);
                }
            }
        }
        catch (Exception) { }
        return false;
    }

    public bool VERIFICAR_PERMISO_ACCESO_PAGINA_WEB(int _ID_USUARIO, string _PAGINA_WEB)
    {
        return VERIFICAR_PERMISOS_DERECHOS_ACCESO_PAGINA_WEB(_ID_USUARIO, _PAGINA_WEB, "");
    }
}