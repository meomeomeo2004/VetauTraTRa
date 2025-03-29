<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Confirm Payment</title>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

        <style>
            :root {
                --primary-color: #4361ee;
                --secondary-color: #f8f9fa;
                --vnpay-color: #007bff;
                --vietqr-color: #28a745;
                --border-radius: 12px;
                --box-shadow: 0 8px 30px rgba(0, 0, 0, 0.08);
                --text-color: #333;
                --light-gray: #e9ecef;
                --medium-gray: #dee2e6;
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
                max-width: 900px;
                margin: 0 auto 40px;
                background-color: #fff;
                border-radius: var(--border-radius);
                box-shadow: var(--box-shadow);
                overflow: hidden;
                padding: 30px;
            }

            .booking-summary {
                background-color: var(--secondary-color);
                padding: 20px;
                border-radius: var(--border-radius);
                margin-bottom: 30px;
            }

            .booking-summary h2 {
                color: var(--primary-color);
                font-size: 1.5rem;
                margin-bottom: 20px;
                font-weight: 600;
            }

            .summary-item {
                display: flex;
                justify-content: space-between;
                padding: 10px 0;
                border-bottom: 1px solid var(--medium-gray);
            }

            .summary-item:last-child {
                border-bottom: none;
            }

            .summary-label {
                font-weight: 500;
            }

            .summary-value {
                font-weight: 600;
                color: var(--primary-color);
            }

            .payment-methods {
                margin-top: 30px;
            }

            .payment-methods h2 {
                color: var(--primary-color);
                font-size: 1.5rem;
                margin-bottom: 20px;
                font-weight: 600;
                text-align: center;
            }

            .payment-options {
                display: flex;
                gap: 20px;
                margin-bottom: 30px;
            }

            @media (max-width: 768px) {
                .payment-options {
                    flex-direction: column;
                }
            }

            .payment-option {
                flex: 1;
                border: 2px solid var(--medium-gray);
                border-radius: var(--border-radius);
                padding: 20px;
                cursor: pointer;
                transition: all 0.3s ease;
                position: relative;
                text-align: center;
            }

            .payment-option.selected {
                border-color: var(--primary-color);
                background-color: rgba(67, 97, 238, 0.05);
            }

            .payment-option:hover {
                transform: translateY(-3px);
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            }

            .payment-option-header {
                display: flex;
                align-items: center;
                justify-content: center;
                margin-bottom: 15px;
            }

            .payment-logo {
                width: 80px;
                height: 80px;
                object-fit: contain;
                margin-bottom: 10px;
            }

            .payment-name {
                font-weight: 600;
                font-size: 1.2rem;
                margin-top: 10px;
            }

            .payment-description {
                font-size: 0.9rem;
                color: #666;
                margin-top: 10px;
            }

            .radio-input {
                position: absolute;
                opacity: 0;
                cursor: pointer;
            }

            .radio-custom {
                position: absolute;
                top: 15px;
                right: 15px;
                height: 20px;
                width: 20px;
                background-color: white;
                border: 2px solid var(--medium-gray);
                border-radius: 50%;
            }

            .payment-option.selected .radio-custom {
                border-color: var(--primary-color);
            }

            .payment-option.selected .radio-custom:after {
                content: '';
                position: absolute;
                top: 3px;
                left: 3px;
                width: 10px;
                height: 10px;
                border-radius: 50%;
                background: var(--primary-color);
            }

            .qr-container {
                display: none;
                margin: 20px auto;
                text-align: center;
                max-width: 300px;
                padding: 20px;
                background-color: white;
                border-radius: var(--border-radius);
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }

            .qr-container.active {
                display: block;
                animation: fadeIn 0.5s;
            }

            @keyframes fadeIn {
                from {
                    opacity: 0;
                }
                to {
                    opacity: 1;
                }
            }

            .qr-code {
                width: 100%;
                max-width: 250px;
                height: auto;
                margin: 0 auto;
                display: block;
            }

            .qr-instructions {
                margin-top: 15px;
                font-size: 0.9rem;
                color: #666;
            }

            .payment-button {
                width: 100%;
                padding: 15px;
                border: none;
                border-radius: 8px;
                color: white;
                font-size: 1.1rem;
                font-weight: 500;
                cursor: pointer;
                transition: all 0.3s ease;
                display: flex;
                justify-content: center;
                align-items: center;
                margin-top: 20px;
            }

            .payment-button.vnpay {
                background-color: var(--vnpay-color);
            }

            .payment-button.vnpay:hover {
                background-color: #0069d9;
            }

            .payment-button.vietqr {
                background-color: var(--vietqr-color);
            }

            .payment-button.vietqr:hover {
                background-color: #218838;
            }

            .payment-button:disabled {
                background-color: var(--medium-gray);
                cursor: not-allowed;
            }
        </style>
    </head>
    <body>
        <div class="header">
            <h1>Confirm Your Payment</h1>
        </div>

        <div class="container">
            <c:if test="${not empty novoucher}">
                <div class="alert alert-danger d-flex align-items-center" role="alert" id="novoucherAlert">
                    <i class="fas fa-exclamation-circle me-2"></i>
                    <div>${novoucher}</div>
                    <button type="button" class="btn-close ms-auto" onclick="closeNoVoucherAlert()" aria-label="Close"></button>
                </div>
            </c:if>
            <div class="booking-summary">
                <h2>Booking Summary</h2>
                <div class="summary-item">
                    <span class="summary-label">Total Amount:</span>
                    <span class="summary-value">${amount} VND</span>
                </div>
                <div class="summary-item">
                    <span class="summary-label">Number of Seats:</span>
                    <span class="summary-value">${numSeats}</span>
                </div>
            </div>


            <div class="payment-methods">
                <h2>Select Payment Method</h2>

                <div class="payment-options">
                    <!-- VNPay Option -->
                    <label class="payment-option" id="vnpay-option">
                        <input type="radio" name="paymentMethod" value="vnpay" class="radio-input" checked>
                        <span class="radio-custom"></span>
                        <div class="payment-option-header">
                            <img src="image/paymentMethod/vnpay.png" alt="VNPay Logo" class="payment-logo">
                        </div>
                        <div class="payment-name">VNPay</div>
                        <div class="payment-description">Fast and secure payment with VNPay gateway</div>
                    </label>

                    <!-- VietQR Option -->
                    <label class="payment-option" id="vietqr-option">
                        <input type="radio" name="paymentMethod" value="vietqr" class="radio-input">
                        <span class="radio-custom"></span>
                        <div class="payment-option-header">
                            <img src="image/paymentMethod/vietqr.png" alt="VietQR Logo" class="payment-logo">
                        </div>
                        <div class="payment-name">VietQR</div>
                        <div class="payment-description">Scan QR code with your banking app</div>
                    </label>
                </div>

                <!-- QR Code Container -->
                <div class="qr-container" id="qrContainer">
                    <c:set var="qrCodeUrl" value="https://img.vietqr.io/image/MB-0394110940-compact2.jpg?amount=${amount}" />
                    <img src="${qrCodeUrl}" alt="QR Code Payment" class="qr-code">
                    <div class="qr-instructions">
                        <p>1. Open your banking app</p>
                        <p>2. Scan this QR code</p>
                        <p>3. Confirm the payment amount</p>
                    </div>
                </div>

                <!-- Payment Forms -->
                <div id="payment-forms">
                    <!-- VNPay Form -->
                    <form action="pay" method="GET" id="vnpayForm">
                        <c:forEach var="transaction" items="${transactions}">
                            <input type="hidden" name="seatName[]" value="${transaction.seatName}">
                            <input type="hidden" name="seatPrice[]" value="${transaction.seatPrice}">
                            <input type="hidden" name="luggageId[]" value="${transaction.luggageId}">
                        </c:forEach>
                        <input type="hidden" name="customerId" value="${userId}" />
                        <input type="hidden" name="amount" value="${amount}" />
                        <input type="hidden" name="numSeats" value="${numSeats}" />
                        <button type="submit" class="payment-button vnpay" id="vnpayButton">
                            Pay with VNPay
                        </button>
                    </form>

                    <!-- VietQR Form -->
                    <form action="payVietQR" method="GET" id="vietqrForm" style="display: none;">
                        <c:forEach var="transaction" items="${transactions}">
                            <input type="hidden" name="seatName[]" value="${transaction.seatName}">
                            <input type="hidden" name="seatPrice[]" value="${transaction.seatPrice}">
                            <input type="hidden" name="luggageId[]" value="${transaction.luggageId}">
                        </c:forEach>
                        <input type="hidden" name="customerId" value="${userId}" />
                        <input type="hidden" name="amount" value="${amount}" />
                        <input type="hidden" name="numSeats" value="${numSeats}" />
                        <button type="submit" class="payment-button vietqr" id="vietqrButton">
                            Confirm VietQR Payment
                        </button>
                    </form>
                </div>
            </div>
        </div>

        <script>
            // Get elements
            const vnpayOption = document.getElementById('vnpay-option');
            const vietqrOption = document.getElementById('vietqr-option');
            const qrContainer = document.getElementById('qrContainer');
            const vnpayForm = document.getElementById('vnpayForm');
            const vietqrForm = document.getElementById('vietqrForm');

            // Set initial state
            vnpayOption.classList.add('selected');

            // Add event listeners to payment options
            document.querySelectorAll('.payment-option').forEach(option => {
                option.addEventListener('click', function () {
                    // Remove selected class from all options
                    document.querySelectorAll('.payment-option').forEach(opt => {
                        opt.classList.remove('selected');
                    });

                    // Add selected class to clicked option
                    this.classList.add('selected');

                    // Get the selected payment method
                    const paymentMethod = this.querySelector('input[type="radio"]').value;

                    // Show/hide QR code and forms based on selection
                    if (paymentMethod === 'vietqr') {
                        qrContainer.classList.add('active');
                        vnpayForm.style.display = 'none';
                        vietqrForm.style.display = 'block';
                    } else {
                        qrContainer.classList.remove('active');
                        vnpayForm.style.display = 'block';
                        vietqrForm.style.display = 'none';
                    }
                });
            });
            function closeNoVoucherAlert() {
                const alertElement = document.getElementById("novoucherAlert");
                if (alertElement) {
                    alertElement.style.display = "none";
                }
            }
        </script>
    </body>
</html>