/**
 * Grid Utilities - Shared module for table rendering, search, and pagination
 * Provides a configurable grid component that can be reused across pages
 */

var GridUtils = (function() {
    'use strict';

    // Stores all registered grid instances
    var grids = {};

    /**
     * Creates and initializes a grid with the given configuration
     * @param {Object} config - Configuration object
     * @param {string} config.tableId - ID of the table element
     * @param {string} config.tbodyId - ID of tbody element
     * @param {string} config.searchInputId - ID of search input element
     * @param {string} config.paginationWrapperId - ID for pagination container
     * @param {string} config.pageInfoId - ID for page info label
     * @param {string} config.counterId - ID for total records counter
     * @param {string} config.dataFieldId - ID of hidden field containing JSON data
     * @param {number} [config.rowsPerPage=10] - Number of rows per page
     * @param {string[]} config.searchFields - Array of field names to search in
     * @param {Function} config.columnRenderer - Callback function that returns HTML string for a single row
     * @param {Function} [config.onRowClick] - Optional callback when a row is clicked
     * @param {Function} [config.onInitialized] - Optional callback after grid is initialized
     */
    function createGrid(config) {
        // Validate required config
        if (!config.tableId || !config.tbodyId || !config.searchInputId ||
            !config.paginationWrapperId || !config.dataFieldId ||
            !config.searchFields || !config.columnRenderer) {
            console.error('GridUtils: Missing required configuration');
            return null;
        }

        // Set defaults
        config.rowsPerPage = config.rowsPerPage || 10;

        // Initialize grid state
        var gridId = config.tableId;
        var state = {
            config: config,
            data: [],
            filteredData: [],
            currentPage: 1,
            rowsPerPage: config.rowsPerPage
        };

        // Store the grid instance
        grids[gridId] = state;

        // Set up event listeners
        setupEventListeners(gridId);

        // Load initial data
        loadData(gridId);

        return state;
    }

    /**
     * Loads data from the hidden field and initializes the grid
     */
    function loadData(gridId) {
        var state = grids[gridId];
        if (!state) return;

        var dataField = document.getElementById(state.config.dataFieldId);
        if (dataField && dataField.value && dataField.value !== '[]') {
            try {
                state.data = JSON.parse(dataField.value);
                state.filteredData = state.data.slice();
                filtrarTabla(gridId);
            } catch (e) {
                console.error('GridUtils: Error parsing JSON - ' + e.message);
            }
        }
    }

    /**
     * Sets up event listeners for search input and other elements
     */
    function setupEventListeners(gridId) {
        var state = grids[gridId];
        if (!state) return;

        var searchInput = document.getElementById(state.config.searchInputId);
        if (searchInput) {
            searchInput.addEventListener('keyup', function() {
                filtrarTabla(gridId);
            });
        }
    }

    /**
     * Filters data based on search text
     */
    function filtrarTabla(gridId) {
        var state = grids[gridId];
        if (!state) return;

        var searchInput = document.getElementById(state.config.searchInputId);
        var searchText = searchInput ? searchInput.value.toLowerCase().trim() : '';

        if (searchText === '') {
            state.filteredData = state.data.slice();
        } else {
            state.filteredData = state.data.filter(function(item) {
                return state.config.searchFields.some(function(field) {
                    var value = item[field] || '';
                    return value.toLowerCase().includes(searchText);
                });
            });
        }

        state.currentPage = 1;
        renderizarTabla(gridId);
        generarPaginacion(gridId, Math.ceil(state.filteredData.length / state.rowsPerPage));

        // Update counter if exists
        if (state.config.counterId) {
            var counter = document.getElementById(state.config.counterId);
            if (counter) {
                counter.textContent = 'Total: ' + state.filteredData.length + ' elementos';
            }
        }
    }

    /**
     * Renders the current page of data
     */
    function renderizarTabla(gridId) {
        var state = grids[gridId];
        if (!state) return;

        var tbody = document.getElementById(state.config.tbodyId);
        if (!tbody) return;

        var totalRows = state.filteredData.length;
        var totalPages = Math.ceil(totalRows / state.rowsPerPage);
        var start = (state.currentPage - 1) * state.rowsPerPage;
        var end = start + state.rowsPerPage;

        tbody.innerHTML = '';

        if (totalRows === 0) {
            var tr = document.createElement('tr');
            var cellCount = document.querySelectorAll('#' + state.config.tableId + ' thead th').length || 1;
            tr.innerHTML = '<td colspan="' + cellCount + '" class="text-center text-muted py-4">No hay datos disponibles</td>';
            tbody.appendChild(tr);
            var pageInfo = document.getElementById(state.config.pageInfoId);
            if (pageInfo) pageInfo.textContent = '';
            return;
        }

        for (var i = start; i < end && i < totalRows; i++) {
            var item = state.filteredData[i];
            var tr = document.createElement('tr');

            // Set row HTML using the column renderer callback
            tr.innerHTML = state.config.columnRenderer(item);

            // Add row click handler if configured
            if (state.config.onRowClick) {
                (function(item, tr) {
                    tr.style.cursor = 'pointer';
                    tr.addEventListener('click', function() {
                        state.config.onRowClick(item);
                    });
                })(item, tr);
            }

            tbody.appendChild(tr);
        }

        // Update page info if exists
        var pageInfo = document.getElementById(state.config.pageInfoId);
        if (pageInfo) {
            pageInfo.textContent = 'Pagina ' + state.currentPage + ' de ' + totalPages + ' (Total: ' + totalRows + ' registros)';
        }
    }

    /**
     * Generates pagination controls
     */
    function generarPaginacion(gridId, totalPages) {
        var state = grids[gridId];
        if (!state) return;

        var wrapper = document.getElementById(state.config.paginationWrapperId);
        if (!wrapper) return;

        wrapper.innerHTML = '';

        if (totalPages <= 1) {
            return;
        }

        var sb = '<nav><ul class="pagination mb-0">';

        if (state.currentPage > 1) {
            sb += '<li class="page-item"><a class="page-link" href="javascript:GridUtils.paginate(\'' + gridId + '\', ' + (state.currentPage - 1) + ')">Anterior</a></li>';
        } else {
            sb += '<li class="page-item disabled"><span class="page-link">Anterior</span></li>';
        }

        var inicio = Math.max(1, state.currentPage - 2);
        var fin = Math.min(totalPages, state.currentPage + 2);

        if (inicio > 1) {
            sb += '<li class="page-item"><a class="page-link" href="javascript:GridUtils.paginate(\'' + gridId + '\', 1)">1</a></li>';
            if (inicio > 2) sb += '<li class="page-item disabled"><span class="page-link">...</span></li>';
        }

        for (var i = inicio; i <= fin; i++) {
            if (i === state.currentPage) {
                sb += '<li class="page-item active"><span class="page-link">' + i + '</span></li>';
            } else {
                sb += '<li class="page-item"><a class="page-link" href="javascript:GridUtils.paginate(\'' + gridId + '\', ' + i + ')">' + i + '</a></li>';
            }
        }

        if (fin < totalPages) {
            if (fin < totalPages - 1) sb += '<li class="page-item disabled"><span class="page-link">...</span></li>';
            sb += '<li class="page-item"><a class="page-link" href="javascript:GridUtils.paginate(\'' + gridId + '\', ' + totalPages + ')">' + totalPages + '</a></li>';
        }

        if (state.currentPage < totalPages) {
            sb += '<li class="page-item"><a class="page-link" href="javascript:GridUtils.paginate(\'' + gridId + '\', ' + (state.currentPage + 1) + ')">Siguiente</a></li>';
        } else {
            sb += '<li class="page-item disabled"><span class="page-link">Siguiente</span></li>';
        }

        sb += '</ul></nav>';
        wrapper.innerHTML = sb;
    }

    /**
     * Navigates to a specific page
     */
    function paginate(gridId, pagina) {
        var state = grids[gridId];
        if (!state) return;

        var totalPages = Math.ceil(state.filteredData.length / state.rowsPerPage);
        if (pagina < 1 || pagina > totalPages) return;

        state.currentPage = pagina;
        renderizarTabla(gridId);
        generarPaginacion(gridId, totalPages);

        // Scroll to table if table-wrapper exists
        var tableWrapper = document.querySelector('.table-wrapper');
        if (tableWrapper) {
            tableWrapper.scrollIntoView({ behavior: 'smooth' });
        }
    }

    /**
     * Refreshes the grid data (reloads from hidden field)
     */
    function refresh(gridId) {
        var state = grids[gridId];
        if (!state) return;

        state.data = [];
        state.filteredData = [];
        state.currentPage = 1;
        loadData(gridId);
    }

    /**
     * Gets the current state of a grid
     */
    function getState(gridId) {
        return grids[gridId] || null;
    }

    // Public API
    return {
        createGrid: createGrid,
        paginate: paginate,
        refresh: refresh,
        getState: getState
    };
})();
