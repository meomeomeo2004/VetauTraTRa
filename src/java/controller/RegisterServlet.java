package controller;

import dal.CustomerDAO;
import dal.UserDAO;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
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

        // Danh sách chứa các thông báo lỗi
        List<String> errors = new ArrayList<>();

        // Kiểm tra định dạng email
        if (!email.matches("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$")) {
            errors.add("Email must have the format xxx@xxx.xxx");
        }

        // Kiểm tra định dạng số điện thoại
        if (!phoneNumber.matches("^0[0-9]{9}$")) {
            errors.add("Phone number must start with '0' and contain exactly 10 digits");
        }

        // Kiểm tra email đã tồn tại
        if (userDAO.checkEmailExist(email)) {
            errors.add("Email already exists");
        }

        // Kiểm tra số điện thoại đã tồn tại
        if (customerDAO.checkPhoneNumberExist(phoneNumber)) {
            errors.add("Phone Number already exists");
        }

        // Kiểm tra mật khẩu trùng khớp
        if (!password.equals(confirmPassword)) {
            errors.add("Passwords do not match");
        }

        // Kiểm tra mật khẩu có chứa chữ và số
        if (password.length() < 8 || !password.matches(".*[a-zA-Z].*") || !password.matches(".*\\d.*")) {
            errors.add("Password must be at least 8 characters long and contain both letters and numbers");
        }

        // Kiểm tra định dạng tên
        if (!fullName.matches("[A-Za-z\\s]{2,}")) {
            errors.add("Full name must contain only letters and spaces with at least 2 characters");
        }

        // Nếu có lỗi, chuyển về trang đăng ký
        if (errors.size() > 0) {
            request.setAttribute("registerErrors", errors);
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Lưu thông tin user vào session (chưa insert vào DB)
        HttpSession session = request.getSession();
        session.setAttribute("pendingUser", new User(email, password, "Customer"));
        session.setAttribute("pendingCustomer", new Customer(fullName, phoneNumber, address, 1));

        // Gửi OTP không đồng bộ để giảm độ trễ
        new Thread(() -> {
            try {
                // Gửi OTP để xác thực email
                String otp = resetService.generateOTP();
                OTPStorage.saveOTP(email, otp);
                boolean emailSent = resetService.sendOTPEmail(email, otp, fullName);

                if (!emailSent) {
                    System.err.println("Failed to send OTP email.");
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }).start();

        // Chuyển hướng ngay lập tức để không bị lag
        response.sendRedirect("verify-email?email=" + email);
    }
}
