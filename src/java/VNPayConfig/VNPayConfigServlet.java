/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package VNPayConfig;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import VNPayConfig.Config;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "VNPayConfigServlet", urlPatterns = {"/pay"})
public class VNPayConfigServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy giá trị amount từ request parameter
        String numSeats = request.getParameter("numSeats");
        String customerId = request.getParameter("customerId");
        String amountStr = request.getParameter("amount");
        List<Map<String, Object>> transactions = (List<Map<String, Object>>) request.getSession().getAttribute("transactions");
        long amount = 0;

        try {
            amount = Long.parseLong(amountStr);
        } catch (NumberFormatException e) {
            response.getWriter().println("Lỗi: Giá trị thanh toán không hợp lệ.");
            return;
        }

        request.getSession().setAttribute("amount", amount);
        request.getSession().setAttribute("numSeats", numSeats);
        request.getSession().setAttribute("customerId", customerId);

        String orderId = "DH" + System.currentTimeMillis();
        String paymentUrl = Config.createPaymentUrl(amount, orderId);
        
        if (paymentUrl != null) {
            response.sendRedirect(paymentUrl);
        } else {
            response.getWriter().println("Lỗi khi tạo URL thanh toán.");
        }
    }

}
