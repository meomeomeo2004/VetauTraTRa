<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Ticket Management</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="css/manageroutecss.css">
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
                <h2 class="page-title">Train Route Management</h2>
                <!-- Error Notification -->
                <c:if test="${not empty requestScope.editerror}">
                    <div class="alert-notification p-3 d-flex align-items-center" id="errorAlert">
                        <div class="alert-icon">
                            <i class="fas fa-exclamation-triangle"></i>
                        </div>
                        <div class="flex-grow-1">
                            <h5 class="mb-1">Operation Failed</h5>
                            <p class="mb-0">${requestScope.editerror}</p>
                        </div>
                        <div class="close-btn" onclick="closeErrorAlert()">
                            <i class="fas fa-times"></i>
                        </div>
                    </div>
                </c:if>
                <div class="card">
                    <div class="card-header">
                        <h5 class="card-title">Train Routes List</h5>
                        <div class="btn-group">
                            <a href="liststation" class="btn btn-success me-2">
                                <i class="fas fa-plus"></i> Add Route
                            </a>
                            <a href="ViewRouteDeleted" class="btn btn-danger">
                                <i class="fas fa-history"></i> Deleted History
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
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${listroute}" var="r" >
                                        <c:if test="${r.status != 4}">
                                        <tr>
                                            <td>${r.routeCode}</td>
                                            <td>${r.departureStation}</td>
                                            <td>${r.arrivalStation}</td>
                                            <td>${r.departureDate}</td>
                                            <td>${r.departureHour}</td>
                                            <td>${r.arrivalHour}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${r.status == 0}">
                                                        <span class="badge bg-danger">Inactive</span>
                                                    </c:when>
                                                    <c:when test="${r.status == 1}">
                                                        <span class="badge bg-success">Active</span>
                                                    </c:when>
                                                    <c:when test="${r.status == 2}">
                                                        <span class="badge bg-primary">In Transit</span>
                                                    </c:when>
                                                    <c:when test="${r.status == 3}">
                                                        <span class="badge bg-secondary">Completed</span>
                                                    </c:when>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <div class="action-buttons">
                                                    <!-- Add view details icon -->
                                                    <a href="ViewRouteDetails?routeid=${r.id}" class="btn btn-primary btn-icon" title="View Details">
                                                        <i class="fas fa-eye"></i>
                                                        
                                                    </a>
                                                    <c:if test="${r.status != 3 and r.status != 2}">
                                                    <a href="updateroute?routeid=${r.id}" class="btn btn-warning btn-icon" title="Update">
                                                        <i class="fas fa-edit"></i>
                                                    </a>      
                                                    <a href="deleteroute?routeid=${r.id}" class="btn btn-danger btn-icon" title="Delete" onclick="return confirm('Are you sure you want to delete this route?');">
                                                        <i class="fas fa-trash"></i>
                                                    </a>
                                                    </c:if>    
                                                </div>
                                            </td>
                                        </tr>
                                    <input type="hidden" name="arrivalDate" value="${r.arrivalDate}">
                                    <input type="hidden" name="departureTime" value="${r.departureTime}">
                                    <input type="hidden" name="arrivalTime" value="${r.arrivalTime}">
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
    // Auto-dismiss the error alert after 5 seconds
    if (document.getElementById('errorAlert')) {
        setTimeout(function() {
            closeErrorAlert();
        }, 5000);
    }
    
    // Function to close the error alert
    function closeErrorAlert() {
        const alert = document.getElementById('errorAlert');
        if (alert) {
            alert.style.opacity = '0';
            alert.style.transition = 'opacity 0.5s';
            setTimeout(function() {
                alert.style.display = 'none';
            }, 500);
        }
    }
</script>
    </body>
</html>

