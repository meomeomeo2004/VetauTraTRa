<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Edit Voucher</title>
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
                <h2 class="page-title">Edit Voucher</h2>

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

                <!-- Success Notification -->
                <c:if test="${not empty requestScope.success}">
                    <div class="alert-notification p-3 d-flex align-items-center bg-success text-white" id="successAlert">
                        <div class="alert-icon">
                            <i class="fas fa-check-circle"></i>
                        </div>
                        <div class="flex-grow-1">
                            <h5 class="mb-1">Success</h5>
                            <p class="mb-0">${requestScope.success}</p>
                        </div>
                        <div class="close-btn" onclick="closeSuccessAlert()">
                            <i class="fas fa-times"></i>
                        </div>
                    </div>
                </c:if>

                <div class="card">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <h5 class="card-title">Edit Voucher Details</h5>
                        <a href="ViewListVoucher" class="btn btn-secondary">
                            <i class="fas fa-arrow-left me-1"></i> Back to Vouchers
                        </a>
                    </div>
                    <div class="card-body">
                        <form action="VoucherEdit" method="post" id="editVoucherForm" onsubmit="return validateVoucherForm()">
                            <input type="hidden" name="id" value="${voucher.id}">

                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label for="code" class="form-label">Voucher Code <span class="text-danger" >*</span></label>
                                    <input type="text" class="form-control" id="code" name="code" value="${voucher.code}" readonly>
                                    <div class="form-text">Unique code for the voucher (e.g., SUMMER2023)</div>
                                </div>

                                <div class="col-md-6">
                                    <label for="discountAmount" class="form-label">Discount Amount (VND)<span class="text-danger">*</span></label>
                                    <input type="number" class="form-control" id="discountAmount" name="discountAmount" value="${voucher.discountAmount}" min="10000" step="1000" required required>
                                    <div class="form-text">Fixed discount amount (minimum 10,000 VND))</div>
                                </div>
                            </div>
                            <fmt:formatDate value="${voucher.validFrom}" pattern="yyyy-MM-dd'T'HH:mm" var="validFromFormatted" />
                            <fmt:formatDate value="${voucher.validTo}" pattern="yyyy-MM-dd'T'HH:mm" var="validToFormatted" />

                            <div class="row mb-4">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="validFrom" class="form-label">Valid From <span class="text-danger">*</span></label>
                                        <!-- Định dạng validFrom trước khi hiển thị -->
                                        <fmt:formatDate value="${voucher.validFrom}" pattern="yyyy-MM-dd'T'HH:mm" var="validFromFormatted" />
                                        <input type="datetime-local" class="form-control" id="validFrom" name="validFrom"
                                               value="${validFromFormatted}" required>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="validTo" class="form-label">Valid To</label>
                                        <!-- Định dạng validTo trước khi hiển thị -->
                                        <fmt:formatDate value="${voucher.validTo}" pattern="yyyy-MM-dd'T'HH:mm" var="validToFormatted" />
                                        <input type="datetime-local" class="form-control" id="validTo" name="validTo"
                                               value="${validToFormatted}">
                                    </div>
                                </div>
                            </div>



                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label for="quantity" class="form-label">Quantity <span class="text-danger">*</span></label>
                                    <input type="number" class="form-control" id="quantity" name="quantity" value="${voucher.quantity}" min="1" required>
                                    <div class="form-text">Number of vouchers available</div>
                                </div>

                                <div class="col-md-6">
                                    <label for="status" class="form-label">Status <span class="text-danger">*</span></label>
                                    <select class="form-select" id="status" name="status" required>
                                        <option value="1" ${voucher.status == '1' ? 'selected' : ''}>Active</option>
                                        <option value="0" ${voucher.status == '0' ? 'selected' : ''}>Upcoming</option>
                                    </select>
                                </div>
                            </div>                           
                            <div class="d-flex justify-content-end gap-2 mt-4">
                                <button type="button" class="btn btn-secondary" onclick="window.location.href = 'Seller_ManageVoucher.jsp'">Cancel</button>
                                <button type="submit" class="btn btn-primary">Save Changes</button>
                            </div>
                        </form>
                    </div>
                </div>
            </main>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                                    // Auto-dismiss the alerts after 5 seconds
                                    if (document.getElementById('errorAlert')) {
                                        setTimeout(function () {
                                            closeErrorAlert();
                                        }, 5000);
                                    }

                                    if (document.getElementById('successAlert')) {
                                        setTimeout(function () {
                                            closeSuccessAlert();
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

                                    // Hàm cập nhật min cho validTo dựa trên validFrom
                                    function updateValidToMin() {
                                        let validFromInput = document.getElementById("validFrom");
                                        let validToInput = document.getElementById("validTo");

                                        if (!validFromInput.value)
                                            return;

                                        // Chuyển validFrom sang đối tượng Date và cộng thêm 1 phút để đảm bảo validTo > validFrom
                                        let validFromDate = new Date(validFromInput.value);
                                        let minValidTo = new Date(validFromDate.getTime() + 1 * 60000);
                                        let minValidToStr = minValidTo.toISOString().slice(0, 16);
                                        validToInput.min = minValidToStr;

                                        // Nếu validTo hiện tại không thỏa mãn, xóa để bắt người dùng nhập lại
                                        if (validToInput.value && validToInput.value < minValidToStr) {
                                            validToInput.value = "";
                                        }
                                    }

                                    // Khi cửa sổ load, đặt giá trị min cho validFrom và cập nhật validTo
                                    window.addEventListener("load", function () {
                                        let validFromInput = document.getElementById("validFrom");
                                        let validToInput = document.getElementById("validTo");

                                        // Tính thời gian hiện tại + 1 tiếng (lưu ý: nếu bạn cần thay đổi khoảng thời gian này, chỉnh sửa ở đây)
                                        let now = new Date();
                                        now.setHours(now.getHours() + 1);
                                        let minValidFromStr = now.toISOString().slice(0, 16);

                                        // Đặt giá trị min cho validFrom
                                        validFromInput.min = minValidFromStr;

                                        // Nếu giá trị hiện có của validFrom không hợp lệ thì cập nhật lại
                                        if (validFromInput.value && validFromInput.value < minValidFromStr) {
                                            validFromInput.value = minValidFromStr;
                                        }

                                        // Cập nhật validTo dựa trên validFrom
                                        updateValidToMin();
                                    });

                                    // Khi validFrom thay đổi thì cập nhật validTo.min
                                    document.getElementById("validFrom").addEventListener("change", updateValidToMin);

                                    // Form validation (cho form có id "editVoucherForm")
                                    document.addEventListener('DOMContentLoaded', function () {
                                        const form = document.getElementById('editVoucherForm');
                                        const validFrom = document.getElementById('validFrom');
                                        const validTo = document.getElementById('validTo');
                                        const discountAmount = document.getElementById('discountAmount');
                                        const quantity = document.getElementById('quantity');

                                        form.addEventListener('submit', function (event) {
                                            // Kiểm tra validTo phải lớn hơn validFrom
                                            if (validTo.value && new Date(validTo.value) <= new Date(validFrom.value)) {
                                                event.preventDefault();
                                                alert('Valid To date must be after Valid From date');
                                                validTo.focus();
                                                return;
                                            }

                                            // Kiểm tra discount amount: phải ít nhất 10,000 và là số nguyên
                                            if (discountAmount.value < 10000 || !Number.isInteger(parseFloat(discountAmount.value))) {
                                                event.preventDefault();
                                                alert('Discount amount must be at least 10,000 VND and a whole number.');
                                                discountAmount.focus();
                                                return;
                                            }

                                            // Kiểm tra quantity: phải là số nguyên dương (>= 1)
                                            if (parseInt(quantity.value) < 1 || !Number.isInteger(parseFloat(quantity.value))) {
                                                event.preventDefault();
                                                alert('Quantity must be a positive integer.');
                                                quantity.focus();
                                                return;
                                            }
                                        });
                                    });

                                    // Hàm kiểm tra trước khi submit form (nếu sử dụng thuộc tính onsubmit)
                                    function validateVoucherForm() {
                                        let validFromInput = document.getElementById("validFrom");
                                        let validToInput = document.getElementById("validTo");
                                        let discountAmount = document.getElementById("discountAmount");
                                        let quantity = document.getElementById("quantity");

                                        // Kiểm tra validFrom: phải lớn hơn thời gian hiện tại + 1 tiếng
                                        let now = new Date();
                                        now.setHours(now.getHours() + 1);
                                        let minValidFrom = now.toISOString().slice(0, 16);
                                        if (validFromInput.value < minValidFrom) {
                                            alert("Valid From must be at least 1 hour from now!");
                                            return false;
                                        }

                                        // Kiểm tra validTo: nếu có thì phải lớn hơn validFrom
                                        if (validToInput.value) {
                                            if (validToInput.value <= validFromInput.value) {
                                                alert("Valid To must be later than Valid From!");
                                                return false;
                                            }
                                        }

                                        // Kiểm tra discount amount
                                        if (discountAmount.value < 10000 || !Number.isInteger(parseFloat(discountAmount.value))) {
                                            alert("Discount amount must be at least 10,000 VND and a whole number.");
                                            return false;
                                        }

                                        // Kiểm tra quantity
                                        if (parseInt(quantity.value) < 1 || !Number.isInteger(parseFloat(quantity.value))) {
                                            alert("Quantity must be a positive integer.");
                                            return false;
                                        }

                                        return true;
                                    }
        </script>

    </body>
</html>