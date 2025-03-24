package dal;

import java.sql.*;

import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.News;

public class NewsDAO extends DBContext {

    public void markAllAsRead() {
        String sql = "UPDATE news SET status = 1";
        try (PreparedStatement pre = connection.prepareStatement(sql)) {
            pre.executeUpdate();
        } catch (SQLException ex) {
        }
    }

    public void markAsRead(int id) {
        String sql = "UPDATE news SET status = 1 WHERE id = ?";
        try (PreparedStatement pre = connection.prepareStatement(sql)) {
            pre.setInt(1, id);
            pre.executeUpdate();
        } catch (SQLException ex) {
        }
    }

    public List<News> getUnreadNews() {
        List<News> newsList = new ArrayList<>();
        String sql = "SELECT * FROM news WHERE status = 0";
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
        }
        return newsList;
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
            Logger.getLogger(NewsDAO.class.getName()).log(Level.SEVERE, null, ex);
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

    public static void main(String[] args) {
        NewsDAO dao = new NewsDAO();
        System.out.println(dao.getAllNews());
    }
}
