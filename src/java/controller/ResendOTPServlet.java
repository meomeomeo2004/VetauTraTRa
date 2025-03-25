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

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User pendingUser = (User) session.getAttribute("pendingUser");
        Customer pendingCustomer = (Customer) session.getAttribute("pendingCustomer");

        if (pendingUser != null && pendingCustomer != null) {
            String email = pendingUser.getEmail();
            String name = pendingCustomer.getFullName();

            String newOtp = resetService.generateOTP();
            OTPStorage.saveOTP(email, newOtp);

            boolean emailSent = resetService.sendOTPEmail(email, newOtp, name);

            if (emailSent) {
                request.setAttribute("email", email);
                request.setAttribute("errorMessage", "A new OTP has been sent to your email.");
            } else {
                request.setAttribute("email", email);
                request.setAttribute("errorMessage", "Failed to resend OTP. Please try again.");
            }
            request.getRequestDispatcher("verify_email.jsp").forward(request, response);

        } else {
            response.sendRedirect("register.jsp");
        }
    }
}
