/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.Timestamp;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.sql.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.LoginCounter;
import model.News;
import model.RoC;
import model.SellerRevenue;
import model.SellerTicketSale;
import model.TransLog;
import model.UserDetail;
import model.View;

/**
 *
 * @author Aus TUF GAMAING
 */
public class DAOforAdmin extends DBContext {

    public List<UserDetail> getAllUserByRole(String role) {
        List<UserDetail> users = new ArrayList<>();
        String sql = "select * from User\n"
                + " join " + role + " on User.id = " + role + ".user_id";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("user_id");
                String email = rs.getString("email");
                String password = rs.getString("password");
                String address = rs.getString("address");
                String phone_number = rs.getString("phone_number");
                String full_name = rs.getString("full_name");
                int status = rs.getInt("status");
                UserDetail user = new UserDetail(id, email, password, role, full_name, phone_number, address, status);
                users.add(user);
            }

        } catch (SQLException ex) {
            Logger.getLogger(DAOforAdmin.class.getName()).log(Level.SEVERE, null, ex);
        }

        return users;
    }

    public List<String> getAllEmail() {
        List<String> emails = new ArrayList<>();
        String sql = "Select email from user";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                String email = rs.getString("email");
                emails.add(email);
            }

        } catch (SQLException ex) {
            Logger.getLogger(DAOforAdmin.class.getName()).log(Level.SEVERE, null, ex);
        }

        return emails;
    }

    public UserDetail getChoosedUser(String role, int id) {
        UserDetail user = new UserDetail();
        String sql = "select * from User\n"
                + " join " + role + " on User.id = " + role + ".user_id"
                + " where user_id = " + id;
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                String fullName = rs.getString("full_name");
                String email = rs.getString("email");
                String password = rs.getString("password");
                String phoneNumber = rs.getString("phone_number");
                String address = rs.getString("address");
                int status = rs.getInt("status");

                user = new UserDetail(id, email, password, role, fullName, phoneNumber, address, status);
            }

        } catch (SQLException ex) {
            Logger.getLogger(DAOforAdmin.class.getName()).log(Level.SEVERE, null, ex);
        }

        return user;
    }

    public void changeStatus(int id, String role) {
        String sql = "UPDATE " + role + "\n"
                + "SET status = CASE WHEN status = 0 THEN 1 ELSE 0 END\n"
                + "WHERE user_id = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, id);
            pre.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(DAOforAdmin.class.getName()).log(Level.SEVERE, null, ex);
        }

        recordChange("Changed status of an account", 1, "admin");
    }

    public void editAcc(String fullname, String phonenumber, String address, String role, int id) {
        String sql = "UPDATE " + role + "\n"
                + "SET full_name = ?, phone_number = ?, address = ?\n"
                + "WHERE user_id = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, fullname);
            pre.setString(2, phonenumber);
            pre.setString(3, address);
            pre.setInt(4, id);

            pre.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(DAOforAdmin.class.getName()).log(Level.SEVERE, null, ex);
        }

        recordChange("Edited an account", 1, "admin");
    }

    public void addNewAcc(String fullname, String email, String phonenumber, String password, String role) {
        String sql;
        sql = "INSERT INTO user (email, password, role) VALUES (?, ?, ?)";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);

            pre.setString(1, email);
            pre.setString(2, password);
            pre.setString(3, role);
            pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOforAdmin.class.getName()).log(Level.SEVERE, null, ex);
        }

        sql = "select id from user where email = '" + email + "'";
        int id = 0;
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                id = rs.getInt("id");
            }

        } catch (SQLException ex) {
            Logger.getLogger(DAOforAdmin.class.getName()).log(Level.SEVERE, null, ex);
        }

        sql = "INSERT INTO " + role + " (user_id, phone_number, full_name, address, status) VALUES (?, ?, ?, ?, 1)";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);

            pre.setInt(1, id);
            pre.setString(2, phonenumber);
            pre.setString(3, fullname);
            pre.setString(4, "");
            pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOforAdmin.class.getName()).log(Level.SEVERE, null, ex);
        }

        recordChange("Added a new account", 1, "admin");
    }

    public UserDetail getUserDetail(int id, String role) {
        UserDetail user = new UserDetail();
        String sql = "select * from User\n"
                + " join " + role + " on User.id = " + role + ".user_id\n"
                + " where user_id = " + id;
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                String email = rs.getString("email");
                String password = rs.getString("password");
                String address = rs.getString("address");
                String phone_number = rs.getString("phone_number");
                String full_name = rs.getString("full_name");
                int status = rs.getInt("status");
                user = new UserDetail(id, email, password, role, full_name, phone_number, address, status);
            }

        } catch (SQLException ex) {
            Logger.getLogger(DAOforAdmin.class.getName()).log(Level.SEVERE, null, ex);
        }

        return user;
    }

    public void viewCounted() {
        String sql;
        sql = "INSERT INTO View (date) values (?)";
        LocalDateTime myDateObj = LocalDateTime.now();
        DateTimeFormatter myFormatObj = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

        String formattedDate = myDateObj.format(myFormatObj);
        try {
            PreparedStatement pre = connection.prepareStatement(sql);

            pre.setString(1, formattedDate);

            pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOforAdmin.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public List<View> getView(String duration) {
        List<View> views = new ArrayList<>();
        String sql = "select * from View";
        if (duration.equalsIgnoreCase("week")) {
            sql = "SELECT * FROM view\n"
                    + "WHERE date BETWEEN DATE_SUB(CURDATE(), INTERVAL 6 DAY) AND NOW()";
        }
        if (duration.equalsIgnoreCase("month")) {
            sql = "SELECT * FROM view\n"
                    + "WHERE date BETWEEN DATE_SUB(CURDATE(), INTERVAL 29 DAY) AND NOW()";
        }
        if (duration.equalsIgnoreCase("year")) {
            sql = "SELECT * FROM view\n"
                    + "WHERE date BETWEEN DATE_SUB(CURDATE(), INTERVAL 364 DAY) AND NOW()";
        }
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                Date date = rs.getDate("date");

                View v = new View(id, date);
                views.add(v);
            }

        } catch (SQLException ex) {
            Logger.getLogger(DAOforAdmin.class.getName()).log(Level.SEVERE, null, ex);
        }

        return views;
    }

    public void loginCounted(int id) {
        String sql;
        sql = "INSERT INTO Logincounter (date, user_id) values (?, ?)";
        LocalDateTime myDateObj = LocalDateTime.now();
        DateTimeFormatter myFormatObj = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        String formattedDate = myDateObj.format(myFormatObj);
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, formattedDate);
            pre.setInt(2, id);
            pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOforAdmin.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public List<LoginCounter> getLoginCounter(String duration) {
        List<LoginCounter> lcs = new ArrayList<>();
        String sql = "select * from Logincounter";

        if (duration.equalsIgnoreCase("week")) {
            sql = "select * from Logincounter\n"
                    + "WHERE date BETWEEN DATE_SUB(CURDATE(), INTERVAL 6 DAY) AND NOW()";
        }
        if (duration.equalsIgnoreCase("month")) {
            sql = "select * from Logincounter\n"
                    + "WHERE date BETWEEN DATE_SUB(CURDATE(), INTERVAL 29 DAY) AND NOW()";
        }
        if (duration.equalsIgnoreCase("year")) {
            sql = "select * from Logincounter\n"
                    + "WHERE date BETWEEN DATE_SUB(CURDATE(), INTERVAL 364 DAY) AND NOW()";
        }

        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                Date date = rs.getDate("date");
                int user_id = rs.getInt("user_id");
                LoginCounter lc = new LoginCounter(id, date, user_id);
                lcs.add(lc);
            }

        } catch (SQLException ex) {
            Logger.getLogger(DAOforAdmin.class.getName()).log(Level.SEVERE, null, ex);
        }

        return lcs;
    }

    public List<SellerRevenue> getSellerRevenue(String duration) {
        List<SellerRevenue> sr_list = new ArrayList<>();
        String sql = """
                     SELECT full_name, price, booking_date FROM ticket
                                          join seat on seat.id = ticket.seat_id
                                          join route on ticket.route_id = route.id
                                          join train on route.train_id = train.id
                                          join seller on seller.id = train.owner
                                          WHERE ticket.status != 0""";

        if (duration.equalsIgnoreCase("week")) {
            sql += " AND ticket.booking_date BETWEEN DATE_SUB(CURDATE(), INTERVAL 6 DAY) AND NOW()";
        }
        if (duration.equalsIgnoreCase("month")) {
            sql += " AND ticket.booking_date BETWEEN DATE_SUB(CURDATE(), INTERVAL 29 DAY) AND NOW()";
        }
        if (duration.equalsIgnoreCase("year")) {
            sql += " AND ticket.booking_date BETWEEN DATE_SUB(CURDATE(), INTERVAL 364 DAY) AND NOW()";
        }

        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                String name = rs.getString("full_name");
                Date date = rs.getDate("booking_date");
                double amount = rs.getDouble("price");
                SellerRevenue sr = new SellerRevenue(name, date, amount);
                sr_list.add(sr);
            }

        } catch (SQLException ex) {
            Logger.getLogger(DAOforAdmin.class.getName()).log(Level.SEVERE, null, ex);
        }

        return sr_list;
    }

    public List<SellerTicketSale> getSellerTicketSale(String duration) {
        List<SellerTicketSale> sts_list = new ArrayList<>();
        String sql = """
                     SELECT full_name, booking_date FROM ticket
                     join route on ticket.route_id = route.id
                     join train on route.train_id = train.id
                     join seller on seller.id = train.owner
                     WHERE ticket.status != 0""";

        if (duration.equalsIgnoreCase("week")) {
            sql += " AND ticket.booking_date BETWEEN DATE_SUB(CURDATE(), INTERVAL 6 DAY) AND NOW()";
        }
        if (duration.equalsIgnoreCase("month")) {
            sql += " AND ticket.booking_date BETWEEN DATE_SUB(CURDATE(), INTERVAL 29 DAY) AND NOW()";
        }
        if (duration.equalsIgnoreCase("year")) {
            sql += " AND ticket.booking_date BETWEEN DATE_SUB(CURDATE(), INTERVAL 364 DAY) AND NOW()";
        }

        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                String name = rs.getString("full_name");
                Date date = rs.getDate("booking_date");
                SellerTicketSale sts = new SellerTicketSale(name, date);
                sts_list.add(sts);
            }

        } catch (SQLException ex) {
            Logger.getLogger(DAOforAdmin.class.getName()).log(Level.SEVERE, null, ex);
        }

        return sts_list;
    }

    public List<TransLog> getTransactionLog() {
        List<TransLog> trans_list = new ArrayList<>();
        String sql = "SELECT * from transaction join customer on customer.id = customer_id";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                String fromPerson = rs.getString("full_name");
                Timestamp date = rs.getTimestamp("payment_date");
                int amount = rs.getInt("amount_paid");

                TransLog trans = new TransLog(1, fromPerson, "TraTra", date, amount);
                trans_list.add(trans);
            }

        } catch (SQLException ex) {
            Logger.getLogger(DAOforAdmin.class.getName()).log(Level.SEVERE, null, ex);
        }

        sql = """
              SELECT customer.full_name, staff.full_name, handle_time, amount_paid from refund
              join customer on customer.user_id = userId
              join staff on staff.user_id = staffId
              join ticket on ticket.id = ticketId
              join transaction on transaction.id = transaction_id
              where refund.status = 1""";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                String toPerson = rs.getString("customer.full_name");
                String fromPerson = rs.getString("staff.full_name");
                Timestamp date = rs.getTimestamp("handle_time");
                int amount = rs.getInt("amount_paid");

                TransLog trans = new TransLog(0, fromPerson, toPerson, date, amount);
                trans_list.add(trans);
            }

        } catch (SQLException ex) {
            Logger.getLogger(DAOforAdmin.class.getName()).log(Level.SEVERE, null, ex);
        }

        return trans_list;
    }

    public List<RoC> getRoC() {
        List<RoC> roc_list = new ArrayList<>();
        String sql = "SELECT * from recordofchange join user on user.id = user_id";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                String change = rs.getString("content");
                Timestamp date = rs.getTimestamp("created_at");
                int id = rs.getInt("user_id");
                String role = rs.getString("user_role");
                String name = getChoosedUserName(role, id);
                RoC roc = new RoC(name, role, change, date);
                roc_list.add(roc);
            }

        } catch (SQLException ex) {
            Logger.getLogger(DAOforAdmin.class.getName()).log(Level.SEVERE, null, ex);
        }

        return roc_list;
    }

    public String getChoosedUserName(String role, int id) {
        String name = null;
        String sql = "select * from User\n"
                + " join " + role + " on User.id = " + role + ".user_id"
                + " where user_id = " + id;
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                name = rs.getString("full_name");
            }

        } catch (SQLException ex) {
            Logger.getLogger(DAOforAdmin.class.getName()).log(Level.SEVERE, null, ex);
        }

        return name;
    }

    public void recordChange(String content, int id, String role) {
        String sql;
        sql = "INSERT INTO recordofchange (user_id, user_role, content) values (?, ?, ?)";

        try {
            PreparedStatement pre = connection.prepareStatement(sql);

            pre.setInt(1, id);
            pre.setString(2, role);
            pre.setString(3, content);

            pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOforAdmin.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void addNew(String content, String title, int status) {
        String sql;
        sql = "INSERT INTO news (title, content, status) values (?, ?, ?)";

        try {
            PreparedStatement pre = connection.prepareStatement(sql);

            pre.setString(1, title);
            pre.setString(2, content);
            pre.setInt(3, status);

            pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOforAdmin.class.getName()).log(Level.SEVERE, null, ex);
        }

        recordChange("Added a news", 1, "admin");
    }

    public void editNew(String content, String title, int id) {
        String sql;
        sql = "UPDATE news SET title = ?, content = ? WHERE id = ?";

        try {
            PreparedStatement pre = connection.prepareStatement(sql);

            pre.setString(1, title);
            pre.setString(2, content);

            pre.setInt(3, id);

            pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOforAdmin.class.getName()).log(Level.SEVERE, null, ex);
        }

        recordChange("Edited a news", 1, "admin");
    }

    public void changeStatusNew(int id) {
        String sql;
        sql = "UPDATE news SET status = CASE WHEN status = 0 THEN 1 ELSE 0 END WHERE id = ?";

        try {
            PreparedStatement pre = connection.prepareStatement(sql);

            pre.setInt(1, id);

            pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOforAdmin.class.getName()).log(Level.SEVERE, null, ex);
        }

        recordChange("Change status a news", 1, "admin");
    }

    public List<News> getAllNews() {
        List<News> newsList = new ArrayList<>();
        String sql = "SELECT id, title, content, created_at, status FROM news";
        try (PreparedStatement pre = connection.prepareStatement(sql); ResultSet rs = pre.executeQuery()) {

            while (rs.next()) {
                Timestamp createdAt = rs.getTimestamp("created_at");
                News news = News.builder()
                        .id(rs.getInt("id"))
                        .title(rs.getString("title"))
                        .content(rs.getString("content"))
                        .createdAt(createdAt)
                        .status(rs.getInt("status"))
                        .build();
                newsList.add(news);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOforAdmin.class.getName()).log(Level.SEVERE, null, ex);
        }
        return newsList;
    }

    public News getNewsById(int id) {
        String sql = "SELECT * FROM news WHERE id = ?";
        try (PreparedStatement pre = connection.prepareStatement(sql)) {
            pre.setInt(1, id);
            ResultSet rs = pre.executeQuery();
            if (rs.next()) {
                Timestamp createdAt = rs.getTimestamp("created_at");
                return News.builder()
                        .id(rs.getInt("id"))
                        .title(rs.getString("title"))
                        .content(rs.getString("content"))
                        .createdAt(createdAt)
                        .status(rs.getInt("status"))
                        .build();
            }
        } catch (SQLException ex) {

        }
        return null;
    }
}
