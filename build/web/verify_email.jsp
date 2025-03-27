<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Verify Email OTP</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }
            
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: #22577a;
                background-image: url("data:image/svg+xml,%3Csvg width='60' height='60' viewBox='0 0 60 60' xmlns='http://www.w3.org/2000/svg'%3E%3Cg fill='none' fill-rule='evenodd'%3E%3Cg fill='%23ffffff' fill-opacity='0.05'%3E%3Cpath d='M36 34v-4h-2v4h-4v2h4v4h2v-4h4v-2h-4zm0-30V0h-2v4h-4v2h4v4h2V6h4V4h-4zM6 34v-4H4v4H0v2h4v4h2v-4h4v-2H6zM6 4V0H4v4H0v2h4v4h2V6h4V4H6z'/%3E%3C/g%3E%3C/g%3E%3C/svg%3E");
                margin: 0;
                padding: 20px;
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 100vh;
            }

            .container {
                background-color: white;
                border-radius: 12px;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
                width: 100%;
                max-width: 450px;
                padding: 40px 30px;
                text-align: center;
                position: relative;
                overflow: hidden;
            }
            
            .container::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 5px;
                background: #ffbe0b;
            }

            .icon-circle {
                width: 80px;
                height: 80px;
                background-color: #ffbe0b;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                margin: 0 auto 25px;
                box-shadow: 0 5px 15px rgba(255, 190, 11, 0.3);
                transition: transform 0.3s ease;
            }
            
            .icon-circle:hover {
                transform: scale(1.05);
            }

            .icon-circle svg {
                width: 40px;
                height: 40px;
                fill: #22577a;
            }

            .header {
                color: #22577a;
                margin-bottom: 25px;
                font-size: 28px;
                font-weight: 600;
                position: relative;
                padding-bottom: 12px;
            }
            
            .header::after {
                content: '';
                position: absolute;
                bottom: 0;
                left: 50%;
                transform: translateX(-50%);
                width: 60px;
                height: 3px;
                background-color: #ffbe0b;
            }

            .notification-box {
                background-color: #f0f7ff;
                padding: 18px;
                border-radius: 10px;
                margin-bottom: 30px;
                color: #22577a;
                border: 1px solid rgba(34, 87, 122, 0.1);
                line-height: 1.5;
            }
            
            .notification-box strong {
                display: block;
                margin-top: 5px;
                font-size: 17px;
                word-break: break-all;
            }

            .form-group {
                margin-bottom: 25px;
                text-align: left;
            }

            label {
                display: block;
                margin-bottom: 10px;
                color: #22577a;
                font-weight: 500;
                font-size: 16px;
            }

            .otp-input {
                width: 100%;
                padding: 18px 15px;
                border: 1px solid #ddd;
                border-radius: 10px;
                font-size: 22px;
                box-sizing: border-box;
                text-align: center;
                letter-spacing: 8px;
                outline: none;
                background-color: #f9f9f9;
                transition: all 0.3s ease;
            }
            
            .otp-input:focus {
                border-color: #22577a;
                box-shadow: 0 0 0 3px rgba(34, 87, 122, 0.15);
                background-color: #fff;
            }

            .otp-input::placeholder {
                color: #ccc;
                letter-spacing: 5px;
            }

            .verify-button {
                background-color: #22577a;
                color: white;
                border: none;
                border-radius: 10px;
                padding: 16px;
                font-size: 16px;
                font-weight: 600;
                cursor: pointer;
                width: 100%;
                margin-bottom: 20px;
                transition: all 0.3s ease;
                letter-spacing: 0.5px;
            }

            .verify-button:hover {
                background-color: #1a4562;
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(34, 87, 122, 0.3);
            }
            
            .verify-button:active {
                transform: translateY(0);
            }

            .resend-container {
                margin-bottom: 15px;
                color: #555;
                font-size: 15px;
            }

            .resend-link {
                color: #22577a;
                text-decoration: none;
                font-weight: 600;
                transition: color 0.3s ease;
                margin-left: 5px;
            }

            .resend-link:hover {
                color: #ffbe0b;
            }

            .error-message {
                background-color: rgba(229, 62, 62, 0.1);
                border-left: 4px solid #e53e3e;
                color: #e53e3e;
                padding: 12px 15px;
                margin-top: 20px;
                border-radius: 6px;
                text-align: left;
                font-size: 14px;
            }

            .back-link {
                position: absolute;
                top: 20px;
                left: 20px;
                font-size: 15px;
                font-weight: 600;
                color: #22577a;
                text-decoration: none;
                display: flex;
                align-items: center;
                transition: all 0.3s ease;
            }

            .back-link:hover {
                color: #ffbe0b;
                transform: translateX(-3px);
            }

            .back-link i {
                margin-right: 6px;
            }
            
            .timer {
                display: inline-block;
                background-color: rgba(255, 190, 11, 0.15);
                color: #22577a;
                padding: 4px 10px;
                border-radius: 20px;
                font-size: 14px;
                font-weight: 600;
                margin-top: 10px;
            }
            
            @media (max-width: 480px) {
                .container {
                    padding: 30px 20px;
                }
                
                .icon-circle {
                    width: 70px;
                    height: 70px;
                }
                
                .icon-circle svg {
                    width: 35px;
                    height: 35px;
                }
                
                .header {
                    font-size: 24px;
                }
                
                .back-link {
                    top: 15px;
                    left: 15px;
                }
            }
        </style>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    </head>
    <body>
        <div class="container">
            <!-- Back to Signup Link -->
            <a href="register" class="back-link">
                <i class="fas fa-arrow-left"></i> Back to Signup
            </a>

            <div class="icon-circle">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
                    <path d="M20 4H4c-1.1 0-1.99.9-1.99 2L2 18c0 1.1.9 2 2 2h16c1.1 0 2-.9 2-2V6c0-1.1-.9-2-2-2zm0 14H4V8l8 5 8-5v10zm-8-7L4 6h16l-8 5z"/>
                </svg>
            </div>

            <h1 class="header">Email Verification</h1>

            <div class="notification-box">
                Enter the verification code sent to
                <strong>${email}</strong>
            </div>

            <form action="verify-email" method="post">
                <input type="hidden" name="email" value="${email}">

                <div class="form-group">
                    <label>Verification Code</label>
                    <input type="text" name="otp" required placeholder="000000" maxlength="6" class="otp-input" autocomplete="off">
                </div>

                <button type="submit" class="verify-button">Verify Email</button>
            </form>

            <div class="resend-container">
                Didn't receive the code?
                <a href="resend-otp" class="resend-link">Resend</a>
                <div class="timer" id="countdown">Code expires in 10:00</div>
            </div>

            <c:if test="${not empty errorMessage}">
                <div class="error-message">
                    <i class="fas fa-exclamation-circle"></i> ${errorMessage}
                </div>
            </c:if>
        </div>

        <script>
            // Countdown timer for OTP expiration
            function startCountdown(duration, display) {
                let timer = duration, minutes, seconds;
                const interval = setInterval(function () {
                    minutes = parseInt(timer / 60, 10);
                    seconds = parseInt(timer % 60, 10);

                    minutes = minutes < 10 ? "0" + minutes : minutes;
                    seconds = seconds < 10 ? "0" + seconds : seconds;

                    display.textContent = "Code expires in " + minutes + ":" + seconds;

                    if (--timer < 0) {
                        display.textContent = "Code expired";
                        display.style.backgroundColor = "rgba(229, 62, 62, 0.15)";
                        display.style.color = "#e53e3e";
                        clearInterval(interval);
                    }
                }, 1000);
            }

            window.onload = function () {
                const tenMinutes = 60 * 10; // Changed from 5 minutes to 10 minutes
                const display = document.querySelector('#countdown');
                startCountdown(tenMinutes, display);
                
                // Auto focus on OTP input
                document.querySelector('.otp-input').focus();
            };
            
            // Format OTP input to show only numbers
            document.querySelector('.otp-input').addEventListener('input', function(e) {
                this.value = this.value.replace(/[^0-9]/g, '');
            });
        </script>
    </body>
</html>