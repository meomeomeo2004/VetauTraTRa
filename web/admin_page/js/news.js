// Sample news data
const newsData = [];

async function getNewsData() {
    try {
        const response = await fetch('NewsList', {
            method: 'POST', // Use POST method
            headers: {
                'Content-Type': 'application/json'  // Specify JSON content
            }
        });

        if (!response.ok) {
            throw new Error(`Error: ${response.status}`);
        }

        const data = await response.json();

        newsData.length = 0;

        data.forEach(item => {
            newsData.push({
                id: item.id,
                title: item.title,
                status: item.status,
                content: item.content,
                date: item.date
            });
        });
        filteredNews = [...newsData];
    } catch (error) {
        console.error("Failed to fetch News:", error);
    }
}

async function changeStatus(id) {
    await fetch('ChangeNewsStatus?id='+id, {
        method: 'GET'
    });
}

// State variables
let currentPage = 1;
const recordsPerPage = 5; // Fixed at 5 news per page as requested
let filteredNews = [];

// DOM elements
const newsList = document.getElementById('newsList');
const prevPageBtn = document.getElementById('prevPage');
const nextPageBtn = document.getElementById('nextPage');
const pageNumbersContainer = document.getElementById('pageNumbers');
const currentPageSpan = document.getElementById('currentPage');
const totalPagesSpan = document.getElementById('totalPages');
const searchTitleInput = document.getElementById('searchTitle');
const startDateInput = document.getElementById('startDate');
const endDateInput = document.getElementById('endDate');
const searchBtn = document.getElementById('searchBtn');
const resetBtn = document.getElementById('resetBtn');
const statusFilter = document.getElementById('statusFilter');

// Modal elements
const modal = document.getElementById('newsDetailModal');
const modalTitle = document.getElementById('modalTitle');
const modalDate = document.getElementById('modalDate');
const modalStatus = document.getElementById('modalStatus');
const modalContent = document.getElementById('modalContent');
const closeModal = document.querySelector('.close');

init();

// Initialize the page
async function init() {
    await getNewsData();
    renderNewsList();
    setupEventListeners();
}
;

// Set up event listeners
function setupEventListeners() {
    // Pagination
    prevPageBtn.addEventListener('click', () => {
        if (currentPage > 1) {
            currentPage--;
            renderNewsList();
        }
    });

    nextPageBtn.addEventListener('click', () => {
        const totalPages = Math.ceil(filteredNews.length / recordsPerPage);
        if (currentPage < totalPages) {
            currentPage++;
            renderNewsList();
        }
    });

    // Search
    searchBtn.addEventListener('click', applyFilters);

    // Enter key event for search input
    searchTitleInput.addEventListener('keypress', (e) => {
        if (e.key === 'Enter') {
            applyFilters();
        }
    });

    // Reset
    resetBtn.addEventListener('click', resetFilters);

    // Filter
    statusFilter.addEventListener('change', applyFilters);

    // Modal close
    closeModal.addEventListener('click', () => {
        modal.style.display = "none";
    });

    window.addEventListener('click', (event) => {
        if (event.target === modal) {
            modal.style.display = "none";
        }
    });
}

// Apply filters
function applyFilters() {
    const searchTitle = searchTitleInput.value.toLowerCase();
    const startDate = startDateInput.value;
    const endDate = endDateInput.value;
    const statusValue = statusFilter.value;

    filteredNews = newsData.filter(news => {
        // Title filter
        const matchesTitle = news.title.toLowerCase().includes(searchTitle);

        // Date range filter
        let matchesDateRange = true;
        if (startDate && endDate) {
            matchesDateRange = news.date >= startDate && news.date <= endDate;
        } else if (startDate) {
            matchesDateRange = news.date >= startDate;
        } else if (endDate) {
            matchesDateRange = news.date <= endDate;
        }

        // Status filter
        const matchesStatus = statusValue === 'all' || news.status === statusValue;

        return matchesTitle && matchesDateRange && matchesStatus;
    });

    currentPage = 1;
    renderNewsList();
}

// Reset filters
function resetFilters() {
    searchTitleInput.value = '';
    startDateInput.value = '';
    endDateInput.value = '';
    statusFilter.value = 'all';

    filteredNews = [...newsData];
    currentPage = 1;
    renderNewsList();
}

// Render the news list
function renderNewsList() {
    // Clear the list
    newsList.innerHTML = '';

    // Calculate pagination
    const totalPages = Math.ceil(filteredNews.length / recordsPerPage);
    const startIndex = (currentPage - 1) * recordsPerPage;
    const endIndex = Math.min(startIndex + recordsPerPage, filteredNews.length);

    // Update pagination UI
    updatePaginationUI(totalPages);

    // No news found
    if (filteredNews.length === 0) {
        newsList.innerHTML = '<div class="no-results">No news found matching your criteria</div>';
        return;
    }

    // Render news items
    for (let i = startIndex; i < endIndex; i++) {
        const news = filteredNews[i];
        const newsItem = document.createElement('div');
        newsItem.className = 'news-item';

        // Format the date
        const dateObj = new Date(news.date);
        const formattedDate = dateObj.toLocaleDateString('en-US', {
            year: 'numeric',
            month: 'long',
            day: 'numeric'
        });

        // Get content preview (first 100 characters)
        const contentPreview = news.content.length > 100
                ? news.content.substring(0, 100) + '...'
                : news.content;

        // Create publish/hide button based on current status
        const statusToggleBtn = news.status === 'Published'
                ? `<button class="btn btn-hide" data-id="${news.id}"><i class="fas fa-eye-slash"></i> Hide</button>`
                : `<button class="btn btn-publish" data-id="${news.id}"><i class="fas fa-eye"></i> Publish</button>`;

        newsItem.innerHTML = `
            <div class="status status-${news.status}">${news.status}</div>
            <h2>${news.title}</h2>
            <div class="date"><i class="far fa-calendar-alt"></i> ${formattedDate}</div>
            <div class="content-preview">${contentPreview}</div>
            <div class="actions">
                <button class="btn btn-view" data-id="${news.id}"><i class="fas fa-eye"></i> View Details</button>
                <a href="EditNews?id=${news.id}"><button class="btn btn-edit" data-id="${news.id}"><i class="fas fa-edit"></i> Edit</button></a>
                ${statusToggleBtn}
            </div>
        `;
        newsList.appendChild(newsItem);
    }

    // Add event listeners to buttons
    addButtonEventListeners();
}

// Add event listeners to the buttons in each news item
function addButtonEventListeners() {
    // View Details buttons
    document.querySelectorAll('.btn-view').forEach(button => {
        button.addEventListener('click', (e) => {
            const newsId = parseInt(e.currentTarget.getAttribute('data-id'));
            showNewsDetails(newsId);
        });
    });

    // Publish/Hide buttons
    document.querySelectorAll('.btn-publish, .btn-hide').forEach(button => {
        button.addEventListener('click', async (e) => {

            // Show a confirmation dialog
            const action = button.classList.contains('btn-publish') ? 'publish' : 'hide';
            const confirmation = confirm(`Are you sure you want to ${action} this news?`);

            if (confirmation) {
                const newsId = parseInt(e.currentTarget.getAttribute('data-id'));
                await changeStatus(newsId);
                toggleNewsStatus(newsId);
            }
        });
    });
}

// Show news details in modal
function showNewsDetails(newsId) {
    const news = newsData.find(item => item.id === newsId);
    if (!news)
        return;

    // Format the date
    const dateObj = new Date(news.date);
    const formattedDate = dateObj.toLocaleDateString('en-US', {
        year: 'numeric',
        month: 'long',
        day: 'numeric'
    });

    modalTitle.textContent = news.title;
    modalDate.textContent = formattedDate;
    modalStatus.textContent = news.status;
    modalStatus.className = `status-${news.status}`;
    modalContent.textContent = news.content;

    modal.style.display = "block";
}

// Toggle news status (published/hidden)
function toggleNewsStatus(newsId) {
    // Find the news in the original data
    const newsIndex = newsData.findIndex(item => item.id === newsId);
    if (newsIndex === -1)
        return;

    // Toggle the status
    newsData[newsIndex].status = newsData[newsIndex].status === 'Published' ? 'Hidden' : 'Published';

    // Re-apply filters to update the filtered list
    applyFilters();
}

// Update pagination UI
function updatePaginationUI(totalPages) {
    // Update page info
    currentPageSpan.textContent = currentPage;
    totalPagesSpan.textContent = totalPages;

    // Enable/disable prev/next buttons
    prevPageBtn.disabled = currentPage === 1;
    nextPageBtn.disabled = currentPage === totalPages || totalPages === 0;

    // Generate page number buttons
    pageNumbersContainer.innerHTML = '';

    // Determine which page numbers to show
    let startPage = Math.max(1, currentPage - 2);
    let endPage = Math.min(totalPages, startPage + 4);

    // Adjust if we're near the end
    if (endPage - startPage < 4 && startPage > 1) {
        startPage = Math.max(1, endPage - 4);
    }

    for (let i = startPage; i <= endPage; i++) {
        const pageBtn = document.createElement('div');
        pageBtn.className = `page-number ${i === currentPage ? 'active' : ''}`;
        pageBtn.textContent = i;
        pageBtn.addEventListener('click', () => {
            currentPage = i;
            renderNewsList();
        });
        pageNumbersContainer.appendChild(pageBtn);
    }
}