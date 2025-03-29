/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.util.List;
import java.sql.*;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Transaction;

/**
 *
 * @author dtam6
 */
public class TransactionDAO extends DBContext {

    public List<Transaction> getTransactionByCustomerId(int customerID) {
        List<Transaction> transactions = new ArrayList<>();
        String sql = "SELECT * FROM Transaction WHERE customer_id = ?;";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, customerID);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                Transaction transaction = new Transaction(
                    rs.getInt("id"),
                    rs.getInt("customer_id"),
                    rs.getString("payment_method"),
                    rs.getInt("payment_status"),
                    rs.getDate("payment_date"),
                    rs.getInt("quantity"),
                    rs.getDouble("amount_paid"),
                    rs.getString("voucher_code"));
                transactions.add(transaction);
            }

        } catch (SQLException ex) {
//            Logger.getLogger(TransactionDAO.class
//                .getName()).log(Level.SEVERE, null, ex);
            System.err.println(ex.getMessage());
        }
        return transactions;
    }

    public static void main(String[] args) {
        TransactionDAO dao = new TransactionDAO();
        List<Transaction> list = dao.getTransactionByCustomerId(1);
        System.out.println(list);
    }

    public boolean createTransaction(int customerId, String paymentMethod, int quantity, double amountPaid, String voucherCode) {
        String sql = "INSERT INTO transaction (customer_id, payment_method, quantity, amount_paid, voucher_code) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, customerId);
            stmt.setString(2, paymentMethod);
            stmt.setInt(3, quantity);
            stmt.setDouble(4, amountPaid);
            stmt.setString(5, voucherCode);

            int rowsInserted = stmt.executeUpdate();
            return rowsInserted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public Transaction getLatestTransactionByCustomerId(int customerId) {
        String sql = "SELECT * FROM transaction WHERE customer_id = ? ORDER BY id DESC LIMIT 1";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, customerId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Transaction transaction = new Transaction();
                    transaction.setId(rs.getInt("id"));
                    transaction.setCustomerId(rs.getInt("customer_id"));
                    transaction.setPaymentMethod(rs.getString("payment_method"));
                    transaction.setPaymentStatus(rs.getInt("payment_status"));
                    transaction.setQuantity(rs.getInt("quantity"));
                    transaction.setAmountPaid(rs.getDouble("amount_paid"));
                    transaction.setVouchercode(rs.getString("voucher_code"));
                    transaction.setPaymentDate(rs.getTimestamp("payment_date"));

                    return transaction;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public int getTransactionCountByCustomerId(int customerID) {
        String sql = "SELECT COUNT(*) AS total FROM Transaction WHERE customer_id = ?";
        try (PreparedStatement pre = connection.prepareStatement(sql)) {
            pre.setInt(1, customerID);
            try (ResultSet rs = pre.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("total");
                }
            }
        } catch (SQLException ex) {
            System.err.println(ex.getMessage());
        }
        return 0;
    }

    public List<Transaction> getTransactionByCustomerIdPaged(int customerID, int page, int pageSize) {
        List<Transaction> transactions = new ArrayList<>();
        String sql = "SELECT * FROM Transaction WHERE customer_id = ? ORDER BY payment_date DESC LIMIT ?, ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            int offset = (page - 1) * pageSize;
            pre.setInt(1, customerID);
            pre.setInt(2, offset);
            pre.setInt(3, pageSize);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                Transaction transaction = new Transaction(
                    rs.getInt("id"),
                    rs.getInt("customer_id"),
                    rs.getString("payment_method"),
                    rs.getInt("payment_status"),
                    rs.getDate("payment_date"),
                    rs.getInt("quantity"),
                    rs.getDouble("amount_paid"),
                    rs.getString("voucher_code")
                );
                transactions.add(transaction);
            }
        } catch (SQLException ex) {
            System.err.println(ex.getMessage());
        }
        return transactions;
    }

    public List<Transaction> filterTransactionsPaged(int customerId, String paymentDate, Double minAmount, Double maxAmount, int page, int pageSize) {
        List<Transaction> transactions = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM Transaction WHERE customer_id = ?");
        if (paymentDate != null && !paymentDate.isEmpty()) {
            sql.append(" AND DATE(payment_date) = ?");
        }
        if (minAmount != null) {
            sql.append(" AND amount_paid >= ?");
        }
        if (maxAmount != null) {
            sql.append(" AND amount_paid <= ?");
        }
        sql.append(" ORDER BY payment_date DESC LIMIT ?, ?");

        try (PreparedStatement pre = connection.prepareStatement(sql.toString())) {
            int paramIndex = 1;
            pre.setInt(paramIndex++, customerId);
            if (paymentDate != null && !paymentDate.isEmpty()) {
                pre.setString(paramIndex++, paymentDate);
            }
            if (minAmount != null) {
                pre.setDouble(paramIndex++, minAmount);
            }
            if (maxAmount != null) {
                pre.setDouble(paramIndex++, maxAmount);
            }
            int offset = (page - 1) * pageSize;
            pre.setInt(paramIndex++, offset);
            pre.setInt(paramIndex, pageSize);

            try (ResultSet rs = pre.executeQuery()) {
                while (rs.next()) {
                    Transaction transaction = new Transaction(
                        rs.getInt("id"),
                        rs.getInt("customer_id"),
                        rs.getString("payment_method"),
                        rs.getInt("payment_status"),
                        rs.getTimestamp("payment_date"),
                        rs.getInt("quantity"),
                        rs.getDouble("amount_paid"),
                        rs.getString("voucher_code")
                    );
                    transactions.add(transaction);
                }
            }
        } catch (SQLException ex) {
            System.err.println("Error filtering transactions: " + ex.getMessage());
        }
        return transactions;
    }

    public int countFilteredTransactions(int customerId, String paymentDate, Double minAmount, Double maxAmount) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) AS total FROM Transaction WHERE customer_id = ?");
        if (paymentDate != null && !paymentDate.isEmpty()) {
            sql.append(" AND DATE(payment_date) = ?");
        }
        if (minAmount != null) {
            sql.append(" AND amount_paid >= ?");
        }
        if (maxAmount != null) {
            sql.append(" AND amount_paid <= ?");
        }

        try (PreparedStatement pre = connection.prepareStatement(sql.toString())) {
            int paramIndex = 1;
            pre.setInt(paramIndex++, customerId);
            if (paymentDate != null && !paymentDate.isEmpty()) {
                pre.setString(paramIndex++, paymentDate);
            }
            if (minAmount != null) {
                pre.setDouble(paramIndex++, minAmount);
            }
            if (maxAmount != null) {
                pre.setDouble(paramIndex++, maxAmount);
            }

            try (ResultSet rs = pre.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("total");
                }
            }
        } catch (SQLException ex) {
            System.err.println("Error counting filtered transactions: " + ex.getMessage());
        }
        return 0;
    }

}
