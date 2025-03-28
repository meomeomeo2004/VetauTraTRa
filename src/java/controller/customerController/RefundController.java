package controller.customerController;

import dal.RefundDAO;
import java.io.IOException;
import java.time.LocalDateTime;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.security.Timestamp;
import model.Refund;

@WebServlet(name = "RefundController", urlPatterns = {"/insert-refund"})
public class RefundController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        try {
            int userId = Integer.parseInt(request.getParameter("userId"));
            int ticketId = Integer.parseInt(request.getParameter("ticketId"));

            String userBankName = request.getParameter("userBankName");
            String userBankNumber = request.getParameter("userBankNumber");
            String userBankAccountName = request.getParameter("userBankAccountName");

            LocalDateTime createdAt = LocalDateTime.now();

            Refund refund = new Refund(
                0, // id
                0, // status = 0 (chưa duyệt)
                userId, // userId
                null, // staffId (chưa có)
                ticketId, // ticketId
                userBankName, // userBankName
                userBankNumber, // userBankNumber
                userBankAccountName, // userBankAccountName
                LocalDateTime.now(), // createdAt
                null, // handle_time
                null // staff (nếu cần)
            );

            RefundDAO refundDAO = new RefundDAO();
            int result = refundDAO.insertRefund(refund);

            if (result > 0) {
                response.sendRedirect("transaction");
            } else {
                // Nếu insert thất bại, quay lại ticketDetails kèm message
                response.sendRedirect("insert-refund");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("insert-refund");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        request.getRequestDispatcher("insertRefund.jsp").forward(request, response);
    }
}
