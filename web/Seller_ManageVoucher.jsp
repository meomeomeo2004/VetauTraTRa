<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Voucher Management</title>
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
                        <a href="ViewListVoucher" class="nav-link active">
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
                <!-- Success notifications -->
                <c:if test="${not empty addsucess}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert" id="successAlert">
                        <strong>Success!</strong> ${addsucess}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close" onclick="closeSuccessAlert()"></button>
                    </div>
                </c:if>
                <c:if test="${not empty editsucess}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert" id="successAlert">
                        <strong>Success!</strong> ${editsucess}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close" onclick="closeSuccessAlert()"></button>
                    </div>
                </c:if>
                <c:if test="${not empty delsucess}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert" id="successAlert">
                        <strong>Success!</strong> ${delsucess}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close" onclick="closeSuccessAlert()"></button>
                    </div>
                </c:if>
                <h2 class="page-title">Voucher Management</h2>

                <div class="card">
                    <div class="card-header">
                        <h5 class="card-title">Vouchers List</h5>
                        <div class="btn-group">
                            <a href="VoucherAdd" class="btn btn-success me-2">
                                <i class="fas fa-plus"></i> Add Voucher
                            </a>
                            <a href="ViewVoucherHistory" class="btn btn-danger">
                                <i class="fas fa-history"></i> Deleted History
                            </a>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="row mb-3">
                            <div class="col-md-6 mb-2 mb-md-0">
                                <div class="d-flex align-items-center">
                                    <label for="statusFilter" class="me-2">Status:</label>
                                    <select id="statusFilter" class="form-select form-select-sm" style="width: auto;">
                                        <option value="all">All</option>
                                        <option value="1">Active</option>
                                        <option value="2">Expired</option>
                                        <option value="0">Coming</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="input-group">
                                    <input type="text" id="searchInput" class="form-control" placeholder="Search by voucher code...">
                                    <button class="btn btn-outline-secondary" type="button" id="searchBtn">
                                        <i class="fas fa-search"></i>
                                    </button>
                                </div>
                            </div>
                        </div>

                        <div class="table-responsive">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th>Code</th>
                                        <th>Discount</th>
                                        <th>Valid From</th>
                                        <th>Valid To</th>
                                        <th>Quantity</th>
                                        <th>Status</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${listvoucher}" var="v">
                                        <c:if test = "${v.status != 3}">
                                        <fmt:formatDate value="${v.validFrom}" pattern="yyyy-MM-dd HH:mm" var="validFromFormatted" />
                                        <fmt:formatDate value="${v.validTo}" pattern="yyyy-MM-dd HH:mm" var="validToFormatted" />

                                        <tr>
                                            <td>${v.code}</td>
                                            <td><fmt:formatNumber value="${v.discountAmount}" pattern="#,###" /></td>
                                            <td>
                                                ${validFromFormatted}
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${v.validTo == null}">
                                                        Non-Expiring
                                                    </c:when>
                                                    <c:otherwise>
                                                        ${validToFormatted}
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>${v.quantity}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${v.status == '1'}">
                                                        <span class="badge bg-success">Active</span>
                                                    </c:when>
                                                    <c:when test="${v.status == '2'}">
                                                        <span class="badge bg-danger">Expired</span>
                                                    </c:when>
                                                    <c:when test="${v.status == '0'}">
                                                        <span class="badge bg-warning">Coming</span>
                                                    </c:when>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <div class="action-buttons">
                                                    <a href="VoucherEdit?id=${v.id}" class="btn btn-warning btn-icon" title="Edit">
                                                        <i class="fas fa-edit"></i>
                                                    </a>
                                                    <a href="VoucherDelete?id=${v.id}" class="btn btn-danger btn-icon" title="Delete" onclick="return confirm('Are you sure you want to delete this voucher?');">
                                                        <i class="fas fa-trash"></i>
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
            </main>

        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                                                        // Auto-dismiss the error alert after 5 seconds
                                                        if (document.getElementById('errorAlert')) {
                                                            setTimeout(function () {
                                                                closeErrorAlert();
                                                            }, 5000);
                                                        }

                                                        // Function to close the error alert
                                                        function closeErrorAlert() {
                                                            const alert = document.getElementById('errorAlert');
                                                            if (alert) {
                                                                alert.style.opacity = '0';
                                                                alert.style.transition = 'opacity 0.5s';
                                                                setTimeout(function () {
                                                                    alert.style.display = 'none';
                                                                }, 500);
                                                            }
                                                        }

                                                        // Status filter functionality
                                                        document.addEventListener('DOMContentLoaded', function () {
                                                            const statusFilter = document.getElementById('statusFilter');
                                                            const searchInput = document.getElementById('searchInput');
                                                            const searchBtn = document.getElementById('searchBtn');
                                                            const tableRows = document.querySelectorAll('table tbody tr');

                                                            // Filter by status (nếu cần chỉnh sửa thì bạn có thể thay đổi logic tại đây)
                                                            statusFilter.addEventListener('change', function () {
                                                                const selectedStatus = this.value;

                                                                tableRows.forEach(row => {
                                                                    const statusCell = row.querySelector('td:nth-child(6)');
                                                                    const statusText = statusCell.textContent.trim();

                                                                    if (selectedStatus === 'all' || statusText === selectedStatus) {
                                                                        row.style.display = '';
                                                                    } else {
                                                                        row.style.display = 'none';
                                                                    }
                                                                });
                                                            });

                                                            // Search by voucher code (không cần khớp chính xác)
                                                            const performSearch = function () {
                                                                const searchTerm = searchInput.value.toLowerCase();

                                                                tableRows.forEach(row => {
                                                                    // Lấy ô chứa mã voucher (cột đầu tiên)
                                                                    const codeCell = row.querySelector('td:nth-child(1)');
                                                                    if (codeCell) {
                                                                        const codeText = codeCell.textContent.toLowerCase();
                                                                        if (codeText.includes(searchTerm)) {
                                                                            row.style.display = '';
                                                                        } else {
                                                                            row.style.display = 'none';
                                                                        }
                                                                    }
                                                                });
                                                            };

                                                            searchBtn.addEventListener('click', performSearch);
                                                            searchInput.addEventListener('keyup', function (e) {
                                                                if (e.key === 'Enter') {
                                                                    performSearch();
                                                                }
                                                            });
                                                        });
                                                        // Function to close the success alert
                                                        function closeSuccessAlert() {
                                                            const alert = document.getElementById('successAlert');
                                                            if (alert) {
                                                                alert.style.opacity = '0';
                                                                alert.style.transition = 'opacity 0.5s';
                                                                setTimeout(function () {
                                                                    alert.style.display = 'none';
                                                                }, 500);
                                                            }
                                                        }

                                                        // Auto-dismiss the success alert after 5 seconds
                                                        if (document.getElementById('successAlert')) {
                                                            setTimeout(function () {
                                                                closeSuccessAlert();
                                                            }, 5000);
                                                        }
        </script>
    </body>
</html>

