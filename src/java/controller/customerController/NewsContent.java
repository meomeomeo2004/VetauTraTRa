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

@WebServlet(name = "NewsContent", urlPatterns = {"/news"})
public class NewsContent extends HttpServlet {

    private final NewsDAO newsDAO = new NewsDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String action = request.getParameter("action");
        if ("markAllAsRead".equals(action)) {
            newsDAO.markAllAsRead();
            response.sendRedirect("news");
            return;
        }

        String idStr = request.getParameter("id");
        if (idStr != null) {
            try {
                int id = Integer.parseInt(idStr);
                newsDAO.markAsRead(id);
                News news = newsDAO.getNewsById(id);
                request.setAttribute("newsContent", news);
            } catch (NumberFormatException e) {
            }
        }

        List<News> unreadNewsList = newsDAO.getUnreadNews();
        List<News> allNewsList = newsDAO.getAllNews();
        request.setAttribute("unreadNewsList", unreadNewsList);
        request.setAttribute("allNewsList", allNewsList);

        request.getRequestDispatcher("newsContent.jsp").forward(request, response);
    }
}
