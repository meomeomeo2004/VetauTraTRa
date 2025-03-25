package controller.customerController;

import dal.NewsDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.News;

@WebServlet(name = "NewsContent", urlPatterns = {"/news"})
public class NewsContent extends HttpServlet {

    private final NewsDAO newsDAO = new NewsDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String newsId = request.getParameter("id");
        News newsContent = null;

        if (newsId != null && !newsId.isEmpty()) {
            try {
                int id = Integer.parseInt(newsId);
                newsContent = newsDAO.getNewsById(id);
            } catch (NumberFormatException e) {
            }
        }

        request.setAttribute("newsContent", newsContent);
        request.getRequestDispatcher("newsContent.jsp").forward(request, response);
    }

}
