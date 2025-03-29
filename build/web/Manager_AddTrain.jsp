<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Add Train</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="css/addtraincss.css">
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
                    <a href="ViewListStation" class="nav-link">
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
            <h2 class="page-title"><i class="fas fa-plus-circle"></i> Add New Train</h2>

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

            <form action="AddTrain" method="post" id="addTrainForm">
                <div class="card" id="trainInfoCard">
                    <div class="card-header">
                        <h5 class="card-title"><i class="fas fa-train me-2"></i>Train Information</h5>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="train_model" class="form-label">Train Model</label>
                                    <input type="text" class="form-control" id="train_model" name="train_model" required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="owner" class="form-label">Owner</label>
                                    <select class="form-select" id="owner" name="owner" required>
                                        <option value="">Select Owner</option>
                                        <c:forEach items="${listseller}" var="s">
                                            <option value="${s.id}">${s.fullName}</option> 
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="total_seats" class="form-label">Total Seats</label>
                                    <input type="number" class="form-control" id="total_seats" name="total_seats" required>
                                    <small class="form-text">Total number of seats across all cabins</small>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="numcabin" class="form-label">Number of Cabins</label>
                                    <input type="number" class="form-control" id="numcabin" name="numcabin" required>
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

                <div class="card disabled-section" id="cabinDetailsCard">
                    <div class="card-header">
                        <h5 class="card-title"><i class="fas fa-door-open me-2"></i>Cabin Details</h5>
                    </div>
                    <div class="card-body">
                        <div class="cabin-grid row" id="cabinContainer">
                              
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
                            <div class="alert alert-warning mt-2 mb-0 d-none" id="seatMismatchWarning">
                                <i class="fas fa-exclamation-triangle me-2"></i>
                                <span>Warning: The sum of cabin seats does not match the total seats!</span>
                            </div>
                        </div>

                        <div class="d-flex justify-content-between mt-4">
                            <button type="button" class="btn btn-secondary" id="btnBackToTrain">
                                <i class="fas fa-arrow-left"></i> Back to Train Info
                            </button>
                            <button type="submit" class="btn btn-success" id="btnSubmit">
                                <i class="fas fa-save"></i> Add Train
                            </button>
                        </div>
                    </div>
                </div>
            </form>
        </main>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            // Store cabin data between steps
            var cabinDataStore = [];
            
            // Check if train info is complete
            function isTrainInfoComplete() {
                var model = document.getElementById("train_model").value.trim();
                var totalSeats = document.getElementById("total_seats").value.trim();
                var numCabin = document.getElementById("numcabin").value.trim();
                var owner = document.getElementById("owner").value.trim();
                return model !== "" && totalSeats !== "" && numCabin !== "" && owner !== "";
            }

            // Generate cabin cards
            function generateCabins() {
                var numCabinValue = parseInt(document.getElementById("numcabin").value);
                var cabinContainer = document.getElementById("cabinContainer");
                
                // Store existing cabin data before clearing the container
                if (cabinDataStore.length === 0 || cabinDataStore.length !== numCabinValue) {
                    // Only initialize the array if it's empty or size has changed
                    cabinDataStore = new Array(numCabinValue);
                    for (var i = 0; i < numCabinValue; i++) {
                        cabinDataStore[i] = {
                            name: "",
                            cabinClass: "",
                            price: "",
                            seats: "",
                            imgUrl: ""
                        };
                    }
                } else {
                    // Save current values before regenerating
                    var existingCabinInputs = document.querySelectorAll("#cabinContainer .cabin-card");
                    for (var i = 0; i < existingCabinInputs.length && i < cabinDataStore.length; i++) {
                        var cabinCard = existingCabinInputs[i];
                        cabinDataStore[i] = {
                            name: cabinCard.querySelector('input[name="cabinName"]').value,
                            cabinClass: cabinCard.querySelector('input[name="cabinClass"]').value,
                            price: cabinCard.querySelector('input[name="cabinPrice"]').value,
                            seats: cabinCard.querySelector('input[name="cabinNumseat"]').value,
                            imgUrl: cabinCard.querySelector('input[name="cabinImgUrl"]').value
                        };
                    }
                }
                
                cabinContainer.innerHTML = "";

                // Create cabin cards
                for (var i = 0; i < numCabinValue; i++) {
                    console.log("Creating Cabin " + (i + 1));
                    var cabinCol = document.createElement("div");
                    cabinCol.className = "col-md-4";

                    var cabinCard = document.createElement("div");
                    cabinCard.className = "cabin-card card mb-3";

                    // Header
                    var cabinHeader = document.createElement("div");
                    cabinHeader.className = "card-header";
                    cabinHeader.innerHTML = `
                        <i class="fas fa-door-open cabin-icon"></i>
                        <h5 class="cabin-title">Cabin ${i + 1}</h5>
                    `;

                    // Get saved data for this cabin
                    var savedData = cabinDataStore[i] || {
                        name: "",
                        cabinClass: "",
                        price: "",
                        seats: "",
                        imgUrl: ""
                    };

                    // Body with preserved values
                    var cabinBody = document.createElement("div");
                    cabinBody.className = "card-body";
                    cabinBody.innerHTML = `
                        <div class="form-group mb-2">
                            <label class="form-label">Cabin Name</label>
                            <input type="text" class="form-control" name="cabinName" value="${savedData.name}" required>
                        </div>
                        <div class="form-group mb-2">
                            <label class="form-label">Cabin Class</label>
                            <input type="text" class="form-control" name="cabinClass" value="${savedData.cabinClass}" required>
                        </div>
                        <div class="form-group mb-2">
                            <label class="form-label">Price</label>
                            <input type="number" step="0.01" class="form-control" name="cabinPrice" value="${savedData.price}" required>
                        </div>
                        <div class="form-group mb-2">
                            <label class="form-label">Number of Seats</label>
                            <input type="number" class="form-control cabin-seats" name="cabinNumseat" 
                                   value="${savedData.seats}" required onchange="updateSeatSummary()">
                        </div>
                        <div class="form-group">
                            <label class="form-label">Image URL</label>
                            <input type="text" class="form-control" name="cabinImgUrl" value="${savedData.imgUrl}" required>
                        </div>
                    `;

                    cabinCard.appendChild(cabinHeader);
                    cabinCard.appendChild(cabinBody);
                    cabinCol.appendChild(cabinCard);
                    cabinContainer.appendChild(cabinCol);
                }

                // After creating cabins, update seat summary
                updateSeatSummary();
            }

            // Update seat summary
            function updateSeatSummary() {
                var totalSeats = parseInt(document.getElementById("total_seats").value) || 0;
                var cabinSeatInputs = document.getElementsByName("cabinNumseat");
                var totalCabinSeats = 0;

                for (var i = 0; i < cabinSeatInputs.length; i++) {
                    totalCabinSeats += parseInt(cabinSeatInputs[i].value) || 0;
                }

                // Update summary display
                document.getElementById("summaryTotalSeats").textContent = totalSeats;
                document.getElementById("summaryCabinSeats").textContent = totalCabinSeats;

                // Show warning if seats don't match
                var seatMismatchWarning = document.getElementById("seatMismatchWarning");
                if (totalCabinSeats !== totalSeats) {
                    seatMismatchWarning.classList.remove("hidden");
                } else {
                    seatMismatchWarning.classList.add("hidden");
                }
            }

            // Continue to cabin details
            document.getElementById("btnContinue").addEventListener("click", function () {
                if (!isTrainInfoComplete()) {
                    alert("Please fill in all train information fields before continuing.");
                    return;
                }

                // Update UI
                document.getElementById("trainInfoCard").classList.add("disabled-section");
                document.getElementById("cabinDetailsCard").classList.remove("disabled-section");
                document.getElementById("step1").classList.remove("active");
                document.getElementById("step1").classList.add("completed");
                document.getElementById("step2").classList.add("active");

                // Check if cabins already exist
                var existingCabins = document.querySelectorAll("#cabinContainer .cabin-card");
                var numCabinValue = parseInt(document.getElementById("numcabin").value);
                
                // Only regenerate cabins if the number has changed or no cabins exist yet
                if (existingCabins.length !== numCabinValue) {
                    generateCabins();
                } else {
                    // Just update the seat summary
                    updateSeatSummary();
                }
            });

            // Back to train info
            document.getElementById("btnBackToTrain").addEventListener("click", function () {
                // Save current cabin data before going back
                var existingCabinInputs = document.querySelectorAll("#cabinContainer .cabin-card");
                var numCabinValue = parseInt(document.getElementById("numcabin").value);
                
                // Make sure cabinDataStore is initialized with the right size
                if (cabinDataStore.length !== numCabinValue) {
                    cabinDataStore = new Array(numCabinValue);
                }
                
                for (var i = 0; i < existingCabinInputs.length && i < cabinDataStore.length; i++) {
                    var cabinCard = existingCabinInputs[i];
                    cabinDataStore[i] = {
                        name: cabinCard.querySelector('input[name="cabinName"]').value,
                        cabinClass: cabinCard.querySelector('input[name="cabinClass"]').value,
                        price: cabinCard.querySelector('input[name="cabinPrice"]').value,
                        seats: cabinCard.querySelector('input[name="cabinNumseat"]').value,
                        imgUrl: cabinCard.querySelector('input[name="cabinImgUrl"]').value
                    };
                }
                
                // Switch to train info view
                document.getElementById("trainInfoCard").classList.remove("disabled-section");
                document.getElementById("cabinDetailsCard").classList.add("disabled-section");
                document.getElementById("step1").classList.add("active");
                document.getElementById("step1").classList.remove("completed");
                document.getElementById("step2").classList.remove("active");
            });

            // Special handling for fields that affect cabin generation
            document.getElementById("numcabin").addEventListener("change", function() {
                if (!document.getElementById("step1").classList.contains("active")) {
                    if (confirm("Changing the number of cabins will reset your cabin details. Do you want to continue?")) {
                        // User confirmed, go back to train info
                        document.getElementById("trainInfoCard").classList.remove("disabled-section");
                        document.getElementById("cabinDetailsCard").classList.add("disabled-section");
                        document.getElementById("step1").classList.add("active");
                        document.getElementById("step1").classList.remove("completed");
                        document.getElementById("step2").classList.remove("active");
                    } else {
                        // User canceled, revert the change
                        this.value = document.querySelectorAll("#cabinContainer .cabin-card").length;
                    }
                }
            });

            document.getElementById("total_seats").addEventListener("change", function() {
                if (!document.getElementById("step1").classList.contains("active")) {
                    // Just update the seat summary without resetting cabin details
                    updateSeatSummary();
                }
            });

            // Form submission validation
            document.getElementById("addTrainForm").addEventListener("submit", function (event) {
                // Check if all cabin fields are filled
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

                // Validate that cabin seats sum matches total seats
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

