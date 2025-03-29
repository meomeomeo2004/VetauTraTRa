<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Edit Train</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="css/edittraincss.css">
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
                    <a href="listtrain" class="nav-link active">
                        <i class="fas fa-subway"></i>
                        <span>Manage Trains</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="#" class="nav-link">
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
            </ul>
        </aside>

        <main class="content">
            <h2 class="page-title"><i class="fas fa-edit"></i> Edit Train</h2>

            <div class="progress-steps">
                <div class="step active" id="step1">
                    <div class="step-number">1</div>
                    <div class="step-label">Train Information</div>
                </div>
                <div class="step" id="step2">
                    <div class="step-number">2</div>
                    <div class="step-label">Cabin Details</div>
                </div>
            </div>

            <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger">
                    <i class="fas fa-exclamation-circle me-2"></i>
                    ${errorMessage}
                </div>
            </c:if>

            <form action="editTrain" method="post" id="editTrainForm">
                <!-- Train Information Card -->
                <div class="card" id="trainInfoCard">
                    <div class="card-header">
                        <h5 class="card-title"><i class="fas fa-train me-2"></i>Train Information</h5>
                    </div>
                    <div class="card-body">
                        <input type="hidden" id="trainId" name="trainId" value="${train.id}" />

                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="train_model" class="form-label">Train Model</label>
                                    <input type="text" class="form-control" id="train_model" name="train_model" value="${train.trainid}" required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="owner" class="form-label">Owner</label>
                                    <select class="form-select" id="owner" name="owner" required>
                                        <option value="">Select Owner</option>
                                        <c:forEach items="${listseller}" var="s">
                                            <option value="${s.id}" <c:if test="${s.id == train.owner}">selected</c:if>>${s.fullName}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="total_seats" class="form-label">Total Seats</label>
                                    <input type="number" class="form-control" id="total_seats" name="total_seats" value="${train.totalSeats}" required>
                                    <small class="form-text">Total number of seats across all cabins</small>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="numcabin" class="form-label">Number of Cabins</label>
                                    <input type="number" class="form-control" id="numcabin" name="numcabin" value="${train.numCabin}" required>
                                    <small class="form-text">Number of cabins in this train</small>
                                </div>
                            </div>
                        </div>

                        <div class="d-flex justify-content-end mt-3">
                            <button type="button" class="btn btn-primary" id="btnContinue">
                                <i class="fas fa-arrow-right"></i> Continue to Cabin Details
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Cabin Details Card -->
                <div class="card disabled-section" id="cabinDetailsCard">
                    <div class="card-header">
                        <h5 class="card-title"><i class="fas fa-door-open me-2"></i>Cabin Details</h5>
                    </div>
                    <div class="card-body">
                        <div class="row" id="cabinContainer">
                            <!-- Cabin cards will be generated here -->
                        </div>

                        <div class="seat-summary" id="seatSummary">
                            <div class="seat-summary-title">
                                <i class="fas fa-chair"></i> Seat Distribution Summary
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="d-flex justify-content-between">
                                        <span>Total Train Seats:</span>
                                        <span class="fw-bold" id="summaryTotalSeats">0</span>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="d-flex justify-content-between">
                                        <span>Total Cabin Seats:</span>
                                        <span class="fw-bold" id="summaryCabinSeats">0</span>
                                    </div>
                                </div>
                            </div>
                            <div class="alert alert-warning mt-2 mb-0 hidden" id="seatMismatchWarning">
                                <i class="fas fa-exclamation-triangle me-2"></i>
                                <span>Warning: The sum of cabin seats does not match the total seats!</span>
                            </div>
                        </div>

                        <div class="d-flex justify-content-between mt-4">
                            <button type="button" class="btn btn-secondary" id="btnBackToTrain">
                                <i class="fas fa-arrow-left"></i> Back to Train Info
                            </button>
                            <button type="submit" class="btn btn-success" id="btnSubmit">
                                <i class="fas fa-save"></i> Save Changes
                            </button>
                        </div>
                    </div>
                </div>
            </form>
        </main>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            // Mảng toàn cục lưu dữ liệu cabin (giúp giữ lại thông tin khi numcabin thay đổi)
            // Mỗi phần tử là 1 object: { name, cabinClass, price, numseat, imgUrl }
            let cabinDataArray = [
            <c:forEach var="c" items="${cabins}" varStatus="loopC">
            {
            name: '${c.cabinName}',
                    cabinClass: '${c.type}',
                    numseat: '${c.numSeat}',
                    imgUrl: '${c.imgUrl}',
                    price: '<c:choose><c:when test="${not empty seat}"><c:set var="foundPrice" value="0"/><c:forEach var="s" items="${seat}"><c:if test="${s.cabinid == c.id}"><c:set var="foundPrice" value="${s.price}" /></c:if></c:forEach>${foundPrice}</c:when><c:otherwise>0</c:otherwise></c:choose>'
                        }<c:if test="${not loopC.last}">,</c:if>
            </c:forEach>
                        ];

                        // Kiểm tra thông tin train có đầy đủ chưa
                        function isTrainInfoComplete() {
                            console.log(model, totalSeats, numCabin, owner);
                            var model = document.getElementById("train_model").value.trim();
                            var totalSeats = document.getElementById("total_seats").value.trim();
                            var numCabin = document.getElementById("numcabin").value.trim();
                            var owner = document.getElementById("owner").value.trim();
                            return model !== "" && totalSeats !== "" && numCabin !== "" && owner !== "";
                        }

                        // Hàm cập nhật khi user thay đổi bất kỳ ô input nào của cabin
                        function onCabinFieldChange(index, field, value) {
                            cabinDataArray[index][field] = value;
                        }

                        // Tạo/hiển thị lại cabin
                        function generateCabins() {
                            var numCabinValue = parseInt(document.getElementById("numcabin").value);
                            var cabinContainer = document.getElementById("cabinContainer");

                            // 1. Điều chỉnh mảng cabinDataArray để khớp với numCabinValue
                            if (cabinDataArray.length < numCabinValue) {
                                while (cabinDataArray.length < numCabinValue) {
                                    cabinDataArray.push({
                                        name: "",
                                        cabinClass: "",
                                        price: "",
                                        numseat: "",
                                        imgUrl: ""
                                    });
                                }
                            } else if (cabinDataArray.length > numCabinValue) {
                                cabinDataArray.splice(numCabinValue, cabinDataArray.length - numCabinValue);
                            }

                            // 2. Xóa UI cũ
                            cabinContainer.innerHTML = "";

                            // 3. Tạo lại UI cho từng cabin
                            for (let i = 0; i < numCabinValue; i++) {
                                let cabinData = cabinDataArray[i];

                                // col-md-4 => 3 cột (Bootstrap)
                                var cabinCol = document.createElement("div");
                                cabinCol.className = "col-md-4";

                                var cabinCard = document.createElement("div");
                                cabinCard.className = "cabin-card card mb-3";

                                // Header hiển thị Cabin 1, Cabin 2, ...
                                var cabinHeader = document.createElement("div");
                                cabinHeader.className = "card-header";
                                cabinHeader.innerHTML = `
                <i class="fas fa-door-open cabin-icon"></i>
                <h5 class="cabin-title">Cabin ${i + 1}</h5>
            `;

                                // Body (nội dung form cabin)
                                var cabinBody = document.createElement("div");
                                cabinBody.className = "card-body";
                                cabinBody.innerHTML = `
                                        <div class="form-group mb-2">
                                            <label class="form-label">Cabin Name</label>
                                            <input type="text" class="form-control" name="cabinName" required
                                                   value="${cabinData.name}"
                                                   onchange="onCabinFieldChange(${i}, 'name', this.value)">
                                        </div>
                                        <div class="form-group mb-2">
                                            <label class="form-label">Cabin Class</label>
                                            <input type="text" class="form-control" name="cabinClass" required
                                                   value="${cabinData.cabinClass}"
                                                   onchange="onCabinFieldChange(${i}, 'cabinClass', this.value)">
                                        </div>
                                        <div class="form-group mb-2">
                                            <label class="form-label">Price</label>
                                            <input type="number" step="0.01" class="form-control" name="cabinPrice" required
                                                   value="${cabinData.price}"
                                                   onchange="onCabinFieldChange(${i}, 'price', this.value)">
                                        </div>
                                        <div class="form-group mb-2">
                                            <label class="form-label">Number of Seats</label>
                                            <input type="number" class="form-control cabin-seats" name="cabinNumseat"
                                                   required value="${cabinData.numseat}"
                                                   onchange="onCabinFieldChange(${i}, 'numseat', this.value); updateSeatSummary();">
                                        </div>
                                        <div class="form-group">
                                            <label class="form-label">Image URL</label>
                                            <input type="text" class="form-control" name="cabinImgUrl" required
                                                   value="${cabinData.imgUrl}"
                                                   onchange="onCabinFieldChange(${i}, 'imgUrl', this.value)">
                                        </div>
            `;

                                cabinCard.appendChild(cabinHeader);
                                cabinCard.appendChild(cabinBody);
                                cabinCol.appendChild(cabinCard);
                                cabinContainer.appendChild(cabinCol);
                            }

                            // Sau khi tạo xong cabin, cập nhật seat summary
                            updateSeatSummary();
                        }

                        // Cập nhật seat summary
                        function updateSeatSummary() {
                            var totalSeats = parseInt(document.getElementById("total_seats").value) || 0;
                            var cabinSeatInputs = document.getElementsByName("cabinNumseat");
                            var totalCabinSeats = 0;

                            for (var i = 0; i < cabinSeatInputs.length; i++) {
                                totalCabinSeats += parseInt(cabinSeatInputs[i].value) || 0;
                            }

                            document.getElementById("summaryTotalSeats").textContent = totalSeats;
                            document.getElementById("summaryCabinSeats").textContent = totalCabinSeats;

                            var seatMismatchWarning = document.getElementById("seatMismatchWarning");
                            if (totalCabinSeats !== totalSeats) {
                                seatMismatchWarning.classList.remove("hidden");
                            } else {
                                seatMismatchWarning.classList.add("hidden");
                            }
                        }

                        // Sự kiện nút "Continue to Cabin details"
                        document.getElementById("btnContinue").addEventListener("click", function () {
                            if (!isTrainInfoComplete()) {
                              
                                alert("Please fill in all train information fields before continuing.");
                                return;
                            }

                            // Ẩn phần train info, hiện phần cabin details
                            document.getElementById("trainInfoCard").classList.add("disabled-section");
                            document.getElementById("cabinDetailsCard").classList.remove("disabled-section");
                            document.getElementById("step1").classList.remove("active");
                            document.getElementById("step1").classList.add("completed");
                            document.getElementById("step2").classList.add("active");

                            // Tạo/hiển thị cabin, vẫn giữ lại dữ liệu cũ
                            generateCabins();
                        });

                        // Sự kiện nút "Back to train info"
                        document.getElementById("btnBackToTrain").addEventListener("click", function () {
                            document.getElementById("trainInfoCard").classList.remove("disabled-section");
                            document.getElementById("cabinDetailsCard").classList.add("disabled-section");
                            document.getElementById("step1").classList.add("active");
                            document.getElementById("step1").classList.remove("completed");
                            document.getElementById("step2").classList.remove("active");
                        });

                        // Khi các trường train info thay đổi => trở về bước 1
                        var trainFields = ["train_model", "total_seats", "numcabin", "owner"];
                        trainFields.forEach(function (id) {
                            document.getElementById(id).addEventListener("change", function () {
                                if (!document.getElementById("step1").classList.contains("active")) {
                                    document.getElementById("trainInfoCard").classList.remove("disabled-section");
                                    document.getElementById("cabinDetailsCard").classList.add("disabled-section");
                                    document.getElementById("step1").classList.add("active");
                                    document.getElementById("step1").classList.remove("completed");
                                    document.getElementById("step2").classList.remove("active");
                                }
                            });
                        });

                        // Validation khi submit form
                        document.getElementById("editTrainForm").addEventListener("submit", function (event) {
                            var cabinInputs = document.querySelectorAll("#cabinContainer input");
                            var allFilled = true;
                            cabinInputs.forEach(function (input) {
                                if (input.value.trim() === "") {
                                    allFilled = false;
                                }
                            });
                            if (!allFilled) {
                                event.preventDefault();
                                alert("Please fill in all cabin details before submitting.");
                                return;
                            }

                            var totalSeats = parseInt(document.getElementById("total_seats").value);
                            var cabinSeatInputs = document.getElementsByName("cabinNumseat");
                            var sum = 0;
                            for (var i = 0; i < cabinSeatInputs.length; i++) {
                                sum += parseInt(cabinSeatInputs[i].value) || 0;
                            }
                            if (sum !== totalSeats) {
                                event.preventDefault();
                                alert("The total number of cabin seats (" + sum + ") does not match the total seats (" + totalSeats + "). Please adjust the seat distribution.");
                            }
                        });
        </script>
    </body>
</html>