<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Waiting Train List</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="css/mytrain.css">
        <style>
            .cabin-card {
                border-radius: 10px;
                box-shadow: 0 4px 8px rgba(0,0,0,0.1);
                margin-bottom: 20px;
                transition: transform 0.3s;
            }
            .cabin-card:hover {
                transform: translateY(-5px);
            }
            .cabin-image {
                height: 180px;
                object-fit: cover;
                border-top-left-radius: 10px;
                border-top-right-radius: 10px;
            }
            .cabin-details {
                padding: 15px;
            }
            .cabin-price {
                font-size: 1.25rem;
                font-weight: bold;
                color: #2c3e50;
            }
            .cabin-class {
                display: inline-block;
                padding: 3px 10px;
                border-radius: 20px;
                font-size: 0.8rem;
                font-weight: 500;
                margin-bottom: 10px;
            }
            .class-economy {
                background-color: #e9f7ef;
                color: #27ae60;
            }
            .class-business {
                background-color: #eaf2f8;
                color: #3498db;
            }
            .class-first {
                background-color: #fef9e7;
                color: #f39c12;
            }
            .class-luxury {
                background-color: #f4ecf7;
                color: #8e44ad;
            }
            .action-btn {
                margin-right: 5px;
            }
            .status-new {
                background-color: #d4edda;
                color: #155724;
                padding: 3px 8px;
                border-radius: 4px;
                font-size: 0.85rem;
            }
            .status-edit {
                background-color: #fff3cd;
                color: #856404;
                padding: 3px 8px;
                border-radius: 4px;
                font-size: 0.85rem;
            }
            .train-details-card {
                background-color: #f8f9fa;
                border-radius: 10px;
                padding: 20px;
                margin-bottom: 30px;
                box-shadow: 0 2px 5px rgba(0,0,0,0.05);
            }
            .train-model {
                font-size: 1.5rem;
                font-weight: 600;
                margin-bottom: 15px;
                color: #2c3e50;
            }
            .train-info {
                display: flex;
                flex-wrap: wrap;
                gap: 20px;
                margin-bottom: 15px;
            }
            .info-item {
                display: flex;
                align-items: center;
            }
            .info-icon {
                margin-right: 8px;
                color: #3498db;
            }
            .cabin-section-title {
                margin: 30px 0 20px;
                padding-bottom: 10px;
                border-bottom: 2px solid #eee;
            }
        </style>
    </head>
    <body>
        <header class="header">
            <h1 class="header-title"><i class="fas fa-ship"></i> TraTra Ferry</h1>
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
                            <span>Trip Management</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="#" class="nav-link">
                            <i class="fas fa-calendar-alt"></i>
                            <span>Schedule</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="ViewAllTrain" class="nav-link">
                            <i class="fas fa-train"></i>
                            <span>Trains</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="#" class="nav-link">
                            <i class="fas fa-user"></i>
                            <span>Account</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="#" class="nav-link">
                            <i class="fas fa-circle-info"></i>
                            <span>Account Information</span>
                        </a>
                    </li>
                </ul>
            </aside>

            <main class="content">
                <h2 class="page-title">Waiting Train Approval</h2>
                
                <div class="filters mb-4">
                    <div class="filter-group">
                        <span class="filter-label">Status:</span>
                        <select class="filter-select" id="statusFilter">
                            <option value="all">All</option>
                            <option value="4">New</option>
                            <option value="5">Edited</option>
                        </select>
                    </div>

                    <div class="search-box">
                        <input type="text" class="search-input" id="searchInput" placeholder="Search by train model...">
                        <button class="btn btn-primary btn-sm" id="searchBtn">
                            <i class="fas fa-search"></i>
                        </button>
                    </div>
                </div>

                <!-- Train List -->
                <div class="card">
                    <div class="card-header">
                        <h5 class="card-title">Waiting Trains</h5>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th>Train Model</th>
                                        <th>Total Seats</th>
                                        <th>Total Cabins</th>
                                        <th>Status</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="train" items="${trainl}">
                                        <tr>
                                            <td>${train.trainid}</td>
                                            <td>${train.totalSeats}</td>
                                            <td>${train.numCabin}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${train.status == 4}">
                                                        <span class="status-new">New</span>
                                                    </c:when>
                                                    <c:when test="${train.status == 5}">
                                                        <span class="status-edit">Edited</span>
                                                    </c:when>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <div class="action-buttons">
                                                    <a href="DetailsTrain?id=${train.id}" class="btn btn-primary btn-sm action-btn">
                                                        <i class="fas fa-eye"></i> View
                                                    </a>
                                                    <form action="UpdateStatusRoute" method="POST" style="display: inline;">
                                                        <input type="hidden" name="trainId" value="${train.id}">
                                                        <input type="hidden" name="status" value="0">
                                                        <button type="submit" class="btn btn-success btn-sm action-btn" onclick="return confirm('Are you sure you want to accept this train?');">
                                                            <i class="fas fa-check"></i> Accept
                                                        </button>
                                                    </form>
                                                    <form action="UpdateStatusRoute" method="POST" style="display: inline;">
                                                        <input type="hidden" name="trainId" value="${train.id}">
                                                        <input type="hidden" name="status" value="6">
                                                        <button type="submit" class="btn btn-danger btn-sm action-btn" onclick="return confirm('Are you sure you want to cancel this train?');">
                                                            <i class="fas fa-times"></i> Cancel
                                                        </button>
                                                    </form>
                                                </div>
                                            </td>

                                        </tr>
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

                            const statusSpan = row.querySelector('td:nth-child(4) span');
                            if (!statusSpan) return;

                            const statusText = statusSpan.textContent.trim().toLowerCase();

                            if (status === '4' && statusText === 'new') {
                                row.style.display = '';
                            } else if (status === '5' && statusText === 'edited') {
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
                            const modelCell = row.cells[0]; // Train model is in the 1st column (index 0)
                            if (!modelCell) return;

                            const modelText = modelCell.textContent.toLowerCase();
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