<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!doctype html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>News List - Tratra</title>
        <%@ include file="components/Style.jsp" %>
        <style>
            :root {
                --navy: #22577a;
                --yellow: #ffbe0b;
                --navy-light: #2c6a92;
                --navy-dark: #1a4258;
                --yellow-light: #ffd04c;
            }

            /* Hero section */
            .news-hero {
                background-color: var(--navy);
                color: white;
                padding: 50px 0;
                margin-bottom: 40px;
                position: relative;
            }

            .news-hero::after {
                content: "";
                position: absolute;
                bottom: 0;
                left: 0;
                right: 0;
                height: 5px;
                background-color: var(--yellow);
            }

            .news-hero h1 {
                font-size: 32px;
                font-weight: 700;
                margin-bottom: 10px;
            }

            .news-hero p {
                opacity: 0.8;
                max-width: 600px;
                margin: 0 auto;
            }

            /* News list styling */
            .news-container {
                max-width: 900px;
                margin: 0 auto 60px;
                padding: 0 15px;
            }

            .news-item {
                background-color: white;
                border-radius: 8px;
                box-shadow: 0 3px 10px rgba(0, 0, 0, 0.08);
                padding: 25px;
                margin-bottom: 25px;
                transition: transform 0.2s ease, box-shadow 0.2s ease;
                border-left: 4px solid var(--navy);
                position: relative;
                overflow: hidden;
            }

            .news-item:hover {
                transform: translateY(-5px);
                box-shadow: 0 8px 20px rgba(0, 0, 0, 0.12);
            }

            .news-item::before {
                content: "";
                position: absolute;
                top: 0;
                right: 0;
                width: 100px;
                height: 100px;
                background-color: var(--yellow);
                opacity: 0.1;
                border-radius: 0 0 0 100%;
            }

            .news-item h3 {
                color: var(--navy);
                font-size: 22px;
                margin-bottom: 10px;
                font-weight: 600;
            }

            .news-date {
                display: inline-flex;
                align-items: center;
                color: #666;
                font-size: 14px;
                margin-bottom: 15px;
            }

            .news-date i {
                color: var(--yellow);
                margin-right: 6px;
            }

            .news-content {
                color: #444;
                line-height: 1.6;
                margin-bottom: 20px;
            }

            .btn-read-more {
                background-color: var(--navy);
                color: white;
                padding: 8px 20px;
                border-radius: 50px;
                text-decoration: none;
                display: inline-flex;
                align-items: center;
                transition: all 0.2s ease;
                font-weight: 500;
                border: none;
            }

            .btn-read-more:hover {
                background-color: var(--yellow);
                color: var(--navy-dark);
                transform: translateX(5px);
            }

            .btn-read-more i {
                margin-left: 8px;
            }

            /* Empty state */
            .empty-state {
                text-align: center;
                padding: 60px 20px;
                background-color: #f9f9f9;
                border-radius: 8px;
                margin-top: 20px;
            }

            .empty-state i {
                font-size: 48px;
                color: var(--navy);
                opacity: 0.3;
                margin-bottom: 15px;
            }

            .empty-state p {
                font-size: 18px;
                color: #666;
            }
            .pagination {
                text-align: center;
                margin: 20px 0;
            }

            .pagination-list {
                list-style: none;
                display: inline-flex;
                gap: 5px;
                padding: 0;
            }

            .pagination-list li {
                display: inline;
            }

            .pagination-list li a {
                color: #007bff;
                padding: 8px 12px;
                text-decoration: none;
                border: 1px solid #ddd;
                border-radius: 4px;
            }

            .pagination-list li.active a {
                background-color: #007bff;
                color: white;
            }

            .pagination-list li a:hover {
                background-color: #0056b3;
                color: white;
            }

            /* Pagination Styling */
            .pagination {
                display: flex;
                justify-content: center;
                margin: 25px 0;
            }

            .pagination-list {
                display: flex;
                list-style: none;
                padding: 0;
                margin: 0;
                border-radius: 8px;
                overflow: hidden;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            }

            .pagination-list li {
                margin: 0;
                border-right: 1px solid rgba(0, 0, 0, 0.05);
            }

            .pagination-list li:last-child {
                border-right: none;
            }

            .pagination-list li button {
                display: flex;
                align-items: center;
                justify-content: center;
                min-width: 40px;
                height: 40px;
                padding: 0 15px;
                background-color: white;
                color: var(--navy);
                border: none;
                font-weight: 500;
                cursor: pointer;
                transition: all 0.3s ease;
            }

            .pagination-list li:not(.active) button:hover {
                background-color: rgba(255, 190, 11, 0.15);
            }

            .pagination-list li.active button {
                background-color: var(--navy);
                color: white;
                position: relative;
            }

            .pagination-list li.active button::after {
                content: "";
                position: absolute;
                bottom: 0;
                left: 0;
                right: 0;
                height: 3px;
                background-color: var(--yellow);
            }
            /* Filter Form Styling */
            .filter-form {
                margin-bottom: 30px;
                padding: 20px;
                background-color: #f8f9fa;
                border-radius: 8px;
                border-left: 4px solid var(--navy);
                box-shadow: 0 3px 10px rgba(0, 0, 0, 0.05);
                display: flex;
                flex-wrap: wrap;
                gap: 12px;
                align-items: center;
            }

            .filter-form input[type="text"],
            .filter-form input[type="date"] {
                padding: 10px 15px;
                border: 1px solid #e0e0e0;
                border-radius: 6px;
                font-size: 14px;
                flex: 1;
                min-width: 200px;
                transition: all 0.3s ease;
            }

            .filter-form input[type="text"]:focus,
            .filter-form input[type="date"]:focus {
                border-color: var(--navy);
                box-shadow: 0 0 0 3px rgba(34, 87, 122, 0.1);
                outline: none;
            }

            .filter-form button {
                background-color: var(--yellow);
                color: var(--navy-dark);
                border: none;
                padding: 10px 20px;
                border-radius: 6px;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s ease;
                min-width: 100px;
            }

            .filter-form button:hover {
                background-color: var(--yellow-dark);
                transform: translateY(-2px);
                box-shadow: 0 4px 8px rgba(255, 190, 11, 0.3);
            }

            .filter-form button:active {
                transform: translateY(0);
            }



            /* Responsive adjustments */
            @media (max-width: 768px) {
                .news-hero {
                    padding: 40px 0;
                }

                .news-hero h1 {
                    font-size: 28px;
                }

                .news-item {
                    padding: 20px;
                }

                .news-item h3 {
                    font-size: 20px;
                }
                .filter-form {
                    flex-direction: column;
                    align-items: stretch;
                }

                .filter-form input[type="text"],
                .filter-form input[type="date"] {
                    width: 100%;
                }

                .filter-form button {
                    width: 100%;
                }
            }
        </style>
    <section class="breadcrumb_area">
        <div class="overlay bg-parallax" data-stellar-ratio="0.8" data-stellar-vertical-offset="0"></div>
        <div class="container">
            <div class="page-cover text-center">
                <h2 class="page-cover-tittle">List News </h2>
                <ol class="breadcrumb">
                    <li><a href="/tratra">Home</a></li>
                    <li><a href="list-news">List News</a></li>
                    <li class="active">Details</li>
                </ol>
            </div>
        </div>
    </section>
    <%@ include file="components/Header.jsp" %>
</head>
<body>
    <%@ include file="components/Header.jsp" %>

    <!-- News Hero Section -->


    <!-- News List Section -->
    <div class="news-container mt-5">
        <form class="filter-form" action="list-news" method="get" >
            <input type="text" name="title" placeholder="Search by title" value="${title}">
            <input type="date" name="createdAt" value="${createdAt}">
            <button type="submit">Filter</button>

            <c:if test="${not empty allNewsList}">
                <c:forEach var="news" items="${allNewsList}">
                    <div class="news-item">
                        <h3>${news.title}</h3>
                        <p class="news-date">
                            <i class="fa fa-calendar"></i>
                            <fmt:formatDate value="${news.createdAt}" pattern="MMMM d, yyyy" />
                        </p>
                        <div class="news-content">
                            ${fn:substring(news.content, 0, 200)}...
                        </div>
                        <a href="news?id=${news.id}" class="btn-read-more">
                            Read More <i class="fa fa-arrow-right"></i>
                        </a>
                    </div>
                </c:forEach>
            </c:if>
            <c:if test="${empty allNewsList}">
                <div class="empty-state">
                    <i class="fa fa-newspaper-o"></i>
                    <p>No news available at the moment. Check back soon for updates!</p>
                </div>
            </c:if>
            <div class="pagination">
                <c:if test="${totalPages > 1}">
                    <ul class="pagination-list">
                        <li class="${currentPage == 1 ? 'disabled' : ''}">
                            <button type="submit" name="page" value="${currentPage - 1}" ${currentPage == 1 ? 'disabled' : ''}>
                                Previous
                            </button>
                        </li>
                        <li class="active">
                            <button type="submit" disabled>
                                Page ${currentPage} of ${totalPages}
                            </button>
                        </li>
                        <li class="${currentPage == totalPages ? 'disabled' : ''}">
                            <button type="submit" name="page" value="${currentPage + 1}" ${currentPage == totalPages ? 'disabled' : ''}>
                                Next
                            </button>
                        </li>
                    </ul>
                </c:if>
            </div>
        </form>
    </div>

    <%@ include file="components/Footer.jsp" %>
    <%@ include file="components/Script.jsp" %>
</body>
</html>