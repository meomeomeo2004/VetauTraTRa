<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
    <title>Ticket and Luggage Selection</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
        }
        .ticket-container {
            background-color: white;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            max-width: 800px;
            margin: 0 auto;
        }
        .ticket-section {
            border-bottom: 1px solid #e0e0e0;
            padding-bottom: 15px;
            margin-bottom: 15px;
        }
        .luggage-option {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 10px;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        .luggage-option:hover {
            background-color: #f9f9f9;
            cursor: pointer;
        }
        .luggage-option.selected {
            background-color: #e6f2ff;
            border-color: #3080c7;
        }
    </style>
</head>
<body>
    <div class="ticket-container">
        <h2>Create Tickets and Select Luggage</h2>
        
        <form id="ticketForm" action="ProcessFinalTicketServlet" method="post">
            <c:forEach var="cabin" items="${selectedSeatsByCabin}">
                <div class="ticket-section">
                    <h3>Cabin ${cabin.key} Seats</h3>
                    <c:forEach var="seat" items="${cabin.value}">
                        <div class="ticket-details">
                            <h4>Seat ${seat}</h4>
                            <div class="luggage-selection">
                                <h5>Select Luggage Weight</h5>
                                <c:forEach var="luggage" items="${luggageOptions}">
                                    <div class="luggage-option" 
                                         data-luggage-id="${luggage.id}" 
                                         data-weight="${luggage.weight}" 
                                         data-price="${luggage.price}">
                                        <span>${luggage.weight} kg</span>
                                        <span>
                                            <fmt:formatNumber value="${luggage.price}" type="currency" currencyCode="VND"/>
                                        </span>
                                        <input type="radio" name="luggage_${cabin.key}_${seat}" 
                                               value="${luggage.id}" style="display:none;">
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:forEach>

            <div class="ticket-summary">
                <h3>Total Ticket Price: 
                    <fmt:formatNumber value="${totalPrice}" type="currency" currencyCode="VND"/>
                </h3>
                <h4>Number of Seats: ${numSeats}</h4>
                <button type="submit" class="btn btn-primary">Proceed to Payment</button>
            </div>
        </form>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const luggageOptions = document.querySelectorAll('.luggage-option');
            
            luggageOptions.forEach(option => {
                option.addEventListener('click', function() {
                    // Remove selected class from all options in this group
                    const group = this.closest('.luggage-selection');
                    group.querySelectorAll('.luggage-option').forEach(opt => {
                        opt.classList.remove('selected');
                    });

                    // Add selected class to clicked option
                    this.classList.add('selected');

                    // Select the radio button
                    const radio = this.querySelector('input[type="radio"]');
                    radio.checked = true;
                });
            });
        });
    </script>
</body>
</html>
