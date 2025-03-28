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
                        <a href="#" class="nav-link">
                            <i class="fas fa-calendar-alt"></i>
                            <span>Schedules</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="ViewAllTrain" class="nav-link">
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
                        <a href="seller-profile" class="nav-link">
                            <i class="fas fa-user-circle"></i>
                            <span>Account Info</span>
                        </a>
                    </li>
                    <li><a class="dropdown-item text-danger" href="./logout"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
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
                                <h3 class="stats-value">3,845</h3>
                                <div class="stats-change positive">
                                    <i class="fas fa-arrow-up"></i> 12.5% from last month
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
                                <h3 class="stats-value">12,721</h3>
                                <div class="stats-change positive">
                                    <i class="fas fa-arrow-up"></i> 8.3% from last month
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
                                <h3 class="stats-value">87</h3>
                                <div class="stats-change positive">
                                    <i class="fas fa-arrow-up"></i> 5.2% from last month
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
                                <h3 class="stats-value">$256,890</h3>
                                <div class="stats-change positive">
                                    <i class="fas fa-arrow-up"></i> 15.7% from last month
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Customer Statistics -->
                <div class="row">
                    <div class="col-lg-8 mb-4">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title">Customer Statistics</h5>
                                <div class="btn-group-toggle" id="customerTimeToggle">
                                    <button class="btn active" data-period="day">Daily</button>
                                    <button class="btn" data-period="week">Weekly</button>
                                    <button class="btn" data-period="month">Monthly</button>
                                </div>
                            </div>
                            <div class="card-body">
                                <div class="chart-container">
                                    <canvas id="customerChart"></canvas>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 mb-4">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title">Customer Demographics</h5>
                            </div>
                            <div class="card-body">
                                <div class="chart-container">
                                    <canvas id="demographicsChart"></canvas>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Train Model Popularity -->
                <div class="row">
                    <div class="col-lg-6 mb-4">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title">Train Model Popularity</h5>
                            </div>
                            <div class="card-body">
                                <div class="chart-container">
                                    <canvas id="trainModelChart"></canvas>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6 mb-4">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title">Popular Train Models</h5>
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th>Model</th>
                                                <th>Customers</th>
                                                <th>Popularity</th>
                                                <th>Trend</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td>Express 2000</td>
                                                <td>1,245</td>
                                                <td>
                                                    <div class="progress">
                                                        <div class="progress-bar progress-bar-primary" style="width: 85%"></div>
                                                    </div>
                                                </td>
                                                <td><span class="text-success"><i class="fas fa-arrow-up"></i> 12%</span></td>
                                            </tr>
                                            <tr>
                                                <td>Bullet X500</td>
                                                <td>987</td>
                                                <td>
                                                    <div class="progress">
                                                        <div class="progress-bar progress-bar-success" style="width: 72%"></div>
                                                    </div>
                                                </td>
                                                <td><span class="text-success"><i class="fas fa-arrow-up"></i> 8%</span></td>
                                            </tr>
                                            <tr>
                                                <td>Commuter 350</td>
                                                <td>876</td>
                                                <td>
                                                    <div class="progress">
                                                        <div class="progress-bar progress-bar-warning" style="width: 65%"></div>
                                                    </div>
                                                </td>
                                                <td><span class="text-success"><i class="fas fa-arrow-up"></i> 5%</span></td>
                                            </tr>
                                            <tr>
                                                <td>Metro 100</td>
                                                <td>654</td>
                                                <td>
                                                    <div class="progress">
                                                        <div class="progress-bar progress-bar-info" style="width: 48%"></div>
                                                    </div>
                                                </td>
                                                <td><span class="text-danger"><i class="fas fa-arrow-down"></i> 3%</span></td>
                                            </tr>
                                            <tr>
                                                <td>Cargo 750</td>
                                                <td>432</td>
                                                <td>
                                                    <div class="progress">
                                                        <div class="progress-bar progress-bar-danger" style="width: 32%"></div>
                                                    </div>
                                                </td>
                                                <td><span class="text-success"><i class="fas fa-arrow-up"></i> 2%</span></td>
                                            </tr>
                                        </tbody>
                                    </table>
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
                                    <button class="btn active" data-period="week">Weekly</button>
                                    <button class="btn" data-period="month">Monthly</button>
                                    <button class="btn" data-period="year">Yearly</button>
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

                <!-- Top Routes -->
                <div class="row">
                    <div class="col-12 mb-4">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title">Top Performing Routes</h5>
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th>Route</th>
                                                <th>Departure</th>
                                                <th>Arrival</th>
                                                <th>Tickets Sold</th>
                                                <th>Revenue</th>
                                                <th>Occupancy Rate</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td>RT-1001</td>
                                                <td>Hanoi</td>
                                                <td>Ho Chi Minh City</td>
                                                <td>1,245</td>
                                                <td>$45,678</td>
                                                <td>
                                                    <div class="progress">
                                                        <div class="progress-bar progress-bar-primary" style="width: 92%"></div>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>RT-1002</td>
                                                <td>Da Nang</td>
                                                <td>Hue</td>
                                                <td>987</td>
                                                <td>$32,456</td>
                                                <td>
                                                    <div class="progress">
                                                        <div class="progress-bar progress-bar-success" style="width: 85%"></div>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>RT-1003</td>
                                                <td>Ho Chi Minh City</td>
                                                <td>Nha Trang</td>
                                                <td>876</td>
                                                <td>$28,765</td>
                                                <td>
                                                    <div class="progress">
                                                        <div class="progress-bar progress-bar-warning" style="width: 78%"></div>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>RT-1004</td>
                                                <td>Hanoi</td>
                                                <td>Hai Phong</td>
                                                <td>654</td>
                                                <td>$21,543</td>
                                                <td>
                                                    <div class="progress">
                                                        <div class="progress-bar progress-bar-info" style="width: 65%"></div>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>RT-1005</td>
                                                <td>Vinh</td>
                                                <td>Thanh Hoa</td>
                                                <td>432</td>
                                                <td>$15,432</td>
                                                <td>
                                                    <div class="progress">
                                                        <div class="progress-bar progress-bar-danger" style="width: 52%"></div>
                                                    </div>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            // Customer Statistics Chart
            const customerCtx = document.getElementById('customerChart').getContext('2d');
            const customerChart = new Chart(customerCtx, {
                type: 'line',
                data: {
                    labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
                    datasets: [{
                            label: 'Customers',
                            data: [320, 345, 385, 410, 450, 480, 520, 550, 590, 620, 670, 720],
                            borderColor: '#4361ee',
                            backgroundColor: 'rgba(67, 97, 238, 0.1)',
                            tension: 0.3,
                            fill: true
                        }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            display: false
                        }
                    },
                    scales: {
                        y: {
                            beginAtZero: true,
                            grid: {
                                drawBorder: false
                            }
                        },
                        x: {
                            grid: {
                                display: false
                            }
                        }
                    }
                }
            });

            // Demographics Chart
            const demographicsCtx = document.getElementById('demographicsChart').getContext('2d');
            const demographicsChart = new Chart(demographicsCtx, {
                type: 'doughnut',
                data: {
                    labels: ['Adults', 'Seniors', 'Students', 'Children'],
                    datasets: [{
                            data: [45, 20, 25, 10],
                            backgroundColor: [
                                '#4361ee',
                                '#3a0ca3',
                                '#7209b7',
                                '#f72585'
                            ],
                            borderWidth: 0
                        }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            position: 'bottom'
                        }
                    },
                    cutout: '70%'
                }
            });

            // Train Model Chart
            const trainModelCtx = document.getElementById('trainModelChart').getContext('2d');
            const trainModelChart = new Chart(trainModelCtx, {
                type: 'bar',
                data: {
                    labels: ['Express 2000', 'Bullet X500', 'Commuter 350', 'Metro 100', 'Cargo 750'],
                    datasets: [{
                            label: 'Customers',
                            data: [1245, 987, 876, 654, 432],
                            backgroundColor: [
                                '#4361ee',
                                '#2a9d8f',
                                '#ff9f1c',
                                '#4cc9f0',
                                '#e63946'
                            ],
                            borderWidth: 0,
                            borderRadius: 4
                        }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            display: false
                        }
                    },
                    scales: {
                        y: {
                            beginAtZero: true,
                            grid: {
                                drawBorder: false
                            }
                        },
                        x: {
                            grid: {
                                display: false
                            }
                        }
                    }
                }
            });

            // Revenue Chart
            const revenueCtx = document.getElementById('revenueChart').getContext('2d');
            const revenueChart = new Chart(revenueCtx, {
                type: 'line',
                data: {
                    labels: ['Week 1', 'Week 2', 'Week 3', 'Week 4'],
                    datasets: [{
                            label: 'Revenue',
                            data: [45678, 52456, 48765, 56789],
                            borderColor: '#2a9d8f',
                            backgroundColor: 'rgba(42, 157, 143, 0.1)',
                            tension: 0.3,
                            fill: true
                        }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            display: false
                        }
                    },
                    scales: {
                        y: {
                            beginAtZero: true,
                            grid: {
                                drawBorder: false
                            },
                            ticks: {
                                callback: function (value) {
                                    return '$' + value.toLocaleString();
                                }
                            }
                        },
                        x: {
                            grid: {
                                display: false
                            }
                        }
                    }
                }
            });

            // Toggle buttons for customer statistics
            document.querySelectorAll('#customerTimeToggle .btn').forEach(button => {
                button.addEventListener('click', function () {
                    document.querySelectorAll('#customerTimeToggle .btn').forEach(btn => {
                        btn.classList.remove('active');
                    });
                    this.classList.add('active');

                    const period = this.getAttribute('data-period');
                    let labels, data;

                    if (period === 'day') {
                        labels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                        data = [42, 38, 45, 50, 55, 65, 60];
                    } else if (period === 'week') {
                        labels = ['Week 1', 'Week 2', 'Week 3', 'Week 4'];
                        data = [180, 195, 210, 225];
                    } else if (period === 'month') {
                        labels = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
                        data = [320, 345, 385, 410, 450, 480, 520, 550, 590, 620, 670, 720];
                    }

                    customerChart.data.labels = labels;
                    customerChart.data.datasets[0].data = data;
                    customerChart.update();
                });
            });

            // Toggle buttons for revenue statistics
            document.querySelectorAll('#revenueTimeToggle .btn').forEach(button => {
                button.addEventListener('click', function () {
                    document.querySelectorAll('#revenueTimeToggle .btn').forEach(btn => {
                        btn.classList.remove('active');
                    });
                    this.classList.add('active');

                    const period = this.getAttribute('data-period');
                    let labels, data;

                    if (period === 'week') {
                        labels = ['Week 1', 'Week 2', 'Week 3', 'Week 4'];
                        data = [45678, 52456, 48765, 56789];
                    } else if (period === 'month') {
                        labels = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
                        data = [42000, 45000, 48000, 52000, 56000, 60000, 65000, 68000, 72000, 75000, 78000, 82000];
                    } else if (period === 'year') {
                        labels = ['2019', '2020', '2021', '2022', '2023'];
                        data = [450000, 520000, 580000, 650000, 720000];
                    }

                    revenueChart.data.labels = labels;
                    revenueChart.data.datasets[0].data = data;
                    revenueChart.update();
                });
            });
        </script>
    </body>
</html>

