///*
// * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
// * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
// */
//package dal;
//
//import model.Customer;
//import java.util.ArrayList;
//import java.util.List;
//import java.sql.*;
//import java.util.logging.Level;
//import java.util.logging.Logger;
//
///**
// *
// * @author dtam6
// */
//public class CustomerDAO extends DBContext {
//
//    public static void main(String[] args) {
//        CustomerDAO customerDAO = new CustomerDAO();
//        Customer customer = Customer.builder()
//            .id(5)
//            .fullName("Customer").email("customer@email.com").phoneNumber("0123456789").address("hanoi, vietnam")
//            .build();
//        System.out.println(customerDAO.updateProfileCustomer(customer));
//    }
//
//    public Customer customerLogin(String email, String password) {
//        Customer customer = null;
//        String sql = "select * from Customer where email = ? and password = ? AND status = 1";
//        try {
//            PreparedStatement pre =connection.prepareStatement(sql);
//            pre.setString(1, email);
//            pre.setString(2, password);
//            ResultSet rs = pre.executeQuery();
//            while (rs.next()) {
//                int id = rs.getInt("id");
//                String fullName = rs.getString("full_name");
////                String email = rs.getString("email");
//                String phoneNumber = rs.getString("phone_number");
////                String password = rs.getString("password");
//                String address = rs.getString("address");
//                String role = rs.getString("role");
//                int status = rs.getInt("status");
//
//                customer = new Customer(id, fullName, email, phoneNumber, "", address, role, status);
//            }
//        } catch (SQLException e) {
//            System.err.println(e.getMessage());
//        }
//        return customer;
//    }
//
//    public int updateProfileCustomer(Customer customer) {
//        int n = 0;
//        String sql = "UPDATE customer SET full_name = ?, email = ?, phone_number = ?, address = ? WHERE id = ?";
//        try {
//            PreparedStatement pre =connection.prepareStatement(sql);
//            int index = 1;
//            pre.setString(index++, customer.getFullName());
//            pre.setString(index++, customer.getEmail());
//            pre.setString(index++, customer.getPhoneNumber());
//            pre.setString(index++, customer.getAddress());
//            pre.setInt(index++, customer.getId());
//
//            n = pre.executeUpdate();
//        } catch (SQLException ex) {
//            Logger.getLogger(CustomerDAO.class.getName()).log(Level.SEVERE, null, ex);
//        }
//        return n;
//    }
//
//    public Customer getCustomerById(int id) {
//        Customer customer = null;
//        String sql = """
//                    SELECT * FROM Customer WHERE id = ?""";
//        try {
//            PreparedStatement pre =connection.prepareStatement(sql);
//            pre.setInt(1, id);
//            ResultSet rs = pre.executeQuery();
//            if (rs.next()) {
//                String fullName = rs.getNString("full_name");
//                String email = rs.getString("email");
//                String phoneNumber = rs.getString("phone_number");
//                String address = rs.getString("address");
//                String role = rs.getString("role");
//                int status = rs.getInt("status");
//
//                customer = Customer.builder()
//                    .id(id)
//                    .fullName(fullName)
//                    .email(email)
//                    .phoneNumber(phoneNumber)
//                    .address(address)
//                    .role(role)
//                    .status(status)
//                    .build();
//            }
//
//        } catch (SQLException ex) {
//            Logger.getLogger(CustomerDAO.class.getName()).log(Level.SEVERE, null, ex);
//        }
//        return customer;
//
//    }
//
//    public int deleteCustomer(int id, String password) {
//        int n = 0;
//        String sql = "UPDATE Customer SET status = 0 WHERE id = ? AND password = ?";
//        try {
//            PreparedStatement pre =connection.prepareStatement(sql);
//            int index = 1;
//            pre.setInt(index++, id);
//            pre.setString(index++, password);
//            n = pre.executeUpdate();
//        } catch (SQLException ex) {
//            Logger.getLogger(CustomerDAO.class.getName()).log(Level.SEVERE, null, ex);
//        }
//        return n;
//    }
//
//    public int changePasswordCustomer(String oldPassword, String newPassword, int id) {
//        int n = 0;
//        String sql = """
//                     UPDATE customer SET password = ? WHERE id = ? AND password = ? AND status = 1 ;""";
//        try {
//            PreparedStatement pre =connection.prepareStatement(sql);
//            int index = 1;
//            pre.setString(index++, newPassword);
//            pre.setInt(index++, id);
//            pre.setString(index++, oldPassword);
//
//            n = pre.executeUpdate();
//        } catch (SQLException ex) {
//            Logger.getLogger(CustomerDAO.class.getName()).log(Level.SEVERE, null, ex);
//        }
//        return n;
//    }
//}
