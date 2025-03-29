<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Register Customer | TraTra</title>
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
                max-width: 450px;
                width: 100%;
                padding: 40px;
                background: white;
                border-radius: 12px;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
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

            .home-link {
                text-align: left;
                margin-bottom: 20px;
            }

            .home-link a {
                color: #22577a;
                font-size: 16px;
                text-decoration: none;
                font-weight: 600;
                display: flex;
                align-items: center;
                width: fit-content;
                transition: all 0.3s ease;
            }

            .home-link a:hover {
                color: #ffbe0b;
                transform: translateX(-3px);
            }

            .home-link a i {
                margin-right: 8px;
            }

            h1 {
                font-size: 26px;
                color: #22577a;
                margin-bottom: 30px;
                text-align: center;
                font-weight: 600;
                position: relative;
                padding-bottom: 12px;
            }

            h1::after {
                content: '';
                position: absolute;
                bottom: 0;
                left: 50%;
                transform: translateX(-50%);
                width: 60px;
                height: 3px;
                background-color: #ffbe0b;
            }

            .form-group {
                margin-bottom: 20px;
            }

            label {
                display: block;
                margin-bottom: 8px;
                color: #22577a;
                font-size: 15px;
                font-weight: 500;
            }

            input[type="text"],
            input[type="email"],
            input[type="password"],
            input[type="tel"],
            textarea {
                width: 100%;
                padding: 14px 15px;
                border: 1px solid #ddd;
                border-radius: 6px;
                font-size: 15px;
                transition: all 0.3s ease;
                background-color: #f9f9f9;
            }

            input:focus,
            textarea:focus {
                outline: none;
                border-color: #22577a;
                box-shadow: 0 0 0 3px rgba(34, 87, 122, 0.15);
                background-color: #fff;
            }

            textarea {
                resize: none;
                min-height: 80px;
            }

            .register-btn {
                width: 100%;
                padding: 15px;
                background-color: #22577a;
                color: white;
                border: none;
                border-radius: 6px;
                cursor: pointer;
                font-size: 16px;
                font-weight: 600;
                transition: all 0.3s ease;
                margin-bottom: 20px;
                letter-spacing: 0.5px;
            }

            .register-btn:hover {
                background-color: #1a4562;
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(34, 87, 122, 0.3);
            }

            .register-btn:active {
                transform: translateY(0);
            }

            .checkbox-group {
                display: flex;
                align-items: center;
                margin-bottom: 20px;
            }

            .checkbox-group input[type="checkbox"] {
                margin-right: 8px;
                accent-color: #22577a;
            }

            .error-message {
                background-color: rgba(229, 62, 62, 0.1);
                border-left: 4px solid #e53e3e;
                color: #e53e3e;
                padding: 12px;
                border-radius: 5px;
                margin-bottom: 20px;
                text-align: center;
            }

            .login-link {
                color: #22577a;
                text-decoration: none;
                text-align: center;
                display: block;
                margin-top: 5px;
                font-weight: 500;
                transition: color 0.3s ease;
            }

            .login-link:hover {
                color: #ffbe0b;
            }

            .train-icon {
                width: 80px;
                height: 80px;
                background-color: #ffbe0b;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                margin: 0 auto 25px;
                box-shadow: 0 5px 15px rgba(255, 190, 11, 0.3);
            }

            .train-icon i {
                font-size: 35px;
                color: #22577a;
            }

            .password-requirements {
                font-size: 12px;
                color: #666;
                margin-top: 5px;
            }
            .requirement {
        color: red;
        font-size: 12px;
        margin-top: 4px;
    }

            @media (max-width: 480px) {
                .container {
                    padding: 30px 20px;
                }

                .train-icon {
                    width: 70px;
                    height: 70px;
                }

                .train-icon i {
                    font-size: 30px;
                }
            }
        </style>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    </head>
    <body>
        <div class="container">
            <!-- Home Link -->
            <div class="home-link">
                <a href="/tratra"><i class="fas fa-arrow-left"></i> Back to Home</a>
            </div>

            <!-- Train Icon -->
            <div class="train-icon">
                <i class="fas fa-user-plus"></i>
            </div>

            <h1>Register Customer</h1>

            <c:if test="${not empty registerErrors}">
                <div class="error-message">
                    <ul>
                        <c:forEach var="error" items="${registerErrors}">
                            <li>${error}</li>
                            </c:forEach>
                    </ul>
                </div>
            </c:if>

            <form action="register" method="POST">
                <div class="form-group">
                    <label for="fullName">Full Name</label>
                    <input type="text" id="fullName" name="fullName" required>
                </div>

                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="email" id="email" name="email" required>
                </div>

               <div class="form-group">
    <label for="phone">Phone Number <span style="color: red;">*</span></label>
    <input type="tel" id="phone" name="phone" required>
    <p class="requirement">Phone number must start with '0' and contain exactly 10 digits</p>
</div>

                <div class="form-group">
                    <label for="address">Address</label>
                    <textarea id="address" name="address" required></textarea>
                </div>

                <div class="form-group">
    <label for="password">Password <span style="color: red;">*</span></label>
    <input type="password" id="password" name="password" required>
    <p class="requirement">Password must be at least 8 characters long and contain both letters and numbers</p>
</div>

<div class="form-group">
    <label for="confirmPassword">Confirm Password <span style="color: red;">*</span></label>
    <input type="password" id="confirmPassword" name="confirmPassword" required>
    <p class="requirement">Password must be at least 8 characters long and contain both letters and numbers</p>
</div>

                <button type="submit" class="register-btn">REGISTER</button>

                <!-- Login Link -->
                <a href="customer/login" class="login-link">Already have an account? Login here</a>
            </form>
        </div>


    </body>
</html>