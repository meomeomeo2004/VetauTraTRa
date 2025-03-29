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
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.UserDetail;

/**
 *
 * @author Aus TUF GAMAING
 */
@WebServlet(name = "EditAccount", urlPatterns = {"/admin_page/EditAccount"})
public class EditAccount extends HttpServlet {

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
            out.println("<title>Servlet EditAccount</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EditAccount at " + request.getContextPath() + "</h1>");
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
        DAOforAdmin acc_dao = new DAOforAdmin();
        String role = request.getParameter("role");
        int id = Integer.parseInt(request.getParameter("id"));
        UserDetail user = acc_dao.getChoosedUser(role, id);

        request.setAttribute("fullname", user.getFullname());
        request.setAttribute("phonenumber", user.getPhonenumber());
        request.setAttribute("address", user.getAddress());
        HttpSession session = request.getSession();
        session.setAttribute("email", user.getEmail());
        session.setAttribute("id", String.valueOf(id));
        session.setAttribute("role", user.getRole());

        request.getRequestDispatcher("EditAccount.jsp").forward(request, response);
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
        request.setAttribute("nameError", null);
        request.setAttribute("phoneError", null);

        HttpSession session = request.getSession();
        String fullname = request.getParameter("fullname");
        String phonenumber = request.getParameter("phonenumber");
        String address = request.getParameter("address");
        if (address == null) {
            address = "";
        }
        String role = String.valueOf(session.getAttribute("role"));
        int id = Integer.parseInt(String.valueOf(session.getAttribute("id")));

        boolean allvalid = true;
        String nameError = null;
        String phoneError = null;
        String addressError = null;

        try {
            if (fullname == null) {
                allvalid = false;
                nameError = "Full Name must be from 1 to 100 character";
            }
            if (phonenumber == null) {
                allvalid = false;
                phoneError = "Phone Number must be from 3 to 20 character";
            }
            if (!allvalid) {
                throw new Exception();
            }

            fullname = fullname.trim();
            phonenumber = phonenumber.trim();
            address.trim();

            if (!fullname.matches("^[a-zA-Z\\s]*$")) {
                allvalid = false;
                nameError = "Full Name contains alphabetical characters only ";
            }
            if (!phonenumber.matches("^[0-9]*$")) {
                allvalid = false;
                phoneError = "Phone Number contains numberic characters only";
            }

            if (fullname.length() < 1 || fullname.length() > 100) {
                allvalid = false;
                nameError = "Full Name must be from 1 to 100 character";
            }
            if (phonenumber.length() < 3 || phonenumber.length() > 20) {
                allvalid = false;
                phoneError = "Phone Number must be from 3 to 20 character";
            }
            if (address.length() > 255) {
                allvalid = false;
                addressError = "Address must have less than 255 character";
            }
            if (!allvalid) {
                throw new Exception();
            }

            DAOforAdmin acc_dao = new DAOforAdmin();
            acc_dao.editAcc(fullname, phonenumber, address, role, id);
            session.setAttribute("email", null);
            session.setAttribute("id", null);
            session.setAttribute("role", null);
        } catch (Exception e) {
            request.setAttribute("fullname", fullname);
            request.setAttribute("phonenumber", phonenumber);
            request.setAttribute("address", address);
            request.setAttribute("nameError", nameError);
            request.setAttribute("phoneError", phoneError);
            request.setAttribute("addressError", addressError);
            
            request.getRequestDispatcher("EditAccount.jsp").forward(request, response);
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
