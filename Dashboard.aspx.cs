using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class Dashboard : System.Web.UI.Page
{
    private String Ruta = System.Configuration.ConfigurationManager.ConnectionStrings["CadenaConeccion"].ToString();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            CargarEstadisticas();
            CargarUltimosElementos();
            CargarUltimosSeguimientos();
            lblFecha.Text = DateTime.Now.ToString("dddd, dd de MMMM yyyy");
        }
    }

    private void CargarEstadisticas()
    {
        try
        {
            policia.clsaccesodatos servidor = new policia.clsaccesodatos();
            servidor.cadenaconexion = Ruta;

            if (servidor.abrirconexiontrans() == true)
            {
                // Total Elementos de Configuración
                DataTable dtEC = servidor.consultar("SELECT COUNT(*) AS Total FROM ELEMENTOS_CONFIGURACION").Tables[0];
                lblTotalEC.Text = dtEC.Rows[0]["Total"].ToString();

                // Total Relaciones
                DataTable dtRel = servidor.consultar("SELECT COUNT(*) AS Total FROM RELACION_ELEMENTO_CONFIGURACION").Tables[0];
                lblTotalRelaciones.Text = dtRel.Rows[0]["Total"].ToString();

                // Total Licencias (activas - no vencidas o perpetuas)
                DataTable dtLic = servidor.consultar(@"
                    SELECT COUNT(*) AS Total FROM LICENCIA_ELEMENTO_CONFIGURACION
                    WHERE LICENCIA_PERPETUA = 1
                       OR FECHA_FIN >= GETDATE()").Tables[0];
                lblTotalLicencias.Text = dtLic.Rows[0]["Total"].ToString();

                // Total Seguimientos
                DataTable dtSeg = servidor.consultar("SELECT COUNT(*) AS Total FROM SEGUIMIENTO_ELEMENTO_CONFIGURACION").Tables[0];
                lblTotalSeguimientos.Text = dtSeg.Rows[0]["Total"].ToString();

                // Total Personal activo
                DataTable dtPers = servidor.consultar("SELECT COUNT(*) AS Total FROM Personal WHERE Estado_Personal = 1").Tables[0];
                lblTotalPersonal.Text = dtPers.Rows[0]["Total"].ToString();

                // Total Componentes Asignados
                DataTable dtComp = servidor.consultar("SELECT COUNT(*) AS Total FROM COMPONENTES_ELEMENTO_CONFIGURACION").Tables[0];
                lblTotalComponentes.Text = dtComp.Rows[0]["Total"].ToString();

                servidor.cerrarconexion();
            }
        }
        catch (Exception)
        {
            System.Diagnostics.Debug.WriteLine("Error cargando estadísticas");
        }
    }

    private void CargarUltimosElementos()
    {
        try
        {
            policia.clsaccesodatos servidor = new policia.clsaccesodatos();
            servidor.cadenaconexion = Ruta;

            if (servidor.abrirconexiontrans() == true)
            {
                DataTable dt = servidor.consultar(@"
                    SELECT TOP 5
                        ISNULL(NOMBRE_ELEMENTO_CONFIGURACION, 'Sin nombre') AS NOMBRE_ELEMENTO_CONFIGURACION,
                        FECHA_REGISTRO
                    FROM ELEMENTOS_CONFIGURACION
                    ORDER BY FECHA_REGISTRO DESC").Tables[0];

                gvUltimosEC.DataSource = dt;
                gvUltimosEC.DataBind();

                servidor.cerrarconexion();
            }
        }
        catch (Exception)
        {
            System.Diagnostics.Debug.WriteLine("Error cargando últimos EC");
        }
    }

    private void CargarUltimosSeguimientos()
    {
        try
        {
            policia.clsaccesodatos servidor = new policia.clsaccesodatos();
            servidor.cadenaconexion = Ruta;

            if (servidor.abrirconexiontrans() == true)
            {
                DataTable dt = servidor.consultar(@"
                    SELECT TOP 5
                        S.FECHA_SEGUIMIENTO,
                        ISNULL(E.NOMBRE_ELEMENTO_CONFIGURACION, 'Elemento eliminado') AS NOMBRE_EC
                    FROM SEGUIMIENTO_ELEMENTO_CONFIGURACION S
                    LEFT JOIN ELEMENTOS_CONFIGURACION E ON S.ID_ELEMENTO_CONFIGURACION = E.ID_ELEMENTO_CONFIGURACION
                    ORDER BY S.FECHA_SEGUIMIENTO DESC").Tables[0];

                gvUltimosSeguimientos.DataSource = dt;
                gvUltimosSeguimientos.DataBind();

                servidor.cerrarconexion();
            }
        }
        catch (Exception)
        {
            System.Diagnostics.Debug.WriteLine("Error cargando seguimientos");
        }
    }
}