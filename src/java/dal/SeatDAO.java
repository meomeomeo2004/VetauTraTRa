package dal;

import model.Seat;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author dtam6
 */
public class SeatDAO extends DBContext {

    public Seat getSeatById(int seatId) {
        Seat seat = null;
        String sql = "SELECT id, name, price, cabin_id, status FROM Seat WHERE id = ?";

        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, seatId);
            ResultSet rs = pre.executeQuery();

            if (rs.next()) {
                seat = new Seat(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getLong("price"),
                    rs.getInt("cabin_id"),
                    rs.getInt("status")
                );
            }
        } catch (SQLException ex) {
            Logger.getLogger(SeatDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return seat;
    }
    
    public List<Seat> getReservedSeats(int routeId, int cabinId) {
        List<Seat> reservedSeats = new ArrayList<>();
        String sql = "select seat.id, seat.name from ticket "
                + "join seat on seat.id = ticket.seat_id "
                + "where route_id = ? and cabin_id = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, routeId);
            ps.setInt(2, cabinId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Seat seat = new Seat();
                    seat.setId(rs.getInt("id"));
                    seat.setName(rs.getString("name"));
                    reservedSeats.add(seat);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return reservedSeats;
    }

    public int findSeatId(String seatName, int routeId) {
        String sql = "SELECT seat.id FROM seat "
                + "JOIN cabin ON seat.cabin_id = cabin.id "
                + "JOIN train ON cabin.train_id = train.id "
                + "JOIN route ON train.id = route.train_id "
                + "WHERE seat.name = ? AND route.id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, seatName);
            stmt.setInt(2, routeId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("id");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1; // Trả về -1 nếu không tìm thấy
    }
}
