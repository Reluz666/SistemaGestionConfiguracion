using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;

public partial class ElementosConfiguracion : System.Web.UI.Page
{
    private String Ruta = System.Configuration.ConfigurationManager.ConnectionStrings["CadenaConeccion"].ToString();
    Lista _Lista = new Lista();
    DataTable dt;

    private void Cargar_Elementos_Configuracion()
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");

        try
        {
            policia.clsaccesodatos servidor = new policia.clsaccesodatos();
            servidor.cadenaconexion = Ruta;

            if (servidor.abrirconexion() == true)
            {
                dt = servidor.consultar("[dbo].[pr_ReporteElementosConfiguracion]", "", "", "", "", "", "", "", "", "", "", "", "", "", "").Tables[0];

                if (dt.Rows.Count == 0)
                {
                    servidor.cerrarconexion();
                    this.datosJson.Value = "[]";
                    _Lista.ShowMessage(__mensaje, __pagina, "No hay Elementos de Configuracion", "");
                }
                else
                {
                    var lista = new List<object>();
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        lista.Add(new {
                            ID_CI = dt.Rows[i]["ID CI"].ToString().Trim(),
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
                            UBICACION_LOCAL = dt.Rows[i]["UBICACION LOCAL"].ToString().Trim(),
                            DIRECCION_LOCAL = dt.Rows[i]["DIRECCION LOCAL"].ToString().Trim(),
                            AREA = dt.Rows[i]["AREA"].ToString().Trim(),
                            NRO_PISO = dt.Rows[i]["NRO PISO"].ToString().Trim(),
                            NRO_AMBIENTE = dt.Rows[i]["NRO AMBIENTE"].ToString().Trim(),
                            FEC_CREACION_CI = dt.Rows[i]["FEC. CREACION CI"].ToString().Trim(),
                            RESPONSABLE = dt.Rows[i]["RESPONSABLE"].ToString().Trim()
                        });
                    }

                    // Store data for printing
                    IMPRIMIR.Page.Session.Add("Imprimir", new Object[] { "REPORTE_ELEMENTOS_CONFIGURACION", dt, "REPORTE DE ELEMENTOS DE CONFIGURACION" });

                    JavaScriptSerializer serializer = new JavaScriptSerializer();
                    this.datosJson.Value = serializer.Serialize(lista);

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

        // Load dropdown data for printing purposes only
        Cargar_Datos(this.ddltci, "[dbo].[pr_Obtener_Tipos_Elemento_Configuracion_2]", "Error, al intentar recuperar Tipo Elemento Configuracion.");
        if (this.__mensaje.Value.ToString().Trim() != "")
        {
            return;
        }
        Cargar_Datos(this.ddleci, "[dbo].[pr_Obtener_Estado_Elemento_Configuracion]", "Error, al intentar recuperar Estado Elemento Configuracion.");
        if (this.__mensaje.Value.ToString().Trim() != "")
        {
            return;
        }
        Cargar_Datos(this.ddls, "[dbo].[pr_Obtener_Sedes]", "Error, al intentar recuperar Sedes Judiciales.");
        if (this.__mensaje.Value.ToString().Trim() != "")
        {
            return;
        }
        Cargar_Datos(this.ddlr, "[dbo].[pr_Obtener_Usuarios]", "Error, al intentar recuperar Responsables.");
        if (this.__mensaje.Value.ToString().Trim() != "")
        {
            return;
        }

        // Load Elementos de Configuracion data
        Cargar_Elementos_Configuracion();
    }

    private void Cargar_Datos(System.Web.UI.WebControls.DropDownList ddl, String Procedimiento_Almacenado, String Mensaje, params Object[] p)
    {
        try
        {
            policia.clsaccesodatos servidor = new policia.clsaccesodatos();
            servidor.cadenaconexion = Ruta;
            if (servidor.abrirconexion() == true)
            {
                DataTable dt;
                if (p.Length == 0)
                {
                    dt = servidor.consultar(Procedimiento_Almacenado).Tables[0];
                }
                else
                {
                    dt = servidor.consultar(Procedimiento_Almacenado, Convert.ToInt32(p[0])).Tables[0];
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

    protected void ddls_SelectedIndexChanged(object sender, EventArgs e)
    {
        this.__mensaje.Value = "";
        this.__pagina.Value = "";
        this.ddll.Items.Clear();
        this.ddll.Items.Insert(0, "_____SELECCIONE LOCAL_____");
        this.ddll.Items[0].Value = "-1";
        this.ddla.Items.Clear();
        this.ddla.Items.Insert(0, "_____SELECCIONE AREA_____");
        this.ddla.Items[0].Value = "-1";
        int Codigo_Sede = Convert.ToInt32(ddls.SelectedValue);
        if (Codigo_Sede == -1)
        {
            this.__mensaje.Value = "Seleccione Sede Judicial para ver Locales Judiciales";
            this.__pagina.Value = "";
            return;
        }
        Cargar_Datos(this.ddll, "[dbo].[pr_Obtener_Locales]", "Error, al intentar recuperar Locales Judiciales.", new Object[] { Codigo_Sede });
        if (this.__mensaje.Value.ToString().Trim() != "")
        {
            return;
        }
    }

    protected void ddll_SelectedIndexChanged(object sender, EventArgs e)
    {
        this.__mensaje.Value = "";
        this.__pagina.Value = "";
        this.ddla.Items.Clear();
        this.ddla.Items.Insert(0, "_____SELECCIONE AREA_____");
        this.ddla.Items[0].Value = "-1";
        int Codigo_Local = Convert.ToInt32(ddll.SelectedValue);
        if (Codigo_Local == -1)
        {
            this.__mensaje.Value = "Seleccione Local Judicial para ver Areas Judiciales";
            this.__pagina.Value = "";
            return;
        }
        Cargar_Datos(this.ddla, "[dbo].[pr_Obtener_Areas]", "Error, al intentar recuperar Areas Judiciales.", new Object[] { Codigo_Local });
        if (this.__mensaje.Value.ToString().Trim() != "")
        {
            return;
        }
    }
}
