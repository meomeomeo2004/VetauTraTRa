<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Route Search Results</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-color: #3a86ff;
            --primary-dark: #2667cc;
            --secondary-color: #f8f9fa;
            --accent-color: #ff9e00;
            --text-color: #333;
            --text-light: #6c757d;
            --border-color: #dee2e6;
            --card-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
            --border-radius: 12px;
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Inter', sans-serif;
            background-color: #f5f7fa;
            color: var(--text-color);
            line-height: 1.6;
            padding: 0;
            margin: 0;
        }
        
        .container {
            max-width: 1000px;
            margin: 0 auto;
            padding: 30px 20px;
        }
        
        .page-header {
            text-align: center;
            margin-bottom: 40px;
        }
        
        .page-title {
            font-size: 2.2rem;
            font-weight: 700;
            color: var(--primary-color);
            margin-bottom: 10px;
        }
        
        .search-summary {
            background-color: white;
            border-radius: var(--border-radius);
            box-shadow: var(--card-shadow);
            padding: 25px;
            margin-bottom: 40px;
            position: relative;
            overflow: hidden;
        }
        
        .search-summary::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 5px;
            height: 100%;
            background-color: var(--primary-color);
        }
        
        .summary-title {
            font-size: 1.4rem;
            font-weight: 600;
            color: var(--primary-color);
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 1px solid var(--border-color);
        }
        
        .search-details {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
        }
        
        .detail-item {
            margin-bottom: 5px;
        }
        
        .detail-label {
            font-size: 0.85rem;
            font-weight: 600;
            color: var(--text-light);
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 5px;
        }
        
        .detail-value {
            font-size: 1.1rem;
            font-weight: 500;
        }
        
        .results-title {
            font-size: 1.4rem;
            font-weight: 600;
            color: var(--primary-color);
            margin: 30px 0 20px;
        }
        
        .route-cards {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
        }
        
        .route-card {
            background-color: white;
            border-radius: var(--border-radius);
            box-shadow: var(--card-shadow);
            padding: 20px;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }
        
        .route-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.12);
        }
        
        .route-code {
            font-size: 1.2rem;
            font-weight: 700;
            color: var(--primary-color);
            margin-bottom: 15px;
            display: block;
            text-decoration: none;
            transition: color 0.2s;
        }
        
        .route-code:hover {
            color: var(--primary-dark);
            text-decoration: underline;
        }
        
        .route-info {
            margin-bottom: 15px;
        }
        
        .station-info {
            display: flex;
            align-items: flex-start;
            margin-bottom: 15px;
        }
        
        .station-icon {
            width: 24px;
            height: 24px;
            background-color: var(--primary-color);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 12px;
            flex-shrink: 0;
            margin-top: 3px;
        }
        
        .departure-icon::before {
            content: '';
            display: block;
            width: 10px;
            height: 10px;
            border-radius: 50%;
            background-color: white;
            position: relative;
        }
        
        .arrival-icon {
            background-color: var(--accent-color);
        }
        
        .arrival-icon::before {
            content: '';
            display: block;
            width: 10px;
            height: 10px;
            border-radius: 50%;
            background-color: white;
            position: relative;
        }
        
        .station-details {
            flex-grow: 1;
        }
        
        .station-name {
            font-weight: 600;
            margin-bottom: 3px;
        }
        
        .station-time {
            font-size: 0.9rem;
            color: var(--text-light);
        }
        
        .route-divider {
            height: 30px;
            border-left: 2px dashed var(--border-color);
            margin-left: 12px;
            margin-bottom: 15px;
        }
        
        .no-results {
            text-align: center;
            padding: 40px;
            background-color: white;
            border-radius: var(--border-radius);
            box-shadow: var(--card-shadow);
        }
        
        .no-results p {
            font-size: 1.1rem;
            color: var(--text-light);
        }
        
        @media (max-width: 768px) {
            .container {
                padding: 20px 15px;
            }
            
            .page-title {
                font-size: 1.8rem;
            }
            
            .route-cards {
                grid-template-columns: 1fr;
            }
            
            .search-details {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="page-header">
            <h1 class="page-title">Route Search Results</h1>
        </div>
        
        <div class="search-summary">
            <h2 class="summary-title">Search Parameters</h2>
            <div class="search-details">
                <div class="detail-item">
                    <div class="detail-label">Departure Station</div>
                    <div class="detail-value">${sessionScope.departureStation}</div>
                </div>
                <div class="detail-item">
                    <div class="detail-label">Arrival Station</div>
                    <div class="detail-value">${sessionScope.arrivalStation}</div>
                </div>
                <div class="detail-item">
                    <div class="detail-label">Departure Date</div>
                    <div class="detail-value">${sessionScope.departureDate}</div>
                </div>
                <div class="detail-item">
                    <div class="detail-label">Arrival Date</div>
                    <div class="detail-value">${sessionScope.arrivalDate}</div>
                </div>
            </div>
        </div>
        
        <h2 class="results-title">Available Routes</h2>
        
        <c:choose>
            <c:when test="${not empty sessionScope.routes}">
                <div class="route-cards">
                    <c:forEach var="route" items="${sessionScope.routes}">
                        <div class="route-card">
                            <a href="ViewRoute?id=${route.id}" class="route-code">${route.routeCode}</a>
                            
                            <div class="route-info">
                                <div class="station-info">
                                    <div class="station-icon departure-icon"></div>
                                    <div class="station-details">
                                        <div class="station-name">${route.departureStation}</div>
                                        <div class="station-time">${route.departureTime}</div>
                                    </div>
                                </div>
                                
                                <div class="route-divider"></div>
                                
                                <div class="station-info">
                                    <div class="station-icon arrival-icon"></div>
                                    <div class="station-details">
                                        <div class="station-name">${route.arrivalStation}</div>
                                        <div class="station-time">${route.arrivalTime}</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <div class="no-results">
                    <p>No routes found matching your search criteria.</p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>
