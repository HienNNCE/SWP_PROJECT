package DAO;

import DB.DBContext;
import Model.Blog;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class BlogDAO {

    private Blog mapRowToBlog(ResultSet rs) throws SQLException {
        return new Blog(
                rs.getInt("id"),
                rs.getString("title"),
                rs.getString("summary"),
                rs.getString("content"),
                rs.getString("image"),
                rs.getTimestamp("published_at").toLocalDateTime()
        );
    }

    // 1. Lấy tất cả blogs (mới nhất đầu tiên)
    public List<Blog> getAllBlogs() {
        List<Blog> list = new ArrayList<>();
        String sql = "SELECT * FROM Blogs ORDER BY published_at ASC";
        try (Connection conn = new DBContext().getConnection(); PreparedStatement stmt = conn.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                list.add(mapRowToBlog(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // 2. Lấy theo ID
    public Blog getBlogById(int id) {
        String sql = "SELECT * FROM Blogs WHERE id = ?";
        try (Connection conn = new DBContext().getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return mapRowToBlog(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // 3. Tạo mới
    public void create(Blog blog) {
        String sql = "INSERT INTO Blogs (title, summary, content, image, published_at) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = new DBContext().getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, blog.getTitle());
            stmt.setString(2, blog.getSummary());
            stmt.setString(3, blog.getContent());
            stmt.setString(4, blog.getImage());
            stmt.setTimestamp(5, Timestamp.valueOf(blog.getPublishedAt()));
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // 4. Cập nhật
    public void update(Blog blog) {
        String sql = "UPDATE Blogs SET title = ?, summary = ?, content = ?, image = ?, published_at = ? WHERE id = ?";
        try (Connection conn = new DBContext().getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, blog.getTitle());
            stmt.setString(2, blog.getSummary());
            stmt.setString(3, blog.getContent());
            stmt.setString(4, blog.getImage());
            stmt.setTimestamp(5, Timestamp.valueOf(blog.getPublishedAt()));
            stmt.setInt(6, blog.getId());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // 5. Xoá
    public void delete(int id) {
        String sql = "DELETE FROM Blogs WHERE id = ?";
        try (Connection conn = new DBContext().getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // 6. Tìm kiếm theo tiêu đề
    public List<Blog> searchByTitle(String keyword) {
        List<Blog> list = new ArrayList<>();
        String sql = "SELECT * FROM Blogs WHERE LOWER(title) LIKE LOWER(?) ORDER BY published_at DESC";
        try (Connection conn = new DBContext().getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, "%" + keyword + "%");
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                list.add(mapRowToBlog(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // 7. Lọc + sắp xếp (theo ngày đăng)
    public List<Blog> filterAndSort(String titleKeyword, String sort) {
        List<Blog> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM Blogs WHERE 1=1");

        List<Object> params = new ArrayList<>();

        if (titleKeyword != null && !titleKeyword.trim().isEmpty()) {
            sql.append(" AND LOWER(title) LIKE LOWER(?)");
            params.add("%" + titleKeyword.trim() + "%");
        }

        if ("asc".equalsIgnoreCase(sort)) {
            sql.append(" ORDER BY published_at ASC");
        } else {
            sql.append(" ORDER BY published_at DESC");
        }

        try (Connection conn = new DBContext().getConnection(); PreparedStatement stmt = conn.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                list.add(mapRowToBlog(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    public List<Blog> getLatestBlogsExcludeId(int excludeId, int limit) {
        List<Blog> list = new ArrayList<>();
        String sql = "SELECT TOP (?) * FROM Blogs WHERE id != ? ORDER BY published_at DESC";
        try (Connection con = new DBContext().getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, limit);  // Ví dụ: limit = 3
            ps.setInt(2, excludeId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Blog blog = new Blog(
                        rs.getInt("id"),
                        rs.getString("title"),
                        rs.getString("summary"),
                        rs.getString("content"),
                        rs.getString("image"),
                        rs.getTimestamp("published_at").toLocalDateTime()
                );
                list.add(blog);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
