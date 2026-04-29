using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class RelacionesElementosConfiguracion : System.Web.UI.Page
{
    //private String Ruta = "SERVER=JOSE-PC;DATABASE=GCS;Encrypt=False;INTEGRATED SECURITY=True;packet size=4096;";
    private String Ruta = System.Configuration.ConfigurationManager.ConnectionStrings["CadenaConeccion"].ToString();

    System.Web.UI.WebControls.TableRow tRow;

    Lista _Lista = new Lista();

   

    private void Listar_Relacion_Elementos_Configuracion(
    int _ID_CI,
    string MENSAJE)
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
                DataTable dt = servidor.consultar("[dbo].[pr_ListaRelacionCIConOtrosCIS]", _ID_CI).Tables[0];

                if (dt.Rows.Count == 0)
                {
                    servidor.cerrarconexion();

                    _Lista.ShowMessage(__mensaje, __pagina, MENSAJE, "");
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

                                    tCell.Text = dt.Rows[i]["ID_RELACION"].ToString();

                                    tCell.Visible = false;

                                    tRow.Cells.Add(tCell);

                                    break;

                                case 1:

                                    tCell.Text = dt.Rows[i]["PADRE ID"].ToString();

                                    tCell.HorizontalAlign = HorizontalAlign.Left;

                                    //tCell.BackColor = System.Drawing.Color.LemonChiffon;

                                    tCell.Visible = false;

                                    tRow.Cells.Add(tCell);

                                    break;

                                case 2:

                                    tCell.Text = "<font color=blue><b>Nombre: </b>" + dt.Rows[i]["PADRE CI"].ToString() + "</font> &nbsp;&nbsp; <b>Tipo:</b> " + dt.Rows[i]["PADRE TIPO CI"].ToString() + "&nbsp;&nbsp;<font color=green> <b> Nro. Serie: </b>" + dt.Rows[i]["PADRE NRO SERIE"].ToString() + "</font>&nbsp;&nbsp; <b>Marca:</b> " + dt.Rows[i]["PADRE MARCA"].ToString() + "&nbsp;&nbsp; <b>Modelo:</b> " + dt.Rows[i]["PADRE MODELO"].ToString() + "&nbsp;&nbsp; <b>Fabricante / Proveedor:</b> " + dt.Rows[i]["PADRE FABRICANTE / PROVEEDOR"].ToString() +  "&nbsp;&nbsp; <b>Estado:</b> " + dt.Rows[i]["PADRE ESTADO CI"].ToString() + "&nbsp;&nbsp; <b>Propietario:</b> " + dt.Rows[i]["PADRE PROPIETARIO CI"].ToString() +"<BR>";
                                    tCell.Text += "<b>Descripcion: </b>" + dt.Rows[i]["PADRE DESCRIPCION CI"].ToString() + "&nbsp;&nbsp;<b>Prioridad: </b>" + dt.Rows[i]["PADRE NIVEL PRIORIDAD"].ToString() + "&nbsp;&nbsp;<b>Sede: </b>" + dt.Rows[i]["PADRE SEDE"].ToString() + "&nbsp;&nbsp;<b>Local: </b>" + dt.Rows[i]["PADRE LOCAL"].ToString() + "<BR>";
                                    tCell.Text += "<font color=red><b>Area: </b>" + dt.Rows[i]["PADRE AREA"].ToString() + "&nbsp;&nbsp;<b>Nro. Piso: </b>" + dt.Rows[i]["PADRE NRO PISO"].ToString() + "&nbsp;&nbsp;<b>Nro. Ambiente: </b>" + dt.Rows[i]["PADRE NRO AMBIENTE"].ToString() + "&nbsp;&nbsp;<b>Ubicacion: </b>" + dt.Rows[i]["PADRE UBICACION"].ToString() + "</font><BR>";
                                    tCell.Text += "<font color=red><b>Direccion: </b>" + dt.Rows[i]["PADRE DIRECCION LOCAL"].ToString() + "</font>";
                                    tCell.HorizontalAlign = HorizontalAlign.Left;

                                //tCell.BackColor = System.Drawing.Color.LemonChiffon;

                                    tCell.Visible = true;
                                    tRow.Cells.Add(tCell);

                                    break;

                                case 3:

                                    tCell.Text = dt.Rows[i]["HIJO ID"].ToString();

                                    tCell.HorizontalAlign = HorizontalAlign.Left;

                                    //tCell.BackColor = System.Drawing.Color.LemonChiffon;

                                    tCell.Visible = false;

                                    tRow.Cells.Add(tCell);

                                    break;                                

                                case 4:

                                     tCell.Text = "<font color=blue><b>Nombre: </b>" + dt.Rows[i]["HIJO CI"].ToString() + "</font>&nbsp;&nbsp; <b>Tipo:</b> " + dt.Rows[i]["HIJO TIPO CI"].ToString() + "&nbsp;&nbsp;<font color=green> <b> Nro. Serie: </b>" + dt.Rows[i]["HIJO NRO SERIE"].ToString() + "</font>&nbsp;&nbsp;<b> Marca: </b>" + dt.Rows[i]["HIJO MARCA"].ToString() + "&nbsp;&nbsp;<b> Modelo: </b>" + dt.Rows[i]["HIJO MODELO"].ToString() + "&nbsp;&nbsp;<b> Fabricante / Proveedor: </b>" + dt.Rows[i]["HIJO FABRICANTE / PROVEEDOR"].ToString() +  "&nbsp;&nbsp; <b>Estado:</b> " + dt.Rows[i]["HIJO ESTADO CI"].ToString() + "&nbsp;&nbsp; <b>Propietario:</b> " + dt.Rows[i]["HIJO PROPIETARIO CI"].ToString() +"<BR>";
                                     tCell.Text += "<b>Descripcion: </b>" + dt.Rows[i]["HIJO DESCRIPCION CI"].ToString() + "&nbsp;&nbsp;<b>Prioridad: </b>" + dt.Rows[i]["HIJO NIVEL PRIORIDAD"].ToString() + "&nbsp;&nbsp;<b>Sede: </b>" + dt.Rows[i]["HIJO SEDE"].ToString() + "&nbsp;&nbsp;<b>Local: </b>" + dt.Rows[i]["HIJO LOCAL"].ToString() + "<BR>";
                                     tCell.Text += "<font color=red><b>Area: </b>" + dt.Rows[i]["HIJO AREA"].ToString() + "&nbsp;&nbsp;<b>Nro. Piso: </b>" + dt.Rows[i]["HIJO NRO PISO"].ToString() + "&nbsp;&nbsp;<b>Nro. Ambiente: </b>" + dt.Rows[i]["HIJO NRO AMBIENTE"].ToString() + "&nbsp;&nbsp;<b>Ubicacion: </b>" + dt.Rows[i]["HIJO UBICACION"].ToString() + "</font> <BR>";
                                     tCell.Text += "<font color=red><b>Direccion: </b>" + dt.Rows[i]["HIJO DIRECCION LOCAL"].ToString() + "</font>" ;
                                     tCell.HorizontalAlign = HorizontalAlign.Left;

                                    //tCell.BackColor = System.Drawing.Color.LemonChiffon;

                                    tCell.Visible = true;

                                    tRow.Cells.Add(tCell);

                                    break;

                                case 5:

                                    tCell.Text = dt.Rows[i]["TIPO RELACION"].ToString();

                                    tCell.HorizontalAlign = HorizontalAlign.Left;

                                    //tCell.BackColor = System.Drawing.Color.LemonChiffon;

                                    tCell.Visible = true;

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

    protected void Page_init(object sender, EventArgs e) {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");
        int _ID_CI = Convert.ToInt32(Request.QueryString.Get("CI").Trim());
        this.Listar_Relacion_Elementos_Configuracion(_ID_CI,           
            "No hay relacion de elementos de configuracion");
        


    }   
    
}