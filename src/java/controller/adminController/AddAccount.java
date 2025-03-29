/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.adminController;

import dal.DAOforAdmin;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

/**
 *
 * @author Aus TUF GAMAING
 */
@WebServlet(name = "AddAccount", urlPatterns = {"/admin_page/AddAccount"})
public class AddAccount extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AddAccount</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddAccount at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("AddAccount.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            request.setAttribute("emailError", null);
            request.setAttribute("nameError", null);
            request.setAttribute("phoneError", null);
            request.setAttribute("passError", null);
            request.setAttribute("roleError", null);
        
        String fullname = request.getParameter("fullname");
        String phonenumber = request.getParameter("phonenumber");
        String role = request.getParameter("role");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        boolean allvalid = true;
        String nameError = null;
        String phoneError = null;
        String roleError = null;
        String passError = null;
        String emailError = null;

        try {
            if (fullname == null) {
                allvalid = false;
                nameError = "Full Name must be from 1 to 100 character";
            }
            if (phonenumber == null) {
                allvalid = false;
                phoneError = "Phone Number must be from 3 to 20 character";
            }
            if (role == null) {
                allvalid = false;
                roleError = "Invalid role selection";
            }
            if (email == null) {
                allvalid = false;
                emailError = "Email must be from 6 to 100 character";
            }
            if (password == null) {
                allvalid = false;
                passError = "Password must be from 8 to 100 character";
            }
            if (!allvalid) {
                throw new Exception();
            }

            fullname = fullname.trim();
            password = password.trim();
            email = email.trim();
            role = role.trim();
            phonenumber = phonenumber.trim();

            DAOforAdmin acc_dao = new DAOforAdmin();
            List<String> emails = acc_dao.getAllEmail();
            for (String e : emails) {
                if (e.equals(email)) {
                    allvalid = false;
                    emailError = "This email is already in use";
                    break;
                }
            }

            if (!email.matches("^[^@]+@[^@]+\\.[^@]+$")) {
                allvalid = false;
                emailError = "Email must match email format";
            }
            if (!fullname.matches("^[a-zA-Z\\s]*$")) {
                allvalid = false;
                nameError = "Full Name contains alphabetical characters only ";
            }
            if (!phonenumber.matches("^[0-9]*$")) {
                allvalid = false;
                phoneError = "Phone Number contains numberic characters only";
            }
            if (!role.matches("^(Seller|Manager|Staff|Customer)$")) {
                allvalid = false;
                roleError = "Invalid role selection";
            }
            if (!password.matches("^(?=.*[A-Z])(?=.*[0-9])(?=.*[^a-zA-Z0-9]).{8,100}$")) {
                allvalid = false;
                passError = "Password must have at least 1 uppercase letter, 1 number, and 1 special character.";
            }

            if (fullname.length() < 1 || fullname.length() > 100) {
                allvalid = false;
                nameError = "Full Name must be from 1 to 100 character";
            }
            if (phonenumber.length() < 3 || phonenumber.length() > 20) {
                allvalid = false;
                phoneError = "Phone Number must be from 3 to 20 character";
            }
            if (password.length() < 8 || password.length() > 100) {
                allvalid = false;
                passError = "Password must be from 8 to 100 character";
            }
            if (email.length() < 6 || email.length() > 100) {
                allvalid = false;
                emailError = "Email must be from 6 to 100 character";
            }

            if (!allvalid) {
                throw new Exception();
            }

            acc_dao.addNewAcc(fullname, email, phonenumber, password, role);

        } catch (Exception e) {
            request.setAttribute("email", email);
            request.setAttribute("fullname", fullname);
            request.setAttribute("phonenumber", phonenumber);
            request.setAttribute("password", password);
            request.setAttribute("role", role);
            request.setAttribute("emailError", emailError);
            request.setAttribute("nameError", nameError);
            request.setAttribute("phoneError", phoneError);
            request.setAttribute("passError", passError);
            request.setAttribute("roleError", roleError);
            request.getRequestDispatcher("AddAccount.jsp").forward(request, response);
            return;
        }
        
        response.sendRedirect("AccountList?role=" + role);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
