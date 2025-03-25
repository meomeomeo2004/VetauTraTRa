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
        <title>Voucher List - Tratra</title>
        <%@include file="components/Style.jsp" %>
        <%@include file="components/StyleProfile.jsp" %>
        <style>
            :root {
                --navy: #22577a;
                --yellow: #ffbe0b;
                --navy-light: #2c6a92;
                --navy-dark: #1a4258;
                --yellow-light: #ffd04c;
                --yellow-dark: #e6a800;
            }

            /* Breadcrumb styling */
            .breadcrumb_area {
                background-color: var(--navy);
                position: relative;
                padding: 60px 0;
            }

            .breadcrumb_area .overlay {
                background-color: rgba(0, 0, 0, 0.2);
            }

            .page-cover-tittle {
                color: white;
                position: relative;
                margin-bottom: 15px;
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
                margin-bottom: 0;
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

            /* Voucher section styling */
            .voucher-section {
                padding: 50px 0;
                background-color: #f8f9fa;
            }

            .section-title {
                color: var(--navy);
                margin-bottom: 30px;
                position: relative;
                display: inline-block;
                padding-bottom: 10px;
            }

            .section-title::after {
                content: "";
                position: absolute;
                bottom: 0;
                left: 0;
                width: 60%;
                height: 3px;
                background-color: var(--yellow);
            }

            /* Table styling */
            .voucher-table {
                border-radius: 8px;
                overflow: hidden;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
                margin-bottom: 30px;
            }

            .voucher-table .table {
                margin-bottom: 0;
            }

            .voucher-table thead {
                background-color: var(--navy);
                color: white;
                border: none;
            }

            .voucher-table th {
                font-weight: 600;
                border: none;
                padding: 15px;
                vertical-align: middle;
            }

            .voucher-table tbody tr:nth-child(even) {
                background-color: rgba(34, 87, 122, 0.05);
            }

            .voucher-table tbody tr:hover {
                background-color: rgba(255, 190, 11, 0.1);
            }

            .voucher-table td {
                padding: 12px 15px;
                vertical-align: middle;
                border-color: #eee;
            }

            /* Badge styling */
            .badge-active {
                background-color: var(--navy);
                color: white;
                padding: 6px 12px;
                border-radius: 20px;
                font-weight: 500;
                font-size: 12px;
            }

            .badge-inactive {
                background-color: #dc3545;
                color: white;
                padding: 6px 12px;
                border-radius: 20px;
                font-weight: 500;
                font-size: 12px;
            }

            /* Voucher code styling */
            .voucher-code {
                background-color: var(--yellow);
                color: var(--navy-dark);
                padding: 4px 8px;
                border-radius: 4px;
                font-weight: 600;
                font-family: monospace;
                font-size: 14px;
                letter-spacing: 1px;
            }

            /* Button styling */
            .btn-home {
                background-color: var(--navy);
                color: white;
                padding: 10px 25px;
                border-radius: 50px;
                border: 2px solid var(--navy);
                transition: all 0.3s ease;
                font-weight: 500;
            }

            .btn-home:hover {
                background-color: var(--yellow);
                border-color: var(--yellow);
                color: var(--navy-dark);
                transform: translateY(-3px);
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            }

            /* Empty state */
            .empty-state {
                text-align: center;
                padding: 40px 20px;
                background-color: white;
                border-radius: 8px;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            }

            .empty-state i {
                font-size: 48px;
                color: var(--navy);
                opacity: 0.3;
                margin-bottom: 15px;
            }

            .empty-state p {
                font-size: 16px;
                color: #666;
                margin-bottom: 20px;
            }

            /* Responsive adjustments */
            @media (max-width: 768px) {
                .breadcrumb_area {
                    padding: 40px 0;
                }

                .voucher-section {
                    padding: 30px 0;
                }

                .section-title {
                    margin-bottom: 20px;
                }

                .voucher-table {
                    box-shadow: none;
                    border-radius: 0;
                }
            }
        </style>
    </head>

    <body>
        <!--================Header Area =================-->
        <%@include file="components/Header.jsp" %>
        <!--================Header Area =================-->

        <!-- Breadcrumb Area -->
        <section class="breadcrumb_area">
            <div class="overlay bg-parallax" data-stellar-ratio="0.8" data-stellar-vertical-offset="0" data-background=""></div>
            <div class="container">
                <div class="page-cover text-center">
                    <h2 class="page-cover-tittle">Voucher List</h2>
                    <ol class="breadcrumb">
                        <li><a href="/tratra">Home</a></li>
                        <li class="active">Voucher</li>
                    </ol>
                </div>
            </div>
        </section>

        <!-- Voucher List Section -->
        <section class="voucher-section">
            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                        <h3 class="section-title">Available Vouchers</h3>

                        <c:if test="${not empty vouchers}">
                            <div class="voucher-table">
                                <div class="table-responsive">
                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th>ID</th>
                                                <th>Code</th>
                                                <th>Discount</th>
                                                <th>Valid From</th>
                                                <th>Valid To</th>
                                                <th>Quantity</th>
                                                <th>Status</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="voucher" items="${vouchers}">
                                                <tr>
                                                    <td>${voucher.id}</td>
                                                    <td><span class="voucher-code">${voucher.code}</span></td>
                                                    <td><fmt:formatNumber value="${voucher.discountAmount}" type="currency" currencySymbol="$" /></td>
                                                    <td><fmt:formatDate value="${voucher.validFrom}" pattern="dd/MM/yyyy HH:mm" /></td>
                                                    <td><fmt:formatDate value="${voucher.validTo}" pattern="dd/MM/yyyy HH:mm" /></td>
                                                    <td>${voucher.quantity}</td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${voucher.status == 1}">
                                                                <span class="badge-active">Active</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="badge-inactive">Inactive</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </c:if>

                        <c:if test="${empty vouchers}">
                            <div class="empty-state">
                                <i class="fa fa-ticket"></i>
                                <p>No vouchers are currently available. Please check back later for special offers and discounts.</p>
                                <a href="/tratra" class="btn-home">Back to Home</a>
                            </div>
                        </c:if>

                        <c:if test="${not empty vouchers}">
                            <div class="text-center mt-4">
                                <a href="/tratra" class="btn-home">
                                    <i class="fa fa-home mr-2"></i> Back to Home
                                </a>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </section>

        <!--================ Start footer Area =================-->
        <%@include file="components/Footer.jsp" %>
        <!--================ End footer Area =================-->

        <%@include file="components/Script.jsp" %>
    </body>
</html>