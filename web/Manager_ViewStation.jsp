<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Station Management</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="css/managetraincss.css">
        <style>
            .custom-alert {
                background-color: #fff;
                transition: all 0.3s ease;
            }
            .custom-alert:hover {
                transform: translateY(-2px);
            }
            .btn-close:focus {
                box-shadow: none;
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
                        <span>Manage Seller</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="listtrain" class="nav-link">
                        <i class="fas fa-subway"></i>
                        <span>Manage Trains</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="ViewListStation" class="nav-link active">
                        <i class="fas fa-route"></i>
                        <span>Manage Station</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="manager-profile" class="nav-link">
                        <i class="fas fa-user-circle"></i>
                        <span>Account</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="./logout" class="nav-link text-danger">
                        <i class="fas fa-sign-out-alt"></i>
                        <span>Logout</span>
                    </a>
                </li>
            </ul>
        </aside>

        <main class="content">
            <h2 class="page-title"><i class="fas fa-route"></i> Station Management</h2>
            <c:if test="${not empty message}">
                <div class="alert custom-alert shadow-sm border-start border-success border-4 rounded-3 p-3 mb-4" id="difAlert">
                    <div class="d-flex align-items-center">
                        <div class="alert-icon me-3">
                            <i class="fas fa-check-circle text-success fs-4"></i>
                        </div>
                        <div class="flex-grow-1">
                            <h5 class="fw-bold mb-1 text-success">Success</h5>
                            <p class="mb-0 text-secondary">${message}</p>
                        </div>
                        <button type="button" class="btn-close" onclick="document.getElementById('difAlert').remove()" aria-label="Close"></button>
                    </div>
                </div>
            </c:if>
            <div class="card">
                <div class="card-header">
                    <h5 class="card-title">Station Network</h5>
                    <div class="d-flex gap-2">
                        <a href="AddStation" class="btn btn-primary">
                            <i class="fas fa-plus"></i> Add New Station
                        </a>
                        <a href="pendingStations" class="btn btn-secondary">
                            <i class="fas fa-clock"></i> Pending Approval
                        </a>
                    </div>
                </div>
                <div class="card-body">
                    <div class="filter-section">
                        <form action="FilterStation" method="get" id="filterForm">
                            <div class="row">
                                <div class="col-md-4 mb-3 mb-md-0">
                                    <label for="stationName" class="form-label">Station Name</label>
                                    <input type="text" name="stationName" id="stationName" class="form-control" 
                                           placeholder="Enter station name" value="${param.stationName}">
                                </div>
                                <div class="col-md-4 d-flex align-items-end gap-2">
                                    <button type="submit" class="btn btn-primary flex-grow-1">
                                        <i class="fas fa-search"></i> Search
                                    </button>
                                    <button type="button" id="resetFilter" class="btn btn-secondary">
                                        <i class="fas fa-undo"></i> Reset
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
                                    <th>Station Name</th>
                                    <th>Address</th>
                                    <th>Phone Number</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${liststation}" var="s">
                                    <tr>
                                        <td>${s.id}</td>
                                        <td>${s.name}</td>
                                        <td>${s.address}</td>
                                        <td>${s.phone}</td>
                                        <td> Contact </td>
                                    </tr>                                  
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </main>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                            function closeSuccessAlert() {
                                document.getElementById("successAlert").style.display = "none";
                            }
                            setTimeout(() => {
                                const successAlert = document.getElementById("successAlert");
                                if (successAlert)
                                    successAlert.style.display = "none";
                            }, 3000);
                            // Function to filter stations by name
                            function filterStationsByName() {
                                // Get the input value and convert to lowercase for case-insensitive comparison
                                const nameFilter = document.getElementById('stationName').value.toLowerCase();
                                const table = document.querySelector('.table');
                                const rows = table.querySelectorAll('tbody tr');

                                // Loop through all table rows
                                rows.forEach(row => {
                                    const stationNameCell = row.cells[1]; // Station Name is in the second column (index 1)
                                    if (stationNameCell) {
                                        const stationName = stationNameCell.textContent.toLowerCase();

                                        // Show row if the station name contains the filter text, hide it otherwise
                                        if (stationName.includes(nameFilter)) {
                                            row.style.display = '';
                                        } else {
                                            row.style.display = 'none';
                                        }
                                    }
                                });
                            }

// Function to reset the filter and show all stations
                            function resetFilter() {
                                document.getElementById('stationName').value = '';
                                document.getElementById('stationCode').selectedIndex = 0;

                                const rows = document.querySelectorAll('.table tbody tr');
                                rows.forEach(row => {
                                    row.style.display = '';
                                });
                            }

// Add event listener when the document is loaded
                            document.addEventListener('DOMContentLoaded', function () {
                                // Add input event listener to the station name field for real-time filtering
                                const stationNameInput = document.getElementById('stationName');
                                if (stationNameInput) {
                                    stationNameInput.addEventListener('input', filterStationsByName);
                                }

                                // Add reset button functionality
                                const resetButton = document.getElementById('resetFilter');
                                if (resetButton) {
                                    resetButton.addEventListener('click', resetFilter);
                                }
                            });
        </script>        
    </body>
</html>