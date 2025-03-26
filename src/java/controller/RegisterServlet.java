package controller;

import dal.CustomerDAO;
import dal.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Customer;
import model.User;

@WebServlet(name = "RegisterServlet", urlPatterns = {"/register"})
public class RegisterServlet extends HttpServlet {

    private final resetService resetService = new resetService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phoneNumber = request.getParameter("phone");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String address = request.getParameter("address");

        UserDAO userDAO = new UserDAO();
        CustomerDAO customerDAO = new CustomerDAO();

        // Validate thông tin
        if (userDAO.checkEmailExist(email)) {
            request.setAttribute("registerError", "Email already exists");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        if (customerDAO.checkPhoneNumberExist(phoneNumber)) {
            request.setAttribute("registerError", "Phone Number already exists");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        if (!password.equals(confirmPassword)) {
            request.setAttribute("registerError", "Passwords do not match");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        if (!password.matches(".*[a-zA-Z].*") || !password.matches(".*\\d.*")) {
            request.setAttribute("registerError", "Password must contain letters and numbers");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        if (!phoneNumber.matches("[0-9]{10}")) {
            request.setAttribute("registerError", "Phone number is not valid");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Lưu thông tin user vào session (chưa insert vào DB)
        HttpSession session = request.getSession();
        session.setAttribute("pendingUser", new User(email, password, "Customer"));
        session.setAttribute("pendingCustomer", new Customer(fullName, phoneNumber, address, 1));

        // Gửi OTP để xác thực email
        String otp = resetService.generateOTP();
        OTPStorage.saveOTP(email, otp);

        boolean emailSent = resetService.sendOTPEmail(email, otp, fullName);

        if (emailSent) {
            response.sendRedirect("verify-email?email=" + email);
        } else {
            request.setAttribute("registerError", "Failed to send OTP email.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}
