using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ReporteCIsSeguidos : System.Web.UI.Page
{
    private String Ruta = System.Configuration.ConfigurationManager.ConnectionStrings["CadenaConeccion"].ToString();
    Lista _Lista = new Lista();

    private void Cargar_CIs_Seguidos(string Nombre_CI, string Tipo_CI, string Nro_Serie, string Descripcion_CI, string Sede, string Local, string Area, string Responsable, string Clasificacion_Datos, string Relacion_otros_CIs, string Fecha_Inicio, string Fecha_Fin, string Estado_Actual_CIs, String Mensaje)
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");

        try
        {
            policia.clsaccesodatos servidor = new policia.clsaccesodatos();
            servidor.cadenaconexion = Ruta;

            if (servidor.abrirconexion() == true)
            {
                DataTable dt = servidor.consultar("[dbo].[pr_ReporteCIsSeguidos]", Nombre_CI, Tipo_CI, Nro_Serie, Descripcion_CI, Sede, Local, Area, Responsable, Clasificacion_Datos, Relacion_otros_CIs, Fecha_Inicio, Fecha_Fin, Estado_Actual_CIs).Tables[0];

                if (dt.Rows.Count == 0)
                {
                    servidor.cerrarconexion();
                    _Lista.ShowMessage(__mensaje, __pagina, Mensaje, "");
                }
                else
                {
                    // Serialize to JSON for client-side rendering
                    var serializer = new JavaScriptSerializer();
                    var lista = new List<object>();

                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        string nroPiso = dt.Rows[i]["NRO PISO"].ToString();
                        string nroAmbiente = dt.Rows[i]["NRO AMBIENTE"].ToString();
                        string fechaSeg = dt.Rows[i]["FECHA SEGUIMIENTO"].ToString().Trim();

                        lista.Add(new
                        {
                            AREA = dt.Rows[i]["AREA"].ToString(),
                            NRO_PISO = nroPiso,
                            NRO_AMBIENTE = nroAmbiente,
                            TIPO_CI = dt.Rows[i]["TIPO CI"].ToString(),
                            DESCRIPCION_CI = dt.Rows[i]["DESCRIPCION CI"].ToString(),
                            NOMBRE_CI = dt.Rows[i]["NOMBRE CI"].ToString(),
                            ESTADO_ACTUAL = dt.Rows[i]["ESTADO ACTUAL"].ToString(),
                            OBSERVACION = dt.Rows[i]["OBSERVACION"].ToString(),
                            FECHA_SEGUIMIENTO = fechaSeg != "" ? Convert.ToDateTime(fechaSeg).ToShortDateString() : ""
                        });
                    }

                    this.datosJson.Value = serializer.Serialize(lista);

                    // Preserve Session for Crystal Reports
                    IMPRIMIR.Page.Session.Add("Imprimir", new Object[] { "REPORTE_CIs_SEGUIDOS", dt, "" });

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
                DataTable dt = servidor.consultar("[dbo].[pr_ReporteCIsSeguidos]", "", "", "", "", "", "", "", "", "", "", "", "", "").Tables[0];

                var serializer = new JavaScriptSerializer();
                var lista = new List<object>();

                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    string nroPiso = dt.Rows[i]["NRO PISO"].ToString();
                    string nroAmbiente = dt.Rows[i]["NRO AMBIENTE"].ToString();
                    string fechaSeg = dt.Rows[i]["FECHA SEGUIMIENTO"].ToString().Trim();

                    lista.Add(new
                    {
                        AREA = dt.Rows[i]["AREA"].ToString(),
                        NRO_PISO = nroPiso,
                        NRO_AMBIENTE = nroAmbiente,
                        TIPO_CI = dt.Rows[i]["TIPO CI"].ToString(),
                        DESCRIPCION_CI = dt.Rows[i]["DESCRIPCION CI"].ToString(),
                        NOMBRE_CI = dt.Rows[i]["NOMBRE CI"].ToString(),
                        ESTADO_ACTUAL = dt.Rows[i]["ESTADO ACTUAL"].ToString(),
                        OBSERVACION = dt.Rows[i]["OBSERVACION"].ToString(),
                        FECHA_SEGUIMIENTO = fechaSeg != "" ? Convert.ToDateTime(fechaSeg).ToShortDateString() : ""
                    });
                }

                this.datosJson.Value = serializer.Serialize(lista);
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
}