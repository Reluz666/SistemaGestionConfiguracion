using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Ventanas_ventanaObtenerElemtosConfiguracion : System.Web.UI.Page
{
    //private String Ruta = "SERVER=JOSE-PC;DATABASE=GCS;Encrypt=False;INTEGRATED SECURITY=True;packet size=4096;";
    private String Ruta = System.Configuration.ConfigurationManager.ConnectionStrings["CadenaConeccion"].ToString();
    System.Web.UI.WebControls.TableRow tRow;

    Lista _Lista = new Lista();

    private void Listar_Elementos_Configuracion()
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");

        for (int i = 1; i < this.Table_.Rows.Count; i++)
        {
            this.Table_.Rows[i].Cells.Clear();
        }

        try
        {
            policia.clsaccesodatos servidor = new policia.clsaccesodatos();

            servidor.cadenaconexion = Ruta;

            if (servidor.abrirconexion() == true)
            {
                DataTable dt = servidor.consultar("[dbo].[pr_Obtener_Elementos_Configuracion]").Tables[0];

                if (dt.Rows.Count == 0)
                {
                    servidor.cerrarconexion();

                    _Lista.ShowMessage(__mensaje, __pagina, "No hay Areas", "");
                }
                else
                {
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        tRow = new TableRow();

                        for (int j = 0; j < Table_.Rows[i].Cells.Count; j++)//Cabecera de la tabla
                        {
                            TableCell tCell = new TableCell();
                            tRow.BorderColor = System.Drawing.Color.Black;

                            switch (j)
                            {

                                case 0:

                                    tCell.Text = dt.Rows[i]["ID CI"].ToString();

                                    tCell.Visible = false;

                                    tRow.Cells.Add(tCell);

                                    break;

                                case 1:

                                    tCell.Text = dt.Rows[i]["NOMBRE CI"].ToString();

                                    tCell.HorizontalAlign = HorizontalAlign.Left;

                                    //tCell.BackColor = System.Drawing.Color.LemonChiffon;

                                    tCell.Visible = true;

                                    tRow.Cells.Add(tCell);

                                    break;

                                case 2:

                                    tCell.Text = dt.Rows[i]["TIPO CI"].ToString();

                                    tCell.HorizontalAlign = HorizontalAlign.Left;

                                    //tCell.BackColor = System.Drawing.Color.LemonChiffon;

                                    tCell.Visible = true;

                                    tRow.Cells.Add(tCell);

                                    break;

                                case 3:

                                    tCell.Text = dt.Rows[i]["ESTADO CI"].ToString();

                                    tCell.HorizontalAlign = HorizontalAlign.Left;

                                    //tCell.BackColor = System.Drawing.Color.LemonChiffon;

                                    tCell.Visible = true;

                                    tRow.Cells.Add(tCell);

                                    break;

                                case 4:

                                    tCell.Text = dt.Rows[i]["PROPIETARIO"].ToString();

                                    tCell.HorizontalAlign = HorizontalAlign.Left;

                                    //tCell.BackColor = System.Drawing.Color.LemonChiffon;

                                    tCell.Visible = true;

                                    tRow.Cells.Add(tCell);

                                    break;

                                case 5:

                                    tCell.Text = dt.Rows[i]["DESCRIPCION CI"].ToString();

                                    tCell.HorizontalAlign = HorizontalAlign.Left;

                                    //tCell.BackColor = System.Drawing.Color.LemonChiffon;

                                    tCell.Visible = true;

                                    tRow.Cells.Add(tCell);

                                    break;

                                case 6:

                                    tCell.Text = "<b>Area: </b>" + dt.Rows[i]["AREA"].ToString() +
                                    "<b> Sede: </b>" + dt.Rows[i]["SEDE"].ToString() +
                                    "<b> Local: </b>" + dt.Rows[i]["LOCAL"].ToString() +
                                    "<b> Ubicacion: </b>" + dt.Rows[i]["UBICACION LOCAL"].ToString() +
                                    "<b><br> Direccion: </b>" + dt.Rows[i]["DIRECCION LOCAL"].ToString() + 
                                    "<b> Nro. Piso: </b>" + dt.Rows[i]["NRO PISO"].ToString() + 
                                    "<b> Nro. Ambiente: </b>" + dt.Rows[i]["NRO AMBIENTE"].ToString();

                                    tCell.HorizontalAlign = HorizontalAlign.Left;

                                    //tCell.BackColor = System.Drawing.Color.LemonChiffon;

                                    tCell.Visible = true;

                                    tRow.Cells.Add(tCell);

                                    break;

                                case 7:

                                    tCell.Text = dt.Rows[i]["NIVEL PRIORIDAD"].ToString();

                                    tCell.HorizontalAlign = HorizontalAlign.Left;

                                    //tCell.BackColor = System.Drawing.Color.LemonChiffon;

                                    tCell.Visible = true;

                                    tRow.Cells.Add(tCell);

                                    break;

                                case 8:

                                    System.Web.UI.WebControls.Button b = new System.Web.UI.WebControls.Button();

                                    b.Height = 25;

                                    b.Text = "Seleccionar";

                                    b.BackColor = System.Drawing.Color.SpringGreen;

                                    b.BorderStyle = BorderStyle.None;

                                    b.CausesValidation = false;

                                    b.UseSubmitBehavior = false;

                                    //b.PostBackUrl = "~/#";

                                    b.OnClientClick = "ELEMENTO_CONFIGURACION('" + dt.Rows[i]["ID CI"].ToString() + "','" + dt.Rows[i]["NOMBRE CI"].ToString() + "','" + dt.Rows[i]["TIPO CI"].ToString() + "','" + dt.Rows[i]["ESTADO CI"].ToString() + "','" + dt.Rows[i]["PROPIETARIO"].ToString() + "','" + dt.Rows[i]["DESCRIPCION CI"].ToString() + "','" + dt.Rows[i]["AREA"].ToString() + "','" + dt.Rows[i]["SEDE"].ToString() + "','" + dt.Rows[i]["LOCAL"].ToString() + "','" + dt.Rows[i]["UBICACION LOCAL"].ToString() + "','" + dt.Rows[i]["DIRECCION LOCAL"].ToString() + "','" + dt.Rows[i]["NRO PISO"].ToString() + "','" + dt.Rows[i]["NRO AMBIENTE"].ToString() + "','" + dt.Rows[i]["NIVEL PRIORIDAD"].ToString() + "','" + Request.QueryString.Get("Nivel").Trim() + "');";

                                    tCell.HorizontalAlign = HorizontalAlign.Center;

                                    tCell.Controls.Add(b);

                                    tRow.Cells.Add(tCell);

                                    break;

                            }
                        }

                        this.Table_.Rows.Add(tRow);
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