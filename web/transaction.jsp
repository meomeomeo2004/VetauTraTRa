<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chi tiết giao dịch</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        table, th, td {
            border: 1px solid #ddd;
            padding: 8px;
        }
        th {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
    <h1>Chi tiết giao dịch</h1>
    
    <c:choose>
        <c:when test="${not empty transaction}">
            <div class="transaction-details">
                <p>Mã giao dịch: ${transaction.id}</p>
                <p>Phương thức thanh toán: ${transaction.paymentMethod}</p>
                <p>Số lượng vé: ${transaction.quantity}</p>
                <p>Số tiền thanh toán: 
                    <fmt:formatNumber value="${transaction.amountPaid}" type="currency" currencyCode="VND"/>
                </p>
                <c:if test="${not empty transaction.vouchercode}">
                    <p>Mã giảm giá: ${transaction.vouchercode}</p>
                </c:if>
                <p>Ngày giao dịch: 
                    <fmt:formatDate value="${transaction.paymentDate}" 
                                    pattern="dd/MM/yyyy HH:mm:ss"/>
                </p>
            </div>

            <h2>Chi tiết vé</h2>
            <c:if test="${not empty tickets}">
                <table>
                    <thead>
                        <tr>
                            <th>Mã vé</th>
                            <th>Ghế</th>
                            <th>Tuyến đường</th>
                            <th>Hành lý</th>
                            <th>Ngày đặt</th>
                            <th>Trạng thái</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="ticket" items="${tickets}">
                            <tr>
                                <td>${ticket.id}</td>
                                <td>${ticket.seatId}</td>
                                <td>${ticket.routeId}</td>
                                <td>${ticket.luggageType}</td>
                                <td>
                                    <fmt:formatDate value="${ticket.bookingDate}" 
                                                    pattern="dd/MM/yyyy HH:mm:ss"/>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${ticket.status == 1}">Đang hoạt động</c:when>
                                        <c:when test="${ticket.status == 0}">Không hoạt động</c:when>
                                        <c:otherwise>Không xác định</c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:if>
            <c:if test="${empty tickets}">
                <p>Không tìm thấy vé nào cho giao dịch này.</p>
            </c:if>
        </c:when>
        <c:otherwise>
            <p>Không tìm thấy giao dịch.</p>
        </c:otherwise>
    </c:choose>
</body>
</html>