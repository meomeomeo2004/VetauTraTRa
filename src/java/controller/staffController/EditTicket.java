package controller.staffController;

import dal.CustomerDAO;
import dal.TicketDAO;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.TicketDetail;

@WebServlet(name = "EditTicket", urlPatterns = {"/staff_page/editTicket"})
public class EditTicket extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        TicketDAO tdao = new TicketDAO();
        String id_raw = request.getParameter("id");
        int id = -1;
        try {
            id = Integer.parseInt(id_raw);
        } catch (Exception e) {
            e.printStackTrace();
        }
        TicketDetail ticket = tdao.getTicketDetailById(id);
        request.getSession().setAttribute("ticket", ticket);
        request.getRequestDispatcher("EditTicket.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<String> errors = new ArrayList<>();
        try {
            String idRaw = request.getParameter("id");
            String fullName = request.getParameter("fullName");
            String phoneNumber = request.getParameter("phoneNumber");
            String address = request.getParameter("address");
            String luggageTypeRaw = request.getParameter("luggageType");
            CustomerDAO customerDAO = new CustomerDAO();
            if (idRaw == null || luggageTypeRaw == null) {
                errors.add("Missing required parameters!");
            }

            if (!phoneNumber.matches("^0[0-9]{9}$")) {
                errors.add("Phone number must start with '0' and contain exactly 10 digits.");
            }

            if (address.length() < 3 || address.length() > 255 || !address.matches(".*[a-zA-Z].*") || !address.matches(".*\\d.*")) {
                errors.add("Address must be between 3 and 255 characters long, and contain both letters and numbers.");
            }

            if (fullName.length() < 3 || !fullName.matches("[A-Za-z\\s]{3,}")) {
                errors.add("Full name must contain only letters and be at least 3 characters long.");
            }
            if (customerDAO.checkPhoneNumberExist(phoneNumber)) {
            errors.add("Phone Number already exists");
        }

            if (!errors.isEmpty()) {
                request.setAttribute("errorMessage", errors);
                request.getRequestDispatcher("EditTicket.jsp").forward(request, response);
                return;
            }

            int ticketId = Integer.parseInt(idRaw);
            int luggageType = Integer.parseInt(luggageTypeRaw);

            TicketDAO t_dao = new TicketDAO();
            t_dao.updateTicketDetail(ticketId, luggageType, phoneNumber, fullName, address);

            TicketDetail updatedTicket = t_dao.getTicketDetailById(ticketId);
            request.getSession().setAttribute("ticket", updatedTicket);

            response.sendRedirect("../staff_page/ticketList");
        } catch (Exception e) {
            e.printStackTrace();
            errors.add("An error occurred while updating the ticket.");
            request.setAttribute("errorMessage", errors);
            request.getRequestDispatcher("EditTicket.jsp").forward(request, response);
        }
    }
}
