/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import model.Luggage;
import java.sql.Timestamp;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Voucher;
import model.TicketDetail;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author dtam6
 */
public class VoucherDAO extends DBContext {

    public List<Voucher> getAllVoucher() {
        List<Voucher> vouchers = new ArrayList<>();
        String sql = """
                    select * from voucher """;
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                Voucher voucher = Voucher.builder()
                    .id(rs.getInt("id"))
                    .code(rs.getString("code"))
                    .discountAmount(rs.getBigDecimal("discount_amount"))
                    .validFrom(rs.getTimestamp("valid_from"))
                    .validTo(rs.getTimestamp("valid_to") != null ? rs.getTimestamp("valid_to") : null)
                    .status(rs.getInt("status"))
                    .createdBy(rs.getInt("created_by"))
                    .build();
                vouchers.add(voucher);
            }
        } catch (SQLException ex) {
            Logger.getLogger(VoucherDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return vouchers;
    }
}
