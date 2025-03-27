package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Customer;
import model.User;

@WebServlet(name = "ResendOTPServlet", urlPatterns = {"/resend-otp"})
public class ResendOTPServlet extends HttpServlet {

    private final resetService resetService = new resetService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User pendingUser = (User) session.getAttribute("pendingUser");
        Customer pendingCustomer = (Customer) session.getAttribute("pendingCustomer");

        if (pendingUser != null && pendingCustomer != null) {
            String email = pendingUser.getEmail();
            String name = pendingCustomer.getFullName();

            // Tạo OTP mới
            String newOtp = resetService.generateOTP();
            OTPStorage.saveOTP(email, newOtp);

            // Gửi OTP không đồng bộ để tránh lag
            new Thread(() -> {
                try {
                    boolean emailSent = resetService.sendOTPEmail(email, newOtp, name);
                    if (!emailSent) {
                        System.err.println("Failed to resend OTP to " + email);
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }).start();

            // Phản hồi nhanh chóng và chuyển hướng về trang xác thực OTP
            request.setAttribute("email", email);
            request.setAttribute("errorMessage", "A new OTP has been sent to your email.");
            request.getRequestDispatcher("verify_email.jsp").forward(request, response);

        } else {
            response.sendRedirect("register.jsp");
        }
    }
}
