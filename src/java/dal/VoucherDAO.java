/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.math.BigDecimal;
import model.Luggage;
import java.sql.Timestamp;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
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
                    .validTo(rs.getTimestamp("valid_to"))
                    .quantity(rs.getInt("quantity"))
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
    
    public List<Voucher> getVoucherBySellerId(int sellerid){
        List<Voucher> list = new ArrayList<>();
        String sql = """
                     Select * from voucher
                     where created_by = ?
                     """;
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, sellerid);
            ResultSet rs = pre.executeQuery();
            while(rs.next()){
                list.add(new Voucher(rs.getInt(1), rs.getString(2), 
                        rs.getBigDecimal(3), rs.getTimestamp(4), 
                        rs.getTimestamp(5), rs.getInt(6), 
                        rs.getInt(7), rs.getInt(8)));
            }
        } catch (Exception e) {
        }
        return list;
    }
    
    public void sellerAddVoucher(String code,BigDecimal discount,String valid_from,
            String valid_to,int quantity,int sellerid,int status){
        String sql = """
                     INSERT INTO Voucher (code, discount_amount, valid_from, valid_to, quantity,created_by,status)
                     VALUES (?,?,?,?,?,?,0)                 
                     """;
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, code);
            pre.setBigDecimal(2, discount);
            SimpleDateFormat dateTimeFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
            Timestamp validfrom = new Timestamp(dateTimeFormat.parse(valid_from).getTime());
            Timestamp validto = new Timestamp(dateTimeFormat.parse(valid_to).getTime());
            pre.setTimestamp(3, validfrom);
            pre.setTimestamp(4, validto);
            pre.setInt(5, quantity);
            pre.setInt(6, sellerid);
            pre.executeUpdate();
        } catch (Exception e) {
        }
    }
    
    public void editVoucher (int id ,BigDecimal discount,String valid_from,String valid_to,int quantity,int status){
        String sql = """
                     UPDATE Voucher                      
                     SET discount_amount = ?,
                         valid_from = ?,
                         valid_to = ?,
                         quantity = ?,
                         status = ?,
                     WHERE id = ?                  
                     """;
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(6, id);
            pre.setBigDecimal(1, discount);
            SimpleDateFormat dateTimeFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
            Timestamp validfrom = new Timestamp(dateTimeFormat.parse(valid_from).getTime());
            Timestamp validto = new Timestamp(dateTimeFormat.parse(valid_to).getTime());
            pre.setTimestamp(2, validfrom);
            pre.setTimestamp(3, validto);
            pre.setInt(4, quantity);
            pre.setInt(5, status);
            pre.executeUpdate();
        } catch (Exception e) {
        }
    }
    
    public Voucher getVoucherById(int sellerid){
        String sql = """
                     Select * from voucher
                     where id = ?
                     """;
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, sellerid);
            ResultSet rs = pre.executeQuery();
            while(rs.next()){
                return new Voucher(rs.getInt(1), rs.getString(2), 
                        rs.getBigDecimal(3), rs.getTimestamp(4), 
                        rs.getTimestamp(5), rs.getInt(6), 
                        rs.getInt(7), rs.getInt(8));
            }
        } catch (Exception e) {
        }
        return null;
    }
     
}
