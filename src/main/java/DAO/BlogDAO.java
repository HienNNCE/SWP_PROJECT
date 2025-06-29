package DAO;

import DB.DBContext;
import Model.Blog;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class BlogDAO extends DBContext {

    public List<Blog> getAllBlogs() {
        List<Blog> list = new ArrayList<>();
        String sql = "SELECT * FROM Blogs ORDER BY published_at DESC";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                list.add(new Blog(
                        rs.getInt("id"),
                        rs.getString("title"),
                        rs.getString("summary"),
                        rs.getString("content"),
                        rs.getString("image"),
                        rs.getTimestamp("published_at").toLocalDateTime()
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public Blog getBlogById(int id) {
        String sql = "SELECT * FROM blogs WHERE id = ?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new Blog(
                            rs.getInt("id"),
                            rs.getString("title"),
                            rs.getString("summary"),
                            rs.getString("content"),
                            rs.getString("image"),
                            rs.getTimestamp("published_at").toLocalDateTime()
                    );
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
