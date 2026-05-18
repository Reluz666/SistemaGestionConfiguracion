using System;
using System.Collections.Generic;
using System.Data;
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


    System.Web.UI.WebControls.TextBox tb;
    System.Web.UI.WebControls.DropDownList ddl;

    String msg = "";

    int k = 0;


    private void Consultar_Elementos_Configuracion(int _Id_CI)
    {
        System.Data.DataTable dt = null;

        try
        {
            policia.clsaccesodatos servidor = new policia.clsaccesodatos();
            servidor.cadenaconexion = Ruta;
            if (servidor.abrirconexion() == true)
            {
               
               
                dt = servidor.consultar("[dbo].[pr_ConsultarElementosConfiguracion]", _Id_CI).Tables[0];
               
                if (dt.Rows.Count == 0)
                {
                    servidor.cerrarconexion();
                    this.__mensaje.Value = "";
                    this.__pagina.Value = "";
                }
                else
                {
                    lblNombreCI.Text = dt.Rows[0]["NOMBRE CI"].ToString();
                    lblTipoCI.Text = dt.Rows[0]["NOMBRE TIPO CI"].ToString();
                    lblNroSerie.Text = dt.Rows[0]["NRO. SERIE"].ToString();
                    lblMarcaModelo.Text = dt.Rows[0]["MARCA"].ToString() + " / " + dt.Rows[0]["MODELO"].ToString();
                    lblSedeLocal.Text = dt.Rows[0]["SEDE"].ToString() + " / " + dt.Rows[0]["LOCAL"].ToString();
                    lblArea.Text = dt.Rows[0]["AREA"].ToString();
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

    private System.Data.DataTable _Consultar_Componente_CI(int _Id_CI)
    {
        System.Data.DataTable dt=null;

        try
        {
            policia.clsaccesodatos servidor = new policia.clsaccesodatos();
            servidor.cadenaconexion = Ruta;
            if (servidor.abrirconexion() == true)
            {
                dt = servidor.consultar("[dbo].[pr_ConsultarComponenteCI]", _Id_CI).Tables[0];
                
                if (dt.Rows.Count == 0)
                {
                    servidor.cerrarconexion();
                }
                else
                {
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
        return dt;
    }
    protected void Page_Load(object sender, EventArgs e)
    {
       
    }

    protected void Page_Init(object sender, EventArgs e)
    {
        this.__mensaje.Value = "";
        this.__pagina.Value = "";

        string[] Datos = (string[])Session["__JSAR__"];

        if (Datos == null)
        {

            this.__mensaje.Value = "Ud. no esta autorizado para ingresar a esta página, inicie sesion por favor.";

            this.__pagina.Value = "CerrarSession.aspx";

            return;

        }

        //verificar permiso para acceder a esta pagina.
        bool rpta = this.VERIFICAR_PERMISO_ACCESO_PAGINA_WEB(Convert.ToInt32(Datos[0]),
        "ComponenteCI.aspx");
        if (rpta == false)
        {
            this.__mensaje.Value = "Ud. no tiene permiso para ACCEDER esta pagina web.";
            this.__pagina.Value = "CerrarSession.aspx";
            return;
        }

        int Codigo_CI = Convert.ToInt32(Request.QueryString.Get("IDCI").Trim());
        Consultar_Elementos_Configuracion(Codigo_CI);
        DataTable dt=_Consultar_Componente_CI(Codigo_CI);//16
        if(dt==null) {
            if (this.__mensaje.Value.ToString().Trim() != "")
            {
                return;
            }
        }
        Lista_Tipo_Componentes_CI(dt,"No hay Tipos Componente para mostrar");

        if(dt.Rows.Count==0) {
            this.__mensaje.Value = "Elemento de Configuracion no Tiene Componenetes Asignados";
            this.__pagina.Value = "";
        }



    }
    protected void Page_PreRender(object sender, EventArgs e)
    {
        
    }

    private void ShowMessage(string msg, string paginaweb)
    {
        this.__mensaje.Value = msg;
        this.__pagina.Value = paginaweb;
    }
    private void Lista_Tipo_Componentes_CI(DataTable _T,string MENSAJE)
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");
        //********************** AGREGADO EN REQUE EL 21-03-2023 ***************************
        _Lista.Limpiar_Tabla(Table_);
        int ok = 0;

        try
        {
            policia.clsaccesodatos servidor = new policia.clsaccesodatos();
            servidor.cadenaconexion = Ruta;
            if (servidor.abrirconexion() == true)
            {
                dt = servidor.consultar("[dbo].[pr_Obtener_Tipo_Componentes_CI]").Tables[0];
                if (dt.Rows.Count == 0)
                {
                    servidor.cerrarconexion();
                    _Lista.ShowMessage(__mensaje, __pagina, MENSAJE, "");
                }
                else
                {

                
                    
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        string x = dt.Rows[i]["NOMBRE"].ToString().Trim();
                        for (int ii = 0; ii < _T.Rows.Count; ii++) {
                            string y = _T.Rows[ii]["NOMBRE"].ToString().Trim();
                            if(x==y) {
                                k = ii;
                                ok = 1;
                                break;
                            }else {
                                ok = 0;
                            }
                        }
                       
                        tRow = new TableRow();
                        for (int j = 0; j < Table_.Rows[i].Cells.Count; j++)//Cabecera de la tabla
                        {
                            TableCell tCell = new TableCell();
                            switch (j)
                            {
                                case 0:
                                    tCell.Text = dt.Rows[i]["ID"].ToString().Trim();
                                    tCell.Visible = false;
                                    tRow.Cells.Add(tCell);
                                    break;
                                case 1:
                                    tCell.Text = dt.Rows[i]["NOMBRE"].ToString().Trim();
                                    tCell.Visible = true;
                                    tRow.Cells.Add(tCell);
                                    break;
                                case 2:
                                    tb = new System.Web.UI.WebControls.TextBox();
                                    if (ok == 1)
                                    {
                                        tb.Text = _T.Rows[k]["DESCRIPCION"].ToString().Trim(); ;
                                    }
                                    tb.CssClass = "form-control input-sm";
                                    tCell.Controls.Add(tb);
                                    tRow.Cells.Add(tCell);
                                    break;
                                case 3:
                                    tb = new System.Web.UI.WebControls.TextBox();
                                    if (ok == 1)
                                    {
                                        tb.Text = _T.Rows[k]["FABRICANTE"].ToString().Trim(); ;
                                    }
                                    tb.CssClass = "form-control input-sm";
                                    tCell.Controls.Add(tb);
                                    tRow.Cells.Add(tCell);
                                    break;
                                case 4:
                                    tb = new System.Web.UI.WebControls.TextBox();
                                    if (ok == 1)
                                    {
                                        tb.Text = _T.Rows[k]["NRO SERIE"].ToString().Trim(); ;
                                    }
                                    tb.CssClass = "form-control input-sm";
                                    tCell.Controls.Add(tb);
                                    tRow.Cells.Add(tCell);
                                    break;
                                case 5:
                                    ddl = new System.Web.UI.WebControls.DropDownList();
                                    Cargar_Datos(ddl, "[dbo].[pr_Obtener_Marcas]", "Error, al intentar recuperar Marcas Elemento Configuracion.");
                                    if (this.__mensaje.Value.ToString().Trim() != "")
                                    {
                                        return;
                                    }
                                    if (ok == 1)
                                    {
                                        for (int ma = 0; ma < this.ddl.Items.Count; ma++)
                                        {
                                            if (this.ddl.Items[ma].Text.Trim() == _T.Rows[k]["MARCA"].ToString().Trim())
                                                this.ddl.SelectedIndex = ma;
                                        }
                                    }
                                    ddl.CssClass = "form-control input-sm";
                                    tCell.Controls.Add(ddl);
                                    tRow.Cells.Add(tCell);
                                    break;
                                case 6:
                                    ddl = new System.Web.UI.WebControls.DropDownList();
                                    Cargar_Datos(this.ddl, "pr_Obtener_Modelos", "Error, al intentar recuperar Modelos Elemento Configuracion.");
                                    if (this.__mensaje.Value.ToString().Trim() != "")
                                    {
                                        return;
                                    }
                                    if (ok == 1)
                                    {
                                        for (int mo = 0; mo < this.ddl.Items.Count; mo++)
                                        {
                                            if (this.ddl.Items[mo].Text.Trim() == _T.Rows[k]["MODELO"].ToString().Trim())
                                                this.ddl.SelectedIndex = mo;
                                        }
                                    }
                                    ddl.CssClass = "form-control input-sm";
                                    tCell.Controls.Add(ddl);
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




























    protected void Button1_Click(object sender, EventArgs e)
    {
        //this.Title= ((System.Web.UI.WebControls.TextBox)this.Table_.Rows[1].Cells[2].Controls[0]).Text;
        this.__mensaje.Value = "";
        this.__pagina.Value = "";

        string[] Datos = (string[])Session["__JSAR__"];
        bool rpta = this.VERIFICAR_PERMISOS_DERECHOS_ACCESO_PAGINA_WEB(Convert.ToInt32(Datos[0]),
        "ComponenteCI.aspx", "NUEVO");
        if (rpta == false)
        {
            this.__mensaje.Value = "Ud. no esta autorizado para enviar datos en esta pagina web.";
            this.__pagina.Value = "CerrarSession.aspx";
            return;
        }

        bool ok = VerificarComponentes(Table_);
        if (ok == true)
        {
            this.__mensaje.Value = msg;
            this.__pagina.Value = "";
            return;
        }

        //String Descripcion = ((System.Web.UI.WebControls.DropDownList)Table_.Rows[1].Cells[6].Controls[0]).SelectedValue.ToString();
        //this.Title = Descripcion;
        int Codigo_CI = Convert.ToInt32(Request.QueryString.Get("IDCI").Trim());

        policia.clsaccesodatos servidor = new policia.clsaccesodatos();
        servidor.cadenaconexion = Ruta;
        try
        {
            servidor.cadenaconexion = Ruta;
            if (servidor.abrirconexiontrans() == true)
            {
                for (int i = 1; i < Table_.Rows.Count; i++)
                {

                    String Descripcion = ((System.Web.UI.WebControls.TextBox)Table_.Rows[i].Cells[2].Controls[0]).Text.Trim();
                    String Fabricante = ((System.Web.UI.WebControls.TextBox)Table_.Rows[i].Cells[3].Controls[0]).Text.Trim();
                    String NroSerie = ((System.Web.UI.WebControls.TextBox)Table_.Rows[i].Cells[4].Controls[0]).Text.Trim();
                    if (Descripcion != "" && Fabricante != "" && NroSerie != "")
                    {
                        servidor.ejecutar("[dbo].[pr_MatenimientoComponentesElementoConfiguracion]",
                                        false,
                                        null,
                                        Codigo_CI,
                                        Convert.ToUInt32(Table_.Rows[i].Cells[0].Text.Trim()),
                                        ((System.Web.UI.WebControls.TextBox)Table_.Rows[i].Cells[2].Controls[0]).Text.Trim(),
                                        ((System.Web.UI.WebControls.TextBox)Table_.Rows[i].Cells[3].Controls[0]).Text.Trim(),
                                        ((System.Web.UI.WebControls.TextBox)Table_.Rows[i].Cells[4].Controls[0]).Text.Trim(),
                                        Convert.ToUInt32(((System.Web.UI.WebControls.DropDownList)Table_.Rows[i].Cells[5].Controls[0]).SelectedValue.ToString()),
                                        Convert.ToUInt32(((System.Web.UI.WebControls.DropDownList)Table_.Rows[i].Cells[6].Controls[0]).SelectedValue.ToString()),
                                        "N",
                                        0, "");
                    }
                }
                if (servidor.getRespuesta() == 1)
                {
                    servidor.cerrarconexiontrans();
                    ShowMessage(servidor.getMensaje(), "CIsComponentesAsignados.aspx");
                }
                else
                {
                    servidor.cancelarconexiontrans();
                    ShowMessage(servidor.getMensaje(), "CIsComponentesAsignados.aspx");
                }
            }
            else
            {
                servidor.cancelarconexiontrans();
                ShowMessage(servidor.getMensageError(), "CerrarSession.aspx");
            }
        }
        catch (Exception)
        {
            servidor.cancelarconexiontrans();
            ShowMessage("Error inesperado al intentar conectarnos con el servidor.", "CerrarSession.aspx");
        }
    }

    private bool VerificarComponentes(System.Web.UI.WebControls.Table _T) {
        bool ok = false;
        int blanco = 0;
        for (int i = 1; i < _T.Rows.Count; i++)
        {

            String Descripcion = ((System.Web.UI.WebControls.TextBox)_T.Rows[i].Cells[2].Controls[0]).Text;
            String Fabricante = ((System.Web.UI.WebControls.TextBox)_T.Rows[i].Cells[3].Controls[0]).Text;
            String NroSerie = ((System.Web.UI.WebControls.TextBox)_T.Rows[i].Cells[4].Controls[0]).Text;
            if (Descripcion == "" && Fabricante != "" && NroSerie == "")
            {
                this.msg += _T.Rows[i].Cells[1].Text + "\n";
                this.msg += "No tiene Descripcion y NroSerie";
                ok = true;
                break;
            }
            else if (Descripcion == "" && Fabricante == "" && NroSerie != "")
            {
                this.msg += _T.Rows[i].Cells[1].Text + "\n";
                this.msg += "No tiene Descripcion y Fabricante";
                ok = true;
                break;
            }
            else if (Descripcion != "" && Fabricante == "" && NroSerie == "")
            {
                this.msg += _T.Rows[i].Cells[1].Text + "\n";
                this.msg += "No tiene Fabricante y NroSerie";
                ok = true;
                break;
            }
            else if (Descripcion != "" && Fabricante != "" && NroSerie == "")
            {
                this.msg += _T.Rows[i].Cells[1].Text + "\n";
                this.msg += "No tiene NroSerie";
                ok = true;
                break;
            }
            else if (Descripcion != "" && Fabricante == "" && NroSerie != "")
            {
                this.msg += _T.Rows[i].Cells[1].Text + "\n";
                this.msg += "No tiene Fabricante";
                ok = true;
                break;
            }
            else if (Descripcion == "" && Fabricante != "" && NroSerie != "")
            {
                this.msg += _T.Rows[i].Cells[1].Text + "\n";
                this.msg += "No tiene Descripcion";
                ok = true;
                break;
            }
            else if (Descripcion == "" && Fabricante == "" && NroSerie == "")
            {

                blanco += 1;
            }
            

        }

        if(blanco== _T.Rows.Count-1) {
            this.msg = "Ingrese componentes CI.";
            ok = true;
        }
      

        return ok;
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