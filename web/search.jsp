<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Kết quả tìm kiếm tuyến đường</title>
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <%@include file="components/Style.jsp" %>
        <style>
            :root {
                --primary-color: #1a73e8;
                --secondary-color: #f8f9fa;
                --accent-color: #4285f4;
                --text-color: #202124;
                --border-color: #dadce0;
                --success-color: #34a853;
                --warning-color: #fbbc05;
                --danger-color: #ea4335;
            }

            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                margin-top: 80px;
                font-family: 'Roboto', sans-serif;
                background-color: #f5f5f5;
                color: var(--text-color);
                line-height: 1.6;
                padding: 20px;
            }

            .container {
                max-width: 1200px;
                margin: 0 auto;
                background-color: white;
                border-radius: 8px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                overflow: hidden;
            }

            .search-form {
                background-color: #fff;
                padding: 20px;
                border-bottom: 1px solid var(--border-color);
            }

            .search-info {
                background-color: var(--secondary-color);
                padding: 15px 20px;
                margin-top: 10px;
                margin-bottom: 20px;
                border-radius: 8px;
                border-left: 4px solid var(--primary-color);
            }

            .search-info h3 {
                color: var(--primary-color);
                margin-bottom: 10px;
                font-size: 16px;
                display: flex;
                align-items: center;
            }

            .search-info h3 i {
                margin-right: 8px;
            }

            .search-details {
                display: flex;
                flex-wrap: wrap;
                gap: 15px;
            }

            .search-detail-item {
                background-color: white;
                padding: 8px 12px;
                border-radius: 6px;
                box-shadow: 0 1px 2px rgba(0, 0, 0, 0.1);
                display: flex;
                align-items: center;
            }

            .search-detail-item i {
                color: var(--primary-color);
                margin-right: 8px;
            }

            .route-section {
                padding: 20px;
                margin-bottom: 20px;
            }

            .route-section h2 {
                color: var(--primary-color);
                font-size: 20px;
                margin-bottom: 15px;
                display: flex;
                align-items: center;
            }

            .route-section h2 i {
                margin-right: 10px;
            }

            .route-card {
                background-color: white;
                border-radius: 8px;
                box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
                margin-bottom: 15px;
                overflow: hidden;
            }

            .route-card-header {
                background-color: var(--secondary-color);
                padding: 12px 15px;
                font-weight: 500;
                border-bottom: 1px solid var(--border-color);
                display: flex;
                justify-content: space-between;
            }

            .route-code {
                color: var(--primary-color);
                font-weight: 700;
            }

            .route-status {
                padding: 3px 8px;
                border-radius: 12px;
                font-size: 12px;
                font-weight: 500;
                background-color: var(--success-color);
                color: white;
            }

            .route-card-body {
                padding: 15px;
                display: flex;
                flex-wrap: wrap;
            }

            .route-info {
                flex: 1;
                min-width: 250px;
                margin-bottom: 10px;
            }

            .station {
                display: flex;
                align-items: flex-start;
                margin-bottom: 15px;
            }

            .station-icon {
                width: 24px;
                height: 24px;
                background-color: var(--primary-color);
                color: white;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                margin-right: 10px;
                font-size: 12px;
            }

            .station-details {
                flex: 1;
            }

            .station-name {
                font-weight: 500;
            }

            .station-time {
                color: #5f6368;
                font-size: 14px;
            }

            .route-path {
                position: relative;
                margin-left: 12px;
                padding-left: 22px;
                height: 30px;
            }

            .route-path:before {
                content: '';
                position: absolute;
                left: 0;
                top: 0;
                height: 100%;
                width: 2px;
                background-color: var(--primary-color);
            }

            .pagination {
                display: flex;
                justify-content: center;
                margin: 20px 0;
                padding: 10px;
            }

            .pagination a {
                display: inline-flex;
                align-items: center;
                justify-content: center;
                width: 36px;
                height: 36px;
                margin: 0 5px;
                background-color: white;
                color: var(--primary-color);
                text-decoration: none;
                border-radius: 50%;
                font-weight: 500;
                box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
                transition: all 0.2s ease;
            }

            .pagination a:hover {
                background-color: var(--secondary-color);
            }

            .pagination a.active {
                background-color: var(--primary-color);
                color: white;
            }

            .empty-results {
                text-align: center;
                padding: 40px 20px;
                color: #5f6368;
            }

            @media (max-width: 768px) {
                .route-card-body {
                    flex-direction: column;
                }

                .route-info {
                    width: 100%;
                }

                .search-details {
                    flex-direction: column;
                    gap: 10px;
                }
            }
        </style>
    </head>
    <body>
        <%-- Xử lý giá trị của trang hiện tại --%>
        <c:set var="page" value="${param.page != null ? param.page : 1}" />
        <%@include file="components/Header.jsp" %>
        <div class="container">

            <!-- Search Information Section -->
            <div class="search-info">
                <h3><i class="fas fa-search"></i>Search Information</h3>
                <div class="search-details">
                    <div class="search-detail-item">
                        <span>Departure: <strong>${departureStation}</strong></span>
                    </div>
                    <div class="search-detail-item">
                        <span>Arrival: <strong>${arrivalStation}</strong></span>
                    </div>
                    <div class="search-detail-item">
                        <span>Departure Date: <strong>${departureDate}</strong></span>
                    </div>
                    <c:if test="${not empty arrivalDate}">
                        <div class="search-detail-item">
                            <span>Return Date: <strong>${arrivalDate}</strong></span>
                        </div>
                        <div class="search-detail-item">
                            <span>Trip Type: <strong>Round Trip</strong></span>
                        </div>
                    </c:if>
                    <c:if test="${empty arrivalDate}">
                        <div class="search-detail-item">
                            <span>Trip Type: <strong>One Way</strong></span>
                        </div>
                    </c:if>
                </div>
            </div>

            <div class="route-section">
                <h2><i class="fas fa-long-arrow-alt-right"></i>One way route</h2>

                <c:if test="${not empty routes}">
                    <c:forEach var="route" items="${routes}" begin="${(page - 1) * 3}" end="${page * 3 - 1}">
                        <div class="route-card">
                            <div class="route-card-header">
                                <a href="ViewRoute?id=${route.id}" class="route-code">Route name: ${route.routeCode}</a>
                            </div>
                            <div class="route-card-body">
                                <div class="route-info">
                                    <div class="station">
                                        <div class="station-icon">
                                            <i class="fas fa-map-marker-alt"></i>
                                        </div>
                                        <div class="station-details">
                                            <div class="station-name">Departure station: ${route.departureStation}</div>
                                            <div class="station-time">Departure time: ${route.departureTime}</div>
                                        </div>
                                    </div>

                                    <div class="route-path"></div>

                                    <div class="station">
                                        <div class="station-icon">
                                            <i class="fas fa-flag-checkered"></i>
                                        </div>
                                        <div class="station-details">
                                            <div class="station-name">Arrival station: ${route.arrivalStation}</div>
                                            <div class="station-time">Arrival time: ${route.arrivalTime}</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>

                    <div class="pagination">
                        <c:forEach var="i" begin="1" end="${(routes.size() + 2) / 3}">
                            <a href="search.jsp?page=${i}" class="${i == page ? 'active' : ''}">${i}</a>
                        </c:forEach>
                    </div>
                </c:if>

                <c:if test="${empty routes}">
                    <div class="empty-results">
                        <i class="fas fa-info-circle"></i> No one-way routes found.
                    </div>
                </c:if>
            </div>
            <div class="route-section">
                <h2><i class="fas fa-exchange-alt"></i>Round trip route</h2>
                <c:if test="${not empty routeRTs}">
                    <c:forEach var="route" items="${routeRTs}" begin="${(page - 1) * 3}" end="${page * 3 - 1}">
                        <div class="route-card">
                            <div class="route-card-header">
                                <a href="ViewRoute?id=${route.id}" class="route-code">Route name: ${route.routeCode}</a>
                            </div>
                            <div class="route-card-body">
                                <div class="route-info">
                                    <div class="station">
                                        <div class="station-icon">
                                            <i class="fas fa-map-marker-alt"></i>
                                        </div>
                                        <div class="station-details">
                                            <div class="station-name">Departure station: ${route.departureStation}</div>
                                            <div class="station-time">Departure time: ${route.departureTime}</div>
                                        </div>
                                    </div>

                                    <div class="route-path"></div>

                                    <div class="station">
                                        <div class="station-icon">
                                            <i class="fas fa-flag-checkered"></i>
                                        </div>
                                        <div class="station-details">
                                            <div class="station-name">Arrival station: ${route.arrivalStation}</div>
                                            <div class="station-time">Arrival time: ${route.arrivalTime}</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>

                    <div class="pagination">
                        <c:forEach var="i" begin="1" end="${(routeRTs.size() + 2) / 3}">
                            <a href="search.jsp?page=${i}" class="${i == page ? 'active' : ''}">${i}</a>
                        </c:forEach>
                    </div>
                </c:if>

                <c:if test="${empty routeRTs}">
                    <div class="empty-results">
                        <i class="fas fa-info-circle"></i> No return routes found.
                    </div>
                </c:if>
            </div>
        </div>
    </body>
</html>