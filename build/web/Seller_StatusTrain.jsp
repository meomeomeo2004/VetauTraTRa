<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Update Train Status - TraTra Ferry</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="css/mytrain.css">
        <style>
            .status-option {
                border: 2px solid #e0e0e0;
                border-radius: 8px;
                padding: 20px;
                margin-bottom: 20px;
                cursor: pointer;
                transition: all 0.3s ease;
            }
            .status-option:hover {
                border-color: #adb5bd;
                background-color: #f8f9fa;
            }
            .status-option.selected {
                border-color: #0d6efd;
                background-color: rgba(13, 110, 253, 0.1);
            }
            .status-option.maintenance {
                border-left: 5px solid #ffc107;
            }
            .status-option.inactive {
                border-left: 5px solid #dc3545;
            }
            .status-icon {
                font-size: 24px;
                margin-bottom: 10px;
            }
            .maintenance .status-icon {
                color: #ffc107;
            }
            .inactive .status-icon {
                color: #dc3545;
            }
            .train-info {
                background-color: #f8f9fa;
                border-radius: 8px;
                padding: 20px;
                margin-bottom: 30px;
            }
            .train-info h3 {
                margin-bottom: 20px;
                color: #212529;
                font-weight: 500;
            }
            .info-item {
                margin-bottom: 15px;
            }
            .info-label {
                font-weight: 500;
                color: #6c757d;
            }
            .info-value {
                font-weight: 600;
                color: #212529;
            }
            .action-buttons {
                margin-top: 30px;
            }

            .status-option.active {
                border-left: 5px solid #0d6efd;
            }

        </style>
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
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2 class="page-title">Update Train Status</h2>
                    <a href="ViewAllTrain" class="btn btn-outline-secondary">
                        <i class="fas fa-arrow-left me-2"></i>Back to Trains
                    </a>
                </div>

                <div class="card">
                    <div class="card-body">
                        <div class="train-info">
                            <h3>Train Information</h3>

                            <div class="row">
                                <div class="col-md-6">
                                    <div class="info-item">
                                        <div class="info-label">Train ID</div>
                                        <div class="info-value">${train.id}</div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="info-item">
                                        <div class="info-label">Train Model</div>
                                        <div class="info-value">${train.trainid}</div>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6">
                                    <div class="info-item">
                                        <div class="info-label">Current Status</div>
                                        <div class="info-value">
                                            <c:choose>
                                                <c:when test="${train.status == 1}">
                                                    <span class="status-badge status-active">Active</span>
                                                </c:when>
                                                <c:when test="${train.status == 2}">
                                                    <span class="status-badge status-maintenance">Maintenance</span>
                                                </c:when>
                                                <c:when test="${train.status == 0 || train.status == 3}">
                                                    <span class="status-badge status-inactive">Inactive</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="status-badge">Unknown</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>

                        <form action="UpdateStatusRoute" method="POST">
                            <input type="hidden" name="trainId" value="${train.id}">

                            <h4 class="mb-4">Select New Status</h4>

                            <div class="row">
                                <c:choose>
                                    <c:when test="${train.status == 1}">
                                        <div class="col-md-6">
                                            <div class="status-option maintenance" onclick="selectStatus(this, 2)">
                                                <div class="status-icon">
                                                    <i class="fas fa-wrench"></i>
                                                </div>
                                                <h5>Maintenance</h5>
                                                <p class="text-muted">Set train to maintenance mode. The train will not be available for scheduling.</p>
                                                <div class="form-check mt-3">
                                                    <input class="form-check-input status-radio" type="radio" name="status" id="maintenance" value="2">
                                                    <label class="form-check-label" for="maintenance">
                                                        Select Maintenance Status
                                                    </label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="status-option inactive" onclick="selectStatus(this, 0)">
                                                <div class="status-icon">
                                                    <i class="fas fa-power-off"></i>
                                                </div>
                                                <h5>Inactive</h5>
                                                <p class="text-muted">Deactivate this train. It will be completely removed from service.</p>
                                                <div class="form-check mt-3">
                                                    <input class="form-check-input status-radio" type="radio" name="status" id="inactive" value="0">
                                                    <label class="form-check-label" for="inactive">
                                                        Select Inactive Status
                                                    </label>
                                                </div>
                                            </div>
                                        </div>
                                    </c:when>

                                   
                                    <c:when test="${train.status == 0}">
                                        <div class="col-md-6">
                                            <div class="status-option maintenance" onclick="selectStatus(this, 2)">
                                                <div class="status-icon">
                                                    <i class="fas fa-wrench"></i>
                                                </div>
                                                <h5>Maintenance</h5>
                                                <p class="text-muted">Set train to maintenance mode. The train will not be available for scheduling.</p>
                                                <div class="form-check mt-3">
                                                    <input class="form-check-input status-radio" type="radio" name="status" id="maintenance" value="2">
                                                    <label class="form-check-label" for="maintenance">
                                                        Select Maintenance Status
                                                    </label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="status-option active" onclick="selectStatus(this, 1)">
                                                <div class="status-icon">
                                                    <i class="fas fa-check"></i>
                                                </div>
                                                <h5>Active</h5>
                                                <p class="text-muted">Activate this train. The train will be available for scheduling.</p>
                                                <div class="form-check mt-3">
                                                    <input class="form-check-input status-radio" type="radio" name="status" id="active" value="1">
                                                    <label class="form-check-label" for="active">
                                                        Select Active Status
                                                    </label>
                                                </div>
                                            </div>
                                        </div>
                                    </c:when>

                                   
                                    <c:when test="${train.status == 2}">
                                        <div class="col-md-6">
                                            <div class="status-option active" onclick="selectStatus(this, 1)">
                                                <div class="status-icon">
                                                    <i class="fas fa-check"></i>
                                                </div>
                                                <h5>Active</h5>
                                                <p class="text-muted">Activate this train. The train will be available for scheduling.</p>
                                                <div class="form-check mt-3">
                                                    <input class="form-check-input status-radio" type="radio" name="status" id="active" value="1">
                                                    <label class="form-check-label" for="active">
                                                        Select Active Status
                                                    </label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="status-option inactive" onclick="selectStatus(this, 0)">
                                                <div class="status-icon">
                                                    <i class="fas fa-power-off"></i>
                                                </div>
                                                <h5>Inactive</h5>
                                                <p class="text-muted">Deactivate this train. It will be completely removed from service.</p>
                                                <div class="form-check mt-3">
                                                    <input class="form-check-input status-radio" type="radio" name="status" id="inactive" value="0">
                                                    <label class="form-check-label" for="inactive">
                                                        Select Inactive Status
                                                    </label>
                                                </div>
                                            </div>
                                        </div>
                                    </c:when>
                                </c:choose>
                            </div>
                            <div class="action-buttons">
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-save me-2"></i>Update Status
                                </button>
                                <a href="ViewAllTrain" class="btn btn-outline-secondary ms-2">
                                    Cancel
                                </a>
                            </div>
                        </form>

                    </div>
                </div>
            </main>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                                                function selectStatus(element, value) {
                                                    // Remove selected class from all options
                                                    document.querySelectorAll('.status-option').forEach(option => {
                                                        option.classList.remove('selected');
                                                    });

                                                    // Add selected class to clicked option
                                                    element.classList.add('selected');

                                                    // Check the corresponding radio button
                                                    document.querySelector(`input[value="${value}"]`).checked = true;
                                                }

                                                // Initialize - check if a status is already selected (e.g., when returning to the page)
                                                document.addEventListener('DOMContentLoaded', function () {
                                                    const checkedRadio = document.querySelector('.status-radio:checked');
                                                    if (checkedRadio) {
                                                        const statusOption = checkedRadio.closest('.status-option');
                                                        if (statusOption) {
                                                            statusOption.classList.add('selected');
                                                        }
                                                    }
                                                });
        </script>
    </body>
</html>