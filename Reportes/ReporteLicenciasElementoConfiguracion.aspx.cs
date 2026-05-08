using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;

public partial class ReporteLicenciasElementoConfiguracion : System.Web.UI.Page
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
        "ReporteLicenciasElementoConfiguracion.aspx");
        if (rpta == false)
        {
            this.__mensaje.Value = "Ud. no tiene permiso para ACCEDER esta pagina web.";
            this.__pagina.Value = "CerrarSession.aspx";
            return;
        }

        Cargar_Datos_Json();
    }

    private void Cargar_Datos_Json()
    {
        datosJson.Value = "[]";
        try
        {
            DataTable dtLicencias = getLicencias("", "", "", "", "");
            if (dtLicencias != null && dtLicencias.Rows.Count > 0)
            {
                var lista = new List<object>();
                foreach (DataRow row in dtLicencias.Rows)
                {
                    // Get detalles for this license
                    var detalles = GetDetalleLicenciasAsList(Convert.ToInt32(row["ID LI"]));

                    lista.Add(new
                    {
                        ID_LI = row["ID LI"].ToString(),
                        LICENCIA = row["LICENCIA"].ToString(),
                        TIPO_LICENCIA = row["TIPO LICENCIA"].ToString(),
                        NOMBRE = row["NOMBRE"].ToString(),
                        VERSION = row["VERSION"].ToString(),
                        SUSCRIPCION = row["SUSCRIPCION"].ToString(),
                        FEC_INI = row["FEC. INI."].ToString(),
                        FEC_FIN = row["FEC. FIN"].ToString(),
                        PERPETUA = row["PERPETUA"].ToString(),
                        DESCRIPCION = row["DESCRIPCION"].ToString(),
                        VENCE_LICENCIA = row["VENCE LICENCIA"].ToString(),
                        detalles = detalles
                    });
                }
                JavaScriptSerializer serializer = new JavaScriptSerializer();
                datosJson.Value = serializer.Serialize(lista);
            }
        }
        catch (Exception ex)
        {
            datosJson.Value = "[]";
            System.Diagnostics.Debug.WriteLine("ReporteLicencias Error: " + ex.Message);
        }
    }

    private List<Dictionary<string, object>> GetDetalleLicenciasAsList(int ID_LICENCIA_ELE_CONF)
    {
        var detalles = new List<Dictionary<string, object>>();
        try
        {
            policia.clsaccesodatos servidor = new policia.clsaccesodatos();
            servidor.cadenaconexion = Ruta;
            if (servidor.abrirconexion() == true)
            {
                DataTable dt = servidor.consultar("[dbo].[pr_ListaRelacionLicenciaElementosConfiguracion]", ID_LICENCIA_ELE_CONF).Tables[0];
                foreach (DataRow row in dt.Rows)
                {
                    var dict = new Dictionary<string, object>();
                    dict["ID_RE"] = row["ID RE"].ToString();
                    dict["ID_CI"] = row["ID CI"].ToString();
                    dict["TIPO_CI"] = row["TIPO CI"].ToString();
                    dict["NOMBRE_CI"] = row["NOMBRE CI"].ToString();
                    dict["NRO_SERIE"] = row["NRO SERIE"].ToString();
                    dict["PROPIETARIO"] = row["PROPIETARIO"].ToString();
                    dict["DESCRIPCION_CI"] = row["DESCRIPCION CI"].ToString();
                    dict["ID_LICENCIA_ELE_CONF"] = row["ID_LICENCIA_ELE_CONF"].ToString();
                    dict["SEDE"] = row["SEDE"].ToString();
                    dict["LOCAL"] = row["LOCAL"].ToString();
                    dict["AREA"] = row["AREA"].ToString();
                    dict["NRO_PISO"] = row["NRO PISO"].ToString();
                    dict["NRO_AMBIENTE"] = row["NRO AMBIENTE"].ToString();
                    detalles.Add(dict);
                }
                servidor.cerrarconexion();
            }
        }
        catch (Exception)
        {
            // Return empty list on error
        }
        return detalles;
    }

    private DataTable getLicencias(string _TIPOLICENCIA, string _SUSCRIPCIONLICENCIA, string _LICENCIAPERPETUA, string _FECHA_INICIO_SUSCRIPCION_LICENCIA, string _FECHA_FIN_SUSCRIPCION_LICENCIA)
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");
        DataTable dt = null;

        try
        {
            policia.clsaccesodatos servidor = new policia.clsaccesodatos();
            servidor.cadenaconexion = Ruta;
            if (servidor.abrirconexion() == true)
            {
                dt = servidor.consultar("[dbo].[pr_ListaLicencias]", _TIPOLICENCIA, _SUSCRIPCIONLICENCIA, _LICENCIAPERPETUA, _FECHA_INICIO_SUSCRIPCION_LICENCIA, _FECHA_FIN_SUSCRIPCION_LICENCIA).Tables[0];
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
