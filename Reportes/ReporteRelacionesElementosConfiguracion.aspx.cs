using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;

public partial class ReporteRelacionesElementosConfiguracion : System.Web.UI.Page
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
        "ReporteRelacionesElementosConfiguracion.aspx");
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
                DataTable dt = servidor.consultar("[dbo].[pr_ListaRelacionElementosConfiguracion]",
                "", "", "", "", "", "", "", "").Tables[0];

                if (dt.Rows.Count > 0)
                {
                    var lista = new List<object>();
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        lista.Add(new
                        {
                            ID_RELACION = dt.Rows[i]["ID_RELACION"].ToString(),
                            PADRE_ID = dt.Rows[i]["PADRE ID"].ToString(),
                            PADRE_CI = dt.Rows[i]["PADRE CI"].ToString(),
                            PADRE_TIPO_CI = dt.Rows[i]["PADRE TIPO CI"].ToString(),
                            PADRE_ESTADO_CI = dt.Rows[i]["PADRE ESTADO CI"].ToString(),
                            PADRE_PROPIETARIO_CI = dt.Rows[i]["PADRE PROPIETARIO CI"].ToString(),
                            PADRE_DESCRIPCION_CI = dt.Rows[i]["PADRE DESCRIPCION CI"].ToString(),
                            PADRE_SEDE = dt.Rows[i]["PADRE SEDE"].ToString(),
                            PADRE_LOCAL = dt.Rows[i]["PADRE LOCAL"].ToString(),
                            PADRE_AREA = dt.Rows[i]["PADRE AREA"].ToString(),
                            PADRE_NRO_SERIE = dt.Rows[i]["PADRE NRO SERIE"].ToString(),
                            PADRE_IP = dt.Rows[i]["PADRE IP"].ToString(),
                            PADRE_GATEWAY = dt.Rows[i]["PADRE GATEWAY"].ToString(),
                            PADRE_GRUPO_TRABAJO = dt.Rows[i]["PADRE GRUPO TRABAJO"].ToString(),
                            PADRE_FABRICANTE = dt.Rows[i]["PADRE FABICANTE / PROVEEDOR"].ToString(),
                            PADRE_PRIORIDAD = dt.Rows[i]["PADRE NIVEL PRIORIDAD"].ToString(),
                            PADRE_UBICACION = dt.Rows[i]["PADRE UBICACION"].ToString(),
                            PADRE_DIRECCION = dt.Rows[i]["PADRE DIRECCION LOCAL"].ToString(),
                            PADRE_NRO_PISO = dt.Rows[i]["PADRE NRO PISO"].ToString(),
                            PADRE_NRO_AMBIENTE = dt.Rows[i]["PADRE NRO AMBIENTE"].ToString(),
                            HIJO_ID = dt.Rows[i]["HIJO ID"].ToString(),
                            HIJO_CI = dt.Rows[i]["HIJO CI"].ToString(),
                            HIJO_TIPO_CI = dt.Rows[i]["HIJO TIPO CI"].ToString(),
                            HIJO_ESTADO_CI = dt.Rows[i]["HIJO ESTADO CI"].ToString(),
                            HIJO_PROPIETARIO_CI = dt.Rows[i]["HIJO PROPIETARIO CI"].ToString(),
                            HIJO_DESCRIPCION_CI = dt.Rows[i]["HIJO DESCRIPCION CI"].ToString(),
                            HIJO_SEDE = dt.Rows[i]["HIJO SEDE"].ToString(),
                            HIJO_LOCAL = dt.Rows[i]["HIJO LOCAL"].ToString(),
                            HIJO_AREA = dt.Rows[i]["HIJO AREA"].ToString(),
                            HIJO_NRO_SERIE = dt.Rows[i]["HIJO NRO SERIE"].ToString(),
                            HIJO_IP = dt.Rows[i]["HIJO IP"].ToString(),
                            HIJO_GATEWAY = dt.Rows[i]["HIJO GATEWAY"].ToString(),
                            HIJO_GRUPO_TRABAJO = dt.Rows[i]["HIJO GRUPO TRABAJO"].ToString(),
                            HIJO_FABRICANTE = dt.Rows[i]["HIJO FABRICANTE / PROVEEDOR"].ToString(),
                            HIJO_PRIORIDAD = dt.Rows[i]["HIJO NIVEL PRIORIDAD"].ToString(),
                            HIJO_UBICACION = dt.Rows[i]["HIJO UBICACION"].ToString(),
                            HIJO_DIRECCION = dt.Rows[i]["HIJO DIRECCION LOCAL"].ToString(),
                            HIJO_NRO_PISO = dt.Rows[i]["HIJO NRO PISO"].ToString(),
                            HIJO_NRO_AMBIENTE = dt.Rows[i]["HIJO NRO AMBIENTE"].ToString(),
                            TIPO_RELACION = dt.Rows[i]["TIPO RELACION"].ToString()
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
