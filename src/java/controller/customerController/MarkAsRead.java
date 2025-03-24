/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.customerController;

import dal.NewsDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "MarkAsRead", urlPatterns = {"/markAsRead"})
public class MarkAsRead extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String idParam = request.getParameter("id");
        if (idParam != null) {
            int newsId = Integer.parseInt(idParam);
            NewsDAO newsDAO = new NewsDAO();
            newsDAO.markAsRead(newsId);

            HttpSession session = request.getSession();
            session.setAttribute("newsList", newsDAO.getUnreadNews());
            session.setAttribute("allNewsList", newsDAO.getAllNews());
        }
        response.sendRedirect(request.getHeader("referer"));
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

    }

}
