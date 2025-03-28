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
        <link rel="stylesheet" type="text/css" href="css/managetraincss.css">
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
                    <a href="manager-profile" class="nav-link">
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
                                                <div class="status-badge status-active">
                                                    <i class="fas fa-check-circle"></i>
                                                    <span>Active</span>
                                                </div>
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
                                    <c:if test="${t.status == 2}">
                                        <tr>
                                            <td>${t.id}</td>
                                            <td><strong>${t.trainid}</strong></td>
                                            <td>${t.totalSeats}</td>
                                            <td>${t.numCabin}</td>
                                            <td>
                                                <div class="status-badge status-maintenance">
                                                    <i class="fas fa-exclamation-triangle"></i>
                                                    <span>Maintenance</span>
                                                </div>
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
                                    <c:if test="${t.status == 0}">
                                        <tr>
                                            <td>${t.id}</td>
                                            <td><strong>${t.trainid}</strong></td>
                                            <td>${t.totalSeats}</td>
                                            <td>${t.numCabin}</td>
                                            <td>
                                                <div class="status-badge status-inactive">
                                                    <i class="fas fa-times-circle"></i>
                                                    <span>Inactive</span>
                                                </div>
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

