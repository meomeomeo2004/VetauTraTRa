<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Update Train Route</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="css/updateroutecss.css">
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
                        <a href="#" class="nav-link">
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
                <div class="card">
                    <div class="card-header">
                        <h5 class="card-title">Update Train Route</h5>
                    </div>
                    <div class="card-body">
                        <form action="updateroute" method="POST" onsubmit="return validateForm()">
                            <input type="hidden" name="routeid" value="${r.id}" />

                            <div class="row mb-4">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="trainid" class="form-label">Train Type</label>
                                        <select class="form-select" id="trainid" name="trainid" required>
                                            <c:forEach items="${train}" var="t">
                                                <option value="${t.id}" ${t.id == r.trainId ? 'selected' : ''}>
                                                    ${t.trainid}
                                                </option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="routecode" class="form-label">Route Code</label>
                                        <input type="text" class="form-control" id="routecode" 
                                               name="routecode" 
                                               placeholder="Enter route code" 
                                               value="${r.routeCode}" required>
                                    </div>
                                </div>
                            </div>

                            <div class="form-group mb-4">
                                <label for="description" class="form-label">Description</label>
                                <textarea class="form-control" id="description" name="description" rows="3"
                                          placeholder="Enter route description">${r.description}</textarea>
                            </div>

                            <!-- Thời gian khởi hành / đến -->
                            <div class="row mb-4">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="departureDateTime" class="form-label">Departure Date & Time</label>
                                        <input type="datetime-local" class="form-control" id="departureDateTime"
                                               name="departureDateTime"
                                               value="${r.departureTime}" required
                                               onchange="handleDepartureChange()"  />
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="returnDateTime" class="form-label">Arrival Date & Time</label>
                                        <input type="datetime-local" class="form-control" id="returnDateTime"
                                               name="returnDateTime"
                                               value="${r.arrivalTime}" required />
                                    </div>
                                </div>
                            </div>

                            <div class="row mb-4">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="departureStation" class="form-label">Departure Station</label>
                                        <select class="form-select" id="departureStation" name="departureStation" required>
                                            <option value="" disabled>Select station</option>
                                            <c:forEach items="${station}" var="o">
                                                <option value="${o.id}" ${o.name == r.departureStation ? 'selected' : ''}>
                                                    ${o.name}
                                                </option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="arrivalStation" class="form-label">Arrival Station</label>
                                        <select class="form-select" id="arrivalStation" name="arrivalStation" required>
                                            <option value="" disabled>Select station</option>
                                            <c:forEach items="${station}" var="o">
                                                <option value="${o.id}" ${o.name == r.arrivalStation ? 'selected' : ''}>
                                                    ${o.name}
                                                </option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <div class="d-flex justify-content-end gap-2 mt-4">
                                <a href="viewlistroute" class="btn btn-danger">
                                    <i class="fas fa-times"></i> Cancel
                                </a>
                                <button type="submit" class="btn btn-success" 
                                        onclick="return confirm('Are you sure you want to update this train route?');">
                                    <i class="fas fa-save"></i> Update
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </main>

        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                                            // Khi trang load, thiết lập giá trị min cho Departure nếu cần
                                            window.addEventListener("load", function () {
                                                // Lấy thời gian hiện tại
                                                let now = new Date();
                                                // Cộng 2 giờ
                                                now.setHours(now.getHours() + 24);

                                                // Định dạng theo chuẩn của input datetime-local (yyyy-MM-ddTHH:mm)
                                                let minDepartureStr = now.toISOString().slice(0, 16);

                                                // Lấy ô departure                                                                                  
                                                let departureInput = document.getElementById("departureDateTime");

                                                // Nếu giá trị cũ (r.departureTime) < (hiện tại + 2h) thì ép min
                                                // Tức là route cũ không hợp lệ so với quy tắc, bắt buộc người dùng phải sửa
                                                if (departureInput.value < minDepartureStr) {
                                                    departureInput.min = minDepartureStr;
                                                } else {
                                                    // Nếu route cũ vốn đã hợp lệ, ta vẫn đặt min = giá trị cũ
                                                    // hoặc (hiện tại + 2h) để user không được chọn thấp hơn
                                                    departureInput.min = minDepartureStr;
                                                }

                                                // Gọi hàm cập nhật min cho Arrival
                                                handleDepartureChange();
                                            });

                                            // Hàm cập nhật min cho Arrival khi thay đổi Departure
                                            function handleDepartureChange() {
                                                let departureInput = document.getElementById("departureDateTime");
                                                let arrivalInput = document.getElementById("returnDateTime");

                                                if (!departureInput.value)
                                                    return;

                                                // Chuyển sang Date
                                                let departureDate = new Date(departureInput.value);

                                                // Arrival phải tối thiểu là +30 phút so với Departure
                                                let minArrival = new Date(departureDate.getTime() + 30 * 60000);
                                                let minArrivalStr = minArrival.toISOString().slice(0, 16);

                                                // Gán min cho Arrival
                                                arrivalInput.min = minArrivalStr;

                                                // Nếu arrival cũ < minArrival thì xóa giá trị (bắt user chọn lại)
                                                if (arrivalInput.value < minArrivalStr) {
                                                    arrivalInput.value = "";
                                                }
                                            }

                                            // Hàm kiểm tra cuối cùng trước khi submit
                                            function validateForm() {
                                                const now = new Date();
                                                // Thời gian hiện tại + 2h
                                                let nowPlus2h = new Date(now.getTime() + 24 * 3600000);

                                                let departureInput = document.getElementById("departureDateTime");
                                                let arrivalInput = document.getElementById("returnDateTime");

                                                let departureDate = new Date(departureInput.value);
                                                let arrivalDate = new Date(arrivalInput.value);

                                                // 1) Departure phải >= hiện tại + 2 tiếng
                                                if (departureDate < nowPlus2h) {
                                                    alert("Departure time must be at least 1 day from now!");
                                                    return false;
                                                }

                                                // 2) Arrival phải >= Departure + 30 phút
                                                let departurePlus30m = new Date(departureDate.getTime() + 30 * 60000);
                                                if (arrivalDate < departurePlus30m) {
                                                    alert("Arrival time must be at least 30 minutes after Departure!");
                                                    return false;
                                                }

                                                // Hợp lệ
                                                return true;
                                            }
        </script>
    </body>
</html>

