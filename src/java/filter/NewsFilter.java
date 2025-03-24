/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Filter.java to edit this template
 */
package filter;

import dal.NewsDAO;
import java.io.IOException;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import java.util.List;
import model.News;

/**
 *
 * @author dtam6
 */
@WebFilter(filterName = "NewsFilter", urlPatterns = {"/*"})
public class NewsFilter implements Filter {

    private final NewsDAO newsDAO = new NewsDAO();

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
        throws IOException, ServletException {

        List<News> newsList = newsDAO.getAllNews();
        request.setAttribute("newsList", newsList);
        chain.doFilter(request, response);
    }

}
