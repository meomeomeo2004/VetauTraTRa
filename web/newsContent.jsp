<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!doctype html>
<html lang="en">
    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link rel="icon" href="image/favicon.png" type="image/png">
        <title>${newsContent.title} - News</title>
        <%@include file="components/Style.jsp" %>
        <style>
            :root {
                --navy: #22577a;
                --yellow: #ffbe0b;
            }

            /* Breadcrumb styling */
            .breadcrumb_area {
                background-color: var(--navy);
                position: relative;
            }

            .breadcrumb_area .overlay {
                background-color: rgba(0, 0, 0, 0.2);
            }

            .page-cover-tittle {
                color: white;
                position: relative;
            }

            .page-cover-tittle::after {
                content: "";
                display: block;
                width: 80px;
                height: 4px;
                background-color: var(--yellow);
                margin: 15px auto 0;
            }

            .breadcrumb {
                background: transparent;
                justify-content: center;
            }

            .breadcrumb li a {
                color: var(--yellow);
                text-decoration: none;
            }

            .breadcrumb li.active {
                color: white;
            }

            .breadcrumb-item+.breadcrumb-item::before {
                color: rgba(255, 255, 255, 0.5);
            }

            /* News content styling */
            .news-content-container {
                max-width: 800px;
                margin: 50px auto;
                padding: 0;
                background-color: white;
                border-radius: 10px;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
                overflow: hidden;
            }

            .news-header {
                background-color: var(--navy);
                padding: 30px;
                position: relative;
            }

            .news-header::after {
                content: "";
                position: absolute;
                bottom: 0;
                left: 0;
                right: 0;
                height: 5px;
                background-color: var(--yellow);
            }

            .news-title {
                font-size: 28px;
                font-weight: bold;
                color: white;
                margin-bottom: 15px;
            }

            .news-date {
                font-size: 14px;
                color: var(--yellow);
                display: flex;
                align-items: center;
            }

            .news-date i {
                margin-right: 8px;
            }

            .news-body {
                padding: 35px;
            }

            .news-content {
                font-size: 17px;
                line-height: 1.8;
                color: #444;
                margin-bottom: 30px;
                text-align: justify;
            }

            .news-content p:first-child::first-letter {
                font-size: 3.5em;
                font-weight: bold;
                color: var(--navy);
                float: left;
                line-height: 0.8;
                margin-right: 10px;
                margin-top: 5px;
            }

            .news-footer {
                border-top: 1px solid #eee;
                padding-top: 25px;
                text-align: center;
            }

            .btn-back {
                display: inline-flex;
                align-items: center;
                background-color: var(--navy);
                color: white;
                padding: 12px 25px;
                border-radius: 50px;
                text-decoration: none;
                transition: all 0.3s ease;
                font-weight: 500;
                box-shadow: 0 4px 10px rgba(34, 87, 122, 0.3);
            }

            .btn-back:hover {
                background-color: var(--yellow);
                color: var(--navy);
                transform: translateY(-3px);
                box-shadow: 0 6px 15px rgba(255, 190, 11, 0.4);
            }

            .btn-back i {
                margin-right: 8px;
            }

            /* Decorative elements */
            .news-icon {
                position: absolute;
                top: -25px;
                left: 50%;
                transform: translateX(-50%);
                width: 50px;
                height: 50px;
                background-color: var(--yellow);
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                color: var(--navy);
                font-size: 20px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
            }

            .highlight-box {
                background-color: rgba(255, 190, 11, 0.1);
                border-left: 4px solid var(--yellow);
                padding: 20px;
                margin: 25px 0;
                border-radius: 0 5px 5px 0;
            }

            .highlight-box p {
                margin: 0;
                color: var(--navy);
                font-style: italic;
            }

            @media (max-width: 768px) {
                .news-title {
                    font-size: 24px;
                }

                .news-body {
                    padding: 25px;
                }

                .news-content {
                    font-size: 16px;
                }
            }
        </style>
        <!-- Breadcrumb Area -->
    <section class="breadcrumb_area">
        <div class="overlay bg-parallax" data-stellar-ratio="0.8" data-stellar-vertical-offset="0"></div>
        <div class="container">
            <div class="page-cover text-center">
                <h2 class="page-cover-tittle">News Details</h2>
                <ol class="breadcrumb">
                    <li><a href="/tratra">Home</a></li>
                    <li><a href="news">News</a></li>
                    <li class="active">Details</li>
                </ol>
            </div>
        </div>
    </section>
    <%@ include file="components/Header.jsp" %>

</head>
<body>
    <!--================ Header Area =================-->
    <%@include file="components/Header.jsp" %>
    <!--================ Header Area =================-->

    <!--================ News Content Area =================-->
    <div class="container">
        <div class="news-content-container">
            <!-- Header của bài viết -->
            <div class="news-header">
                <div class="news-icon">
                    <i class="fa fa-newspaper-o"></i>
                </div>
                <h1 class="news-title">${newsContent.title}</h1>
                <p class="news-date">
                    <i class="fa fa-calendar"></i>
                    <span>Published on:
                        <fmt:formatDate value="${newsContent.createdAt}" pattern="MMMM d, yyyy 'at' HH:mm"/>
                    </span>
                </p>
            </div>

            <!-- Nội dung bài viết -->
            <div class="news-body">
                <div class="news-content">
                    <p>${newsContent.content}</p>

                    <!-- Hộp thông báo quan trọng (nếu có) -->
                    <c:if test="${newsContent.status == 1}">
                        <div class="highlight-box">
                            <p><strong>Important:</strong> This announcement contains critical information that may affect your travel plans.</p>
                        </div>
                    </c:if>
                </div>

                <!-- Footer với nút quay lại -->
                <div class="news-footer text-center mt-4">
                    <a href="list-news" class="btn-back">
                        <i class="fa fa-arrow-left"></i> Back to News List
                    </a>
                    <a href="index.jsp" class="btn-back">
                        <i class="fa fa-home"></i> Back to Home
                    </a>
                </div>
            </div>
        </div>
    </div>

    <!--================ End News Content Area =================-->

    <!--================ Start footer Area =================-->
    <%@include file="components/Footer.jsp" %>
    <!--================ End footer Area =================-->

    <%@include file="components/Script.jsp" %>
</body>
</html>
