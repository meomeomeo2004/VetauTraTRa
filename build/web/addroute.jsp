<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Add Train Route</title>
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
                display: flex;
                justify-content: center;
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
                width: 100%;
                max-width: 900px;
            }

            .card-header {
                background-color: white;
                border-bottom: 1px solid var(--gray-200);
                padding: 1.25rem 1.5rem;
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

            .form-label {
                font-weight: 500;
                color: var(--gray-700);
                margin-bottom: 0.5rem;
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
                box-shadow: 0 0 0 0.25rem rgba(67, 97, 238, 0.15);
            }

            .form-control::placeholder {
                color: var(--gray-500);
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

            .form-group {
                margin-bottom: 1.5rem;
            }

            .form-text {
                color: var(--gray-600);
                font-size: 0.875rem;
                margin-top: 0.25rem;
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
            }

            @media (max-width: 576px) {
                .header {
                    padding: 1rem;
                }
                
                .content {
                    padding: 1rem;
                }
                
                .card-body {
                    padding: 1rem;
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
                <div class="card">
                    <div class="card-header">
                        <h5 class="card-title">Add New Train Route</h5>
                    </div>
                    <div class="card-body">
                        <form action="AddRoute" method="POST">
                            <div class="row mb-4">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="trainid" class="form-label">Train Type</label>
                                        <select class="form-select" id="trainid" name="trainid" required>
                                            <option value="" selected disabled>Select train type</option>
                                            <c:forEach items="${listtrain}" var="t">
                                                <option value="${t.id}">${t.trainid}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="routecode" class="form-label">Route Code</label>
                                        <input type="text" class="form-control" id="routecode" name="routecode" placeholder="Enter route code" required>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="form-group mb-4">
                                <label for="description" class="form-label">Description</label>
                                <textarea class="form-control" id="description" name="description" rows="3" placeholder="Enter route description"></textarea>
                            </div>
                            
                            <div class="row mb-4">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="departureDateTime" class="form-label">Departure Date & Time</label>
                                        <input type="datetime-local" class="form-control" id="departureDateTime" name="departureDateTime" required>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="returnDateTime" class="form-label">Arrival Date & Time</label>
                                        <input type="datetime-local" class="form-control" id="returnDateTime" name="returnDateTime" required>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="row mb-4">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="departureStation" class="form-label">Departure Station</label>
                                        <select class="form-select" id="departureStation" name="departureStation" required>
                                            <option value="" selected disabled>Select station</option>
                                            <c:forEach items="${liststation}" var="o">
                                                <option value="${o.id}">${o.name}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="arrivalStation" class="form-label">Arrival Station</label>
                                        <select class="form-select" id="arrivalStation" name="arrivalStation" required>
                                            <option value="" selected disabled>Select station</option>
                                            <c:forEach items="${liststation}" var="o">
                                                <option value="${o.id}">${o.name}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="d-flex justify-content-end gap-2 mt-4">
                                <button type="button" class="btn btn-danger" onclick="window.location.href='viewlistroute'">
                                    <i class="fas fa-times"></i> Cancel
                                </button>
                                <button type="submit" class="btn btn-success">
                                    <i class="fas fa-plus"></i> Add Route
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </main>
        </div>
        
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>

