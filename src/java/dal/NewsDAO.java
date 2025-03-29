package dal;

import java.sql.*;

import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.News;

public class NewsDAO extends DBContext {

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

    public List<News> getNewsPaged(int page, int pageSize) {
        List<News> newsList = new ArrayList<>();
        String sql = "SELECT id, title, content, created_at, status FROM news ORDER BY created_at DESC LIMIT ?, ?";
        try (PreparedStatement pre = connection.prepareStatement(sql)) {
            int offset = (page - 1) * pageSize;
            pre.setInt(1, offset);
            pre.setInt(2, pageSize);
            ResultSet rs = pre.executeQuery();
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

    public int getTotalNewsCount() {
        String sql = "SELECT COUNT(*) AS total FROM news";
        try (PreparedStatement pre = connection.prepareStatement(sql); ResultSet rs = pre.executeQuery()) {
            if (rs.next()) {
                return rs.getInt("total");
            }
        } catch (SQLException ex) {
            Logger.getLogger(NewsDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

}
