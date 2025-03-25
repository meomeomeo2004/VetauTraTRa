package controller.staffController;

import controller.resetService;
import dal.CustomerDAO;
import dal.RefundDAO;
import dal.TicketDAO;
import dal.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Refund;
import model.Ticket;
import model.TicketDetail;

@WebServlet(name = "ChangeStatusRefund", urlPatterns = {"/staff_page/changeStatusRefund"})
public class ChangeStatusRefund extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id_raw = request.getParameter("id");
        RefundDAO fdao = new RefundDAO();
        int id;
        TicketDAO tdao=new TicketDAO();
        UserDAO udao=new UserDAO();
        
        try {
            id = Integer.parseInt(id_raw);
            fdao.changeRefundStatus(id);
            Refund rf= fdao.getRefundById(id);
            TicketDetail tk= tdao.getTicketDetailById(rf.getTicketId());
            resetService service= new resetService();
            service.sendRefundSuccess(udao.getUserById(rf.getUserId()).getEmail(), rf.getUserBankAccountName(), rf.getTicketId(), rf.getUserBankNumber(), rf.getUserBankName(), tk.getAmountPaid());
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }
        request.getRequestDispatcher("/staff_page/refundList").forward(request, response);      
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet to change the refund status from Pending to Completed";
    }
}
