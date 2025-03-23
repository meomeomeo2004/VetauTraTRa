<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        <style>
            :root {
                --primary: #22577a;
                --primary-dark: #1a4562;
                --primary-light: #38a3a5;
                --secondary: #57cc99;
                --danger: #e63946;
                --warning: #ff9f1c;
                --success: #2a9d8f;
                --light: #f8f9fa;
                --dark: #212529;
                --gray-100: #f8f9fa;
                --gray-200: #e9ecef;
                --gray-300: #dee2e6;
                --gray-400: #ced4da;
                --gray-500: #adb5bd;
                --gray-600: #6c757d;
                --gray-700: #495057;
                --gray-800: #343a40;
                --gray-900: #212529;
                --border-radius: 0.5rem;
                --box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.08);
                --transition: all 0.3s ease;
            }

            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                display: flex;
                min-height: 100vh;
                margin: 0;
                font-family: 'Roboto', sans-serif;
                background-color: var(--gray-100);
                color: var(--gray-800);
            }

            .sidebar {
                width: 280px;
                background-color: white;
                color: var(--gray-800);
                padding: 2rem 1.5rem;
                box-shadow: var(--box-shadow);
                transition: var(--transition);
                height: 100vh;
                position: fixed;
                overflow-y: auto;
                z-index: 1000;
            }

            .sidebar-header {
                margin-bottom: 2rem;
                text-align: center;
            }

            .sidebar-title {
                font-size: 1.5rem;
                color: var(--primary);
                font-weight: 700;
                margin-bottom: 0.5rem;
                letter-spacing: 0.5px;
            }

            .sidebar-divider {
                height: 1px;
                background-color: var(--gray-300);
                margin: 1rem 0;
            }

            .nav-list {
                list-style: none;
                padding: 0;
                margin: 0;
            }

            .nav-item {
                margin-bottom: 0.5rem;
            }

            .nav-link {
                display: flex;
                align-items: center;
                text-decoration: none;
                color: var(--gray-700);
                font-weight: 500;
                padding: 0.75rem 1rem;
                border-radius: var(--border-radius);
                transition: var(--transition);
            }

            .nav-link:hover, .nav-link.active {
                background-color: var(--primary);
                color: white;
            }

            .nav-link i {
                margin-right: 0.75rem;
                font-size: 1.1rem;
                width: 1.5rem;
                text-align: center;
            }

            .content {
                flex: 1;
                padding: 2rem;
                margin-left: 280px;
                width: calc(100% - 280px);
            }

            .page-title {
                font-size: 1.75rem;
                font-weight: 700;
                margin-bottom: 1.5rem;
                color: var(--primary);
                display: flex;
                align-items: center;
            }

            .page-title i {
                margin-right: 0.75rem;
                font-size: 1.5rem;
                color: var(--primary);
            }

            .card {
                background-color: white;
                border-radius: var(--border-radius);
                box-shadow: var(--box-shadow);
                border: none;
                margin-bottom: 2rem;
                overflow: hidden;
            }

            .card-header {
                background-color: white;
                border-bottom: 1px solid var(--gray-200);
                padding: 1.25rem 1.5rem;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .card-title {
                font-size: 1.25rem;
                font-weight: 600;
                margin: 0;
                color: var(--gray-800);
            }

            .card-body {
                padding: 1.5rem;
            }

            .btn {
                font-weight: 500;
                padding: 0.625rem 1.25rem;
                border-radius: var(--border-radius);
                transition: var(--transition);
                display: inline-flex;
                align-items: center;
                justify-content: center;
                gap: 0.5rem;
                border: none;
            }

            .btn-primary {
                background-color: var(--primary);
                color: white;
            }

            .btn-primary:hover {
                background-color: var(--primary-dark);
            }

            .btn-success {
                background-color: var(--success);
                color: white;
            }

            .btn-success:hover {
                background-color: #248a7e;
            }

            .btn-danger {
                background-color: var(--danger);
                color: white;
            }

            .btn-danger:hover {
                background-color: #d62b39;
            }

            .btn-warning {
                background-color: var(--warning);
                color: white;
            }

            .btn-warning:hover {
                background-color: #e58e19;
            }

            .btn-info {
                background-color: var(--primary-light);
                color: white;
            }

            .btn-info:hover {
                background-color: #2d8a8c;
            }

            .btn-sm {
                padding: 0.375rem 0.75rem;
                font-size: 0.875rem;
            }

            .btn-icon {
                width: 2.25rem;
                height: 2.25rem;
                padding: 0;
                display: inline-flex;
                align-items: center;
                justify-content: center;
                border-radius: 0.375rem;
            }

            .table-responsive {
                overflow-x: auto;
                -webkit-overflow-scrolling: touch;
            }

            .table {
                width: 100%;
                margin-bottom: 0;
                color: var(--gray-700);
                vertical-align: middle;
                border-color: var(--gray-200);
            }

            .table thead th {
                background-color: var(--primary);
                color: white;
                font-weight: 600;
                text-align: left;
                padding: 1rem;
                border: none;
                white-space: nowrap;
            }

            .table tbody td {
                padding: 1rem;
                text-align: left;
                border-bottom: 1px solid var(--gray-200);
                vertical-align: middle;
            }

            .table tbody tr {
                transition: var(--transition);
            }

            .table tbody tr:hover {
                background-color: var(--gray-100);
            }

            .table tbody tr:last-child td {
                border-bottom: none;
            }

            .form-control, .form-select {
                border-radius: var(--border-radius);
                border: 1px solid var(--gray-300);
                padding: 0.625rem 1rem;
                font-size: 0.95rem;
                transition: var(--transition);
            }

            .form-control:focus, .form-select:focus {
                border-color: var(--primary);
                box-shadow: 0 0 0 0.25rem rgba(34, 87, 122, 0.15);
            }

            .form-control::placeholder {
                color: var(--gray-500);
            }

            .filter-section {
                background-color: var(--gray-100);
                border-radius: var(--border-radius);
                padding: 1.25rem;
                margin-bottom: 1.5rem;
            }

            .status-active {
                background-color: var(--success);
                color: white;
                padding: 0.35rem 0.65rem;
                border-radius: 50rem;
                font-size: 0.75rem;
                font-weight: 600;
            }

            .status-maintenance {
                background-color: var(--warning);
                color: white;
                padding: 0.35rem 0.65rem;
                border-radius: 50rem;
                font-size: 0.75rem;
                font-weight: 600;
            }

            .status-inactive {
                background-color: var(--danger);
                color: white;
                padding: 0.35rem 0.65rem;
                border-radius: 50rem;
                font-size: 0.75rem;
                font-weight: 600;
            }

            .action-buttons {
                display: flex;
                gap: 0.5rem;
            }

            .empty-state {
                text-align: center;
                padding: 3rem 1rem;
            }

            .empty-state-icon {
                font-size: 3rem;
                color: var(--gray-400);
                margin-bottom: 1rem;
            }

            .empty-state-title {
                font-size: 1.25rem;
                font-weight: 600;
                color: var(--gray-700);
                margin-bottom: 0.5rem;
            }

            .empty-state-description {
                color: var(--gray-600);
                margin-bottom: 1.5rem;
            }

            @media (max-width: 992px) {
                .sidebar {
                    width: 240px;
                }
                
                .content {
                    margin-left: 240px;
                    width: calc(100% - 240px);
                }
            }

            @media (max-width: 768px) {
                body {
                    flex-direction: column;
                }
                
                .sidebar {
                    width: 100%;
                    height: auto;
                    position: relative;
                    padding: 1rem;
                }
                
                .content {
                    margin-left: 0;
                    width: 100%;
                    padding: 1.5rem;
                }
                
                .card-header {
                    flex-direction: column;
                    gap: 1rem;
                    align-items: flex-start;
                }
                
                .action-buttons {
                    margin-top: 0.5rem;
                }
            }

            @media (max-width: 576px) {
                .content {
                    padding: 1rem;
                }
                
                .filter-section .row > div {
                    margin-bottom: 1rem;
                }
                
                .btn-group {
                    flex-direction: column;
                    width: 100%;
                }
                
                .btn-group .btn {
                    width: 100%;
                    margin-bottom: 0.5rem;
                }
            }
        </style>
    </head>
    <body>
        <aside class="sidebar">
            <div class="sidebar-header">
                <h5 class="sidebar-title"><i class="fas fa-train"></i> Manager Panel</h5>
            </div>
            <div class="sidebar-divider"></div>
            <ul class="nav-list">
                <li class="nav-item">
                    <a href="ManagerHomePage.jsp" class="nav-link">
                        <i class="fas fa-chart-line"></i>
                        <span>Dashboard</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="#" class="nav-link">
                        <i class="fas fa-users"></i>
                        <span>Manage Users</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="listtrain" class="nav-link active">
                        <i class="fas fa-subway"></i>
                        <span>Manage Trains</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="#" class="nav-link">
                        <i class="fas fa-route"></i>
                        <span>Manage Routes</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="#" class="nav-link">
                        <i class="fas fa-user-circle"></i>
                        <span>Account</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="#" class="nav-link">
                        <i class="fas fa-chart-bar"></i>
                        <span>Reports</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="#" class="nav-link">
                        <i class="fas fa-cog"></i>
                        <span>Settings</span>
                    </a>
                </li>
            </ul>
        </aside>
        
        <main class="content">
            <h2 class="page-title"><i class="fas fa-subway"></i> Train Management</h2>
            
            <div class="card">
                <div class="card-header">
                    <h5 class="card-title">Train Fleet</h5>
                    <a href="AddTrain" class="btn btn-primary">
                        <i class="fas fa-plus"></i> Add New Train
                    </a>
                </div>
                <div class="card-body">
                    <div class="filter-section">
                        <form action="FilterTrain" method="get">
                            <div class="row">
                                <div class="col-md-4 mb-3 mb-md-0">
                                    <label for="trainModel" class="form-label">Train Model</label>
                                    <select name="trainModel" id="trainModel" class="form-select">
                                        <option value="">-- All Models --</option>
                                        <c:forEach var="t" items="${alltrain}">
                                            <option value="${t.trainid}" <c:if test="${param.trainModel eq t.trainid}">selected</c:if>>${t.trainid}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="col-md-4 mb-3 mb-md-0">
                                    <label for="owner" class="form-label">Owner</label>
                                    <select name="owner" id="owner" class="form-select">
                                        <option value="">-- All Owners --</option>
                                        <c:forEach var="entry" items="${sellerMap}">
                                            <option value="${entry.key}" <c:if test="${param.owner eq entry.key}">selected</c:if>>${entry.value}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="col-md-4 d-flex align-items-end">
                                    <button type="submit" class="btn btn-primary w-100">
                                        <i class="fas fa-search"></i> Search
                                    </button>
                                </div>
                            </div>
                        </form>
                    </div>
                    
                    <div class="table-responsive">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Model</th>
                                    <th>Total Seats</th>
                                    <th>Total Cabins</th>
                                    <th>Status</th>
                                    <th>Owner</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${alltrain}" var="t">
                                    <c:if test="${t.status == 1}">
                                        <tr>
                                            <td>${t.id}</td>
                                            <td><strong>${t.trainid}</strong></td>
                                            <td>${t.totalSeats}</td>
                                            <td>${t.numCabin}</td>
                                            <td>
                                                <form action="UpdateStatusTrain" method="get">
                                                    <input type="hidden" name="trainId" value="${t.id}">
                                                    <select name="status" class="form-select form-select-sm" style="width: auto;" onchange="
                                                            var newStatus = this.options[this.selectedIndex].text;
                                                            if (confirm('Are you sure you want to change the status to ' + newStatus + '?')) {
                                                                this.form.submit();
                                                            } else {
                                                                this.selectedIndex = 0;
                                                            }">
                                                        <option value="1" selected>Active</option>
                                                        <option value="2">Maintenance</option>
                                                        <option value="0">Inactive</option>
                                                    </select>
                                                </form>
                                            </td>
                                            <td>${sellerMap[t.owner]}</td>
                                            <td>
                                                <div class="action-buttons">
                                                    <a href="editTrain?id=${t.id}" class="btn btn-warning btn-icon" title="Edit">
                                                        <i class="fas fa-edit"></i>
                                                    </a>
                                                    <a href="DetailsTrain?id=${t.id}" class="btn btn-info btn-icon" title="Details">
                                                        <i class="fas fa-eye"></i>
                                                    </a>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:if>
                                </c:forEach>
                                
                                <c:if test="${empty alltrain}">
                                    <tr>
                                        <td colspan="7">
                                            <div class="empty-state">
                                                <div class="empty-state-icon">
                                                    <i class="fas fa-train"></i>
                                                </div>
                                                <h4 class="empty-state-title">No trains found</h4>
                                                <p class="empty-state-description">There are no trains matching your criteria.</p>
                                                <a href="AddTrain" class="btn btn-primary">
                                                    <i class="fas fa-plus"></i> Add New Train
                                                </a>
                                            </div>
                                        </td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            
            <!-- Train Statistics Card -->
            <div class="card">
                <div class="card-header">
                    <h5 class="card-title">Train Fleet Overview</h5>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-4 mb-4">
                            <div class="card h-100">
                                <div class="card-body text-center">
                                    <i class="fas fa-subway mb-3" style="font-size: 2.5rem; color: var(--primary);"></i>
                                    <h5>Total Active Trains</h5>
                                    <h2 class="mt-2" style="color: var(--primary);">
                                        <c:set var="activeCount" value="0" />
                                        <c:forEach items="${alltrain}" var="t">
                                            <c:if test="${t.status == 1}">
                                                <c:set var="activeCount" value="${activeCount + 1}" />
                                            </c:if>
                                        </c:forEach>
                                        ${activeCount}
                                    </h2>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4 mb-4">
                            <div class="card h-100">
                                <div class="card-body text-center">
                                    <i class="fas fa-tools mb-3" style="font-size: 2.5rem; color: var(--warning);"></i>
                                    <h5>Trains in Maintenance</h5>
                                    <h2 class="mt-2" style="color: var(--warning);">
                                        <c:set var="maintenanceCount" value="0" />
                                        <c:forEach items="${alltrain}" var="t">
                                            <c:if test="${t.status == 2}">
                                                <c:set var="maintenanceCount" value="${maintenanceCount + 1}" />
                                            </c:if>
                                        </c:forEach>
                                        ${maintenanceCount}
                                    </h2>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4 mb-4">
                            <div class="card h-100">
                                <div class="card-body text-center">
                                    <i class="fas fa-train-subway mb-3" style="font-size: 2.5rem; color: var(--danger);"></i>
                                    <h5>Total Train Inactive</h5>
                                    <h2 class="mt-2" style="color: var(--danger);">
                                        <c:set var="inactiveCount" value="0" />
                                        <c:forEach items="${alltrain}" var="t">
                                            <c:if test="${t.status == 0}">
                                                <c:set var="inactiveCount" value="${inactiveCount + 1}" />
                                            </c:if>
                                        </c:forEach>
                                        ${inactiveCount}
                                    </h2>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
        
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>

