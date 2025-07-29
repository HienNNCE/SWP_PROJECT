/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DB.DBContext;
import Model.Comment;
import Model.Part;
import Model.Users;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author daoducdanh
 */
public class CommentDAO extends DBContext {

    public void createComment(Comment comment) {
        String query = "INSERT INTO [Comment] (user_id, comment_text, part_id, rating, status, date) "
                + "VALUES (?, ?, ?, ?, ?, ?)";
        Connection conn = this.getConnection();
        try (PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, comment.getUser().getUserId());
            ps.setString(2, comment.getCommentText());
            ps.setInt(3, comment.getPart().getPartId());
            ps.setInt(4, comment.getRating());
            ps.setString(5, "Active");

            java.sql.Date sqlDate = new java.sql.Date(System.currentTimeMillis());
            ps.setDate(6, sqlDate);

            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void updateCommentStatus(int commentId) {
        String query = "UPDATE [Comment] SET status = CASE WHEN status = 'Active' THEN 'Banned' ELSE 'Active' END WHERE comment_id = ?";
        Connection conn = this.getConnection();
        try (PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, commentId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<Comment> getCommentsByPartId(int partId) {
        List<Comment> comments = new ArrayList<>();
        String query = "SELECT comment_id, user_id, comment_text, part_id, rating, status, date "
                + "FROM [Comment] WHERE part_id = ? AND status = 'Active' "
                + "ORDER BY date DESC";

        Connection conn = this.getConnection(); try (PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, partId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Comment cmt = new Comment();
                    cmt.setCommentId(rs.getInt("comment_id"));
                    cmt.setUser(new Users(rs.getInt("user_id")));
                    cmt.setCommentText(rs.getString("comment_text"));
                    cmt.setPart(new Part(rs.getInt("part_id")));
                    cmt.setRating(rs.getInt("rating"));
                    cmt.setStatus(rs.getString("status"));
                    cmt.setDate(rs.getDate("date").toLocalDate());

                    comments.add(cmt);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return comments;
    }

    public boolean hasUserPurchasedPart(int userId, int partId) {
        String query = " SELECT 1 FROM [Order] o JOIN [OrderDetail] od ON o.order_id = od.order_id WHERE o.user_id = ? AND od.part_id = ?";

        Connection conn = this.getConnection();
        try (PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, userId);
            ps.setInt(2, partId);

            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public List<Comment> getAllComments(int offset, int limit) {
        List<Comment> comments = new ArrayList<>();
        String sql = "SELECT * FROM Comment ORDER BY date DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        Connection conn = getConnection(); try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, offset);
            ps.setInt(2, limit);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Comment comment = new Comment();
                comment.setCommentId(rs.getInt("comment_id"));
                comment.setUser(new Users(rs.getInt("user_id")));
                comment.setPart(new Part(rs.getInt("part_id")));
                comment.setCommentText(rs.getString("comment_text"));
                comment.setRating(rs.getInt("rating"));
                comment.setStatus(rs.getString("status"));
                comment.setDate(rs.getDate("date").toLocalDate());
                comments.add(comment);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return comments;
    }

    public int countAllComments() {
        String sql = "SELECT COUNT(*) FROM Comment";
        Connection conn = getConnection(); try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
}
