using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class RelacionesElementosConfiguracion : System.Web.UI.Page
{
    private String Ruta = System.Configuration.ConfigurationManager.ConnectionStrings["CadenaConeccion"].ToString();

    System.Web.UI.WebControls.TableRow tRow;

    Lista _Lista = new Lista();

    private void Listar_Relacion_Elementos_Configuracion(int _ID_CI, string MENSAJE)
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");

        try
        {
            policia.clsaccesodatos servidor = new policia.clsaccesodatos();
            servidor.cadenaconexion = Ruta;

            if (servidor.abrirconexion() == true)
            {
                DataTable dt = servidor.consultar("[dbo].[pr_ListaRelacionCIConOtrosCIS]", _ID_CI).Tables[0];
                servidor.cerrarconexion();

                if (dt.Rows.Count == 0)
                {
                    _Lista.ShowMessage(__mensaje, __pagina, MENSAJE, "");
                    datosJson.Value = "[]";
                }
                else
                {
                    System.Text.StringBuilder sb = new System.Text.StringBuilder();
                    sb.Append("[");

                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        if (i > 0) sb.Append(",");
                        DataRow row = dt.Rows[i];

                        string padreCel = "<font color=blue><b>Nombre: </b></font>" + htmlEncode(row["PADRE CI"].ToString()) + " <font color=blue><b>Tipo:</b></font> " + htmlEncode(row["PADRE TIPO CI"].ToString()) + " <font color=green><b> Nro. Serie: </b></font>" + htmlEncode(row["PADRE NRO SERIE"].ToString()) + " <font color=blue><b>Marca:</b></font> " + htmlEncode(row["PADRE MARCA"].ToString()) + " <font color=blue><b>Modelo:</b></font> " + htmlEncode(row["PADRE MODELO"].ToString()) + " <font color=blue><b>Fabricante / Proveedor:</b></font> " + htmlEncode(row["PADRE FABRICANTE / PROVEEDOR"].ToString()) + " <font color=blue><b>Estado:</b></font> " + htmlEncode(row["PADRE ESTADO CI"].ToString()) + " <font color=blue><b>Propietario:</b></font> " + htmlEncode(row["PADRE PROPIETARIO CI"].ToString()) + "<br>";
                        padreCel += "<font color=blue><b>Descripcion: </b></font>" + htmlEncode(row["PADRE DESCRIPCION CI"].ToString()) + " <font color=blue><b>Prioridad: </b></font>" + htmlEncode(row["PADRE NIVEL PRIORIDAD"].ToString()) + " <font color=blue><b>Sede: </b></font>" + htmlEncode(row["PADRE SEDE"].ToString()) + " <font color=blue><b>Local: </b></font>" + htmlEncode(row["PADRE LOCAL"].ToString()) + "<br>";
                        padreCel += "<font color=red><b>Area: </b></font>" + htmlEncode(row["PADRE AREA"].ToString()) + " <font color=red><b>Nro. Piso: </b></font>" + htmlEncode(row["PADRE NRO PISO"].ToString()) + " <font color=red><b>Nro. Ambiente: </b></font>" + htmlEncode(row["PADRE NRO AMBIENTE"].ToString()) + " <font color=red><b>Ubicacion: </b></font>" + htmlEncode(row["PADRE UBICACION"].ToString()) + "<br>";
                        padreCel += "<font color=red><b>Direccion: </b></font>" + htmlEncode(row["PADRE DIRECCION LOCAL"].ToString());

                        string hijoCel = "<font color=blue><b>Nombre: </b></font>" + htmlEncode(row["HIJO CI"].ToString()) + " <font color=blue><b>Tipo:</b></font> " + htmlEncode(row["HIJO TIPO CI"].ToString()) + " <font color=green><b> Nro. Serie: </b></font>" + htmlEncode(row["HIJO NRO SERIE"].ToString()) + " <font color=blue><b>Marca: </b></font>" + htmlEncode(row["HIJO MARCA"].ToString()) + " <font color=blue><b>Modelo: </b></font>" + htmlEncode(row["HIJO MODELO"].ToString()) + " <font color=blue><b>Fabricante / Proveedor: </b></font>" + htmlEncode(row["HIJO FABRICANTE / PROVEEDOR"].ToString()) + " <font color=blue><b>Estado:</b></font> " + htmlEncode(row["HIJO ESTADO CI"].ToString()) + " <font color=blue><b>Propietario:</b></font> " + htmlEncode(row["HIJO PROPIETARIO CI"].ToString()) + "<br>";
                        hijoCel += "<font color=blue><b>Descripcion: </b></font>" + htmlEncode(row["HIJO DESCRIPCION CI"].ToString()) + " <font color=blue><b>Prioridad: </b></font>" + htmlEncode(row["HIJO NIVEL PRIORIDAD"].ToString()) + " <font color=blue><b>Sede: </b></font>" + htmlEncode(row["HIJO SEDE"].ToString()) + " <font color=blue><b>Local: </b></font>" + htmlEncode(row["HIJO LOCAL"].ToString()) + "<br>";
                        hijoCel += "<font color=red><b>Area: </b></font>" + htmlEncode(row["HIJO AREA"].ToString()) + " <font color=red><b>Nro. Piso: </b></font>" + htmlEncode(row["HIJO NRO PISO"].ToString()) + " <font color=red><b>Nro. Ambiente: </b></font>" + htmlEncode(row["HIJO NRO AMBIENTE"].ToString()) + " <font color=red><b>Ubicacion: </b></font>" + htmlEncode(row["HIJO UBICACION"].ToString()) + "<br>";
                        hijoCel += "<font color=red><b>Direccion: </b></font>" + htmlEncode(row["HIJO DIRECCION LOCAL"].ToString());

                        sb.Append("{");
                        sb.Append("\"ID_RELACION\":\"" + JsonEncode(row["ID_RELACION"].ToString()) + "\",");
                        sb.Append("\"PADRE ID\":\"" + JsonEncode(row["PADRE ID"].ToString()) + "\",");
                        sb.Append("\"PADRE CEL\":\"" + JsonEncode(padreCel) + "\",");
                        sb.Append("\"HIJO ID\":\"" + JsonEncode(row["HIJO ID"].ToString()) + "\",");
                        sb.Append("\"HIJO CEL\":\"" + JsonEncode(hijoCel) + "\",");
                        sb.Append("\"TIPO RELACION\":\"" + JsonEncode(row["TIPO RELACION"].ToString()) + "\"");
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

    private string htmlEncode(string str)
    {
        if (string.IsNullOrEmpty(str)) return "";
        return str.Replace("&", "&amp;").Replace("<", "&lt;").Replace(">", "&gt;").Replace("\"", "&quot;");
    }

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void Page_init(object sender, EventArgs e)
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");
        int _ID_CI = Convert.ToInt32(Request.QueryString.Get("CI").Trim());
        this.Listar_Relacion_Elementos_Configuracion(_ID_CI, "No hay relacion de elementos de configuracion");
    }
}