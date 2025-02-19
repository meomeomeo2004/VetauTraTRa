/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import model.User;
import java.util.ArrayList;
import java.util.List;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author HP
 */
public class UserDAO extends DBContext {
    
    public User Login(String email,String password){
        String sql = "Select * from User where email = ? and password = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, email);
            pre.setString(2, password);
            ResultSet rs = pre.executeQuery();
            while(rs.next()){
                return new User(rs.getInt(1), 
                        rs.getString(2), 
                        rs.getString(3), 
                        rs.getString(4));
            }
                
        } catch (Exception e) {
        }
        return null;
    }
    
//    public void Register

//    public User authenticate(String email, String password, String role) {
//        User user = null;
//        String sql = "SELECT * FROM " + role + " WHERE email = ? AND password = ?";
//
//        try {
//            PreparedStatement ps = connection.prepareStatement(sql);
//            ps.setString(1, email);
//            ps.setString(2, password);
//            ResultSet rs = ps.executeQuery();
//            if (rs.next()) {
//                String imgUrl = null;
//                try {
//                    imgUrl = rs.getString("img_url");
//                } catch (SQLException e) {
//                    System.out.println("Column 'img_url' not found: " + e.getMessage());
//                }
//
//                String address = null;
//                try {
//                    address = rs.getString("address");
//                } catch (SQLException e) {
//                    System.out.println("Column 'address' not found: " + e.getMessage());
//                }
//
//                int status = 0;
//                try {
//                    status = rs.getInt("status");
//                } catch (SQLException e) {
//                    System.out.println("Column 'status' not found: " + e.getMessage());
//                }
//
//                user = new User(
//                    rs.getInt("id"),
//                    rs.getString("full_name"),
//                    rs.getString("email"),
//                    rs.getString("phone_number"),
//                    address,
//                    rs.getString("role"),
//                    status,
//                    imgUrl
//                );
//            }
//        } catch (SQLException ex) {
//            Logger.getLogger(CustomerDAO.class.getName()).log(Level.SEVERE, null, ex);
//        }
//        return user;
//    }

//    public static void main(String[] args) {
//        System.out.println(new UserDAO().authenticate("customer@email.com", "customer", "Customer"));
//    }

}
