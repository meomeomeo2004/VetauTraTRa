<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link rel="icon" href="image/favicon.png" type="image/png">
        <title>Ticket Details</title>
        <%@include file="components/Style.jsp" %>
        <%@include file="components/StyleProfile.jsp" %>
        <style>
            .container {
                width: 80%;
                margin: 20px auto; /* canh giữa container */
                padding: 20px;
                text-align: center; /* canh giữa các phần tử con mặc định */
            }

            /* Chỉnh lại bảng */
            table {
                margin: 20px auto; /* canh giữa bảng */
                border-collapse: collapse;
                width: 100%;
                max-width: 100%; /* có thể giới hạn độ rộng tối đa */
            }

            th, td {
                border: 1px solid #ddd;
                padding: 12px;
                text-align: center; /* canh giữa nội dung trong ô */
                vertical-align: middle; /* canh giữa theo chiều dọc */
            }

            th {
                background-color: #f4f4f4;
            }

            /* Nút Back */
            .btn-back {
                background: #007bff;
            }

            /* Nút View Details */
            .btn-view {
                background: #28a745; /* Màu xanh lá */
                color: white;
                padding: 8px 12px;
                border-radius: 5px;
                text-decoration: none;
                font-size: 14px;
                font-weight: bold;
                margin: 0; /* xóa bớt margin nếu muốn */
            }
            .btn-view:hover {
                background-color: #218838;
            }

            /* Màu cho trạng thái Paid/Unpaid */
            .status-paid {
                color: green;
                font-weight: bold;
            }
            .status-unpaid {
                color: red;
                font-weight: bold;
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
                .pagination {
                    display: flex;
                    justify-content: center;
                    margin: 20px 0;
                }

                .pagination-list {
                    display: flex;
                    list-style: none;
                    padding: 0;
                    margin: 0;
                }

                .pagination-list li {
                    margin: 0 5px;
                }

                .pagination-list li a {
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    width: 36px;
                    height: 36px;
                    border-radius: 4px;
                    color: #22577a;
                    text-decoration: none;
                    font-weight: 500;
                    transition: all 0.2s ease;
                }

                .pagination-list li:not(.active) a:hover {
                    background-color: #f0f0f0;
                }

                .pagination-list li.active a {
                    background-color: #22577a;
                    color: white;
                    border-bottom: 2px solid #ffbe0b;
                }
            }
            /* Filter Form Styling */
            .filter-form {
                margin-bottom: 25px;
                padding: 20px;
                background-color: #f8f9fa;
                border-radius: 8px;
                border-left: 4px solid var(--navy);
            }

            .filter-form > div {
                display: flex;
                flex-wrap: wrap;
                gap: 10px;
                align-items: center;
            }

            .filter-form input {
                padding: 10px 15px;
                border: 1px solid #ddd;
                border-radius: 6px;
                font-size: 14px;
                flex: 1;
                min-width: 150px;
                transition: all 0.3s ease;
            }

            .filter-form input:focus {
                border-color: var(--navy);
                box-shadow: 0 0 0 3px rgba(34, 87, 122, 0.1);
                outline: none;
            }

            /* Updated filter button to yellow */
            .btn-filter {
                background-color: var(--yellow);
                color: var(--navy-dark); /* Dark navy text for better contrast on yellow */
                border: none;
                padding: 10px 20px;
                border-radius: 6px;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s ease;
                display: flex;
                align-items: center;
                justify-content: center;
            }

            .btn-filter:hover {
                background-color: var(--yellow-dark);
                transform: translateY(-2px);
                box-shadow: 0 4px 8px rgba(255, 190, 11, 0.3);
            }

            .btn-filter:active {
                transform: translateY(0);
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

        </style>
    </head>
    <body>
        <section class="breadcrumb_area">
            <div class="overlay bg-parallax" data-stellar-ratio="0.8" data-stellar-vertical-offset="0" data-background=""></div>
        </section>
        <%@include file="components/Header.jsp" %>

        <div class="container">

        </div><!-- Profile Content -->
        <div class="page-wrapper">
            <div class="container">
                <div class="row">
                    <!-- Sidebar Navigation -->
                    <div class="col-lg-3 col-md-4">
                        <div class="profile-nav-card">
                            <div class="profile-nav-header">
                                Account Menu
                            </div>
                            <ul class="profile-nav-list">
                                <li class="profile-nav-item">
                                    <a href="profile" class="profile-nav-link">
                                        <i class="fas fa-user"></i> View Profile
                                    </a>
                                </li>
                                <li class="profile-nav-item">
                                    <a href="update-profile" class="profile-nav-link">
                                        <i class="fas fa-edit"></i> Update Profile
                                    </a>
                                </li>
                                <li class="profile-nav-item">
                                    <a href="change-password" class="profile-nav-link">
                                        <i class="fas fa-lock"></i> Change Password
                                    </a>
                                </li>
                                <li class="profile-nav-item">
                                    <a href="transaction" class="profile-nav-link active">
                                        <i class="fas fa-history"></i> Transaction History
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </div>

                    <!-- Main Content -->
                    <div class="col-lg-9 col-md-8">
                        <div class="content-card">
                            <div class="content-card-header">
                                <h3 class="content-card-title">Transaction History</h3>
                            </div>
                            <form class="filter-form" action="transaction" method="get">
                                <div>
                                    <input type="date" name="paymentDate" value="${paymentDate}" placeholder="Payment Date">
                                    <input type="number" name="minAmount" value="${minAmount}" step="0" placeholder="Min Amount (VND)">
                                    <input type="number" name="maxAmount" value="${maxAmount}" step="5" placeholder="Max Amount (VND)">
                                    <button type="submit" class="btn-filter">Filter</button>
                                </div>

                                <c:if test="${not empty transactions}">

                                    <div class="responsive-table">
                                        <table class="transaction-table">
                                            <thead>
                                                <tr>
                                                    <th>ID</th>
                                                    <th>Payment Method</th>
                                                    <th>Status</th>
                                                    <th>Payment Date</th>
                                                    <th>Tickets</th>
                                                    <th>Amount</th>
                                                    <th>Voucher</th>
                                                    <th>Action</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="t" items="${transactions}">
                                                    <tr>
                                                        <td>#${t.id}</td>
                                                        <td>${t.paymentMethod}</td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${t.paymentStatus == 1}">
                                                                    <span class="status-paid">Paid</span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="status-unpaid">Unpaid</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        <td>
                                                            <fmt:formatDate value="${t.paymentDate}" pattern="dd/MM/yyyy HH:mm" />
                                                        </td>
                                                        <td>${t.quantity}</td>
                                                        <td>
                                                            <fmt:formatNumber value="${t.amountPaid}"
                                                                              type="number"
                                                                              minFractionDigits="2"
                                                                              maxFractionDigits="2" />
                                                            VND
                                                        </td>
                                                        <td>
                                                            ${t.vouchercode != null ? t.vouchercode : "None"}
                                                        </td>
                                                        <td>
                                                            <a href="ticket-detail?transactionId=${t.id}" class="btn-view">
                                                                <i class="fas fa-eye"></i> Details
                                                            </a>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="transaction-summary">
                                        <p>Total transactions: <span class="count">${fn:length(transactions)}</span></p>
                                    </div>
                                    <div class="pagination">
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
                                    </div>
                                </c:if>
                            </form>
                            <c:if test="${empty transactions}">
                                <div class="empty-state">
                                    <i class="fas fa-receipt"></i>
                                    <p>No transactions found!</p>
                                    <a href="/tratra" class="btn-view">
                                        <i class="fas fa-home"></i> Back to Home
                                    </a>
                                </div>
                            </c:if>
                            <a href="index.jsp" class="btn-back">Back to Home</a>
                        </div>

                    </div>
                </div>
            </div>
            <%@include file="components/Footer.jsp" %>
            <%@include file="components/Message.jsp" %>
            <%@include file="components/Script.jsp" %>
    </body>
</html>