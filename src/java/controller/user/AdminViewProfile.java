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

@WebServlet(name = "AdminViewProfile", urlPatterns = {"/admin_page/AdminViewProfile"})
public class AdminViewProfile extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        HttpSession session = request.getSession();
        User acc = (User) session.getAttribute("account");
        if (acc != null) {
            int a = acc.getId();
            Admin admin = userDAO.getAdminById(a);
            request.setAttribute("admin", admin);
        }
        request.getRequestDispatcher("./adminProfile.jsp").forward(request, response);
    }

}
