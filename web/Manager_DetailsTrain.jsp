<%-- 
    Document   : Manager_DetailsTrain
    Created on : Mar 2, 2025, 4:47:10 PM
    Author     : ASUS
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Train Details</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --navy: #22577a;
            --navy-light: #2d6a92;
            --navy-dark: #1b4560;
            --gold: #bc986a;
            --gold-light: #d4b48c;
            --gold-dark: #a68659;
            --white: #ffffff;
            --light-gray: #f8f9fa;
            --medium-gray: #e9ecef;
        }
        
        body {
            background-color: var(--light-gray);
            font-family: 'Segoe UI', Arial, sans-serif;
            min-height: 100vh;
        }
        
        .main-container {
            max-width: 1200px;
            margin: 50px auto;
            padding: 0 20px;
        }
        
        .card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
            overflow: hidden;
            transition: all 0.3s ease;
            background-color: var(--white);
        }
        
        .card-header {
            background: linear-gradient(90deg, var(--navy) 0%, var(--navy-light) 100%);
            color: var(--white);
            padding: 20px;
            border: none;
        }
        
        .cabin-card {
            height: 100%;
            border: none;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            background-color: var(--white);
        }
        
        .cabin-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
        }
        
        .cabin-img-container {
            position: relative;
            height: 180px;
            overflow: hidden;
        }
        
        .cabin-img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        
        .cabin-type-badge {
            position: absolute;
            top: 10px;
            right: 10px;
            z-index: 10;
        }
        
        .info-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 8px 0;
            border-bottom: 1px solid var(--medium-gray);
        }
        
        .info-row:last-child {
            border-bottom: none;
        }
        
        .info-label {
            font-weight: 600;
            color: var(--navy);
        }
        
        .tab-content {
            padding: 20px 0;
        }
        
        .nav-tabs .nav-link {
            border: none;
            padding: 12px 20px;
            color: #6b7280;
            font-weight: 500;
            border-radius: 0;
        }
        
        .nav-tabs .nav-link.active {
            color: var(--navy);
            border-bottom: 3px solid var(--navy);
            background-color: transparent;
        }
        
        .maintenance-alert {
            background-color: rgba(34, 87, 122, 0.1);
            border-radius: 10px;
            padding: 15px;
            display: flex;
            align-items: center;
            max-width: 500px;
            margin: 20px auto 0;
            border-left: 4px solid var(--gold);
        }
        
        .maintenance-icon {
            font-size: 2rem;
            color: var(--gold);
            margin-right: 15px;
            animation: spin 10s linear infinite;
        }
        
        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
        
        /* Badge colors */
        .badge-first-class {
            background-color: var(--navy-dark);
        }
        
        .badge-business {
            background-color: var(--navy);
        }
        
        .badge-economy-plus {
            background-color: var(--navy-light);
        }
        
        .badge-economy {
            background-color: var(--gold-dark);
        }
        
        .badge-special {
            background-color: var(--gold);
            color: #fff;
        }
        
        .fade-in {
            animation: fadeIn 0.5s ease-in-out;
        }
        
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        .cabin-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
        }
        
        .back-button {
            background-color: transparent;
            border: 1px solid var(--white);
            color: var(--white);
            transition: all 0.3s ease;
        }
        
        .back-button:hover {
            background-color: var(--white);
            color: var(--navy);
        }
        
        .cabin-details-btn {
            width: 100%;
            background-color: transparent;
            border: 1px solid var(--navy);
            color: var(--navy);
            transition: all 0.3s ease;
        }
        
        .cabin-details-btn:hover {
            background-color: var(--navy);
            color: var(--white);
        }
        
        .text-navy {
            color: var(--navy);
        }
        
        .text-gold {
            color: var(--gold);
        }
        
        .bg-navy {
            background-color: var(--navy);
        }
        
        .bg-gold {
            background-color: var(--gold);
        }
        
        /* Status badges */
        .badge-active {
            background-color: var(--navy);
        }
        
        .badge-maintenance {
            background-color: var(--gold);
            color: #fff;
        }
        
        .badge-inactive {
            background-color: #dc3545;
        }
        
        /* Icon colors */
        .icon-navy {
            color: var(--navy);
        }
        
        .icon-gold {
            color: var(--gold);
        }
    </style>
</head>
<body>
    <div class="main-container">
        <div class="card">
            <!-- Header -->
            <div class="card-header">
                <div class="d-flex justify-content-between align-items-center">
                    <div class="d-flex align-items-center">
                        <i class="fas fa-train me-2 fs-4"></i>
                        <h2 class="mb-0">Train Details</h2>
                    </div>
                    <a href="listtrain" class="btn back-button">
                        <i class="fas fa-arrow-left me-2"></i> Back to List
                    </a>
                </div>
            </div>
            
            <!-- Content -->
            <div class="card-body p-4">
                <!-- Tabs -->
                <ul class="nav nav-tabs mb-4" id="trainTabs" role="tablist">
                    <li class="nav-item" role="presentation">
                        <button class="nav-link active" id="info-tab" data-bs-toggle="tab" data-bs-target="#info" type="button" role="tab" aria-controls="info" aria-selected="true">
                            <i class="fas fa-train me-2 icon-navy"></i> Train Information
                        </button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="cabins-tab" data-bs-toggle="tab" data-bs-target="#cabins" type="button" role="tab" aria-controls="cabins" aria-selected="false">
                            <i class="fas fa-home me-2 icon-navy"></i> Cabins (${train.numCabin})
                        </button>
                    </li>
                </ul>
                
                <!-- Tab Content -->
                <div class="tab-content" id="trainTabsContent">
                    <!-- Train Info Tab -->
                    <div class="tab-pane fade show active" id="info" role="tabpanel" aria-labelledby="info-tab">
                        <div class="card">
                            <div class="card-body p-4">
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="info-row">
                                            <span class="info-label">ID</span>
                                            <span>${train.id}</span>
                                        </div>
                                        <div class="info-row">
                                            <span class="info-label">Model</span>
                                            <span>${train.trainid}</span>
                                        </div>
                                        <div class="info-row">
                                            <span class="info-label">Owner</span>
                                            <span>${train.owner}</span>
                                        </div>
                                    </div>
                                    
                                    <div class="col-md-6">
                                        <div class="info-row">
                                            <span class="info-label">Total Seats</span>
                                            <span><i class="fas fa-users me-2 icon-gold"></i>${train.totalSeats}</span>
                                        </div>
                                        <div class="info-row">
                                            <span class="info-label">Total Cabins</span>
                                            <span><i class="fas fa-home me-2 icon-gold"></i>${train.numCabin}</span>
                                        </div>
                                        <div class="info-row">
                                            <span class="info-label">Status</span>
                                            <c:choose>
                                                <c:when test="${train.status == 1}">
                                                    <span class="badge badge-active">Active</span>
                                                </c:when>
                                                <c:when test="${train.status == 2}">
                                                    <span class="badge badge-maintenance">Maintenance</span>
                                                </c:when>
                                                <c:when test="${train.status == 0}">
                                                    <span class="badge badge-inactive">Inactive</span>
                                                </c:when>
                                                    <c:when test="${train.status == 4}">
                                                    <span class="badge badge-maintenance">New Train Waiting</span>
                                                </c:when>
                                                <c:when test="${train.status == 5}">
                                                    <span class="badge badge-maintenance">Train Edited Waiting</span>
                                                </c:when>
                                                <c:when test="${train.status == 6}">
                                                    <span class="badge badge-inactive">Seller Reject</span>
                                                </c:when>
                                            </c:choose>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="maintenance-alert mt-4">
                                    <i class="fas fa-cog maintenance-icon"></i>
                                    <div>
                                        <h5 class="mb-1 text-navy">Maintenance Schedule</h5>
                                        <p class="mb-0 text-navy small">Next maintenance check scheduled in 45 days</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Cabins Tab -->
                    <div class="tab-pane fade" id="cabins" role="tabpanel" aria-labelledby="cabins-tab">
                        <div class="cabin-grid">
                            <c:forEach items="${cabinlist}" var="cabin" varStatus="status">
                                <div class="cabin-card-container" data-index="${status.index}">
                                    <div class="cabin-card">
                                        <div class="cabin-img-container">
                                            <img src="${cabin.imgUrl}" class="cabin-img" alt="${cabin.cabinName}">
                                            <div class="cabin-type-badge">
                                                <c:choose>
                                                    <c:when test="${cabin.type == 'First Class'}">
                                                        <span class="badge badge-first-class">First Class</span>
                                                    </c:when>
                                                    <c:when test="${cabin.type == 'Business'}">
                                                        <span class="badge badge-business">Business</span>
                                                    </c:when>
                                                    <c:when test="${cabin.type == 'Economy Plus'}">
                                                        <span class="badge badge-economy-plus">Economy Plus</span>
                                                    </c:when>
                                                    <c:when test="${cabin.type == 'Economy'}">
                                                        <span class="badge badge-economy">Economy</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge badge-special">Special</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                        <div class="card-body">
                                            <h5 class="card-title text-navy">${cabin.cabinName}</h5>
                                            <div class="d-flex justify-content-between align-items-center mb-2 small">
                                                <span class="text-navy">Class:</span>
                                                <span class="fw-medium">${cabin.type}</span>
                                            </div>
                                            <div class="d-flex justify-content-between align-items-center small">
                                                <span class="text-navy">Seats:</span>
                                                <span class="fw-medium">
                                                    <i class="fas fa-users me-1 icon-gold"></i>
                                                    ${cabin.numSeat}
                                                </span>
                                            </div>
                                            <div class="mt-3">
                                                <button class="btn cabin-details-btn">View Details</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Animation for cabin cards
        document.addEventListener('DOMContentLoaded', function() {
            // Add animation when switching to cabins tab
            document.getElementById('cabins-tab').addEventListener('shown.bs.tab', function() {
                const cabinCards = document.querySelectorAll('.cabin-card-container');
                cabinCards.forEach((card, index) => {
                    setTimeout(() => {
                        card.classList.add('fade-in');
                    }, index * 100);
                });
            });
            
            // Reset animation when switching away from cabins tab
            document.getElementById('cabins-tab').addEventListener('hide.bs.tab', function() {
                const cabinCards = document.querySelectorAll('.cabin-card-container');
                cabinCards.forEach(card => {
                    card.classList.remove('fade-in');
                });
            });
        });
    </script>
</body>
</html>