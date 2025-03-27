<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Reset Password | TraTra</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }

            body {
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 100vh;
                background-color: #22577a;
                background-image: url("data:image/svg+xml,%3Csvg width='60' height='60' viewBox='0 0 60 60' xmlns='http://www.w3.org/2000/svg'%3E%3Cg fill='none' fill-rule='evenodd'%3E%3Cg fill='%23ffffff' fill-opacity='0.05'%3E%3Cpath d='M36 34v-4h-2v4h-4v2h4v4h2v-4h4v-2h-4zm0-30V0h-2v4h-4v2h4v4h2V6h4V4h-4zM6 34v-4H4v4H0v2h4v4h2v-4h4v-2H6zM6 4V0H4v4H0v2h4v4h2V6h4V4H6z'/%3E%3C/g%3E%3C/g%3E%3C/svg%3E");
                padding: 20px;
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

            .icon-circle i {
                font-size: 35px;
                color: #22577a;
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

            .description {
                color: #555;
                margin-bottom: 30px;
                line-height: 1.6;
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

            .form-control {
                width: 100%;
                padding: 15px;
                border: 1px solid #ddd;
                border-radius: 8px;
                font-size: 16px;
                transition: all 0.3s ease;
                background-color: #f9f9f9;
            }
            
            .form-control:focus {
                outline: none;
                border-color: #22577a;
                box-shadow: 0 0 0 3px rgba(34, 87, 122, 0.15);
                background-color: #fff;
            }

            .reset-button {
                width: 100%;
                padding: 15px;
                background-color: #22577a;
                color: white;
                border: none;
                border-radius: 8px;
                font-size: 16px;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s ease;
                margin-bottom: 20px;
            }

            .reset-button:hover {
                background-color: #1a4562;
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(34, 87, 122, 0.3);
            }
            
            .reset-button:active {
                transform: translateY(0);
            }

            .back-to-login {
                display: inline-block;
                color: #22577a;
                text-decoration: none;
                font-weight: 500;
                font-size: 15px;
                transition: all 0.3s ease;
                margin-top: 15px;
            }
            
            .back-to-login:hover {
                color: #ffbe0b;
            }
            
            .back-to-login i {
                margin-right: 6px;
            }

            .error-message {
                color: #e53e3e;
                background-color: rgba(229, 62, 62, 0.1);
                border-left: 4px solid #e53e3e;
                padding: 12px 15px;
                margin-top: 20px;
                border-radius: 6px;
                text-align: left;
                font-size: 14px;
            }
            
            .success-message {
                color: #2d7f44;
                background-color: rgba(52, 199, 89, 0.1);
                border-left: 4px solid #34c759;
                padding: 12px 15px;
                margin-top: 20px;
                border-radius: 6px;
                text-align: left;
                font-size: 14px;
            }
            
            @media (max-width: 480px) {
                .container {
                    padding: 30px 20px;
                }
                
                .icon-circle {
                    width: 70px;
                    height: 70px;
                }
                
                .icon-circle i {
                    font-size: 30px;
                }
                
                .header {
                    font-size: 24px;
                }
            }
        </style>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    </head>
    <body>
        <div class="container">
            <div class="icon-circle">
                <i class="fas fa-key"></i>
            </div>
            
            <h1 class="header">Reset Password</h1>
            
            <p class="description">
                Enter your email address below and we'll send you instructions to reset your password.
            </p>
            
            <form action="requestPassword" method="POST">
                <div class="form-group">
                    <label for="email">Email Address</label>
                    <input type="email" class="form-control" name="email" id="email" 
                           placeholder="Enter your email" required>
                </div>
                
                <button class="reset-button" type="submit">
                    <i class="fas fa-paper-plane"></i> Send Reset Link
                </button>
            </form>
            
            <a href="customer/login" class="back-to-login">
                <i class="fas fa-arrow-left"></i> Back to Login
            </a>
            
            <% if (request.getAttribute("mess") != null && !request.getAttribute("mess").toString().isEmpty()) { 
                String message = request.getAttribute("mess").toString();
                boolean isSuccess = message.contains("success") || 
                                   message.contains("sent") || 
                                   message.contains("Success") || 
                                   message.equals("SEND REQUEST SUCCESS");
            %>
                <div class="<%= isSuccess ? "success-message" : "error-message" %>">
                    <i class="<%= isSuccess ? "fas fa-check-circle" : "fas fa-exclamation-circle" %>"></i> ${mess}
                </div>
            <% } %>
        </div>
    </body>
</html>