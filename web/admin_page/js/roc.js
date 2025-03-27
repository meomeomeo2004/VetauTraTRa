const rocs = [];

async function getROCData() {
    try {
        const response = await fetch('RecordOfChange', {
            method: 'POST', // Use POST method
            headers: {
                'Content-Type': 'application/json'  // Specify JSON content
            }
        });

        if (!response.ok) {
            throw new Error(`Error: ${response.status}`);
        }

        const data = await response.json();

        rocs.length = 0;

        data.forEach(item => {
            rocs.push({
                name: item.name,
                role: item.role,
                change: item.change,
                date: item.date
            });
        });
        filteredRoc = [...rocs];
    } catch (error) {
        console.error("Failed to fetch ROC:", error);
    }
}

// DOM elements
const searchInput = document.getElementById("searchInput")
const typeFilter = document.getElementById("typeFilter")
const filterButton = document.getElementById("filterButton")
const recordsPerPage = document.getElementById("recordsPerPage")
const rocBody = document.getElementById("rocBody")
const prevPageButton = document.getElementById("prevPage")
const nextPageButton = document.getElementById("nextPage")
const pageNumbers = document.getElementById("pageNumbers")
const pageInfo = document.getElementById("pageInfo")
const tableHeaders = document.querySelectorAll("th[data-sort]")

// State variables
let currentPage = 1
let filteredRoc = []
let sortColumn = "date"
let sortDirection = "desc"
let itemsPerPage = Number.parseInt(recordsPerPage.value)

// Initialize the table
initializeTable()

// Event listeners
filterButton.addEventListener("click", applyFilters)
searchInput.addEventListener("keyup", (event) => {
    if (event.key === "Enter") {
        applyFilters()
    }
})
recordsPerPage.addEventListener("change", function () {
    itemsPerPage = Number.parseInt(this.value)
    currentPage = 1
    renderTable()
})
prevPageButton.addEventListener("click", goToPreviousPage)
nextPageButton.addEventListener("click", goToNextPage)
tableHeaders.forEach((header) => {
    header.addEventListener("click", function () {
        const column = this.getAttribute("data-sort")
        if (sortColumn === column) {
            sortDirection = sortDirection === "asc" ? "desc" : "asc"
        } else {
            sortColumn = column
            sortDirection = "asc"
        }
        sortTransactions()
        renderTable()
    })
})

// Functions
async function initializeTable() {
    await getROCData()
    sortTransactions()
    renderTable()
}

function applyFilters() {
    const searchTerm = searchInput.value.toLowerCase()
    const typeValue = typeFilter.value.toLowerCase()

    filteredRoc = rocs.filter((roc) => {
        const matchesSearch =
                roc.name.toLowerCase().includes(searchTerm) ||
                roc.change.toLowerCase().includes(searchTerm) ||
                roc.date.includes(searchTerm) ||
                roc.role.toLowerCase().includes(searchTerm)

        const matchesType = typeValue === "" || roc.role.toLowerCase() === typeValue

        return matchesSearch && matchesType
    })

    currentPage = 1
    sortTransactions()
    renderTable()
}

function sortTransactions() {
    filteredRoc.sort((a, b) => {
        let valueA = a[sortColumn]
        let valueB = b[sortColumn]

        // Handle numeric values
        if (sortColumn === "amount") {
            valueA = Number.parseFloat(valueA)
            valueB = Number.parseFloat(valueB)
        }

        // Handle date values
        if (sortColumn === "date") {
            valueA = new Date(valueA)
            valueB = new Date(valueB)
        }

        if (valueA < valueB) {
            return sortDirection === "asc" ? -1 : 1
        }
        if (valueA > valueB) {
            return sortDirection === "asc" ? 1 : -1
        }
        return 0
    })
}

function renderTable() {
    // Clear the table body
    rocBody.innerHTML = ""

    // Calculate pagination
    const totalPages = Math.ceil(filteredRoc.length / itemsPerPage)
    const startIndex = (currentPage - 1) * itemsPerPage
    const endIndex = Math.min(startIndex + itemsPerPage, filteredRoc.length)

    // Update page info
    pageInfo.textContent = `Page ${currentPage} of ${totalPages || 1}`

    // Enable/disable pagination buttons
    prevPageButton.disabled = currentPage === 1
    nextPageButton.disabled = currentPage === totalPages || totalPages === 0

    // Render page numbers
    renderPageNumbers(totalPages)

    // Render table rows
    if (filteredRoc.length === 0) {
        const emptyRow = document.createElement("tr")
        emptyRow.innerHTML = `<td colspan="5" style="text-align: center;">No Record found</td>`
        rocBody.appendChild(emptyRow)
        return
    }

    for (let i = startIndex; i < endIndex; i++) {
        const roc = filteredRoc[i]
        const row = document.createElement("tr")

        // Format date
        const dateObj = new Date(roc.date)
        const formattedDate = dateObj.toLocaleString("en-US", {
            year: "numeric",
            month: "short",
            day: "numeric",
            hour: "2-digit",
            minute: "2-digit",
            hour12: false
        });

        row.innerHTML = `
            <td>${roc.name}</td>
            <td>${roc.role}</td>
            <td>${formattedDate}</td>
            <td>${roc.change}</td>
        `

        rocBody.appendChild(row)
    }

    // Update sort icons
    updateSortIcons()
}

function renderPageNumbers(totalPages) {
    pageNumbers.innerHTML = ""

    // Limit the number of page buttons shown
    const maxPageButtons = 5
    let startPage = Math.max(1, currentPage - Math.floor(maxPageButtons / 2))
    const endPage = Math.min(totalPages, startPage + maxPageButtons - 1)

    if (endPage - startPage + 1 < maxPageButtons) {
        startPage = Math.max(1, endPage - maxPageButtons + 1)
    }

    // Add first page button if not visible
    if (startPage > 1) {
        addPageButton(1)
        if (startPage > 2) {
            addEllipsis()
        }
    }

    // Add page number buttons
    for (let i = startPage; i <= endPage; i++) {
        addPageButton(i)
    }

    // Add last page button if not visible
    if (endPage < totalPages) {
        if (endPage < totalPages - 1) {
            addEllipsis()
        }
        addPageButton(totalPages)
    }
}

function addPageButton(pageNum) {
    const button = document.createElement("div")
    button.className = `page-number ${pageNum === currentPage ? "active" : ""}`
    button.textContent = pageNum
    button.addEventListener("click", () => goToPage(pageNum))
    pageNumbers.appendChild(button)
}

function addEllipsis() {
    const ellipsis = document.createElement("div")
    ellipsis.className = "page-number"
    ellipsis.textContent = "..."
    ellipsis.style.cursor = "default"
    pageNumbers.appendChild(ellipsis)
}

function goToPage(pageNum) {
    currentPage = pageNum
    renderTable()
}

function goToPreviousPage() {
    if (currentPage > 1) {
        currentPage--
        renderTable()
    }
}

function goToNextPage() {
    const totalPages = Math.ceil(filteredRoc.length / itemsPerPage)
    if (currentPage < totalPages) {
        currentPage++
        renderTable()
    }
}

function updateSortIcons() {
    tableHeaders.forEach((header) => {
        const column = header.getAttribute("data-sort")
        const icon = header.querySelector(".sort-icon")

        if (column === sortColumn) {
            icon.textContent = sortDirection === "asc" ? "↑" : "↓"
        } else {
            icon.textContent = "↕"
        }
    })
}

