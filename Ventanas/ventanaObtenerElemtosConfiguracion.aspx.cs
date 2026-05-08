using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Ventanas_ventanaObtenerElemtosConfiguracion : System.Web.UI.Page
{
    private String Ruta = System.Configuration.ConfigurationManager.ConnectionStrings["CadenaConeccion"].ToString();
    System.Web.UI.WebControls.TableRow tRow;

    Lista _Lista = new Lista();

    private void Listar_Elementos_Configuracion()
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");

        try
        {
            policia.clsaccesodatos servidor = new policia.clsaccesodatos();
            servidor.cadenaconexion = Ruta;

            if (servidor.abrirconexion() == true)
            {
                DataTable dt = servidor.consultar("[dbo].[pr_Obtener_Elementos_Configuracion]").Tables[0];
                servidor.cerrarconexion();

                if (dt.Rows.Count == 0)
                {
                    _Lista.ShowMessage(__mensaje, __pagina, "No hay Areas", "");
                    datosJson.Value = "[]";
                }
                else
                {
                    System.Text.StringBuilder sb = new System.Text.StringBuilder();
                    sb.Append("[");

                    string nivel = Request.QueryString.Get("Nivel").Trim();

                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        if (i > 0) sb.Append(",");
                        DataRow row = dt.Rows[i];
                        sb.Append("{");
                        sb.Append("\"ID CI\":\"" + JsonEncode(row["ID CI"].ToString()) + "\",");
                        sb.Append("\"NOMBRE CI\":\"" + JsonEncode(row["NOMBRE CI"].ToString()) + "\",");
                        sb.Append("\"TIPO CI\":\"" + JsonEncode(row["TIPO CI"].ToString()) + "\",");
                        sb.Append("\"ESTADO CI\":\"" + JsonEncode(row["ESTADO CI"].ToString()) + "\",");
                        sb.Append("\"PROPIETARIO\":\"" + JsonEncode(row["PROPIETARIO"].ToString()) + "\",");
                        sb.Append("\"DESCRIPCION CI\":\"" + JsonEncode(row["DESCRIPCION CI"].ToString()) + "\",");
                        sb.Append("\"AREA\":\"" + JsonEncode(row["AREA"].ToString()) + "\",");
                        sb.Append("\"SEDE\":\"" + JsonEncode(row["SEDE"].ToString()) + "\",");
                        sb.Append("\"LOCAL\":\"" + JsonEncode(row["LOCAL"].ToString()) + "\",");
                        sb.Append("\"UBICACION LOCAL\":\"" + JsonEncode(row["UBICACION LOCAL"].ToString()) + "\",");
                        sb.Append("\"DIRECCION LOCAL\":\"" + JsonEncode(row["DIRECCION LOCAL"].ToString()) + "\",");
                        sb.Append("\"NRO PISO\":\"" + JsonEncode(row["NRO PISO"].ToString()) + "\",");
                        sb.Append("\"NRO AMBIENTE\":\"" + JsonEncode(row["NRO AMBIENTE"].ToString()) + "\",");
                        sb.Append("\"NIVEL PRIORIDAD\":\"" + JsonEncode(row["NIVEL PRIORIDAD"].ToString()) + "\",");
                        sb.Append("\"OPCION\":\"" + JsonEncode(nivel) + "\"");
                        sb.Append("}");
                    }

                    sb.Append("]");
                    datosJson.Value = sb.ToString();
                }
            }
            else
            {
                servidor.cerrarconexion();
                _Lista.ShowMessage(__mensaje, __pagina, servidor.getMensageError(), "../CerrarSession.aspx");
                datosJson.Value = "[]";
            }
        }
        catch (Exception)
        {
            _Lista.ShowMessage(__mensaje, __pagina, "Error inesperado al intentar conectarnos con el servidor.", "../CerrarSession.aspx");
            datosJson.Value = "[]";
        }
    }

    private string JsonEncode(string str)
    {
        if (string.IsNullOrEmpty(str)) return "";
        return str.Replace("\\", "\\\\")
                   .Replace("\"", "\\\"")
                   .Replace("\n", "\\n")
                   .Replace("\r", "\\r")
                   .Replace("\t", "\\t")
                   .Replace("<", "\\u003c")
                   .Replace(">", "\\u003e");
    }

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void Page_init(object sender, EventArgs e)
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");
        this.Listar_Elementos_Configuracion();
    }
}