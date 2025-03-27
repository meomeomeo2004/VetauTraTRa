package controller.customerController;

import dal.CustomerDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Customer;
import model.User;

@WebServlet(name = "CustomerProfileUpdate", urlPatterns = {"/update-profile"})
public class CustomerProfileUpdate extends HttpServlet {

    private final CustomerDAO customerDAO = new CustomerDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        HttpSession session = request.getSession();
        User acc = (User) session.getAttribute("account");
        if (acc != null && acc.getRole().equalsIgnoreCase("customer")) {
            Customer customer = customerDAO.getCustomerById(acc.getId());
            request.setAttribute("cus", customer);
        }
        request.getRequestDispatcher("updateCustomerProfile.jsp").forward(request, response);
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

            if (id.isBlank() || fullName.isBlank() || address.isBlank() || phoneNumber.isBlank()) {
                throw new Exception("All fields must be filled!");
            }

            // Lấy thông tin khách hàng hiện tại để so sánh
            int customerId = Integer.parseInt(id);
            Customer currentCustomer = customerDAO.getCustomerById(customerId);

            if (currentCustomer == null) {
                throw new Exception("Customer not found!");
            }

            // Kiểm tra nếu không có thay đổi
            if (currentCustomer.getFullName().equals(fullName)
                && currentCustomer.getAddress().equals(address)
                && currentCustomer.getPhoneNumber().equals(phoneNumber)) {
                throw new Exception("No changes detected in the profile information!");
            }

            // Xác thực full name
            String fullNameRegex = "^[\\p{L}]+( [\\p{L}]+)*$";
            if (!fullName.matches(fullNameRegex) || fullName.length() < 2 || fullName.length() > 50) {
                throw new Exception("Full Name must be between 2 and 50 characters and only contain alphabetic characters and spaces.");
            }

            // Xác thực địa chỉ
            String addressRegex = "^[a-zA-Z0-9\\s,/#-]{5,100}$";
            if (!address.matches(addressRegex)) {
                throw new Exception("Address must contain 5-100 characters and only accept alphabetic characters, numbers, spaces, commas, slashes, and hyphens.");
            }

            // Xác thực số điện thoại
            String phoneRegex = "^[0-9]{10}$";
            if (!phoneNumber.matches(phoneRegex)) {
                throw new Exception("Invalid phone number format. It must contain exactly 10 digits.");
            }

            // Kiểm tra dấu cách ở cuối
            if (fullName.endsWith(" ") || address.endsWith(" ") || phoneNumber.endsWith(" ")) {
                throw new Exception("Fields must not have trailing spaces.");
            }

            int n = customerDAO.updateCustomerProfile(phoneNumber, fullName, address, customerId);
            if (n <= 0) {
                throw new Exception("Profile update failed!");
            }

            // Cập nhật thông tin vào session
            Customer updatedCustomer = customerDAO.getCustomerById(customerId);
            session.setAttribute("customer", updatedCustomer);
            message = "Update profile successful!";
        } catch (Exception e) {
            message = "Error: " + e.getMessage();
        }

        session.setAttribute("message", message);
        response.sendRedirect("update-profile");
    }
}
