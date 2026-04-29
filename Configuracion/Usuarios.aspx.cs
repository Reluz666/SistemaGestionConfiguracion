using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class Configuracion_Default : System.Web.UI.Page
{
    //private String Ruta = System.Configuration.ConfigurationManager.AppSettings.Get("CadenaConeccion");
    private String Ruta = System.Configuration.ConfigurationManager.ConnectionStrings["CadenaConeccion"].ToString();
    System.Web.UI.WebControls.TableRow tRow;
    Lista _Lista = new Lista();

    private void ListarPersonal()
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");
        for (int i = 1; i < this.TablePersonal.Rows.Count; i++)
        {
            this.TablePersonal.Rows[i].Cells.Clear();
        }
        try
        {
            policia.clsaccesodatos servidor = new policia.clsaccesodatos();
            servidor.cadenaconexion = Ruta;
            if (servidor.abrirconexion() == true)
            {
                DataTable dt = servidor.consultar("[dbo].[pr_ListaUsuarios_2]").Tables[0];
                if (dt.Rows.Count == 0)
                {
                    servidor.cerrarconexion();
                    _Lista.ShowMessage(__mensaje, __pagina, "Nombre a Buscar, no se encuentra registrado", "");
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
                                    tCell.Text = dt.Rows[i]["CARGO"].ToString().Trim();
                                    tCell.Visible = true;
                                    tRow.Cells.Add(tCell);
                                    break;
                                case 2:
                                    tCell.Text = dt.Rows[i]["NOMBRE"].ToString().Trim() + " " + dt.Rows[i]["APEPAT"].ToString().Trim() + " " + dt.Rows[i]["APEMAT"].ToString().Trim();
                                    tCell.Visible = true;
                                    tRow.Cells.Add(tCell);
                                    break;
                                case 3:
                                    tCell.Text = dt.Rows[i]["TELEFONO"].ToString();
                                    tCell.Visible = false;
                                    tRow.Cells.Add(tCell);
                                    break;
                                case 4:
                                    tCell.Text = dt.Rows[i]["EMAIL"].ToString();
                                    tCell.Visible = true;
                                    tRow.Cells.Add(tCell);
                                    break;
                                case 5:
                                    tCell.Text = dt.Rows[i]["LOGIN"].ToString();
                                    tCell.Visible = true;
                                    tRow.Cells.Add(tCell);
                                    break;
                                case 6:
                                    tCell.Text = dt.Rows[i]["PASSWORD"].ToString();
                                    tCell.Visible = true;
                                    tRow.Cells.Add(tCell);
                                    break;
                                case 7:
                                    tCell.Text = dt.Rows[i]["ESTADO"].ToString();
                                    if (tCell.Text.Trim().Equals("INACTIVO"))
                                    {
                                        tCell.ForeColor = System.Drawing.Color.Red;
                                    }
                                    else
                                    {
                                        tCell.ForeColor = System.Drawing.Color.Blue;
                                    }
                                    tCell.Visible = true;
                                    tRow.Cells.Add(tCell);
                                    break;
                                case 8:
                                    //verificar permiso para enviar datos.
                                    string[] Datos = (string[])Session["__JSAR__"];
                                    bool rpta = this.VERIFICAR_PERMISOS_DERECHOS_ACCESO_PAGINA_WEB(Convert.ToInt32(Datos[0]),
                                    "Usuarios.aspx", "GENERAR");

                                    if (rpta == true)
                                    {
                                        System.Web.UI.WebControls.Button b = new System.Web.UI.WebControls.Button();
                                        b.Text = "Generar Permisos";
                                        b.ToolTip = "Seleccione colaborador para generar permisos de acceso al sistema.";
                                        b.OnClientClick = "return Confirmar('¿Desea generar permisos de acceso al sistema para el usuario seleccionado?');";
                                        b.BorderStyle = BorderStyle.None;
                                        b.CausesValidation = false;
                                        b.UseSubmitBehavior = true;
                                        b.CssClass = "btn btn-dark";
                                        b.CommandArgument = dt.Rows[i]["ID"].ToString().Trim() + "," +
                                                            dt.Rows[i]["CARGO"].ToString().Trim() + "," +
                                                            dt.Rows[i]["NOMBRE"].ToString().Trim() + "," +
                                                            dt.Rows[i]["APEPAT"].ToString().Trim() + "," +
                                                            dt.Rows[i]["APEMAT"].ToString().Trim() + "," +
                                                            dt.Rows[i]["TELEFONO"].ToString() + "," +
                                                            dt.Rows[i]["EMAIL"].ToString() + "," +
                                                            dt.Rows[i]["LOGIN"].ToString() + "," +
                                                            dt.Rows[i]["PASSWORD"].ToString() + "," +
                                                            dt.Rows[i]["ESTADO"].ToString();
                                        //b.PostBackUrl = "ejemplo.aspx?CODIGOEJEMPLO=" + dt.Rows[i]["COD EJEMPLO"].ToString() + "&CODIGOSUBTEMA=" + dt.Rows[i]["COD SUBTEMA"].ToString() + "&SUBTEMA=" + dt.Rows[i]["SUB TEMA"].ToString();
                                        b.Click += new System.EventHandler(visualiza_datos_personal);
                                        tCell.HorizontalAlign = HorizontalAlign.Center;
                                        tCell.Controls.Add(b);
                                        tRow.Cells.Add(tCell);
                                    }
                                    else
                                    {
                                        tCell.Text = "SIN PERMISO PARA GENERAR PERMISOS DE ACCESO AL SISTEMA";
                                        tCell.ForeColor = System.Drawing.Color.Red;
                                        tCell.Font.Bold = true;
                                        tCell.Visible = true;
                                        tRow.Cells.Add(tCell);
                                    }
                                    break;
                            }
                        }

                        this.TablePersonal.Rows.Add(tRow);
                    }

                    servidor.cerrarconexion();

                }

            }
            else
            {
                servidor.cerrarconexion();

                this.__mensaje.Value = servidor.getMensageError();

                this.__pagina.Value = "../CerrarSession.aspx";
            }

        }
        catch (Exception)
        {

            this.__mensaje.Value = "Error inesperado al intentar conectarnos con el servidor.";

            this.__pagina.Value = "../CerrarSession.aspx";
        }
    }

    protected void visualiza_datos_personal(object sender, EventArgs e)
    {
        System.Web.UI.WebControls.Button b = (System.Web.UI.WebControls.Button)sender;
        String Registro = b.CommandArgument.Trim();
        String[] DatosPersonal = Registro.Split(',');

        Session["__DatosPersonal__"] = DatosPersonal;

        Response.Clear();
        Response.Redirect("Seguridad.aspx");
        Response.Flush();
    }

   

    protected void Page_Init(object sender, EventArgs e)
    {
        string[] Datos = (string[])Session["__JSAR__"];

        if (Datos == null)
        {

            this.__mensaje.Value = "Ud. no esta autorizado para ingresar a esta página, inicie sesion por favor.";

            this.__pagina.Value = "../CerrarSession.aspx";

            return;

        }

        //verificar permiso para acceder a esta pagina.
        bool rpta = this.VERIFICAR_PERMISO_ACCESO_PAGINA_WEB(Convert.ToInt32(Datos[0]),
        "Usuarios.aspx");
        if (rpta == false)
        {
            this.__mensaje.Value = "Ud. no tiene permiso para ACCEDER esta pagina web.";
            this.__pagina.Value = "../CerrarSession.aspx";
            return;
        }

        ListarPersonal();
       
    }

    protected void Page_Load(object sender, EventArgs e)
    {
       

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