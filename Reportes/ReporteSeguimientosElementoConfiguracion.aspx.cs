using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;

public partial class ReporteSeguimientosElementoConfiguracion : System.Web.UI.Page
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
        "ReporteSeguimientosElementoConfiguracion.aspx");
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
            policia.clsaccesodatos servidor = new policia.clsaccesodatos();
            servidor.cadenaconexion = Ruta;

            if (servidor.abrirconexion() == true)
            {
                DataTable dt = servidor.consultar("[dbo].[pr_ReporteSeguimientoElementosConfiguracion]",
                    "", "", "", "", "", "", "", "", "", "", "", "", "").Tables[0];

                if (dt.Rows.Count > 0)
                {
                    var lista = new List<object>();
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        lista.Add(new
                        {
                            ID_CI = dt.Rows[i]["ID CI"].ToString(),
                            NOMBRE_CI = dt.Rows[i]["NOMBRE CI"].ToString(),
                            TIPO_CI = dt.Rows[i]["TIPO CI"].ToString(),
                            NRO_SERIE = dt.Rows[i]["NRO. SERIE"].ToString(),
                            FABRICANTE = dt.Rows[i]["FABRICANTE / PROVEEDOR"].ToString(),
                            MARCA = dt.Rows[i]["MARCA"].ToString(),
                            MODELO = dt.Rows[i]["MODELO"].ToString(),
                            ESTADO = dt.Rows[i]["ESTADO"].ToString(),
                            DESCRIPCION = dt.Rows[i]["DESCRIPCION CI"].ToString(),
                            SEDE = dt.Rows[i]["SEDE"].ToString(),
                            LOCAL = dt.Rows[i]["LOCAL"].ToString(),
                            UBICACION = dt.Rows[i]["UBICACION"].ToString(),
                            DIRECCION = dt.Rows[i]["DIRECCION"].ToString(),
                            AREA = dt.Rows[i]["AREA"].ToString(),
                            NRO_PISO = dt.Rows[i]["NRO PISO"].ToString(),
                            NRO_AMBIENTE = dt.Rows[i]["NRO AMBIENTE"].ToString(),
                            RESPONSABLE = dt.Rows[i]["RESPONSABLE"].ToString(),
                            FECHA_SEGUIMIENTO = dt.Rows[i]["FECHA SEGUIMIENTO"].ToString(),
                            CLASIFICACION_DATOS = dt.Rows[i]["CLASIFICACION DATOS"].ToString(),
                            ESTADO_ACTUAL = dt.Rows[i]["ESTADO ACTUAL"].ToString(),
                            RELACION_CIS = dt.Rows[i]["RELACION CIS"].ToString(),
                            CUMPLE_POLITICA = dt.Rows[i]["CUMPLE POLITICA GESTION CONIGURACION ORGANIZACION"].ToString(),
                            OBSERVACION = dt.Rows[i]["OBSERVACION"].ToString(),
                            ID_SEGUIMIENTO = dt.Rows[i]["ID SEGUIMIENTO"].ToString(),
                            ID_RESPONSABLE = dt.Rows[i]["ID RESPONSABLE"].ToString()
                        });
                    }
                    JavaScriptSerializer serializer = new JavaScriptSerializer();
                    datosJson.Value = serializer.Serialize(lista);
                }
                servidor.cerrarconexion();
            }
            else
            {
                servidor.cerrarconexion();
            }
        }
        catch (Exception)
        {
            datosJson.Value = "[]";
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
