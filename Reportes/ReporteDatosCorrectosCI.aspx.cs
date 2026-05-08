using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ReporteDatosCorrectosCI : System.Web.UI.Page
{
    private String Ruta = System.Configuration.ConfigurationManager.ConnectionStrings["CadenaConeccion"].ToString();
    Lista _Lista = new Lista();

    private void Cargar_Datos_Correctos(String Mensaje)
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");

        try
        {
            policia.clsaccesodatos servidor = new policia.clsaccesodatos();
            servidor.cadenaconexion = Ruta;

            if (servidor.abrirconexion() == true)
            {
                DataTable dt = servidor.consultar("[dbo].[pr_ReporteDatosCorrectosCI]", "", "", "", "", "", "", "", "", "", "", "", "", "").Tables[0];

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
                        string fechaSeg = dt.Rows[i]["FECHA SEGUIMIENTO"].ToString().Trim();
                        lista.Add(new
                        {
                            AREA = dt.Rows[i]["AREA"].ToString(),
                            TIPO_CI = dt.Rows[i]["TIPO CI"].ToString(),
                            DESCRIPCION_CI = dt.Rows[i]["DESCRIPCION CI"].ToString(),
                            NOMBRE_CI = dt.Rows[i]["NOMBRE CI"].ToString(),
                            FECHA_SEGUIMIENTO = fechaSeg != "" ? Convert.ToDateTime(fechaSeg).ToShortDateString() : ""
                        });
                    }

                    this.datosJson.Value = serializer.Serialize(lista);

                    // Preserve Session for Crystal Reports
                    IMPRIMIR.Page.Session.Add("Imprimir", new Object[] { "REPORTE_DATOS_CORRECTOS_CIs", dt, "" });

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

        Cargar_Datos_Correctos("No hay Elementos Configuracion con Datos Correctos");
    }
}