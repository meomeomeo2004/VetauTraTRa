<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Add Voucher</title>
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
                        <a href="Seller_ManageVoucher.jsp" class="nav-link active">
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
                <h2 class="page-title">Add New Voucher</h2>

                <!-- Error Notification -->
                <c:if test="${not empty requestScope.error}">
                    <div class="alert-notification p-3 d-flex align-items-center" id="errorAlert">
                        <div class="alert-icon">
                            <i class="fas fa-exclamation-triangle"></i>
                        </div>
                        <div class="flex-grow-1">
                            <h5 class="mb-1">Operation Failed</h5>
                            <p class="mb-0">${requestScope.error}</p>
                        </div>
                        <div class="close-btn" onclick="closeErrorAlert()">
                            <i class="fas fa-times"></i>
                        </div>
                    </div>
                </c:if>

                <div class="card">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <h5 class="card-title">Voucher Information</h5>
                        <a href="ViewListVoucher" class="btn btn-secondary">
                            <i class="fas fa-arrow-left me-1"></i> Back to Vouchers
                        </a>
                    </div>
                    <div class="card-body">
                        <form action="VoucherAdd" method="post" id="addVoucherForm">
                            <div class="row mb-4">
                                <div class="col-md-6">
                                    <label for="code" class="form-label">Voucher Code <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" id="code" name="code" required>
                                    <div class="form-text">Unique code for the voucher (e.g., SUMMER2023)</div>
                                </div>

                                <div class="col-md-6">
                                    <label for="discountAmount" class="form-label">Discount Amount (VND) <span class="text-danger">*</span></label>
                                    <input type="number" class="form-control" id="discountAmount" name="discountAmount" min="10000" step="1000" required>
                                    <div class="form-text">Fixed discount amount (minimum 10,000 VND)</div>
                                </div>
                            </div>

                            <div class="row mb-4">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="validFrom" class="form-label">Valid From <span class="text-danger">*</span></label>
                                        <input type="datetime-local" class="form-control" id="validFrom" name="validFrom" required>
                                        <div class="form-text">Start date and time when the voucher becomes valid</div>
                                    </div>
                                </div>

                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="validTo" class="form-label">Valid To <span class="text-danger">*</span></label>
                                        <input type="datetime-local" class="form-control" id="validTo" name="validTo" required>
                                        <div class="form-text">End date and time when the voucher expires</div>
                                    </div>
                                </div>
                            </div>

                            <div class="row mb-4">
                                <div class="col-md-6">
                                    <label for="quantity" class="form-label">Quantity <span class="text-danger">*</span></label>
                                    <input type="number" class="form-control" id="quantity" name="quantity" min="1" value="1" required>
                                    <div class="form-text">Number of vouchers available</div>
                                </div>
                            </div>

                            <div class="d-flex justify-content-end gap-2 mt-4">
                                <button type="button" class="btn btn-secondary" onclick="window.location.href = 'Seller_ManageVoucher.jsp'">Cancel</button>
                                <button type="submit" class="btn btn-success">Create Voucher</button>
                            </div>
                        </form>
                    </div>
                </div>
            </main>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                                    document.addEventListener('DOMContentLoaded', function () {
                                        // Lấy các phần tử cần thiết từ form
                                        const validFrom = document.getElementById('validFrom');
                                        const validTo = document.getElementById('validTo');
                                        const discountAmount = document.getElementById('discountAmount');
                                        const quantity = document.getElementById('quantity');
                                        const form = document.getElementById('addVoucherForm');

                                        // Hàm định dạng Date theo "yyyy-MM-ddTHH:mm"
                                        const formatDatetime = (date) => {
                                            return date.toISOString().slice(0, 16);
                                        };

                                        // Lấy thời gian hiện tại
                                        const now = new Date();
                                        // Tính validFrom: hiện tại + 10 phút
                                        const validFromDate = new Date(now.getTime() + 10 * 60000 + 7 * 3600000);

                                        validFrom.value = formatDatetime(validFromDate);
                                        validFrom.min = formatDatetime(validFromDate);

                                        // Thiết lập validTo: mặc định là validFrom + 5 phút
                                        const validToDate = new Date(validFromDate.getTime() + 5 * 60000);
                                        validTo.value = formatDatetime(validToDate);
                                        validTo.min = formatDatetime(validToDate);

                                        // Khi validFrom thay đổi, cập nhật min của validTo
                                        validFrom.addEventListener('change', function () {
                                            const selectedValidFrom = new Date(validFrom.value);
                                            // Cập nhật min cho validTo: phải lớn hơn validFrom (ở đây mặc định là validFrom + 5 phút)
                                            const newValidToMin = new Date(selectedValidFrom.getTime() + 5 * 60000);
                                            validTo.min = formatDatetime(newValidToMin);
                                            // Nếu giá trị hiện tại của validTo không thỏa, cập nhật lại
                                            if (new Date(validTo.value) <= selectedValidFrom) {
                                                validTo.value = formatDatetime(newValidToMin);
                                            }
                                        });

                                        // Xử lý sự kiện submit của form
                                        form.addEventListener('submit', function (event) {
                                            const currentTime = new Date();
                                            const validFromTime = new Date(validFrom.value);
                                            const validToTime = new Date(validTo.value);

                                            // Kiểm tra validFrom phải ít nhất là hiện tại + 10 phút
                                            if (validFromTime < new Date(currentTime.getTime() + 10 * 60000)) {
                                                event.preventDefault();
                                                alert("Valid From must be at least 10 minutes after the current time.");
                                                validFrom.focus();
                                                return;
                                            }

                                            // Kiểm tra validTo phải lớn hơn validFrom
                                            if (validToTime <= validFromTime) {
                                                event.preventDefault();
                                                alert("Valid To must be after Valid From.");
                                                validTo.focus();
                                                return;
                                            }

                                            // Kiểm tra quantity phải là số nguyên dương (>= 1)
                                            if (parseInt(quantity.value) < 1 || !Number.isInteger(parseFloat(quantity.value))) {
                                                event.preventDefault();
                                                alert("Quantity must be a positive integer.");
                                                quantity.focus();
                                                return;
                                            }

                                            // Validate discount amount nếu cần (đã có sẵn trong script cũ)
                                            if (discountAmount.value < 10000 || !Number.isInteger(parseFloat(discountAmount.value))) {
                                                event.preventDefault();
                                                alert("Discount amount must be at least 10,000 VND and a whole number");
                                                discountAmount.focus();
                                                return;
                                            }
                                        });

                                        // Xử lý discountAmount: chỉ cho phép nhập số
                                        discountAmount.addEventListener('input', function () {
                                            this.value = this.value.replace(/[^\d]/g, '');
                                        });

                                        // Phần tạo nút generate random voucher code (nếu có)
                                        const codeInput = document.getElementById('code');
                                        if (codeInput) {
                                            const generateButton = document.createElement('button');
                                            generateButton.type = 'button';
                                            generateButton.className = 'btn btn-outline-secondary mt-2';
                                            generateButton.innerHTML = '<i class="fas fa-random me-1"></i> Generate Random Code';
                                            generateButton.onclick = function () {
                                                const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
                                                let result = '';
                                                for (let i = 0; i < 8; i++) {
                                                    result += chars.charAt(Math.floor(Math.random() * chars.length));
                                                }
                                                codeInput.value = result;
                                            };
                                            codeInput.parentNode.appendChild(generateButton);
                                        }
                                    });
        </script>

    </body>
</html>