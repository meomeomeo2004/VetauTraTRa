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
import model.News;

/**
 *
 * @author Aus TUF GAMAING
 */
@WebServlet(name = "EditNews", urlPatterns = {"/admin_page/EditNews"})
public class EditNews extends HttpServlet {

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
            out.println("<title>Servlet EditNews</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EditNews at " + request.getContextPath() + "</h1>");
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

        try {
            DAOforAdmin dao = new DAOforAdmin();
            int id = Integer.parseInt(request.getParameter("id"));
            News n = dao.getNewsById(id);

            request.setAttribute("title", n.getTitle());
            request.setAttribute("content", n.getContent());

            HttpSession session = request.getSession();
            session.setAttribute("id", String.valueOf(id));

            request.getRequestDispatcher("EditNews.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
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

        DAOforAdmin dao = new DAOforAdmin();
        String title = request.getParameter("newsTitle");
        String content = request.getParameter("newsContent");

        boolean allvalid = true;
        String titleError = null;
        String contentError = null;

        try {
            if (title == null) {
                allvalid = false;
                titleError = "Title must be from 1 to 100 character";
            }
            if (content == null) {
                allvalid = false;
                contentError = "Content must be from 1 to 60,000 character";
            }
            if (!allvalid) {
                throw new Exception();
            }

            content = content.trim();
            title = title.trim();

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


            HttpSession session = request.getSession();
            int id = Integer.parseInt(String.valueOf(session.getAttribute("id")));
            dao.editNew(content, title, id);
            session.setAttribute("id", null);
        } catch (Exception e) {
            request.setAttribute("content", content);
            request.setAttribute("title", title);
            request.setAttribute("contentError", contentError);
            request.setAttribute("titleError", titleError);
            
            request.getRequestDispatcher("EditNews.jsp").forward(request, response);
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
