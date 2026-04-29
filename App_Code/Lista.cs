using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Web.UI.WebControls;
using System.Drawing;
/// <summary>
/// Summary description for Lista
/// </summary>
/// Secundino Alvites Rodas, Nro Cel. 988305228, josealvites@hotmail.com, Av. Mariscal Castilla Nro. 708 Peru/Reque/Chiclayo/Lambayeque
public class Lista
{
    public Lista()
    {


    }

    //********************** ACTUALIZADO EN REQUE EL 15-03-2023 ***************************
    public void Limpiar_Tabla(System.Web.UI.WebControls.Table tabla)
    {
        for (int i = tabla.Rows.Count-1; i >0 ; i--)
        {
      
            tabla.Rows.RemoveAt(i);
        }
    }


    //********************** AGREGADO EL 30-08-2017 ***************************
    public bool VerificarDetalleOrdenDespacho(DataTable t, System.Web.UI.WebControls.Table tabla, int nrocolumnachecktabladestino, int nrocolumnacomparartablaorigen, int nrocolumnacomparartabladestino)
    {
        bool ok = false;
        for (int i = 0; i < t.Rows.Count; i++)
        {
            for (int j = 1; j < tabla.Rows.Count; j++)
            {
                System.Web.UI.WebControls.CheckBox check;
                check = (System.Web.UI.WebControls.CheckBox)tabla.Rows[j].Cells[nrocolumnachecktabladestino].Controls[0];
                if (check.Checked == true)
                {
                    ok = t.Rows[i].ItemArray[nrocolumnacomparartablaorigen].ToString().Trim() == tabla.Rows[j].Cells[nrocolumnacomparartabladestino].Text.Trim();
                    if (ok == true)
                    {
                        break;
                    }
                }
            } if (ok == true)
            {
                break;
            }
        }
        return ok;
    }

    public DataTable LlenarTabla(System.Web.UI.WebControls.Table tabla, int nrocolumna, DataTable t)
    {
        for (int i = 1; i < tabla.Rows.Count; i++)
        {
            System.Web.UI.WebControls.CheckBox check;
            check = (System.Web.UI.WebControls.CheckBox)tabla.Rows[i].Cells[0].Controls[nrocolumna];
            if (check.Checked == true)
            {
                t.Rows.Add("-1",
                    Convert.ToInt32(tabla.Rows[i].Cells[1].Text.Trim()), //ID VENTA
                    Convert.ToString(tabla.Rows[i].Cells[2].Text.Trim()), // PERSONA
                    Convert.ToString(tabla.Rows[i].Cells[3].Text.Trim()), //codigo VENTA
                    Convert.ToString(tabla.Rows[i].Cells[4].Text.Trim()), // PRODUCCION
                    Convert.ToDouble(tabla.Rows[i].Cells[5].Text.Trim()), //CANTIDAD
                    Convert.ToDouble(tabla.Rows[i].Cells[6].Text.Trim()),//CANTIDAD DESPACHADA
                    Convert.ToDouble(tabla.Rows[i].Cells[7].Text.Trim()),
                    Convert.ToDouble(tabla.Rows[i].Cells[8].Text.Trim()));
            }
        }
        return t;
    }

    public bool VerificeCheck(System.Web.UI.WebControls.Table tabla, int nrocolumna)
    {
        bool ok = false;
        for (int i = 1; i < tabla.Rows.Count; i++)
        {
            System.Web.UI.WebControls.CheckBox check;
            check = (System.Web.UI.WebControls.CheckBox)tabla.Rows[i].Cells[0].Controls[nrocolumna];
            if (check.Checked == true)
            {
                ok = true;
                break;
            }
        }
        return ok;
    }

    // PARA AMORTIZACION DE VENTAS O SERVICIOS
    public DataTable LlenarTabla2(System.Web.UI.WebControls.Table tabla, int nrocolumna, DataTable t)
    {
        for (int i = 1; i < tabla.Rows.Count; i++)
        {
            System.Web.UI.WebControls.CheckBox check;
            check = (System.Web.UI.WebControls.CheckBox)tabla.Rows[i].Cells[0].Controls[nrocolumna];
            if (check.Checked == true)
            {
                t.Rows.Add("-1",
                    Convert.ToInt32(tabla.Rows[i].Cells[1].Text.Trim()), // ID VENTA
                    Convert.ToInt32(tabla.Rows[i].Cells[2].Text.Trim()), // ID VENTA NOTA
                    Convert.ToString(tabla.Rows[i].Cells[3].Text.Trim()),//CODIGO
                    Convert.ToString(tabla.Rows[i].Cells[5].Text.Trim()),//TIPO
                    Convert.ToString(tabla.Rows[i].Cells[7].Text.Trim()), //PERSONA
                    Convert.ToDouble(tabla.Rows[i].Cells[9].Text.Trim()), //IMPORTE
                    Convert.ToDouble(tabla.Rows[i].Cells[9].Text.Trim())); // SALDO
            }
        }
        return t;
    }

    // AGREGADO EL DIA 16-10-2017 --> PARA VENTANA BUSCAR MOVIMIENTOS DE ALMACEN
    public DataTable LlenarTabla3(System.Web.UI.WebControls.Table tabla, int nrocolumna, DataTable t)
    {
        for (int i = 1; i < tabla.Rows.Count; i++)
        {
            System.Web.UI.WebControls.CheckBox check;
            check = (System.Web.UI.WebControls.CheckBox)tabla.Rows[i].Cells[0].Controls[nrocolumna];
            if (check.Checked == true)
            {
                t.Rows.Add("-1",
                    Convert.ToInt32(tabla.Rows[i].Cells[1].Text.Trim()),//ID MOV ALMACEN
                    Convert.ToString(tabla.Rows[i].Cells[2].Text.Trim()),//CODIGO ALMACEN
                    Convert.ToString(tabla.Rows[i].Cells[3].Text.Trim()),//TIPO DE OPERACION
                    Convert.ToString(tabla.Rows[i].Cells[4].Text.Trim()),//OPERACION
                    Convert.ToString(tabla.Rows[i].Cells[5].Text.Trim()),//FECHA
                    Convert.ToString(tabla.Rows[i].Cells[6].Text.Trim()),//FUNDO
                    Convert.ToString(tabla.Rows[i].Cells[7].Text.Trim()),//CLIENTE/PROVEEDOR
                    Convert.ToString(tabla.Rows[i].Cells[8].Text.Trim()),//TIPO DE COMPROBANTE
                    Convert.ToString(tabla.Rows[i].Cells[9].Text.Trim()),//SERIE
                    Convert.ToString(tabla.Rows[i].Cells[10].Text.Trim()),//NUMERO
                    Convert.ToString(tabla.Rows[i].Cells[11].Text.Trim()),//MONEDA
                    Convert.ToDouble(tabla.Rows[i].Cells[14].Text.Trim()),//[TOTAL A COBRAR]
                    Convert.ToDouble(tabla.Rows[i].Cells[13].Text.Trim()),//[CANT. AMORTIZACION]
                    Convert.ToDouble(tabla.Rows[i].Cells[14].Text.Trim()));//SALDO
            }
        }
        return t;
    }

    // AGREGADO EL DIA 25-10-2017 --> PARA VENTANA BUSCAR PRODUCCION PARA REGISTRAR VENTA A O SERVICIO
    public DataTable LlenarTabla4(System.Web.UI.WebControls.Table tabla, int nrocolumna, DataTable t)
    {
        for (int i = 1; i < tabla.Rows.Count; i++)
        {
            System.Web.UI.WebControls.CheckBox check;
            check = (System.Web.UI.WebControls.CheckBox)tabla.Rows[i].Cells[0].Controls[nrocolumna];
            if (check.Checked == true)
            {
                t.Rows.Add("-1", // "ID DET VENTA SER"
                    Convert.ToInt32(tabla.Rows[i].Cells[1].Text.Trim()),//_IDDETPRO
                    Convert.ToString(tabla.Rows[i].Cells[2].Text.Trim()),//_NROPRODUCCION
                    Convert.ToString(tabla.Rows[i].Cells[4].Text.Trim()),//_FUNDO
                    Convert.ToString(tabla.Rows[i].Cells[5].Text.Trim()),//_LOTE
                    Convert.ToString(tabla.Rows[i].Cells[6].Text.Trim()),//_PRODUCCION
                     Convert.ToDouble(tabla.Rows[i].Cells[7].Text.Trim()),//STOCK
                     Convert.ToDouble(tabla.Rows[i].Cells[7].Text.Trim()),//CANTIDAD
                     "0", // CANTIDAD RECHAZADA
                     Convert.ToDouble(tabla.Rows[i].Cells[8].Text.Trim()),//PRECIO
                     Convert.ToDouble(tabla.Rows[i].Cells[9].Text.Trim()),//SUB TOTAL
                     Convert.ToDouble(tabla.Rows[i].Cells[10].Text.Trim()),//IGV
                     Convert.ToDouble(tabla.Rows[i].Cells[11].Text.Trim())// TOTAL
               );
            }
        }
        return t;
    }
    //********************** AGREGADO EL 15-08-2017 ***************************
    public bool VerificarCodigoDetalleProduccionDetalleVentaServicio(DataTable t, String CodigoDetalleProduccion)
    {
        bool ok = false;
        for (int i = 0; i < t.Rows.Count; i++)
        {
            ok = t.Rows[i].ItemArray[1].ToString().Trim() == CodigoDetalleProduccion.Trim();
            if (ok == true)
            {
                break;
            }
        }
        return ok;
    }

    public bool VerificarEditarNumeroComprobante(DataTable t, String Comprobante, String Numero, String Serie, int FilaEditar)
    {
        bool ok = false;
        for (int i = 0; i < t.Rows.Count; i++)
        {
            if (i != FilaEditar)
            {
                ok = t.Rows[i].ItemArray[2].ToString().Trim() == Comprobante.Trim();
                ok = ok && t.Rows[i].ItemArray[3].ToString().Trim() == Numero.Trim();
                ok = ok && t.Rows[i].ItemArray[4].ToString().Trim() == Serie.Trim();
                if (ok == true)
                {
                    break;
                }
            }
        }
        return ok;
    }

    //AGREGADO EL DIA 14-02-2018
    public bool VerificarEditarTipoComprobanteEstado(DataTable t, String Comprobante, String Estado, int FilaEditar)
    {
        bool ok = false;
        for (int i = 0; i < t.Rows.Count; i++)
        {
            if (i != FilaEditar)
            {
                ok = t.Rows[i].ItemArray[2].ToString().Trim() == Comprobante.Trim();
                //ok = ok && t.Rows[i].ItemArray[3].ToString().Trim() == Numero.Trim();
                //ok = ok && t.Rows[i].ItemArray[4].ToString().Trim() == Serie.Trim();
                ok = ok && t.Rows[i].ItemArray[5].ToString().Trim() == Estado.Trim();
                if (ok == true)
                {
                    break;
                }
            }
        }
        return ok;
    }

    public bool VerificarNumeroComprobante(DataTable t, String Comprobante, String Numero, String Serie)
    {
        bool ok = false;
        for (int i = 0; i < t.Rows.Count; i++)
        {
            ok = t.Rows[i].ItemArray[2].ToString().Trim() == Comprobante.Trim();
            ok = ok && t.Rows[i].ItemArray[3].ToString().Trim() == Numero.Trim();
            ok = ok && t.Rows[i].ItemArray[4].ToString().Trim() == Serie.Trim();
           // ok = ok && t.Rows[i].ItemArray[5].ToString().Trim() == Estado.Trim();
            if (ok == true)
            {
                break;
            }
        }
        return ok;
    }

    public bool VerificarNumeroComprobanteEstado(DataTable t, String Comprobante, String Numero, String Serie, String Estado)
    {
        bool ok = false;
        for (int i = 0; i < t.Rows.Count; i++)
        {
            ok = t.Rows[i].ItemArray[2].ToString().Trim() == Comprobante.Trim();
            ok = ok && t.Rows[i].ItemArray[3].ToString().Trim() == Numero.Trim();
            ok = ok && t.Rows[i].ItemArray[4].ToString().Trim() == Serie.Trim();
            ok = ok && t.Rows[i].ItemArray[5].ToString().Trim() == Estado.Trim();
            if (ok == true)
            {
                break;
            }
        }
        return ok;
    }

    // AGREGADO EL DIA 14-02-2018
    public bool VerificarTipoComprobanteEstado(DataTable t, String Comprobante, String Estado)
    {
        bool ok = false;
        for (int i = 0; i < t.Rows.Count; i++)
        {
            ok = t.Rows[i].ItemArray[2].ToString().Trim() == Comprobante.Trim();
            //ok = ok && t.Rows[i].ItemArray[3].ToString().Trim() == Numero.Trim();
            //ok = ok && t.Rows[i].ItemArray[4].ToString().Trim() == Serie.Trim();
            ok = ok && t.Rows[i].ItemArray[5].ToString().Trim() == Estado.Trim();
            if (ok == true)
            {
                break;
            }
        }
        return ok;
    }
    //********************** AGREGADO EL 05-07-2017 ***************************
    //************* ELIMINAR COLUMNAS CUYOS TOTALES SEAN "0" *****************
    public DataTable EliminarColumnaTablaTotalSeaCero(DataTable dt)
    {

        int valor = -1;

        int j = dt.Columns.Count - 1;

        while (j >= 0)
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                valor = -1;

                if (dt.Rows[i].ItemArray[j].ToString().Trim() == "0")
                {
                    valor = Convert.ToInt32(dt.Rows[i].ItemArray[j]);
                }
            }

            if (valor == 0)
            {
                dt.Columns.RemoveAt(j);

                valor = -1;
            }

            j--;
        }

        return dt;
    }

    //********************** AGREGADO EL 05-07-2017 ***************************
    //************* AGREGAR RATIOS A REPORTE DE COSECHA - PRODUCCION POR DIA  *****************
    public int ObtenerNroFilaEnBlanco(DataTable dt)
    {
        int fila = 0;

        for (int i = 0; i < dt.Rows.Count; i++)
        {
            if (dt.Rows[i].ItemArray[1].ToString().Trim() == "")
            {
                fila = i;

                break;
            }
        }

        return fila;
    }



    //public DataTable Ratio_Cosecha_Produccion_Por_Dia(DataTable dtdc, DataTable dtdcc, DataTable dtdp)
    //{
    //    DataTable dt = new DataTable();

    //    dt.Columns.Add("Ratio");

    //    dt.Columns.Add("Valor");

    //    for (int i = 0; i < dtdp.Rows.Count; i++)
    //    {
    //        bool ok = dtdp.Rows[i].ItemArray[0].ToString().Trim() != "";

    //        ok = ok && dtdp.Rows[i].ItemArray[1].ToString().Trim() != "";

    //        if (ok == true)
    //        {
    //            dt.Rows.Add("RATIO GENERAL (" + dtdp.Rows[i].ItemArray[1].ToString().Trim() + ")");
    //        }
    //        else
    //        {
    //            break;
    //        }
    //    }

    //    for (int i = 0; i < dtdp.Rows.Count; i++)
    //    {
    //        bool ok = dtdp.Rows[i].ItemArray[0].ToString().Trim() != "";

    //        ok = ok && dtdp.Rows[i].ItemArray[1].ToString().Trim() != "";

    //        if (ok == true)
    //        {
    //            dt.Rows.Add("RATIO PROCESADO (" + dtdp.Rows[i].ItemArray[1].ToString().Trim() + ")");
    //        }
    //        else
    //        {
    //            break;
    //        }
    //    }

    //    dt.Rows.Add("RATIO DESCARTE");

    //    DataRow FilaTabla;

    //    //obtenemos el TOTAL GENERAL de DETALLE DE COSECHA.

    //    double totalgeneral = Convert.ToDouble(dtdc.Rows[dtdc.Rows.Count - 1].ItemArray[dtdc.Columns.Count - 1]);

    //    for (int i = 0; i < dtdp.Rows.Count; i++)
    //    {
    //        bool ok = dtdp.Rows[i].ItemArray[0].ToString().Trim() != "";

    //        ok = ok && dtdp.Rows[i].ItemArray[1].ToString().Trim() != "";

    //        if (ok == true)
    //        {
    //            FilaTabla = dt.Rows[i];

    //            FilaTabla.BeginEdit();

    //            FilaTabla[dt.Columns.Count - 1] =Math.Round(( Convert.ToDouble(dtdp.Rows[i].ItemArray[dtdp.Columns.Count - 1]) / totalgeneral),2);

    //            FilaTabla.EndEdit();

    //            dt.AcceptChanges();
    //        }
    //        else
    //        {
    //            break;
    //        }
    //    }

    //    //obtenemos el TOTAL del TIPO RACIMOS de DETALLE DE COSECHA.

    //    double total = 0;

    //    for (int i = 0; i < dtdc.Rows.Count; i++)
    //    {
    //        bool ok = dtdc.Rows[i].ItemArray[0].ToString().Trim() == "";

    //        ok = ok && dtdc.Rows[i].ItemArray[1].ToString().Trim() != "";

    //        if (ok == true)
    //        {
    //            total = Convert.ToDouble(dtdc.Rows[i].ItemArray[dtdc.Columns.Count - 1]);

    //            break;
    //        }
    //    }

    //    int j = ObtenerNroFilaEnBlanco(dt);

    //    for (int i = 0; i < dtdp.Rows.Count; i++)
    //    {
    //        bool ok = dtdp.Rows[i].ItemArray[0].ToString().Trim() != "";

    //        ok = ok && dtdp.Rows[i].ItemArray[1].ToString().Trim() != "";

    //        if (ok == true)
    //        {
    //            FilaTabla = dt.Rows[j];

    //            FilaTabla.BeginEdit();

    //            FilaTabla[dt.Columns.Count - 1] = Math.Round(( Convert.ToDouble(dtdp.Rows[i].ItemArray[dtdp.Columns.Count - 1]) / total),2);

    //            FilaTabla.EndEdit();

    //            dt.AcceptChanges();

    //            j += 1;
    //        }
    //        else
    //        {
    //            break;
    //        }
    //    }

    //    //obtenemos el TOTAL antes del TOTAL GENERAL de DETALLE DE PRODUCCION.

    //    double total2 = Convert.ToDouble(dtdp.Rows[dtdp.Rows.Count - 2].ItemArray[dtdp.Columns.Count - 1]);

    //    FilaTabla = dt.Rows[dt.Rows.Count - 1];

    //    FilaTabla.BeginEdit();

    //    FilaTabla[dt.Columns.Count - 1] = Math.Round((total2 / total),2);

    //    FilaTabla.EndEdit();

    //    dt.AcceptChanges();

    //    return dt;
    //}


    //********************** AGREGADO EL 02-07-2017 ***************************

    public DataTable Ratio_Cosecha_Produccion_Por_Dia(DataTable dtdc, DataTable dtdcc, DataTable dtdp)
    {
        DataTable dt = new DataTable();

        dt.Columns.Add("RATIO");

        for (int i = 2; i < dtdp.Columns.Count; i++)
        {
            dt.Columns.Add(dtdp.Columns[i].Caption);
        }

        for (int i = 0; i < dtdp.Rows.Count; i++)
        {
            bool ok = dtdp.Rows[i].ItemArray[0].ToString().Trim() != "";

            ok = ok && dtdp.Rows[i].ItemArray[1].ToString().Trim() != "";

            if (ok == true)
            {
                dt.Rows.Add("RATIO GENERAL (" + dtdp.Rows[i].ItemArray[1].ToString().Trim() + ")");
            }
            else
            {
                break;
            }
        }

        for (int i = 0; i < dtdp.Rows.Count; i++)
        {
            bool ok = dtdp.Rows[i].ItemArray[0].ToString().Trim() != "";

            ok = ok && dtdp.Rows[i].ItemArray[1].ToString().Trim() != "";

            if (ok == true)
            {
                dt.Rows.Add("RATIO PROCESADO (" + dtdp.Rows[i].ItemArray[1].ToString().Trim() + ")");
            }
            else
            {
                break;
            }
        }

        dt.Rows.Add("RATIO DESCARTE");

        DataRow FilaTabla;

        int k = 1;

        for (int j = 2; j < dtdp.Columns.Count; j++)
        {
            FilaTabla = dt.Rows[0];

            FilaTabla.BeginEdit();

            FilaTabla[k] = Math.Round((Convert.ToDouble(dtdp.Rows[1].ItemArray[j]) / Convert.ToDouble(dtdc.Rows[dtdc.Rows.Count - 1].ItemArray[j])), 2);

            FilaTabla.EndEdit();

            dt.AcceptChanges();

            k++;
        }

        k = 1;

        for (int j = 2; j < dtdp.Columns.Count; j++)
        {
            FilaTabla = dt.Rows[1];

            FilaTabla.BeginEdit();

            FilaTabla[k] = Math.Round((Convert.ToDouble(dtdp.Rows[1].ItemArray[j]) / Convert.ToDouble(dtdc.Rows[1].ItemArray[j])), 2);

            FilaTabla.EndEdit();

            dt.AcceptChanges();

            k++;
        }

        k = 1;

        for (int j = 2; j < dtdp.Columns.Count; j++)
        {
            FilaTabla = dt.Rows[2];

            FilaTabla.BeginEdit();

            FilaTabla[k] = Math.Round((Convert.ToDouble(dtdp.Rows[dtdp.Rows.Count - 2].ItemArray[j]) / Convert.ToDouble(dtdc.Rows[1].ItemArray[j])), 2);

            FilaTabla.EndEdit();

            dt.AcceptChanges();

            k++;
        }


        return dt;
    }
    public int Total_Columna_Individual_Tabla(DataTable t, String Descripcion, int Columna)
    {
        int suma = 0;

        for (int i = 0; i < t.Rows.Count; i++)
        {
            if (t.Rows[i].ItemArray[0].ToString().Trim() == Descripcion)
            {
                suma = suma + Convert.ToInt32(t.Rows[i].ItemArray[Columna]);
            }
        }

        return suma;
    }

    public DataTable Generar_Totales_Filas_3(DataTable t, int ColumnaPrincipalComparar, int ColumnaInicioTotalizar, String FilaNombreRatio)
    {
        DataTable Tabla = t.Clone();

        Tabla.Clear();

        ListBox l = new ListBox();

        for (int i = 0; i < t.Rows.Count - 1; i++)
        {

            if (this.Verifica(l, t.Rows[i].ItemArray[ColumnaPrincipalComparar].ToString().Trim()) == false)
            {

                l.Items.Add(t.Rows[i].ItemArray[ColumnaPrincipalComparar].ToString().Trim());
            }

        }

        for (int i = 0; i < l.Items.Count; i++)
        {
            Tabla.Rows.Add(l.Items[i].Text.Trim());

        }

        object[,] totales_columnas = new object[l.Items.Count, t.Columns.Count - ColumnaInicioTotalizar];

        for (int i = 0; i < l.Items.Count; i++)
        {
            for (int j = ColumnaInicioTotalizar; j < t.Columns.Count; j++)
            {
                totales_columnas[i, j - 1] = Total_Columna_Individual_Tabla(t, l.Items[i].Text.Trim(), j);
            }
        }

        for (int i = 0; i < Tabla.Rows.Count; i++)
        {
            for (int j = ColumnaInicioTotalizar; j < Tabla.Columns.Count; j++)
            {
                DataRow FilaTabla = Tabla.Rows[i];

                FilaTabla.BeginEdit();

                FilaTabla[j] = Convert.ToInt32(totales_columnas[i, j - 1]);

                FilaTabla.EndEdit();

                Tabla.AcceptChanges();
            }
        }

        if (FilaNombreRatio.Trim() != "")
        {
            Tabla.Rows.Add(FilaNombreRatio);

            for (int j = ColumnaInicioTotalizar; j < Tabla.Columns.Count; j++)
            {
                DataRow FilaTabla = Tabla.Rows[Tabla.Rows.Count - 1];

                FilaTabla.BeginEdit();

                if ((Convert.ToDouble(Tabla.Rows[1].ItemArray[j]) / Convert.ToDouble(Tabla.Rows[0].ItemArray[j])).ToString() == "NaN")
                {
                    FilaTabla[j] = 0;
                }
                else
                {
                    FilaTabla[j] = Math.Round( Convert.ToDouble(Tabla.Rows[1].ItemArray[j]) / Convert.ToDouble(Tabla.Rows[0].ItemArray[j]),2);
                }

                FilaTabla.EndEdit();

                Tabla.AcceptChanges();
            }
        }


        return Tabla;

    }

    //----------------*******************************------------------------------------------------------------

    public DataTable Generar_Totales_Filas_2(DataTable t, int ColumnaPrincipalComparar, int ColumnaInicioTotalizar)
    {
        DataTable Tabla = t.Clone();

        Tabla.Clear();

        ListBox l = new ListBox();

        for (int i = 0; i < t.Rows.Count - 1; i++)
        {

            if (Convert.ToInt32(t.Rows[i].ItemArray[ColumnaPrincipalComparar].ToString().Trim()) != Convert.ToInt32(t.Rows[i + 1].ItemArray[ColumnaPrincipalComparar].ToString().Trim()))
            {

                l.Items.Add(t.Rows[i].ItemArray[ColumnaPrincipalComparar].ToString().Trim());

            }

        }

        if (l.Items.Count != 0)
        {

            l.Items.Add(t.Rows[t.Rows.Count - 1].ItemArray[ColumnaPrincipalComparar].ToString().Trim());
        }
        else
        {
            l.Items.Add(t.Rows[t.Rows.Count - 1].ItemArray[ColumnaPrincipalComparar].ToString().Trim());
        }

        int columnas = t.Columns.Count - ColumnaInicioTotalizar;

        int[] total = new int[columnas];

        DataView dv;

        dv = t.DefaultView;

        for (int w = 0; w < l.Items.Count; w++)
        {
            String[] parcial = new String[columnas];

            dv.RowFilter = "SEMANA='" + l.Items[w].Text + "'";

            //filas adicionar

            //Tabla = dv.ToTable();

            for (int i = 0; i < dv.ToTable().Rows.Count; i++)
            {
                Tabla.Rows.Add(dv.ToTable().Rows[i].ItemArray);
            }

            int suma = 0;

            for (int j = ColumnaInicioTotalizar, k = 0; j < dv.ToTable().Columns.Count && k < columnas; j++, k++)
            {
                for (int i = 0; i < dv.Count; i++)
                {
                    suma = suma + Convert.ToInt32(dv.ToTable().Rows[i].ItemArray[j]);
                }

                parcial[k] = suma.ToString();

                total[k] = total[k] + suma;

                suma = 0;
            }

            Tabla.Rows.Add();

            for (int j = ColumnaInicioTotalizar, k = 0; j < dv.ToTable().Columns.Count && k < columnas; j++, k++)
            {
                DataRow FilaTabla = Tabla.Rows[Tabla.Rows.Count - 1];

                FilaTabla.BeginEdit();

                FilaTabla[ColumnaInicioTotalizar - 1] = "TOTAL";

                FilaTabla[j] = Convert.ToInt32(parcial[k]);

                FilaTabla.EndEdit();

                Tabla.AcceptChanges();
            }
        }

        Tabla.Rows.Add();

        for (int j = ColumnaInicioTotalizar, k = 0; j < dv.ToTable().Columns.Count && k < columnas; j++, k++)
        {
            DataRow FilaTabla = Tabla.Rows[Tabla.Rows.Count - 1];

            FilaTabla.BeginEdit();

            FilaTabla[ColumnaInicioTotalizar - 1] = "TOTAL GENERAL";

            FilaTabla[j] = Convert.ToInt32(total[k]);

            FilaTabla.EndEdit();

            Tabla.AcceptChanges();
        }


        return Tabla;

    }


    //----------------*******************************------------------------------------------------------------

    public DataTable Generar_Totales_Filas_3(DataTable t, int ColumnaPrincipalComparar, int ColumnaInicioTotalizar)
    {
        DataTable Tabla = t.Clone();

        Tabla.Clear();

        ListBox l = new ListBox();

        for (int i = 0; i < t.Rows.Count - 1; i++)
        {

            if (Convert.ToString(t.Rows[i].ItemArray[ColumnaPrincipalComparar].ToString().Trim()) != Convert.ToString(t.Rows[i + 1].ItemArray[ColumnaPrincipalComparar].ToString().Trim()))
            {

                l.Items.Add(t.Rows[i].ItemArray[ColumnaPrincipalComparar].ToString().Trim());

            }

        }

        if (l.Items.Count != 0)
        {

            l.Items.Add(t.Rows[t.Rows.Count - 1].ItemArray[ColumnaPrincipalComparar].ToString().Trim());
        }
        else
        {
            l.Items.Add(t.Rows[t.Rows.Count - 1].ItemArray[ColumnaPrincipalComparar].ToString().Trim());
        }

        int columnas = t.Columns.Count - ColumnaInicioTotalizar;

        double[] total = new double[columnas];

        DataView dv;

        dv = t.DefaultView;

        for (int w = 0; w < l.Items.Count; w++)
        {
            String[] parcial = new String[columnas];

            dv.RowFilter = "FUNDO='" + l.Items[w].Text + "'";

            //filas adicionar

            //Tabla = dv.ToTable();

            for (int i = 0; i < dv.ToTable().Rows.Count; i++)
            {
                Tabla.Rows.Add(dv.ToTable().Rows[i].ItemArray);
            }

            double suma = 0;

            for (int j = ColumnaInicioTotalizar, k = 0; j < dv.ToTable().Columns.Count && k < columnas; j++, k++)
            {
                for (int i = 0; i < dv.Count; i++)
                {
                    suma = suma + Convert.ToDouble(dv.ToTable().Rows[i].ItemArray[j]);
                }

                parcial[k] = suma.ToString();

                total[k] = total[k] + suma;

                suma = 0;
            }

            Tabla.Rows.Add();

            for (int j = ColumnaInicioTotalizar, k = 0; j < dv.ToTable().Columns.Count && k < columnas; j++, k++)
            {
                DataRow FilaTabla = Tabla.Rows[Tabla.Rows.Count - 1];

                FilaTabla.BeginEdit();

                FilaTabla[ColumnaInicioTotalizar - 1] = "TOTAL";

                FilaTabla[j] = Convert.ToDouble(parcial[k]);

                FilaTabla.EndEdit();

                Tabla.AcceptChanges();
            }
        }

        Tabla.Rows.Add();

        for (int j = ColumnaInicioTotalizar, k = 0; j < dv.ToTable().Columns.Count && k < columnas; j++, k++)
        {
            DataRow FilaTabla = Tabla.Rows[Tabla.Rows.Count - 1];

            FilaTabla.BeginEdit();

            FilaTabla[ColumnaInicioTotalizar - 1] = "TOTAL GENERAL";

            FilaTabla[j] = Convert.ToDouble(total[k]);

            FilaTabla.EndEdit();

            Tabla.AcceptChanges();
        }


        return Tabla;

    }

    public DataTable Generar_Totales(DataTable t, int ColumnaInicioTotalizar)
    {
        DataTable Tabla = t.Clone();

        Tabla.Clear();

        ListBox l = new ListBox();

        for (int i = 0; i < t.Rows.Count - 1; i++)
        {

            if (Convert.ToInt32(t.Rows[i].ItemArray[0].ToString().Trim()) != Convert.ToInt32(t.Rows[i + 1].ItemArray[0].ToString().Trim()))
            {

                l.Items.Add(t.Rows[i].ItemArray[0].ToString().Trim());

            }

        }

        if (l.Items.Count != 0)
        {

            l.Items.Add(t.Rows[t.Rows.Count - 1].ItemArray[0].ToString().Trim());
        }
        else
        {
            l.Items.Add(t.Rows[t.Rows.Count - 1].ItemArray[0].ToString().Trim());
        }

        int columnas = t.Columns.Count - ColumnaInicioTotalizar;

        int[] total = new int[columnas];

        DataView dv;

        dv = t.DefaultView;

        for (int w = 0; w < l.Items.Count; w++)
        {
            String[] parcial = new String[columnas];

            dv.RowFilter = "SEMANA='" + l.Items[w].Text + "'";

            //filas adicionar

            //Tabla = dv.ToTable();

            for (int i = 0; i < dv.ToTable().Rows.Count; i++)
            {
                Tabla.Rows.Add(dv.ToTable().Rows[i].ItemArray);
            }

            int suma = 0;

            for (int j = ColumnaInicioTotalizar, k = 0; j < dv.ToTable().Columns.Count && k < columnas; j++, k++)
            {
                for (int i = 0; i < dv.Count; i++)
                {
                    suma = suma + Convert.ToInt32(dv.ToTable().Rows[i].ItemArray[j]);
                }

                parcial[k] = suma.ToString();

                total[k] = total[k] + suma;

                suma = 0;
            }

            Tabla.Rows.Add();

            for (int j = ColumnaInicioTotalizar, k = 0; j < dv.ToTable().Columns.Count && k < columnas; j++, k++)
            {
                DataRow FilaTabla = Tabla.Rows[Tabla.Rows.Count - 1];

                FilaTabla.BeginEdit();

                FilaTabla[ColumnaInicioTotalizar - 1] = "TOTAL";

                FilaTabla[j] = Convert.ToInt32(parcial[k]);

                FilaTabla.EndEdit();

                Tabla.AcceptChanges();
            }
        }

        Tabla.Rows.Add();

        for (int j = ColumnaInicioTotalizar, k = 0; j < dv.ToTable().Columns.Count && k < columnas; j++, k++)
        {
            DataRow FilaTabla = Tabla.Rows[Tabla.Rows.Count - 1];

            FilaTabla.BeginEdit();

            FilaTabla[ColumnaInicioTotalizar - 1] = "TOTAL GENERAL";

            FilaTabla[j] = Convert.ToInt32(total[k]);

            FilaTabla.EndEdit();

            Tabla.AcceptChanges();
        }


        return Tabla;

    }

    public DataTable Generar_Totales_Columna(DataTable t, int ColumnaInicioTotalizar)
    {
        DataTable Tabla = t;

        int ColumnaFinal = Tabla.Columns.Count - 1;

        int Suma = 0;

        for (int i = 0; i < Tabla.Rows.Count; i++)
        {
            for (int j = ColumnaInicioTotalizar; j < ColumnaFinal; j++)
            {
                Suma += Convert.ToInt32(Tabla.Rows[i].ItemArray[j].ToString());
            }

            DataRow FilaTabla = Tabla.Rows[i];

            FilaTabla.BeginEdit();

            FilaTabla[ColumnaFinal] = Convert.ToInt32(Suma);

            FilaTabla.EndEdit();

            Tabla.AcceptChanges();

            Suma = 0;
        }

        return Tabla;
    }

    public DataTable Generar_Totales_Filas(DataTable t, int ColumnaInicioTotalizar)
    {
        DataTable Tabla = t.Clone();

        Tabla.Clear();

        ListBox l = new ListBox();

        for (int i = 0; i < t.Rows.Count - 1; i++)
        {

            if (Convert.ToInt32(t.Rows[i].ItemArray[0].ToString().Trim()) != Convert.ToInt32(t.Rows[i + 1].ItemArray[0].ToString().Trim()))
            {

                l.Items.Add(t.Rows[i].ItemArray[0].ToString().Trim());

            }

        }

        if (l.Items.Count != 0)
        {

            l.Items.Add(t.Rows[t.Rows.Count - 1].ItemArray[0].ToString().Trim());
        }
        else
        {
            l.Items.Add(t.Rows[t.Rows.Count - 1].ItemArray[0].ToString().Trim());
        }

        int columnas = t.Columns.Count - ColumnaInicioTotalizar;

        int[] total = new int[columnas];

        DataView dv;

        dv = t.DefaultView;

        for (int w = 0; w < l.Items.Count; w++)
        {
            String[] parcial = new String[columnas];

            dv.RowFilter = "SEMANA='" + l.Items[w].Text + "'";

            //filas adicionar

            //Tabla = dv.ToTable();

            for (int i = 0; i < dv.ToTable().Rows.Count; i++)
            {
                Tabla.Rows.Add(dv.ToTable().Rows[i].ItemArray);
            }

            int suma = 0;

            for (int j = ColumnaInicioTotalizar, k = 0; j < dv.ToTable().Columns.Count && k < columnas; j++, k++)
            {
                for (int i = 0; i < dv.Count; i++)
                {
                    suma = suma + Convert.ToInt32(dv.ToTable().Rows[i].ItemArray[j]);
                }

                parcial[k] = suma.ToString();

                total[k] = total[k] + suma;

                suma = 0;
            }

            Tabla.Rows.Add();

            for (int j = ColumnaInicioTotalizar, k = 0; j < dv.ToTable().Columns.Count && k < columnas; j++, k++)
            {
                DataRow FilaTabla = Tabla.Rows[Tabla.Rows.Count - 1];

                FilaTabla.BeginEdit();

                FilaTabla[ColumnaInicioTotalizar - 1] = "TOTAL";

                FilaTabla[j] = Convert.ToInt32(parcial[k]);

                FilaTabla.EndEdit();

                Tabla.AcceptChanges();
            }
        }

        Tabla.Rows.Add();

        for (int j = ColumnaInicioTotalizar, k = 0; j < dv.ToTable().Columns.Count && k < columnas; j++, k++)
        {
            DataRow FilaTabla = Tabla.Rows[Tabla.Rows.Count - 1];

            FilaTabla.BeginEdit();

            FilaTabla[ColumnaInicioTotalizar - 1] = "TOTAL GENERAL";

            FilaTabla[j] = Convert.ToInt32(total[k]);

            FilaTabla.EndEdit();

            Tabla.AcceptChanges();
        }


        return Tabla;

    }
    public int Contabiliza(ListBox l, String Texto)
    {
        int cuenta = 0;

        for (int i = 0; i < l.Items.Count; i++)
        {

            if (l.Items[i].Text.Trim() == Texto)
            {
                cuenta += 1;
            }
        }

        return cuenta;
    }

    public Boolean Verifica(ListBox l, String Texto)
    {
        bool ok = false;

        for (int i = 0; i < l.Items.Count; i++)
        {

            if (l.Items[i].Text.Trim() == Texto)
            {
                ok = true;

                break;
            }
        }

        return ok;
    }

    //public bool Verifica_Detalles_Cosecha_Produccion_Fundos_Lotes_Iguales(DataTable tdc, DataTable tdcc, DataTable tdp)
    public bool Verifica_Detalles_Cosecha_Produccion_Fundos_Lotes_Iguales(DataTable tdc, DataTable tdp)
    {
        bool ok = false;

        int a = tdc.Rows.Count;

       // int b = tdcc.Rows.Count;

        int c = tdp.Rows.Count;

        string fundo1 = "", lote1 = "";

       // string fundo2 = "", lote2 = "";

        string fundo3 = "", lote3 = "";

        ListBox Registro = new ListBox();

       // if (a > 0 && b > 0 && c > 0)
            if (a > 0 && c > 0)
        {
            for (int i = 0; i < a; i++)
            {
                fundo1 = tdc.Rows[i].ItemArray[2].ToString().Trim();    //fundo detalle cosecha.

                lote1 = tdc.Rows[i].ItemArray[3].ToString().Trim();    //lote detalle cosecha. 

                Registro.Items.Add(fundo1 + " " + lote1);
            }

            //for (int j = 0; j < b; j++)
            //{
            //    fundo2 = tdcc.Rows[j].ItemArray[2].ToString().Trim();    //fundo detalle cosecha color.

            //    lote2 = tdcc.Rows[j].ItemArray[3].ToString().Trim();    //lote detalle cosecha color.

            //    Registro.Items.Add(fundo2 + " " + lote2);
            //}

            for (int k = 0; k < c; k++)
            {
                fundo3 = tdp.Rows[k].ItemArray[2].ToString().Trim();    //fundo detalle produccion.

                lote3 = tdp.Rows[k].ItemArray[3].ToString().Trim();    //lote detalle produccion.

                Registro.Items.Add(fundo3 + " " + lote3);
            }

            for (int l = 0; l < Registro.Items.Count; l++)
            {
               // if (Contabiliza(Registro, Registro.Items[l].Text.Trim()) <= 2)
                    if (Contabiliza(Registro, Registro.Items[l].Text.Trim()) <= 1)
                {

                    ok = true;

                    break;
                }
            }



            /*
             * fundo1 lote3  0
             * fundo1 lote5  1
             * fundo1 lote3  2              
             * */

            //for(int i = 0; i < a; i++)
            //{
            //    fundo1 = tdc.Rows[i].ItemArray[2].ToString().Trim();    //fundo detalle cosecha.

            //    lote1 = tdc.Rows[i].ItemArray[3].ToString().Trim();    //lote detalle cosecha. 

            //    for (int j = 0; j < b; j++)
            //    {
            //        fundo2 = tdcc.Rows[j].ItemArray[2].ToString().Trim();    //fundo detalle cosecha color.

            //        lote2 = tdcc.Rows[j].ItemArray[3].ToString().Trim();    //lote detalle cosecha color.

            //        for (int k = 0; k < c; k++)
            //        {
            //            fundo3 = tdp.Rows[k].ItemArray[2].ToString().Trim();    //fundo detalle produccion.

            //            lote3 = tdp.Rows[k].ItemArray[3].ToString().Trim();    //lote detalle produccion.

            //            if (!(fundo1 == fundo2 && fundo1 == fundo3 && fundo2 == fundo3 && lote1 == lote2 && lote1 == lote3 && lote2 == lote3))
            //            {
            //                ok = true;

            //                break;
            //            }
            //        }

            //        if (ok == true)
            //        {
            //            break;
            //        }
            //    }

            //    if (ok == true)
            //    {
            //        break;
            //    }
            //}
        }
       // else if (a > 0 && b > 0 && c == 0)
     else if (a > 0  && c == 0)
        {

        }
        //else if (a > 0 && b == 0 && c > 0)
      else if (a > 0  && c > 0)
        {

        }
      //  else if (a == 0 && b > 0 && c > 0)
        else if (a == 0  && c > 0)
        {

        }

        return ok;
    }

  
    public bool Verifica_Detalle_Produccion_Lotes_Fundo(DataTable t, string fundo)//2,3,5
    {
        bool ok = true;

        for (int i = 0; i < t.Rows.Count; i++)
        {
            string filafundo = t.Rows[i].ItemArray[2].ToString().Trim();

            if (!(filafundo == fundo))
            {
                ok = false;

                break;
            }
        }

        return ok;
    }

    //public bool Verifica__Detalle_Produccion_Lotes_Empacadora(DataTable t, string lote, string empacadora)//2,3,9
    //{
    //    bool ok = true;

    //    for (int i = 0; i < t.Rows.Count; i++)
    //    {

    //       // string filafundo = t.Rows[i].ItemArray[2].ToString().Trim();

    //        string filalote = t.Rows[i].ItemArray[3].ToString().Trim();

    //        string filaempacadora = t.Rows[i].ItemArray[8].ToString().Trim();


    //       // if (!(filafundo == fundo && filalote == lote && filaempacadora == empacadora))
    //            if (!(filalote == lote && filaempacadora == empacadora))
    //        {
    //            ok = false;

    //            break;
    //        }


    //    }

    //    return ok;
    //}
    public bool Verifica_Detalle_Mov_Cajas_Lotes_Fundo_(DataTable t, string fundo)//2,3,9
    {
        bool ok = true;

        for (int i = 0; i < t.Rows.Count; i++)
        {
            string filafundo = t.Rows[i].ItemArray[5].ToString().Trim();

            //string filanrosemana = t.Rows[i].ItemArray[9].ToString().Trim();

            if (!(filafundo == fundo /*&& filanrosemana == nrosemana*/))
            {
                ok = false;

                break;
            }
        }

        return ok;
    }
    public bool Verifica_Existencia_Detalle_Cosecha_Color_Lotes_Fundo_Colores(DataTable t, string fundo, string lote, string color)//2,3,5
    {
        bool ok = true;

        for (int i = 0; i < t.Rows.Count; i++)
        {
            string filafundo = t.Rows[i].ItemArray[2].ToString().Trim();

            string filalote = t.Rows[i].ItemArray[3].ToString().Trim();

            string filacolor = t.Rows[i].ItemArray[5].ToString().Trim();

            if (filafundo == fundo && filalote == lote && filacolor == color)
            {
                ok = false;

                break;
            }


        }

        return ok;
    }

    public bool Verifica_Detalle_Cosecha_Color_Lotes_Fundo(DataTable t, string fundo)//2,3,5
    {
        bool ok = true;

        for (int i = 0; i < t.Rows.Count; i++)
        {
            string filafundo = t.Rows[i].ItemArray[2].ToString().Trim();

            if (!(filafundo == fundo))
            {
                ok = false;

                break;
            }
        }

        return ok;
    }

    public bool Verifica_Existencia_Detalle_Cosecha_Lotes_Fundo_Semanas(DataTable t, string fundo, string lote)//2,3,9
    {
        bool ok = true;
        for (int i = 0; i < t.Rows.Count; i++)
        {
            string filafundo = t.Rows[i].ItemArray[2].ToString().Trim();
            string filalote = t.Rows[i].ItemArray[3].ToString().Trim();
           // string filanrosemana = t.Rows[i].ItemArray[9].ToString().Trim();
            string filanrosemana = t.Rows[i].ItemArray[8].ToString().Trim(); //ES COLOR
            if (filafundo == fundo && filalote == lote)
            {
                ok = false;
                break;
            }
        }
        return ok;
    }

   
    //public bool Verifica_Existencia_Detalle_Cosecha_Lotes_Fundo_Semanas(DataTable t, string fundo, string lote, string nrosemana)//2,3,9
    //{
    //    bool ok = true;

    //    for (int i = 0; i < t.Rows.Count; i++)
    //    {
    //        string filafundo = t.Rows[i].ItemArray[2].ToString().Trim();

    //        string filalote = t.Rows[i].ItemArray[3].ToString().Trim();

    //        string filanrosemana = t.Rows[i].ItemArray[9].ToString().Trim();

    //        if (filafundo == fundo && filalote == lote && filanrosemana == nrosemana)
    //        {
    //            ok = false;

    //            break;
    //        }


    //    }

    //    return ok;
    //}

    //public bool Verifica_Detalle_Cosecha_Lotes_Fundo_Semanas(DataTable t, string fundo, string nrosemana)//2,3,9
    //{
    //    bool ok = true;

    //    for (int i = 0; i < t.Rows.Count; i++)
    //    {
    //        string filafundo = t.Rows[i].ItemArray[2].ToString().Trim();

    //        string filanrosemana = t.Rows[i].ItemArray[9].ToString().Trim();

    //        if (!(filafundo == fundo /*&& filanrosemana == nrosemana*/))
    //        {
    //            ok = false;

    //            break;
    //        }
    //    }

    //    return ok;
    //}

    //************************** SE AGREGO EL DIA 18-06-2017 ****************************************
    public bool Verifica_Detalle_Cosecha_Lotes_Fundo_(DataTable t, string fundo)//2,3,9
    {
        bool ok = true;

        for (int i = 0; i < t.Rows.Count; i++)
        {
            string filafundo = t.Rows[i].ItemArray[2].ToString().Trim();

            //string filanrosemana = t.Rows[i].ItemArray[9].ToString().Trim();

            if (!(filafundo == fundo /*&& filanrosemana == nrosemana*/))
            {
                ok = false;

                break;
            }
        }

        return ok;
    }

   
    //************************** SE AGREGO EL DIA 17-10-2017 ****************************************
    public bool Verifica_Detalle_Mov_Almacen_Lotes_Fundo_(DataTable t, string fundo)//2,3,9
    {
        bool ok = true;

        for (int i = 0; i < t.Rows.Count; i++)
        {
            string filafundo = t.Rows[i].ItemArray[1].ToString().Trim();

            //string filanrosemana = t.Rows[i].ItemArray[9].ToString().Trim();

            if (!(filafundo == fundo /*&& filanrosemana == nrosemana*/))
            {
                ok = false;

                break;
            }
        }

        return ok;
    }

    //**************************** SE COMENTO EL DIA 08-06-2017 ****************************************
    //public bool Verifica_Detalle_Cosecha_Lotes_Fundo_Semanas(DataTable t, string fundo)//2,3,9
    //{
    //    bool ok = true;

    //    for (int i = 0; i < t.Rows.Count; i++)
    //    {
    //        string filafundo = t.Rows[i].ItemArray[2].ToString().Trim();

    //        string filanrosemana = t.Rows[i].ItemArray[9].ToString().Trim();

    //        if (!(filafundo == fundo /*&& filanrosemana == nrosemana*/))
    //        {
    //            ok = false;

    //            break;
    //        }
    //    }

    //    return ok;
    //}
    public bool Verifica_Existencia_Lotes_Fundo_Semanas_trabajador(System.Web.UI.WebControls.Table tabla, string fundo, string lote, string nrosemana, string fecha, string trabajador)//2,3,5,6
    {
        bool ok = true;

        for (int i = 1; i < tabla.Rows.Count; i++)
        {
            if (tabla.Rows[i].Visible == true)
            {
                string filafundo = tabla.Rows[i].Cells[2].Text.Trim();

                string filalote = tabla.Rows[i].Cells[3].Text.Trim();

                string filanrosemana = tabla.Rows[i].Cells[5].Text.Trim();

                string filafecha = tabla.Rows[i].Cells[6].Text.Trim();

                string filatrabajador = tabla.Rows[i].Cells[11].Text.Trim();

                if (filafundo == fundo && filalote == lote && filanrosemana == nrosemana && filafecha == fecha && filatrabajador == trabajador)
                {
                    ok = false;

                    break;
                }

            }
        }

        return ok;
    }

    public bool Verifica_Lotes_Fundo_Semanas(System.Web.UI.WebControls.Table tabla, string fundo, string nrosemana, string fecha)//2,3,5
    {
        bool ok = true;

        for (int i = 1; i < tabla.Rows.Count; i++)
        {
            if (tabla.Rows[i].Visible == true)
            {
                string filafundo = tabla.Rows[i].Cells[2].Text.Trim();

                string filanrosemana = tabla.Rows[i].Cells[5].Text.Trim();

                string filaFecha= tabla.Rows[i].Cells[6].Text.Trim();

                if (!(filafundo == fundo && filanrosemana == nrosemana && filaFecha == fecha))
                {
                    ok = false;

                    break;
                }

            }
        }

        return ok;
    }

    
    public bool Validar_Editar_Datos_Tabla(DataTable t, object[,] datosvalidar, int filaeditar)
    {
        bool ok = true;

        object[,] r = datosvalidar;

        object[] c = (object[])datosvalidar[0, 0];

        object[] d = (object[])datosvalidar[0, 1];

        for (int i = 0; i < t.Rows.Count; i++)
        {
            if (i != filaeditar)
            {
                if (ok == false)
                {
                    ok = true;
                }

                for (int j = 0; j < c.Length; j++)
                {
                    ok = ok && t.Rows[i].ItemArray[(int)c[j]].ToString().Trim() == d[j].ToString();
                }

                if (ok == true)
                {
                    break;
                }
            }
            else
            {
                ok = false;
            }
        }

        return ok;
    }

    public bool Validar_Datos_Tabla(DataTable t, object[,] datosvalidar)
    {
        bool ok = true;

        if (t.Rows.Count > 0)
        {
            object[,] r = datosvalidar;

            object[] c = (object[])datosvalidar[0, 0];

            object[] d = (object[])datosvalidar[0, 1];

            for (int i = 0; i < t.Rows.Count; i++)
            {
                if (ok == false)
                {
                    ok = true;
                }

                for (int j = 0; j < c.Length; j++)
                {
                    ok = ok && t.Rows[i].ItemArray[(int)c[j]].ToString().Trim() == d[j].ToString();
                }

                if (ok == true)
                {
                    break;
                }
            }
        }
        else
        {
            ok = false;
        }

        return ok;
    }

    public bool Verifica_Datos_Tabla(DataTable t)
    {
        bool ok = true;
        if (t == null)
        {
            ok = false;
        }
        else if (t.Rows.Count == 0)
        {
            ok = false;
        }

        for (int i = 0; i < t.Rows.Count; i++)
        {
            for (int j = 0; j < t.Columns.Count - 2; j++)
            {
                ok = ok && t.Rows[i].ItemArray[j].ToString().Trim() != "";
            }
        }
        return ok;
    }


    public bool Verifica_Datos_Tabla_2(DataTable t, String TipoComprobante, string Estado)
    {
        bool ok = false;
        if (t == null)
        {
            ok = false;
        }
        else if (t.Rows.Count == 0)
        {
            ok = false;
        }

        for (int i = 0; i < t.Rows.Count; i++)
        {
            //columna nro 2 -> TipoComprobante.
            //columna nro 5 -> Estado.
            ok = t.Rows[i].ItemArray[2].ToString().Trim() == TipoComprobante;
            ok = ok && t.Rows[i].ItemArray[5].ToString().Trim() == Estado;
            if (ok==true)
            {
                ok = true;
                break;
            }         
        }
        return ok;
    }


    public bool Verifica_Datos_Tabla_3(DataTable t)
    {
        bool ok = true;
        if (t == null)
        {
            ok = false;
        }
        else if (t.Rows.Count == 0)
        {
            ok = false;
        }

        for (int i = 0; i < t.Rows.Count; i++)
        {
            if (t.Rows[i].ItemArray[1].ToString().Trim() == "")
            {
                ok = false;
                break;
            }
                        
        }
        return ok;
    }

    public bool Verifica_Datos_Tabla_4(DataTable t, string tipooperacion)
    {
        bool ok = true;
        if (t == null)
        {
            ok = false;
        }
        else if (t.Rows.Count == 0)
        {
            ok = false;
        }

            for (int i = 0; i < t.Rows.Count; i++)
            {
                if (t.Rows[i].ItemArray[3].ToString().Trim() != tipooperacion)
                {
                    ok = false;
                    break;
                }

            }
       
        return ok;
    }


    public bool Verifica_Datos_Tabla_5(DataTable t)
    {
        bool ok = true;
        if (t == null)
        {
            ok = false;
        }
        else if (t.Rows.Count == 0)
        {
            ok = false;
        }

        string produccion = t.Rows[0].ItemArray[5].ToString().Trim();

        for (int i = 0; i < t.Rows.Count; i++)
        {
            //for (int j = 0; j < t.Columns.Count - 2; j++)
            //{
            if (produccion.Equals(t.Rows[i].ItemArray[5].ToString().Trim()))
            {
                ok = true;
            }
            else
            {
                ok = false;
                break;
            }
            //}
        }
        return ok;
    }

    //===============================================================================================================================================================================
    //Funcion que busca informacion en una lista desplegable. 

    public void Busca(System.Web.UI.WebControls.DropDownList control, String Text)
    {
        for (int i = 0; i < control.Items.Count; i++)
        {
            if (control.Items[i].Text.Trim().Equals(Text))
            {
                control.SelectedIndex = i;
            }
        }
    }

    public DataTable Eliminar_Fila_Tabla_Datos(DataTable dt, int fila)
    {
        DataRow FilaTabla = dt.Rows[fila];//obtenemos la fila de la fuente de datos.

        dt.Rows.Remove(FilaTabla);//eliminamos la fila de la fuente de datos.

        return dt;
    }

    //AGREGADO EL 13/01/2023 9:29 AM.
    public DataTable Eliminar_Fila_Tabla_Datos_2(DataTable dt, object[] Columnas, object[] Condiciones)
    {
        
        bool Ok = true;
        for (int fila = 0; fila < dt.Rows.Count; fila++)
        {
            for (int j = 0; j < Columnas.Count(); j++)
            {
                Ok = Ok && dt.Rows[fila].ItemArray[(int)Columnas[j]].Equals(Condiciones[j]);
            }
            if (Ok == true)
            {
                DataRow FilaTabla = dt.Rows[fila];//obtenemos la fila de la fuente de datos.
                dt.Rows.Remove(FilaTabla);//eliminamos la fila de la fuente de datos. 
            }
            Ok = true;
        }
        return dt;
    }

    //AGREGADO EL 21/01/2023 15:33 PM.
    public DataTable Eliminar_Fila_Tabla_Datos_3(DataTable dt, int FilaEditar)
    {
        for (int fila = 0; fila < dt.Rows.Count; fila++)
        {
            if (fila != FilaEditar)
            {
                DataRow FilaTabla = dt.Rows[fila];//obtenemos la fila de la fuente de datos.
                dt.Rows.Remove(FilaTabla);//eliminamos la fila de la fuente de datos. 
            }
        }
        return dt;
    }


    public DataTable Crear_Cabecera_Grilla(params object[] columnas)
    {
        DataTable dt = new DataTable();

        object[] fila = new object[columnas.Length];

        for (int i = 0; i < columnas.Length; i++)
        {
            fila[i] = "";

            dt.Columns.Add(columnas[i].ToString());
        }

        dt.Rows.Add(fila);

        return dt;
    }

    public DataTable Crear_Cabecera_Grilla_2(params object[] columnas)
    {
        DataTable dt = new DataTable();

        for (int i = 0; i < columnas.Length; i++)
        {
            dt.Columns.Add(columnas[i].ToString());
        }

        dt.Rows.Add();

        return dt;
    }
    public void Pintar_Fondo_Caja_Texto(System.Web.UI.WebControls.TextBox CajaTexto)
    {
        string micolor = CajaTexto.Text.Trim();

        if (micolor.Equals("BLANCO"))
        {
            CajaTexto.BackColor = Color.White;

            CajaTexto.BorderColor = Color.White;

            CajaTexto.ForeColor = Color.White;
        }
        else if (micolor.Equals("NEGRO"))
        {
            CajaTexto.BackColor = Color.Black;

            CajaTexto.BorderColor = Color.Black;

            CajaTexto.ForeColor = Color.Black;
        }
        else if (micolor.Equals("VERDE"))
        {
            CajaTexto.BackColor = Color.Green;

            CajaTexto.BorderColor = Color.Green;

            CajaTexto.ForeColor = Color.Green;
        }
        else if (micolor.Equals("MORADO/LILA"))
        {
            CajaTexto.BackColor = Color.Purple;

            CajaTexto.BorderColor = Color.Purple;

            CajaTexto.ForeColor = Color.Purple;
        }
        else if (micolor.Equals("MARRON"))
        {
            CajaTexto.BackColor = Color.Maroon;

            CajaTexto.BorderColor = Color.Maroon;

            CajaTexto.ForeColor = Color.Maroon;
        }
        else if (micolor.Equals("AMARILLO"))
        {
            CajaTexto.BackColor = Color.Yellow;

            CajaTexto.BorderColor = Color.Yellow;

            CajaTexto.ForeColor = Color.Yellow;
        }
        else if (micolor.Equals("AZUL"))
        {
            CajaTexto.BackColor = Color.Blue;

            CajaTexto.BorderColor = Color.Blue;

            CajaTexto.ForeColor = Color.Blue;
        }
        else if (micolor.Equals("ROJO"))
        {
            CajaTexto.BackColor = Color.Red;

            CajaTexto.BorderColor = Color.Red;

            CajaTexto.ForeColor = Color.Red;
        }
        else if (micolor.Equals(""))
        {
            CajaTexto.BackColor = Color.FromName("#FFFFCC");

            CajaTexto.BorderColor = Color.FromName("#FFFFCC");

            CajaTexto.ForeColor = Color.FromName("#FFFFCC");
        }
    }

    public void Pintar_Fondo_Fila_Seleccionada(System.Web.UI.WebControls.Table tabla, int columnabuscar, string datobuscar, params object[] columnas)
    {
        for (int i = 1; i < tabla.Rows.Count; i++)
        {
            if (tabla.Rows[i].Cells[columnabuscar].Text.Trim().Equals(datobuscar))
            {
                for (int j = 0; j < columnas.Length; j++)
                {
                    tabla.Rows[i].Cells[(int)columnas[j]].BackColor = System.Drawing.Color.PaleGoldenrod;
                }

                break;
            }
        }
    }

    public void Pintar_Fondo_Fila_Seleccionada_2(System.Web.UI.WebControls.Table tabla, int columnabuscar, string datobuscar, params object[] columnas)
    {
        for (int i = 1; i < tabla.Rows.Count; i++)
        {
            if (tabla.Rows[i].Cells[columnabuscar].Text.Trim().Equals(datobuscar))
            {
                for (int j = Convert.ToInt32(columnas[0]); j < columnas.Length; j++)
                {
                    tabla.Rows[i].Cells[(int)columnas[j]].BackColor = System.Drawing.Color.PaleGoldenrod;
                }

                break;
            }
        }
    }

    //AGREGADO EL 19/01/2023 9:29 AM.
    public void Pintar_Fondo_Fila_Seleccionada_2(System.Web.UI.WebControls.Table tabla, int fila, params object[] columnas)
    {
        
            
                for (int j = 0; j < columnas.Length; j++)
                {
                    tabla.Rows[fila].Cells[(int)columnas[j]].BackColor = System.Drawing.Color.PaleGoldenrod;                    
                }

               
           
        
    }

    public void Restablecer_Color_Fondo_Fila_Tabla(System.Web.UI.WebControls.Table tabla, params object[] columnas)
    {
        for (int i = 1; i < tabla.Rows.Count; i++)
        {
            for (int j = 0; j < columnas.Length; j++)
            {
                tabla.Rows[i].Cells[(int)columnas[j]].BackColor = System.Drawing.Color.White;
            }

        }
    }

    public void Restablecer_Color_Fondo_Fila_Tabla_2(System.Web.UI.WebControls.Table tabla, params object[] columnas)
    {
        for (int i = 1; i < tabla.Rows.Count; i++)
        {
            for (int j = Convert.ToInt32(columnas[0]); j < columnas.Length; j++)
            {
                tabla.Rows[i].Cells[(int)columnas[j]].BackColor = System.Drawing.Color.White;
            }

        }
    }

    public bool Verifica_Datos_Fila_Cuadricula(System.Web.UI.WebControls.Table tabla, params object[] columnas)
    {
        bool ok = true;

        bool flag = false;

        for (int i = 1; i < tabla.Rows.Count; i++)
        {
            for (int j = 0; j < columnas.Length; j++)
            {
                if (tabla.Rows[i].Visible == true)
                {
                    ok = ok && tabla.Rows[i].Cells[(int)columnas[j]].Text.Trim() != "";

                    flag = true;
                }
            }
        }

        if (flag == false)
        {
            ok = false;
        }

        return ok;
    }

    public void Ocultar_Columnas(System.Web.UI.WebControls.Table tabla, params object[] columnas)
    {
        for (int i = 0; i < tabla.Rows.Count; i++)
        {
            for (int j = 0; j < columnas.Length; j++)
            {
                tabla.Rows[i].Cells[(int)columnas[j]].Visible = false;
            }

        }
    }   
    

    public int Obtener_Numero_Fila_Blanco(System.Web.UI.WebControls.Table tabla, int nrocolumna)
    {
        int fila = 0;

        for (int i = 1; i < tabla.Rows.Count; i++)
        {
            if (tabla.Rows[i].Cells[nrocolumna].Text.Trim() == "")
            {
                fila = i;

                break;
            }
        }

        return fila;
    }

    public void Cuadricula(System.Web.UI.WebControls.Table tabla, int nrofilas, int nrocolumnas)
    {
        System.Web.UI.WebControls.TableRow tRow;

        for (int i = 0; i < nrofilas; i++)
        {
            tRow = new TableRow();

            for (int j = 0; j < nrocolumnas; j++)//Cabecera de la tabla
            {
                TableCell tCell = new TableCell();

                tCell.Text = "";

                tCell.Height = 16;

                tCell.HorizontalAlign = HorizontalAlign.Left;

                tCell.Visible = true;

                tRow.Cells.Add(tCell);

            }

            tRow.Visible = false;

            tabla.Rows.Add(tRow);
        }
    }
    //========================= AGREGADO EL DIA 27-01-2023 14:07 ===============================
    public bool Verificar_Orden_Secuencial_Datos(DataTable dt, int nrocolumna, int valor)
    {
        bool ok = true;
        int k = 0;
        for (int j = 1; j < valor; j++)
        {
             for (int i = 0; i < dt.Rows.Count; i++){
                 if (dt.Rows[i].ItemArray[nrocolumna].Equals(j.ToString()))
                 {
                     k = i;
                     break;
                 }
             }
             if (k == 0)
             {
                 ok = ok && false;
             }
             else
             {
                 ok = ok && true;
             }
             if (dt.Rows.Count > 0)
             {
                 if ((Convert.ToInt32(dt.Rows[dt.Rows.Count-1].ItemArray[nrocolumna]) + 1) == valor)
                 {
                     ok = true;
                 }
             }
             k = 0;
        }
        return ok;

    }

    //========================= AGREGADO EL DIA 17-09-2017 ===============================
    public bool verifica_seleccion_autorizacion_formulario_derecho_2(System.Web.UI.WebControls.Table tabla, int NroColumna)
    {

        bool ok = ((System.Web.UI.WebControls.CheckBox)tabla.Rows[1].Cells[NroColumna].Controls[0]).Checked;

        return ok;
    }

    public bool verifica_seleccion_autorizacion_formulario_3(System.Web.UI.WebControls.Table tabla, int NroColumna)
    {
        bool ok = true;

        for (int i = 2; i < tabla.Rows.Count; i++)
        {
            if (((System.Web.UI.WebControls.CheckBox)tabla.Rows[i].Cells[NroColumna].Controls[0]).Checked == false)
            {
                ok = true;

                for (int j = 4; j < tabla.Rows[i].Cells.Count; j++)
                {
                    if (((System.Web.UI.WebControls.CheckBox)tabla.Rows[i].Cells[j].Controls[0]).Checked == true)
                    {
                        ok = false;
                    }

                }
            }

            if (ok == false)
            {
                break;
            }

        }

        return ok;

    }

    public bool verifica_seleccion_autorizacion_formulario_2(System.Web.UI.WebControls.Table tabla, int NroColumna)
    {
        bool ok = true;

        for (int i = 2; i < tabla.Rows.Count; i++)
        {
            if (((System.Web.UI.WebControls.CheckBox)tabla.Rows[i].Cells[NroColumna].Controls[0]).Checked == true)
            {
                ok = false;

                for (int j = 4; j < tabla.Rows[i].Cells.Count; j++)
                {
                    if (((System.Web.UI.WebControls.CheckBox)tabla.Rows[i].Cells[j].Controls[0]).Checked == true)
                    {
                        ok = true;
                    }

                }
            }

            if (ok == false)
            {
                break;
            }

        }

        return ok;
    }

    public bool verifica_seleccion_autorizacion_formulario(System.Web.UI.WebControls.Table tabla, int NroColumna)
    {

        bool ok = false;

        for (int i = 1; i < tabla.Rows.Count; i++)
        {
            System.Web.UI.WebControls.CheckBox check = (System.Web.UI.WebControls.CheckBox)tabla.Rows[i].Cells[NroColumna].Controls[0];

            if (check.Checked == true)
            {
                ok = true;
            }
        }

        return ok;

    }
    //========================= ===================================================
    public void Search_DropDownList(DataTable Tabla, System.Web.UI.WebControls.DropDownList control, String strcampo)
    {
        if (Tabla.Rows.Count == 0) return;

        for (int i = 0; i < control.Items.Count; i++)
        {
            if (control.Items[i].Text.Trim().Equals(Tabla.Rows[0][strcampo].ToString()))
            {

                control.SelectedIndex = i;

            }
        }
    }

    public void ShowMessage(System.Web.UI.WebControls.HiddenField __mensaje, System.Web.UI.WebControls.HiddenField __pagina, string msg, string paginaweb)
    {
        __mensaje.Value = msg;

        __pagina.Value = paginaweb;
    }
}