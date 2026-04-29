using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class TiposElementoConfiguracion : System.Web.UI.Page
{
    //private String Ruta = "SERVER=JOSE-PC;DATABASE=GCS;Encrypt=False;INTEGRATED SECURITY=True;packet size=4096;";
    private String Ruta = System.Configuration.ConfigurationManager.ConnectionStrings["CadenaConeccion"].ToString();

    System.Web.UI.WebControls.TableRow tRow;
    Lista _Lista = new Lista();
    System.Data.DataTable dt;
    protected void Page_Load(object sender, EventArgs e)
    {
        
    }

    protected void Page_Init(object sender, EventArgs e)
    {
        this.__mensaje.Value = "";
        this.__pagina.Value = "";
        Cargar_Datos(this.ddls, "[dbo].[pr_Obtener_Sedes]", "Error, al intentar recuperar Sedes Judiciales.");
        if (this.__mensaje.Value.ToString().Trim() != "")
        {
            return;
        }
        if (Session["OpcionBusqueda"] == null)
        {
            this.Lista_Locales("", "", "No hay Locales registrados");
        }
        else
        {
            Object[] ob = (Object[])Session["OpcionBusqueda"];
           
            this.cbs.Checked = (bool)ob[1];
            ddls.Enabled = (bool)ob[1];
            for (int i = 0; i < this.ddls.Items.Count; i++)
            {
                if (this.ddls.Items[i].Text == ob[0].ToString().Trim())
                    this.ddls.SelectedIndex = i;
            }
            this.Lista_Locales("",ob[0].ToString().Trim(),
            "No hay Locales con los criterios seleccionados");
        }
    }

    private void ShowMessage(string msg, string paginaweb)
    {
        this.__mensaje.Value = msg;
        this.__pagina.Value = paginaweb;
    }
    private void Lista_Locales(string LOCAL_NOMBRE, string SEDE, string MENSAJE)
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");
        //********************** AGREGADO EN REQUE EL 21-03-2023 ***************************
        _Lista.Limpiar_Tabla(Table_);
        try
        {
            policia.clsaccesodatos servidor = new policia.clsaccesodatos();
            servidor.cadenaconexion = Ruta;
            if (servidor.abrirconexion() == true)
            {
                dt = servidor.consultar("[dbo].[pr_Lista_Locales]", LOCAL_NOMBRE, SEDE).Tables[0];
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
                        for (int j = 0; j < 8; j++)//Cabecera de la tabla
                        {
                            TableCell tCell = new TableCell();
                            switch (j)
                            {
                                case 0:
                                    tCell.Text = dt.Rows[i]["ID LOCAL"].ToString().Trim();
                                    tCell.Visible = false;
                                    tRow.Cells.Add(tCell);
                                    break;
                                case 1:
                                    tCell.Text = dt.Rows[i]["LOCAL CODIGO"].ToString().Trim();
                                    tCell.Visible = true;
                                    tRow.Cells.Add(tCell);
                                    break;
                                case 2:
                                    tCell.Text = dt.Rows[i]["LOCAL NOMBRE"].ToString().Trim();
                                    tCell.Visible = true;
                                    tRow.Cells.Add(tCell);
                                    break;
                                case 3:
                                    tCell.Text = dt.Rows[i]["LOCAL DIRECCION"].ToString().Trim();
                                    tCell.Visible = true;
                                    tRow.Cells.Add(tCell);
                                    break;
                                case 4:
                                    tCell.Text = dt.Rows[i]["SEDE"].ToString().Trim();
                                    tCell.Visible = true;
                                    tRow.Cells.Add(tCell);
                                    break;
                                case 5:
                                    tCell.Text = dt.Rows[i]["ID UBI"].ToString().Trim();
                                    tCell.Visible = false;
                                    tRow.Cells.Add(tCell);
                                    break;
                                case 6:
                                    tCell.Text = dt.Rows[i]["UBICACION GEOGRAFICA"].ToString().Trim();
                                    tCell.Visible = true;
                                    tRow.Cells.Add(tCell);
                                    break;
                                case 7:
                                    System.Web.UI.WebControls.Button b = new System.Web.UI.WebControls.Button();

                                    b.Height = 25;

                                    b.Text = "Local";
                                    b.ToolTip = "Seleccione Local";

                                    b.BackColor = System.Drawing.Color.SpringGreen;

                                    b.BorderStyle = BorderStyle.None;

                                    b.CausesValidation = false;

                                    b.UseSubmitBehavior = false;

                                    //b.PostBackUrl = "~/#";

                                    b.OnClientClick = "LOCAL('" + dt.Rows[i]["ID LOCAL"].ToString() + "','" + dt.Rows[i]["LOCAL CODIGO"].ToString() + "','" + dt.Rows[i]["LOCAL NOMBRE"].ToString() + "','" + dt.Rows[i]["LOCAL DIRECCION"].ToString() + "','" + dt.Rows[i]["SEDE"].ToString() + "','" + dt.Rows[i]["ID UBI"].ToString() + "','" + dt.Rows[i]["UBICACION GEOGRAFICA"].ToString() + "','" + "');";

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

                this.__mensaje.Value = servidor.getMensageError();

                this.__pagina.Value = "CerrarSession.aspx";
            }

        }
        catch (Exception)
        {

            this.__mensaje.Value = "Error inesperado al intentar conectarnos con el servidor.";

            this.__pagina.Value = "CerrarSession.aspx";
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

        Object[] ob;

        bool ok = (cbs.Checked == true ||
        cbs.Checked == true);
        if (ok == false)
        {
            _Lista.ShowMessage(__mensaje, __pagina, "Seleccione opciones para empezar la busqueda.", "");

            return;
        }


        ob = new Object[] {
             Convert.ToInt32(ddls.SelectedValue)==-1?"": ddls.SelectedItem.Text, this.cbs.Checked
        };

        Session["OpcionBusqueda"] = ob;

        Response.Clear();
        Response.Redirect("ventanaLocal.aspx");
        Response.Flush();

        _Lista.ShowMessage(__mensaje, __pagina, "", "");
    }

    protected void btnActualizarInformacion_Click(object sender, EventArgs e)
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");
        Session["OpcionBusqueda"] = null;
        Response.Clear();
        Response.Redirect("ventanaLocal.aspx");
        Response.Flush();
        _Lista.ShowMessage(__mensaje, __pagina, "", "");
    }
}