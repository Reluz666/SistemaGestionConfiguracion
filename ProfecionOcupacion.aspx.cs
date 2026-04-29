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
    //private String Ruta = "SERVER=JOSE-PC;DATABASE=GCS;Encrypt=False;INTEGRATED SECURITY=True;packet size=4096;";
    private String Ruta = System.Configuration.ConfigurationManager.ConnectionStrings["CadenaConeccion"].ToString();
    System.Web.UI.WebControls.TableRow tRow;
    Lista _Lista = new Lista();
    System.Data.DataTable dt;

   
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
        "ProfecionOcupacion.aspx");
        if (rpta == false)
        {
            this.__mensaje.Value = "Ud. no tiene permiso para ACCEDER esta pagina web.";
            this.__pagina.Value = "CerrarSession.aspx";
            return;
        }

        Lista_Profesiones_Ocupaciones();
    }

    protected void Page_Load(object sender, EventArgs e)
    {

        if (Convert.ToInt32(this.Id_prof_ocup.Value.Trim()) == 0)
        {
            this.btnRegistrar.Visible = true;
            this.btnCancelar.Visible = true;
            oculta(false);
        }
    }


    private void Matenimiento_Profesion_Ocupacion(int _Id_prof_ocup,
        string _Prof_Ocup,
        string _Descripcion_prof_ocup,

        string operacion)
    {
        policia.clsaccesodatos servidor = new policia.clsaccesodatos();
        servidor.cadenaconexion = Ruta;
        try
        {
            servidor.cadenaconexion = Ruta;
            if (servidor.abrirconexiontrans() == true)
            {
                servidor.ejecutar("[dbo].[pr_MatenimientoProfesionOcupacion]",
                                    false,
                                    _Id_prof_ocup,
                                    _Prof_Ocup.Trim(),
                                    _Descripcion_prof_ocup.Trim(),
                                    operacion,
                                    0, "");
                if (servidor.getRespuesta() == 1)
                {
                    servidor.cerrarconexiontrans();
                    ShowMessage(servidor.getMensaje(), "ProfecionOcupacion.aspx");
                }
                else
                {
                    servidor.cancelarconexiontrans();
                    ShowMessage(servidor.getMensaje(), "ProfecionOcupacion.aspx");
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
    private void Lista_Profesiones_Ocupaciones()
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");
        //********************** AGREGADO EN REQUE EL 21-03-2023 ***************************
        _Lista.Limpiar_Tabla(TableUsuario);
        try
        {
            policia.clsaccesodatos servidor = new policia.clsaccesodatos();
            servidor.cadenaconexion = Ruta;
            if (servidor.abrirconexion() == true)
            {
                dt = servidor.consultar("[dbo].[pr_Lista_Profesiones_Ocupaciones]").Tables[0];
                if (dt.Rows.Count == 0)
                {
                    servidor.cerrarconexion();
                    _Lista.ShowMessage(__mensaje, __pagina, "No hay Profesiones / Ocupaciones registradas.", "");
                }
                else
                {
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        tRow = new TableRow();
                        for (int j = 0; j < 9; j++)//Cabecera de la tabla
                        {
                            TableCell tCell = new TableCell();
                            switch (j)
                            {
                                case 0:
                                    tCell.Text = dt.Rows[i]["ID"].ToString().Trim();
                                    tCell.Visible = false;
                                    tRow.Cells.Add(tCell);
                                    break;
                                case 1:
                                    tCell.Text = dt.Rows[i]["NOMBRE"].ToString().Trim();
                                    tCell.Visible = true;
                                    tRow.Cells.Add(tCell);
                                    break;
                                case 2:
                                    tCell.Text = dt.Rows[i]["DESCRIPCION"].ToString().Trim();
                                    tCell.Visible = true;
                                    tRow.Cells.Add(tCell);
                                    break;                               
                                case 3:
                                    //verificar permiso para enviar datos.
                                    string[] Datos = (string[])Session["__JSAR__"];
                                    bool rpta = this.VERIFICAR_PERMISOS_DERECHOS_ACCESO_PAGINA_WEB(Convert.ToInt32(Datos[0]),
                                    "ProfecionOcupacion.aspx", "SELECCIONAR");

                                    if (rpta == true)
                                    {
                                        System.Web.UI.WebControls.Button b = new System.Web.UI.WebControls.Button();
                                        b.Text = "PROFESION/OCUPACION";
                                        b.ToolTip = "Seleccione Profesion / Ocupacion";
                                        b.BorderStyle = BorderStyle.None;
                                        b.CausesValidation = false;
                                        b.UseSubmitBehavior = true;
                                        b.CssClass = "btn btn-dark";
                                        b.CommandArgument = dt.Rows[i]["ID"].ToString().Trim() + "," +
                                                            dt.Rows[i]["NOMBRE"].ToString().Trim() + "," +
                                                            dt.Rows[i]["DESCRIPCION"].ToString().Trim();
                                        //b.PostBackUrl = "ejemplo.aspx?CODIGOEJEMPLO=" + dt.Rows[i]["COD EJEMPLO"].ToString() + "&CODIGOSUBTEMA=" + dt.Rows[i]["COD SUBTEMA"].ToString() + "&SUBTEMA=" + dt.Rows[i]["SUB TEMA"].ToString();
                                        b.Click += new System.EventHandler(visualiza_datos_profesion_ocupacion);
                                        tCell.HorizontalAlign = HorizontalAlign.Center;
                                        tCell.Controls.Add(b);
                                        tRow.Cells.Add(tCell);
                                    }
                                    else
                                    {
                                        tCell.Text = "SIN PERMISO PARA ESTA OPCION";
                                        tCell.ForeColor = System.Drawing.Color.Red;
                                        tCell.Font.Bold = true;
                                        tCell.Visible = true;
                                        tRow.Cells.Add(tCell);
                                    }
                                    break;


                            }
                        }

                        this.TableUsuario.Rows.Add(tRow);
                    }

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

    protected void visualiza_datos_profesion_ocupacion(object sender, EventArgs e)
    {
        this.__mensaje.Value = "";
        this.__pagina.Value = "";
        System.Web.UI.WebControls.Button b = (System.Web.UI.WebControls.Button)sender;
        String Registro = b.CommandArgument.Trim();
        String[] Datos = Registro.Split(',');
        this.Id_prof_ocup.Value = Datos[0];
        this.Prof_Ocup.Text = Datos[1];
        this.Descripcion_prof_ocup.Text = Datos[2];
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

        //verificar permiso para REGISTRAR datos.
        string[] Datos = (string[])Session["__JSAR__"];
        bool rpta = this.VERIFICAR_PERMISOS_DERECHOS_ACCESO_PAGINA_WEB(Convert.ToInt32(Datos[0]),
        "ProfecionOcupacion.aspx", "NUEVO");
        if (rpta == false)
        {
            this.__mensaje.Value = "Ud. no esta autorizado para registrar datos en esta pagina web.";
            this.__pagina.Value = "CerrarSession.aspx";
            return;
        }

        Boolean ok;
        ok = rfvProf_Ocup.IsValid;
        if (ok == false)
        {
            return;
        }

        Matenimiento_Profesion_Ocupacion(Convert.ToInt32(this.Id_prof_ocup.Value.Trim()),

            this.Prof_Ocup.Text.Trim(),
            this.Descripcion_prof_ocup.Text.Trim(),


            "N");
    }

    protected void btnModificar_Click(object sender, EventArgs e)
    {
        this.__mensaje.Value = "";
        this.__pagina.Value = "";

        //verificar permiso para REGISTRAR datos.
        string[] Datos = (string[])Session["__JSAR__"];
        bool rpta = this.VERIFICAR_PERMISOS_DERECHOS_ACCESO_PAGINA_WEB(Convert.ToInt32(Datos[0]),
        "ProfecionOcupacion.aspx", "MODIFICAR");
        if (rpta == false)
        {
            this.__mensaje.Value = "Ud. no esta autorizado para MODIFICAR datos en esta pagina web.";
            this.__pagina.Value = "CerrarSession.aspx";
            return;
        }

        Boolean ok;
        ok = rfvProf_Ocup.IsValid;

        if (ok == false)
        {
            return;
        }

        Matenimiento_Profesion_Ocupacion(Convert.ToInt32(this.Id_prof_ocup.Value.Trim()),

            this.Prof_Ocup.Text.Trim(),
            this.Descripcion_prof_ocup.Text.Trim(),

            "M");
    }

    protected void btnEliminar_Click(object sender, EventArgs e)
    {
        this.__mensaje.Value = "";
        this.__pagina.Value = "";

        //verificar permiso para eliminar datos.
        string[] Datos = (string[])Session["__JSAR__"];
        bool rpta = this.VERIFICAR_PERMISOS_DERECHOS_ACCESO_PAGINA_WEB(Convert.ToInt32(Datos[0]),
        "ProfecionOcupacion.aspx", "ELIMINAR");
        if (rpta == false)
        {
            this.__mensaje.Value = "Ud. no esta autorizado para eliminar datos en esta pagina web.";
            this.__pagina.Value = "CerrarSession.aspx";
            return;
        }

        Boolean ok;
        ok = rfvProf_Ocup.IsValid;

        if (ok == false)
        {
            return;
        }
        Matenimiento_Profesion_Ocupacion(Convert.ToInt32(this.Id_prof_ocup.Value.Trim()),

            this.Prof_Ocup.Text.Trim(),
            this.Descripcion_prof_ocup.Text.Trim(),

            "E");
    }

    protected void btnCancelar_Click(object sender, EventArgs e)
    {
        //verificar permiso para eliminar datos.
        string[] Datos = (string[])Session["__JSAR__"];
        bool rpta = this.VERIFICAR_PERMISOS_DERECHOS_ACCESO_PAGINA_WEB(Convert.ToInt32(Datos[0]),
        "ProfecionOcupacion.aspx", "CANCELAR");
        if (rpta == false)
        {
            this.__mensaje.Value = "Ud. no esta autorizado para CANCELAR datos en esta pagina web.";
            this.__pagina.Value = "CerrarSession.aspx";
            return;
        }

        this.Response.Redirect("ProfecionOcupacion.aspx");
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