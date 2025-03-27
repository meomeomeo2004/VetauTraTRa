/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.Ticket;
import model.TicketDetail;
import java.util.logging.Level;
import java.util.logging.Logger;

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
        String sql = "UPDATE ticket t "
                + "JOIN transaction tr ON t.transaction_id = tr.id "
                + "JOIN customer c ON tr.customer_id = c.id "
                + "SET t.luggage_type = ?, "
                + "c.phone_number = ?, c.full_name = ?, c.address = ? "
                + "WHERE t.id = ?";

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

        } catch (Exception ex) {
            Logger.getLogger(TicketDAO.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
        return tickets;
    }

    public boolean createTicketsForTransaction(int transactionId, int routeId, List<Map<String, Object>> seats) {
        String sqlTicket = "INSERT INTO Ticket (status, luggage_type, route_id, seat_id, transaction_id) "
                + "VALUES (1, ?, ?, ?, ?)";

        try (PreparedStatement pstmtTicket = connection.prepareStatement(sqlTicket)) {
            for (Map<String, Object> seat : seats) {
                // Lấy tên ghế
                String seatName = (String) seat.get("seatName");

                // Tìm ID của ghế
                SeatDAO dao = new SeatDAO();
                int seatId = dao.findSeatId(seatName, routeId);

                // Kiểm tra nếu không tìm thấy Seat ID
                if (seatId == -1) {
                    return false;
                }

                // Lấy loại hành lý (mặc định là 0 nếu không có)
                int luggageType = seat.get("luggageId") != null
                        ? Integer.parseInt(seat.get("luggageId").toString())
                        : 0;

                // Thiết lập tham số cho câu truy vấn
                pstmtTicket.setInt(1, luggageType);
                pstmtTicket.setInt(2, routeId);
                pstmtTicket.setInt(3, seatId);
                pstmtTicket.setInt(4, transactionId);

                // Thực thi từng lệnh INSERT
                int rowsAffected = pstmtTicket.executeUpdate();
                System.out.println("✅ Thực thi lệnh INSERT, số dòng bị ảnh hưởng: " + rowsAffected);
            }

            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Map<String, Object>> getTicketsWithDetails(int transactionId) {
        List<Map<String, Object>> tickets = new ArrayList<>();

        String sql = "SELECT t.id AS ticketId, s.name AS seatName, r.route_code AS routeName, l.weight AS luggageWeight, t.booking_date AS bookingDate "
                + "FROM Ticket t "
                + "JOIN Seat s ON t.seat_id = s.id "
                + "JOIN Route r ON t.route_id = r.id "
                + "JOIN Luggage l ON t.luggage_type = l.id "
                + "WHERE t.transaction_id = ?";

        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, transactionId);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {

                Map<String, Object> ticket = new HashMap<>();
                ticket.put("ticketId", rs.getInt("ticketId"));
                ticket.put("seatName", rs.getString("seatName"));
                ticket.put("routeName", rs.getString("routeName"));
                ticket.put("luggageWeight", rs.getInt("luggageWeight"));
                ticket.put("bookingDate", rs.getTimestamp("bookingDate"));
                tickets.add(ticket);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return tickets;
    }
}
