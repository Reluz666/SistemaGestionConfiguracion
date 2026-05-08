using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ReporteDatosIncorrectosCI : System.Web.UI.Page
{
    private String Ruta = System.Configuration.ConfigurationManager.ConnectionStrings["CadenaConeccion"].ToString();
    Lista _Lista = new Lista();

    private void Cargar_Datos_Incorrectos(string Nombre_CI, string Tipo_CI, string Nro_Serie, string Descripcion_CI, string Sede, string Local, string Area, string Responsable, string Clasificacion_Datos, string Relacion_otros_CIs, string Fecha_Inicio, string Fecha_Fin, string Estado_Actual_CIs, String Mensaje)
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");

        try
        {
            policia.clsaccesodatos servidor = new policia.clsaccesodatos();
            servidor.cadenaconexion = Ruta;

            if (servidor.abrirconexion() == true)
            {
                DataTable dt = servidor.consultar("[dbo].[pr_ReporteDatosIncorrectosCI]", Nombre_CI, Tipo_CI, Nro_Serie, Descripcion_CI, Sede, Local, Area, Responsable, Clasificacion_Datos, Relacion_otros_CIs, Fecha_Inicio, Fecha_Fin, Estado_Actual_CIs).Tables[0];

                if (dt.Rows.Count == 0)
                {
                    servidor.cerrarconexion();
                    _Lista.ShowMessage(__mensaje, __pagina, Mensaje, "");
                }
                else
                {
                    // Calculate stats
                    int Cantidad_CIs_CMDB = Obtener_Cantidad_CIs_CMDB();
                    int CantidadIncorrectos = dt.Rows.Count;
                    int porcentaje = Cantidad_CIs_CMDB > 0 ? (CantidadIncorrectos * 100) / Cantidad_CIs_CMDB : 0;

                    // Build stats object
                    var stats = new
                    {
                        Total_CMDB = Cantidad_CIs_CMDB,
                        Total_Incorrectos = CantidadIncorrectos,
                        Porcentaje = porcentaje + "%"
                    };

                    // Serialize to JSON for client-side rendering
                    var serializer = new JavaScriptSerializer();
                    var lista = new List<object>();

                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        lista.Add(new
                        {
                            AREA = dt.Rows[i]["AREA"].ToString(),
                            TIPO_CI = dt.Rows[i]["TIPO CI"].ToString(),
                            DESCRIPCION_CI = dt.Rows[i]["DESCRIPCION CI"].ToString(),
                            NOMBRE_CI = dt.Rows[i]["NOMBRE CI"].ToString(),
                            FECHA_SEGUIMIENTO = dt.Rows[i]["FECHA SEGUIMIENTO"].ToString()
                        });
                    }

                    this.datosJson.Value = serializer.Serialize(lista);
                    this.datosStatsJson.Value = serializer.Serialize(stats);

                    // Preserve Session for Crystal Reports
                    IMPRIMIR.Page.Session.Add("Imprimir", new Object[] { "REPORTE_DATOS_INCORRECTOS_CIs", dt, "" });

                    servidor.cerrarconexion();
                }
            }
            else
            {
                servidor.cerrarconexion();
                _Lista.ShowMessage(__mensaje, __pagina, servidor.getMensageError(), "../CerrarSession.aspx");
            }
        }
        catch (Exception)
        {
            _Lista.ShowMessage(__mensaje, __pagina, "Error inesperado al intentar conectarnos con el servidor.", "../CerrarSession.aspx");
        }
    }

    private void Listar_Elementos_Configuracion()
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");

        try
        {
            policia.clsaccesodatos servidor = new policia.clsaccesodatos();
            servidor.cadenaconexion = Ruta;

            if (servidor.abrirconexion() == true)
            {
                DataTable dt = servidor.consultar("[dbo].[pr_ReporteDatosIncorrectosCI]", "", "", "", "", "", "", "", "", "", "", "", "", "").Tables[0];

                // Calculate stats
                int Cantidad_CIs_CMDB = Obtener_Cantidad_CIs_CMDB();
                int CantidadIncorrectos = dt.Rows.Count;
                int porcentaje = Cantidad_CIs_CMDB > 0 ? (CantidadIncorrectos * 100) / Cantidad_CIs_CMDB : 0;

                var stats = new
                {
                    Total_CMDB = Cantidad_CIs_CMDB,
                    Total_Incorrectos = CantidadIncorrectos,
                    Porcentaje = porcentaje + "%"
                };

                var serializer = new JavaScriptSerializer();
                var lista = new List<object>();

                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    lista.Add(new
                    {
                        AREA = dt.Rows[i]["AREA"].ToString(),
                        TIPO_CI = dt.Rows[i]["TIPO CI"].ToString(),
                        DESCRIPCION_CI = dt.Rows[i]["DESCRIPCION CI"].ToString(),
                        NOMBRE_CI = dt.Rows[i]["NOMBRE CI"].ToString(),
                        FECHA_SEGUIMIENTO = dt.Rows[i]["FECHA SEGUIMIENTO"].ToString()
                    });
                }

                this.datosJson.Value = serializer.Serialize(lista);
                this.datosStatsJson.Value = serializer.Serialize(stats);
                servidor.cerrarconexion();
            }
            else
            {
                servidor.cerrarconexion();
                _Lista.ShowMessage(__mensaje, __pagina, servidor.getMensageError(), "../CerrarSession.aspx");
            }
        }
        catch (Exception)
        {
            _Lista.ShowMessage(__mensaje, __pagina, "Error inesperado al intentar conectarnos con el servidor.", "../CerrarSession.aspx");
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
    }

    protected void Page_Init(object sender, EventArgs e)
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");

        string[] Datos = (string[])Session["__JSAR__"];

        if (Datos == null)
        {
            this.__mensaje.Value = "Ud. no esta autorizado para ingresar a esta pagina, inicie sesion por favor.";
            this.__pagina.Value = "CerrarSession.aspx";
            return;
        }

        Listar_Elementos_Configuracion();
    }

    private int Obtener_Cantidad_CIs_CMDB()
    {
        int Cantidad = 0;

        try
        {
            policia.clsaccesodatos servidor = new policia.clsaccesodatos();
            servidor.cadenaconexion = Ruta;

            if (servidor.abrirconexion() == true)
            {
                System.Data.DataTable dt = servidor.consultar("[dbo].[prCantidad_CIs_CMDB]").Tables[0];

                if (dt.Rows.Count == 0)
                {
                    servidor.cerrarconexion();
                    this.__mensaje.Value = "Error al intentar obtener fecha del sistema";
                    this.__pagina.Value = "";
                }
                else
                {
                    Cantidad = Convert.ToInt32(dt.Rows[0].ItemArray[0]);
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

        return Cantidad;
    }
}