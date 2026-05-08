# Report Column Mappings - Reference Document

Analysis of all 11 report code-behind files. This document captures stored procedure names, column names (case-sensitive with accents/spaces), column counts, inline color HTML, Session["Imprimir"] usage, and special features.

---

## 1. ReporteDatosIncorrectosCI.aspx.cs

**Stored Procedure:** `[dbo].[pr_ReporteDatosIncorrectosCI]`

**Columns (5):**
| # | Column Name (case-sensitive) | Notes |
|---|------------------------------|-------|
| 0 | AREA | Plain text |
| 1 | TIPO CI | Plain text |
| 2 | DESCRIPCION CI | Plain text |
| 3 | NOMBRE CI | Plain text |
| 4 | FECHA SEGUIMIENTO | Formatted date, may be empty string |

**Inline Color HTML:** None directly in cells (uses `tCell.ForeColor` for percentage-based coloring in summary rows only)

**Session["Imprimir"]:** `"REPORTE_DATOS_INCORRECTOS_CIs"`
- Object[] format: `{ "REPORTE_DATOS_INCORRECTOS_CIs", dt, msg }`

**Summary Rows:** Yes - injects 3 rows into dt before rendering:
- `"CANTIDAD DE CIs EN LA CMDB:"`, `Cantidad_CIs_CMDB.ToString()`, `""`, `""`, `null`
- `"CANTIDAD DE CIs CON DATOS INCORRECTOS:"`, `CantidadCorrectos.ToString()`, `""`, `""`, `null`
- `"% DE CIs CON DATOS INCORRECTOS:"`, `x.ToString() + "%"`, `""`, `""`, `null`

**Special Features:** None (no EDITAR button, no dedup, no expandable rows, no dual tables)

**Empty State Colspan:** 5

---

## 2. ReporteDatosCorrectosCI.aspx.cs

**Stored Procedure:** `[dbo].[pr_ReporteDatosCorrectosCI]`

**Columns (5):**
| # | Column Name (case-sensitive) | Notes |
|---|------------------------------|-------|
| 0 | AREA | Plain text |
| 1 | TIPO CI | Has conditional ForeColor: Blue if >=80%, Green if >60%<80%, Red if <60%; also colored for summary rows like "% IDEAL DE CIs CORRECTOS." |
| 2 | DESCRIPCION CI | Plain text |
| 3 | NOMBRE CI | Plain text |
| 4 | FECHA SEGUIMIENTO | Plain text |

**Inline Color HTML:** None (uses `tCell.ForeColor` programmatic coloring instead)

**Session["Imprimir"]:** `"REPORTE_DATOS_CORRECTOS_CIs"`
- Object[] format: `{ "REPORTE_DATOS_CORRECTOS_CIs", dt, msg }`

**Summary Rows:** Yes - injects 6 rows into dt:
- `"CANTIDAD DE CIs EN LA CMDB:"` + value
- `"CANTIDAD DE CIs CON DATOS CORRECTOS:"` + value
- `"% DE CIs CON DATOS CORRECTOS:"` + percentage
- `"SI EL % DE CIs CON DATOS CORRECTOS ES >=80%:"` + message
- `"SI EL % DE CIs CON DATOS CORRECTOS ES >60% Y <80%:"` + message
- `"SI EL % DE CIs CON DATOS CORRECTOS ES <60%:"` + message

**Special Features:** None

**Empty State Colspan:** 5

---

## 3. ReporteCIsSeguidos.aspx.cs

**Stored Procedure:** `[dbo].[pr_ReporteCIsSeguidos]`

**Columns (8):**
| # | Column Name (case-sensitive) | Notes |
|---|------------------------------|-------|
| 0 | AREA | Plain text |
| 1 | NRO PISO / NRO AMBIENTE | Conditional inline color HTML: `<font color=blue>` for NRO PISO, `<font color=red>` for NRO AMBIENTE when TIPO CI is not empty |
| 2 | TIPO CI | Plain text |
| 3 | DESCRIPCION CI | Plain text |
| 4 | NOMBRE CI | Plain text |
| 5 | ESTADO ACTUAL | Plain text |
| 6 | OBSERVACION | Plain text |
| 7 | FECHA SEGUIMIENTO | Converted to ShortDateString, may be empty |

**Inline Color HTML:** `<font color=blue>` (NRO PISO), `<font color=red>` (NRO AMBIENTE) in column 1

**Session["Imprimir"]:** `"REPORTE_CIs_SEGUIDOS"`
- Object[] format: `{ "REPORTE_CIs_SEGUIDOS", dt, msg }`

**Summary Rows:** Yes - injects 3 rows:
- `"CANTIDAD DE CIs EN LA CMDB:"` + value
- `"CANTIDAD DE CIs CONSIGNADOS Y SEGUIDOS:"` + value
- `"% DE CIs SEGUIDOS:"` + percentage

**Special Features:** None

**Empty State Colspan:** 8

---

## 4. Reporte_CIS_Relacionados_Con_Otros_CIS.aspx.cs

**Stored Procedure:** `[dbo].[pr_Reporte_CIS_Relacionados_Con_Otros_CIS]`

**Columns (6):**
| # | Column Name (case-sensitive) | Notes |
|---|------------------------------|-------|
| 0 | ID_RELACION | Hidden (Visible=false) |
| 1 | PADRE ID | Hidden |
| 2 | PADRE CI | Rich HTML content with inline colors |
| 3 | HIJO ID | Hidden |
| 4 | HIJO CI | Rich HTML content with inline colors |
| 5 | TIPO RELACION | Plain text |

**Column 2 (PADRE CI) Inline HTML:**
```
<font color=blue><b>Nombre: </b>{PADRE CI}</font>
<b>Tipo:</b> {PADRE TIPO CI}
<b>Nro Serie: </b>{PADRE NRO SERIE}
<b>Direccion IP: </b>{PADRE IP}
<b>Direccion Gateway: </b>{PADRE GATEWAY}
<b>Grupo de Trabajo: </b>{PADRE GRUPO TRABAJO}
<b>Fabricante / Proveedor: </b>{PADRE FABICANTE / PROVEEDOR}
<b>Estado:</b> {PADRE ESTADO CI}
<b>Propietario:</b> {PADRE PROPIETARIO CI}
<b>Descripcion: </b>{PADRE DESCRIPCION CI}
<b>Prioridad: </b>{PADRE NIVEL PRIORIDAD}
<b>Sede: </b>{PADRE SEDE}
<b>Local: </b>{PADRE LOCAL}
<font color=red><b>Area: </b>{PADRE AREA}
<b>Nro. Piso: </b>{PADRE NRO PISO}
<b>Nro. Ambiente: </b>{PADRE NRO AMBIENTE}
<b>Ubicacion: </b>{PADRE UBICACION}</font>
<font color=red><b>Direccion: </b>{PADRE DIRECCION LOCAL}</font>
```

**Column 4 (HIJO CI) Inline HTML:** Same pattern with "HIJO" prefix

**Inline Color HTML:** `<font color=blue>` (for "Nombre:" in CI cells), `<font color=red>` (for Area, Nro Piso, Nro Ambiente, Ubicacion, Direccion)

**Session["Imprimir"]:** `"REPORTE_DE_CIS_RELACIONADOS_CON_OTROS_CIS"`
- Object[] format: `{ "REPORTE_DE_CIS_RELACIONADOS_CON_OTROS_CIS", dt, "REPORTE DE CIS RELACIONADOS CON OTROS CIS", T, A, X }`

**Dedup Logic:** Yes - deduplicates rows where `PADRE DESCRIPCION CI` equals the next row's same value. When match found, sets `PADRE CI = ""` and `PADRE TIPO CI = ""`.

**Summary Rows:** Yes - displays T, A, X statistics in labels (not injected into dt):
- `T.Text` = "Nro. Total de CIs registrados que pueden estar relacionados con otros elementos de configuración: {T}"
- `A.Text` = "Nro. de CIs relacionado a uno u otros elementos de configuración: {A}"
- `X.Text` = "% de CIs relacionados con otros CIs: {X}"

**Special Features:** Dedup logic, summary statistics

**Empty State Colspan:** 6

---

## 5. Reporte_De_CIS_Relativo_A_Servicios.aspx.cs

**Stored Procedure:** `[dbo].[pr_Reporte_De_CIS_Relativo_A_Servicios]`

**Columns (6):**
| # | Column Name (case-sensitive) | Notes |
|---|------------------------------|-------|
| 0 | ID_RELACION | Hidden |
| 1 | PADRE ID | Hidden |
| 2 | PADRE CI | Rich HTML content, empty string when deduped |
| 3 | HIJO ID | Hidden |
| 4 | HIJO CI | Rich HTML content with inline colors |
| 5 | TIPO RELACION | Plain text |

**Inline Color HTML:** Same pattern as #4 - `<font color=blue>` for CI names, `<font color=red>` for area/direction fields

**Session["Imprimir"]:** `"REPORTE_DE_CIS_RELATIVO_A_SERVICIOS"`
- Object[] format: `{ "REPORTE_DE_CIS_RELATIVO_A_SERVICIOS", dt, "REPORTE DE ELEMENTOS DE CONFIGURACION RELATIVO A SERVICIOS", T, A, X }`

**Dedup Logic:** Yes - same as #4 but also decrements counter `A = A - 1` when deduping

**Summary Rows:** Yes - displays T, A, X in labels:
- `T.Text`, `A.Text`, `X.Text` with descriptive labels

**Special Features:** Dedup with counter decrement

**Empty State Colspan:** 6

---

## 6. ReporteComponentesAsignados.aspx.cs

**Stored Procedure:** `[dbo].[pr_ListaElementosConfiguracionComponenetesAsignados]`

**Main Table Columns (Table_, 18 visible columns from ASPX header, 18 case statements):**
| # | Column Name (case-sensitive) | Notes |
|---|------------------------------|-------|
| 0 | ID CI | Hidden |
| 1 | NOMBRE CI | Plain text |
| 2 | NOMBRE TIPO CI | Plain text |
| 3 | NRO SERIE | Plain text |
| 4 | FABRICANTE / PROVEEDOR | Plain text |
| 5 | MARCA / MODELO | Inline color HTML: `<font color=red>{MARCA}</font> / <font color=blue>{MODELO}</font>` |
| 6 | IP | Plain text |
| 7 | GATEWAY | Plain text |
| 8 | GRUPO TRABAJO | Plain text |
| 9 | ESTADO CI | Conditional ForeColor: Blue=ACTIVO, Red=otherwise |
| 10 | PROPIETARIO | Plain text |
| 11 | DESCRIPCION CI | Plain text |
| 12 | IMPACTO CI / NIVEL PRIORIDAD | Inline color HTML: `<font color=blue>{IMPACTO CI}</font> / <font color=red>{NIVEL PRIORIDAD}</font>` |
| 13 | SEDE / LOCAL | Inline color HTML: `<font color=blue>{SEDE}</font> / <font color=red>{LOCAL}</font>` |
| 14 | AREA | Plain text |
| 15 | NRO PISO | Plain text |
| 16 | NRO AMBIENTE | Plain text |
| 17 | (DETALLE button) | Button with CssClass="btn btn-success", CommandArgument=ID CI |

**Detail Table (Table_0) Columns (7):**
| # | Column Name (case-sensitive) | Notes |
|---|------------------------------|-------|
| 0 | ID COMPONENETE | Hidden |
| 1 | TIPO COMPONENTE | Plain text |
| 2 | DESCRIPCION | Plain text |
| 3 | FABRICANTE | Plain text |
| 4 | NRO SERIE | Plain text |
| 5 | MODELO | Plain text |
| 6 | MARCA | Plain text |

**Inline Color HTML:** `<font color=red>` (MARCA, IMPACTO CI, SEDE), `<font color=blue>` (MODELO, NIVEL PRIORIDAD, LOCAL)

**Session["Imprimir"]:** Not found in this file (uses `IMPRIMIR.Page.Session.Add` with "REPORTE_COMPONENTES_CI" on line 1027)

**Session["CABECERA"]:** dt is stored in Session for use during print

**Special Features:**
- DETALLE button that triggers `Consultar_Detalle_Componentes_CI` event handler
- Expandable detail rows loaded via separate stored proc `[dbo].[pr_ConsultarDetalleComponentesCI]`
- Dual table structure (main CI table + nested components table)

**Empty State Colspan:** 18 (main table), 7 (detail table)

---

## 7. ReporteCIsInformacionContenidaEnCMDB.aspx.cs

**Two separate stored procedures called with different parameters:**

**Stored Procedure 1:** `[dbo].[pr_Reporte_CIs_Información_Contenidas_En_CMDB]` with OPCION_BUSQUEDA="1"
**Stored Procedure 2:** `[dbo].[pr_Reporte_CIs_Información_Contenidas_En_CMDB]` with OPCION_BUSQUEDA="2"

**CI Table Columns (Table_, 20):**
| # | Column Name (case-sensitive) | Notes |
|---|------------------------------|-------|
| 0 | ID CI | Hidden |
| 1 | NOMBRE CI | Plain text |
| 2 | NOMBRE TIPO CI | Plain text |
| 3 | NRO SERIE | Plain text |
| 4 | FABRICANTE / PROVEEDOR | Plain text |
| 5 | MARCA / MODELO | Inline color HTML: `<font color=blue><b>{MARCA}</b></font> / <font color=red><b>{MODELO}</b></font>` |
| 6 | IP | Plain text |
| 7 | GATEWAY | Plain text |
| 8 | GRUPO TRABAJO | Plain text |
| 9 | ESTADO CI | Conditional ForeColor: Blue=ACTIVO, Red=otherwise |
| 10 | PROPIETARIO | Plain text |
| 11 | DESCRIPCION CI | Plain text |
| 12 | IMPACTO CI / NIVEL PRIORIDAD | Combined: `{IMPACTO CI}<b>  /  </b>{NIVEL PRIORIDAD}` |
| 13 | SEDE / LOCAL | Inline color HTML: `<FONT COLOR=BLUE><B>{SEDE}</B></FONT> / <FONT COLOR=RED><B>{LOCAL}</B></FONT>` with `<BR>` |
| 14 | UBICACION LOCAL | Hidden |
| 15 | DIRECCION LOCAL | Hidden |
| 16 | AREA | Plain text |
| 17 | NRO PISO / NRO AMBIENTE | Inline color HTML: `<FONT COLOR=BLUE><B>{NRO PISO}</B></FONT> / <FONT COLOR=RED><B>{NRO AMBIENTE}</B></FONT>` |
| 18 | FEC. CREACION CI | Plain text |
| 19 | RESPONSABLE | Plain text |

**License Table Columns (Table_1, 10):**
| # | Column Name (case-sensitive) | Notes |
|---|------------------------------|-------|
| 0 | AREA | Plain text |
| 1 | LICENCIA | Plain text |
| 2 | NOMBRE | Plain text |
| 3 | VERSION | Plain text |
| 4 | SUSCRIPCION | Plain text |
| 5 | FEC. INI. | Plain text |
| 6 | FEC. FIN | Plain text |
| 7 | PERPETUA | Plain text |
| 8 | DESCRIPCION | Plain text |
| 9 | VENCE LICENCIA | Plain text |

**Inline Color HTML:** `<font color=blue>`, `<font color=red>`, `<FONT COLOR=BLUE>`, `<FONT COLOR=RED>` in multiple cells

**Session["Imprimir"]:** Two separate calls (lines 46 and 600):
- First: `"REPORTE_CIs_Información_Contenidas_En_CMDB"` for CI table
- Second: `"REPORTE_LICENCIAS_CI"` for License table (called in `Listar_Licencias` but no IMPRIMIR call found in this file - only header row setup for Table_1)

**Special Features:**
- Dual table structure (CI table + License table)
- Summary statistics computed from total count vs. table row counts with percentage coloring in Label3

**Empty State Colspan:** 20 (CI table), 10 (License table)

---

## 8. ReporteRelacionesElementosConfiguracion.aspx.cs

**Stored Procedure:** `[dbo].[pr_ListaRelacionElementosConfiguracion]`

**Columns (6):**
| # | Column Name (case-sensitive) | Notes |
|---|------------------------------|-------|
| 0 | ID_RELACION | Hidden |
| 1 | PADRE ID | Hidden |
| 2 | PADRE CI | Rich HTML content with inline colors |
| 3 | HIJO ID | Hidden |
| 4 | HIJO CI | Rich HTML content with inline colors |
| 5 | TIPO RELACION | Plain text |

**Inline Color HTML:** Same rich HTML pattern as #4/#5:
- `<font color=blue>` for "Nombre:" labels
- `<font color=red>` for Area, Nro Piso, Nro Ambiente, Ubicacion, Direccion fields

**Session["Imprimir"]:** `"REPORTE_RELACIONES_ELEMENTOS_CONFIGURACION"`
- Object[] format: `{ "REPORTE_RELACIONES_ELEMENTOS_CONFIGURACION", dt, "REPORTE DE RELACIONES DE ELEMENTOS DE CONFIGURACION" }`

**Special Features:** None (no dedup, no summary rows, no buttons)

**Empty State Colspan:** 6

---

## 9. ReporteLicenciasElementoConfiguracion.aspx.cs

**Stored Procedures:**
- `[dbo].[pr_ListaLicencias]` (main table)
- `[dbo].[pr_ListaRelacionLicenciaElementosConfiguracion]` (detail expansion)

**Main Table Columns (tblLicencias, 10 + action column = 11):**
| # | Column Name (case-sensitive) | Notes |
|---|------------------------------|-------|
| 0 | ID LI | Hidden |
| 1 | TIPO LICENCIA | Plain text |
| 2 | NOMBRE | Plain text |
| 3 | VERSION | Plain text |
| 4 | SUSCRIPCION | Plain text |
| 5 | FEC. INI. | Converted to ShortDateString or "---" if empty |
| 6 | FEC. FIN | Converted to ShortDateString or "---" if empty |
| 7 | PERPETUA | Conditional ForeColor: Blue=SI, Red=NO |
| 8 | DESCRIPCION | Plain text |
| 9 | VENCE LICENCIA | Conditional ForeColor: Red="LICENCIA VENCIDA", Green="LICENCIA NO VENCE", Blue=otherwise |
| 10 | (action) | "Ver Detalles" button |

**Detail Table (innerTable in details row, 13 columns):**
| # | Column Name (case-sensitive) | Notes |
|---|------------------------------|-------|
| 0 | ID RE | Hidden |
| 1 | ID CI | Hidden |
| 2 | TIPO CI | Plain text |
| 3 | NOMBRE CI | Plain text |
| 4 | NRO SERIE | Plain text |
| 5 | PROPIETARIO | Plain text |
| 6 | DESCRIPCION CI | Plain text |
| 7 | ID_LICENCIA_ELE_CONF | Hidden |
| 8 | SEDE | Plain text |
| 9 | LOCAL | Plain text |
| 10 | AREA | Plain text |
| 11 | NRO PISO | Plain text |
| 12 | NRO AMBIENTE | Plain text |

**Inline Color HTML:** None directly in cells (uses `tCell.ForeColor` programmatic coloring)

**Session["Imprimir"]:** `"REPORTE_LICENCIAS_CI"`
- Object[] format: `{ "REPORTE_LICENCIAS_CI", dtLICENCIAS, "REPORTE DE LICENCIAS DE ELEMENTO CONFIGURACION SOFTWARE", dtDETALLE_LICENCIA }`

**Special Features:**
- Expandable rows: "Ver Detalles" button shows/hides detail rows via `toggleRow('details-{id}')` JavaScript
- Detail rows initially hidden with `display: none`
- Dual table structure (main licenses + nested detail table)

**Empty State Colspan:** 10 (main table)

---

## 10. ReporteSeguimientosElementoConfiguracion.aspx.cs

**Stored Procedure:** `[dbo].[pr_ReporteSeguimientoElementosConfiguracion]`

**Columns (20):**
| # | Column Name (case-sensitive) | Notes |
|---|------------------------------|-------|
| 0 | ID CI | Hidden |
| 1 | NOMBRE CI | Plain text |
| 2 | TIPO CI | Plain text |
| 3 | NRO. SERIE | Plain text |
| 4 | FABRICANTE / PROVEEDOR | Hidden |
| 5 | MARCA | Hidden |
| 6 | MODELO | Hidden |
| 7 | ESTADO | Conditional ForeColor: Blue=ACTIVO, Red=otherwise; Hidden |
| 8 | DESCRIPCION CI | Plain text |
| 9 | SEDE / LOCAL | Inline color HTML: `<font color=red>{SEDE}</font> / <font color=blue>{LOCAL}</font>` |
| 10 | UBICACION / DIRECCION | Inline color HTML: `<font color=red>{UBICACION}</font> / <font color=blue>{DIRECCION}</font>` |
| 11 | AREA / NRO PISO / NRO AMBIENTE | Inline color HTML: `<font color=red>{AREA}</font> / <font color=blue>{NRO PISO}</font> / <font color=black>{NRO AMBIENTE}</font>` |
| 12 | RESPONSABLE | Plain text |
| 13 | FECHA SEGUIMIENTO | ForeColor=Green, Font.Bold=true |
| 14 | CLASIFICACION DATOS | Plain text |
| 15 | ESTADO ACTUAL | With comma-to-`<br>` replacement |
| 16 | RELACION CIS | Conditional ForeColor: Blue=SI, Red=NO |
| 17 | CUMPLE POLITICA GESTION CONIGURACION ORGANIZACION | Conditional ForeColor: Blue=SI, Red=NO |
| 18 | OBSERVACION | Plain text |
| 19 | (EDITAR button) | Button with CssClass="btn btn-success", enabled only if current date = FECHA SEGUIMIENTO |

**Inline Color HTML:** `<font color=red>`, `<font color=blue>`, `<font color=black>` in columns 9, 10, 11

**Session["Imprimir"]:** `"REPORTE_SEGUIMIENTO_CIs"`
- Object[] format: `{ "REPORTE_SEGUIMIENTO_CIs", dt, "REPORTE DE SEGUIMIENTO DE ELEMENTOS DE CONFIGURACION" }`

**Special Features:**
- EDITAR button with conditional visibility (enabled only when system date equals FECHA SEGUIMIENTO)
- Button passes extensive CommandArgument with all CI and seguimiento data
- No expandable rows, no dedup, no dual tables

**Empty State Colspan:** 20

---

## 11. ReporteElementosConfiguracion.aspx.cs

**Stored Procedure:** `[dbo].[pr_ReporteElementosConfiguracion]` (note leading space in raw code)

**Columns (20):**
| # | Column Name (case-sensitive) | Notes |
|---|------------------------------|-------|
| 0 | ID CI | Hidden |
| 1 | NOMBRE CI | Plain text |
| 2 | NOMBRE TIPO CI | Plain text |
| 3 | NRO SERIE | Plain text |
| 4 | FABRICANTE / PROVEEDOR | Plain text |
| 5 | MARCA / MODELO | Inline color HTML: `<font color=blue><b>{MARCA}</b></font> / <font color=red><b>{MODELO}</b></font>` |
| 6 | IP | Plain text |
| 7 | GATEWAY | Plain text |
| 8 | GRUPO TRABAJO | Plain text |
| 9 | ESTADO CI | Conditional ForeColor: Blue=ACTIVO, Red=otherwise |
| 10 | PROPIETARIO | Plain text |
| 11 | DESCRIPCION CI | Plain text |
| 12 | IMPACTO CI / NIVEL PRIORIDAD | Combined with `<b>  /  </b>`: `{IMPACTO CI}<b>  /  </b>{NIVEL PRIORIDAD}` |
| 13 | SEDE / LOCAL | Inline color HTML: `<FONT COLOR=BLUE><B>{SEDE}</B></FONT> / <FONT COLOR=RED><B>{LOCAL}</B></FONT>` with `<BR>` |
| 14 | UBICACION LOCAL | Hidden |
| 15 | DIRECCION LOCAL | Hidden |
| 16 | AREA | Plain text |
| 17 | NRO PISO / NRO AMBIENTE | Inline color HTML: `<FONT COLOR=BLUE><B>{NRO PISO}</B></FONT> / <FONT COLOR=RED><B>{NRO AMBIENTE}</B></FONT>` |
| 18 | FEC. CREACION CI | Plain text |
| 19 | RESPONSABLE | Plain text |

**Inline Color HTML:** `<font color=blue>`, `<font color=red>`, `<FONT COLOR=BLUE>`, `<FONT COLOR=RED>` in multiple cells

**Session["Imprimir"]:** `"REPORTE_ELEMENTOS_CONFIGURACION"`
- Object[] format: `{ "REPORTE_ELEMENTOS_CONFIGURACION", dt, "REPORTE DE ELEMENTOS DE CONFIGURACION" }`

**Special Features:** None (no EDITAR button, no dedup, no expandable rows, no dual tables)

**Empty State Colspan:** 20

---

## Summary Table

| Report | SP Name | Columns | Inline Color Tags | Session Key | Dedup | Expandable | Dual Tables | Summary Rows |
|--------|---------|---------|-------------------|-------------|-------|------------|-------------|--------------|
| ReporteDatosIncorrectosCI | pr_ReporteDatosIncorrectosCI | 5 | None | REPORTE_DATOS_INCORRECTOS_CIs | No | No | No | Yes (3 rows) |
| ReporteDatosCorrectosCI | pr_ReporteDatosCorrectosCI | 5 | None (ForeColor) | REPORTE_DATOS_CORRECTOS_CIs | No | No | No | Yes (6 rows) |
| ReporteCIsSeguidos | pr_ReporteCIsSeguidos | 8 | font color=blue/red | REPORTE_CIs_SEGUIDOS | No | No | No | Yes (3 rows) |
| Reporte_CIS_Relacionados_Con_Otros_CIS | pr_Reporte_CIS_Relacionados_Con_Otros_CIS | 6 | font color=blue/red | REPORTE_DE_CIS_RELACIONADOS_CON_OTROS_CIS | Yes | No | No | Yes (labels) |
| Reporte_De_CIS_Relativo_A_Servicios | pr_Reporte_De_CIS_Relativo_A_Servicios | 6 | font color=blue/red | REPORTE_DE_CIS_RELATIVO_A_SERVICIOS | Yes | No | No | Yes (labels) |
| ReporteComponentesAsignados | pr_ListaElementosConfiguracionComponenetesAsignados | 18 (+7 detail) | font color=red/blue | REPORTE_COMPONENTES_CI | No | Yes (DETALLE) | Yes | No |
| ReporteCIsInformacionContenidaEnCMDB | pr_Reporte_CIs_Información_Contenidas_En_CMDB (x2) | 20 + 10 | font color=blue/red, FONT COLOR= | Separate calls | No | No | Yes | Yes (labels) |
| ReporteRelacionesElementosConfiguracion | pr_ListaRelacionElementosConfiguracion | 6 | font color=blue/red | REPORTE_RELACIONES_ELEMENTOS_CONFIGURACION | No | No | No | No |
| ReporteLicenciasElementoConfiguracion | pr_ListaLicencias + pr_ListaRelacionLicenciaElementosConfiguracion | 10 (+13 detail) | None (ForeColor) | REPORTE_LICENCIAS_CI | No | Yes (Ver Detalles) | Yes | No |
| ReporteSeguimientosElementoConfiguracion | pr_ReporteSeguimientoElementosConfiguracion | 20 | font color=red/blue/black | REPORTE_SEGUIMIENTO_CIs | No | No | No | No |
| ReporteElementosConfiguracion | pr_ReporteElementosConfiguracion | 20 | font color=blue/red, FONT COLOR= | REPORTE_ELEMENTOS_CONFIGURACION | No | No | No | No |

---

## Color CSS Class Mapping Requirements

The following inline color HTML patterns need to be converted to CSS classes:

| Inline HTML Pattern | Suggested CSS Class |
|--------------------|---------------------|
| `<font color=blue>` | `.color-blue` or `.text-blue` |
| `<font color=red>` | `.color-red` or `.text-red` |
| `<font color=green>` | `.color-green` or `.text-green` |
| `<font color=black>` | `.color-black` or `.text-black` |
| `<FONT COLOR=BLUE>` | same as above |
| `<FONT COLOR=RED>` | same as above |
| `<FONT COLOR=GREEN>` | same as above |
| `<font color=gren>` (misspelled) | `.color-green` (fix typo) |

---

## Notes

- Column names are **case-sensitive** and include spaces and accented characters (e.g., "FABRICANTE / PROVEEDOR", "NRO. SERIE", "IMPACTO CI", "CUMPLE POLITICA GESTION CONIGURACION ORGANIZACION")
- Some reports use `<BR>` tags within single cells for multi-line content
- Summary rows are sometimes injected directly into the DataTable before rendering, not added as extra table rows
- The `IMPRIMIR` session key structure varies: some pass 3 objects, some pass 4-5 (with T, A, X statistics)
- `Session["CABECERA"]` is used in ReporteComponentesAsignados to store the main dt for later use during print
