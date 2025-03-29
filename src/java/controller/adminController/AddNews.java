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

/**
 *
 * @author Aus TUF GAMAING
 */
@WebServlet(name = "AddNews", urlPatterns = {"/admin_page/AddNews"})
public class AddNews extends HttpServlet {

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
            out.println("<title>Servlet AddNews</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddNews at " + request.getContextPath() + "</h1>");
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

        request.getRequestDispatcher("AddNews.jsp").forward(request, response);
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
        request.setAttribute("titleError", null);
        request.setAttribute("contetnError", null);
        request.setAttribute("statusError", null);

        DAOforAdmin dao = new DAOforAdmin();
        String title = request.getParameter("newsTitle");
        String content = request.getParameter("newsContent");
        String status = request.getParameter("status");

        boolean allvalid = true;
        String titleError = null;
        String contentError = null;
        String statusError = null;

        try {
            if (title == null) {
                allvalid = false;
                titleError = "Title must be from 1 to 100 character";
            }
            if (content == null) {
                allvalid = false;
                contentError = "Content must be from 1 to 60,000 character";
            }
            if (status == null) {
                allvalid = false;
                statusError = "Incorrect status";
            }
            if (!allvalid) {
                throw new Exception();
            }

            title = title.trim();
            content = content.trim();
            status = status.trim();

            if (!status.matches("^(hidden|published)$")) {
                allvalid = false;
                statusError = "Invalid status";
            }
            if (title.length() < 1 || title.length() > 100) {
                allvalid = false;
                titleError = "Title must be from 1 to 100 character";
            }
            if (content.length() < 1 || content.length() > 60000) {
                allvalid = false;
                contentError = "Content must be from 1 to 60,000 character";
            }
            if (!allvalid) {
                throw new Exception();
            }

            int s = 0;
            if (status.equalsIgnoreCase("published")) {
                s = 1;
            }
            dao.addNew(title, content, s);
        } catch (Exception e) {
            request.setAttribute("title", title);
            request.setAttribute("content", content);
            request.setAttribute("status", status);
            request.setAttribute("titleError", titleError);
            request.setAttribute("contentError", contentError);
            request.setAttribute("statusError", statusError);
            request.getRequestDispatcher("AddNews.jsp").forward(request, response);
            return;
        }

        response.sendRedirect("NewsList");
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
