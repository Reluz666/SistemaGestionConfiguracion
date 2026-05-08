using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;

public partial class ReporteComponentesAsignados : System.Web.UI.Page
{
    private String Ruta = System.Configuration.ConfigurationManager.ConnectionStrings["CadenaConeccion"].ToString();

    Lista _Lista = new Lista();

    private void Listar_Elementos_Configuracion(String NOMBRE_CI, String TIPO_CI, String ESTADO_CI,
    String PROPIETARIO_CI, String DESCRIPCION_CI, String IMPACTO_CI, String SEDE, String LOCAL, String AREA, String NRO_SERIE, String MARCA, String Mensaje)
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");

        try
        {
            policia.clsaccesodatos servidor = new policia.clsaccesodatos();

            servidor.cadenaconexion = Ruta;

            if (servidor.abrirconexion() == true)
            {
                DataTable dt = servidor.consultar("[dbo].[pr_ListaElementosConfiguracionComponenetesAsignados]", NOMBRE_CI, TIPO_CI, ESTADO_CI, PROPIETARIO_CI, DESCRIPCION_CI, IMPACTO_CI, SEDE, LOCAL, AREA, NRO_SERIE, MARCA).Tables[0];

                if (dt.Rows.Count == 0)
                {
                    servidor.cerrarconexion();
                    this.datosJson.Value = "[]";
                    this.datosJsonComponentes.Value = "{}";
                    _Lista.ShowMessage(__mensaje, __pagina, Mensaje, "");
                }
                else
                {
                    // Store for printing
                    Session["CABECERA"] = dt;

                    // Get all component details for each CI
                    var componentesPorCI = new Dictionary<string, List<object>>();

                    // Serialize to JSON with nested componentes
                    var lista = new List<object>();
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        string ciId = dt.Rows[i]["ID CI"].ToString().Trim();

                        // Get component details for this CI
                        DataTable dtComp = getDetalleComponentesCI(Convert.ToInt32(ciId));
                        var componentes = new List<object>();

                        if (dtComp != null && dtComp.Rows.Count > 0)
                        {
                            for (int j = 0; j < dtComp.Rows.Count; j++)
                            {
                                componentes.Add(new {
                                    ID_COMPONENTE = dtComp.Rows[j]["ID COMPONENETE"].ToString().Trim(),
                                    TIPO_COMPONENTE = dtComp.Rows[j]["TIPO COMPONENTE"].ToString().Trim(),
                                    DESCRIPCION = dtComp.Rows[j]["DESCRIPCION"].ToString().Trim(),
                                    FABRICANTE = dtComp.Rows[j]["FABRICANTE"].ToString().Trim(),
                                    NRO_SERIE = dtComp.Rows[j]["NRO SERIE"].ToString().Trim(),
                                    MODELO = dtComp.Rows[j]["MODELO"].ToString().Trim(),
                                    MARCA = dtComp.Rows[j]["MARCA"].ToString().Trim()
                                });
                            }
                        }

                        componentesPorCI[ciId] = componentes;

                        lista.Add(new {
                            ID_CI = ciId,
                            NOMBRE_CI = dt.Rows[i]["NOMBRE CI"].ToString().Trim(),
                            NOMBRE_TIPO_CI = dt.Rows[i]["NOMBRE TIPO CI"].ToString().Trim(),
                            NRO_SERIE = dt.Rows[i]["NRO SERIE"].ToString().Trim(),
                            FABRICANTE_PROVEEDOR = dt.Rows[i]["FABRICANTE / PROVEEDOR"].ToString().Trim(),
                            MARCA = dt.Rows[i]["MARCA"].ToString().Trim(),
                            MODELO = dt.Rows[i]["MODELO"].ToString().Trim(),
                            IP = dt.Rows[i]["IP"].ToString().Trim(),
                            GATEWAY = dt.Rows[i]["GATEWAY"].ToString().Trim(),
                            GRUPO_TRABAJO = dt.Rows[i]["GRUPO TRABAJO"].ToString().Trim(),
                            ESTADO_CI = dt.Rows[i]["ESTADO CI"].ToString().Trim(),
                            PROPIETARIO = dt.Rows[i]["PROPIETARIO"].ToString().Trim(),
                            DESCRIPCION_CI = dt.Rows[i]["DESCRIPCION CI"].ToString().Trim(),
                            IMPACTO_CI = dt.Rows[i]["IMPACTO CI"].ToString().Trim(),
                            NIVEL_PRIORIDAD = dt.Rows[i]["NIVEL PRIORIDAD"].ToString().Trim(),
                            SEDE = dt.Rows[i]["SEDE"].ToString().Trim(),
                            LOCAL = dt.Rows[i]["LOCAL"].ToString().Trim(),
                            AREA = dt.Rows[i]["AREA"].ToString().Trim(),
                            NRO_PISO = dt.Rows[i]["NRO PISO"].ToString().Trim(),
                            NRO_AMBIENTE = dt.Rows[i]["NRO AMBIENTE"].ToString().Trim(),
                            COMPONENTES = componentes
                        });
                    }

                    JavaScriptSerializer serializer = new JavaScriptSerializer();
                    this.datosJson.Value = serializer.Serialize(lista);
                    this.datosJsonComponentes.Value = serializer.Serialize(componentesPorCI);

                    servidor.cerrarconexion();
                }
            }
            else
            {
                servidor.cerrarconexion();
                this.datosJson.Value = "[]";
                this.datosJsonComponentes.Value = "{}";
                _Lista.ShowMessage(__mensaje, __pagina, servidor.getMensageError(), "../CerrarSession.aspx");
            }
        }
        catch (Exception)
        {
            this.datosJson.Value = "[]";
            this.datosJsonComponentes.Value = "{}";
            _Lista.ShowMessage(__mensaje, __pagina, "Error inesperado al intentar conectarnos con el servidor.", "../CerrarSession.aspx");
        }
    }

    private DataTable getDetalleComponentesCI(int ID)
    {
        DataTable dt = null;

        try
        {
            policia.clsaccesodatos servidor = new policia.clsaccesodatos();
            servidor.cadenaconexion = Ruta;
            if (servidor.abrirconexion() == true)
            {
                dt = servidor.consultar("[dbo].[pr_ConsultarDetalleComponentesCI]", ID).Tables[0];
                servidor.cerrarconexion();
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
            this.__pagina.Value = "CerrarSession.aspx";
            return;
        }

        if (Session["OpcionBusqueda"] == null)
        {
            this.Listar_Elementos_Configuracion("", "", "", "", "", "", "", "", "", "", "", "No hay Elementos Configuracion");
        }
        else
        {
            Object[] ob = (Object[])Session["OpcionBusqueda"];
            this.Listar_Elementos_Configuracion(ob[0].ToString().Trim(),
            ob[2].ToString().Trim(),
            ob[4].ToString().Trim(),
            "",
            ob[8].ToString().Trim(),
            "",
            ob[10].ToString().Trim(),
            ob[12].ToString().Trim(),
            ob[14].ToString().Trim(),
            ob[18].ToString().Trim(),
            ob[20].ToString().Trim(),
            "No hay Elementos Configuracion con los criterios seleccionados");
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
             "", false,
             "", false,
             "", false,
             "", false,
             "", false
        };
        Session["OpcionBusqueda"] = ob;

        Response.Clear();
        Response.Redirect("ReporteComponentesAsignados.aspx");
        Response.Flush();

        _Lista.ShowMessage(__mensaje, __pagina, "", "");
    }

    protected void btnActualizarInformacion_Click(object sender, EventArgs e)
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");
        Session["OpcionBusqueda"] = null;
        Response.Clear();
        Response.Redirect("ReporteComponentesAsignados.aspx");
        Response.Flush();
        _Lista.ShowMessage(__mensaje, __pagina, "", "");
    }

    protected void IMPRIMIR_Click(object sender, EventArgs e)
    {
        DataTable dtCIs = (DataTable)Session["CABECERA"];

        if (dtCIs == null || dtCIs.Rows.Count == 0)
        {
            _Lista.ShowMessage(__mensaje, __pagina, "No hay datos para imprimir.", "");
            return;
        }

        DataTable dtCOMPONENTES = new DataTable();
        dtCOMPONENTES.Columns.Add(new DataColumn("ID COMPONENETE", typeof(System.Int32)));
        dtCOMPONENTES.Columns.Add(new DataColumn("TIPO COMPONENTE", typeof(System.String)));
        dtCOMPONENTES.Columns.Add(new DataColumn("DESCRIPCION", typeof(System.String)));
        dtCOMPONENTES.Columns.Add(new DataColumn("FABRICANTE", typeof(System.String)));
        dtCOMPONENTES.Columns.Add(new DataColumn("NRO SERIE", typeof(System.String)));
        dtCOMPONENTES.Columns.Add(new DataColumn("MODELO", typeof(System.String)));
        dtCOMPONENTES.Columns.Add(new DataColumn("MARCA", typeof(System.String)));
        dtCOMPONENTES.Columns.Add(new DataColumn("ID CI", typeof(System.Int32)));

        for (int i = 0; i < dtCIs.Rows.Count; i++)
        {
            DataTable dt = getDetalleComponentesCI(Convert.ToInt32(dtCIs.Rows[i].ItemArray[0].ToString()));

            if (dt != null)
            {
                foreach (DataRow row in dt.Rows)
                {
                    dtCOMPONENTES.ImportRow(row);
                }
            }
        }

        Session["Imprimir"] = new Object[] { "REPORTE_COMPONENTES_CI", dtCIs, "REPORTE DE COMPONENTES DE ELEMENTO CONFIGURACION HARDWARE", dtCOMPONENTES };
    }
}
