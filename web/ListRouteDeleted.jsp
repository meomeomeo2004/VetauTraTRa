<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Deleted Train Routes</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
        <style>
            :root {
                --primary: #659dbd;
                --primary-dark: #3a56d4;
                --secondary: #2ec4b6;
                --danger: #bc986a;
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
                flex-direction: column;
                min-height: 100vh;
                margin: 0;
                font-family: 'Roboto', sans-serif;
                background-color: var(--gray-100);
                color: var(--gray-800);
            }

            .header {
                width: 100%;
                background-color: var(--primary);
                color: white;
                padding: 1rem 2rem;
                display: flex;
                align-items: center;
                justify-content: center;
                box-shadow: var(--box-shadow);
                position: sticky;
                top: 0;
                z-index: 1000;
            }

            .header-title {
                font-size: 1.5rem;
                font-weight: 700;
                margin: 0;
                letter-spacing: 0.5px;
            }

            .header-title i {
                margin-right: 0.5rem;
            }

            .main-content {
                display: flex;
                flex: 1;
            }

            .sidebar {
                width: 280px;
                background-color: white;
                padding: 2rem 1.5rem;
                border-right: 1px solid var(--gray-200);
                box-shadow: var(--box-shadow);
                transition: var(--transition);
                height: calc(100vh - 64px);
                position: sticky;
                top: 64px;
                overflow-y: auto;
            }

            .sidebar-header {
                margin-bottom: 2rem;
                text-align: center;
            }

            .sidebar-title {
                font-size: 1.25rem;
                color: var(--primary);
                font-weight: 700;
                margin-bottom: 0.5rem;
            }

            .sidebar-divider {
                height: 1px;
                background-color: var(--gray-200);
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
                max-width: 100%;
            }

            .page-title {
                font-size: 1.75rem;
                font-weight: 700;
                margin-bottom: 1.5rem;
                color: var(--gray-800);
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
                padding: 0.5rem 1.25rem;
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

            .btn-sm {
                padding: 0.25rem 0.5rem;
                font-size: 0.875rem;
            }

            .btn-icon {
                width: 2rem;
                height: 2rem;
                padding: 0;
                display: inline-flex;
                align-items: center;
                justify-content: center;
                border-radius: 50%;
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
                text-align: center;
                padding: 1rem;
                border: none;
                white-space: nowrap;
            }

            .table tbody td {
                padding: 1rem;
                text-align: center;
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

            .badge {
                padding: 0.35rem 0.65rem;
                font-size: 0.75rem;
                font-weight: 600;
                border-radius: 50rem;
            }

            .badge-danger {
                background-color: var(--danger);
                color: white;
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
            }

            @media (max-width: 768px) {
                .main-content {
                    flex-direction: column;
                }
                
                .sidebar {
                    width: 100%;
                    height: auto;
                    position: relative;
                    top: 0;
                }
                
                .content {
                    padding: 1.5rem;
                }
                
                .card-header {
                    flex-direction: column;
                    gap: 1rem;
                    align-items: flex-start;
                }
            }

            @media (max-width: 576px) {
                .header {
                    padding: 1rem;
                }
                
                .content {
                    padding: 1rem;
                }
            }
        </style>
    </head>
    <body>
        <header class="header">
            <h1 class="header-title"><i class="fas fa-train"></i> TraTra Train Tickets</h1>
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
                        <a href="viewlistroute" class="nav-link active">
                            <i class="fas fa-route"></i>
                            <span>Train Routes</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="#" class="nav-link">
                            <i class="fas fa-calendar-alt"></i>
                            <span>Schedules</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="#" class="nav-link">
                            <i class="fas fa-subway"></i>
                            <span>Trains</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="#" class="nav-link">
                            <i class="fas fa-users"></i>
                            <span>User Accounts</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="#" class="nav-link">
                            <i class="fas fa-user-circle"></i>
                            <span>Account Info</span>
                        </a>
                    </li>
                </ul>
            </aside>
            
            <main class="content">
                <h2 class="page-title">Deleted Train Routes</h2>
                
                <div class="card">
                    <div class="card-header">
                        <h5 class="card-title">Deleted Routes History</h5>
                        <div>
                            <a href="viewlistroute" class="btn btn-danger">
                                <i class="fas fa-arrow-left"></i> Back to Routes
                            </a>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th>Route ID</th>
                                        <th>Departure Station</th>
                                        <th>Arrival Station</th>
                                        <th>Departure Date</th>
                                        <th>Departure Time</th>
                                        <th>Arrival Time</th>
                                        <th>Status</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${routedeleted}" var="d">
                                        <tr>
                                            <td>${d.routeCode}</td>
                                            <td>${d.departureStation}</td>
                                            <td>${d.arrivalStation}</td>
                                            <td>${d.departureDate}</td>
                                            <td>${d.departureHour}</td>
                                            <td>${d.arrivalHour}</td>
                                            <td>
                                                <span class="badge badge-danger">Deleted</span>
                                            </td>
                                        </tr>   
                                    </c:forEach>
                                    
                                    <c:if test="${empty routedeleted}">
                                        <tr>
                                            <td colspan="7">
                                                <div class="empty-state">
                                                    <div class="empty-state-icon">
                                                        <i class="fas fa-trash-alt"></i>
                                                    </div>
                                                    <h4 class="empty-state-title">No deleted routes found</h4>
                                                    <p class="empty-state-description">There are no deleted train routes in the system.</p>
                                                    <a href="viewlistroute" class="btn btn-danger">
                                                        <i class="fas fa-arrow-left"></i> Back to Routes
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
            </main>
        </div>
        
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>

