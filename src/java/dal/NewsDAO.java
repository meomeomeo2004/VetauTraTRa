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
        String sql = "SELECT id, title, content, created_at, status FROM news where status = 1";
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

    public List<News> filterNews(String title, String createdAt, int page, int pageSize) {
        List<News> newsList = new ArrayList<>();
        String sql = "SELECT id, title, content, created_at, status FROM news WHERE status = 1";

        if (title != null && !title.trim().isEmpty()) {
            sql += " AND LOWER(title) LIKE ?";
        }
        if (createdAt != null && !createdAt.trim().isEmpty()) {
            sql += " AND CAST(created_at AS DATE) = ?";
        }
        sql += " ORDER BY created_at DESC LIMIT ?, ?";

        try (PreparedStatement pre = connection.prepareStatement(sql)) {
            int paramIndex = 1;
            if (title != null && !title.trim().isEmpty()) {
                pre.setString(paramIndex++, "%" + title.toLowerCase() + "%");
            }
            if (createdAt != null && !createdAt.trim().isEmpty()) {
                pre.setString(paramIndex++, createdAt);
            }
            int offset = (page - 1) * pageSize;
            pre.setInt(paramIndex++, offset);
            pre.setInt(paramIndex, pageSize);

            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                Timestamp createdAtTimestamp = rs.getTimestamp("created_at");
                News news = News.builder()
                    .id(rs.getInt("id"))
                    .title(rs.getString("title"))
                    .content(rs.getString("content"))
                    .createdAt(createdAtTimestamp)
                    .status(rs.getInt("status"))
                    .build();
                newsList.add(news);
            }
        } catch (SQLException ex) {
            Logger.getLogger(NewsDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return newsList;
    }

    public int getFilteredNewsCount(String title, String createdAt) {
        String sql = "SELECT COUNT(*) AS total FROM news WHERE status = 1";

        if (title != null && !title.trim().isEmpty()) {
            sql += " AND LOWER(title) LIKE ?";
        }
        if (createdAt != null && !createdAt.trim().isEmpty()) {
            sql += " AND CAST(created_at AS DATE) = ?";
        }

        try (PreparedStatement pre = connection.prepareStatement(sql)) {
            int paramIndex = 1;
            if (title != null && !title.trim().isEmpty()) {
                pre.setString(paramIndex++, "%" + title.toLowerCase() + "%");
            }
            if (createdAt != null && !createdAt.trim().isEmpty()) {
                pre.setString(paramIndex, createdAt);
            }

            ResultSet rs = pre.executeQuery();
            if (rs.next()) {
                return rs.getInt("total");
            }
        } catch (SQLException ex) {
            Logger.getLogger(NewsDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

}
