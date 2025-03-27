<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login | TraTra</title>
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
            }

            .login-container {
                background: white;
                padding: 40px;
                border-radius: 12px;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
                width: 100%;
                max-width: 420px;
                position: relative;
                overflow: hidden;
            }

            .login-container::before {
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

            .login-title {
                font-size: 26px;
                color: #22577a;
                margin-bottom: 30px;
                text-align: center;
                font-weight: 600;
                position: relative;
                padding-bottom: 12px;
            }

            .login-title::after {
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
                margin-bottom: 22px;
            }

            .form-group label {
                display: block;
                margin-bottom: 8px;
                color: #22577a;
                font-size: 15px;
                font-weight: 500;
            }

            .form-group input {
                width: 100%;
                padding: 14px 15px;
                border: 1px solid #ddd;
                border-radius: 6px;
                font-size: 15px;
                transition: all 0.3s ease;
                background-color: #f9f9f9;
            }

            .form-group input:focus {
                outline: none;
                border-color: #22577a;
                box-shadow: 0 0 0 3px rgba(34, 87, 122, 0.15);
                background-color: #fff;
            }

            .remember-forgot {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 25px;
            }

            .remember-me {
                display: flex;
                align-items: center;
                gap: 8px;
                font-size: 14px;
                color: #555;
            }

            .remember-me input[type="checkbox"] {
                accent-color: #22577a;
                width: 16px;
                height: 16px;
                cursor: pointer;
            }

            .forgot-password, .signup-link {
                color: #22577a;
                text-decoration: none;
                font-size: 14px;
                font-weight: 500;
                transition: color 0.3s ease;
            }

            .forgot-password:hover, .signup-link:hover {
                color: #ffbe0b;
            }

            .login-button {
                width: 100%;
                padding: 15px;
                background-color: #22577a;
                color: white;
                border: none;
                border-radius: 6px;
                font-size: 16px;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s ease;
                margin-bottom: 20px;
                letter-spacing: 0.5px;
            }

            .login-button:hover {
                background-color: #1a4562;
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(34, 87, 122, 0.3);
            }

            .login-button:active {
                transform: translateY(0);
            }

            .signup-link {
                display: block;
                text-align: center;
                margin-top: 5px;
                font-weight: 500;
            }

            .success-message {
                background-color: rgba(52, 199, 89, 0.1);
                border-left: 4px solid #34c759;
                color: #2d7f44;
                padding: 12px;
                border-radius: 5px;
                margin-bottom: 20px;
                text-align: center;
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

            @media (max-width: 480px) {
                .login-container {
                    padding: 30px 20px;
                    margin: 0 15px;
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
        <div class="login-container">
            <!-- Home Link -->
            <div class="home-link">
                <a href="/tratra"><i class="fas fa-arrow-left"></i> Back to Home</a>
            </div>

            <!-- Train Icon -->
            <div class="train-icon">
                <i class="fas fa-train"></i>
            </div>

            <h1 class="login-title">Login ${role}</h1>

            <c:if test="${not empty sessionScope.registerSuccess}">
                <div class="success-message">${sessionScope.registerSuccess}</div>
                <c:remove var="registerSuccess" scope="session"/>
            </c:if>

            <c:if test="${not empty errorMessage}">
                <div class="error-message">${errorMessage}</div>
            </c:if>

            <form action="../${role}/login" method="POST">
                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="email" id="email" name="email" required>
                </div>
                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" required>
                </div>
                <div class="remember-forgot">
                    <label class="remember-me">
                        <input type="checkbox" name="remember">
                        Remember me
                    </label>
                    <a href="../requestPassword" class="forgot-password">Forgot Password?</a>
                </div>
                <button type="submit" class="login-button">LOGIN</button>
            </form>

            <!-- Sign Up link only for customer role -->
            <c:if test="${role == 'customer'}">
                <a href="../register.jsp" class="signup-link">Don't have an account? Sign Up</a>
            </c:if>
        </div>
    </body>
</html>