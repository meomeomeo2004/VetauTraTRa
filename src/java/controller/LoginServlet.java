/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.CustomerDAO;
import dal.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

@WebServlet({"/admin/login", "/customer/login", "/manager/login", "/seller/login", "/staff/login"})
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;

    public void init() {
        userDAO = new UserDAO();
    }
    private final CustomerDAO CustomerDAO = new CustomerDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String role = request.getRequestURI().split("/")[2];
        request.setAttribute("role", role);

        // Lấy email từ cookie nếu có
        String savedEmail = null;
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (("email_" + role).equals(cookie.getName())) {
                    savedEmail = cookie.getValue();
                    break;
                }
            }
        }

        request.setAttribute("savedEmail", savedEmail);
        request.getRequestDispatcher("../login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getRequestURI().split("/")[2];
        String remember = request.getParameter("remember"); // Lấy giá trị của "Remember Me"

        request.setAttribute("role", role);

        try {
            User user = userDAO.authenticate(email, password, role);
            if (user != null) {
                HttpSession session = request.getSession();
                session.setAttribute(role, user);
                session.setMaxInactiveInterval(300);
                Cookie sessionCookie = new Cookie("JSESSIONID", session.getId());
                sessionCookie.setMaxAge(7 * 24 * 60 * 60); // Giữ 7 ngày
                sessionCookie.setPath("/");
                response.addCookie(sessionCookie);

                // Xử lý "Remember Me"
                if ("on".equals(remember)) {
                    Cookie emailCookie = new Cookie("email_" + role, email);
                    emailCookie.setMaxAge(7 * 24 * 60 * 60); // 7 ngày
                    emailCookie.setPath("/"); // Cookie có hiệu lực trên toàn hệ thống
                    response.addCookie(emailCookie);
                } else {
                    // Xóa cookie nếu không chọn "Remember Me"
                    Cookie emailCookie = new Cookie("email_" + role, "");
                    emailCookie.setMaxAge(0);
                    emailCookie.setPath("/");
                    response.addCookie(emailCookie);
                }

                if (role.equalsIgnoreCase("customer")) {
                    response.sendRedirect("/tickettraintest1");
                }
                if (role.equalsIgnoreCase("seller")) {
                    response.sendRedirect(request.getContextPath() + "/homeSellerPage.jsp");
                }

            } else {
                request.setAttribute("errorMessage", "Invalid email or password.");
                request.getRequestDispatcher("../login.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database error. Please try again.");
            request.getRequestDispatcher("../login.jsp").forward(request, response);
        }
    }

}
