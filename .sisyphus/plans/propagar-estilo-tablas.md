# Propagate Modern Table Style to All Views

## TL;DR

> **Quick Summary**: Migrate 10 legacy entity views, 9 Ventanas popups, and 11 Reportes from old `asp:Table` pattern to the modern JSON-driven Bootstrap 5 table pattern defined in `GUIA_ESTILO_TABLAS.md`, using `ElementosConfiguracion.aspx` as the gold standard.
>
> **Deliverables**:
> - 10 main entity views modernized with search + pagination + client-side JSON rendering
> - 9 Ventanas popups upgraded from Bootstrap 3 to 5 + table modernization
> - 11 Reportes visually refreshed with modern table CSS
> - XSS fix applied to `JsonEncode()` in gold standard
> - Playwright smoke tests for gold standard + all modernized views
>
> **Estimated Effort**: Large (30 files × .aspx + .aspx.cs = 60 files modified)
> **Parallel Execution**: YES — 3 independent workstreams
> **Critical Path**: Wave 1 (Prep + Gold Fix) → Wave 2 (Main Views pilot) → Wave 3 (Main Views batch) | Ventanas BS upgrade → Ventanas table | Reportes visual only

---

## Context

### Original Request
User modernized `ElementosConfiguracion.aspx` — removed checkboxes/inputs from tables, added modern table design, universal search input, and pagination. Now needs to propagate these changes to ALL views with the old pattern.

### Interview Summary
**Key Discussions**:
- **Scope**: ALL views including main entities, Ventanas popups, and Reportes (35+ ASPX files total)
- **Strategy**: Manual verification + Playwright QA scenarios per task
- **Gold Standard**: `ElementosConfiguracion.aspx` — Bootstrap 5.3.3, JSON in HiddenField, client-side JS rendering, search, pagination
- **Pattern Doc**: `GUIA_ESTILO_TABLAS.md` defines exact CSS, HTML, JS, and C# patterns to follow

**Research Findings**:
- Project is ASP.NET Web Forms (.aspx), not MVC/Razor
- 8 views already fully modernized (Area, Local, Personal, ElementosConfiguracion, RelacionesElementoConfiguracion, SeguimientosElementoConfiguracion, LicenciasElementoConfiguracion, CIsAsignarComponenetes)
- 10 main entity views still use old `asp:Table` pattern
- Ventanas use Bootstrap 3.x (need upgrade to 5 BEFORE table modernization)
- Reportes use `asp:Table` with heavy filter systems — full JSON conversion may not be appropriate
- Code-behind pattern: stored procedure → DataTable → StringBuilder JSON → HiddenField
- JS pattern: parse JSON → render table → filter client-side → paginate
- Zero test files exist in the project

### Metis Review
**Identified Gaps** (addressed in plan):
- **XSS vulnerability**: `JsonEncode()` does NOT escape `<` and `>` — fixed in Wave 1 Task P1
- **CSS naming conflict**: `.table-modern` vs `.table-modern-grid` — resolved in Wave 1 Task P2
- **Bootstrap 3→5 on Ventanas**: Must be a separate phase before table modernization
- **ViewState bloat risk**: HiddenField with `runat="server"` stores JSON in ViewState — mitigation by setting `EnableViewState="false"` on `datosJson`
- **Ventanas `window.opener` callbacks**: Must preserve exact function signatures
- **Reportes are fundamentally different**: Apply lighter visual refresh instead of full JSON conversion
- **Crystal Reports pages**: Excluded from scope entirely
- **Form-only pages**: Excluded (ElementoConfiguracion, RelacionElementosConfiguracion, SeguimientoElementoConfiguracion — no list tables)
- **Lista.cs dead code**: Not removed now (do later after verifying zero callers)
- **No shared JS extraction**: Do inline per view first, extract later

---

## Work Objectives

### Core Objective
Replace all `asp:Table` server-rendered data tables with modern client-side JSON-driven tables matching the `ElementosConfiguracion.aspx` gold standard pattern, including universal search and pagination.

### Concrete Deliverables
- **Workstream A (Main Views)**: 10 .aspx + 10 .aspx.cs files modernized
- **Workstream B (Ventanas)**: 9 .aspx + 9 .aspx.cs files — Bootstrap 3→5 upgrade + table modernization
- **Workstream C (Reportes)**: 11 .aspx + 11 .aspx.cs files — visual refresh (BS5 table classes)
- **Gold Standard Fix**: `ElementosConfiguracion.aspx.cs` — `JsonEncode()` XSS fix

### Definition of Done
- [ ] Every modernized view has: `datosJson` HiddenField, `txtBusqueda` search input, `filtrarTabla()`, `renderizarTabla()`, `Paginar()`, `generarPaginacion()`, `htmlEncode()`, `inicializarDatos()`
- [ ] Code-behind: `StringBuilder` JSON building pattern with `JsonEncode()` (with `<` `>` escaping)
- [ ] Zero `asp:Table` in data display sections (verified by `Select-String -Pattern '<asp:Table'`)
- [ ] Bootstrap 5.3.3 CDN present in every view
- [ ] Playwright smoke test passes for each modernized view
- [ ] `Cargo.aspx` pilot passes end-to-end verification before batching remaining 9 views

### Must Have
- Client-side search across all displayed fields (case-insensitive)
- Client-side pagination (10 rows per page) with Anterior/Siguiente + page numbers
- Modern CSS: gradient header, card wrapper, hover effects
- Edit/Delete action buttons rendered in last column
- Empty state message when no data found
- `htmlEncode()` applied to all rendered field values
- `JsonEncode()` properly escaping `<`, `>`, `\`, `"`, `\n`, `\r`, `\t`

### Must NOT Have (Guardrails)
- **DO NOT**: Use `asp:Table` or `asp:GridView` in data display sections
- **DO NOT**: Add server-side pagination or new API endpoints — client-side only
- **DO NOT**: Change form layout, validation, postback behavior, or edit page links
- **DO NOT**: Touch Crystal Reports pages (`Reportes/Default.aspx`, `Reportes/Default2.aspx`, `Reportes/Reporte.aspx`)
- **DO NOT**: Modernize form-only pages (ElementoConfiguracion.aspx, RelacionElementosConfiguracion.aspx, SeguimientoElementoConfiguracion.aspx)
- **DO NOT**: Change Ventanas `window.opener` callback function names or parameter counts
- **DO NOT**: Add DataTables.net, modals, export buttons, or other new features
- **DO NOT**: Extract shared JavaScript — keep inline per view for now
- **DO NOT**: Remove Lista.cs or other helper classes at this time

---

## Verification Strategy (MANDATORY)

> **ZERO HUMAN INTERVENTION** - ALL verification is agent-executed. No exceptions.

### Test Decision
- **Infrastructure exists**: NO (zero test files in project)
- **Automated tests**: None (post-migration smoke tests via Playwright)
- **Framework**: Playwright for browser-based verification
- **Evidence**: Screenshots and console logs saved to `.sisyphus/evidence/`

### QA Policy
Every task MUST include agent-executed QA scenarios.
Evidence saved to `.sisyphus/evidence/task-{N}-{scenario-slug}.{ext}`.

- **Frontend/UI**: Use Playwright — Navigate, wait for table render, interact, assert DOM, screenshot
- **Code verification**: Use PowerShell `Select-String` for pattern checks (no `asp:Table` left, required functions present)
- **JSON validity**: Use `bun` REPL or browser console to parse and validate `datosJson`

---

## Execution Strategy

### Three Independent Workstreams

```
Workstream A: Main Entity Views (10 views)
├── Wave A1: Preparation (fix gold standard + CSS) [blocks A2]
├── Wave A2: Pilot (Cargo.aspx - simplest, 2 columns) [blocks A3]
├── Wave A3: Batch (remaining 9 views, max parallel)
└── Wave A4: Final verification

Workstream B: Ventanas Popups (9 views)
├── Wave B1: Bootstrap 3→5 CSS upgrade ONLY [blocks B2]
├── Wave B2: Replace asp:Table with HTML table + JSON pattern [after B1]
└── Wave B3: Verify window.opener callbacks preserved

Workstream C: Reportes Visual Refresh (11 views)
├── Wave C1: Apply BS5 table classes to existing asp:Table (lighter touch)
└── Wave C2: Verify report filters and export still work

ALL workstreams run in PARALLEL (independent — no shared state between A, B, C)
```

### Critical Path
Wave A1 (Prep) → Wave A2 (Cargo pilot) → Wave A3-A4 (Main batch) | Wave B1 → Wave B2-B3 | Wave C1-C2

---

## TODOs

---

## Final Verification Wave

> 4 review agents run in PARALLEL. ALL must APPROVE.

- [ ] F1. **Plan Compliance Audit** — `oracle`
  Read the plan end-to-end. For each "Must Have": verify implementation exists. For each "Must NOT Have": search codebase for forbidden patterns. Check evidence files exist.

- [ ] F2. **Code Quality Review** — `unspecified-high`
  Verify no `<asp:Table` remains in data display sections. Check all views have BS5 CDN. Verify `JsonEncode()` properly escapes `<` `>`.

- [ ] F3. **Real Manual QA** — `unspecified-high` (+ `playwright` skill)
  Execute Playwright smoke tests for gold standard + all modernized views. Verify search, pagination, edit/delete links, empty state.

- [ ] F4. **Scope Fidelity Check** — `deep`
  Verify 1:1 — everything in spec was built, nothing beyond spec. Check "Must NOT Do" compliance.

---

## Commit Strategy

- **A1**: `fix(seguridad): escapar < y > en JsonEncode para prevenir XSS` — ElementosConfiguracion.aspx.cs
- **A2**: `feat(ui): modernizar tabla Cargo con busqueda y paginacion` — Cargo.aspx, Cargo.aspx.cs
- **A3**: `feat(ui): modernizar tablas de entidades restantes (9 vistas)` — 9 .aspx + 9 .aspx.cs
- **B1**: `refactor(ui): actualizar Ventanas de Bootstrap 3 a Bootstrap 5` — 9 Ventanas/*.aspx
- **B2**: `feat(ui): modernizar tablas en Ventanas con busqueda y paginacion` — 9 Ventanas/*.aspx.cs
- **C1**: `style(ui): aplicar estilos modernos a tablas de Reportes` — 11 Reportes/*.aspx

---

## Success Criteria

### Verification Commands
```powershell
# All modernized views MUST have (returns count 8):
Select-String -Path '<view>.aspx' -Pattern 'datosJson|txtBusqueda|filtrarTabla|Paginar|renderizarTabla|htmlEncode|generarPaginacion|inicializarDatos'

# Zero asp:Table in data sections:
Select-String -Path '<view>.aspx' -Pattern '<asp:Table'  # must return 0 matches

# Bootstrap 5.3.3 present:
Select-String -Path '<view>.aspx' -Pattern 'bootstrap@5\.3\.3'  # must return >=1

# JsonEncode with XSS fix:
Select-String -Path '<view>.aspx.cs' -Pattern 'Replace\("<"'
```

### Final Checklist
- [ ] All "Must Have" present in every modernized view
- [ ] All "Must NOT Have" absent from every modernized view
- [ ] Gold standard XSS fix applied
- [ ] Playwright smoke tests pass for all views
- [ ] Zero `asp:Table` in data display sections
- [ ] Ventanas Bootstrap 3→5 upgrade complete
