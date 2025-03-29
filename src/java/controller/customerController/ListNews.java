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
import java.util.List;
import model.News;

@WebServlet(name = "ListNews", urlPatterns = {"/list-news"})
public class ListNews extends HttpServlet {

    private NewsDAO newsDAO = new NewsDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        int page = 1;
        int pageSize = 5;

        String pageParam = request.getParameter("page");
        if (pageParam != null) {
            try {
                page = Integer.parseInt(pageParam);
            } catch (NumberFormatException e) {
                page = 1;
            }
        }

        String title = request.getParameter("title");
        String createdAt = request.getParameter("createdAt");

        List<News> newsList;
        int totalNewsCount;

        if ((title != null && !title.trim().isEmpty()) || (createdAt != null && !createdAt.trim().isEmpty())) {
            totalNewsCount = newsDAO.getFilteredNewsCount(title, createdAt);
            int totalPages = (int) Math.ceil((double) totalNewsCount / pageSize);

            newsList = newsDAO.filterNews(title, createdAt, page, pageSize);

            request.setAttribute("title", title);
            request.setAttribute("createdAt", createdAt);
            request.setAttribute("totalPages", totalPages);
        } else {
            totalNewsCount = newsDAO.getTotalNewsCount();
            int totalPages = (int) Math.ceil((double) totalNewsCount / pageSize);

            newsList = newsDAO.getNewsPaged(page, pageSize);
            request.setAttribute("totalPages", totalPages);
        }

        request.setAttribute("allNewsList", newsList);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalNewsCount", totalNewsCount);

        request.getRequestDispatcher("listNews.jsp").forward(request, response);
    }
}
