<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    java.util.Date currentTime = new java.util.Date();
    request.setAttribute("currentTime", currentTime);
%>
<!doctype html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link rel="icon" href="image/favicon.png" type="image/png">
        <title>Refund Request</title>
        <%@ include file="components/Style.jsp" %>
        <%@include file="components/StyleProfile.jsp" %>

        <!-- Additional Custom CSS for Refund Form -->
        <style>
            :root {
                --navy: #22577a;
                --yellow: #ffbe0b;
                --navy-light: #2e6b93;
                --navy-dark: #1a4258;
                --yellow-light: #ffd04c;
                --yellow-dark: #e6aa00;
            }

            /* Main container styling */
            .refund-container {
                max-width: 800px;
                margin: 50px auto;
                background: #fff;
                border-radius: 10px;
                box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
                padding: 30px;
            }

            /* Page title styling */
            .refund-title {
                color: var(--navy);
                margin-bottom: 30px;
                font-weight: 600;
                position: relative;
                padding-bottom: 15px;
                text-align: center;
            }

            .refund-title:after {
                content: '';
                position: absolute;
                bottom: 0;
                left: 50%;
                transform: translateX(-50%);
                width: 80px;
                height: 3px;
                background: var(--yellow);
            }

            /* Alert messages styling */
            .message {
                padding: 15px;
                border-radius: 5px;
                margin-bottom: 25px;
                font-weight: 500;
            }

            .success {
                background-color: #d4edda;
                color: #155724;
                border-left: 4px solid #28a745;
            }

            .error {
                background-color: #f8d7da;
                color: #721c24;
                border-left: 4px solid #dc3545;
            }

            /* Form styling */
            .refund-form {
                margin-top: 20px;
            }

            .form-group {
                margin-bottom: 25px;
            }

            .form-group label {
                display: block;
                margin-bottom: 8px;
                font-weight: 500;
                color: var(--navy);
            }

            .form-control {
                width: 100%;
                padding: 12px 15px;
                border: 1px solid #ddd;
                border-radius: 5px;
                font-size: 15px;
                transition: all 0.3s;
            }

            .form-control:focus {
                border-color: var(--yellow);
                box-shadow: 0 0 0 0.2rem rgba(255, 190, 11, 0.25);
                outline: none;
            }

            .form-control[readonly] {
                background-color: #f8f9fa;
                cursor: not-allowed;
            }

            /* Button styling */
            .btn-submit {
                background: var(--navy);
                color: #fff;
                border: none;
                padding: 12px 25px;
                border-radius: 5px;
                font-size: 16px;
                font-weight: 500;
                cursor: pointer;
                transition: all 0.3s;
                display: block;
                width: 100%;
                text-align: center;
            }

            .btn-submit:hover {
                background: var(--navy-light);
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(34, 87, 122, 0.3);
            }

            .back-btn {
                display: inline-block;
                margin-top: 20px;
                color: var(--navy);
                text-decoration: none;
                font-weight: 500;
                transition: all 0.3s;
            }

            .back-btn:hover {
                color: var(--yellow);
                text-decoration: none;
            }

            /* Responsive adjustments */
            @media (max-width: 768px) {
                .refund-container {
                    padding: 20px;
                    margin: 30px 15px;
                }
            }

            /* Card styling for form sections */
            .form-card {
                border: 1px solid #eee;
                border-radius: 8px;
                padding: 20px;
                margin-bottom: 25px;
                background-color: #f9f9f9;
                border-top: 3px solid var(--yellow);
            }

            .form-card-title {
                font-size: 18px;
                color: var(--navy);
                margin-bottom: 15px;
                padding-bottom: 10px;
                border-bottom: 1px solid #eee;
            }

            /* Icon styling */
            .form-icon {
                margin-right: 8px;
                color: var(--yellow);
            }

            /* Breadcrumb customization */
            .breadcrumb_area .overlay {
                background: var(--navy) !important;
            }

            .breadcrumb_area .breadcrumb li a {
                color: var(--yellow) !important;
            }

            /* Additional styling for a more polished look */
            .refund-header {
                text-align: center;
                margin-bottom: 30px;
            }

            .refund-subtext {
                text-align: center;
                color: #666;
                margin-bottom: 30px;
                font-size: 16px;
            }

            .form-footer {
                margin-top: 30px;
                padding-top: 20px;
                border-top: 1px solid #eee;
                text-align: center;
                font-size: 14px;
                color: #777;
            }

            /* Highlight required fields */
            .required-field::after {
                content: '*';
                color: #dc3545;
                margin-left: 4px;
            }

            /* Animated focus effect */
            .form-control:focus {
                border-color: var(--yellow);
                box-shadow: 0 0 0 0.2rem rgba(255, 190, 11, 0.25);
            }

            /* Custom checkbox styling */
            .form-check {
                display: block;
                position: relative;
                padding-left: 35px;
                margin-bottom: 15px;
                cursor: pointer;
                font-size: 15px;
            }

            .form-check input {
                position: absolute;
                opacity: 0;
                cursor: pointer;
                height: 0;
                width: 0;
            }

            .checkmark {
                position: absolute;
                top: 0;
                left: 0;
                height: 20px;
                width: 20px;
                background-color: #eee;
                border-radius: 3px;
            }

            .form-check:hover input ~ .checkmark {
                background-color: #ccc;
            }

            .form-check input:checked ~ .checkmark {
                background-color: var(--yellow);
            }

            .checkmark:after {
                content: "";
                position: absolute;
                display: none;
            }

            .form-check input:checked ~ .checkmark:after {
                display: block;
            }

            .form-check .checkmark:after {
                left: 7px;
                top: 3px;
                width: 6px;
                height: 12px;
                border: solid white;
                border-width: 0 2px 2px 0;
                transform: rotate(45deg);
            }
        </style>
    </head>
    <body>
        <!-- Breadcrumb Area -->
        <section class="breadcrumb_area">
            <div class="overlay bg-parallax" data-stellar-ratio="0.8" data-stellar-vertical-offset="0"></div>
            <div class="container">
                <div class="page-cover text-center">
                    <h2 class="page-cover-tittle">Refund Request</h2>
                    <ol class="breadcrumb">
                        <li><a href="/tratra">Home</a></li>
                        <li class="active">Request Refund</li>
                    </ol>
                </div>
            </div>
        </section>

        <%@ include file="components/Header.jsp" %>

        <div class="refund-container">
            <div class="refund-header">
                <h2 class="refund-title">Request a Refund</h2>
                <p class="refund-subtext">Please fill in the form below to request a refund for your ticket. We'll process your request within 3-5 business days.</p>
            </div>

            <!-- Hiển thị thông báo từ request -->
            <c:if test="${param.message == 'refundSuccess'}">
                <div class="message success">
                    <i class="fa fa-check-circle form-icon"></i> Your refund request has been submitted successfully! We'll process it within 3-5 business days.
                </div>
            </c:if>
            <c:if test="${param.message == 'refundFailed'}">
                <div class="message error">
                    <i class="fa fa-exclamation-circle form-icon"></i> Refund request failed. Please check your information and try again.
                </div>
            </c:if>
            <c:if test="${param.message == 'refundError'}">
                <div class="message error">
                    <i class="fa fa-exclamation-triangle form-icon"></i> An error occurred while processing your refund request. Please contact customer support.
                </div>
            </c:if>

            <!-- Form yêu cầu hoàn tiền -->
            <form action="insert-refund" method="post" class="refund-form">
                <c:set var="ticketId" value="${sessionScope.ticketId}" />
                <c:set var="acc" value="${sessionScope.account}" />

                <div class="form-card">
                    <h3 class="form-card-title">
                        <i class="fa fa-ticket form-icon"></i> Ticket Information
                    </h3>
                    <div class="form-group">
                        <label for="userId">User ID</label>
                        <input type="number" name="userId" id="userId" class="form-control" placeholder="Enter User ID" value="${acc.id}" readonly>
                    </div>

                    <div class="form-group">
                        <label for="ticketId">Ticket ID</label>
                        <input type="number" name="ticketId" id="ticketId" class="form-control" placeholder="Enter Ticket ID" value="${ticketId}" readonly>
                    </div>
                </div>

                <div class="form-card">
                    <h3 class="form-card-title">
                        <i class="fa fa-university form-icon"></i> Banking Information
                    </h3>
                    <div class="form-group">
                        <label for="userBankName" class="required-field">Bank Name</label>
                        <input type="text" name="userBankName" id="userBankName" class="form-control" placeholder="Enter your bank name (e.g., Vietcombank, BIDV)" required>
                    </div>

                    <div class="form-group">
                        <label for="userBankNumber" class="required-field">Bank Account Number</label>
                        <input type="text" name="userBankNumber" id="userBankNumber" class="form-control" placeholder="Enter your bank account number" required>
                    </div>

                    <div class="form-group">
                        <label for="userBankAccountName" class="required-field">Account Holder Name</label>
                        <input type="text" name="userBankAccountName" id="userBankAccountName" class="form-control" placeholder="Enter the name on your bank account" required>
                    </div>

                    <label class="form-check">
                        I confirm that the banking information provided is correct
                        <input type="checkbox" required>
                        <span class="checkmark"></span>
                    </label>
                </div>

                <button type="submit" class="btn-submit">
                    <i class="fa fa-paper-plane form-icon"></i> Submit Refund Request
                </button>
            </form>

            <a href="transaction" class="back-btn">
                <i class="fa fa-arrow-left"></i> Back to Transactions
            </a>

            <div class="form-footer">
                <p>If you have any questions about your refund, please contact our customer support team.</p>
            </div>
        </div>

        <%@ include file="components/Footer.jsp" %>
        <%@ include file="components/Script.jsp" %>

        <!-- Add Font Awesome if not already included -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    </body>
</html>