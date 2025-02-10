/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

@WebServlet({"/admin/login", "/customer/login", "/manager/login", "/seller/login", "/staff/login"})
public class LoginServlet extends HttpServlet {

//    private static final long serialVersionUID = 1L;
    private final UserDAO userDAO = new UserDAO();

//    public void init() {
//        userDAO = new UserDAO();
//    }
//    private final CustomerDAO CustomerDAO = new CustomerDAO();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        String role = request.getRequestURI().split("/")[2];
        request.setAttribute("role", role);
        request.getRequestDispatcher("../login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getRequestURI().split("/")[2];
        request.setAttribute("role", role);
        try {
            User user = userDAO.authenticate(email, password, role);
            if (user != null) {
                HttpSession session = request.getSession();
                session.setAttribute(role, user);
                if (role.equalsIgnoreCase("customer")) {
                    response.sendRedirect("/tratra");
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
