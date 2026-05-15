using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{
    private String Ruta = System.Configuration.ConfigurationManager.ConnectionStrings["CadenaConeccion"].ToString();

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

    private void CargarEstadisticas()
    {
        try
        {
            policia.clsaccesodatos servidor = new policia.clsaccesodatos();
            servidor.cadenaconexion = Ruta;

            if (servidor.abrirconexion() == true)
            {
                // Total Elementos de Configuración
                DataTable dtEC = servidor.consultar("SELECT COUNT(*) FROM ELEMENTOS_CONFIGURACION").Tables[0];
                statElementos.InnerText = dtEC.Rows[0][0].ToString();

                // Total Relaciones
                DataTable dtRel = servidor.consultar("SELECT COUNT(*) FROM RELACION_ELEMENTO_CONFIGURACION").Tables[0];
                statRelaciones.InnerText = dtRel.Rows[0][0].ToString();

                // Total Licencias (activas)
                DataTable dtLic = servidor.consultar("SELECT COUNT(*) FROM LICENCIA_ELEMENTO_CONFIGURACION WHERE LICENCIA_PERPETUA = 1 OR FECHA_FIN >= GETDATE()").Tables[0];
                statLicencias.InnerText = dtLic.Rows[0][0].ToString();

                // Total Personal activo
                DataTable dtPers = servidor.consultar("SELECT COUNT(*) FROM Personal WHERE Estado_Personal = 1").Tables[0];
                statPersonal.InnerText = dtPers.Rows[0][0].ToString();

                servidor.cerrarconexion();
            }
            else
            {
                statElementos.InnerText = "--";
                statRelaciones.InnerText = "--";
                statLicencias.InnerText = "--";
                statPersonal.InnerText = "--";
            }
        }
        catch (Exception)
        {
            statElementos.InnerText = "--";
            statRelaciones.InnerText = "--";
            statLicencias.InnerText = "--";
            statPersonal.InnerText = "--";
        }
    }

    private void MostrarError(string mensaje)
    {
        string script = string.Format("alert('Error: {0}');", mensaje.Replace("'", "\\'"));
        ScriptManager.RegisterStartupScript(this, GetType(), "ErrorStats", script, true);
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        string[] Datos = (string[])Session["__JSAR__"];

        if (Datos == null)
        {

            this.__mensaje.Value = "Ud. no esta autorizado para ingresar a esta página, inicie sesion por favor.";

            this.__pagina.Value = "CerrarSession.aspx";

            return;

        }

        //verificar permiso para acceder a esta pagina.
        bool rpta = this.VERIFICAR_PERMISO_ACCESO_PAGINA_WEB(Convert.ToInt32(Datos[0]),
        "Menu.aspx");
        if (rpta == false)
        {
            this.__mensaje.Value = "Ud. no tiene permiso para ACCEDER esta pagina web.";
            this.__pagina.Value = "CerrarSession.aspx";
            return;
        }

        // Mostrar nombre de usuario en el dashboard
        string nombreUsuario = Datos[1].Trim() + " " + Datos[2].Trim() + " " + Datos[3].Trim();
        string cargo = Datos[9].Trim();
        this.lblUsuario.Text = nombreUsuario + " | " + cargo;

        CargarEstadisticas();
    }
}