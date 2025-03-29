// This is the JavaScript code you can add to your existing page

document.addEventListener("DOMContentLoaded", () => {
  // Get the table and add search inputs
  const routesTable = document.querySelector(".table");
  const tableBody = routesTable.querySelector("tbody");
  const tableRows = Array.from(tableBody.querySelectorAll("tr"));

  // Create search container
  const searchContainer = document.createElement("div");
  searchContainer.className = "search-container mb-4 p-3 border rounded bg-light";
  searchContainer.innerHTML = `
    <h5 class="mb-3">Search Routes</h5>
    <div class="row g-3">
      <div class="col-md-4">
        <label for="routeIdSearch" class="form-label">Search by Route ID</label>
        <div class="input-group">
          <span class="input-group-text"><i class="fas fa-search"></i></span>
          <input type="text" class="form-control" id="routeIdSearch" placeholder="Enter Route ID">
        </div>
      </div>
      
      <div class="col-md-4">
        <label for="departureStationSearch" class="form-label">Departure Station</label>
        <select class="form-select" id="departureStationSearch">
          <option value="">All Stations</option>
          ${getUniqueStations("departureStation")}
        </select>
      </div>
      
      <div class="col-md-4">
        <label for="arrivalStationSearch" class="form-label">Arrival Station</label>
        <select class="form-select" id="arrivalStationSearch">
          <option value="">All Stations</option>
          ${getUniqueStations("arrivalStation")}
        </select>
      </div>
    </div>
    
    <div class="d-flex justify-content-end mt-3">
      <button class="btn btn-outline-secondary" id="resetFilters">Reset Filters</button>
    </div>
  `;

  // Insert search container before the table
  routesTable.parentNode.insertBefore(searchContainer, routesTable);

  // Get unique stations for dropdowns
  function getUniqueStations(stationType) {
    const stationIndex = stationType === "departureStation" ? 1 : 2; // Column index
    const stations = new Set();

    tableRows.forEach((row) => {
      const station = row.cells[stationIndex].textContent.trim();
      stations.add(station);
    });

    return Array.from(stations)
      .sort()
      .map((station) => `<option value="${station}">${station}</option>`)
      .join("");
  }

  // Add event listeners for search inputs
  const routeIdSearch = document.getElementById("routeIdSearch");
  const departureStationSearch = document.getElementById("departureStationSearch");
  const arrivalStationSearch = document.getElementById("arrivalStationSearch");
  const resetFiltersBtn = document.getElementById("resetFilters");

  // Function to filter table rows
  function filterTable() {
    const routeIdValue = routeIdSearch.value.toLowerCase();
    const departureStationValue = departureStationSearch.value;
    const arrivalStationValue = arrivalStationSearch.value;

    tableRows.forEach((row) => {
      const routeId = row.cells[0].textContent.toLowerCase();
      const departureStation = row.cells[1].textContent.trim();
      const arrivalStation = row.cells[2].textContent.trim();

      const matchesRouteId = !routeIdValue || routeId.includes(routeIdValue);
      const matchesDepartureStation = !departureStationValue || departureStation === departureStationValue;
      const matchesArrivalStation = !arrivalStationValue || arrivalStation === arrivalStationValue;

      // Show row if it matches all active filters
      if (matchesRouteId && matchesDepartureStation && matchesArrivalStation) {
        row.style.display = "";
      } else {
        row.style.display = "none";
      }
    });

    // Show "no results" message if all rows are hidden
    const visibleRows = tableRows.filter((row) => row.style.display !== "none");

    // Remove existing no results message if it exists
    const existingNoResults = document.getElementById("noResultsMessage");
    if (existingNoResults) {
      existingNoResults.remove();
    }

    if (visibleRows.length === 0) {
      const noResultsRow = document.createElement("tr");
      noResultsRow.id = "noResultsMessage";
      noResultsRow.innerHTML = `<td colspan="8" class="text-center py-3 text-muted">No routes found matching your search criteria</td>`;
      tableBody.appendChild(noResultsRow);
    }
  }

  // Add event listeners
  routeIdSearch.addEventListener("input", filterTable);
  departureStationSearch.addEventListener("change", filterTable);
  arrivalStationSearch.addEventListener("change", filterTable);

  // Reset filters
  resetFiltersBtn.addEventListener("click", () => {
    routeIdSearch.value = "";
    departureStationSearch.value = "";
    arrivalStationSearch.value = "";
    filterTable();;
  });
});




