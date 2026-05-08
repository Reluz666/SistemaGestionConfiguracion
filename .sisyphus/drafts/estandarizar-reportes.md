# Draft: Estandarizar Vistas de Reportes al Estándar de Personal

## Requerimiento (del usuario)
Aplicar los cambios hechos como estándar en Personal.aspx a todas las vistas de Reportes:
- Retirar comboboxes (checkbox + dropdown pairs de filtro)
- Agregar paginación a tablas
- Unificar el estilo visual

## Hallazgos - Estado Actual de Personal.aspx (EL ESTÁNDAR)

### Patrones implementados en Personal:
1. **Layout**: `form-card` con Bootstrap grid (row/col), card-header + card-body
2. **Tabla**: HTML `<table>` puro, renderizado client-side desde JSON en `datosJson` HiddenField
3. **Búsqueda**: input text con filtrado en tiempo real (`onkeyup`)
4. **Paginación**: JS puro con `pagination-wrapper`, navegación Anterior/Siguiente, numeración
5. **CSS**: Referencia `CssJs/global-styles.css` (NO estilos navbar inline duplicados)
6. **JS**: Referencia `src/js/utils.js` (htmlEncode, Confirmar, etc.) - NO funciones duplicadas
7. **Code-behind**: `JavaScriptSerializer` + anonymous objects (NO StringBuilder manual)
8. **Controles**: `ClientIDMode="Static"` en campos clave
9. **Inicialización**: `window.addEventListener('load', ...)` nativo (NO jQuery)
10. **Font sizes**: 0.7-0.8rem tablas, 0.9-0.95rem formularios

### Reportes actuales (14 vistas) - BRECHAS detectadas:
1. ❌ Estilos navbar duplicados inline en cada archivo (~80 líneas CSS repetidas)
2. ❌ Sin referencia a `CssJs/global-styles.css`
3. ❌ Sin referencia a `src/js/utils.js`
4. ❌ Funciones JS duplicadas (`MostrarMensaje()`, `Confirmar()`)
5. ❌ Tabla renderizada server-side con `asp:Table` (no client-side JSON)
6. ❌ Sin paginación
7. ❌ Sin barra de búsqueda (filtro por checkbox+dropdown pair)
8. ❌ Layout con `<table>` anidado (no Bootstrap grid)
9. ❌ Sin `form-card`
10. ❌ Checkbox + DropDown pair para filtrar (patrón complejo: checkbox habilita dropdown)

### Archivos de Reportes (14 total):
- Default.aspx, Default2.aspx, Reporte.aspx (reportes genéricos con Crystal Reports)
- ReporteElementosConfiguracion.aspx
- ReporteSeguimientosElementoConfiguracion.aspx
- ReporteLicenciasElementoConfiguracion.aspx
- ReporteRelacionesElementosConfiguracion.aspx
- ReporteCIsSeguidos.aspx
- ReporteComponentesAsignados.aspx
- ReporteDatosCorrectosCI.aspx
- ReporteDatosIncorrectosCI.aspx
- ReporteCIsInformacionContenidaEnCMDB.aspx
- Reporte_De_CIS_Relativo_A_Servicios.aspx
- Reporte_CIS_Relacionados_Con_Otros_CIS.aspx

## Tech Stack
- ASP.NET Web Forms (.NET 4.8)
- Bootstrap 5.3.3 (CDN)
- SQL Server (stored procedures: `pr_Reporte*`)
- jQuery 3.7.1 (CDN)
- Crystal Reports para impresión
- Lenguaje: C# code-behind, español en UI

## Scope Boundaries (CONFIRMADO)
- INCLUDE: 11 reportes con tablas de datos (lista abajo)
- EXCLUDE: Vistas principales (ElementosConfiguracion.aspx, Licencias, etc.)
- EXCLUDE: Archivos Crystal Reports (.rpt)
- EXCLUDE: Default.aspx, Default2.aspx, Reporte.aspx (visores Crystal Reports)

## Decisiones Confirmadas
1. **Filtro**: Barra de búsqueda unificada (como Personal), reemplazar checkbox+dropdown
2. **Alcance**: Solo los 11 reportes con tablas (no los Crystal Report viewers)
3. **Estrategia**: Migración completa client-side (JSON + JS rendering + search + pagination)
4. **Testing**: QA manual (sin tests automatizados)
5. **Impresión**: Conservar Crystal Reports (botón imprimir/exportar vía Session["Imprimir"])

## 11 Reportes a Migrar:
1. ReporteElementosConfiguracion.aspx
2. ReporteSeguimientosElementoConfiguracion.aspx
3. ReporteLicenciasElementoConfiguracion.aspx
4. ReporteRelacionesElementosConfiguracion.aspx
5. ReporteCIsSeguidos.aspx
6. ReporteComponentesAsignados.aspx
7. ReporteDatosCorrectosCI.aspx
8. ReporteDatosIncorrectosCI.aspx
9. ReporteCIsInformacionContenidaEnCMDB.aspx
10. Reporte_De_CIS_Relativo_A_Servicios.aspx
11. Reporte_CIS_Relacionados_Con_Otros_CIS.aspx
