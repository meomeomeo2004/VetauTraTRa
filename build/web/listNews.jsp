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
            }
        </style>
    </head>
    <body>
        <%@ include file="components/Header.jsp" %>

        <!-- News Hero Section -->
        <section class="news-hero text-center">
            <div class="container">
                <h1>Latest News & Updates</h1>
                <p>Stay informed about our latest announcements, updates, and special offers</p>
            </div>
        </section>

        <!-- News List Section -->
        <div class="news-container">
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
        </div>

        <%@ include file="components/Footer.jsp" %>
        <%@ include file="components/Script.jsp" %>
    </body>
</html>