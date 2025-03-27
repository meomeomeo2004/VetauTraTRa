/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import model.User;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Admin;
import model.Customer;
import model.Manager;
import model.Seller;
import model.Staff;

/**
 *
 * @author HP
 */
public class UserDAO extends DBContext {

    public boolean checkEmailExist(String email) {
        String sql = "SELECT * FROM User WHERE email = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

     public User getUserById(int id) {
    String sql = "SELECT * FROM User WHERE id = ?";
    try (PreparedStatement stmt = connection.prepareStatement(sql)) {
        stmt.setInt(1, id);
        try (ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return new User(
                        rs.getInt("id"),
                        rs.getString("email"),
                        rs.getString("password"),
                        rs.getString("role")
                );
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return null;
}

    public User Login(String email,String password){

        String sql = "Select * from User where email = ? and password = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, email);
            pre.setString(2, password);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                return new User(rs.getInt(1),
                    rs.getString(2),
                    rs.getString(3),
                    rs.getString(4));
            }
        } catch (Exception e) {
        }
        return null;
    }

    public int insertUser(User user) {
        String sql = "INSERT INTO User (email, password, role) VALUES (?, ?, ?)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
            ps.setString(1, user.getEmail());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getRole());
            int affectedRows = ps.executeUpdate();
            if (affectedRows > 0) {
                ResultSet generatedKeys = ps.getGeneratedKeys();
                if (generatedKeys.next()) {
                    return generatedKeys.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

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

    public Manager getManagerById(int user_id) {
        Manager manager = null;
        String sql = """
                    SELECT *from Manager
                        WHERE user_id = ?""";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, user_id);
            ResultSet rs = pre.executeQuery();
            if (rs.next()) {
                manager = Manager.builder()
                    .id(rs.getInt("id"))
                    .address(rs.getString("address"))
                    .phoneNumber(rs.getString("phone_number"))
                    .fullName(rs.getString("full_name"))
                    .status(rs.getInt("status"))
                    .build();
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return manager;
    }

    public Seller getSellerById(int user_id) {
        Seller seller = null;
        String sql = """
                SELECT * FROM Seller
                WHERE user_id = ?""";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, user_id);
            ResultSet rs = pre.executeQuery();
            if (rs.next()) {
                seller = Seller.builder()
                    .id(rs.getInt("id"))
                    .user_id(rs.getInt("user_id"))
                    .phoneNumber(rs.getString("phone_number"))
                    .fullName(rs.getString("full_name"))
                    .address(rs.getString("address"))
                    .status(rs.getInt("status"))
                    .build();
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return seller;
    }

    public Staff getStaffById(int user_id) {
        Staff staff = null;
        String sql = """
                SELECT * FROM Staff
                WHERE user_id = ?""";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, user_id);
            ResultSet rs = pre.executeQuery();
            if (rs.next()) {
                staff = Staff.builder()
                    .id(rs.getInt("id"))
                    .user_id(rs.getInt("user_id"))
                    .phoneNumber(rs.getString("phone_number"))
                    .fullName(rs.getString("full_name"))
                    .address(rs.getString("address"))
                    .status(rs.getInt("status"))
                    .build();
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return staff;
    }

    public Admin getAdminById(int user_id) {
        Admin admin = null;
        String sql = """
                SELECT * FROM Admin
                WHERE user_id = ?""";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, user_id);
            ResultSet rs = pre.executeQuery();
            if (rs.next()) {
                admin = Admin.builder()
                    .id(rs.getInt("id"))
                    .user_id(rs.getInt("user_id"))
                    .phoneNumber(rs.getString("phone_number"))
                    .fullname(rs.getString("full_name"))
                    .build();
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return admin;
    }

    public int updateStaffProfile(String phone, String fullname, String address, int uid) {
        int n = 0;
        String sql = """
            UPDATE Staff c
            JOIN User u ON  c.user_id = u.id
            SET
                c.phone_number = ?,
                c.full_name = ?,
                c.address = ?
            WHERE c.user_id = ?;
        """;
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, phone);
            pre.setString(2, fullname);
            pre.setString(3, address);
            pre.setInt(4, uid);
            n = pre.executeUpdate();
        } catch (Exception e) {
        }
        return n;
    }

    public int updateManagerProfile(String phone, String fullname, String address, int uid) {
        int n = 0;
        String sql = """
            UPDATE Manager c
            JOIN User u ON  c.user_id = u.id
            SET
                c.phone_number = ?,
                c.full_name = ?,
                c.address = ?
            WHERE c.user_id = ?;
        """;
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, phone);
            pre.setString(2, fullname);
            pre.setString(3, address);
            pre.setInt(4, uid);
            n = pre.executeUpdate();
        } catch (Exception e) {
        }
        return n;
    }

    public int updateSellerProfile(String phone, String fullname, String address, int uid) {
        int n = 0;
        String sql = """
            UPDATE Seller c
            JOIN User u ON  c.user_id = u.id
            SET
                c.phone_number = ?,
                c.full_name = ?,
                c.address = ?
            WHERE c.user_id = ?;
        """;
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, phone);
            pre.setString(2, fullname);
            pre.setString(3, address);
            pre.setInt(4, uid);
            n = pre.executeUpdate();
        } catch (Exception e) {
        }
        return n;
    }

    public int updateAdminProfile(String phone, String fullname, int uid) {
        int n = 0;
        String sql = """
        UPDATE Admin
        SET phone_number = ?,
            full_name = ?
        WHERE user_id = ?;
    """;
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, phone);
            pre.setString(2, fullname);
            pre.setInt(3, uid);
            n = pre.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return n;
    }

    public int updateProfileAdminById(Admin admin) {
        int n = 0;
        String sql = """
            UPDATE Admin
            SET phone_number = ?, full_name = ?
            WHERE user_id = ?;
                    """;
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, admin.getPhoneNumber());
            pre.setString(2, admin.getFullname());
            pre.setInt(3, admin.getUser_id());
            n = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }

    public int changePasswordUser(String oldPassword, String newPassword, int id) {
        int n = 0;
        String sql = "UPDATE User u"
            + "SET u.password = ? WHERE u.id = ? AND u.password = ? AND u.status = 1";
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

    public boolean checkOldPassword(int userId, String oldPassword) {
        String sql = "SELECT password FROM User WHERE id = ?";
        try (PreparedStatement pre = connection.prepareStatement(sql)) {
            pre.setInt(1, userId);
            ResultSet rs = pre.executeQuery();
            if (rs.next()) {
                return rs.getString("password").equals(oldPassword);
            }
        } catch (SQLException ex) {
            Logger.getLogger(CustomerDAO.class.getName()).log(Level.SEVERE, "Error checking old password", ex);
        }
        return false;
    }

    public boolean changePasswordUser(int userId, String newPassword) {
        String updatePasswordSQL = "UPDATE User SET password = ? WHERE id = ?";
        boolean success = false;

        try {
            connection.setAutoCommit(false);

            try (PreparedStatement updateStmt = connection.prepareStatement(updatePasswordSQL)) {
                updateStmt.setString(1, newPassword);
                updateStmt.setInt(2, userId);
                int rowsUpdated = updateStmt.executeUpdate();
                success = rowsUpdated > 0;
            }

            if (success) {
                connection.commit();
            } else {
                connection.rollback();
            }

        } catch (SQLException ex) {
            try {
                connection.rollback();
            } catch (SQLException rollbackEx) {
                Logger.getLogger(CustomerDAO.class.getName()).log(Level.SEVERE, "Rollback failed!", rollbackEx);
            }
            Logger.getLogger(CustomerDAO.class.getName()).log(Level.SEVERE, "Error updating password", ex);
        } finally {
            try {
                connection.setAutoCommit(true); // Reset auto-commit
            } catch (SQLException e) {
                Logger.getLogger(CustomerDAO.class.getName()).log(Level.SEVERE, "Failed to reset auto-commit", e);
            }
        }
        return success;
    }
}
