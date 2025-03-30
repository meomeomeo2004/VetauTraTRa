package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;
import VNPayConfig.Config;
import dal.CustomerDAO;
import dal.TicketDAO;
import dal.TransactionDAO;
import dal.VoucherDAO;
import model.Ticket;
import model.Transaction;

@WebServlet(name = "TransactionServlet", urlPatterns = {"/TransactionServlet"})
public class TransactionServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String vnp_ResponseCode = request.getParameter("vnp_ResponseCode");
        String vnp_TransactionStatus = request.getParameter("vnp_TransactionStatus");

        List<Map<String, Object>> transactions = (List<Map<String, Object>>) request.getSession().getAttribute("transactions");
        String voucherCode = request.getSession().getAttribute("voucherCode").toString();
        if(voucherCode.isEmpty()){
            voucherCode = null;
        }
        request.getSession().removeAttribute("voucherCode");
        int routeId = Integer.parseInt(request.getSession().getAttribute("routeId").toString());
        long amount = (long) request.getSession().getAttribute("amount");
        String numSeats = (String) request.getSession().getAttribute("numSeats");
        String customerId = (String) request.getSession().getAttribute("customerId");
        CustomerDAO customerDAO = new CustomerDAO();
        int customerIdreal = customerDAO.getCustomerById(Integer.parseInt(customerId)).getId();

        if ("00".equals(vnp_TransactionStatus)) {
            TransactionDAO transactionDAO = new TransactionDAO();

            boolean isSuccess = transactionDAO.createTransaction(
                    customerIdreal,
                    "VNPay",
                    Integer.parseInt(numSeats),
                    (double) amount,
                    voucherCode
            );

            if (isSuccess) {
                Transaction latestTransaction = transactionDAO.getLatestTransactionByCustomerId(customerIdreal);
                TicketDAO ticketDAO = new TicketDAO();
                VoucherDAO vdao = new VoucherDAO();
                if(voucherCode != null){
                    vdao.updatequantity(voucherCode);
                }
                
                boolean ticketsCreated = ticketDAO.createTicketsForTransaction(
                        latestTransaction.getId(),
                        routeId,
                        transactions
                );
                List<Map<String, Object>> createdTickets = ticketDAO.getTicketsWithDetails(latestTransaction.getId());
                request.setAttribute("tickets", createdTickets);
                request.setAttribute("transaction", latestTransaction);
                request.setAttribute("transactions", transactions);
                request.setAttribute("routeId", routeId);
                request.setAttribute("amount", amount);
                request.setAttribute("numSeats", numSeats);
                request.setAttribute("customerId", customerId);
                request.setAttribute("success", "Payment success!");
                request.getRequestDispatcher("/transaction.jsp").forward(request, response);
            } else {
                request.setAttribute("fail", "Payment Failed!");
                request.getRequestDispatcher("/PayFailed.jsp").forward(request, response);
            }
        } else {
            request.setAttribute("fail", "Payment Failed!");
            request.getRequestDispatcher("/PayFailed.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}