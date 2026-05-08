# Draft: Propagate Modern Table Style to All Views

## Requirements (confirmed)
- [Propagate changes]: Apply the modern table style from ElementosConfiguracion.aspx to all views still using old pattern
- [New pattern features]: Remove checkboxes/inputs from tables, modern table design, universal search input, pagination
- [Guide exists]: GUIA_ESTILO_TABLAS.md documents exact pattern - must follow it

## Technical Context
- **Framework**: ASP.NET Web Forms (.aspx + .aspx.cs code-behind)
- **CSS**: Bootstrap 5.3.3 CDN + Bootstrap Icons CDN + CssJs/global-styles.css
- **JS**: jQuery 3.7.1 CDN, Bootstrap JS CDN, custom JS for client-side rendering
- **Data pattern**: Code-behind loads data via stored procedure → serializes to JSON → stored in HiddenField → JS renders table
- **Reference implementation**: ElementosConfiguracion.aspx + ElementosConfiguracion.aspx.cs

## Views to Update (from GUIA_ESTILO_TABLAS.md)
1. Area.aspx
2. Local.aspx
3. Personal.aspx
4. CIsAsignarComponenetes.aspx
5. LicenciasElementoConfiguracion.aspx
6. LicenciaElementoConfiguracion.aspx
7. RelacionesElementosConfiguracion.aspx
8. SeguimientosElementoConfiguracion.aspx
9. CIsComponentesAsignados.aspx

## Scope Boundaries
- INCLUDE: Update listed views' HTML structure, CSS, JS, and code-behind to match ElementosConfiguracion pattern
- EXCLUDE: Functional/behavioral changes beyond the UI pattern (keep existing business logic, stored procedures, routing)
- EXCLUDE: Views that already follow the new pattern or don't have tables

## Comprehensive Analysis Results

### Project Type: ASP.NET Web Forms (.aspx + code-behind)

### FULLY MODERNIZED (Gold Standard Pattern - NO changes needed):
| View | BS5 | JSON | Search | Pagination |
|------|-----|------|--------|------------|
| ElementosConfiguracion.aspx | ✓ | ✓ | ✓ | ✓ |
| RelacionesElementosConfiguracion.aspx | ✓ | ✓ | ✓ | ✓ |
| SeguimientosElementosConfiguracion.aspx | ✓ | ✓ | ✓ | ✓ |
| Area.aspx | ✓ | ✓ | ✓ | ✓ |
| Local.aspx | ✓ | ✓ | ✓ | ✓ |
| Personal.aspx | ✓ | ✓ | ✓ | ✓ |
| CIsAsignarComponenetes.aspx | ✓ | ✓ | ✓ | ✓ |
| LicenciasElementoConfiguracion.aspx | ✓ | ✓ | ✓ | ✓ |

### PARTIALLY MODERNIZED (BS5 forms but OLD table pattern - NEED update):
| View | BS5 | OLD Table | Issue |
|------|-----|-----------|-------|
| Cargo.aspx | ✓ | asp:Table | No JSON/Pagination/Search |
| Dependencia.aspx | ✓ | asp:Table | No JSON/Pagination/Search |
| DescripcionElementoConfiguracion.aspx | ✓ | asp:Table | No JSON/Pagination/Search |
| EstadoActualCI.aspx | ✓ | asp:Table | No JSON/Pagination/Search |
| Modelo.aspx | ✓ | asp:Table | No JSON/Pagination/Search |
| ProfecionOcupacion.aspx | ✓ | asp:Table | No JSON/Pagination/Search |
| Sede.aspx | ✓ | asp:Table | No JSON/Pagination/Search |
| TipoComponeneteCI.aspx | ✓ | asp:Table | No JSON/Pagination/Search |
| TipoRelacionElementoConfiguracion.aspx | ✓ | asp:Table | No JSON/Pagination/Search |
| TiposElementoConfiguracion.aspx | ✓ | asp:Table | No JSON/Pagination/Search |
| Usuario.aspx | ✓ | asp:Table | No JSON/Pagination/Search |
| ComponenteCI.aspx | ✓ | asp:Table | No ModernCSS/JSON/Pagination |
| Marca.aspx | ✓ | asp:Table | No ModernCSS/JSON/Pagination |

### SPECIAL CASES (Has JSON but missing pagination):
| View | Note |
|------|------|
| CIsComponentesAsignados.aspx | Has JSON but Pag:False |
| LicenciaElementoConfiguracion.aspx | Has JSON but Pag:False |

### DETAIL/FORM pages (singular, not list views - OUT of scope):
- ElementoConfiguracion.aspx, RelacionElementosConfiguracion.aspx, SeguimientoElementoConfiguracion.aspx

### VENTANAS + REPORTES (popup dialogs and reports - separate concern):
- 11 report files + ~9 Ventanas popups still use old pattern

## Open Questions
- [ ] Scope: Only main entity views (Cargo, Dependencia, Sede, Marca, etc. = 13 views) OR also Ventanas popups and Reportes?
- [ ] Should CIsComponentesAsignados and LicenciaElementoConfiguracion get pagination added?
- [ ] Should test strategy be: tests-after (manual verification), or none?
- [ ] Are there views with unique features that need special handling (e.g., some views have master-detail selection pattern)?
