/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.user;

import dal.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "ChangePasswordAdmin", urlPatterns = {"/admin_page/ChangePasswordAdmin"})
public class ChangePasswordAdmin extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        request.getRequestDispatcher("./changeAdminPassword.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        HttpSession session = request.getSession();
        String message = "";

        try {
            String id = request.getParameter("id");
            String oldPassword = request.getParameter("oldPassword");
            String newPassword = request.getParameter("newPassword");
            String renewPassword = request.getParameter("renewPassword");

            if (id == null || oldPassword == null || newPassword == null || renewPassword == null
                || id.isBlank() || oldPassword.isBlank() || newPassword.isBlank() || renewPassword.isBlank()) {
                throw new Exception("All fields must be filled!");
            }

            int adminId = Integer.parseInt(id);

            // Check old password
            if (!userDAO.checkOldPassword(adminId, oldPassword)) {
                message = "Incorrect old password!";
            } else if (newPassword.equals(oldPassword)) {
                throw new Exception("New password must be different from the old password.");
            } else if (!newPassword.equals(renewPassword)) {
                message = "New password and confirmation do not match!";
            } else if (newPassword.length() < 8) {
                throw new Exception("Password must be at least 8 characters long");
            } else {
                String passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$";
                if (!newPassword.matches(passwordRegex)) {
                    throw new Exception("Password must be at least 8 characters long and include uppercase, lowercase letters, a number, and a special character.");
                }

                boolean isUpdated = userDAO.changePasswordUser(adminId, newPassword);
                if (isUpdated) {
                    message = "Password changed successfully!";
                    session.removeAttribute("account");
                    response.sendRedirect("/tratra/admin/login");
                    return;
                } else {
                    message = "Failed to change password. Please try again!";
                    session.setAttribute("message", message);
                    response.sendRedirect("ChangePasswordAdmin");
                    return;
                }
            }

        } catch (Exception e) {
            message = "Error: " + e.getMessage();
            session.setAttribute("message", message);
            response.sendRedirect("ChangePasswordAdmin");
            return;
        }

        session.setAttribute("message", message);
        response.sendRedirect("ChangePasswordAdmin");
    }
}
