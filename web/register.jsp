<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Register Customer</title>
        <style>
            body {
                margin: 0;
                padding: 0;
                min-height: 100vh;
                display: flex;
                align-items: center;
                justify-content: center;
                background-color: #f3f4f6;
            }

            .container {
                max-width: 400px;
                width: 100%;
                padding: 20px;
                background: white;
                border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            }

            h1 {
                text-align: center;
                color: #333;
                margin-bottom: 30px;
            }

            .form-group {
                margin-bottom: 20px;
            }

            label {
                display: block;
                margin-bottom: 5px;
                color: #333;
            }

            input[type="text"],
            input[type="email"],
            input[type="password"],
            input[type="tel"],
            textarea {
                width: 100%;
                padding: 8px;
                border: 1px solid #ddd;
                border-radius: 4px;
                box-sizing: border-box;
                height: 35px;
            }

            textarea {
                resize: none;
                overflow-y: hidden;
            }

            .register-btn {
                width: 100%;
                padding: 10px;
                background-color: #6366F1;
                color: white;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-size: 16px;
            }

            .register-btn:hover {
                background-color: #4F46E5;
            }

            .checkbox-group {
                display: flex;
                align-items: center;
                margin-bottom: 20px;
            }

            .checkbox-group input[type="checkbox"] {
                margin-right: 8px;
            }

            .error-message {
                color: #dc2626;
                background-color: #fee2e2;
                padding: 10px;
                border-radius: 4px;
                margin-bottom: 20px;
                text-align: center;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>Register Customer</h1>

            <% if (request.getAttribute("registerError") != null) { %>
            <div class="error-message">
                <%= request.getAttribute("registerError") %>
            </div>
            <% } %>

            <form action="register" method="POST">
                <div class="form-group">
                    <label for="fullName">Full Name</label>
                    <input type="text" id="fullName" name="fullName" pattern="[A-Za-z\s]{2,}" 
                           title="Name should only contain letters and spaces, with at least 2 characters." required>
                </div>

                <div class="form-group">
                    <label for="email" style="display: inline-block;">Email</label>
                    <span id="emailError" style="display: none; color: #dc2626;background-color: transparent;padding-left: 8px;font-size: 12px;font-weight: normal;margin-left: 5px;vertical-align: middle;">
                        Please enter a valid email address (e.g., example@domain.com)</span>
                    <input type="text" id="email" name="email" oninput="validateEmail()" required>
                </div>

                <div class="form-group">
                    <label for="phone">Phone Number</label>
                    <input type="tel" id="phone" name="phone" pattern="[0-9]{10}" title="Please enter a valid 10-digit phone number" required>
                </div>

                <div class="form-group">
                    <label for="address">Address</label>
                    <textarea id="address" name="address" ></textarea>
                </div>

                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" pattern="^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{2,}$" 
                           title="Password must contain at least one letter and one number" required>
                </div>

                <div class="form-group">
                    <label for="confirmPassword">Confirm Password</label>
                    <input type="password" id="confirmPassword" name="confirmPassword"
                           title="Password does not match" required oninput="checkPasswordMatch()">
                </div>

                <button type="submit" class="register-btn">REGISTER</button>

                <p style="text-align: center; margin-top: 20px;">
                    Already have an account? <a href="login.jsp">Login here</a>
                </p>
            </form>
        </div>
    </body>
    <script>
        function validateEmail() {
            const emailInput = document.getElementById("email");
            const emailError = document.getElementById("emailError");
            const email = emailInput.value;

            // Email regex pattern
            const emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;

            if (email.length > 0 && !emailPattern.test(email)) {
                emailError.style.display = "inline-block";
                emailInput.setCustomValidity("Invalid email format");
            } else {
                emailError.style.display = "none";
                emailInput.setCustomValidity(""); // Xóa lỗi nếu định dạng đúng
            }
        }

        function checkPasswordMatch() {
            const password = document.getElementById("password").value;
            const confirmPassword = document.getElementById("confirmPassword").value;
            const confirmPasswordInput = document.getElementById("confirmPassword");

            if (password !== confirmPassword) {
                confirmPasswordInput.setCustomValidity("Passwords do not match");
            } else {
                confirmPasswordInput.setCustomValidity("");
            }
        }
    </script>
</html>