package controller.staffController;

import dal.TicketDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

@WebServlet(name = "ChangeStatusTicket", urlPatterns = {"/staff_page/ChangeStatusTicket"})
public class ChangeStatusTicket extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id_raw = request.getParameter("id");
        TicketDAO t_dao = new TicketDAO();
        int id = -1;

        try {
            id = Integer.parseInt(id_raw);
        } catch (Exception e) {
            e.printStackTrace();
        }
        HttpSession session = request.getSession();
        User acc = (User) session.getAttribute("account");

        // Thay đổi trạng thái vé
        t_dao.changeTicketStatus(id, acc.getId());

        // Chuyển hướng về danh sách vé với thông báo thành công
        response.sendRedirect("../staff_page/ticketList?success=true");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Change status of ticket";
    }
}
