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
        <style>
            .container {
                max-width: 900px;
                margin: 40px auto;
                background: #fff;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            }
            table {
                border-radius: 8px;
                overflow: hidden;
            }
            .breadcrumb {
                background: none;
                padding: 10px 0;
            }
            .btn-back {
                background-color: #007bff;
                color: white;
            }
            .btn-back:hover {
                background-color: #0056b3;
            }
            .btn-view {
                background-color: #28a745;
                color: white;
            }
            .btn-view:hover {
                background-color: #218838;
            }
        </style>
    </head>
    <body>
        <section class="breadcrumb_area">
            <div class="overlay bg-parallax" data-stellar-ratio="0.8" data-stellar-vertical-offset="0" data-background=""></div>
        </section>
        <%@include file="components/Header.jsp" %>

        <div class="container">
            <h3 class="text-center mb-4">Customer Transaction History</h3>

            <c:choose>
                <c:when test="${not empty transactions}">
                    <div class="table-responsive">
                        <table class="table table-striped table-hover text-center">
                            <thead class="table-dark">
                                <tr>
                                    <th>ID</th>
                                    <th>Payment Method</th>
                                    <th>Status</th>
                                    <th>Payment Date</th>
                                    <th>Tickets</th>
                                    <th>Amount</th>
                                    <th>Voucher Code</th>
                                    <th>View Info</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="t" items="${transactions}">
                                    <tr>
                                        <td>${t.id}</td>
                                        <td>${t.paymentMethod}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${t.paymentStatus == 1}">
                                                    <span class="text-success fw-bold">Paid</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="text-danger fw-bold">Unpaid</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td><fmt:formatDate value="${t.paymentDate}" pattern="dd/MM/yyyy HH:mm" /></td>
                                        <td>${t.quantity}</td>
                                        <td><fmt:formatNumber value="${t.amountPaid}" type="number" minFractionDigits="2" maxFractionDigits="2" /> VND</td>
                                        <td>${t.vouchercode != null ? t.vouchercode : "None"}</td>
                                        <td>
                                            <a href="ticket-detail?transactionId=${t.id}" class="btn btn-sm btn-view">View Details</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    <p class="text-center mt-3">Total transactions: ${fn:length(transactions)}</p>
                </c:when>
                <c:otherwise>
                    <p class="text-center text-muted">No transactions found!</p>
                </c:otherwise>
            </c:choose>

            <div class="text-center mt-4">
                <a href="index.jsp" class="btn btn-back">Back to Home</a>
            </div>
        </div>

        <%@include file="components/Footer.jsp" %>
        <%@include file="components/Script.jsp" %>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
