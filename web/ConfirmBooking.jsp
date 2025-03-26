<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Create Transaction</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                margin: 0;
                padding: 0;
            }
            .container {
                max-width: 500px;
                margin: 50px auto;
                background-color: white;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }
            h2 {
                text-align: center;
            }
            label {
                font-weight: bold;
            }
            select, input[type="text"] {
                width: 100%;
                padding: 8px;
                margin: 8px 0;
                border: 1px solid #ccc;
                border-radius: 4px;
            }
            button {
                width: 100%;
                padding: 10px;
                background-color: #4CAF50;
                color: white;
                border: none;
                border-radius: 4px;
                cursor: pointer;
            }
            button:hover {
                background-color: #45a049;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <!-- VNPay Payment Form -->
            <input type="hidden" name="customerId" value="${userId}" />
            <label>Total Amount:</label>
            <input type="text" name="amount" value="${amount}" readonly />

            <label>Number of Seats:</label>
            <input type="text" name="numSeats" value="${numSeats}" readonly />

            <form action="pay" method="GET">
                <label>Payment Method: VNPay</label>
                <c:forEach var="transaction" items="${transactions}">
                    <input type="hidden" name="seatName[]" value="${transaction.seatName}">
                    <input type="hidden" name="seatPrice[]" value="${transaction.seatPrice}">
                    <input type="hidden" name="luggageId[]" value="${transaction.luggageId}">
                </c:forEach>
                <input type="hidden" name="customerId" value="${userId}" />
                <input type="hidden" name="amount" value="${amount}" />
                <input type="hidden" name="numSeats" value="${numSeats}" />
                <button type="submit" style="background-color: #007bff; color: white; padding: 10px; border-radius: 5px;">
                    Pay with VNPay
                </button>
            </form>

            <br>

            <!-- VietQR Payment Form -->
            <form action="payVietQR" method="GET">
                <c:forEach var="transaction" items="${transactions}">
                    <input type="hidden" name="seatName[]" value="${transaction.seatName}">
                    <input type="hidden" name="seatPrice[]" value="${transaction.seatPrice}">
                    <input type="hidden" name="luggageId[]" value="${transaction.luggageId}">
                </c:forEach>
                <input type="hidden" name="customerId" value="${userId}" />
                <input type="hidden" name="amount" value="${amount}" />
                <input type="hidden" name="numSeats" value="${numSeats}" />
                <label>Payment Method: VietQR</label>
                <div id="qrCodeContainer" style="margin-top: 10px;">
                    <c:set var="qrCodeUrl" value="https://img.vietqr.io/image/MB-0394110940-compact2.jpg?amount=${amount}" />
                    <img src="${qrCodeUrl}" alt="QR Code Payment" style="max-width: 50%; height: auto;">
                </div>

                <button type="submit" style="background-color: #28a745; color: white; padding: 10px; border-radius: 5px;">
                    Pay with VietQR
                </button>
            </form>
        </div>
        <script>
            function toggleQrCode() {
                const paymentMethod = document.getElementById("paymentMethod").value;
                const qrCodeContainer = document.getElementById("qrCodeContainer");

                // Kiểm tra nếu phương thức thanh toán là VietQR thì hiển thị QR
                if (paymentMethod === "vietqr") {
                    qrCodeContainer.style.display = "block";
                } else {
                    qrCodeContainer.style.display = "none";
                }
            }
        </script>
    </body>
</html>
