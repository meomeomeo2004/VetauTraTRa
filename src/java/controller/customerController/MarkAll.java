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

@WebServlet(name = "MarkAsRead", urlPatterns = {"/markAllAsRead"})
public class MarkAll extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        NewsDAO newsDAO = new NewsDAO();
        // Đánh dấu tất cả thông báo là đã đọc
        newsDAO.markAllAsRead();

        // Cập nhật session: lấy lại danh sách thông báo chưa đọc và tất cả thông báo
        HttpSession session = request.getSession();
        session.setAttribute("newsList", newsDAO.getUnreadNews());
        session.setAttribute("allNewsList", newsDAO.getAllNews());

        // Redirect về trang trước (hoặc trang chủ)
        response.sendRedirect(request.getHeader("referer"));
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

    }

}
