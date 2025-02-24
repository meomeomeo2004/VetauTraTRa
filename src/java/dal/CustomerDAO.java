/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import model.Customer;
import java.util.ArrayList;
import java.util.List;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author dtam6
 */
public class CustomerDAO extends DBContext {

//    public static void main(String[] args) {
//        CustomerDAO customerDAO = new CustomerDAO();
//        Customer customer = Customer.builder()
//            .id(5)
//            .fullName("Customer").email("customer@email.com").phoneNumber("0123456789").address("hanoi, vietnam")
//            .build();
//        System.out.println(customerDAO.updateProfileCustomer(customer));
//    }

    public boolean checkPhoneNumberExist(String phoneNumber) {
        String sql = "SELECT * FROM Customer WHERE phone_number = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, phoneNumber);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
public boolean insertCustomer(Customer customer) {
        String sql = "INSERT INTO Customer (user_id, full_name, phone_number, address, status) VALUES (?, ?, ?, ?, ?)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, customer.getUser_id());
            ps.setString(2, customer.getFullName());
            ps.setString(3, customer.getPhoneNumber());
            ps.setString(4, customer.getAddress());
            ps.setInt(5, customer.getStatus());
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Cập nhật thông tin khách hàng: chỉ cập nhật các trường trong bảng Customer
    public int updateProfileCustomer(Customer customer) {
        int result = 0;
        String sql = "UPDATE Customer SET full_name = ?, phone_number = ?, address = ? WHERE id = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, customer.getFullName());
            pre.setString(2, customer.getPhoneNumber());
            pre.setString(3, customer.getAddress());
            pre.setInt(4, customer.getId());
            result = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(CustomerDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return result;
    }

    // Lấy thông tin khách hàng theo id từ bảng Customer
    public Customer getCustomerById(int customerId) {
        Customer customer = null;
        String sql = "SELECT * FROM Customer WHERE id = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, customerId);
            ResultSet rs = pre.executeQuery();
            if (rs.next()) {
                int user_id = rs.getInt("user_id");
                String fullName = rs.getString("full_name");
                String phoneNumber = rs.getString("phone_number");
                String address = rs.getString("address");
                int status = rs.getInt("status");
                customer = Customer.builder()
                    .id(customerId)
                    .user_id(user_id)
                    .fullName(fullName)
                    .phoneNumber(phoneNumber)
                    .address(address)
                    .status(status)
                    .build();
            }
        } catch (SQLException ex) {
            Logger.getLogger(CustomerDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return customer;
    }

    // Xóa khách hàng: cập nhật trạng thái của khách hàng thành 0 nếu password khớp trong bảng User
    public int deleteCustomer(int customerId, String password) {
        int n = 0;
        String sql = "UPDATE Customer c JOIN User u ON c.user_id = u.id "
            + "SET c.status = 0 WHERE c.id = ? AND u.password = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, customerId);
            pre.setString(2, password);
            n = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(CustomerDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }

    // Đổi mật khẩu: cập nhật password trong bảng User thông qua join với bảng Customer
    public int changePasswordCustomer(String oldPassword, String newPassword, int id) {
        int n = 0;
        String sql = "UPDATE User u JOIN Customer c ON c.user_id = u.id "
            + "SET u.password = ? WHERE c.id = ? AND u.password = ? AND c.status = 1";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, newPassword);
            pre.setInt(2, id);
            pre.setString(3, oldPassword);
            n = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(CustomerDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }
}