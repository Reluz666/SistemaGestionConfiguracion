# Guía de Estilo - Tabla con Paginación y Búsqueda

## Resumen de Componentes Visuales

Este documento describe los estilos y funcionalidad JavaScript que deben replicarse en todas las vistas para mantener consistencia.

---

## 1. CSS Requerido

### Contenedor Wrapper
```css
.table-wrapper {
    background: #fff;
    border-radius: 16px;
    box-shadow: 0 4px 25px rgba(0,0,0,0.08);
    padding: 1.5rem;
    border: 1px solid rgba(0,0,0,0.05);
}
```

### Encabezado de Tabla (thead)
```css
.table-modern thead th {
    background: linear-gradient(135deg, #1a1a2e 0%, #16213e 100%);
    color: #fff;
    font-weight: 600;
    font-size: 0.8rem;
    text-transform: uppercase;
    letter-spacing: 0.5px;
    padding: 0.75rem 0.5rem !important;
    border: none !important;
    white-space: nowrap;
}
```

### Celdas del Cuerpo (tbody td)
```css
.table-modern tbody td {
    padding: 0.6rem 0.5rem !important;
    border-bottom: 1px solid #f1f1f1;
    vertical-align: middle;
    font-size: 0.85rem;
    color: #2d3436;
}
.table-modern tbody tr:hover td {
    background: rgba(233,69,96,0.04);
}
.table-modern tbody tr:last-child td {
    border-bottom: none;
}
```

### Estados de Color
```css
.estado-activo { color: #198754; font-weight: 600; }
.estado-inactivo { color: #dc3545; font-weight: 600; }
```

### Input de Búsqueda
```css
.search-input {
    border: 2px solid #e9ecef;
    border-radius: 10px;
    padding: 0.6rem 1rem;
    font-size: 0.95rem;
}
.search-input:focus {
    border-color: #e94560;
    box-shadow: 0 0 0 4px rgba(233,69,96,0.1);
    outline: none;
}
```

### Botones de Acción
```css
.btn-accion {
    padding: 0.25rem 0.5rem;
    font-size: 0.75rem;
    border-radius: 6px;
    text-decoration: none;
}
```

### Paginación
```css
.pagination-wrapper {
    display: flex;
    justify-content: center;
    margin-top: 1.5rem;
}
.page-info {
    text-align: center;
    margin-top: 1rem;
    color: #6c757d;
    font-size: 0.9rem;
}
```

---

## 2. HTML Estructura

```html
<div class="table-wrapper">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h4><i class="bi bi-collection me-2"></i>TITULO</h4>
        <a href="Nuevo.aspx" class="btn btn-success btn-modern">
            <i class="bi bi-plus-circle me-1"></i>Nuevo
        </a>
    </div>

    <div class="row mb-3">
        <div class="col-md-6">
            <div class="input-group">
                <span class="input-group-text bg-white border-end-0">
                    <i class="bi bi-search text-muted"></i>
                </span>
                <input type="text" id="txtBusqueda" class="form-control border-start-0 search-input"
                    placeholder="Buscar en todos los campos..."
                    onkeyup="filtrarTabla(this.value)" />
            </div>
        </div>
        <div class="col-md-6 text-end">
            <span id="lblTotal" class="text-muted small"></span>
        </div>
    </div>

    <div class="table-responsive">
        <table id="tblDatos" class="table table-modern table-hover">
            <thead>
                <tr>
                    <th>Columna 1</th>
                    <th>Columna 2</th>
                    <!-- ... -->
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody id="tbodyDatos">
            </tbody>
        </table>
    </div>

    <div class="pagination-wrapper" id="pagination"></div>
    <div class="page-info" id="pageInfo"></div>
</div>

<!-- Hidden Fields para datos -->
<asp:HiddenField ID="__mensaje" runat="server" />
<asp:HiddenField ID="__pagina" runat="server" />
<asp:HiddenField ID="paginaActual" runat="server" Value="1" />
<asp:HiddenField ID="datosJson" runat="server" Value="" />
```

---

## 3. JavaScript Funcional

### Variables Globales
```javascript
var datosCompletos = [];
var paginaActual = 1;
var tamanioPagina = 10;
```

### Función Filtrar
```javascript
function filtrarTabla(texto) {
    texto = texto.toUpperCase();
    var datosFiltrados = [];

    for (var i = 0; i < datosCompletos.length; i++) {
        var row = datosCompletos[i];
        var textoFila = Object.values(row).join(' ').toUpperCase();
        if (textoFila.indexOf(texto) > -1) {
            datosFiltrados.push(row);
        }
    }

    paginaActual = 1;
    renderizarTabla(datosFiltrados);
    var totalPaginas = Math.ceil(datosFiltrados.length / tamanioPagina);
    generarPaginacion(totalPaginas, paginaActual);
    document.getElementById('lblTotal').textContent = 'Total: ' + datosFiltrados.length + ' elementos';
}
```

### Función Paginar
```javascript
function Paginar(pagina) {
    paginaActual = pagina;
    var inicio = (pagina - 1) * tamanioPagina;
    var fin = inicio + tamanioPagina;
    var datosPagina = datosCompletos.slice(inicio, fin);

    renderizarTabla(datosPagina);

    var totalPaginas = Math.ceil(datosCompletos.length / tamanioPagina);
    generarPaginacion(totalPaginas, pagina);
    document.getElementById('pageInfo').textContent = 'Pagina ' + pagina + ' de ' + totalPaginas + ' (Total: ' + datosCompletos.length + ' registros)';
    document.querySelector('.table-wrapper').scrollIntoView({ behavior: 'smooth' });
}
```

### Renderizar Tabla
```javascript
function renderizarTabla(datos) {
    var tbody = document.getElementById('tbodyDatos');
    var sb = '';

    if (datos.length === 0) {
        tbody.innerHTML = '<tr><td colspan="NUM_COLUMNAS" class="text-center text-muted py-4">No se encontraron elementos</td></tr>';
        return;
    }

    for (var i = 0; i < datos.length; i++) {
        var row = datos[i];
        sb += '<tr>';
        sb += '<td>' + htmlEncode(row.CAMPO1) + '</td>';
        sb += '<td>' + htmlEncode(row.CAMPO2) + '</td>';
        // ... agregar todas las columnas
        sb += '<td class="text-center">';
        sb += '<a href="Editar.aspx?ID=' + row.ID + '" class="btn btn-primary btn-sm btn-accion me-1">Editar</a>';
        sb += '<a href="Eliminar.aspx?ID=' + row.ID + '" class="btn btn-danger btn-sm btn-accion" onclick="return confirm(\'¿Esta seguro?\');">Eliminar</a>';
        sb += '</td>';
        sb += '</tr>';
    }

    tbody.innerHTML = sb;
}
```

### Función HtmlEncode
```javascript
function htmlEncode(str) {
    if (!str) return '';
    return String(str).replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/"/g, '&quot;');
}
```

### Generar Paginación
```javascript
function generarPaginacion(totalPaginas, pagina) {
    var pagination = document.getElementById('pagination');
    if (!pagination) return;
    if (totalPaginas <= 1) {
        pagination.innerHTML = '';
        return;
    }

    var sb = '<nav><ul class="pagination mb-0">';
    // Anterior
    if (pagina > 1) {
        sb += '<li class="page-item"><a class="page-link" href="javascript:Paginar(' + (pagina - 1) + ')">Anterior</a></li>';
    } else {
        sb += '<li class="page-item disabled"><span class="page-link">Anterior</span></li>';
    }

    // Numeros de pagina (rango de 2 antes y despues)
    var inicio = Math.max(1, pagina - 2);
    var fin = Math.min(totalPaginas, pagina + 2);

    if (inicio > 1) {
        sb += '<li class="page-item"><a class="page-link" href="javascript:Paginar(1)">1</a></li>';
        if (inicio > 2) sb += '<li class="page-item disabled"><span class="page-link">...</span></li>';
    }

    for (var i = inicio; i <= fin; i++) {
        if (i === pagina) {
            sb += '<li class="page-item active"><span class="page-link">' + i + '</span></li>';
        } else {
            sb += '<li class="page-item"><a class="page-link" href="javascript:Paginar(' + i + ')">' + i + '</a></li>';
        }
    }

    if (fin < totalPaginas) {
        if (fin < totalPaginas - 1) sb += '<li class="page-item disabled"><span class="page-link">...</span></li>';
        sb += '<li class="page-item"><a class="page-link" href="javascript:Paginar(' + totalPaginas + ')">' + totalPaginas + '</a></li>';
    }

    // Siguiente
    if (pagina < totalPaginas) {
        sb += '<li class="page-item"><a class="page-link" href="javascript:Paginar(' + (pagina + 1) + ')">Siguiente</a></li>';
    } else {
        sb += '<li class="page-item disabled"><span class="page-link">Siguiente</span></li>';
    }

    sb += '</ul></nav>';
    pagination.innerHTML = sb;
}
```

### Inicialización
```javascript
function inicializarDatos() {
    var datosJsonField = document.getElementById('datosJson');
    if (datosJsonField && datosJsonField.value) {
        try {
            datosCompletos = JSON.parse(datosJsonField.value);
            Paginar(1);
        } catch (e) {
            console.error('Error parsing JSON:', e);
        }
    }
}

if (window.addEventListener) {
    window.addEventListener('load', inicializarDatos, false);
} else if (window.attachEvent) {
    window.attachEvent('onload', inicializarDatos);
}
```

---

## 4. Código C# - Generar JSON

En el code-behind, usar un StringBuilder para construir el JSON:

```csharp
System.Text.StringBuilder sb = new System.Text.StringBuilder();
sb.Append("[");
for (int i = 0; i < dt.Rows.Count; i++)
{
    if (i > 0) sb.Append(",");
    sb.Append("{");
    sb.Append("\"ID\":\"" + JsonEncode(dt.Rows[i]["ID"].ToString()) + "\",");
    sb.Append("\"NOMBRE\":\"" + JsonEncode(dt.Rows[i]["NOMBRE"].ToString()) + "\",");
    sb.Append("\"CAMPO2\":\"" + JsonEncode(dt.Rows[i]["CAMPO 2"].ToString()) + "\"");
    sb.Append("}");
}
sb.Append("]");
datosJson.Value = sb.ToString();

private string JsonEncode(string str)
{
    if (string.IsNullOrEmpty(str)) return "";
    return str.Replace("\\", "\\\\")
               .Replace("\"", "\\\"")
               .Replace("\n", "\\n")
               .Replace("\r", "\\r")
               .Replace("\t", "\\t");
}
```

---

## 5. Archivos CDN Requeridos

```html
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet" />
<link href="CssJs/global-styles.css" rel="stylesheet" />

<script type="text/javascript" src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
```

---

## 6. Estilos Adicionales (global-styles.css)

```css
.btn-modern {
    padding: 0.6rem 1.5rem;
    border-radius: 10px;
    font-weight: 600;
    font-size: 0.95rem;
    transition: all 0.3s ease;
    border: none;
    text-decoration: none;
    display: inline-block;
}
.btn-modern:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 15px rgba(0,0,0,0.2);
}
.btn-success { background: #198754; color: #fff; }
.btn-primary { background: #0d6efd; color: #fff; }
.btn-danger { background: #dc3545; color: #fff; }

@media (max-width: 991px) {
    .table-wrapper { padding: 1rem; }
}
@media (max-width: 576px) {
    .btn-modern { width: 100%; margin-bottom: 0.5rem; }
}
```

---

## Lista de Vistas a Actualizar

1. Area.aspx
2. Local.aspx
3. Personal.aspx
4. CIsAsignarComponenetes.aspx
5. LicenciasElementoConfiguracion.aspx
6. LicenciaElementoConfiguracion.aspx
7. RelacionesElementosConfiguracion.aspx
8. SeguimientosElementoConfiguracion.aspx
9. CIsComponentesAsignados.aspx