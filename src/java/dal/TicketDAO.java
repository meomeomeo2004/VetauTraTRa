/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import model.Ticket;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import lombok.CustomLog;

/**
 *
 * @author dtam6
 */
public class TicketDAO extends DBContext {

    public void cancelTicketById() {

    }

    public List<Ticket> getTicketsByTransactionId(int transactionId) {
        List<Ticket> tickets = new ArrayList<>();
        String sql = """
                     SELECT * FROM Ticket WHERE transaction_id = ?; """;
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, transactionId);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {

                Ticket ticket = new Ticket(
                    rs.getInt("id"),
                    rs.getInt("status"),
                    rs.getInt("luggage_type"),
                    rs.getTimestamp("booking_date"),
                    rs.getInt("route_id"),
                    rs.getInt("seat_id"),
                    rs.getInt("staff_id"),
                    rs.getInt("transaction_id"));

                tickets.add(ticket);
            }

        } catch (SQLException ex) {
            Logger.getLogger(TicketDAO.class
                .getName()).log(Level.SEVERE, null, ex);
        }
        return tickets;
    }

    public static void main(String[] args) {
        TicketDAO dao = new TicketDAO();

        var result = dao.getTicketsByTransactionId(9);
        System.out.println(result);
    }
}
