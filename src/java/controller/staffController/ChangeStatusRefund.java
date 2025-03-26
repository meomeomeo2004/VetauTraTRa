package controller.staffController;

import controller.resetService;
import dal.CustomerDAO;
import dal.RefundDAO;
import dal.SeatDAO;
import dal.StaffDAO;
import dal.TicketDAO;
import dal.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Refund;
import model.Seat;
import model.Staff;
import model.Ticket;
import model.TicketDetail;
import model.User;

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
        SeatDAO sDAO = new SeatDAO();
        StaffDAO staffDAO = new StaffDAO();
        int id;
        TicketDAO tdao = new TicketDAO();
        UserDAO udao = new UserDAO();

        try {
            id = Integer.parseInt(id_raw);
            HttpSession session = request.getSession();
            User acc = (User) session.getAttribute("account");
            Staff staff = staffDAO.getStaffByUserId(acc.getId());
            fdao.changeRefundStatus(id, staff.getId());
            Refund rf = fdao.getRefundById(id);
            TicketDetail tk = tdao.getTicketDetailById(rf.getTicketId());
            Seat seat = sDAO.getSeatById(tk.getSeatId());
            resetService service = new resetService();
            service.sendRefundSuccess(udao.getUserById(rf.getUserId()).getEmail(), rf.getUserBankAccountName(), rf.getTicketId(), rf.getUserBankNumber(), rf.getUserBankName(), seat.getPrice());
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
