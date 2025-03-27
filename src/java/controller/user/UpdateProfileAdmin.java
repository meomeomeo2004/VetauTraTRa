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
import model.Admin;
import model.User;

@WebServlet(name = "UpdateProfileAdmin", urlPatterns = {"/update-admin-profile"})
public class UpdateProfileAdmin extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        HttpSession session = request.getSession();
        User acc = (User) session.getAttribute("account");
        if (acc != null && acc.getRole().equalsIgnoreCase("admin")) {
            Admin admin = userDAO.getAdminById(acc.getId());
            request.setAttribute("admin", admin);
        }
        request.getRequestDispatcher("updateAdminProfile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        HttpSession session = request.getSession();
        String message = "";
        try {
            String id = request.getParameter("id");
            String fullName = request.getParameter("fullName").trim();
            String phoneNumber = request.getParameter("phoneNumber").trim();

            // Kiểm tra xem các trường có trống hay không
            if (id.isBlank() || fullName.isBlank() || phoneNumber.isBlank()) {
                throw new Exception("All fields must be filled!");
            }

            int adminId = Integer.parseInt(id);
            Admin currentAdmin = userDAO.getAdminById(adminId);

            if (currentAdmin == null) {
                throw new Exception("Admin not found!");
            }

            // Kiểm tra nếu không có thay đổi nào so với dữ liệu cũ
            if (currentAdmin.getFullname().equals(fullName)
                && currentAdmin.getPhoneNumber().equals(phoneNumber)) {
                throw new Exception("No changes detected in the profile information!");
            }

            // Kiểm tra định dạng Full Name
            String fullNameRegex = "^[\\p{L}]+( [\\p{L}]+)*$";
            if (!fullName.matches(fullNameRegex) || fullName.length() < 2 || fullName.length() > 50) {
                throw new Exception("Full Name must be between 2 and 50 characters and only contain alphabetic characters and spaces.");
            }

            // Kiểm tra định dạng số điện thoại
            String phoneRegex = "^[0-9]{10}$";
            if (!phoneNumber.matches(phoneRegex)) {
                throw new Exception("Invalid phone number format. It must contain exactly 10 digits.");
            }

            // Kiểm tra xem có dấu cách ở cuối hay không
            if (fullName.endsWith(" ") || phoneNumber.endsWith(" ")) {
                throw new Exception("Fields must not have trailing spaces.");
            }

            int n = userDAO.updateAdminProfile(phoneNumber, fullName, adminId);
            if (n <= 0) {
                throw new Exception("Profile update failed!");
            }

            Admin admin = userDAO.getAdminById(adminId);
            session.setAttribute("admin", admin);
            message = "Update profile successful!";
        } catch (Exception e) {
            message = "Error: " + e.getMessage();
        }

        session.setAttribute("message", message);
        response.sendRedirect("update-admin-profile");
    }
}
