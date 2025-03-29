/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.customerController;

import dal.CustomerDAO;
import dal.TransactionDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Customer;
import model.Transaction;
import model.User;

@WebServlet(name = "TransactionHistory", urlPatterns = {"/transaction"})
public class TransactionHistory extends HttpServlet {

    private final CustomerDAO customerDAO = new CustomerDAO();
    private final TransactionDAO transactionDAO = new TransactionDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        HttpSession session = request.getSession();
        User account = (User) session.getAttribute("account");

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

        String paymentDate = request.getParameter("paymentDate");
        request.setAttribute("paymentDate", paymentDate);
        String minAmountStr = request.getParameter("minAmount");
        request.setAttribute("minAmount", minAmountStr);
        String maxAmountStr = request.getParameter("maxAmount");
        request.setAttribute("maxAmount", maxAmountStr);

        Double minAmount = minAmountStr != null && !minAmountStr.isEmpty() ? Double.parseDouble(minAmountStr) : null;
        Double maxAmount = maxAmountStr != null && !maxAmountStr.isEmpty() ? Double.parseDouble(maxAmountStr) : null;

        if (account != null) {
            try {
                Customer customer = customerDAO.getCustomerById(account.getId());

                List<Transaction> transactions;
                int totalTransactions;
                int totalPages;

                if ((paymentDate != null && !paymentDate.isEmpty()) || minAmount != null || maxAmount != null) {
                    // Lọc giao dịch với các điều kiện
                    transactions = transactionDAO.filterTransactionsPaged(customer.getId(), paymentDate, minAmount, maxAmount, page, pageSize);
                    // Đếm số lượng giao dịch đã lọc
                    totalTransactions = transactionDAO.countFilteredTransactions(customer.getId(), paymentDate, minAmount, maxAmount);
                } else {
                    // Lấy tất cả giao dịch không có bộ lọc
                    transactions = transactionDAO.getTransactionByCustomerIdPaged(customer.getId(), page, pageSize);
                    totalTransactions = transactionDAO.getTransactionCountByCustomerId(customer.getId());
                }

                // Tính tổng số trang
                totalPages = (int) Math.ceil((double) totalTransactions / pageSize);

                request.setAttribute("transactions", transactions);
                request.setAttribute("currentPage", page);
                request.setAttribute("totalPages", totalPages);
                request.setAttribute("paymentDate", paymentDate);
                request.setAttribute("minAmount", minAmountStr);
                request.setAttribute("maxAmount", maxAmountStr);

                request.getRequestDispatcher("transactionOfCustomer.jsp").forward(request, response);
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Invalid input format!");
                request.getRequestDispatcher("transactionOfCustomer.jsp").forward(request, response);
            }
        } else {
            request.setAttribute("error", "Please log in to view your transactions!");
            request.getRequestDispatcher("transactionOfCustomer.jsp").forward(request, response);
        }
    }
}
