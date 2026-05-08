using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;

public partial class LicenciasElementoConfiguracion : System.Web.UI.Page
{
    private String Ruta = System.Configuration.ConfigurationManager.ConnectionStrings["CadenaConeccion"].ToString();
    Lista _Lista = new Lista();

    protected void Page_Load(object sender, EventArgs e)
    {
    }

    protected void Page_Init(object sender, EventArgs e)
    {
        string[] Datos = (string[])Session["__JSAR__"];

        if (Datos == null)
        {
            this.__mensaje.Value = "Ud. no esta autorizado para ingresar a esta página, inicie sesion por favor.";
            this.__pagina.Value = "CerrarSession.aspx";
            return;
        }

        bool rpta = this.VERIFICAR_PERMISO_ACCESO_PAGINA_WEB(Convert.ToInt32(Datos[0]),
        "LicenciasElementoConfiguracion.aspx");
        if (rpta == false)
        {
            this.__mensaje.Value = "Ud. no tiene permiso para ACCEDER esta pagina web.";
            this.__pagina.Value = "CerrarSession.aspx";
            return;
        }

        Cargar_Lista_Json();
    }

    private void Cargar_Lista_Json()
    {
        datosJson.Value = "[]"; // Default value
        try
        {
            DataTable dt = getLicencias("", "", "", "", "");
            if (dt != null && dt.Rows.Count > 0)
            {
                var lista = new List<object>();
                foreach (DataRow row in dt.Rows)
                {
                    lista.Add(new
                    {
                        LICENCIA = row["LICENCIA"].ToString(),
                        TIPO_LICENCIA = row["TIPO LICENCIA"].ToString(),
                        NOMBRE = row["NOMBRE"].ToString(),
                        VERSION = row["VERSION"].ToString(),
                        SUSCRIPCION = row["SUSCRIPCION"].ToString(),
                        FEC_INI = row["FEC. INI."].ToString(),
                        FEC_FIN = row["FEC. FIN"].ToString(),
                        PERPETUA = row["PERPETUA"].ToString(),
                        VENCE_LICENCIA = row["VENCE LICENCIA"].ToString()
                    });
                }
                JavaScriptSerializer serializer = new JavaScriptSerializer();
                string json = serializer.Serialize(lista);
                datosJson.Value = json;
                System.Diagnostics.Debug.WriteLine("Licencias JSON generated: " + json.Length + " chars, " + lista.Count + " records");
            }
            else
            {
                datosJson.Value = "[]";
                System.Diagnostics.Debug.WriteLine("Licencias: No rows returned from getLicencias");
            }
        }
        catch (Exception ex)
        {
            datosJson.Value = "[]";
            System.Diagnostics.Debug.WriteLine("Licencias Error: " + ex.Message);
        }
    }

    protected void Enviar_Datos_Licencia(object sender, EventArgs e)
    {
        System.Web.UI.WebControls.Button b = (System.Web.UI.WebControls.Button)sender;
        String Registro = b.CommandArgument.Trim();
        String[] Datos = Registro.Split(',');
        Session["__CABECERA_LICENCIA__"] = new object[] { Datos[0],
        Datos[1],
        Datos[2],
        Datos[3],
        Datos[4],
        Datos[5],
        Datos[6],
        Datos[7].ToLower(),
        Datos[8]
       };

        DataTable dt = getDetalleLicencias(Convert.ToInt32(Datos[0]));
        Session["_DET_RELACION_LICENCIA_CI"] = dt;

        Response.Clear();
        Response.Redirect("LicenciaElementoConfiguracion.aspx");
        Response.Flush();
    }

    protected void btnEleiminarLiecencias_Click(object sender, EventArgs e)
    {
        string[] Datos = (string[])Session["__JSAR__"];
        bool rpta = this.VERIFICAR_PERMISOS_DERECHOS_ACCESO_PAGINA_WEB(Convert.ToInt32(Datos[0]),
        "LicenciasElementoConfiguracion.aspx", "ELIMINAR");
        if (rpta == false)
        {
            this.__mensaje.Value = "Ud. no esta autorizado para eliminar datos en esta pagina web.";
            this.__pagina.Value = "CerrarSession.aspx";
            return;
        }

        Button btn = (Button)sender;
        int idLicencia = Convert.ToInt32(btn.CommandArgument);
        try
        {
            policia.clsaccesodatos servidor = new policia.clsaccesodatos();
            servidor.cadenaconexion = Ruta;
            if (servidor.abrirconexiontrans() == true){
                servidor.ejecutar("[dbo].[pr_MatenimientoLicenciaElementoConfiguracion]",
                false,
                idLicencia,
                null,
                null,
                null,
                null,
                null,
                null,
                null,
                null,
                "E",
                0, "");
                if (servidor.getRespuesta() == 1){
                   servidor.cerrarconexiontrans();
                   _Lista.ShowMessage(__mensaje, __pagina, servidor.getMensaje(), "LicenciasElementoConfiguracion.aspx");
                }
                else{
                    servidor.cancelarconexiontrans();
                    _Lista.ShowMessage(__mensaje, __pagina, servidor.getMensaje(), "");
                }
            }
            else{
                servidor.cancelarconexiontrans();
                _Lista.ShowMessage(__mensaje, __pagina, servidor.getMensageError(), "CerrarSession.aspx");
            }
        }
        catch (Exception)
        {
            _Lista.ShowMessage(__mensaje, __pagina, "Error inesperado al intentar conectarnos con el servidor.", "");
        }
    }

    private DataTable getLicencias(string _TIPOLICENCIA, string _SUSCRIPCIONLICENCIA, string _LICENCIAPERPETUA, string _FECHA_INICIO_SUSCRIPCION_LICENCIA, string _FECHA_FIN_SUSCRIPCION_LICENCIA)
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");
        DataTable dt = null;

        try
        {
            policia.clsaccesodatos servidor = new policia.clsaccesodatos();
            servidor.cadenaconexion = Ruta;
            if (servidor.abrirconexion() == true) {
                dt = servidor.consultar("[dbo].[pr_ListaLicencias]", _TIPOLICENCIA, _SUSCRIPCIONLICENCIA, _LICENCIAPERPETUA, _FECHA_INICIO_SUSCRIPCION_LICENCIA, _FECHA_FIN_SUSCRIPCION_LICENCIA).Tables[0];
                if(dt.Rows.Count==0) {
                    this.__mensaje.Value = "No hay licencias con el criterio o criterios seleccionados.";
                    this.__pagina.Value = "";
                }
            }
            else{
                servidor.cerrarconexion();
                this.__mensaje.Value = servidor.getMensageError();
                this.__pagina.Value = "CerrarSession.aspx";
            }
        }
        catch (Exception){
            this.__mensaje.Value = "Error inesperado al intentar conectarnos con el servidor.";
            this.__pagina.Value = "CerrarSession.aspx";
        }
        return dt;
    }

    private DataTable getDetalleLicencias(int ID_LICENCIA_ELE_CONF)
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");
        DataTable dt = null;

        try
        {
            policia.clsaccesodatos servidor = new policia.clsaccesodatos();
            servidor.cadenaconexion = Ruta;
            if (servidor.abrirconexion() == true)
            {
                dt = servidor.consultar("[dbo].[pr_ListaRelacionLicenciaElementosConfiguracion]", ID_LICENCIA_ELE_CONF).Tables[0];
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
        return dt;
    }

    protected void btnNuevaLicencia_Click(object sender, EventArgs e)
    {
        string[] Datos = (string[])Session["__JSAR__"];
        bool rpta = this.VERIFICAR_PERMISOS_DERECHOS_ACCESO_PAGINA_WEB(Convert.ToInt32(Datos[0]),
        "LicenciasElementoConfiguracion.aspx", "NUEVO");
        if (rpta == false)
        {
            this.__mensaje.Value = "Ud. no esta autorizado para GENERAR UNA NUEVA LICENCIA en esta pagina web.";
            this.__pagina.Value = "CerrarSession.aspx";
            return;
        }

        Session["__CABECERA_LICENCIA__"] = null;
        Session["_DET_RELACION_LICENCIA_CI"] = null;
        Response.Clear();
        Response.Redirect("LicenciaElementoConfiguracion.aspx");
        Response.Flush();
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