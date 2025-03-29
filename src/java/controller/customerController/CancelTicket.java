package controller.customerController;

import dal.TicketDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "CancelTicket", urlPatterns = {"/cancel-ticket"})
public class CancelTicket extends HttpServlet {

    private final TicketDAO ticketDAO = new TicketDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String ticketIdStr = request.getParameter("ticketId");
        String cancelReason = request.getParameter("cancelReason");

        if (ticketIdStr != null && !ticketIdStr.trim().isEmpty()) {
            try {
                int ticketId = Integer.parseInt(ticketIdStr);

                // Ghi log hoặc lưu cancelReason nếu cần
                System.out.println("Cancel reason: " + cancelReason);

                // Cập nhật trạng thái của ticket về 0 (Canceled)
                boolean success = ticketDAO.changeTicketStatus(ticketId, -1);

                if (success) {
                    request.getSession().setAttribute("ticketId", ticketId);
                    request.getRequestDispatcher("insertRefund.jsp").forward(request, response);
                } else {
                    request.setAttribute("error", "Failed to cancel the ticket.");
                    request.getRequestDispatcher("error.jsp").forward(request, response);
                }
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Invalid ticket ID.");
                request.getRequestDispatcher("error.jsp").forward(request, response);
            }
        } else {
            request.setAttribute("error", "Ticket ID is required.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}
