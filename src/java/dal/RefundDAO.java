/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Refund;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author ASUS
 */
public class RefundDAO extends DBContext {

    public List<Refund> getAllRefund() {
        List<Refund> refunds = new ArrayList<>();
        String sql = "SELECT * FROM refund";

        try (PreparedStatement stmt = connection.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Refund refund = new Refund(
                        rs.getInt("id"),
                        rs.getInt("status"),
                        rs.getInt("userId"),
                        (Integer) rs.getObject("staffId"),
                        rs.getInt("ticketId"),
                        rs.getString("userBankName"),
                        rs.getString("userBankNumber"),
                        rs.getString("userBankAccountName"),
                        rs.getTimestamp("created_at").toLocalDateTime(),
                        rs.getTimestamp("handle_time") != null ? rs.getTimestamp("handle_time").toLocalDateTime() : null,
                        null
                );
                refunds.add(refund);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return refunds;
    }

    public Refund getRefundById(int id) {
        String sql = "SELECT * FROM refund WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new Refund(
                            rs.getInt("id"),
                            rs.getInt("status"),
                            rs.getInt("userId"),
                            (Integer) rs.getObject("staffId"),
                            rs.getInt("ticketId"),
                            rs.getString("userBankName"),
                            rs.getString("userBankNumber"),
                            rs.getString("userBankAccountName"),
                            rs.getTimestamp("created_at").toLocalDateTime(),
                            rs.getTimestamp("handle_time") != null ? rs.getTimestamp("handle_time").toLocalDateTime() : null,
                            null
                    );
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean changeRefundStatus(int refundId, int staffId) {
        String sql = "UPDATE refund SET status = CASE WHEN status = 0 THEN 1 END, handle_time = NOW(), staffId = ? WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, staffId);  // Set the staffId parameter
            stmt.setInt(2, refundId);  // Set the refundId parameter
            int rowsAffected = stmt.executeUpdate();
            DAOforAdmin dao = new DAOforAdmin();
            dao.recordChange("Refunded a ticket", staffId, "staff");
            return rowsAffected > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public int insertRefund(Refund refund) {
        int n = 0;
        String sql = """
        INSERT INTO refund (status, userId, ticketId, userBankName, userBankNumber, userBankAccountName, created_at)
                VALUES (0, ?, ?, ?, ?, ?, ?)
    """;
        try {
            PreparedStatement pre = connection.prepareStatement(sql);

            int index = 1;
            pre.setInt(index++, refund.getUserId());
            pre.setInt(index++, refund.getTicketId());
            pre.setString(index++, refund.getUserBankName());
            pre.setString(index++, refund.getUserBankNumber());
            pre.setString(index++, refund.getUserBankAccountName());
            pre.setTimestamp(index++, Timestamp.valueOf(refund.getCreatedAt()));
            n = pre.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(RefundDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return n;
    }

}
