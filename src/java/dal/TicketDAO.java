/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.math.BigDecimal;
import java.sql.Timestamp;  
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.TicketDetail;

/**
 *
 * @author ASUS
 */
public class TicketDAO extends DBContext {

    public List<TicketDetail> getAllTicketDetails() {
        List<TicketDetail> tickets = new ArrayList<>();
        String sql = "SELECT t.id, t.status, t.route_id, t.seat_id, t.staff_id, t.transaction_id, "
                + "t.luggage_type, tr.amount_paid, c.phone_number, c.full_name, c.address, "
                + "r.departure_station, r.arrival_station, r.departure_time, r.arrival_time "
                + "FROM Ticket t "
                + "JOIN Transaction tr ON t.transaction_id = tr.id "
                + "JOIN Customer c ON tr.customer_id = c.id "
                + "JOIN Route r ON t.route_id = r.id";

        try (PreparedStatement stmt = connection.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                TicketDetail ticket = new TicketDetail();
                ticket.setId(rs.getInt("id"));
                ticket.setStatus(rs.getInt("status"));
                ticket.setRouteId(rs.getInt("route_id"));
                ticket.setSeatId(rs.getInt("seat_id"));
                ticket.setStaffId(rs.getInt("staff_id"));
                ticket.setTransactionId(rs.getInt("transaction_id"));
                ticket.setLuggageType(rs.getInt("luggage_type"));
                ticket.setAmountPaid(rs.getBigDecimal("amount_paid"));
                ticket.setPhoneNumber(rs.getString("phone_number"));
                ticket.setFullName(rs.getString("full_name"));
                ticket.setAddress(rs.getString("address"));
                ticket.setDepartureStation(rs.getString("departure_station"));
                ticket.setArrivalStation(rs.getString("arrival_station"));
                ticket.setDepartureTime(rs.getTimestamp("departure_time"));
                ticket.setArrivalTime(rs.getTimestamp("arrival_time"));

                tickets.add(ticket);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return tickets;
    }

    public TicketDetail getTicketDetailById(int ticketId) {
        String sql = "SELECT t.id, t.status, t.route_id, t.seat_id, t.staff_id, t.transaction_id, "
                + "t.luggage_type, tr.amount_paid, c.phone_number, c.full_name, c.address, "
                + "r.departure_station, r.arrival_station, r.departure_time, r.arrival_time "
                + "FROM Ticket t "
                + "JOIN Transaction tr ON t.transaction_id = tr.id "
                + "JOIN Customer c ON tr.customer_id = c.id "
                + "JOIN Route r ON t.route_id = r.id "
                + "WHERE t.id = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, ticketId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    TicketDetail ticket = new TicketDetail();
                    ticket.setId(rs.getInt("id"));
                    ticket.setStatus(rs.getInt("status"));
                    ticket.setRouteId(rs.getInt("route_id"));
                    ticket.setSeatId(rs.getInt("seat_id"));
                    ticket.setStaffId(rs.getInt("staff_id"));
                    ticket.setTransactionId(rs.getInt("transaction_id"));
                    ticket.setLuggageType(rs.getInt("luggage_type"));
                    ticket.setAmountPaid(rs.getBigDecimal("amount_paid"));
                    ticket.setPhoneNumber(rs.getString("phone_number"));
                    ticket.setFullName(rs.getString("full_name"));
                    ticket.setAddress(rs.getString("address"));
                    ticket.setDepartureStation(rs.getString("departure_station"));
                    ticket.setArrivalStation(rs.getString("arrival_station"));
                    ticket.setDepartureTime(rs.getTimestamp("departure_time"));
                    ticket.setArrivalTime(rs.getTimestamp("arrival_time"));

                    return ticket;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public static void main(String[] args) {
        TicketDAO ticketDAO = new TicketDAO();

        // Kiểm tra phương thức getAllTicketDetails
        System.out.println("Danh sách tất cả vé:");
        List<TicketDetail> tickets = ticketDAO.getAllTicketDetails();
        for (TicketDetail ticket : tickets) {
            System.out.println(ticket.getFullName());
        }

        // Kiểm tra phương thức getTicketDetailById với ID cụ thể
        int ticketIdToTest = 1; // Cập nhật ID thực tế có trong database
        System.out.println("\nChi tiết vé có ID: " + ticketIdToTest);
        TicketDetail ticketDetail = ticketDAO.getTicketDetailById(ticketIdToTest);
        if (ticketDetail != null) {
            System.out.println(ticketDetail);
        } else {
            System.out.println("Không tìm thấy vé với ID: " + ticketIdToTest);
        }
    }

    public boolean changeTicketStatus(int ticketId) {
        String sql = "UPDATE Ticket SET status = CASE WHEN status = 0 THEN 1 ELSE 0 END WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, ticketId);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    public void updateTicketDetail(int ticketId, Integer luggageType, 
                                  String phoneNumber, String fullName, 
                                  String address) {
    String sql = "UPDATE ticket t " +
             "JOIN transaction tr ON t.transaction_id = tr.id " +
             "JOIN customer c ON tr.customer_id = c.id " +
             "SET t.luggage_type = ?, " +
             "c.phone_number = ?, c.full_name = ?, c.address = ? " + 
             "WHERE t.id = ?";


    try {
        PreparedStatement stmt = connection.prepareStatement(sql);

        if (luggageType != null) {
            stmt.setInt(1, luggageType);
        } else {
            stmt.setNull(1, java.sql.Types.INTEGER);
        }

        if (phoneNumber != null) {
            stmt.setString(2, phoneNumber);
        } else {
            stmt.setNull(2, java.sql.Types.VARCHAR);
        }

        if (fullName != null) {
            stmt.setString(3, fullName);
        } else {
            stmt.setNull(3, java.sql.Types.VARCHAR);
        }

        if (address != null) {
            stmt.setString(4, address);
        } else {
            stmt.setNull(4, java.sql.Types.VARCHAR);
        }
        stmt.setInt(5, ticketId);
        
        int rowsUpdated = stmt.executeUpdate();
System.out.println("Rows updated: " + rowsUpdated);

        
    } catch (Exception e) {
        e.printStackTrace();
    }
    }
}
