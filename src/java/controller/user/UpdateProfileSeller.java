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
import model.Seller;
import model.User;

@WebServlet(name = "UpdateProfileSeller", urlPatterns = {"/update-seller-profile"})
public class UpdateProfileSeller extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        HttpSession session = request.getSession();
        User acc = (User) session.getAttribute("account");
        if (acc != null && acc.getRole().equalsIgnoreCase("seller")) {
            Seller seller = userDAO.getSellerById(acc.getId());
            request.setAttribute("seller", seller);
        }
        request.getRequestDispatcher("updateSellerProfile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        HttpSession session = request.getSession();
        String message = "";
        try {
            String id = request.getParameter("id");
            String fullName = request.getParameter("fullName").trim();
            String address = request.getParameter("address").trim();
            String phoneNumber = request.getParameter("phoneNumber").trim();

            // Kiểm tra xem các trường có trống hay không
            if (id.isBlank() || fullName.isBlank() || address.isBlank() || phoneNumber.isBlank()) {
                throw new Exception("All fields must be filled!");
            }

            int sellerId = Integer.parseInt(id);
            Seller currentSeller = userDAO.getSellerById(sellerId);

            if (currentSeller == null) {
                throw new Exception("Seller not found!");
            }

            // Kiểm tra nếu không có thay đổi nào so với dữ liệu cũ
            if (currentSeller.getFullName().equals(fullName)
                && currentSeller.getPhoneNumber().equals(phoneNumber)
                && currentSeller.getAddress().equals(address)) {
                throw new Exception("No changes detected in the profile information!");
            }

            // Kiểm tra định dạng Full Name
            String fullNameRegex = "^[\\p{L}]+( [\\p{L}]+)*$";
            if (!fullName.matches(fullNameRegex) || fullName.length() < 2 || fullName.length() > 50) {
                throw new Exception("Full Name must be between 2 and 50 characters and only contain alphabetic characters and spaces.");
            }

            // Kiểm tra định dạng địa chỉ
            String addressRegex = "^[a-zA-Z0-9\\s,/#-]{5,100}$";
            if (!address.matches(addressRegex)) {
                throw new Exception("Address must contain 5-100 characters and only accept alphabetic characters, numbers, spaces, commas, slashes, and hyphens.");
            }

            // Kiểm tra định dạng số điện thoại
            String phoneRegex = "^[0-9]{10}$";
            if (!phoneNumber.matches(phoneRegex)) {
                throw new Exception("Invalid phone number format. It must contain exactly 10 digits.");
            }

            // Kiểm tra xem có dấu cách ở cuối hay không
            if (fullName.endsWith(" ") || address.endsWith(" ") || phoneNumber.endsWith(" ")) {
                throw new Exception("Fields must not have trailing spaces.");
            }

            int n = userDAO.updateSellerProfile(phoneNumber, fullName, address, sellerId);
            if (n <= 0) {
                throw new Exception("Profile update failed!");
            }

            Seller seller = userDAO.getSellerById(sellerId);
            session.setAttribute("seller", seller);
            message = "Update profile successful!";
        } catch (Exception e) {
            message = "Error: " + e.getMessage();
        }

        session.setAttribute("message", message);
        response.sendRedirect("update-seller-profile");
    }

}
