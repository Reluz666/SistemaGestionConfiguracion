using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;

public partial class ReporteElementosConfiguracion : System.Web.UI.Page
{
    private String Ruta = System.Configuration.ConfigurationManager.ConnectionStrings["CadenaConeccion"].ToString();
    Lista _Lista = new Lista();

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
            this.__mensaje.Value = "Error inesperado al intentar conectarnos con el servidor.";
            this.__pagina.Value = "";
        }
    }

    private List<Dictionary<string, string>> Listar_Elementos_Configuracion(String NOMBRE_CI, String TIPO_CI, String ESTADO_CI,
    String PROPIETARIO_CI, String DESCRIPCION_CI, String IMPACTO_CI, String SEDE, String LOCAL, String AREA, String RESPONSABLE, String NIVEL_PRIORIDAD, String MARCA, String MODELO, String FECHA_INICIO_CREACION_CI, String FECHA_FIN_CREACION_CI, String Mensaje)
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");
        var result = new List<Dictionary<string, string>>();

        try
        {
            policia.clsaccesodatos servidor = new policia.clsaccesodatos();
            servidor.cadenaconexion = Ruta;

            if (servidor.abrirconexion() == true)
            {
                DataTable dt = servidor.consultar("[dbo].[pr_ReporteElementosConfiguracion]", NOMBRE_CI, TIPO_CI, ESTADO_CI, PROPIETARIO_CI, DESCRIPCION_CI, IMPACTO_CI, SEDE, LOCAL, AREA, RESPONSABLE, NIVEL_PRIORIDAD, MARCA, MODELO, FECHA_INICIO_CREACION_CI, FECHA_FIN_CREACION_CI).Tables[0];

                if (dt.Rows.Count == 0)
                {
                    servidor.cerrarconexion();
                    _Lista.ShowMessage(__mensaje, __pagina, Mensaje, "");
                }
                else
                {
                    // Store for Crystal Reports printing
                    this.Session.Add("Imprimir", new Object[] { "REPORTE_ELEMENTOS_CONFIGURACION", dt, "REPORTE DE ELEMENTOS DE CONFIGURACION" });

                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        var row = new Dictionary<string, string>();
                        row["ID CI"] = dt.Rows[i]["ID CI"].ToString();
                        row["NOMBRE CI"] = dt.Rows[i]["NOMBRE CI"].ToString();
                        row["NOMBRE TIPO CI"] = dt.Rows[i]["NOMBRE TIPO CI"].ToString();
                        row["NRO SERIE"] = dt.Rows[i]["NRO SERIE"].ToString();
                        row["FABRICANTE / PROVEEDOR"] = dt.Rows[i]["FABRICANTE / PROVEEDOR"].ToString();
                        row["MARCA"] = dt.Rows[i]["MARCA"].ToString();
                        row["MODELO"] = dt.Rows[i]["MODELO"].ToString();
                        row["IP"] = dt.Rows[i]["IP"].ToString();
                        row["GATEWAY"] = dt.Rows[i]["GATEWAY"].ToString();
                        row["GRUPO TRABAJO"] = dt.Rows[i]["GRUPO TRABAJO"].ToString();
                        row["ESTADO CI"] = dt.Rows[i]["ESTADO CI"].ToString();
                        row["PROPIETARIO"] = dt.Rows[i]["PROPIETARIO"].ToString();
                        row["DESCRIPCION CI"] = dt.Rows[i]["DESCRIPCION CI"].ToString();
                        row["IMPACTO CI"] = dt.Rows[i]["IMPACTO CI"].ToString();
                        row["NIVEL PRIORIDAD"] = dt.Rows[i]["NIVEL PRIORIDAD"].ToString();
                        row["SEDE"] = dt.Rows[i]["SEDE"].ToString();
                        row["LOCAL"] = dt.Rows[i]["LOCAL"].ToString();
                        row["UBICACION LOCAL"] = dt.Rows[i]["UBICACION LOCAL"].ToString();
                        row["DIRECCION LOCAL"] = dt.Rows[i]["DIRECCION LOCAL"].ToString();
                        row["AREA"] = dt.Rows[i]["AREA"].ToString();
                        row["NRO PISO"] = dt.Rows[i]["NRO PISO"].ToString();
                        row["NRO AMBIENTE"] = dt.Rows[i]["NRO AMBIENTE"].ToString();
                        row["FEC. CREACION CI"] = dt.Rows[i]["FEC. CREACION CI"].ToString();
                        row["RESPONSABLE"] = dt.Rows[i]["RESPONSABLE"].ToString();
                        result.Add(row);
                    }
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

        return result;
    }

    protected void Page_Load(object sender, EventArgs e)
    {
    }

    protected void Page_init(object sender, EventArgs e)
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");

        string[] Datos = (string[])Session["__JSAR__"];

        if (Datos == null)
        {
            this.__mensaje.Value = "Ud. no esta autorizado para ingresar a esta pagina, inicie sesion por favor.";
            this.__pagina.Value = "CerrarSession.aspx";
            return;
        }

        // Load all data for client-side search and pagination
        var data = this.Listar_Elementos_Configuracion("", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "No hay Elementos Configuracion");
        var serializer = new JavaScriptSerializer();
        this.datosJson.Value = serializer.Serialize(data);
    }
}
