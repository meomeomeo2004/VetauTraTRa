package controller;

import dal.CustomerDAO;
import dal.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import model.Customer;
import model.User;

@WebServlet(name = "VerifyEmailServlet", urlPatterns = {"/verify-email"})
public class VerifyEmailServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("email", request.getParameter("email"));
        request.getRequestDispatcher("verify_email.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String otp = request.getParameter("otp");

        if (OTPStorage.validateOTP(email, otp)) {

            HttpSession session = request.getSession();

            User pendingUser = (User) session.getAttribute("pendingUser");
            Customer pendingCustomer = (Customer) session.getAttribute("pendingCustomer");

            UserDAO userDAO = new UserDAO();
            CustomerDAO customerDAO = new CustomerDAO();

            int userId = userDAO.insertUser(pendingUser);

            if (userId > 0) {
                pendingCustomer.setUser_id(userId);
                boolean customerCreated = customerDAO.insertCustomer(pendingCustomer);

                if (customerCreated) {
                    session.removeAttribute("pendingUser");
                    session.removeAttribute("pendingCustomer");

                    session.setAttribute("registerSuccess", "Your account has been successfully created! Please log in.");
                    response.sendRedirect("./customer/login");
                } else {
                    request.setAttribute("errorMessage", "Failed to register customer information.");
                    request.getRequestDispatcher("verify_email.jsp").forward(request, response);
                }
            } else {
                request.setAttribute("errorMessage", "Failed to register user information.");
                request.getRequestDispatcher("verify_email.jsp").forward(request, response);
            }

        } else {
            request.setAttribute("email", email);
            request.setAttribute("errorMessage", "OTP is invalid or expired.");
            request.getRequestDispatcher("verify_email.jsp").forward(request, response);
        }
    }
}
