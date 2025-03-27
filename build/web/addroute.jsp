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
        <link rel="stylesheet" type="text/css" href="scss/addroutecss.css">
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
                        <a href="ViewAllTrain" class="nav-link">
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
                    <c:if test="${not empty exist}">
                    <div class="alert-notification p-3 d-flex align-items-center" id="errorAlert">
                        <div class="alert-icon">
                            <i class="fas fa-exclamation-triangle"></i>
                        </div>
                        <div class="flex-grow-1">
                            <h5 class="mb-1">Failed</h5>
                            <p class="mb-0">${exist}</p>
                        </div>
                        <div class="close-btn" onclick="closeErrorAlert()">
                            <i class="fas fa-times"></i>
                        </div>
                    </div>
                    </c:if>
                    <div class="card-body">
                        <form action="AddRoute" method="POST" onsubmit="return validateForm()">
                            <div class="row mb-4">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="trainid" class="form-label">Train Type</label>
                                        <select class="form-select" id="trainid" name="trainid" required>
                                            <option value="" selected disabled>Select train type</option>
                                            <c:forEach items="${listtrain}" var="t">
                                                <c:if test="${t.status == 1}">
                                                    <option value="${t.id}">${t.trainid}</option>
                                                </c:if>
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
                                    <label for="departureDateTime" class="form-label">Departure Date & Time</label>
                                    <input type="datetime-local" class="form-control" id="departureDateTime"
                                           name="departureDateTime" required
                                           onchange="handleDepartureChange()"  />
                                </div>
                                <div class="col-md-6">
                                    <label for="returnDateTime" class="form-label">Arrival Date & Time</label>
                                    <input type="datetime-local" class="form-control" id="returnDateTime"
                                           name="returnDateTime" required />
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
                                <button type="button" class="btn btn-danger" onclick="window.location.href = 'viewlistroute'">
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
        <script>
                                   window.addEventListener("load", function () {
                                       // Lấy thời gian hiện tại
                                       let now = new Date();
                                       // Cộng thêm 2 giờ
                                       now.setHours(now.getHours() + 2);

                                       // Chuyển thành định dạng datetime-local
                                       let minDeparture = now.toISOString().slice(0, 16);

                                       // Gán cho Departure Date & Time
                                       document.getElementById("departureDateTime").min = minDeparture;
                                   });

                                   function handleDepartureChange() {
                                       const departureInput = document.getElementById("departureDateTime");
                                       const arrivalInput = document.getElementById("returnDateTime");

                                       let departureValue = departureInput.value;
                                       if (!departureValue)
                                           return;

                                       let departureDate = new Date(departureValue);

                                       // Cộng thêm 30 phút
                                       let minArrival = new Date(departureDate.getTime() + 30 * 60000);
                                       arrivalInput.min = minArrival.toISOString().slice(0, 16);

                                       // Nếu arrival đang nhỏ hơn min, reset lại
                                       if (arrivalInput.value && arrivalInput.value < arrivalInput.min) {
                                           arrivalInput.value = "";
                                       }
                                   }

                                   function validateForm() {
                                       const now = new Date();
                                       // Giờ hiện tại + 2 tiếng
                                       let nowPlus2h = new Date(now.getTime() + 2 * 3600000);

                                       const departureInput = document.getElementById("departureDateTime");
                                       const arrivalInput = document.getElementById("returnDateTime");

                                       let departureDate = new Date(departureInput.value);
                                       let arrivalDate = new Date(arrivalInput.value);

                                       // Kiểm tra Departure >= giờ hiện tại + 2 tiếng
                                       if (departureDate < nowPlus2h) {
                                           alert("Departure time must be at least 2 hours from now!");
                                           return false;
                                       }

                                       // Kiểm tra Arrival >= Departure + 30 phút
                                       let departurePlus30m = new Date(departureDate.getTime() + 30 * 60000);
                                       if (arrivalDate < departurePlus30m) {
                                           alert("Arrival time must be at least 30 minutes before departure time!");
                                           return false;
                                       }
                                       return true;
                                   }
                                   
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

