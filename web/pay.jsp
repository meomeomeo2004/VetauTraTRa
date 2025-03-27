<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Payment Summary</title>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <style>
            :root {
                --primary-color: #4361ee;
                --primary-hover: #3a56d4;
                --secondary-color: #f8f9fa;
                --border-radius: 12px;
                --box-shadow: 0 8px 30px rgba(0, 0, 0, 0.08);
                --text-color: #333;
                --light-gray: #e9ecef;
                --medium-gray: #dee2e6;
                --success-color: #38b000;
            }

            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Poppins', sans-serif;
                background-color: #f5f7fa;
                color: var(--text-color);
                line-height: 1.6;
                padding: 0;
                margin: 0;
            }

            .header {
                background-color: var(--primary-color);
                color: white;
                padding: 20px 0;
                text-align: center;
                margin-bottom: 30px;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            }

            .header h1 {
                font-weight: 600;
                font-size: 1.8rem;
            }

            .container {
                max-width: 800px;
                margin: 0 auto 40px;
                background-color: #fff;
                border-radius: var(--border-radius);
                box-shadow: var(--box-shadow);
                overflow: hidden;
            }

            .booking-details {
                padding: 25px;
                border-bottom: 1px solid var(--medium-gray);
            }

            .booking-details h2 {
                color: var(--primary-color);
                font-size: 1.5rem;
                margin-bottom: 20px;
                font-weight: 600;
            }

            .route-info {
                background-color: var(--secondary-color);
                padding: 20px;
                border-radius: var(--border-radius);
                margin-bottom: 20px;
                display: flex;
                flex-wrap: wrap;
                justify-content: space-between;
            }

            .route-info-item {
                flex: 1;
                min-width: 200px;
                margin: 5px 10px;
            }

            .route-info-item p {
                margin: 8px 0;
            }

            .route-info-item strong {
                color: var(--primary-color);
            }

            .seats-section {
                padding: 25px;
            }

            .seats-section h2 {
                color: var(--primary-color);
                font-size: 1.5rem;
                margin-bottom: 20px;
                font-weight: 600;
            }

            .seat-item {
                background-color: var(--secondary-color);
                border-radius: var(--border-radius);
                padding: 20px;
                margin-bottom: 15px;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
                transition: all 0.3s ease;
            }

            .seat-item:hover {
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            }

            .seat-info {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 15px;
            }

            .seat-name {
                font-size: 1.1rem;
                font-weight: 600;
            }

            .seat-price {
                color: var(--primary-color);
                font-weight: 600;
            }

            .luggage-selection {
                margin-top: 15px;
            }

            .luggage-selection h3 {
                font-size: 1rem;
                margin-bottom: 10px;
                color: #555;
            }

            .form-select {
                width: 100%;
                padding: 12px 15px;
                border: 1px solid var(--medium-gray);
                border-radius: 8px;
                font-family: 'Poppins', sans-serif;
                font-size: 0.95rem;
                background-color: white;
                cursor: pointer;
                transition: border-color 0.3s;
            }

            .form-select:focus {
                outline: none;
                border-color: var(--primary-color);
                box-shadow: 0 0 0 3px rgba(67, 97, 238, 0.2);
            }

            .total-section {
                background-color: var(--secondary-color);
                padding: 25px;
                border-top: 1px solid var(--medium-gray);
            }

            .total-amount {
                display: flex;
                justify-content: space-between;
                align-items: center;
                font-size: 1.2rem;
                font-weight: 600;
                padding: 10px 0;
            }

            .amount-value {
                color: var(--primary-color);
                font-size: 1.5rem;
            }

            .btn-confirm {
                background-color: var(--primary-color);
                color: white;
                border: none;
                padding: 15px 25px;
                margin-top: 20px;
                border-radius: 8px;
                cursor: pointer;
                width: 100%;
                font-size: 1.1rem;
                font-weight: 500;
                transition: background-color 0.3s, transform 0.2s;
                display: flex;
                justify-content: center;
                align-items: center;
            }

            .btn-confirm:hover {
                background-color: var(--primary-hover);
                transform: translateY(-2px);
            }

            .btn-confirm:active {
                transform: translateY(0);
            }

            @media (max-width: 768px) {
                .container {
                    margin: 0 15px 40px;
                    border-radius: 0;
                }

                .route-info {
                    flex-direction: column;
                }

                .seat-info {
                    flex-direction: column;
                    align-items: flex-start;
                }

                .seat-price {
                    margin-top: 5px;
                }
            }
        </style>
    </head>
    <body>
        <div class="container">
            <form id="bookingForm" action="ConfirmBookingServlet" method="POST">
                <div class="booking-details">
                    <h2>Booking Details</h2>
                    <div class="route-info">
                        <div class="route-info-item">
                            <p><strong>Route Name:</strong> ${selectedSeats[0].routeName}</p>
                            <input type="hidden" name="routeId" value="${selectedSeats[0].routeId}">
                            <input type="hidden" name="routeName" value="${selectedSeats[0].routeName}">
                        </div>
                        <div class="route-info-item">
                            <p><strong>Total Seats:</strong> ${numSeats}</p>
                            <input type="hidden" name="numSeats" value="${numSeats}">
                        </div>
                    </div>
                </div>

                <div class="seats-section">
                    <h2>Selected Seats</h2>
                    <c:forEach var="seat" items="${selectedSeats}">
                        <div class="seat-item">
                            <div class="seat-info">
                                <div class="seat-name">Seat: ${seat.seatName}</div>
                                <div class="seat-price">${seat.price} VND</div>
                            </div>
                            <input type="hidden" name="seatName" value="${seat.seatName}">
                            <input type="hidden" name="seatPrice" value="${seat.price}">

                            <div class="luggage-selection">
                                <h3>Select Luggage Option</h3>
                                <select id="luggageOption_${seat.seatName}" name="luggageOption" class="form-select" onchange="updateTotalAmount()">
                                    <option value="0" data-price="0">No luggage</option>
                                    <c:forEach var="luggage" items="${lu}">
                                        <option value="${luggage.id}" data-price="${luggage.price}">${luggage.weight} kg - ${luggage.price} VND</option>
                                    </c:forEach>
                                </select>
                                <input type="hidden" name="selectedLuggage_${seat.seatName}" id="selectedLuggage_${seat.seatName}" value="0">
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <div class="total-section">
                    <div class="total-amount">
                        <span>Total Amount:</span>
                        <span class="amount-value"><span id="totalAmount">${amount}</span> VND</span>
                    </div>
                    <input type="hidden" name="totalAmount" id="hiddenTotalAmount" value="${amount}">

                    <button type="submit" class="btn-confirm">
                        Confirm Payment
                    </button>
                </div>
            </form>
        </div>

        <script>
            let totalAmount = ${amount};

            function updateTotalAmount() {
                // Get all luggage selects
                const luggageSelects = document.querySelectorAll('.form-select');
                let luggageTotal = 0;

                // Calculate total luggage price
                luggageSelects.forEach(select => {
                    const selectedOption = select.options[select.selectedIndex];
                    const luggagePrice = parseInt(selectedOption.getAttribute('data-price')) || 0;
                    luggageTotal += luggagePrice;

                    // Update the hidden input for this specific seat's luggage
                    const seatId = select.id.replace('luggageOption_', '');
                    document.getElementById('selectedLuggage_' + seatId).value = select.value;
                });

                // Calculate total with luggage
                const totalWithLuggage = totalAmount + luggageTotal;

                // Format with thousand separators
                document.getElementById('totalAmount').textContent = totalWithLuggage.toLocaleString('vi-VN');
                document.getElementById('hiddenTotalAmount').value = totalWithLuggage;
            }
        </script>
    </body>
</html>