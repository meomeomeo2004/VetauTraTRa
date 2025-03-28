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
        int pageSize = 10;

        String pageParam = request.getParameter("page");
        if (pageParam != null) {
            try {
                page = Integer.parseInt(pageParam);
            } catch (NumberFormatException e) {
                page = 1;
            }
        }

        if (account != null) {
            try {
                Customer customer = customerDAO.getCustomerById(account.getId());

                int totalTransactions = transactionDAO.getTransactionCountByCustomerId(customer.getId());
                int totalPages = (int) Math.ceil((double) totalTransactions / pageSize);

                List<Transaction> transactions = transactionDAO.getTransactionByCustomerIdPaged(customer.getId(), page, pageSize);

                request.setAttribute("transactions", transactions);
                request.setAttribute("currentPage", page);
                request.setAttribute("totalPages", totalPages);

                request.getRequestDispatcher("transactionOfCustomer.jsp").forward(request, response);
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Invalid customer ID!");
                request.getRequestDispatcher("transactionOfCustomer.jsp").forward(request, response);
            }
        } else {
            request.setAttribute("error", "Please enter customer ID!");
            request.getRequestDispatcher("transactionOfCustomer.jsp").forward(request, response);
        }
    }

}
