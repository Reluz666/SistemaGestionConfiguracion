using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SeguimientosElementoConfiguracion : System.Web.UI.Page
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
        "SeguimientosElementoConfiguracion.aspx");
        if (rpta == false)
        {
            this.__mensaje.Value = "Ud. no tiene permiso para ACCEDER esta pagina web.";
            this.__pagina.Value = "CerrarSession.aspx";
            return;
        }

        Cargar_Lista_Seguimientos();
    }

    protected void btnNuevoSeguiminetoCIs_Click(object sender, EventArgs e)
    {
        string[] Datos = (string[])Session["__JSAR__"];
        bool rpta = this.VERIFICAR_PERMISOS_DERECHOS_ACCESO_PAGINA_WEB(Convert.ToInt32(Datos[0]),
        "SeguimientosElementoConfiguracion.aspx", "NUEVO");
        if (rpta == false)
        {
            this.__mensaje.Value = "Ud. no esta autorizado para generar un NUEVO seguimiento de elementos de configuracion en esta pagina web.";
            this.__pagina.Value = "CerrarSession.aspx";
            return;
        }

        Session["__SEGUIMIENTO_ELEMENTO_CONFIGURACION__"] = null;
        Response.Clear();
        Response.Redirect("SeguimientoElementoConfiguracion.aspx");
        Response.Flush();
    }

    protected void Enviar_Datos_Seguimiento_Elemento_Configuracion(object sender, EventArgs e)
    {
        System.Web.UI.WebControls.Button b = (System.Web.UI.WebControls.Button)sender;
        String Registro = b.CommandArgument.Trim();
        String[] Datos = Registro.Split(',');
        Session["__SEGUIMIENTO_ELEMENTO_CONFIGURACION__"] = new object[] { Datos[0],
        "Nombre: " + Datos[1] + "   Tipo: " + Datos[2] + "   Nro. Serie: " + Datos[3],
        "Fabricante: " + Datos[4] + "   Marca: " + Datos[5] + "   Modelo: " + Datos[6],
        "Estado: " + Datos[7] + "   Descripcion: " + Datos[8] + "   Sede: " + Datos[9],
        "Local: " + Datos[10] + "   Ubicacion: " + Datos[11] + "   Direccion: " + Datos[12],
        "Area: " + Datos[13] + "   Nro. Piso: " + Datos[14] + "   Nro. Ambiente: " + Datos[15],
        Datos[16],
        Datos[17],
        Datos[18],
        Datos[19],
        Datos[20],
        Datos[21],
        Datos[22],
        Datos[23],
        Datos[24]
       };

        Response.Clear();
        Response.Redirect("SeguimientoElementoConfiguracion.aspx");
        Response.Flush();
    }

    private void Cargar_Lista_Seguimientos()
    {
        try
        {
            policia.clsaccesodatos servidor = new policia.clsaccesodatos();
            servidor.cadenaconexion = Ruta;

            if (servidor.abrirconexion() == true)
            {
                DataTable dt = servidor.consultar("[dbo].[pr_ListaSeguimientoElementosConfiguracion]", "", "", "", "", "", "", "", "", "", "", "", "", "").Tables[0];

                if (dt.Rows.Count > 0)
                {
                    System.Text.StringBuilder sb = new System.Text.StringBuilder();
                    sb.Append("[");

                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        if (i > 0) sb.Append(",");

                        sb.Append("{");
                        sb.Append("\"ID\":\"" + System.Web.HttpUtility.JavaScriptStringEncode(dt.Rows[i]["ID CI"].ToString()) + "\",");
                        sb.Append("\"NOMBRE\":\"" + System.Web.HttpUtility.JavaScriptStringEncode(dt.Rows[i]["NOMBRE CI"].ToString()) + "\",");
                        sb.Append("\"TIPO\":\"" + System.Web.HttpUtility.JavaScriptStringEncode(dt.Rows[i]["TIPO CI"].ToString()) + "\",");
                        sb.Append("\"NRO_SERIE\":\"" + System.Web.HttpUtility.JavaScriptStringEncode(dt.Rows[i]["NRO. SERIE"].ToString()) + "\",");
                        sb.Append("\"DESCRIPCION\":\"" + System.Web.HttpUtility.JavaScriptStringEncode(dt.Rows[i]["DESCRIPCION CI"].ToString()) + "\",");
                        sb.Append("\"SEDE\":\"" + System.Web.HttpUtility.JavaScriptStringEncode(dt.Rows[i]["SEDE"].ToString()) + "\",");
                        sb.Append("\"RESPONSABLE\":\"" + System.Web.HttpUtility.JavaScriptStringEncode(dt.Rows[i]["RESPONSABLE"].ToString()) + "\",");
                        sb.Append("\"FECHA_SEGUIMIENTO\":\"" + System.Web.HttpUtility.JavaScriptStringEncode(dt.Rows[i]["FECHA SEGUIMIENTO"].ToString()) + "\",");
                        sb.Append("\"ESTADO_ACTUAL\":\"" + System.Web.HttpUtility.JavaScriptStringEncode(dt.Rows[i]["ESTADO ACTUAL"].ToString()) + "\"");
                        sb.Append("}");
                    }

                    sb.Append("]");
                    datosJson.Value = sb.ToString();
                }
                else
                {
                    datosJson.Value = "[]";
                }

                servidor.cerrarconexion();
            }
            else
            {
                servidor.cerrarconexion();
                datosJson.Value = "[]";
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
