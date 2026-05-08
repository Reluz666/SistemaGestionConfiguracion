# Estandarizar Vistas de Reportes al Patrón Personal

## TL;DR

> **Quick Summary**: Migrar 11 vistas de reportes en `Reportes/` del patrón server-side (`asp:Table` + checkbox/dropdown) al estándar client-side establecido en Personal.aspx (JSON + JS rendering + búsqueda + paginación), unificando layout, CSS y JS compartidos, conservando la integración con Crystal Reports para impresión.

> **Deliverables**:
> - 11 reportes migrados a client-side rendering (JSON + HTML table + search + pagination)
> - CSS inline duplicado eliminado (referencia a `global-styles.css`)
> - JS duplicado eliminado (referencia a `utils.js`)
> - Funcionalidad de impresión Crystal Reports conservada
> - Layout unificado `form-card` en todos los reportes

> **Estimated Effort**: Large (11 reportes × 3 archivos cada uno)
> **Parallel Execution**: YES - 4 waves
> **Critical Path**: Wave 1 → Wave 2 (pilot) → Wave 3 (medium) → Wave 4 (complex) → Wave FINAL

---

## Context

### Original Request
> "verificar los cambios realizados como estándar de Personal, donde se retiraron comboboxes y demás, se hicieron cambios en las tablas añadiendo paginación y demás, todo eso que se aplique en todas las vistas de Reportes"

### Interview Summary
**Key Discussions**:
- **Filtro**: Reemplazar checkbox+dropdown pairs con barra de búsqueda unificada (como Personal)
- **Alcance**: Solo 11 reportes con tablas de datos; excluir Default.aspx, Default2.aspx, Reporte.aspx (visores Crystal Reports)
- **Estrategia**: Migración completa client-side (JSON + JS rendering + search + pagination)
- **Testing**: QA manual, sin tests automatizados
- **Impresión**: Conservar Crystal Reports vía `Session["Imprimir"]`

**Research Findings**:
- `CssJs/global-styles.css` (597 líneas) ya contiene TODOS los estilos compartidos: navbar, form-card, table-modern-grid, pagination-wrapper, search-input, btn-modern, etc.
- `src/js/utils.js` (35 líneas) ya contiene: `MostrarMensaje()`, `Confirmar()`, `SoloNumeros()`, `CambiaLetraMayuscula()`, `htmlEncode()`
- 10 de 11 reportes usan `Session["Imprimir"]` para pasar DataTable al visor Crystal Reports
- Cada reporte tiene su propio stored procedure con columnas únicas
- ReporteCIsInformacionContenidaEnCMDB es único: renderiza DOS tablas (Elementos + Licencias), no usa Crystal Reports
- ReporteLicenciasElementoConfiguracion usa `asp:UpdatePanel` (incompatible con client-side rendering)
- ReporteComponentesAsignados y ReporteLicenciasElementoConfiguracion tienen filas expandibles (detalle)
- 3 reportes agregan filas de resumen estadístico al final de la tabla

### Metis Review
**Identified Gaps** (addressed):
- Arquitectura de filtrado: Se decide client-side (como Personal), cargando todos los datos y filtrando en navegador. Riesgo de performance en datasets grandes mitigado por paginación.
- UpdatePanel en ReporteLicencias: Se elimina; el toggle de filas expandibles se implementa client-side.
- Doble serialización: Cada code-behind serializa a JSON (para la página) Y guarda el DataTable en Session (para Crystal Reports).
- Filas expandibles: Se implementan con toggle client-side (CSS class + JS click handler).
- Filas resumen: Se renderizan como `<tfoot>` en la tabla HTML.
- Botón EDITAR en ReporteSeguimientos: Se convierte a función client-side tipo `seleccionarPersonal`.
- Reporte dual-table: Dos `form-card` separados en la misma página.
- Date picker: Se usa `<input type="date">` nativo HTML5.
- Rows per page: 10 (mismo que Personal).
- `else if` → Multi-criterio: La barra de búsqueda busca en TODAS las columnas simultáneamente.

---

## Work Objectives

### Core Objective
Migrar las 11 vistas de reportes a rendering client-side con búsqueda unificada y paginación, igualando el estándar de Personal.aspx en layout, CSS y JS, conservando la impresión Crystal Reports.

### Concrete Deliverables
- 11 archivos `.aspx` migrados (HTML table + search + pagination + form-card layout)
- 11 archivos `.aspx.cs` migrados (JavaScriptSerializer + DataTable preservation)
- CSS inline duplicado eliminado en 11 archivos (reemplazado por `global-styles.css`)
- JS duplicado eliminado en 11 archivos (reemplazado por `utils.js`)
- `Session["Imprimir"]` preservado en 10 reportes que usan Crystal Reports

### Definition of Done
- [ ] `Select-String -Path "Reportes\*.aspx" -Pattern "<asp:Table"` → zero matches (except excluded files)
- [ ] `Select-String -Path "Reportes\*.aspx" -Pattern "\.navbar-modern"` → zero matches (navbar CSS moved to global)
- [ ] Cada reporte tiene `CssJs/global-styles.css` y `src/js/utils.js` referenciados
- [ ] Cada reporte renderiza tabla con datos desde `datosJson` HiddenField
- [ ] Búsqueda y paginación funcionan sin postback
- [ ] Impresión Crystal Reports funciona (popup window con Reporte.aspx)
- [ ] Layout `form-card` consistente en todos los reportes

### Must Have
- Búsqueda client-side en tiempo real para cada reporte
- Paginación client-side (10 filas por página)
- Layout `form-card` con Bootstrap grid (no tablas anidadas)
- Referencia a `global-styles.css` y `utils.js` (no CSS/JS duplicado)
- `JavaScriptSerializer` para serialización JSON
- `htmlEncode()` en todo output de datos
- `Session["Imprimir"]` preservado para Crystal Reports
- `Page_init()` con verificación de permisos
- `ClientIDMode="Static"` en `datosJson` HiddenField

### Must NOT Have (Guardrails)
- NO `<asp:Table>` para renderizar datos (usar HTML `<table>`)
- NO CSS navbar/form-card/table duplicado inline (usar `global-styles.css`)
- NO funciones JS duplicadas (`MostrarMensaje`, `Confirmar`, `htmlEncode`)
- NO `StringBuilder` manual para JSON (usar `JavaScriptSerializer`)
- NO `UpdatePanel` / `ScriptManager` (eliminar de ReporteLicencias)
- NO `$(document).ready()` (usar `window.addEventListener('load', ...)`)
- NO modificar stored procedures ni archivos Crystal Reports `.rpt`
- NO modificar `PaginaMaestra.master`, `NavBar.ascx`, ni vistas principales
- NO agregar sorting, export a Excel/PDF, ni features no solicitados

---

## Verification Strategy (MANDATORY)

> **ZERO HUMAN INTERVENTION** - ALL verification is agent-executed. No exceptions.

### Test Decision
- **Infrastructure exists**: NO (ASP.NET Web Forms, sin framework de testing)
- **Automated tests**: None
- **Framework**: N/A

### QA Policy
Every task MUST include agent-executed QA scenarios.
Evidence saved to `.sisyphus/evidence/task-{N}-{scenario-slug}.{ext}`.

- **File-level verification**: Grep/glob for pattern compliance (no `<asp:Table`, no duplicated CSS/JS)
- **Code-level verification**: LSP diagnostics, grep for `JavaScriptSerializer`, `ClientIDMode`
- **Runtime verification**: Playwright browser automation for table rendering, search, pagination, Crystal Reports popup

---

## Execution Strategy

### Parallel Execution Waves

> Maximize throughput by grouping independent tasks into parallel waves.

```
Wave 1 (Foundation - shared patterns + analysis):
├── Task 1: Analyze all report stored procedures [quick]
├── Task 2: Create shared JS module for grid functions [quick]
├── Task 3: Migrate ReporteDatosIncorrectosCI (pilot - simplest: 4 cols) [quick]
└── Task 4: Migrate ReporteDatosCorrectosCI (pilot - 6 cols + stats) [quick]

Wave 2 (Simple reports - MAX PARALLEL):
├── Task 5: Migrate ReporteCIsSeguidos (5 cols + stats) [unspecified-high]
├── Task 6: Migrate Reporte_CIS_Relacionados_Con_Otros_CIS (5 cols + dedup) [unspecified-high]
├── Task 7: Migrate Reporte_De_CIS_Relativo_A_Servicios (5 cols + dedup) [unspecified-high]
├── Task 8: Migrate ReporteComponentesAsignados (5 cols + expandable) [unspecified-high]
└── Task 9: Migrate ReporteCIsInformacionContenidaEnCMDB (dual-table) [unspecified-high]

Wave 3 (Medium complexity reports - MAX PARALLEL):
├── Task 10: Migrate ReporteRelacionesElementosConfiguracion (7 cols) [unspecified-high]
├── Task 11: Migrate ReporteLicenciasElementoConfiguracion (7 cols + expandable + UpdatePanel removal) [unspecified-high]
└── Task 12: Migrate ReporteSeguimientosElementoConfiguracion (8 cols + EDITAR button) [unspecified-high]

Wave 4 (Complex report - large column count):
└── Task 13: Migrate ReporteElementosConfiguracion (20 cols, 14 filters) [unspecified-high]

Wave FINAL (After ALL tasks — 4 parallel reviews, then user okay):
├── Task F1: Plan compliance audit (oracle)
├── Task F2: Code quality review (unspecified-high)
├── Task F3: Runtime QA verification (unspecified-high + playwright)
└── Task F4: Scope fidelity check (deep)
```

Critical Path: Task 1 → Task 2 → Task 3 → Wave 2-4 → F1-F4
Parallel Speedup: ~75% faster than sequential
Max Concurrent: 5 (Wave 2)

---

## TODOs

### Wave 1 — Foundation + Pilot Reports

- [ ] 1. **Analyze all report stored procedures and column mappings**

  **What to do**:
  - Read each of the 11 report code-behind files and extract:
    - Stored procedure name called
    - Column names from `dt.Rows[i]["..."]` (case-sensitive, with spaces/accents)
    - Number of columns (for `colspan` in empty state)
    - Which columns use inline color HTML (`<font color=...>`) that must become CSS classes
    - Whether the report uses `Session["Imprimir"]` (and the report identifier string)
    - Special features: expandable rows, summary rows, EDITAR button, dedup logic, dual tables
  - Create a reference document `.sisyphus/drafts/report-column-mappings.md` with the extracted data per report

  **Must NOT do**:
  - Do NOT modify any files; read-only analysis
  - Do NOT assume column names match across reports

  **Recommended Agent Profile**:
  - **Category**: `quick`
  - **Skills**: `[]`

  **Parallelization**:
  - **Can Run In Parallel**: YES (with Task 2)
  - **Parallel Group**: Wave 1
  - **Blocks**: Task 3, Task 4 (informs migration)
  - **Blocked By**: None

  **References**:
  - `Reportes/*.aspx.cs` (11 files) - Extract SP name, columns, special features from `Listar_*` and `Page_init` methods
  - `Personal.aspx.cs:164-219` - Reference pattern for `Cargar_Lista_Personal()` JSON serialization

  **Acceptance Criteria**:
  - [ ] Reference document created at `.sisyphus/drafts/report-column-mappings.md`
  - [ ] Document lists all 11 reports with: SP name, columns, special features, Session["Imprimir"] identifier

  **QA Scenarios**:
  ```
  Scenario: Document completeness check
    Tool: Bash (grep)
    Preconditions: Reference document exists
    Steps:
      1. Count reports in document: grep -c "Report:" .sisyphus/drafts/report-column-mappings.md
      2. Verify each has SP name, columns list, special features section
    Expected Result: 11 reports documented with all required fields
    Evidence: .sisyphus/evidence/task-1-column-mappings.txt
  ```

  **Commit**: YES
  - Message: `docs(reportes): column mappings reference for report migration`
  - Files: `.sisyphus/drafts/report-column-mappings.md`

- [ ] 2. **Create shared JS grid module (`src/js/grid-utils.js`)**

  **What to do**:
  - Extract the reusable pagination and rendering functions from Personal.aspx JS (lines 150-297) into a new shared file
  - Create `src/js/grid-utils.js` with parameterized functions:
    - `createGrid(config)` — config object: `{ tableId, tbodyId, searchInputId, paginationWrapperId, pageInfoId, counterId, dataFieldId, rowsPerPage, searchFields, columnRenderer }`
    - `htmlEncode(str)` — already in utils.js, reference it
  - The `config.columnRenderer(item)` is a callback that returns an HTML string for a single row — each report provides its own renderer
  - Include: `filtrarTabla()`, `renderizarTabla()`, `generarPaginacion(totalPages)`, `Paginar(page)`
  - Update Personal.aspx to reference `src/js/grid-utils.js` and use `createGrid()` instead of inline functions
  - Add the `<script>` tag for `grid-utils.js` in Personal.aspx

  **Must NOT do**:
  - Do NOT break existing Personal.aspx functionality
  - Do NOT hardcode column count or field names

  **Recommended Agent Profile**:
  - **Category**: `quick`
  - **Skills**: `[]`

  **Parallelization**:
  - **Can Run In Parallel**: YES (with Task 1)
  - **Parallel Group**: Wave 1
  - **Blocks**: Task 3 through Task 13 (shared dependency)
  - **Blocked By**: None

  **References**:
  - `Personal.aspx:150-297` - Source JS functions to extract and parameterize
  - `src/js/utils.js:1-35` - Existing shared utilities (htmlEncode at line 32)
  - `CssJs/global-styles.css:378-400` - Pagination CSS classes used

  **Acceptance Criteria**:
  - [ ] `src/js/grid-utils.js` file created with `createGrid()` function
  - [ ] Personal.aspx updated to use `createGrid()` and still works
  - [ ] `createGrid()` accepts config object with all parameters listed above

  **QA Scenarios**:
  ```
  Scenario: Personal.aspx still works after refactor
    Tool: Playwright
    Preconditions: Personal.aspx updated to use grid-utils.js
    Steps:
      1. Navigate to Personal.aspx
      2. Assert: Table #tblListaPersonal renders rows in tbody
      3. Type "test" in #txtBuscarPersonal
      4. Assert: Row count changes (filtered)
      5. Click clear button (× icon)
      6. Assert: All rows restored
      7. If pagination visible, click page 2
      8. Assert: Page info shows "Pagina 2 de N"
      9. Check browser_console_messages for errors
    Expected Result: All Personal functionality preserved, no console errors
    Evidence: .sisyphus/evidence/task-2-personal-regression.png
  ```

  **Commit**: YES
  - Message: `refactor(js): extract shared grid utilities to grid-utils.js`
  - Files: `src/js/grid-utils.js`, `Personal.aspx`

- [ ] 3. **Migrate ReporteDatosIncorrectosCI (PILOT — simplest report)**

  **What to do**:
  - **Code-behind** (`ReporteDatosIncorrectosCI.aspx.cs`):
    - Add `using System.Web.Script.Serialization;`
    - In `Listar_Datos_Incorrectos_CI()` method: After the DataTable `dt` is populated, serialize to JSON using `JavaScriptSerializer` + anonymous type list (follow Personal.aspx.cs:180-203 pattern)
    - Set `this.datosJson.Value = serializer.Serialize(lista);`
    - If report uses Crystal Reports, ALSO store the DataTable: `IMPRIMIR.Page.Session.Add("Imprimir", new Object[] { "REPORTE_DATOS_INCORRECTOS_CI", dt, "REPORTE DE DATOS INCORRECTOS CI" });`
  - **ASPX** (`ReporteDatosIncorrectosCI.aspx`):
    - Replace ALL inline `<style>` with: `<link href="../CssJs/global-styles.css" rel="stylesheet" />`
    - Add: `<script src="../src/js/utils.js"></script>`, `<script src="../src/js/grid-utils.js"></script>`
    - Replace `<asp:Table ID="Table_">` block with HTML table using `table-modern-grid` class, proper `<thead>` with column headers, `<tbody>` for data
    - Add search bar HTML (input-group with search icon, clear button, counter)
    - Add pagination HTML (`.pagination-wrapper` with `<ul>`)
    - Add `<asp:HiddenField ID="datosJson" ClientIDMode="Static" EnableViewState="False" />`
    - Restructure layout to `.form-card` > `.card-header` (not nested `<table>`)
  - **JavaScript inline**: Write `createGrid()` call specific to this report's columns.

  **Must NOT do**:
  - Do NOT remove `Session["Imprimir"]` if the report uses Crystal Reports
  - Do NOT change the stored procedure call or its parameters
  - Do NOT remove permission verification in `Page_init`

  **Recommended Agent Profile**:
  - **Category**: `quick`
  - **Skills**: `[]`

  **Parallelization**:
  - **Can Run In Parallel**: NO (pilot — must complete before Wave 2)
  - **Parallel Group**: Wave 1 (sequential within wave)
  - **Blocks**: None directly (pattern validation for Wave 2)
  - **Blocked By**: Task 1, Task 2

  **References**:
  - `Reportes/ReporteDatosIncorrectosCI.aspx` — Current ASPX (full file to migrate)
  - `Reportes/ReporteDatosIncorrectosCI.aspx.cs` — Current code-behind (full file to migrate)
  - `Personal.aspx:377-436` — HTML structure pattern (container > form-card > search > table > pagination)
  - `Personal.aspx:143-297` — JS pattern for `createGrid()` usage
  - `Personal.aspx.cs:164-219` — `JavaScriptSerializer` + anonymous type serialization pattern

  **Acceptance Criteria**:
  - [ ] Zero `<asp:Table` in migrated ASPX
  - [ ] `JavaScriptSerializer` used in code-behind (not StringBuilder)
  - [ ] `datosJson` HiddenField with `ClientIDMode="Static"`
  - [ ] `global-styles.css` referenced
  - [ ] `utils.js` and `grid-utils.js` referenced
  - [ ] Search bar, table, pagination HTML present
  - [ ] `Session["Imprimir"]` preserved (if used)

  **QA Scenarios**:
  ```
  Scenario: Table renders data from JSON
    Tool: Playwright
    Preconditions: Page deployed and accessible
    Steps:
      1. Navigate to Reportes/ReporteDatosIncorrectosCI.aspx
      2. Wait for table tbody to have rows
      3. Assert: Table has > 0 rows OR shows "No hay datos disponibles" message
      4. Check browser_console_messages level=error
    Expected Result: Zero JS errors. Table renders correctly.
    Evidence: .sisyphus/evidence/task-3-table-render.png

  Scenario: Search filters table in real time
    Tool: Playwright
    Preconditions: Table has data rows
    Steps:
      1. Type known text in search input
      2. Wait 500ms for filter
      3. Assert: Row count is less than or equal to original
      4. Assert: All visible rows contain search text (case insensitive)
    Expected Result: Filtered rows all match search criteria
    Evidence: .sisyphus/evidence/task-3-search-filter.png

  Scenario: Pagination navigation
    Tool: Playwright
    Preconditions: More than 10 rows
    Steps:
      1. Assert pagination wrapper is visible
      2. Click page 2 link
      3. Assert page info shows "Pagina 2 de N"
      4. Click "Anterior"
      5. Assert page info shows "Pagina 1 de N"
    Expected Result: Pagination navigates correctly
    Evidence: .sisyphus/evidence/task-3-pagination.png
  ```

  **Commit**: YES
  - Message: `feat(reportes): migrate ReporteDatosIncorrectosCI to client-side pattern`
  - Files: `Reportes/ReporteDatosIncorrectosCI.aspx`, `Reportes/ReporteDatosIncorrectosCI.aspx.cs`

- [ ] 4. **Migrate ReporteDatosCorrectosCI (PILOT — stats rows)**

  **What to do**:
  - Same migration pattern as Task 3, PLUS:
  - This report has statistical summary rows appended after data rows. Render them in `<tfoot>` section of the HTML table.
  - Identify the summary data (totals, percentages, legend) in the code-behind and serialize them separately or include in JSON with a flag.
  - In the column renderer, check for the summary flag and render with special CSS classes.

  **Must NOT do**:
  - Same as Task 3

  **Recommended Agent Profile**:
  - **Category**: `quick`
  - **Skills**: `[]`

  **Parallelization**:
  - **Can Run In Parallel**: NO (pilot — pattern validation)
  - **Parallel Group**: Wave 1
  - **Blocks**: None
  - **Blocked By**: Task 1, Task 2, Task 3 (learn from pilot 1)

  **References**:
  - `Reportes/ReporteDatosCorrectosCI.aspx` + `.cs` — Full files to migrate
  - Task 3 migrated files — Pattern reference for approach
  - `Personal.aspx:197-239` — Row rendering pattern (`renderizarTablaPersonal`)

  **Acceptance Criteria**:
  - [ ] Same structural criteria as Task 3
  - [ ] Statistical summary rows rendered in `<tfoot>`
  - [ ] Summary data visually distinct from data rows

  **QA Scenarios**:
  ```
  Scenario: Stats rows render in tfoot
    Tool: Playwright
    Preconditions: Data has summary rows
    Steps:
      1. Navigate to report page
      2. Assert: tfoot element exists with summary rows
      3. Assert: Summary text contains "CANTIDAD" or "%" or legend text
    Expected Result: Summary rows visible below data, visually distinct
    Evidence: .sisyphus/evidence/task-4-stats-rows.png

  Scenario: Search and pagination work correctly
    Tool: Playwright
    Preconditions: Table has data
    Steps:
      1. Type search text, verify filtering
      2. Clear search, verify all rows restored
      3. Navigate pagination pages
    Expected Result: All standard grid features work
    Evidence: .sisyphus/evidence/task-4-grid-features.png
  ```

  **Commit**: YES
  - Message: `feat(reportes): migrate ReporteDatosCorrectosCI to client-side pattern with stats rows`
  - Files: `Reportes/ReporteDatosCorrectosCI.aspx`, `Reportes/ReporteDatosCorrectosCI.aspx.cs`

---

### Wave 2 — Simple Reports (MAX PARALLEL — all 5 can run simultaneously)

- [ ] 5. **Migrate ReporteCIsSeguidos (stats rows)**

  **What to do**:
  - Apply the standard migration pattern (JSON + HTML table + search + pagination) following Tasks 3-4 as reference
  - This report adds statistical rows ("CANTIDAD DE CIs...", "% DE CIs SEGUIDOS") — render in `<tfoot>`
  - Remove checkbox+dropdown filter pairs (3 checkboxes: cbci, cbs, cbf)
  - Replace with unified search bar searching across: NOMBRE CI, TIPO CI, ESTADO CI, SEDE, FEC. SEGUIMIENTO
  - Preserve `Session["Imprimir"]` with identifier `"REPORTE_CIs_SEGUIDOS"`

  **Must NOT do**:
  - Same guardrails as Task 3

  **Recommended Agent Profile**:
  - **Category**: `unspecified-high`
  - **Skills**: `[]`

  **Parallelization**:
  - **Can Run In Parallel**: YES (with Tasks 6, 7, 8, 9)
  - **Parallel Group**: Wave 2
  - **Blocks**: None
  - **Blocked By**: Task 2 (grid-utils.js)

  **References**:
  - `Reportes/ReporteCIsSeguidos.aspx` + `.cs` — Files to migrate
  - Tasks 3-4 migrated files — Pattern reference
  - `Reportes/ReporteCIsSeguidos.aspx.cs:54` — Session["Imprimir"] pattern

  **Acceptance Criteria**:
  - [ ] Same structural criteria as Task 3
  - [ ] Statistical rows in `<tfoot>`
  - [ ] `Session["Imprimir"]` preserved

  **QA Scenarios**:
  ```
  Scenario: Report renders with stats and pagination
    Tool: Playwright
    Steps:
      1. Navigate to ReporteCIsSeguidos.aspx
      2. Assert: Table has rows, tfoot has stats
      3. Test search, pagination
      4. Test Crystal Reports print button opens popup
      5. Check browser_console_messages
    Expected Result: All features functional, no errors
    Evidence: .sisyphus/evidence/task-5-full-verify.png
  ```

  **Commit**: YES — grouped with Wave 2
  - Message: `feat(reportes): migrate ReporteCIsSeguidos to client-side pattern`
  - Files: `Reportes/ReporteCIsSeguidos.aspx`, `Reportes/ReporteCIsSeguidos.aspx.cs`

- [ ] 6. **Migrate Reporte_CIS_Relacionados_Con_Otros_CIS (dedup logic)**

  **What to do**:
  - Apply standard migration pattern
  - This report has row deduplication: when a parent row has the same value as the previous row, it's cleared. Implement this in the client-side column renderer: compare current item's parent field with previous item, return empty string if same.
  - Remove checkbox+dropdown pairs (4 checkboxes: cbnci, cbs, cbr, cbf)
  - Preserve `Session["Imprimir"]` with identifier `"REPORTE_CIs_Relacionados_Con_Otros_CIs"`

  **Must NOT do**:
  - Same guardrails as Task 3

  **Recommended Agent Profile**:
  - **Category**: `unspecified-high`
  - **Skills**: `[]`

  **Parallelization**:
  - **Can Run In Parallel**: YES (with Tasks 5, 7, 8, 9)
  - **Parallel Group**: Wave 2
  - **Blocks**: None
  - **Blocked By**: Task 2

  **References**:
  - `Reportes/Reporte_CIS_Relacionados_Con_Otros_CIS.aspx` + `.cs`
  - `Personal.aspx:197-239` — Row rendering pattern; adapt for dedup comparison

  **Acceptance Criteria**:
  - [ ] Same structural criteria as Task 3
  - [ ] Parent row deduplication works (repeated values shown as empty)
  - [ ] `Session["Imprimir"]` preserved

  **QA Scenarios**:
  ```
  Scenario: Deduplication works correctly
    Tool: Playwright
    Steps:
      1. Navigate to report
      2. Assert: Consecutive rows with same parent value show empty cell
      3. Assert: First occurrence shows the value
    Expected Result: Dedup logic matches original behavior
    Evidence: .sisyphus/evidence/task-6-dedup.png
  ```

  **Commit**: YES — grouped with Wave 2

- [ ] 7. **Migrate Reporte_De_CIS_Relativo_A_Servicios (dedup logic)**

  **What to do**:
  - Same pattern as Task 6 (dedup logic)
  - Remove checkbox+dropdown pairs (4 checkboxes)
  - Preserve `Session["Imprimir"]` with identifier `"REPORTE_De_CIS_Relativo_A_Servicios"`

  **Must NOT do**:
  - Same guardrails as Task 3

  **Recommended Agent Profile**:
  - **Category**: `unspecified-high`
  - **Skills**: `[]`

  **Parallelization**:
  - **Can Run In Parallel**: YES (with Tasks 5, 6, 8, 9)
  - **Parallel Group**: Wave 2
  - **Blocks**: None
  - **Blocked By**: Task 2

  **References**:
  - `Reportes/Reporte_De_CIS_Relativo_A_Servicios.aspx` + `.cs`

  **Acceptance Criteria**:
  - [ ] Same as Task 6

  **QA Scenarios**:
  ```
  Scenario: Dedup and search work correctly
    Tool: Playwright
    Steps:
      1. Navigate, verify table renders
      2. Test dedup behavior
      3. Test search filtering
      4. Test pagination
      5. Check Crystal Reports print button
    Expected Result: All features functional
    Evidence: .sisyphus/evidence/task-7-full-verify.png
  ```

  **Commit**: YES — grouped with Wave 2

- [ ] 8. **Migrate ReporteComponentesAsignados (expandable detail rows)**

  **What to do**:
  - Apply standard migration pattern
  - This report has expandable detail rows (second table `Table_0` showing component details when a row is clicked)
  - Implement as client-side toggle: each row has a `[+]` button; clicking it inserts/removes a detail row below with component info
  - Data for detail rows must be serialized separately in JSON (nested array per parent row)
  - Remove checkbox+dropdown pairs
  - Preserve `Session["Imprimir"]` with identifier `"REPORTE_COMPONENTES_CI"` plus the components DataTable

  **Must NOT do**:
  - Do NOT lose the detail/component data in migration
  - Same guardrails as Task 3

  **Recommended Agent Profile**:
  - **Category**: `unspecified-high`
  - **Skills**: `[]`

  **Parallelization**:
  - **Can Run In Parallel**: YES (with Tasks 5, 6, 7, 9)
  - **Parallel Group**: Wave 2
  - **Blocks**: None
  - **Blocked By**: Task 2

  **References**:
  - `Reportes/ReporteComponentesAsignados.aspx` + `.cs` — Current expandable row implementation
  - `Reportes/ReporteComponentesAsignados.aspx.cs:1027` — Session["Imprimir"] with dual DataTable

  **Acceptance Criteria**:
  - [ ] Same structural criteria as Task 3
  - [ ] Expand/collapse toggle works client-side (no postback)
  - [ ] Detail rows show component information
  - [ ] `Session["Imprimir"]` preserved with both DataTables

  **QA Scenarios**:
  ```
  Scenario: Expandable rows toggle correctly
    Tool: Playwright
    Steps:
      1. Navigate to report
      2. Click [+] button on first row
      3. Assert: Detail row appears below with component data
      4. Click [-] button
      5. Assert: Detail row disappears
    Expected Result: Toggle works without postback, no console errors
    Evidence: .sisyphus/evidence/task-8-expand-rows.png
  ```

  **Commit**: YES — grouped with Wave 2

- [ ] 9. **Migrate ReporteCIsInformacionContenidaEnCMDB (dual-table, no Crystal Reports)**

  **What to do**:
  - This report is unique: renders TWO separate tables (Elementos + Licencias) and does NOT use Crystal Reports
  - Create TWO `form-card` sections in the ASPX: "Elementos de Configuración" and "Licencias"
  - Each with its own search bar, table, and pagination
  - Code-behind calls the stored procedure TWICE (once with "1" for Elements, once with "2" for Licenses)
  - Serialize TWO separate JSON arrays: `datosJsonElementos` and `datosJsonLicencias` — two HiddenFields
  - No `Session["Imprimir"]` needed (this report doesn't use Crystal Reports)

  **Must NOT do**:
  - Do NOT merge the two tables into one
  - Same guardrails as Task 3

  **Recommended Agent Profile**:
  - **Category**: `unspecified-high`
  - **Skills**: `[]`

  **Parallelization**:
  - **Can Run In Parallel**: YES (with Tasks 5, 6, 7, 8)
  - **Parallel Group**: Wave 2
  - **Blocks**: None
  - **Blocked By**: Task 2

  **References**:
  - `Reportes/ReporteCIsInformacionContenidaEnCMDB.aspx` + `.cs` — Dual-table pattern
  - `Personal.aspx:377-436` — form-card structure (use twice)

  **Acceptance Criteria**:
  - [ ] Two separate form-card sections rendered
  - [ ] Each table has independent search and pagination
  - [ ] No Session["Imprimir"] (not needed)
  - [ ] Two HiddenFields: `datosJsonElementos`, `datosJsonLicencias`

  **QA Scenarios**:
  ```
  Scenario: Both tables render independently
    Tool: Playwright
    Steps:
      1. Navigate to report
      2. Assert: Two form-card sections visible
      3. Assert: Both tables have data rows
      4. Search in table 1: only table 1 filters
      5. Search in table 2: only table 2 filters
      6. Pagination works independently per table
    Expected Result: Independent tables with isolated search/pagination
    Evidence: .sisyphus/evidence/task-9-dual-tables.png
  ```

  **Commit**: YES — grouped with Wave 2

---

### Wave 3 — Medium Complexity Reports (MAX PARALLEL)

- [ ] 10. **Migrate ReporteRelacionesElementosConfiguracion (7 cols)**

  **What to do**:
  - Apply standard migration pattern
  - Remove checkbox+dropdown pairs (8 checkboxes: cbnci, cbtci, cbeci, cbpci, cbdci, cbs, cbl, cba)
  - This report has cascading dropdowns (Sede→Local→Area) — these become unnecessary with search bar; remove the cascading logic
  - Replace with unified search bar searching across: NOMBRE CI, TIPO CI, ESTADO CI, SEDE, LOCAL, AREA, PROPIETARIO
  - Preserve `Session["Imprimir"]` with identifier `"REPORTE_RELACIONES_CIs"`

  **Must NOT do**:
  - Same guardrails as Task 3

  **Recommended Agent Profile**:
  - **Category**: `unspecified-high`
  - **Skills**: `[]`

  **Parallelization**:
  - **Can Run In Parallel**: YES (with Tasks 11, 12)
  - **Parallel Group**: Wave 3
  - **Blocks**: None
  - **Blocked By**: Task 2

  **References**:
  - `Reportes/ReporteRelacionesElementosConfiguracion.aspx` + `.cs`

  **Acceptance Criteria**:
  - [ ] Same structural criteria as Task 3
  - [ ] Cascading dropdown logic removed
  - [ ] `Session["Imprimir"]` preserved

  **QA Scenarios**:
  ```
  Scenario: Report renders and filters correctly
    Tool: Playwright
    Steps:
      1. Navigate to report
      2. Assert: Table renders rows
      3. Test search, pagination
      4. Test Crystal Reports print button
      5. Check browser_console_messages
    Expected Result: All features functional, no cascading dropdowns
    Evidence: .sisyphus/evidence/task-10-full-verify.png
  ```

  **Commit**: YES — grouped with Wave 3
  - Message: `feat(reportes): migrate ReporteRelacionesElementosConfiguracion to client-side`
  - Files: `Reportes/ReporteRelacionesElementosConfiguracion.aspx`, `.cs`

- [ ] 11. **Migrate ReporteLicenciasElementoConfiguracion (expandable + UpdatePanel removal)**

  **What to do**:
  - Apply standard migration pattern
  - **CRITICAL**: This report uses `asp:ScriptManager` and `asp:UpdatePanel` — REMOVE them. Replace the server-side expandable detail rows with client-side toggle (same pattern as Task 8)
  - Remove checkbox+dropdown pairs (7 checkboxes + date fields)
  - Preserve `Session["Imprimir"]` with BOTH DataTables: licenses + license details (dual DataTable pattern)
  - Detail rows serialize nested JSON for each parent row

  **Must NOT do**:
  - Do NOT keep `asp:ScriptManager` or `asp:UpdatePanel`
  - Same guardrails as Task 3

  **Recommended Agent Profile**:
  - **Category**: `unspecified-high`
  - **Skills**: `[]`

  **Parallelization**:
  - **Can Run In Parallel**: YES (with Tasks 10, 12)
  - **Parallel Group**: Wave 3
  - **Blocks**: None
  - **Blocked By**: Task 2, Task 8 (learn from expandable pattern)

  **References**:
  - `Reportes/ReporteLicenciasElementoConfiguracion.aspx` + `.cs` — Current UpdatePanel implementation
  - Task 8 migrated files — Expandable row pattern reference
  - `Reportes/ReporteLicenciasElementoConfiguracion.aspx.cs:694` — Session["Imprimir"] dual DataTable

  **Acceptance Criteria**:
  - [ ] Zero `asp:ScriptManager` or `asp:UpdatePanel` in migrated ASPX
  - [ ] Same structural criteria as Task 3
  - [ ] Expandable detail rows work client-side
  - [ ] `Session["Imprimir"]` preserved with both DataTables

  **QA Scenarios**:
  ```
  Scenario: UpdatePanel removed, expandable rows work
    Tool: Playwright
    Steps:
      1. Navigate to report
      2. Assert: No ScriptManager, no UpdatePanel (view page source)
      3. Click [+] on row with license details
      4. Assert: Detail row appears without page reload
      5. Test search, pagination, Crystal Reports print
    Expected Result: All client-side, no postback for expand
    Evidence: .sisyphus/evidence/task-11-updatepanel-removed.png
  ```

  **Commit**: YES — grouped with Wave 3

- [ ] 12. **Migrate ReporteSeguimientosElementoConfiguracion (EDITAR button)**

  **What to do**:
  - Apply standard migration pattern
  - Remove checkbox+dropdown pairs (5 checkboxes + date fields)
  - This report has an EDITAR button with 25-param `CommandArgument` that populates a form
  - Convert to client-side function like Personal's `seleccionarPersonal()`: click on a row selects it and populates form fields
  - If the form opens a separate page or popup, use `window.open()` or navigate with query params
  - Preserve `Session["Imprimir"]` with identifier `"REPORTE_SEGUIMIENTO_CIs"`

  **Must NOT do**:
  - Do NOT lose the edit functionality
  - Same guardrails as Task 3

  **Recommended Agent Profile**:
  - **Category**: `unspecified-high`
  - **Skills**: `[]`

  **Parallelization**:
  - **Can Run In Parallel**: YES (with Tasks 10, 11)
  - **Parallel Group**: Wave 3
  - **Blocks**: None
  - **Blocked By**: Task 2

  **References**:
  - `Reportes/ReporteSeguimientosElementoConfiguracion.aspx` + `.cs` — Current EDITAR button pattern
  - `Personal.aspx:299-358` — `seleccionarPersonal()` function pattern

  **Acceptance Criteria**:
  - [ ] Same structural criteria as Task 3
  - [ ] EDITAR button works client-side (populates form or navigates)
  - [ ] `Session["Imprimir"]` preserved

  **QA Scenarios**:
  ```
  Scenario: EDITAR button populates form
    Tool: Playwright
    Steps:
      1. Navigate to report
      2. Click EDITAR button on a row
      3. Assert: Form fields populated or new page/window opened with data
    Expected Result: Edit action works without server-side postback
    Evidence: .sisyphus/evidence/task-12-editar-button.png
  ```

  **Commit**: YES — grouped with Wave 3

### Wave 4 — Complex Report

- [ ] 13. **Migrate ReporteElementosConfiguracion (20 cols, most complex)**

  **What to do**:
  - This is the most complex report: 20 columns, 14 checkbox+dropdown filter pairs, cascading Sede→Local→Area
  - Apply standard migration pattern — this is the final and largest migration
  - Remove ALL 14 checkbox+dropdown pairs and cascading logic
  - Replace with unified search bar searching across ALL text columns
  - Table needs `min-width: 1800px` (20 columns) for proper horizontal scrolling
  - Preserve `Session["Imprimir"]` with identifier `"REPORTE_ELEMENTOS_CONFIGURACION"`
  - Pay special attention to columns that use inline color HTML (`<font color=blue>`, `<font color=red>`) — convert to CSS classes (`.text-primary`, `.text-danger`)

  **Must NOT do**:
  - Do NOT reduce column count — all 20 columns must be rendered
  - Same guardrails as Task 3

  **Recommended Agent Profile**:
  - **Category**: `unspecified-high`
  - **Skills**: `[]`

  **Parallelization**:
  - **Can Run In Parallel**: NO (sequential — validate before moving to final wave)
  - **Parallel Group**: Wave 4 (solo)
  - **Blocks**: Final Verification Wave
  - **Blocked By**: Task 2, Task 13 depends on all previous tasks' learnings

  **References**:
  - `Reportes/ReporteElementosConfiguracion.aspx` + `.cs` — Full files (largest report)
  - `Personal.aspx:377-436` — form-card pattern
  - All previous migrated reports — accumulated patterns

  **Acceptance Criteria**:
  - [ ] Same structural criteria as Task 3
  - [ ] All 20 columns rendered
  - [ ] Inline color HTML converted to CSS classes
  - [ ] Horizontal scrolling works for wide table
  - [ ] `Session["Imprimir"]` preserved

  **QA Scenarios**:
  ```
  Scenario: All 20 columns render and search works
    Tool: Playwright
    Steps:
      1. Navigate to report
      2. Assert: Table has 20 columns (count th elements in thead)
      3. Scroll horizontally to verify all columns visible
      4. Test search filtering across multiple columns
      5. Test pagination
      6. Test Crystal Reports print button
      7. Check browser_console_messages
    Expected Result: All 20 columns functional, no errors
    Evidence: .sisyphus/evidence/task-13-full-verify.png

  Scenario: Color-coded columns use CSS classes
    Tool: Bash (grep)
    Preconditions: ASPX file migrated
    Steps:
      1. grep -c '<font color=' Reportes/ReporteElementosConfiguracion.aspx
    Expected Result: Zero matches (all color moved to CSS classes)
    Evidence: .sisyphus/evidence/task-13-no-inline-font.txt
  ```

  **Commit**: YES
  - Message: `feat(reportes): migrate ReporteElementosConfiguracion to client-side pattern (20 cols)`
  - Files: `Reportes/ReporteElementosConfiguracion.aspx`, `.cs`

---

## Final Verification Wave (MANDATORY — after ALL implementation tasks)

> 4 review agents run in PARALLEL. ALL must APPROVE. Get user's explicit "okay" before completing.

- [ ] F1. **Plan Compliance Audit** — `oracle`
  Read the plan end-to-end. For each "Must Have": verify implementation exists. For each "Must NOT Have": search codebase for forbidden patterns. Check evidence files exist in `.sisyphus/evidence/`.
  Output: `Must Have [N/N] | Must NOT Have [N/N] | Tasks [N/N] | VERDICT: APPROVE/REJECT`

- [ ] F2. **Code Quality Review** — `unspecified-high`
  Grep all 11 migrated files for: `<asp:Table`, `.navbar-modern` inline, `StringBuilder`, `$(document).ready`. Verify `JavaScriptSerializer` import, `ClientIDMode="Static"`, `global-styles.css` ref, `utils.js` ref.
  Output: `Files [N clean/N issues] | VERDICT: APPROVE/REJECT`

- [ ] F3. **Runtime QA Verification** — `unspecified-high` (+ `playwright` skill)
  Navigate each migrated report page. Verify: table renders rows, search filters, pagination works, Crystal Reports popup opens (where applicable), console has no JS errors. Capture screenshots to `.sisyphus/evidence/final-qa/`.
  Output: `Reports [N/N pass] | VERDICT: APPROVE/REJECT`

- [ ] F4. **Scope Fidelity Check** — `deep`
  For each task: read "What to do", read actual diff. Verify 1:1. Check "Must NOT do" compliance. Flag unaccounted changes.
  Output: `Tasks [N/N compliant] | Contamination [CLEAN/N issues] | VERDICT: APPROVE/REJECT`

---

## Commit Strategy

- **Wave 1**: `feat(reportes): foundation - shared grid module + pilot reports` - src/js/grid-utils.js, Reportes/ReporteDatosIncorrectosCI.*, Reportes/ReporteDatosCorrectosCI.*
- **Wave 2**: `feat(reportes): migrate 5 simple-medium reports to client-side pattern` - 5 report files
- **Wave 3**: `feat(reportes): migrate 3 medium-complex reports to client-side pattern` - 3 report files
- **Wave 4**: `feat(reportes): migrate ReporteElementosConfiguracion (complex, 20 cols)` - 1 report
- **FINAL**: `chore(reportes): final verification and cleanup` - cleanup only

---

## Success Criteria

### Verification Commands
```powershell
# Zero asp:Table in migrated reports (excluding excluded files)
Select-String -Path "Reportes\ReporteDatos*.aspx","Reportes\ReporteCIsSeguidos.aspx","Reportes\Reporte_CIS*.aspx","Reportes\Reporte_De_CIS*.aspx","Reportes\ReporteComponentesAsignados.aspx","Reportes\ReporteCIsInformacion*.aspx","Reportes\ReporteRelaciones*.aspx","Reportes\ReporteLicencias*.aspx","Reportes\ReporteSeguimientos*.aspx","Reportes\ReporteElementos*.aspx" -Pattern "<asp:Table" | Should -BeNullOrEmpty

# Zero duplicated navbar CSS in migrated reports
Select-String -Path "Reportes\*.aspx" -Pattern "\.navbar-modern" -Exclude "Default.aspx","Default2.aspx","Reporte.aspx" | Should -BeNullOrEmpty

# All migrated reports reference global-styles.css
Select-String -Path "Reportes\*.aspx" -Pattern "global-styles.css" -Exclude "Default.aspx","Default2.aspx","Reporte.aspx" | Should -HaveCount 11

# All migrated reports reference utils.js
Select-String -Path "Reportes\*.aspx" -Pattern "src/js/utils.js" -Exclude "Default.aspx","Default2.aspx","Reporte.aspx" | Should -HaveCount 11

# All migrated code-behinds use JavaScriptSerializer
Select-String -Path "Reportes\*.aspx.cs" -Pattern "JavaScriptSerializer" -Exclude "Default.aspx.cs","Default2.aspx.cs","Reporte.aspx.cs" | Should -HaveCount 11
```

### Final Checklist
- [ ] All "Must Have" present
- [ ] All "Must NOT Have" absent
- [ ] 11 reportes renderizan datos correctamente
- [ ] Crystal Reports printing funciona en 10/11 reportes
- [ ] Búsqueda y paginación funcionan en todos
- [ ] Cero errores de consola JS
