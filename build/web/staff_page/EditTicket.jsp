<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <title>Edit Ticket Information</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
    <style>
        .alert-danger {
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="container mt-5 d-flex justify-content-center">
        <div class="card col-md-6">
            <div class="card-header bg-primary text-white text-center">
                Edit Ticket Information
            </div>
            <div class="card-body">
                <!-- Hiển thị thông báo lỗi -->
                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-danger">
                        <ul>
                            <c:forEach var="error" items="${errorMessage}">
                                <li>${error}</li>
                            </c:forEach>
                        </ul>
                    </div>
                </c:if>
                
                <form action="editTicket" method="post">
                    <input type="hidden" name="id" value="${ticket.id}" />
                    <div class="mb-3">
                        <label class="form-label">Full Name</label>
                        <input type="text" class="form-control" name="fullName" value="${ticket.fullName}" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Phone Number</label>
                        <input type="text" class="form-control" name="phoneNumber" value="${ticket.phoneNumber}" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Address</label>
                        <input type="text" class="form-control" name="address" value="${ticket.address}" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Luggage Type</label>
                        <select class="form-select" name="luggageType" required>
                            <option value="1" ${ticket.luggageType == 1 ? 'selected' : ''}>15kg</option>
                            <option value="2" ${ticket.luggageType == 2 ? 'selected' : ''}>40kg</option>
                            <option value="3" ${ticket.luggageType == 3 ? 'selected' : ''}>75kg</option>
                        </select>
                    </div>
                    <div class="text-center">
                        <button type="submit" class="btn btn-success">Save</button>
                        <a href="../staff_page/ticketList" class="btn btn-danger">Cancel</a>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
    <script src="js/scripts.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
    <script src="js/datatables-simple-demo.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            document.querySelector("form[action='editTicket']").addEventListener("submit", function (event) {
                event.preventDefault();
                Swal.fire({
                    title: "Bạn có chắc chắn muốn thay đổi thông tin?",
                    icon: "warning",
                    showCancelButton: true,
                    confirmButtonText: "Lưu",
                    cancelButtonText: "Hủy"
                }).then((result) => {
                    if (result.isConfirmed) {
                        event.target.submit();
                    }
                });
            });
        });
    </script>
</body>
</html>
