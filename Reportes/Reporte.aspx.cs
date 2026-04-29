using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using CrystalDecisions.Shared;

public partial class Reportes_Default : System.Web.UI.Page
{
    private String Ruta = System.Configuration.ConfigurationManager.ConnectionStrings["CadenaConeccion"].ToString();
    private String Empresa = "Cooperativa San Martin de Porres\nRUC : \nPrincipal : Av. Pedro Ruiz Nº 1076\nChiclayo, Lambayeque, Peru\nTelefono : 074-204323 Anexo 102\nwww.coopacsanmartin.pe";

    protected void Page_Load(object sender, EventArgs e)
    {
        CrystalDecisions.CrystalReports.Engine.ReportDocument rptDoc = new CrystalDecisions.CrystalReports.Engine.ReportDocument();

        //String Usuario = "";
        //String Contraseña = "";
        //String Servidor = "(local)";
        //String BaseDatos = "ADMINITRACION DE INCIDENCIASd";

        ////CrystalDecisions.CrystalReports.Engine.Tables crTables;
        ////CrystalDecisions.CrystalReports.Engine.Table crTable;
        //CrystalDecisions.Shared.ConnectionInfo crConnInfo = new CrystalDecisions.Shared.ConnectionInfo();
        //CrystalDecisions.Shared.TableLogOnInfo crLogOnInfo;

        //rptDoc.SetDatabaseLogon(Usuario, Contraseña, Servidor, BaseDatos);
        //foreach (CrystalDecisions.CrystalReports.Engine.Table crTable in rptDoc.Database.Tables)
        //{
        //    crConnInfo.ServerName = Servidor;
        //    crConnInfo.DatabaseName = BaseDatos;
        //    crConnInfo.UserID = Usuario;
        //    crConnInfo.Password = Contraseña;
        //    crLogOnInfo = crTable.LogOnInfo;
        //    crLogOnInfo.ConnectionInfo = crConnInfo;
        //    crTable.ApplyLogOnInfo(crLogOnInfo);
        //    crTable.LogOnInfo.ConnectionInfo.Password = Contraseña;
        //    crTable.Location = BaseDatos + ".dbo." + crTable.Name;

        //}

        object[] Datos = (object[])Session["Imprimir"];
        String OpcionInforme = Datos[0].ToString();
        String TituloInforme = Datos[2].ToString();
        if (OpcionInforme.Equals("REPORTE_ELEMENTOS_CONFIGURACION"))
        {
            String RutaReporte = Server.MapPath("CR_REPORTE_ELEMENTOS_CONFIGURACION.rpt");
            DataTable Tabla = (DataTable)Datos[1];
            DS_REPORTE_ELEMENTOS_CONFIGURACION ds = new DS_REPORTE_ELEMENTOS_CONFIGURACION();
            ds.Tables[0].Merge(Tabla);
            this.Title ="IMPRIMIR " + TituloInforme;
            rptDoc.Load(RutaReporte);
            rptDoc.SetDataSource(ds);
        }else if (OpcionInforme.Equals("REPORTE_LICENCIAS_CI"))
        {
            String RutaReporte = Server.MapPath("CR_REPORTE_LICENCIAS_ELEMENTO_CONFIGURACION.rpt");

            DataTable Tabla = (DataTable)Datos[1];
            DS_REPORTE_LICENCIAS_ELEMENTO_CONFIGURACION ds = new DS_REPORTE_LICENCIAS_ELEMENTO_CONFIGURACION();
            //ds.Tables.Add(Tabla);
            ds.Tables[0].Merge(Tabla, true);

            DataTable Tabla2 = (DataTable)Datos[3];
            //ds.Tables.Add(Tabla2);
            ds.Tables[1].Merge(Tabla2, true);

            this.Title = "IMPRIMIR " + TituloInforme;
            rptDoc.Load(RutaReporte);
            rptDoc.SetDataSource(ds);
        }
        else if (OpcionInforme.Equals("REPORTE_RELACIONES_ELEMENTOS_CONFIGURACION"))
        {
            String RutaReporte = Server.MapPath("CR_REPORTE_RELACIONES_CIs.rpt");
            DataTable Tabla = (DataTable)Datos[1];
            DS_REPORTE_RELACIONES_ELEMENTOS_CONFIGURACION ds = new DS_REPORTE_RELACIONES_ELEMENTOS_CONFIGURACION();
            ds.Tables[0].Merge(Tabla);
            this.Title = "IMPRIMIR " + TituloInforme;
            rptDoc.Load(RutaReporte);
            rptDoc.SetDataSource(ds);
        }
        else if (OpcionInforme.Equals("REPORTE_COMPONENTES_CI"))
        {
            String RutaReporte = Server.MapPath("CR_REPORTE_COMPONENTES_ASIGNADOS.rpt");

            DataTable Tabla = (DataTable)Datos[1];
            DS_REPORTE_COMPONENETES_ASIGNADOSt ds = new DS_REPORTE_COMPONENETES_ASIGNADOSt();
            //ds.Tables.Add(Tabla);
            ds.Tables[0].Merge(Tabla, true);

            DataTable Tabla2 = (DataTable)Datos[3];
            //ds.Tables.Add(Tabla2);
            ds.Tables[1].Merge(Tabla2, true);

            this.Title = "IMPRIMIR " + TituloInforme;
            rptDoc.Load(RutaReporte);
            rptDoc.SetDataSource(ds);
        }
        else if (OpcionInforme.Equals("REPORTE_SEGUIMIENTO_CIs"))
        {
            String RutaReporte = Server.MapPath("CR_REPORTE_SEGUIMIENTO_CIs.rpt");
            DataTable Tabla = (DataTable)Datos[1];
            DS_REPORTE_SEGUIMIENTO_CIs ds = new DS_REPORTE_SEGUIMIENTO_CIs();
            ds.Tables[0].Merge(Tabla);
            this.Title = "IMPRIMIR " + TituloInforme;
            rptDoc.Load(RutaReporte);
            rptDoc.SetDataSource(ds);
        }
        else if (OpcionInforme.Equals("REPORTE_DATOS_CORRECTOS_CIs"))
        {
            String RutaReporte = Server.MapPath("CR_ReporteDatosCorrectosCI.rpt");
            DataTable Tabla = (DataTable)Datos[1];
            DS_ReporteDatosCorrectosCI ds = new DS_ReporteDatosCorrectosCI();
            ds.Tables[0].Merge(Tabla);
            this.Title = "IMPRIMIR " + TituloInforme;
            rptDoc.Load(RutaReporte);
            rptDoc.SetDataSource(ds);
        }
        else if (OpcionInforme.Equals("REPORTE_DATOS_INCORRECTOS_CIs"))
        {
            String RutaReporte = Server.MapPath("CR_ReporteDatosIncorrectosCI.rpt");
            DataTable Tabla = (DataTable)Datos[1];
            DS_ReporteDatosIncorrectosCI ds = new DS_ReporteDatosIncorrectosCI();
            ds.Tables[0].Merge(Tabla);
            this.Title = "IMPRIMIR " + TituloInforme;
            rptDoc.Load(RutaReporte);
            rptDoc.SetDataSource(ds);
        }
        else if (OpcionInforme.Equals("REPORTE_CIs_SEGUIDOS"))
        {
            String RutaReporte = Server.MapPath("CR_ReporteCIsSeguidos.rpt");
            DataTable Tabla = (DataTable)Datos[1];
            DS_ReporteCIsSeguidos ds = new DS_ReporteCIsSeguidos();
            ds.Tables[0].Merge(Tabla);
            this.Title = "IMPRIMIR " + TituloInforme;
            rptDoc.Load(RutaReporte);
            rptDoc.SetDataSource(ds);
        }
        else if (OpcionInforme.Equals("REPORTE_DE_CIS_RELATIVO_A_SERVICIOS"))
        {
            String RutaReporte = Server.MapPath("CR_Reporte_De_CIS_Relativo_A_Servicios.rpt");
            DataTable Tabla = (DataTable)Datos[1];
            DS_REPORTE_DE_CIS_RELATIVO_A_SERVICIOS ds = new DS_REPORTE_DE_CIS_RELATIVO_A_SERVICIOS();
            ds.Tables[0].Merge(Tabla);
            this.Title = "IMPRIMIR " + TituloInforme;
            rptDoc.Load(RutaReporte);
            rptDoc.SetDataSource(ds);
            rptDoc.SetParameterValue("T", Datos[3]);
            rptDoc.SetParameterValue("A", Datos[4]);
            rptDoc.SetParameterValue("X", Datos[5]);
        }
        else if (OpcionInforme.Equals("REPORTE_DE_CIS_RELACIONADOS_CON_OTROS_CIS"))
        {
            String RutaReporte = Server.MapPath("CR_Reporte_CIS_Relacionados_Con_Otros_CIS.rpt");
            DataTable Tabla = (DataTable)Datos[1];
            DS_Reporte_CIS_Relacionados_Con_Otros_CIS ds = new DS_Reporte_CIS_Relacionados_Con_Otros_CIS();
            ds.Tables[0].Merge(Tabla);
            this.Title = "IMPRIMIR " + TituloInforme;
            rptDoc.Load(RutaReporte);
            rptDoc.SetDataSource(ds);
            rptDoc.SetParameterValue("T", Datos[3]);
            rptDoc.SetParameterValue("A", Datos[4]);
            rptDoc.SetParameterValue("X", Datos[5]);
        }
        //else if (OpcionInforme.Equals("Lista_Seuridad"))
        //{
        //    //rptDoc.Subreports[0].DataSourceConnections.Clear();
        //    //rptDoc.Subreports[0].DataSourceConnections[0].SetConnection(Servidor, BaseDatos, Usuario, Contraseña);
        //    //rptDoc.Subreports[0].SetDatabaseLogon(Usuario, Contraseña);


        //    String RutaReporte = Server.MapPath("CRSeguridad.rpt");


        //    //    ConnectionInfo connectionInfo = new ConnectionInfo();
        //    //    connectionInfo.Attributes.Collection.Add(Ruta);

        //    //    TableLogOnInfos TableLogOnInfos = crvReporte.LogOnInfo;

        //    //    foreach (TableLogOnInfo tableLogOnInfo in TableLogOnInfos)
        //    //    {
        //    //        tableLogOnInfo.ConnectionInfo = connectionInfo;
        //    //    }

        //    //DataSet ds = (DataSet)Datos[1];

        //    DataTable Tabla = (DataTable)Datos[1];
        //    DSSeguridad ds = new DSSeguridad();
        //    //ds.Tables.Add(Tabla);
        //    ds.Tables[0].Merge(Tabla,true);

        //    DataTable Tabla2 = (DataTable)Datos[3];
        //    //ds.Tables.Add(Tabla2);
        //    ds.Tables[1].Merge(Tabla2,true);


        //    //this.Title = ds.Tables[1].Rows.Count.ToString();
        //    this.Title = "IMPRIMIR " + TituloInforme;
        //    rptDoc.Load(RutaReporte);
        //    rptDoc.SetDataSource(ds);
        //}
        //else if (OpcionInforme.Equals("Lista_Incidencia_Personal"))
        //{
        //    String RutaReporte = Server.MapPath("CRLista_Incidencia_Personal.rpt");
        //    DataTable Tabla = (DataTable)Datos[1];
        //    DSLista_Incidencia_Personal ds = new DSLista_Incidencia_Personal();
        //    ds.Tables[0].Merge(Tabla);
        //    this.Title = "IMPRIMIR " + TituloInforme;
        //    rptDoc.Load(RutaReporte);
        //    rptDoc.SetDataSource(ds);
        //}
        //else if (OpcionInforme.Equals("REPORTE_INCIDENCIAS"))
        //{
        //    String RutaReporte = Server.MapPath("CR_REPORTE_INCIDENCIAS.rpt");
        //    DataTable Tabla = (DataTable)Datos[1];
        //    DS_REPORTE_INCIENCIAS ds = new DS_REPORTE_INCIENCIAS();
        //    ds.Tables[0].Merge(Tabla);
        //    this.Title = "IMPRIMIR " + TituloInforme;
        //    rptDoc.Load(RutaReporte);
        //    rptDoc.SetDataSource(ds);
        //}
        //else if (OpcionInforme.Equals("REPORTE_REGISTRO_INCIDENCIAS"))
        //{
        //    String RutaReporte = Server.MapPath("CR_REPORTE_REGISTRO_INCIDENCIAS.rpt");
        //    DataTable Tabla = (DataTable)Datos[1];
        //    DS_REPORTE_REGISTRO_INCIDENCIAS ds = new DS_REPORTE_REGISTRO_INCIDENCIAS();
        //    ds.Tables[0].Merge(Tabla);
        //    this.Title = "IMPRIMIR " + TituloInforme;
        //    rptDoc.Load(RutaReporte);
        //    rptDoc.SetDataSource(ds);
        //}
        //else if (OpcionInforme.Equals("REPORTE_DIAGNOSTICO_INCIDENCIA_TAREAS_ASIGNADAS"))
        //{
        //    String RutaReporte = Server.MapPath("CR_REPORTE_DIAGNOSTICO_INCIDENCIA_TAREAS_ASIGNADAS.rpt");
        //    DataTable Tabla = (DataTable)Datos[1];
        //    DS_REPORTE_DIAGNOSTICO_INCIDENCIA_TAREAS_ASIGNADAS ds = new DS_REPORTE_DIAGNOSTICO_INCIDENCIA_TAREAS_ASIGNADAS();
        //    ds.Tables[0].Merge(Tabla);
        //    this.Title = "IMPRIMIR " + TituloInforme;
        //    rptDoc.Load(RutaReporte);
        //    rptDoc.SetDataSource(ds);
        //}
        //else if (OpcionInforme.Equals("REPORTE_TAREAS_INDIVIDUAL"))
        //{
        //    String RutaReporte = Server.MapPath("CR_REPORTE_TAREAS.rpt");

        //    DataTable Tabla = (DataTable)Datos[1];
        //    DS_REPORTE_TAREAS_INDIVIDUAL ds = new DS_REPORTE_TAREAS_INDIVIDUAL();
        //    //ds.Tables.Add(Tabla);
        //    ds.Tables[0].Merge(Tabla, true);

        //    DataTable Tabla2 = (DataTable)Datos[3];
        //    //ds.Tables.Add(Tabla2);
        //    ds.Tables[1].Merge(Tabla2, true);

        //    this.Title = "IMPRIMIR " + TituloInforme;
        //    rptDoc.Load(RutaReporte);
        //    rptDoc.SetDataSource(ds);
        //}
        //else if (OpcionInforme.Equals("REPORTE_SOLUCIONES"))
        //{
        //    String RutaReporte = Server.MapPath("CR_REPORTE_SOLUCION_DIAGNOSTICO_INCIDENCIAS_TAREAS_ASIGNADAS.rpt");

        //    DataTable Tabla = (DataTable)Datos[1];
        //    DS_REPORTE_SOLUCION_DIAGNOSTICO_INCIDENCIAS_TAREAS_ASIGNADAS ds = new DS_REPORTE_SOLUCION_DIAGNOSTICO_INCIDENCIAS_TAREAS_ASIGNADAS();
        //    //ds.Tables.Add(Tabla);
        //    ds.Tables[0].Merge(Tabla, true);

        //    DataTable Tabla2 = (DataTable)Datos[3];
        //    //ds.Tables.Add(Tabla2);
        //    ds.Tables[1].Merge(Tabla2, true);

        //    this.Title = "IMPRIMIR " + TituloInforme;
        //    rptDoc.Load(RutaReporte);
        //    rptDoc.SetDataSource(ds);
        //}
        //else if (OpcionInforme.Equals("REPORTE_PRUEBAS"))
        //{
        //    String RutaReporte = Server.MapPath("CR_REPORTE_PRUEBA_SOLUCION_DIAGNOSTICO_INCIDENCIAS_TAREAS_ASIGNADAS.rpt");

        //    DataTable Tabla = (DataTable)Datos[1];
        //    DS_REPORTE_PRUEBA_SOLUCION_DIAGNOSTICO_INCIDENCIAS_TAREAS_ASIGNADAS ds = new DS_REPORTE_PRUEBA_SOLUCION_DIAGNOSTICO_INCIDENCIAS_TAREAS_ASIGNADAS();
        //    //ds.Tables.Add(Tabla);
        //    ds.Tables[0].Merge(Tabla, true);

        //    DataTable Tabla2 = (DataTable)Datos[3];
        //    //ds.Tables.Add(Tabla2);
        //    ds.Tables[1].Merge(Tabla2, true);

        //    this.Title = "IMPRIMIR " + TituloInforme;
        //    rptDoc.Load(RutaReporte);
        //    rptDoc.SetDataSource(ds);
        //}
        //else if (OpcionInforme.Equals("REPORTE_INCIDENCIAS_SOLUCIONADAS_X_NIVEL"))
        //{
        //    String RutaReporte = Server.MapPath("CR_REPORTE_INCIDENCIAS_SOLUCIONADAS_X_NIVEL.rpt");
        //    DataTable Tabla = (DataTable)Datos[1];
        //    DS_REPORTE_INCIDENCIAS_SOLUCIONADAS_X_NIVEL ds = new DS_REPORTE_INCIDENCIAS_SOLUCIONADAS_X_NIVEL();
        //    ds.Tables[0].Merge(Tabla);
        //    this.Title = "IMPRIMIR " + TituloInforme;
        //    rptDoc.Load(RutaReporte);
        //    rptDoc.SetDataSource(ds);
        //}
        //else if (OpcionInforme.Equals("REPORTE_IEMPO_PROMEDIO_SOLUCION_INCIDENCIAS_X_NIVELL"))
        //{
        //    String RutaReporte = Server.MapPath("CR_TIEMPO_PROMEDIO_SOLUCION_INCIDENCIAS_X_NIVEL.rpt");
        //    DataTable Tabla = (DataTable)Datos[1];
        //    DS_TIEMPO_PROMEDIO_SOLUCION_INCIDENCIAS_X_NIVEL ds = new DS_TIEMPO_PROMEDIO_SOLUCION_INCIDENCIAS_X_NIVEL();
        //    ds.Tables[0].Merge(Tabla);
        //    this.Title = "IMPRIMIR " + TituloInforme;
        //    rptDoc.Load(RutaReporte);
        //    rptDoc.SetDataSource(ds);
        //}
        //else if (OpcionInforme.Equals("REPORTE_TIEMPO_PROMEDIO_ATENCION_INCIDENCIAS"))
        //{
        //    String RutaReporte = Server.MapPath("CR_REPORTE_TIEMPO_PROMEDIO_ATENCION_INCIDENCIAS.rpt");
        //    DataTable Tabla = (DataTable)Datos[1];
        //    DS_REPORTE_TIEMPO_PROMEDIO_ATENCION_INCIDENCIAS ds = new DS_REPORTE_TIEMPO_PROMEDIO_ATENCION_INCIDENCIAS();
        //    ds.Tables[0].Merge(Tabla);
        //    this.Title = "IMPRIMIR " + TituloInforme;
        //    rptDoc.Load(RutaReporte);
        //    rptDoc.SetDataSource(ds);
        //}
        //else if (OpcionInforme.Equals("REPORTE_PORCENTAJE_INCIDENCIAS_SOLUCIONADAS_DENTRO_SLAS"))
        //{
        //    String RutaReporte = Server.MapPath("CR_REPORTE_PORCENTAJE_INCIDENCIAS_SOLUCIONADAS_DENTRO_SLAS.rpt");
        //    DataTable Tabla = (DataTable)Datos[1];
        //    DS_REPORTE_PORCENTAJE_INCIDENCIAS_SOLUCIONADAS_DENTRO_SLAS ds = new DS_REPORTE_PORCENTAJE_INCIDENCIAS_SOLUCIONADAS_DENTRO_SLAS();
        //    ds.Tables[0].Merge(Tabla);
        //    this.Title = "IMPRIMIR " + TituloInforme;
        //    rptDoc.Load(RutaReporte);
        //    rptDoc.SetDataSource(ds);
        //}
        rptDoc.SetParameterValue("Empresa", Empresa);
        rptDoc.SetParameterValue("Titulo", TituloInforme);
        crvReporte.ReportSource = rptDoc;
        crvReporte.DataBind();
    }
}