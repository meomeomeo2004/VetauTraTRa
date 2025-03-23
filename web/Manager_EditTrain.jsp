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
        <style>
            :root {
                --primary: #22577a;
                --primary-dark: #1a4562;
                --primary-light: #38a3a5;
                --secondary: #57cc99;
                --danger: #e63946;
                --warning: #ff9f1c;
                --success: #2a9d8f;
                --light: #f8f9fa;
                --dark: #212529;
                --gray-100: #f8f9fa;
                --gray-200: #e9ecef;
                --gray-300: #dee2e6;
                --gray-400: #ced4da;
                --gray-500: #adb5bd;
                --gray-600: #6c757d;
                --gray-700: #495057;
                --gray-800: #343a40;
                --gray-900: #212529;
                --border-radius: 0.5rem;
                --box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.08);
                --transition: all 0.3s ease;
            }

            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                display: flex;
                min-height: 100vh;
                margin: 0;
                font-family: 'Roboto', sans-serif;
                background-color: var(--gray-100);
                color: var(--gray-800);
            }

            .sidebar {
                width: 280px;
                background-color: white;
                color: var(--gray-800);
                padding: 2rem 1.5rem;
                box-shadow: var(--box-shadow);
                transition: var(--transition);
                height: 100vh;
                position: fixed;
                overflow-y: auto;
                z-index: 1000;
            }

            .sidebar-header {
                margin-bottom: 2rem;
                text-align: center;
            }

            .sidebar-title {
                font-size: 1.5rem;
                color: var(--primary);
                font-weight: 700;
                margin-bottom: 0.5rem;
                letter-spacing: 0.5px;
            }

            .sidebar-divider {
                height: 1px;
                background-color: var(--gray-300);
                margin: 1rem 0;
            }

            .nav-list {
                list-style: none;
                padding: 0;
                margin: 0;
            }

            .nav-item {
                margin-bottom: 0.5rem;
            }

            .nav-link {
                display: flex;
                align-items: center;
                text-decoration: none;
                color: var(--gray-700);
                font-weight: 500;
                padding: 0.75rem 1rem;
                border-radius: var(--border-radius);
                transition: var(--transition);
            }

            .nav-link:hover, .nav-link.active {
                background-color: var(--primary);
                color: white;
            }

            .nav-link i {
                margin-right: 0.75rem;
                font-size: 1.1rem;
                width: 1.5rem;
                text-align: center;
            }

            .content {
                flex: 1;
                padding: 2rem;
                margin-left: 280px;
                width: calc(100% - 280px);
            }

            .page-title {
                font-size: 1.75rem;
                font-weight: 700;
                margin-bottom: 1.5rem;
                color: var(--primary);
                display: flex;
                align-items: center;
            }

            .page-title i {
                margin-right: 0.75rem;
                font-size: 1.5rem;
                color: var(--primary);
            }

            .card {
                background-color: white;
                border-radius: var(--border-radius);
                box-shadow: var(--box-shadow);
                border: none;
                margin-bottom: 2rem;
                overflow: hidden;
            }

            .card-header {
                background-color: white;
                border-bottom: 1px solid var(--gray-200);
                padding: 1.25rem 1.5rem;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .card-title {
                font-size: 1.25rem;
                font-weight: 600;
                margin: 0;
                color: var(--gray-800);
            }

            .card-body {
                padding: 1.5rem;
            }

            .btn {
                font-weight: 500;
                padding: 0.625rem 1.25rem;
                border-radius: var(--border-radius);
                transition: var(--transition);
                display: inline-flex;
                align-items: center;
                justify-content: center;
                gap: 0.5rem;
                border: none;
            }

            .btn-primary {
                background-color: var(--primary);
                color: white;
            }

            .btn-primary:hover {
                background-color: var(--primary-dark);
            }

            .btn-success {
                background-color: var(--success);
                color: white;
            }

            .btn-success:hover {
                background-color: #248a7e;
            }

            .btn-danger {
                background-color: var(--danger);
                color: white;
            }

            .btn-danger:hover {
                background-color: #d62b39;
            }

            .btn-warning {
                background-color: var(--warning);
                color: white;
            }

            .btn-warning:hover {
                background-color: #e58e19;
            }

            .btn-secondary {
                background-color: var(--gray-500);
                color: white;
            }

            .btn-secondary:hover {
                background-color: var(--gray-600);
            }

            .form-control, .form-select {
                border-radius: var(--border-radius);
                border: 1px solid var(--gray-300);
                padding: 0.625rem 1rem;
                font-size: 0.95rem;
                transition: var(--transition);
            }

            .form-control:focus, .form-select:focus {
                border-color: var(--primary);
                box-shadow: 0 0 0 0.25rem rgba(34, 87, 122, 0.15);
            }

            .form-control::placeholder {
                color: var(--gray-500);
            }

            .form-label {
                font-weight: 500;
                color: var(--gray-700);
                margin-bottom: 0.5rem;
            }

            .form-group {
                margin-bottom: 1.5rem;
            }

            .form-text {
                color: var(--gray-600);
                font-size: 0.875rem;
                margin-top: 0.25rem;
            }

            .cabin-grid {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
                gap: 1.5rem;
            }

            .cabin-card {
                border: 1px solid var(--gray-300);
                border-radius: var(--border-radius);
                padding: 1.5rem;
                background-color: var(--gray-100);
                transition: var(--transition);
            }

            .cabin-card:hover {
                box-shadow: 0 0.25rem 0.5rem rgba(0, 0, 0, 0.05);
                border-color: var(--primary-light);
            }

            .cabin-header {
                display: flex;
                align-items: center;
                margin-bottom: 1rem;
                padding-bottom: 0.75rem;
                border-bottom: 1px solid var(--gray-300);
            }

            .cabin-icon {
                font-size: 1.5rem;
                color: var(--primary);
                margin-right: 0.75rem;
            }

            .cabin-title {
                font-size: 1.25rem;
                font-weight: 600;
                color: var(--primary);
                margin: 0;
            }

            .disabled-section {
                opacity: 0.6;
                pointer-events: none;
            }

            .alert {
                border-radius: var(--border-radius);
                padding: 1rem 1.5rem;
                margin-bottom: 1.5rem;
                border: none;
            }

            .alert-danger {
                background-color: rgba(230, 57, 70, 0.1);
                color: var(--danger);
                border-left: 4px solid var(--danger);
            }

            .alert-warning {
                background-color: rgba(255, 159, 28, 0.1);
                color: var(--warning);
                border-left: 4px solid var(--warning);
            }

            .hidden {
                display: none;
            }

            .progress-steps {
                display: flex;
                justify-content: space-between;
                margin-bottom: 2rem;
                position: relative;
            }

            .progress-steps::before {
                content: '';
                position: absolute;
                top: 1.25rem;
                left: 0;
                width: 100%;
                height: 2px;
                background-color: var(--gray-300);
                z-index: 1;
            }

            .step {
                position: relative;
                z-index: 2;
                background-color: white;
                padding: 0 1rem;
                text-align: center;
                flex: 1;
            }

            .step-number {
                width: 2.5rem;
                height: 2.5rem;
                display: flex;
                align-items: center;
                justify-content: center;
                border-radius: 50%;
                background-color: var(--gray-300);
                color: var(--gray-700);
                font-weight: 600;
                margin: 0 auto 0.5rem;
            }

            .step.active .step-number {
                background-color: var(--primary);
                color: white;
            }

            .step.completed .step-number {
                background-color: var(--success);
                color: white;
            }

            .step-label {
                font-size: 0.875rem;
                font-weight: 500;
                color: var(--gray-600);
            }

            .step.active .step-label {
                color: var(--primary);
                font-weight: 600;
            }

            .step.completed .step-label {
                color: var(--success);
            }

            .seat-summary {
                background-color: var(--gray-100);
                border-radius: var(--border-radius);
                padding: 1rem;
                margin-top: 1.5rem;
                border: 1px solid var(--gray-300);
            }

            .seat-summary-title {
                font-weight: 600;
                margin-bottom: 0.5rem;
                display: flex;
                align-items: center;
                gap: 0.5rem;
            }

            @media (max-width: 992px) {
                .sidebar {
                    width: 240px;
                }
                
                .content {
                    margin-left: 240px;
                    width: calc(100% - 240px);
                }
                
                .cabin-grid {
                    grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
                }
            }

            @media (max-width: 768px) {
                body {
                    flex-direction: column;
                }
                
                .sidebar {
                    width: 100%;
                    height: auto;
                    position: relative;
                    padding: 1rem;
                }
                
                .content {
                    margin-left: 0;
                    width: 100%;
                    padding: 1.5rem;
                }
                
                .cabin-grid {
                    grid-template-columns: 1fr;
                }
            }

            @media (max-width: 576px) {
                .content {
                    padding: 1rem;
                }
                
                .progress-steps {
                    flex-direction: column;
                    align-items: flex-start;
                    gap: 1rem;
                }
                
                .progress-steps::before {
                    display: none;
                }
                
                .step {
                    display: flex;
                    align-items: center;
                    width: 100%;
                    padding: 0;
                }
                
                .step-number {
                    margin: 0 1rem 0 0;
                }
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
                        <span>Manage Users</span>
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
                        <span>Manage Routes</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="#" class="nav-link">
                        <i class="fas fa-user-circle"></i>
                        <span>Account</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="#" class="nav-link">
                        <i class="fas fa-chart-bar"></i>
                        <span>Reports</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="#" class="nav-link">
                        <i class="fas fa-cog"></i>
                        <span>Settings</span>
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
                        <div class="cabin-grid" id="cabinContainer">
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
            // Mảng chứa dữ liệu các cabin có sẵn từ server
            var existingCabins = [];
            <c:forEach var="cabin" items="${cabins}">
                existingCabins.push({
                    name: '${cabin.cabinName}',
                    cabinClass: '${cabin.type}', // trường trong CSDL là "class"
                    numseat: ${cabin.numSeat},
                    imgUrl: '${cabin.imgUrl}'
                });
            </c:forEach>
            
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
                cabinContainer.innerHTML = "";
                
                for (var i = 0; i < numCabinValue; i++) {
                    // Get existing cabin data if available
                    var cabinData = (existingCabins.length > i) ? existingCabins[i] : {name: "", cabinClass: "", numseat: "", imgUrl: ""};
                    
                    // Create cabin card
                    var cabinCard = document.createElement("div");
                    cabinCard.className = "cabin-card";
                    
                    // Create cabin header
                    var cabinHeader = document.createElement("div");
                    cabinHeader.className = "cabin-header";
                    cabinHeader.innerHTML = `
                        <i class="fas fa-door-open cabin-icon"></i>
                        <h5 class="cabin-title">Cabin ${i + 1}</h5>
                    `;
                    
                    // Create cabin form
                    var cabinForm = document.createElement("div");
                    cabinForm.className = "cabin-form";
                    cabinForm.innerHTML = `
                        <div class="form-group">
                            <label class="form-label">Cabin Name</label>
                            <input type="text" class="form-control" name="cabinName" value="${cabinData.name}" required>
                        </div>
                        <div class="form-group">
                            <label class="form-label">Cabin Class</label>
                            <input type="text" class="form-control" name="cabinClass" value="${cabinData.cabinClass}" required>
                        </div>
                        <div class="form-group">
                            <label class="form-label">Number of Seats</label>
                            <input type="number" class="form-control cabin-seats" name="cabinNumseat" value="${cabinData.numseat}" required onchange="updateSeatSummary()">
                        </div>
                        <div class="form-group mb-0">
                            <label class="form-label">Image URL</label>
                            <input type="text" class="form-control" name="cabinImgUrl" value="${cabinData.imgUrl}" required>
                        </div>
                    `;
                    
                    // Append header and form to card
                    cabinCard.appendChild(cabinHeader);
                    cabinCard.appendChild(cabinForm);
                    
                    // Append card to container
                    cabinContainer.appendChild(cabinCard);
                }
                
                // Update seat summary after generating cabins
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
            document.getElementById("btnContinue").addEventListener("click", function() {
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
                
                // Generate cabin cards
                generateCabins();
            });
            
            // Back to train info
            document.getElementById("btnBackToTrain").addEventListener("click", function() {
                document.getElementById("trainInfoCard").classList.remove("disabled-section");
                document.getElementById("cabinDetailsCard").classList.add("disabled-section");
                document.getElementById("step1").classList.add("active");
                document.getElementById("step1").classList.remove("completed");
                document.getElementById("step2").classList.remove("active");
            });
            
            // Reset cabin details if train info changes
            var trainFields = ["train_model", "total_seats", "numcabin", "owner"];
            trainFields.forEach(function(id) {
                document.getElementById(id).addEventListener("change", function() {
                    // If we're not on the train info step, go back to it
                    if (!document.getElementById("step1").classList.contains("active")) {
                        document.getElementById("trainInfoCard").classList.remove("disabled-section");
                        document.getElementById("cabinDetailsCard").classList.add("disabled-section");
                        document.getElementById("step1").classList.add("active");
                        document.getElementById("step1").classList.remove("completed");
                        document.getElementById("step2").classList.remove("active");
                    }
                });
            });
            
            // Form submission validation
            document.getElementById("editTrainForm").addEventListener("submit", function(event) {
                // Check if all cabin fields are filled
                var cabinInputs = document.querySelectorAll("#cabinContainer input");
                var allFilled = true;
                
                cabinInputs.forEach(function(input) {
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

