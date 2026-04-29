using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Drawing;
//Sin la ayuda de JEHOVA nada de este trabajo se hubiera hecho. Gracias JEHOVA por darme un poquito de sabiduria.
//Si necesita una oracion por ud llame al 988305228
public partial class Configuracion_Seguridad : System.Web.UI.Page
{
    //private string Ruta = System.Configuration.ConfigurationManager.AppSettings.Get("CadenaConeccion");
    private String Ruta = System.Configuration.ConfigurationManager.ConnectionStrings["CadenaConeccion"].ToString();
    System.Web.UI.WebControls.TableRow tRow;
    Lista _Lista = new Lista();
    System.Web.UI.WebControls.CheckBox cb;
    String Operacion = "";
    int CODIGO_PERSONAL = -1;

    private void Generar_Cabecera_Tabla(System.Web.UI.WebControls.Table Tabla)
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");
        this.__pagina.Value = "../CerrarSession.aspx";
        DataTable dt = null;
        try
        {
            policia.clsaccesodatos servidor = new policia.clsaccesodatos();
            servidor.cadenaconexion = Ruta;
            if (servidor.abrirconexion() == true)
            {
                dt = servidor.consultar("[dbo].[pr_Obtener_Derechos]").Tables[0];
                if (dt.Rows.Count != 0)
                {
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        TableCell tc = new TableCell();
                        tc.Text = dt.Rows[i].ItemArray[1].ToString().Trim().ToUpper(); // NOMBRE DEL DERECHO              
                        tc.BackColor = System.Drawing.Color.Black;
                        tc.BorderColor = System.Drawing.Color.Black;
                        tc.ForeColor = System.Drawing.Color.White;
                        tc.Visible = true;
                        this.tSeguridad.Rows[0].Cells.Add(tc);
                    }
                    servidor.cerrarconexion();
                }
                else
                {
                    servidor.cerrarconexion();
                    _Lista.ShowMessage(__mensaje, __pagina, "No hay derechos para generar columnas en la tabla que permitar asignar autorizacion y permisos.", "../CerrarSession.aspx");

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
            dt = null;
            _Lista.ShowMessage(__mensaje, __pagina, "Error inesperado al intentar conectarnos con el servidor.", "../CerrarSession.aspx");
        }

    }

    private void Obtener_Formularios()
    {
        int LETRA = 65;
        //System.Web.UI.WebControls.CheckBox cb;

        _Lista.ShowMessage(__mensaje, __pagina, "", "");
        //for (int i = 1; i < tSeguridad.Rows.Count; i++)
        //{
        //    tSeguridad.Rows[i].Cells.Clear();

        //}
        //********************** AGREGADO EN REQUE EL 22-03-2023 ***************************
        _Lista.Limpiar_Tabla(tSeguridad);
        try
        {
            policia.clsaccesodatos servidor = new policia.clsaccesodatos();
            servidor.cadenaconexion = Ruta;
            if (servidor.abrirconexion() == true)
            {
                DataTable dt = servidor.consultar("[dbo].[pr_Obtener_Formularios]").Tables[0];




                if (dt.Rows.Count == 0)
                {
                    servidor.cerrarconexion();
                    _Lista.ShowMessage(__mensaje, __pagina, "No hay formularios para mostrar.", "../CerrarSession.aspx");
                }
                else
                {
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        tRow = new TableRow();
                        for (int j = 0; j < tSeguridad.Rows[i].Cells.Count; j++)//Cabecera de la tabla
                        {
                            TableCell tCell = new TableCell();
                            switch (j)
                            {
                                case 0: //CODIGO AUTORIZACION
                                    tCell.Text = "-1";
                                    tCell.Visible = false;
                                    tRow.Cells.Add(tCell);
                                    break;
                                case 1: //CODIGO FORMULARIO
                                    tCell.Text = dt.Rows[i]["CODIGO"].ToString().Trim();
                                    tCell.Visible = false;
                                    tRow.Cells.Add(tCell);
                                    break;
                                case 2: //AUTORIZACION
                                    String Nombre_Control = "";
                                    cb = new System.Web.UI.WebControls.CheckBox();
                                    cb.Checked = false;
                                    Nombre_Control = Convert.ToChar(LETRA) + "-" + (i).ToString() + "-" + (j).ToString();
                                    //cb.ID = Convert.ToChar(LETRA) + (i).ToString() + (j).ToString();//Fila / Columna en donde se encuentra el registro. 
                                    cb.ID = Nombre_Control;
                                    String[] DatosNC = Nombre_Control.Split('-');
                                    cb.Attributes.Add("onclick", "Activa('" + Nombre_Control + "','" + DatosNC[0].ToString() + "','" + DatosNC[1].ToString() + "','" + (j).ToString() + "');");                                    
                                    cb.Font.Size = FontUnit.XSmall;
                                    cb.AutoPostBack = true;
                                    cb.PreRender += new System.EventHandler(AUTORIZACION_PreRender);
                                    //cb.CheckedChanged += new System.EventHandler(AUTORIZACION_PreRender);
                                    tCell.HorizontalAlign = HorizontalAlign.Center;
                                    tCell.Visible = true;
                                    tCell.Controls.Add(cb);
                                    tRow.Cells.Add(tCell);
                                    break;
                                case 3: //NOMBRE FORMULARIO
                                    tCell.Text = dt.Rows[i]["NOMBRE"].ToString().Trim();
                                    tCell.Visible = true;
                                    tRow.Cells.Add(tCell);
                                    break;
                                case 4:
                                    cb = new System.Web.UI.WebControls.CheckBox();
                                    cb.ID = Convert.ToChar(LETRA) + (i).ToString() + (j).ToString();//Fila / Columna en donde se encuentra el registro. 
                                    cb.SkinID = "-1";
                                    cb.Font.Size = FontUnit.XSmall;
                                    cb.AutoPostBack = true;
                                    cb.PreRender += new System.EventHandler(ACEPTAR_PreRender);
                                    tCell.HorizontalAlign = HorizontalAlign.Center;
                                    tCell.Visible = true;
                                    tCell.Controls.Add(cb);
                                    tRow.Cells.Add(tCell);
                                    break;
                                case 5:
                                    cb = new System.Web.UI.WebControls.CheckBox();
                                    cb.ID = Convert.ToChar(LETRA) + (i).ToString() + (j).ToString();//Fila / Columna en donde se encuentra el registro. 
                                    cb.SkinID = "-1";
                                    cb.Font.Size = FontUnit.XSmall;
                                    cb.AutoPostBack = true;
                                    cb.PreRender += new System.EventHandler(CANCELAR_PreRender);
                                    tCell.HorizontalAlign = HorizontalAlign.Center;
                                    tCell.Visible = true;
                                    tCell.Controls.Add(cb);
                                    tRow.Cells.Add(tCell);
                                    break;
                                case 6:
                                    cb = new System.Web.UI.WebControls.CheckBox();
                                    cb.ID = Convert.ToChar(LETRA) + (i).ToString() + (j).ToString();//Fila / Columna en donde se encuentra el registro. 
                                    cb.SkinID = "-1";
                                    cb.Font.Size = FontUnit.XSmall;
                                    cb.AutoPostBack = true;
                                    cb.PreRender += new System.EventHandler(CERRAR_PreRender);
                                    tCell.HorizontalAlign = HorizontalAlign.Center;
                                    tCell.Visible = true;
                                    tCell.Controls.Add(cb);
                                    tRow.Cells.Add(tCell);
                                    break;
                                case 7:
                                    cb = new System.Web.UI.WebControls.CheckBox();
                                    cb.ID = Convert.ToChar(LETRA) + (i).ToString() + (j).ToString();//Fila / Columna en donde se encuentra el registro. 
                                    cb.SkinID = "-1";
                                    cb.Font.Size = FontUnit.XSmall;
                                    cb.AutoPostBack = true;
                                    cb.PreRender += new System.EventHandler(NUEVO_PreRender);
                                    tCell.HorizontalAlign = HorizontalAlign.Center;
                                    tCell.Visible = true;
                                    tCell.Controls.Add(cb);
                                    tRow.Cells.Add(tCell);
                                    break;
                                case 8:
                                    cb = new System.Web.UI.WebControls.CheckBox();
                                    cb.ID = Convert.ToChar(LETRA) + (i).ToString() + (j).ToString();//Fila / Columna en donde se encuentra el registro. 
                                    cb.SkinID = "-1";
                                    cb.Font.Size = FontUnit.XSmall;
                                    cb.AutoPostBack = true;
                                    cb.PreRender += new System.EventHandler(MODIFICAR_PreRender);
                                    tCell.HorizontalAlign = HorizontalAlign.Center;
                                    tCell.Visible = true;
                                    tCell.Controls.Add(cb);
                                    tRow.Cells.Add(tCell);
                                    break;
                                case 9:
                                    cb = new System.Web.UI.WebControls.CheckBox();
                                    cb.ID = Convert.ToChar(LETRA) + (i).ToString() + (j).ToString();//Fila / Columna en donde se encuentra el registro.
                                    cb.SkinID = "-1";
                                    cb.Font.Size = FontUnit.XSmall;
                                    cb.AutoPostBack = true;
                                    cb.PreRender += new System.EventHandler(ELIMINAR_PreRender);
                                    tCell.HorizontalAlign = HorizontalAlign.Center;
                                    tCell.Visible = true;
                                    tCell.Controls.Add(cb);
                                    tRow.Cells.Add(tCell);
                                    break;
                                case 10:
                                    cb = new System.Web.UI.WebControls.CheckBox();
                                    cb.ID = Convert.ToChar(LETRA) + (i).ToString() + (j).ToString();//Fila / Columna en donde se encuentra el registro. 
                                    cb.SkinID = "-1";
                                    cb.Font.Size = FontUnit.XSmall;
                                    cb.AutoPostBack = true;
                                    cb.PreRender += new System.EventHandler(IMPRIMIR_PreRender);
                                    tCell.HorizontalAlign = HorizontalAlign.Center;
                                    tCell.Visible = true;
                                    tCell.Controls.Add(cb);
                                    tRow.Cells.Add(tCell);
                                    break;
                                case 11:
                                    cb = new System.Web.UI.WebControls.CheckBox();
                                    cb.ID = Convert.ToChar(LETRA) + (i).ToString() + (j).ToString();//Fila / Columna en donde se encuentra el registro. 
                                    cb.SkinID = "-1";
                                    cb.Font.Size = FontUnit.XSmall;
                                    cb.AutoPostBack = true;
                                    cb.PreRender += new System.EventHandler(BUSCAR_PreRender);
                                    tCell.HorizontalAlign = HorizontalAlign.Center;
                                    tCell.Visible = true;
                                    tCell.Controls.Add(cb);
                                    tRow.Cells.Add(tCell);
                                    break;
                                case 12:
                                    cb = new System.Web.UI.WebControls.CheckBox();
                                    cb.ID = Convert.ToChar(LETRA) + (i).ToString() + (j).ToString();//Fila / Columna en donde se encuentra el registro. 
                                    cb.SkinID = "-1";
                                    cb.Font.Size = FontUnit.XSmall;
                                    cb.AutoPostBack = true;
                                    cb.PreRender += new System.EventHandler(AGREGAR_PreRender);
                                    tCell.HorizontalAlign = HorizontalAlign.Center;
                                    tCell.Visible = true;
                                    tCell.Controls.Add(cb);
                                    tRow.Cells.Add(tCell);
                                    break;
                                case 13:
                                    cb = new System.Web.UI.WebControls.CheckBox();
                                    cb.ID = Convert.ToChar(LETRA) + (i).ToString() + (j).ToString();//Fila / Columna en donde se encuentra el registro. 
                                    cb.SkinID = "-1";
                                    cb.Font.Size = FontUnit.XSmall;
                                    cb.AutoPostBack = true;
                                    cb.PreRender += new System.EventHandler(QUITAR_PreRender);
                                    tCell.HorizontalAlign = HorizontalAlign.Center;
                                    tCell.Visible = true;
                                    tCell.Controls.Add(cb);
                                    tRow.Cells.Add(tCell);
                                    break;
                                case 14:
                                    cb = new System.Web.UI.WebControls.CheckBox();
                                    cb.ID = Convert.ToChar(LETRA) + (i).ToString() + (j).ToString();//Fila / Columna en donde se encuentra el registro. 
                                    cb.SkinID = "-1";
                                    cb.Font.Size = FontUnit.XSmall;
                                    cb.AutoPostBack = true;
                                    cb.PreRender += new System.EventHandler(SELECCIONAR_PreRender);
                                    tCell.HorizontalAlign = HorizontalAlign.Center;
                                    tCell.Visible = true;
                                    tCell.Controls.Add(cb);
                                    tRow.Cells.Add(tCell);
                                    break;
                                case 15: //17-12-2024
                                    cb = new System.Web.UI.WebControls.CheckBox();
                                    cb.ID = Convert.ToChar(LETRA) + (i).ToString() + (j).ToString();//Fila / Columna en donde se encuentra el registro. 
                                    cb.SkinID = "-1";
                                    cb.Font.Size = FontUnit.XSmall;
                                    cb.AutoPostBack = true;
                                    cb.PreRender += new System.EventHandler(ACTUALIZAR_PreRender);
                                    tCell.HorizontalAlign = HorizontalAlign.Center;
                                    tCell.Visible = true;
                                    tCell.Controls.Add(cb);
                                    tRow.Cells.Add(tCell);
                                    break;
                                case 16: //20-12-2024 20:55
                                    cb = new System.Web.UI.WebControls.CheckBox();
                                    cb.ID = Convert.ToChar(LETRA) + (i).ToString() + (j).ToString();//Fila / Columna en donde se encuentra el registro. 
                                    cb.SkinID = "-1";
                                    cb.Font.Size = FontUnit.XSmall;
                                    cb.AutoPostBack = true;
                                    cb.PreRender += new System.EventHandler(EDITAR_PreRender);
                                    tCell.HorizontalAlign = HorizontalAlign.Center;
                                    tCell.Visible = true;
                                    tCell.Controls.Add(cb);
                                    tRow.Cells.Add(tCell);
                                    break;
                                case 17: //21-12-2024 13:53
                                    cb = new System.Web.UI.WebControls.CheckBox();
                                    cb.ID = Convert.ToChar(LETRA) + (i).ToString() + (j).ToString();//Fila / Columna en donde se encuentra el registro. 
                                    cb.SkinID = "-1";
                                    cb.Font.Size = FontUnit.XSmall;
                                    cb.AutoPostBack = true;
                                    cb.PreRender += new System.EventHandler(VISUALIZAR_PreRender);
                                    tCell.HorizontalAlign = HorizontalAlign.Center;
                                    tCell.Visible = true;
                                    tCell.Controls.Add(cb);
                                    tRow.Cells.Add(tCell);
                                    break;
                                case 18: //21-12-2024 16:51
                                    cb = new System.Web.UI.WebControls.CheckBox();
                                    cb.ID = Convert.ToChar(LETRA) + (i).ToString() + (j).ToString();//Fila / Columna en donde se encuentra el registro. 
                                    cb.SkinID = "-1";
                                    cb.Font.Size = FontUnit.XSmall;
                                    cb.AutoPostBack = true;
                                    cb.PreRender += new System.EventHandler(GENERAR_PreRender);
                                    tCell.HorizontalAlign = HorizontalAlign.Center;
                                    tCell.Visible = true;
                                    tCell.Controls.Add(cb);
                                    tRow.Cells.Add(tCell);
                                    break;
                            }
                        }
                        tSeguridad.Rows.Add(tRow);
                        LETRA++;
                    }
                    servidor.cerrarconexion();
                }
            }
            else
            {
                servidor.cerrarconexion();
                __mensaje.Value = servidor.getMensageError();
                __pagina.Value = "../CerrarSession.aspx";
            }
        }
        catch (Exception)
        {
            __mensaje.Value = "Error inesperado al intentar conectarnos con el servidor.";
            __pagina.Value = "../CerrarSession.aspx";
        }
    }

    protected void AUTORIZACION_PreRender(object sender, EventArgs e)
    {
        System.Web.UI.WebControls.CheckBox cb = (System.Web.UI.WebControls.CheckBox)sender;
        cb.Checked = cb.Checked;
    }

    protected void ACEPTAR_PreRender(object sender, EventArgs e)
    {
        System.Web.UI.WebControls.CheckBox cb = (System.Web.UI.WebControls.CheckBox)sender;
        cb.Checked = cb.Checked;
    }

    protected void CANCELAR_PreRender(object sender, EventArgs e)
    {
        System.Web.UI.WebControls.CheckBox cb = (System.Web.UI.WebControls.CheckBox)sender;
        cb.Checked = cb.Checked;
    }

    protected void CERRAR_PreRender(object sender, EventArgs e)
    {
        System.Web.UI.WebControls.CheckBox cb = (System.Web.UI.WebControls.CheckBox)sender;
        cb.Checked = cb.Checked;
    }

    protected void NUEVO_PreRender(object sender, EventArgs e)
    {
        System.Web.UI.WebControls.CheckBox cb = (System.Web.UI.WebControls.CheckBox)sender;
        cb.Checked = cb.Checked;
    }

    protected void MODIFICAR_PreRender(object sender, EventArgs e)
    {
        System.Web.UI.WebControls.CheckBox cb = (System.Web.UI.WebControls.CheckBox)sender;
        cb.Checked = cb.Checked;
    }

    protected void ELIMINAR_PreRender(object sender, EventArgs e)
    {
        System.Web.UI.WebControls.CheckBox cb = (System.Web.UI.WebControls.CheckBox)sender;
        cb.Checked = cb.Checked;
    }

    protected void IMPRIMIR_PreRender(object sender, EventArgs e)
    {
        System.Web.UI.WebControls.CheckBox cb = (System.Web.UI.WebControls.CheckBox)sender;
        cb.Checked = cb.Checked;
    }

    protected void BUSCAR_PreRender(object sender, EventArgs e)
    {
        System.Web.UI.WebControls.CheckBox cb = (System.Web.UI.WebControls.CheckBox)sender;
        cb.Checked = cb.Checked;
    }

    protected void AGREGAR_PreRender(object sender, EventArgs e)
    {
        System.Web.UI.WebControls.CheckBox cb = (System.Web.UI.WebControls.CheckBox)sender;
        cb.Checked = cb.Checked;
    }

    protected void QUITAR_PreRender(object sender, EventArgs e)
    {
        System.Web.UI.WebControls.CheckBox cb = (System.Web.UI.WebControls.CheckBox)sender;
        cb.Checked = cb.Checked;
    }

    protected void SELECCIONAR_PreRender(object sender, EventArgs e)
    {
        System.Web.UI.WebControls.CheckBox cb = (System.Web.UI.WebControls.CheckBox)sender;
        cb.Checked = cb.Checked;
    }

    protected void ACTUALIZAR_PreRender(object sender, EventArgs e)
    {
        System.Web.UI.WebControls.CheckBox cb = (System.Web.UI.WebControls.CheckBox)sender;
        cb.Checked = cb.Checked;
    }

    protected void EDITAR_PreRender(object sender, EventArgs e)
    {
        System.Web.UI.WebControls.CheckBox cb = (System.Web.UI.WebControls.CheckBox)sender;
        cb.Checked = cb.Checked;
    }

    protected void VISUALIZAR_PreRender(object sender, EventArgs e)
    {
        System.Web.UI.WebControls.CheckBox cb = (System.Web.UI.WebControls.CheckBox)sender;
        cb.Checked = cb.Checked;
    }

    protected void GENERAR_PreRender(object sender, EventArgs e)
    {
        System.Web.UI.WebControls.CheckBox cb = (System.Web.UI.WebControls.CheckBox)sender;
        cb.Checked = cb.Checked;
    }

    protected void Page_Init(object sender, EventArgs e)
    {
        string[] Datos = (string[])Session["__JSAR__"];

        if (Datos == null)
        {

            this.__mensaje.Value = "Ud. no esta autorizado para ingresar a esta página, inicie sesion por favor.";

            this.__pagina.Value = "../CerrarSession.aspx";

            return;

        }

        //verificar permiso para acceder a esta pagina.
        bool rpta = this.VERIFICAR_PERMISO_ACCESO_PAGINA_WEB(Convert.ToInt32(Datos[0]),
        "Seguridad.aspx");
        if (rpta == false)
        {
            this.__mensaje.Value = "Ud. no tiene permiso para ACCEDER esta pagina web.";
            this.__pagina.Value = "../CerrarSession.aspx";
            return;
        }

        //Obtenemos y presentamos los datos personales del colaborador
        String[] DatosPersonal = null;
        if (Session["__DatosPersonal__"] != null)
        {
            DatosPersonal = (string[])Session["__DatosPersonal__"];
            //Nombre + Apellido Paterno + Apellido Materno.
            this.lblCOLABORADOR.Text = DatosPersonal[2] + " " + DatosPersonal[3] + " " + DatosPersonal[4];
            this.lblCARGO.Text = DatosPersonal[1];
            Session["__DatosPersonal__"] = DatosPersonal;
        }
        this.Generar_Cabecera_Tabla(this.tSeguridad);
        this.Obtener_Formularios();

        CODIGO_PERSONAL = Convert.ToInt32(DatosPersonal[0]);
        this.consultar_Acceso_formulario_autorizacion(CODIGO_PERSONAL);
        this.consultar_Acceso_formulario_permiso(CODIGO_PERSONAL);

        //Registrar.
        if (this.Operacion.Equals("N"))
        {
            this.lbEnviar.OnClientClick = "return confirm('¿Desea guardar autorización y permisos para ingresar al sistema?');";
        }
        else
        {//Modificar.           
            this.lbEnviar.OnClientClick = "return confirm('¿Desea modificar autorización y permisos para ingresar al sistema?');";
        }


    }

    protected void Page_Load(object sender, EventArgs e)
    {
        //if (Session["BOTON"] != null)
        //{
        //    _Lista.ShowMessage(__mensaje, __pagina, "Error inesperado al intentar conectarnos con el servidor.", "");
        //}


    }

    protected void Page_PreRender(object sender, EventArgs e)
    {



    }

    public void consultar_Acceso_formulario_autorizacion(int CODIGO_PERSONAL)
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");
        DataTable tabla = null;
        try
        {
            policia.clsaccesodatos servidor = new policia.clsaccesodatos();
            servidor.cadenaconexion = Ruta;
            if (servidor.abrirconexion() == true)
            {
                tabla = servidor.consultar("[dbo].[consultar_Acceso_formulario_autorizacion]", CODIGO_PERSONAL).Tables[0];
                int NroFilas = tabla.Rows.Count;
                if (NroFilas == 0)
                {
                    Operacion = "N";
                    servidor.cerrarconexion();
                    //this.mesajeerror.Text = "USUARIO NO TIENE AUTORIZACION, DERECHOS Y PERMISOS PARA INGRESAR AL SISTEMA";
                }
                else
                {
                    Operacion = "M";
                    for (int i = 0; i < tabla.Rows.Count; i++)
                    {
                        for (int j = 1; j < this.tSeguridad.Rows.Count; j++)
                        {
                            //                                          COD FORMULARIO    =       COD FORMULARIO
                            if (Convert.ToInt32(this.tSeguridad.Rows[j].Cells[1].Text.Trim()) == Convert.ToInt32(tabla.Rows[i].ItemArray[1]))
                            {
                                this.tSeguridad.Rows[j].Cells[0].Text = tabla.Rows[i].ItemArray[0].ToString(); //COD AUTORIZACION
                                //OBTENEMOS EL NOMBRE DEL CheckBox QUE ESTA EN LA COLUMNA 2 DE LA TABLA.
                                string Nomnre_Control = ((System.Web.UI.WebControls.CheckBox)this.tSeguridad.Rows[j].Cells[2].Controls[0]).ID;
                                cb = new System.Web.UI.WebControls.CheckBox();
                                cb.Checked = Convert.ToBoolean(tabla.Rows[i].ItemArray[2]); //AUTORIZACION
                                cb.ID = Nomnre_Control;
                                String[] DatosNC = Nomnre_Control.Split('-');
                                cb.Attributes.Add("onclick", "Activa('" + Nomnre_Control + "','" + DatosNC[0].ToString() + "','" + DatosNC[1].ToString() + "','" + (j).ToString() + "');");
                                cb.Font.Size = FontUnit.XSmall;
                                cb.AutoPostBack = true;
                                cb.PreRender += new System.EventHandler(AUTORIZACION_PreRender);
                                this.tSeguridad.Rows[j].Cells[2].Controls.Clear();          //AUTORIZACION
                                this.tSeguridad.Rows[j].Cells[2].Controls.Add(cb);          //AUTORIZACION
                                this.tSeguridad.Rows[j].Cells[2].BackColor = Color.FromArgb(196, 225, 255);  //AUTORIZACION                                                          
                            }
                            //else
                            //{
                            //    this.tSeguridad.Rows[j].Cells[2].BackColor = Color.FromArgb(225, 202, 202);  //AUTORIZACION                               
                            //}                           
                        }
                        servidor.cerrarconexion();
                    }
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

    public void consultar_Acceso_formulario_permiso(int CODIGO_PERSONAL)
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");
        DataTable tabla = null;
        try
        {
            policia.clsaccesodatos servidor = new policia.clsaccesodatos();
            servidor.cadenaconexion = Ruta;
            if (servidor.abrirconexion() == true)
            {
                for (int i = 1; i < this.tSeguridad.Rows.Count; i++)
                {
                    //COLUMNA AUTORIZACION
                    if (((System.Web.UI.WebControls.CheckBox)this.tSeguridad.Rows[i].Cells[2].Controls[0]).Checked == true)
                    {
                        //COLUMNA COD. FORMULARIO
                        tabla = servidor.consultar("[dbo].[consultar_Acceso_formulario_permiso]", CODIGO_PERSONAL, Convert.ToInt32(this.tSeguridad.Rows[i].Cells[1].Text.Trim())).Tables[0];
                        int NroFilas = tabla.Rows.Count;
                        if (NroFilas == 0)
                        {
                            //this.mesajeerror.Text = "USUARIO NO TIENE AUTORIZACION, DERECHOS Y PERMISOS PARA INGRESAR AL SISTEMA";
                        }
                        else
                        {
                            for (int j = 0; j < tabla.Rows.Count; j++)
                            {
                                for (int k = 4; k < this.tSeguridad.Rows[0].Cells.Count; k++)
                                {
                                    if (Convert.ToString(this.tSeguridad.Rows[0].Cells[k].Text.Trim()).ToUpper() == Convert.ToString(tabla.Rows[j].ItemArray[2]).Trim().ToUpper())
                                    {
                                        string Nomnre_Control = ((System.Web.UI.WebControls.CheckBox)this.tSeguridad.Rows[i].Cells[k].Controls[0]).ID;
                                        cb = new System.Web.UI.WebControls.CheckBox();
                                        cb.Checked = Convert.ToBoolean(tabla.Rows[j].ItemArray[3]); //COLUMNA APROBACION PERMISO
                                        cb.ID = Nomnre_Control;
                                        cb.SkinID = Convert.ToString(tabla.Rows[j].ItemArray[4]); //COLUMNA COD PERMISO
                                        cb.Font.Size = FontUnit.XSmall;
                                        cb.AutoPostBack = true;
                                        switch (j)
                                        {
                                            case 4:
                                                cb.PreRender += new System.EventHandler(ACEPTAR_PreRender);
                                                break;
                                            case 5:
                                                cb.PreRender += new System.EventHandler(CANCELAR_PreRender);
                                                break;
                                            case 6:
                                                cb.PreRender += new System.EventHandler(CERRAR_PreRender);
                                                break;
                                            case 7:
                                                cb.PreRender += new System.EventHandler(NUEVO_PreRender);
                                                break;
                                            case 8:
                                                cb.PreRender += new System.EventHandler(MODIFICAR_PreRender);
                                                break;
                                            case 9:
                                                cb.PreRender += new System.EventHandler(ELIMINAR_PreRender);
                                                break;
                                            case 10:
                                                cb.PreRender += new System.EventHandler(IMPRIMIR_PreRender);
                                                break;
                                            case 11:
                                                cb.PreRender += new System.EventHandler(BUSCAR_PreRender);
                                                break;
                                            case 12:
                                                cb.PreRender += new System.EventHandler(AGREGAR_PreRender);
                                                break;
                                            case 13:
                                                cb.PreRender += new System.EventHandler(QUITAR_PreRender);
                                                break;
                                            case 14:
                                                cb.PreRender += new System.EventHandler(SELECCIONAR_PreRender);
                                                break;
                                            case 15:
                                                cb.PreRender += new System.EventHandler(ACTUALIZAR_PreRender);
                                                break;
                                            case 16:
                                                cb.PreRender += new System.EventHandler(EDITAR_PreRender);
                                                break;
                                            case 17:
                                                cb.PreRender += new System.EventHandler(VISUALIZAR_PreRender);
                                                break;
                                            case 18:
                                                cb.PreRender += new System.EventHandler(GENERAR_PreRender);
                                                break;
                                        }
                                        this.tSeguridad.Rows[i].Cells[k].Controls.Clear();
                                        this.tSeguridad.Rows[i].Cells[k].Controls.Add(cb);
                                        this.tSeguridad.Rows[i].Cells[k].BackColor = Color.FromArgb(196, 225, 255);
                                    }
                                }
                            }
                        }
                    }
                }
                servidor.cerrarconexion();
            }
            else
            {
                servidor.cerrarconexion();
                _Lista.ShowMessage(__mensaje, __pagina, servidor.getMensageError(), "CerrarSession.aspx");
            }
        }
        catch (Exception)
        {
            _Lista.ShowMessage(__mensaje, __pagina, "Error inesperado al intentar conectarnos con el servidor.", "CerrarSession.aspx");
        }
    }

    private void Enviar_Datos_Seguridad()
    {

        int Respuesta = -1;
        int _Respuesta = -1;
        policia.clsaccesodatos servidor = new policia.clsaccesodatos();
        try
        {
            //policia.clsaccesodatos servidor = new policia.clsaccesodatos();
            servidor.cadenaconexion = Ruta;
            if (servidor.abrirconexiontrans() == true)
            {
                //ENVIAR DATOS AUTORIZACION
                for (int Fila = 1; Fila < this.tSeguridad.Rows.Count; Fila++)
                {
                    //COLUMNA AUTORIZACION
                    if ((Convert.ToInt32(this.tSeguridad.Rows[Fila].Cells[0].Text.Trim()) == -1 && ((System.Web.UI.WebControls.CheckBox)this.tSeguridad.Rows[Fila].Cells[2].Controls[0]).Checked == true) ||
                        (Convert.ToInt32(this.tSeguridad.Rows[Fila].Cells[0].Text.Trim()) != -1 && ((System.Web.UI.WebControls.CheckBox)this.tSeguridad.Rows[Fila].Cells[2].Controls[0]).Checked == false) ||
                        (Convert.ToInt32(this.tSeguridad.Rows[Fila].Cells[0].Text.Trim()) != -1 && ((System.Web.UI.WebControls.CheckBox)this.tSeguridad.Rows[Fila].Cells[2].Controls[0]).Checked == true))
                    {
                        servidor.ejecutar("[dbo].[_pa_mantenimiento_Autorizacion]",
                        false,
                        Convert.ToInt32(this.tSeguridad.Rows[Fila].Cells[0].Text.Trim()),//COLUMNA CODIGO AUTORIZACION
                        Convert.ToInt32(this.tSeguridad.Rows[Fila].Cells[1].Text.Trim()),//COLUMNA CODIGO FORMULARIO
                        CODIGO_PERSONAL,
                        Convert.ToBoolean(((System.Web.UI.WebControls.CheckBox)this.tSeguridad.Rows[Fila].Cells[2].Controls[0]).Checked),//COLUMNA APROBACION AUTORIZACION                      
                        Operacion,
                        0, "");
                        Respuesta = servidor.getRespuesta();// Obtenemos la respuesta si se guardo o no la autorización y permisos para ingresar al sistema 
                        if (Verficar_Estado_Codigo_Permiso_Autorizacion_Formulario(Fila) == true || Respuesta == 1)
                        {
                            Respuesta = Convert.ToInt32(this.tSeguridad.Rows[Fila].Cells[0].Text.Trim());//COLUMNA CODIGO AUTORIZACION
                        }
                        if (Respuesta == 0)
                        {
                            servidor.cancelarconexiontrans();
                            _Lista.ShowMessage(__mensaje, __pagina, servidor.getMensaje(), "");
                        }
                        else
                        {
                            //ENVIAR DATOS PERMISOS
                            for (int j = 4; j < this.tSeguridad.Rows[Fila].Cells.Count; j++)
                            {
                                if ((Convert.ToInt32(((System.Web.UI.WebControls.CheckBox)this.tSeguridad.Rows[Fila].Cells[j].Controls[0]).SkinID) == -1 && ((System.Web.UI.WebControls.CheckBox)this.tSeguridad.Rows[Fila].Cells[j].Controls[0]).Checked == true) ||
                                    (Convert.ToInt32(((System.Web.UI.WebControls.CheckBox)this.tSeguridad.Rows[Fila].Cells[j].Controls[0]).SkinID) != -1 && ((System.Web.UI.WebControls.CheckBox)this.tSeguridad.Rows[Fila].Cells[j].Controls[0]).Checked == false) ||
                                    (Convert.ToInt32(((System.Web.UI.WebControls.CheckBox)this.tSeguridad.Rows[Fila].Cells[j].Controls[0]).SkinID) != -1 && ((System.Web.UI.WebControls.CheckBox)this.tSeguridad.Rows[Fila].Cells[j].Controls[0]).Checked == true))
                                {
                                    servidor.ejecutar("[dbo].[_pa_mantenimiento_Permiso]",
                                                                    false,
                                                                    Convert.ToInt32(((System.Web.UI.WebControls.CheckBox)this.tSeguridad.Rows[Fila].Cells[j].Controls[0]).SkinID),       //CODIGO PERMISO. 
                                                                    Respuesta,  //CODIGO AUTORIZACION.
                                                                    this.tSeguridad.Rows[0].Cells[j].Text.Trim().ToUpper(), //DERECHO TOMADO DE LA CABECERA DE LAS COLUMNAS DE LA TABLA.
                                                                    Convert.ToBoolean(((System.Web.UI.WebControls.CheckBox)this.tSeguridad.Rows[Fila].Cells[j].Controls[0]).Checked), //APROBACION PERMISO.
                                                                    Operacion,
                                                                    0, "");
                                    _Respuesta = servidor.getRespuesta();
                                }
                            }
                        }
                    }
                }
                if (_Respuesta == 1)
                {
                    servidor.cerrarconexiontrans();
                    _Lista.ShowMessage(__mensaje, __pagina, servidor.getMensaje(), "Usuarios.aspx");
                }
                else
                {
                    servidor.cerrarconexiontrans();
                    _Lista.ShowMessage(__mensaje, __pagina, servidor.getMensaje(), "Usuarios.aspx");
                }
            }
            else
            {
                servidor.cancelarconexiontrans();
                _Lista.ShowMessage(__mensaje, __pagina, servidor.getMensageError(), "../CerrarSession.aspx");
            }
        }
        catch (Exception ex)
        {
            servidor.cancelarconexiontrans();
            _Lista.ShowMessage(__mensaje, __pagina, ex.Message, "");
        }
    }


  
    protected void lbEnviar_Click(object sender, EventArgs e)
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");

        //verificar permiso para REGISTRAR datos.
        string[] Datos = (string[])Session["__JSAR__"];
        bool rpta = this.VERIFICAR_PERMISOS_DERECHOS_ACCESO_PAGINA_WEB(Convert.ToInt32(Datos[0]),
        "Seguridad.aspx", "NUEVO");
        if (rpta == false)
        {
            this.__mensaje.Value = "Ud. no esta autorizado para ENVIAR datos en esta pagina web.";
            this.__pagina.Value = "../CerrarSession.aspx";
            return;
        }

        Session["Imprimir"] = null;
        bool ok = Validar_Autorizacion_Permisos_Ingreso_Sistema();
        if (ok == false)
        {
            _Lista.ShowMessage(__mensaje, __pagina, "Seleccione Autorizacion y Permisos Para Ingresar al Sistema", "");
            return;
        }
        Enviar_Datos_Seguridad();
    }
    protected void lbCancelar_Click(object sender, EventArgs e)
    {
        _Lista.ShowMessage(__mensaje, __pagina, "", "");

        //verificar permiso para eliminar datos.
        string[] Datos = (string[])Session["__JSAR__"];
        bool rpta = this.VERIFICAR_PERMISOS_DERECHOS_ACCESO_PAGINA_WEB(Convert.ToInt32(Datos[0]),
        "Seguridad.aspx", "CANCELAR");
        if (rpta == false)
        {
            this.__mensaje.Value = "Ud. no esta autorizado para CANCELAR datos en esta pagina web.";
            this.__pagina.Value = "CerrarSession.aspx";
            return;
        }

        Session["Imprimir"] = null;
        Response.Clear();
        Response.Redirect("Usuarios.aspx");
        Response.Flush();
    }

    private bool Verficar_Estado_Codigo_Permiso_Autorizacion_Formulario(int FILA){
        int Fila = FILA;
        bool ok = false;
        for (int Columna = 4; Columna < this.tSeguridad.Rows[Fila].Cells.Count; Columna += 1)
        {
            ok = Convert.ToInt32(((System.Web.UI.WebControls.CheckBox)this.tSeguridad.Rows[Fila].Cells[Columna].Controls[0]).SkinID) != -1;
            if (ok == false)
            {
                break;
            }
           
        }
        return ok;
    }

    private bool Validar_Autorizacion_Permisos_Ingreso_Sistema()
    {
        int flag = 0;
        bool  ok = true;
        int COD_AUTORIZACION = -1;
        for (int Fila = 1; Fila < this.tSeguridad.Rows.Count; Fila++)
        {
            COD_AUTORIZACION = Convert.ToInt32(this.tSeguridad.Rows[Fila].Cells[0].Text.Trim()); // COLUMNA CODIGO AUTORIZACIÓN.
            if (COD_AUTORIZACION == -1)
            {
                if (((System.Web.UI.WebControls.CheckBox)this.tSeguridad.Rows[Fila].Cells[2].Controls[0]).Checked == true)
                {
                    for (int Columna = 4; Columna < this.tSeguridad.Rows[Fila].Cells.Count; Columna += 1)
                    {
                        ok = ((System.Web.UI.WebControls.CheckBox)this.tSeguridad.Rows[Fila].Cells[Columna].Controls[0]).Checked;
                        if (ok == true)
                        {
                            break;
                        }
                    }
                    flag = 0;
                }
                else
                {
                    flag+=1;
                    for (int Columna = 4; Columna < this.tSeguridad.Rows[Fila].Cells.Count; Columna += 1)
                    {
                        if (((System.Web.UI.WebControls.CheckBox)this.tSeguridad.Rows[Fila].Cells[Columna].Controls[0]).Checked == true)
                        {
                            ok = false;
                            break;
                        }
                       
                    }
                }                
            }
            if (ok == false)
            {
                break;
            }
        }
        if (flag == this.tSeguridad.Rows.Count - 1)
        {
            ok = false;
        }
        return ok;
    }
    protected void IMPRIMIR_Click(object sender, EventArgs e)
    {
        DataTable dtUsuario = new DataTable();
        DataRow drUsuario;
        
        dtUsuario.Columns.Add(new DataColumn("Colaborador", typeof(string)));
        dtUsuario.Columns.Add(new DataColumn("Áre", typeof(string)));
        dtUsuario.Columns.Add(new DataColumn("Cargo", typeof(string)));
        dtUsuario.Columns.Add(new DataColumn("Codigo", typeof(Int32)));

        String[] DatosPersonal = null;
        DatosPersonal = (string[])Session["__DatosPersonal__"];
               
        drUsuario = dtUsuario.NewRow();
        drUsuario[0] = DatosPersonal[3] + " " + DatosPersonal[4] + " " + DatosPersonal[5];
        drUsuario[1] = DatosPersonal[1];
        drUsuario[2] = DatosPersonal[2];
        drUsuario[3] = Convert.ToInt32(DatosPersonal[0]);
        dtUsuario.Rows.Add(drUsuario);


        DataTable dtSeguridad = new DataTable();

        dtSeguridad.Columns.Add(new DataColumn("AUTORIZACIÓN", typeof(Boolean)));
        dtSeguridad.Columns.Add(new DataColumn("PÁGINA_WEB", typeof(string)));
        dtSeguridad.Columns.Add(new DataColumn("ACEPTAR", typeof(Boolean)));
        dtSeguridad.Columns.Add(new DataColumn("CANCELAR", typeof(Boolean)));
        dtSeguridad.Columns.Add(new DataColumn("CERRAR", typeof(Boolean)));
        dtSeguridad.Columns.Add(new DataColumn("NUEVO", typeof(Boolean)));
        dtSeguridad.Columns.Add(new DataColumn("MODIFICAR", typeof(Boolean)));
        dtSeguridad.Columns.Add(new DataColumn("ELIMINAR", typeof(Boolean)));
        dtSeguridad.Columns.Add(new DataColumn("IMPRIMIR", typeof(Boolean)));
        dtSeguridad.Columns.Add(new DataColumn("BUSCAR", typeof(Boolean)));
        dtSeguridad.Columns.Add(new DataColumn("AGREGAR", typeof(Boolean)));
        dtSeguridad.Columns.Add(new DataColumn("QUITAR", typeof(Boolean)));
        dtSeguridad.Columns.Add(new DataColumn("SELECCIONAR", typeof(Boolean)));
        dtSeguridad.Columns.Add(new DataColumn("Codigo", typeof(Int32)));

        for (int Fila = 1; Fila < this.tSeguridad.Rows.Count; Fila++)
        {
            dtSeguridad.Rows.Add(Convert.ToBoolean(((System.Web.UI.WebControls.CheckBox)this.tSeguridad.Rows[Fila].Cells[2].Controls[0]).Checked)
                , this.tSeguridad.Rows[Fila].Cells[3].Text.Trim()
                , Convert.ToBoolean(((System.Web.UI.WebControls.CheckBox)this.tSeguridad.Rows[Fila].Cells[4].Controls[0]).Checked)
                , Convert.ToBoolean(((System.Web.UI.WebControls.CheckBox)this.tSeguridad.Rows[Fila].Cells[5].Controls[0]).Checked)
                , Convert.ToBoolean(((System.Web.UI.WebControls.CheckBox)this.tSeguridad.Rows[Fila].Cells[6].Controls[0]).Checked)
                , Convert.ToBoolean(((System.Web.UI.WebControls.CheckBox)this.tSeguridad.Rows[Fila].Cells[7].Controls[0]).Checked)
                , Convert.ToBoolean(((System.Web.UI.WebControls.CheckBox)this.tSeguridad.Rows[Fila].Cells[8].Controls[0]).Checked)
                , Convert.ToBoolean(((System.Web.UI.WebControls.CheckBox)this.tSeguridad.Rows[Fila].Cells[9].Controls[0]).Checked)
                , Convert.ToBoolean(((System.Web.UI.WebControls.CheckBox)this.tSeguridad.Rows[Fila].Cells[10].Controls[0]).Checked)
                , Convert.ToBoolean(((System.Web.UI.WebControls.CheckBox)this.tSeguridad.Rows[Fila].Cells[11].Controls[0]).Checked)
                , Convert.ToBoolean(((System.Web.UI.WebControls.CheckBox)this.tSeguridad.Rows[Fila].Cells[12].Controls[0]).Checked)
                , Convert.ToBoolean(((System.Web.UI.WebControls.CheckBox)this.tSeguridad.Rows[Fila].Cells[13].Controls[0]).Checked)
                , Convert.ToInt32(DatosPersonal[0]));

        }
        //dtSeguridad.Rows.Add(true, "WW", false, true, true, true, false, true, true, true, true, true, 1);
        //dtSeguridad.Rows.Add(true, "WW", true, true, false, true, true, true, true, true, true, true, 1);

        //DataSet ds = new DataSet();
        //ds.Tables.Add(dtUsuario);
        //ds.Tables.Add(dtSeguridad);

        //IMPRIMIR.Page.Session.Add("Imprimir", new Object[] { "Lista_Seuridad", dtUsuario, "REPORTE DE CATEGORIZACION DE INCIDENCIAS" });
        Session["Imprimir"] = new Object[] { "Lista_Seuridad", dtUsuario, "REPORTE DE AUTORIZACIÓN Y PERMISOS PARA INGRESAR AL SISTEMA", dtSeguridad };
        //Response.Clear();
        //Response.Redirect("~/Reportes/Reporte.aspx");
        //Response.Flush();
        //_Lista.ShowMessage(__mensaje, __pagina, dtUsuario.Rows.Count.ToString(), "");
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