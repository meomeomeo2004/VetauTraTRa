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
            return rowsAffected > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
