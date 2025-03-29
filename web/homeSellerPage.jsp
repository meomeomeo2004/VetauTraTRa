<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Dashboard - TraTra Train Tickets</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <style>
            :root {
                --primary: #22577a;
                --primary-dark: #3a56d4;
                --secondary: #2ec4b6;
                --danger: #e63946;
                --warning: #ff9f1c;
                --success: #2a9d8f;
                --info: #4cc9f0;
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

                /* Chart colors */
                --chart-1: #4361ee;
                --chart-2: #3a0ca3;
                --chart-3: #7209b7;
                --chart-4: #f72585;
                --chart-5: #4cc9f0;
                --chart-6: #4895ef;
                --chart-7: #560bad;
                --chart-8: #b5179e;
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
                margin-bottom: 1.5rem;
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

            .stats-card {
                display: flex;
                align-items: center;
                padding: 1.5rem;
            }

            .stats-icon {
                display: flex;
                align-items: center;
                justify-content: center;
                width: 4rem;
                height: 4rem;
                border-radius: 50%;
                margin-right: 1rem;
                font-size: 1.5rem;
                color: white;
            }

            .stats-icon.primary {
                background-color: var(--primary);
            }

            .stats-icon.success {
                background-color: var(--success);
            }

            .stats-icon.warning {
                background-color: var(--warning);
            }

            .stats-icon.info {
                background-color: var(--info);
            }

            .stats-info {
                flex: 1;
            }

            .stats-label {
                font-size: 0.875rem;
                color: var(--gray-600);
                margin-bottom: 0.25rem;
            }

            .stats-value {
                font-size: 1.75rem;
                font-weight: 700;
                color: var(--gray-800);
                margin-bottom: 0;
            }

            .stats-change {
                font-size: 0.875rem;
                display: flex;
                align-items: center;
                margin-top: 0.25rem;
            }

            .stats-change.positive {
                color: var(--success);
            }

            .stats-change.negative {
                color: var(--danger);
            }

            .stats-change i {
                margin-right: 0.25rem;
            }

            .chart-container {
                position: relative;
                height: 300px;
                width: 100%;
            }

            .btn-group-toggle {
                display: flex;
                border-radius: var(--border-radius);
                overflow: hidden;
                background-color: var(--gray-200);
            }

            .btn-group-toggle .btn {
                border: none;
                background-color: transparent;
                color: var(--gray-700);
                padding: 0.5rem 1rem;
                font-size: 0.875rem;
                font-weight: 500;
                transition: var(--transition);
            }

            .btn-group-toggle .btn.active {
                background-color: var(--primary);
                color: white;
            }

            .table {
                width: 100%;
                margin-bottom: 0;
                color: var(--gray-700);
                vertical-align: middle;
                border-color: var(--gray-200);
            }

            .table thead th {
                background-color: var(--gray-100);
                color: var(--gray-700);
                font-weight: 600;
                text-align: left;
                padding: 1rem;
                border: none;
                border-bottom: 1px solid var(--gray-200);
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

            .progress {
                height: 0.5rem;
                background-color: var(--gray-200);
                border-radius: 1rem;
                overflow: hidden;
            }

            .progress-bar {
                height: 100%;
                border-radius: 1rem;
            }

            .progress-bar-primary {
                background-color: var(--primary);
            }

            .progress-bar-success {
                background-color: var(--success);
            }

            .progress-bar-warning {
                background-color: var(--warning);
            }

            .progress-bar-info {
                background-color: var(--info);
            }

            .progress-bar-danger {
                background-color: var(--danger);
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

                .stats-grid {
                    grid-template-columns: 1fr;
                }
            }
        </style>
    </head>
    <body>
        <header class="header">
            <h1 class="header-title"><i class="fas fa-train"></i> TraTra Tickets</h1>
        </header>

        <div class="main-content">
            <aside class="sidebar">
                <div class="sidebar-header">
                    <h5 class="sidebar-title">System Management</h5>
                </div>
                <div class="sidebar-divider"></div>
                <ul class="nav-list">
                    <li class="nav-item">
                        <a href="homeSellerPage.jsp" class="nav-link active">
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
                        <a href="ViewAllTrain" class="nav-link">
                            <i class="fas fa-subway"></i>
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
                <h2 class="page-title">Dashboard</h2>

                <!-- Summary Stats Cards -->
                <div class="row">
                    <div class="col-md-6 col-lg-3 mb-4">
                        <div class="card stats-card">
                            <div class="stats-icon primary">
                                <i class="fas fa-users"></i>
                            </div>
                            <div class="stats-info">
                                <div class="stats-label">Total Customers</div>
                                <h3 class="stats-value"><c:out value="${requestScope.customerThisMonth}"/></h3>
                                <div class="stats-change positive">
                                    <c:choose>
                                        <c:when test="${requestScope.customerThisMonthSign eq '1'}">
                                            <i class="fas fa-arrow-up"></i>
                                        </c:when>
                                        <c:otherwise>
                                            <i class="fas fa-arrow-down"></i>
                                        </c:otherwise>
                                    </c:choose>
                                    <c:out value="${requestScope.customerThisMonthPercent}"/>% from last month
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-3 mb-4">
                        <div class="card stats-card">
                            <div class="stats-icon success">
                                <i class="fas fa-ticket-alt"></i>
                            </div>
                            <div class="stats-info">
                                <div class="stats-label">Tickets Sold</div>
                                <h3 class="stats-value"><c:out value="${requestScope.ticket}"/></h3>
                                <div class="stats-change positive">
                                    <c:choose>
                                        <c:when test="${requestScope.ticketSign eq '1'}">
                                            <i class="fas fa-arrow-up"></i>
                                        </c:when>
                                        <c:otherwise>
                                            <i class="fas fa-arrow-down"></i>
                                        </c:otherwise>
                                    </c:choose>
                                    <c:out value="${requestScope.ticketPercent}"/>% from last month
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-3 mb-4">
                        <div class="card stats-card">
                            <div class="stats-icon warning">
                                <i class="fas fa-route"></i>
                            </div>
                            <div class="stats-info">
                                <div class="stats-label">Active Routes</div>
                                <h3 class="stats-value"><c:out value="${requestScope.routeThisMonth}"/></h3>
                                <div class="stats-change positive">
                                    <c:choose>
                                        <c:when test="${requestScope.routeThisMonthSign eq '1'}">
                                            <i class="fas fa-arrow-up"></i>
                                        </c:when>
                                        <c:otherwise>
                                            <i class="fas fa-arrow-down"></i>
                                        </c:otherwise>
                                    </c:choose>
                                    <c:out value="${requestScope.routeThisMonthPercent}"/>% from last month
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-3 mb-4">
                        <div class="card stats-card">
                            <div class="stats-icon info">
                                <i class="fas fa-dollar-sign"></i>
                            </div>
                            <div class="stats-info">
                                <div class="stats-label">Total Revenue</div>
                                <h3 class="stats-value">$<c:out value="${requestScope.reThisMonth}"/>K</h3>
                                <div class="stats-change positive">
                                    <c:choose>
                                        <c:when test="${requestScope.reThisMonthSign eq '1'}">
                                            <i class="fas fa-arrow-up"></i>
                                        </c:when>
                                        <c:otherwise>
                                            <i class="fas fa-arrow-down"></i>
                                        </c:otherwise>
                                    </c:choose>
                                    <c:out value="${requestScope.reThisMonthPercent}"/>% from last month
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-lg-8 mb-4">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title">Ticket Sales Statistics</h5>
                                <div class="btn-group-toggle" id="ticketTimeToggle">
                                    <button class="btn active" data-period="week">Week</button>
                                    <button class="btn" data-period="month">Month</button>
                                    <button class="btn" data-period="year">Year</button>
                                </div>
                            </div>
                            <div class="card-body">
                                <div class="chart-container">
                                    <canvas id="ticketChart"></canvas>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 mb-4">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title">Train Distribution</h5>
                            </div>
                            <div class="card-body">
                                <div class="chart-container">
                                    <canvas id="demographicsChart"></canvas>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Revenue Statistics -->
                <div class="row">
                    <div class="col-12 mb-4">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title">Revenue Statistics</h5>
                                <div class="btn-group-toggle" id="revenueTimeToggle">
                                    <button class="btn active" data-period="week">Week</button>
                                    <button class="btn" data-period="month">Month</button>
                                    <button class="btn" data-period="year">Year</button>
                                </div>
                            </div>
                            <div class="card-body">
                                <div class="chart-container">
                                    <canvas id="revenueChart"></canvas>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="js/SellerDashboard.js"></script>
    </body>
</html>

