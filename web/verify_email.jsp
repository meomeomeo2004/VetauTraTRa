<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Verify Email OTP</title>
        <style>
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: #22577a;
                margin: 0;
                padding: 0;
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 100vh;
            }

            .container {
                background-color: white;
                border-radius: 8px;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
                width: 100%;
                max-width: 450px;
                padding: 30px;
                text-align: center;
            }

            .icon-circle {
                width: 70px;
                height: 70px;
                background-color: #ffbe0b;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                margin: 0 auto 20px;
            }

            .icon-circle svg {
                width: 35px;
                height: 35px;
                fill: #22577a;
            }

            .header {
                color: #22577a;
                margin-bottom: 25px;
                font-size: 24px;
                font-weight: 600;
            }

            .notification-box {
                background-color: #f0f7ff;
                padding: 15px;
                border-radius: 8px;
                margin-bottom: 25px;
                color: #22577a;
            }

            .form-group {
                margin-bottom: 20px;
                text-align: left;
            }

            label {
                display: block;
                margin-bottom: 10px;
                color: #22577a;
                font-weight: 500;
                font-size: 16px;
            }

            input[type="text"] {
                width: 100%;
                padding: 15px;
                border: 1px solid #ddd;
                border-radius: 8px;
                font-size: 18px;
                box-sizing: border-box;
                text-align: center;
                letter-spacing: 5px;
                outline: none;
            }

            input[type="text"]::placeholder {
                color: #ccc;
                letter-spacing: 5px;
            }

            button {
                background-color: #22577a;
                color: white;
                border: none;
                border-radius: 8px;
                padding: 15px;
                font-size: 16px;
                font-weight: 600;
                cursor: pointer;
                width: 100%;
                margin-bottom: 15px;
            }

            button:hover {
                background-color: #1a4562;
            }

            .resend-link {
                color: #22577a;
                text-decoration: none;
                font-weight: 600;
            }

            .resend-link:hover {
                text-decoration: underline;
            }

            .error-message {
                background-color: #fff0f0;
                border-left: 4px solid #ff3b30;
                color: #d63031;
                padding: 12px;
                margin-top: 20px;
                border-radius: 4px;
                text-align: left;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="icon-circle">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
                <path d="M20 4H4c-1.1 0-1.99.9-1.99 2L2 18c0 1.1.9 2 2 2h16c1.1 0 2-.9 2-2V6c0-1.1-.9-2-2-2zm0 14H4V8l8 5 8-5v10zm-8-7L4 6h16l-8 5z"/>
                </svg>
            </div>

            <h1 class="header">Email Verification</h1>

            <div class="notification-box">
                Enter the OTP sent to<br>
                <strong>${email}</strong>
            </div>

            <form action="verify-email" method="post">
                <input type="hidden" name="email" value="${email}">

                <div class="form-group">
                    <label>Verification Code</label>
                    <input type="text" name="otp" required placeholder="000000" maxlength="6">
                </div>

                <button type="submit">Verify Email</button>
            </form>

            <div>
                Didn't receive the code? 
                <a href="resend-otp" class="resend-link">Resend</a>
            </div>


            <c:if test="${not empty errorMessage}">
                <div class="error-message">${errorMessage}</div>
            </c:if>
        </div>
    </body>
</html>