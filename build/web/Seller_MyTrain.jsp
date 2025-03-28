<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Train Management</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="css/mytrain.css">
    </head>
    <body>
        <header class="header">
            <h1 class="header-title"><i class="fas fa-ship"></i> TraTra Tickets</h1>
        </header>


        <div class="main-content">
            <aside class="sidebar">
                <div class="sidebar-header">
                    <h5 class="sidebar-title">System Management</h5>
                </div>
                <div class="sidebar-divider"></div>
                <ul class="nav-list">
                    <li class="nav-item">
                        <a href="homeSellerPage.jsp" class="nav-link">
                            <i class="fas fa-chart-line"></i>
                            <span>Dashboard</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="viewlistroute" class="nav-link">
                            <i class="fas fa-route"></i>
                            <span>Train Routes</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="ViewAllTrain" class="nav-link active">
                            <i class="fas fa-train"></i>
                            <span>Trains</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="ViewListVoucher" class="nav-link">
                            <i class="fas fa-ticket-alt"></i>
                            <span>Voucher</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="seller-profile" class="nav-link">
                            <i class="fas fa-user-circle"></i>
                            <span>Account Information</span>
                        </a>
                    </li>                    
                    <li class="nav-item mt-4">
                        <a href="./logout" class="nav-link text-danger">
                            <i class="fas fa-sign-out-alt"></i>
                            <span>Logout</span>
                        </a>
                    </li>
                </ul>
            </aside>

            <main class="content">
                <h2 class="page-title">Train Management</h2>

                <div class="stats-container">
                    <div class="stat-card">
                        <div class="stat-icon active">
                            <i class="fas fa-train"></i>
                        </div>
                        <div class="stat-content">
                            <h3 class="stat-value">
                                <c:set var="activeCount" value="0" />
                                <c:forEach var="train" items="${trainList}">
                                    <c:if test="${train.status == 1}">
                                        <c:set var="activeCount" value="${activeCount + 1}" />
                                    </c:if>
                                </c:forEach>
                                <c:out value="${activeCount}" />
                            </h3>
                            <p class="stat-label">Active Trains</p>
                        </div>
                    </div>

                    <div class="stat-card">
                        <div class="stat-icon maintenance">
                            <i class="fas fa-wrench"></i>
                        </div>
                        <div class="stat-content">
                            <h3 class="stat-value">
                                <c:set var="maintenanceCount" value="0" />
                                <c:forEach var="train" items="${trainList}">
                                    <c:if test="${train.status == 2}">
                                        <c:set var="maintenanceCount" value="${maintenanceCount + 1}" />
                                    </c:if>
                                </c:forEach>
                                <c:out value="${maintenanceCount}" />
                            </h3>
                            <p class="stat-label">Maintenance Trains</p>
                        </div>
                    </div>

                    <div class="stat-card">
                        <div class="stat-icon inactive">
                            <i class="fas fa-train"></i>
                        </div>
                        <div class="stat-content">
                            <h3 class="stat-value">
                                <c:set var="inactiveCount" value="0" />
                                <c:forEach var="train" items="${trainList}">
                                    <c:if test="${train.status == 0}">
                                        <c:set var="inactiveCount" value="${inactiveCount + 1}" />
                                    </c:if>
                                </c:forEach>
                                <c:out value="${inactiveCount}" />
                            </h3>
                            <p class="stat-label">Inactive Trains</p>
                        </div>
                    </div>
                </div>

                <div class="card">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <h5 class="card-title">Trains List</h5>
                        <a href="waiting" class="btn btn-primary btn-sm">
                            <i class="fas fa-clock me-1"></i> Waiting Trains
                        </a>
                    </div>
                    <div class="card-body">
                        <div class="filters">
                            <div class="filter-group">
                                <span class="filter-label">Status:</span>
                                <select class="filter-select" id="statusFilter">
                                    <option value="all">All</option>
                                    <option value="1">Active</option>
                                    <option value="2">Maintenance</option>
                                    <option value="3">Inactive</option>
                                </select>
                            </div>

                            <div class="search-box">
                                <input type="text" class="search-input" id="searchInput" placeholder="Search by train model...">
                                <button class="btn btn-primary btn-sm" id="searchBtn">
                                    <i class="fas fa-search"></i>
                                </button>
                            </div>
                        </div>

                        <div class="table-responsive">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th>Train ID</th>
                                        <th>Train Model</th>
                                        <th>Total Seats</th>
                                        <th>Total Cabins</th>
                                        <th>Status</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="a" items="${trainList}">
                                        <c:if test="${a.status !=4 and a.status !=5 and a.status != 6}">
                                        <tr>
                                            <td>${a.id}</td>
                                            <td>${a.trainid}</td>                                            
                                            <td>${a.totalSeats}</td>
                                            <td>${a.numCabin}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${a.status == 1}">
                                                        <span class="status-badge status-active">Active</span>
                                                    </c:when>
                                                    <c:when test="${a.status == 2}">
                                                        <span class="status-badge status-maintenance">Maintenance</span>
                                                    </c:when>
                                                    <c:when test="${a.status == 0}">
                                                        <span class="status-badge status-inactive">Inactive</span>
                                                    </c:when>

                                                </c:choose>
                                            </td>
                                            <td>
                                                <div class="action-buttons">
                                                    <a href="DetailsTrain?id=${a.id}" class="btn btn-primary btn-icon" title="View Details">
                                                        <i class="fas fa-eye"></i>
                                                    </a>
                                                    <a href="UpdateStatusRoute?id=${a.id}" class="btn btn-info btn-icon" title="Settings">
                                                        <i class="fas fa-cog"></i>
                                                    </a>
                                                </div>
                                            </td>
                                        </tr>
                                        </c:if>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </main>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                // Status filter functionality
                const statusFilter = document.getElementById('statusFilter');
                if (statusFilter) {
                    statusFilter.addEventListener('change', function () {
                        const status = this.value;
                        const rows = document.querySelectorAll('.table tbody tr');

                        rows.forEach(row => {
                            if (status === 'all') {
                                row.style.display = '';
                                return;
                            }

                            const statusBadge = row.querySelector('.status-badge');
                            if (!statusBadge)
                                return;

                            const statusText = statusBadge.textContent.trim().toLowerCase();

                            if (status === '1' && statusText === 'active') {
                                row.style.display = '';
                            } else if (status === '2' && statusText === 'maintenance') {
                                row.style.display = '';
                            } else if (status === '3' && statusText === 'inactive') {
                                row.style.display = '';
                            } else {
                                row.style.display = 'none';
                            }
                        });
                    });
                }

                // Search functionality
                const searchInput = document.getElementById('searchInput');
                const searchBtn = document.getElementById('searchBtn');

                if (searchInput && searchBtn) {
                    const performSearch = () => {
                        const searchTerm = searchInput.value.toLowerCase();
                        const rows = document.querySelectorAll('.table tbody tr');

                        rows.forEach(row => {
                            const modelCell = row.cells[1]; // Train model is in the 2nd column (index 1)
                            if (!modelCell)
                                return;

                            const modelName = modelCell.querySelector('.model-name');
                            if (!modelName)
                                return;

                            const modelText = modelName.textContent.toLowerCase();
                            row.style.display = modelText.includes(searchTerm) ? '' : 'none';
                        });
                    };
                    searchBtn.addEventListener('click', performSearch);
                    searchInput.addEventListener('keyup', (e) => {
                        if (e.key === 'Enter') {
                            performSearch();
                        }
                    });
                }
            });
        </script>
    </body>
</html>

