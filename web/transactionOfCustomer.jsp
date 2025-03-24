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

                            </c:if>

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