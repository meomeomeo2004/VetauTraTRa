package controller.customerController;

import dal.CabinDAO;
import dal.LuggageDAO;
import dal.RouteDAO;
import dal.SeatDAO;
import dal.StaffDAO;
import dal.TicketDAO;
import dal.TrainDAO;
import dto.TicketDTO;
import model.Ticket;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.time.Duration;
import java.time.Instant;
import java.util.ArrayList;
import java.util.List;
import model.*;
import java.sql.Timestamp;

@WebServlet(name = "TicketDetailServlet", urlPatterns = {"/ticket-detail"})
public class TicketDetail extends HttpServlet {

    private final TicketDAO ticketDAO = new TicketDAO();
    private final RouteDAO routeDAO = new RouteDAO();
    private final TrainDAO trainDAO = new TrainDAO();
    private final CabinDAO cabinDAO = new CabinDAO();
    private final SeatDAO seatDAO = new SeatDAO();
    private final StaffDAO staffDAO = new StaffDAO();
    private final LuggageDAO luggageDAO = new LuggageDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String transactionIdStr = request.getParameter("transactionId");
        if (transactionIdStr != null) {
            try {
                int transactionId = Integer.parseInt(transactionIdStr);

                List<Ticket> tickets = ticketDAO.getTicketsByTransactionId(transactionId);

                if (!tickets.isEmpty()) {

                    List<TicketDTO> list = new ArrayList<>();
                    for (Ticket ticket : tickets) {
                        Route route = routeDAO.getRouteById(ticket.getRouteId());
                        Seat seat = seatDAO.getSeatById(ticket.getSeatId());
                        Cabin cabin = cabinDAO.getCabinById(seat.getCabinid());
                        Train train = trainDAO.getTrainById(cabin.getTrainId());
                        Staff staff = staffDAO.getStaffById(ticket.getStaffId());
                        Luggage luggage = luggageDAO.getLuggageById(ticket.getLuggageType());
                        boolean canCanceled = canCanceled(route.getDepartureTime());

                        TicketDTO ticketDTO = new TicketDTO(ticket, luggage, route, train, cabin, seat, staff, canCanceled);
                        list.add(ticketDTO);
                    }

                    request.setAttribute("tickets", list);
                    request.getRequestDispatcher("ticketDetail.jsp").forward(request, response);
                } else {
                    request.setAttribute("error", "Ticket not found!");
                    request.getRequestDispatcher("error.jsp").forward(request, response);
                }
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Invalid transaction ID!");
                request.getRequestDispatcher("error.jsp").forward(request, response);
            }
        } else {
            request.setAttribute("error", "Transaction ID is required!");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    private static boolean canCanceled(Timestamp departureTime) {
        Timestamp currentTime = new Timestamp(System.currentTimeMillis());
        //Timestamp currentTime = Timestamp.valueOf("2024-03-20 12:34:56");
        Instant instantB = departureTime.toInstant();
        Instant instantA = currentTime.toInstant();
        Duration duration = Duration.between(instantA, instantB);
        return duration.toHours() >= 3;
    }
}
