using System;
using System.Collections.Generic;
using System.Data;
using System.Web;
using System.Web.UI;

public partial class ElementosConfiguracion : System.Web.UI.Page
{
    private String Ruta = System.Configuration.ConfigurationManager.ConnectionStrings["CadenaConeccion"].ToString();

    Lista _Lista = new Lista();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            CargarElementos();
        }
    }

    private void CargarElementos()
    {
        try
        {
            policia.clsaccesodatos servidor = new policia.clsaccesodatos();
            servidor.cadenaconexion = Ruta;

            if (servidor.abrirconexion() == true)
            {
                DataTable dt = servidor.consultar("[dbo].[pr_ListaElementosConfiguracion]", "", "", "", "", "", "", "", "", "").Tables[0];
                servidor.cerrarconexion();

                if (dt.Rows.Count == 0)
                {
                    datosJson.Value = "[]";
                }
                else
                {
                    // Convert DataTable to JSON-like structure
                    System.Text.StringBuilder sb = new System.Text.StringBuilder();
                    sb.Append("[");

                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        if (i > 0) sb.Append(",");

                        DataRow row = dt.Rows[i];
                        sb.Append("{");
                        sb.Append("\"ID_CI\":\"" + JsonEncode(row["ID CI"].ToString()) + "\",");
                        sb.Append("\"NOMBRE_CI\":\"" + JsonEncode(row["NOMBRE CI"].ToString()) + "\",");
                        sb.Append("\"NOMBRE_TIPO_CI\":\"" + JsonEncode(row["NOMBRE TIPO CI"].ToString()) + "\",");
                        sb.Append("\"NRO_SERIE\":\"" + JsonEncode(row["NRO SERIE"].ToString()) + "\",");
                        sb.Append("\"FABRICANTE\":\"" + JsonEncode(row["FABRICANTE / PROVEEDOR"].ToString()) + "\",");
                        sb.Append("\"MARCA\":\"" + JsonEncode(row["MARCA"].ToString()) + "\",");
                        sb.Append("\"MODELO\":\"" + JsonEncode(row["MODELO"].ToString()) + "\",");
                        sb.Append("\"IP\":\"" + JsonEncode(row["IP"].ToString()) + "\",");
                        sb.Append("\"ESTADO_CI\":\"" + JsonEncode(row["ESTADO CI"].ToString()) + "\",");
                        sb.Append("\"PROPIETARIO\":\"" + JsonEncode(row["PROPIETARIO"].ToString()) + "\",");
                        sb.Append("\"DESCRIPCION_CI\":\"" + JsonEncode(row["DESCRIPCION CI"].ToString()) + "\",");
                        sb.Append("\"SEDE\":\"" + JsonEncode(row["SEDE"].ToString()) + "\",");
                        sb.Append("\"LOCAL\":\"" + JsonEncode(row["LOCAL"].ToString()) + "\",");
                        sb.Append("\"AREA\":\"" + JsonEncode(row["AREA"].ToString()) + "\",");
                        sb.Append("\"NRO_PISO\":\"" + JsonEncode(row["NRO PISO"].ToString()) + "\",");
                        sb.Append("\"NRO_AMBIENTE\":\"" + JsonEncode(row["NRO AMBIENTE"].ToString()) + "\"");
                        sb.Append("}");
                    }

                    sb.Append("]");
                    datosJson.Value = sb.ToString();
                }
            }
            else
            {
                servidor.cerrarconexion();
                datosJson.Value = "[]";
                _Lista.ShowMessage(__mensaje, __pagina, servidor.getMensageError(), "CerrarSession.aspx");
            }
        }
        catch (Exception ex)
        {
            datosJson.Value = "[]";
            _Lista.ShowMessage(__mensaje, __pagina, "Error inesperado al intentar conectarnos con el servidor.", "CerrarSession.aspx");
        }
    }

    private string JsonEncode(string str)
    {
        if (string.IsNullOrEmpty(str)) return "";
        return str.Replace("\\", "\\\\")
                   .Replace("\"", "\\\"")
                   .Replace("\n", "\\n")
                   .Replace("\r", "\\r")
                   .Replace("\t", "\\t");
    }
}