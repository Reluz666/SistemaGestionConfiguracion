using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;

public partial class Reporte_De_CIS_Relativo_A_Servicios : System.Web.UI.Page
{
    private String Ruta = System.Configuration.ConfigurationManager.ConnectionStrings["CadenaConeccion"].ToString();

    Lista _Lista = new Lista();

    private int Obtener_Nro_Total_CIs_registrados_relativos_a_servicios_TI_CMDB()
    {
        int Cantidad = 0;

        try
        {
            policia.clsaccesodatos servidor = new policia.clsaccesodatos();
            servidor.cadenaconexion = Ruta;
            if (servidor.abrirconexion() == true)
            {
                System.Data.DataTable dt;
                dt = servidor.consultar("[dbo].[prNro_Total_CIs_registrados_relativos_a_servicios_TI_CMDB.]").Tables[0];
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

    private void Listar_Relacion_Elementos_Configuracion(string PADRE_CI,
    string PADRE_TIPO_CI,
    string PADRE_ESTADO_CI,
    string PADRE_PROPIETARIO_CI,
    string PADRE_DESCRIPCION_CI,
    string PADRE_SEDE,
    string PADRE_LOCAL,
    string PADRE_AREA,
    string MENSAJE)
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");

        try
        {
            policia.clsaccesodatos servidor = new policia.clsaccesodatos();

            servidor.cadenaconexion = Ruta;

            if (servidor.abrirconexion() == true)
            {
                DataTable dt = servidor.consultar("[dbo].[pr_Reporte_De_CIS_Relativo_A_Servicios]",
                PADRE_CI,
                PADRE_TIPO_CI,
                PADRE_ESTADO_CI,
                PADRE_PROPIETARIO_CI,
                PADRE_DESCRIPCION_CI,
                PADRE_SEDE,
                PADRE_LOCAL,
                PADRE_AREA).Tables[0];

                if (dt.Rows.Count == 0)
                {
                    servidor.cerrarconexion();
                    this.datosJson.Value = "[]";
                    _Lista.ShowMessage(__mensaje, __pagina, MENSAJE, "");
                }
                else
                {
                    // Calculate stats first
                    int T = Obtener_Nro_Total_CIs_registrados_relativos_a_servicios_TI_CMDB();
                    int A = dt.Rows.Count;
                    int X = T > 0 ? (A * 100) / T : 0;

                    // Apply deduplication logic (same as original)
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        string ant = dt.Rows[i]["PADRE DESCRIPCION CI"].ToString();
                        for (int j = i + 1; j < dt.Rows.Count; j++)
                        {
                            string sig = dt.Rows[j]["PADRE DESCRIPCION CI"].ToString();
                            if (ant.Equals(sig))
                            {
                                DataRow FilaTabla = dt.Rows[j];
                                FilaTabla.BeginEdit();
                                FilaTabla["PADRE CI"] = "";
                                FilaTabla["PADRE TIPO CI"] = "";
                                FilaTabla.EndEdit();
                                dt.AcceptChanges();
                                A = A - 1;
                            }
                        }
                    }

                    // Recalculate after dedup
                    X = T > 0 ? (A * 100) / T : 0;

                    // Update stats labels
                    this.T.Text = "Nro. Total de los CIs registrados que son relativos a los servicios de TI en la CMDB: " + T.ToString();
                    this.A.Text = "Nro. de CIs relativos a uno o más servicios de TI: " + A.ToString();
                    this.X.Text = "% de CIs relativo a servicios: " + X.ToString();

                    // Serialize to JSON
                    var lista = new List<object>();
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        lista.Add(new {
                            ID_RELACION = dt.Rows[i]["ID_RELACION"].ToString().Trim(),
                            PADRE_ID = dt.Rows[i]["PADRE ID"].ToString().Trim(),
                            PADRE_CI = dt.Rows[i]["PADRE CI"].ToString().Trim(),
                            PADRE_TIPO_CI = dt.Rows[i]["PADRE TIPO CI"].ToString().Trim(),
                            PADRE_NRO_SERIE = dt.Rows[i]["PADRE NRO SERIE"].ToString().Trim(),
                            PADRE_IP = dt.Rows[i]["PADRE IP"].ToString().Trim(),
                            PADRE_GATEWAY = dt.Rows[i]["PADRE GATEWAY"].ToString().Trim(),
                            PADRE_GRUPO_TRABAJO = dt.Rows[i]["PADRE GRUPO TRABAJO"].ToString().Trim(),
                            PADRE_FABRICANTE_PROVEEDOR = dt.Rows[i]["PADRE FABICANTE / PROVEEDOR"].ToString().Trim(),
                            PADRE_ESTADO_CI = dt.Rows[i]["PADRE ESTADO CI"].ToString().Trim(),
                            PADRE_PROPIETARIO_CI = dt.Rows[i]["PADRE PROPIETARIO CI"].ToString().Trim(),
                            PADRE_DESCRIPCION_CI = dt.Rows[i]["PADRE DESCRIPCION CI"].ToString().Trim(),
                            PADRE_NIVEL_PRIORIDAD = dt.Rows[i]["PADRE NIVEL PRIORIDAD"].ToString().Trim(),
                            PADRE_SEDE = dt.Rows[i]["PADRE SEDE"].ToString().Trim(),
                            PADRE_LOCAL = dt.Rows[i]["PADRE LOCAL"].ToString().Trim(),
                            PADRE_AREA = dt.Rows[i]["PADRE AREA"].ToString().Trim(),
                            PADRE_NRO_PISO = dt.Rows[i]["PADRE NRO PISO"].ToString().Trim(),
                            PADRE_NRO_AMBIENTE = dt.Rows[i]["PADRE NRO AMBIENTE"].ToString().Trim(),
                            PADRE_UBICACION = dt.Rows[i]["PADRE UBICACION"].ToString().Trim(),
                            PADRE_DIRECCION_LOCAL = dt.Rows[i]["PADRE DIRECCION LOCAL"].ToString().Trim(),
                            HIJO_ID = dt.Rows[i]["HIJO ID"].ToString().Trim(),
                            HIJO_CI = dt.Rows[i]["HIJO CI"].ToString().Trim(),
                            HIJO_TIPO_CI = dt.Rows[i]["HIJO TIPO CI"].ToString().Trim(),
                            HIJO_NRO_SERIE = dt.Rows[i]["HIJO NRO SERIE"].ToString().Trim(),
                            HIJO_IP = dt.Rows[i]["HIJO IP"].ToString().Trim(),
                            HIJO_GATEWAY = dt.Rows[i]["HIJO GATEWAY"].ToString().Trim(),
                            HIJO_GRUPO_TRABAJO = dt.Rows[i]["HIJO GRUPO TRABAJO"].ToString().Trim(),
                            HIJO_FABRICANTE_PROVEEDOR = dt.Rows[i]["HIJO FABRICANTE / PROVEEDOR"].ToString().Trim(),
                            HIJO_ESTADO_CI = dt.Rows[i]["HIJO ESTADO CI"].ToString().Trim(),
                            HIJO_PROPIETARIO_CI = dt.Rows[i]["HIJO PROPIETARIO CI"].ToString().Trim(),
                            HIJO_DESCRIPCION_CI = dt.Rows[i]["HIJO DESCRIPCION CI"].ToString().Trim(),
                            HIJO_NIVEL_PRIORIDAD = dt.Rows[i]["HIJO NIVEL PRIORIDAD"].ToString().Trim(),
                            HIJO_SEDE = dt.Rows[i]["HIJO SEDE"].ToString().Trim(),
                            HIJO_LOCAL = dt.Rows[i]["HIJO LOCAL"].ToString().Trim(),
                            HIJO_AREA = dt.Rows[i]["HIJO AREA"].ToString().Trim(),
                            HIJO_NRO_PISO = dt.Rows[i]["HIJO NRO PISO"].ToString().Trim(),
                            HIJO_NRO_AMBIENTE = dt.Rows[i]["HIJO NRO AMBIENTE"].ToString().Trim(),
                            HIJO_UBICACION = dt.Rows[i]["HIJO UBICACION"].ToString().Trim(),
                            HIJO_DIRECCION_LOCAL = dt.Rows[i]["HIJO DIRECCION LOCAL"].ToString().Trim(),
                            TIPO_RELACION = dt.Rows[i]["TIPO RELACION"].ToString().Trim()
                        });
                    }

                    JavaScriptSerializer serializer = new JavaScriptSerializer();
                    this.datosJson.Value = serializer.Serialize(lista);

                    // Preserve for Crystal Reports
                    IMPRIMIR.Page.Session.Add("Imprimir", new Object[] { "REPORTE_DE_CIS_RELATIVO_A_SERVICIOS", dt, "REPORTE DE ELEMENTOS DE CONFIGURACION RELATIVO A SERVICIOS", T, A, X });

                    servidor.cerrarconexion();
                }
            }
            else
            {
                servidor.cerrarconexion();
                this.datosJson.Value = "[]";
                _Lista.ShowMessage(__mensaje, __pagina, servidor.getMensageError(), "../CerrarSession.aspx");
            }
        }
        catch (Exception)
        {
            this.datosJson.Value = "[]";
            _Lista.ShowMessage(__mensaje, __pagina, "Error inesperado al intentar conectarnos con el servidor.", "../CerrarSession.aspx");
        }
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
            this.__mensaje.Value = "Ud. no esta autorizado para ingresar a esta página, inicie sesion por favor.";
            this.__pagina.Value = "../CerrarSession.aspx";
            return;
        }

        if (Session["OpcionBusqueda"] == null)
        {
            this.Listar_Relacion_Elementos_Configuracion("",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "No hay relacion de elementos de configuracion");
        }
        else
        {
            Object[] ob = (Object[])Session["OpcionBusqueda"];
            this.Listar_Relacion_Elementos_Configuracion(ob[0].ToString().Trim(),
            ob[2].ToString().Trim(),
            ob[4].ToString().Trim(),
            ob[6].ToString().Trim(),
            ob[8].ToString().Trim(),
            ob[10].ToString().Trim(),
            ob[12].ToString().Trim(),
            ob[14].ToString().Trim(),
            "No hay relacion de elementos de configuracion, con los criterios seleccionados");
        }
    }

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

    protected void lbtnBuscar_Click(object sender, EventArgs e)
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");

        Object[] ob = new Object[] {
             "", false,
             "", false,
             "", false,
             "", false,
             "", false,
             "", false,
             "", false,
             "", false
        };
        Session["OpcionBusqueda"] = ob;

        Response.Clear();
        Response.Redirect("Reporte_De_CIS_Relativo_A_Servicios.aspx");
        Response.Flush();

        _Lista.ShowMessage(__mensaje, __pagina, "", "");
    }

    protected void btnActualizarInformacion_Click(object sender, EventArgs e)
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");
        Session["OpcionBusqueda"] = null;
        Response.Clear();
        Response.Redirect("Reporte_De_CIS_Relativo_A_Servicios.aspx");
        Response.Flush();
        _Lista.ShowMessage(__mensaje, __pagina, "", "");
    }
}
