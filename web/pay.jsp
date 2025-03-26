<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Payment Summary</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 20px;
                background-color: #f4f4f4;
            }

            h2, h3, p {
                margin: 10px 0;
            }

            .container {
                max-width: 600px;
                margin: 20px auto;
                background-color: #fff;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }

            .summary-item {
                margin: 8px 0;
                padding: 8px;
                background-color: #e9ecef;
                border-radius: 5px;
            }

            .seat-list {
                margin: 10px 0;
                padding: 0;
                list-style-type: none;
            }

            .seat-list li {
                margin: 4px 0;
                padding: 6px;
                background-color: #f8f9fa;
                border-radius: 4px;
            }

            .btn-confirm {
                background-color: #007bff;
                color: white;
                border: none;
                padding: 10px 20px;
                margin-top: 15px;
                border-radius: 5px;
                cursor: pointer;
                width: 100%;
            }

            .btn-confirm:hover {
                background-color: #0056b3;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2>Payment Summary</h2>
            <form id="bookingForm" action="ConfirmBookingServlet" method="POST">
                <div class="summary-item">
                    <p>Route ID: ${selectedSeats[0].routeId}</p> <!-- Lấy routeId từ ghế đầu tiên -->
                    <input type="hidden" name="routeId" value="${selectedSeats[0].routeId}">
                    <p>Route Name: ${selectedSeats[0].routeName}</p>
                    <input type="hidden" name="routeName" value="${selectedSeats[0].routeName}">
                    <p><strong>Total Seats:</strong> ${numSeats}</p>
                    <input type="hidden" name="numSeats" value="${numSeats}">
                    <p><strong>Total Amount:</strong> <span id="totalAmount">${amount}</span> VND</p>
                    <input type="hidden" name="totalAmount" id="hiddenTotalAmount" value="${amount}">
                </div>

                <h3>Selected Seats:</h3>
                <ul class="seat-list">
                    <c:forEach var="seat" items="${selectedSeats}">
                        <li>
                            <strong>Seat:</strong> ${seat.seatName} - <strong>Price:</strong> ${seat.price} VND
                            <input type="hidden" name="seatName" value="${seat.seatName}">
                            <input type="hidden" name="seatPrice" value="${seat.price}">
                        </li>
                        <h3>Select Luggage Option:</h3>
                        <select id="luggageOption_${seat.seatName}" name="luggageOption" class="form-select" onchange="updateTotalAmount()">
                            <option value="0" data-price="0">No luggage</option>
                            <c:forEach var="luggage" items="${lu}">
                                <option value="${luggage.id}" data-price="${luggage.price}">${luggage.weight} kg - ${luggage.price} VND</option>
                            </c:forEach>
                        </select>
                        <input type="hidden" name="selectedLuggage_${seat.seatName}" id="selectedLuggage_${seat.seatName}" value="0">
                    </c:forEach>
                </ul>

                <button type="submit" class="btn-confirm">Confirm Payment</button>
            </form>
        </div>

        <script>
            let totalAmount = ${amount};

            function updateTotalAmount() {
                // Lấy tất cả các select của hành lý
                const luggageSelects = document.querySelectorAll('.form-select');
                let luggageTotal = 0;

                // Duyệt qua từng select để cộng giá tiền hành lý
                luggageSelects.forEach(select => {
                    const selectedOption = select.options[select.selectedIndex];
                    const luggagePrice = parseInt(selectedOption.getAttribute('data-price')) || 0;
                    luggageTotal += luggagePrice;
                });

                // Tính tổng tiền
                const totalWithLuggage = totalAmount + luggageTotal;

                // Cập nhật vào phần tổng tiền
                document.getElementById('totalAmount').textContent = totalWithLuggage.toLocaleString();
                document.getElementById('hiddenTotalAmount').value = totalWithLuggage;
            }
        </script>
    </body>
</html>
