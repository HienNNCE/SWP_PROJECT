package DAO;

import DB.DBContext;
import Model.Part;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PartDAO {

    public List<Part> getAllParts() {
        List<Part> parts = new ArrayList<>();
        String sql = "SELECT * FROM Part";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                parts.add(mapRowToPart(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return parts;
    }

    public Part getPartById(int id) {
        String sql = "SELECT * FROM Part WHERE part_id = ?";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return mapRowToPart(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void createPart(Part part) {
        String sql = "INSERT INTO Part (part_name, part_brand, car_model, description, part_img, part_stock, part_price) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            setPartParams(stmt, part);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updatePart(Part part) {
        String sql = "UPDATE Part SET part_name = ?, part_brand = ?, car_model = ?, description = ?, part_img = ?, part_stock = ?, part_price = ? WHERE part_id = ?";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            setPartParams(stmt, part);
            stmt.setInt(8, part.getPartId());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deletePart(int id) {
        String sql = "DELETE FROM Part WHERE part_id = ?";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Part> searchPartsByName(String keyword) {
        List<Part> parts = new ArrayList<>();
        String sql = "SELECT * FROM Part WHERE LOWER(part_name) LIKE LOWER(?)";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, "%" + keyword + "%");
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                parts.add(mapRowToPart(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return parts;
    }

    public List<Part> filterParts(String brand, String carModel, Double priceFrom, Double priceTo, Integer stockFrom, Integer stockTo, String sort) {
        List<Part> parts = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM Part WHERE 1=1");
        List<Object> params = new ArrayList<>();

        if (brand != null && !brand.isEmpty()) {
            sql.append(" AND part_brand = ?");
            params.add(brand);
        }
        if (carModel != null && !carModel.isEmpty()) {
            sql.append(" AND LOWER(car_model) LIKE LOWER(?)");
            params.add("%" + carModel + "%");
        }
        if (priceFrom != null) {
            sql.append(" AND part_price >= ?");
            params.add(priceFrom);
        }
        if (priceTo != null) {
            sql.append(" AND part_price <= ?");
            params.add(priceTo);
        }
        if (stockFrom != null) {
            sql.append(" AND part_stock >= ?");
            params.add(stockFrom);
        }
        if (stockTo != null) {
            sql.append(" AND part_stock <= ?");
            params.add(stockTo);
        }

        if ("asc".equalsIgnoreCase(sort)) {
            sql.append(" ORDER BY part_price ASC");
        } else if ("desc".equalsIgnoreCase(sort)) {
            sql.append(" ORDER BY part_price DESC");
        }

        try (Connection conn = new DBContext().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                parts.add(mapRowToPart(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return parts;
    }

    public List<String> getAllBrands() {
        List<String> brands = new ArrayList<>();
        String sql = "SELECT DISTINCT part_brand FROM Part WHERE part_brand IS NOT NULL AND part_brand <> ''";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                brands.add(rs.getString("part_brand"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return brands;
    }

    public List<String> getAllCarModels() {
        List<String> models = new ArrayList<>();
        String sql = "SELECT DISTINCT car_model FROM Part WHERE car_model IS NOT NULL AND car_model <> ''";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                models.add(rs.getString("car_model"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return models;
    }

    public List<Part> getPartsByBrand(String brand) {
        List<Part> parts = new ArrayList<>();
        String sql = "SELECT * FROM Part WHERE part_brand = ?";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, brand);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                parts.add(mapRowToPart(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return parts;
    }

    public List<Part> getRelatedParts(String brand, int excludePartId) {
        List<Part> parts = new ArrayList<>();
        String sql = "SELECT * FROM Part WHERE part_brand = ? AND part_id != ?";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, brand);
            stmt.setInt(2, excludePartId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                parts.add(mapRowToPart(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return parts;
    }

    private Part mapRowToPart(ResultSet rs) throws SQLException {
        Part part = new Part();
        part.setPartId(rs.getInt("part_id"));
        part.setPartName(rs.getString("part_name"));
        part.setPartBrand(rs.getString("part_brand"));
        part.setCarModel(rs.getString("car_model"));
        part.setDescription(rs.getString("description"));
        part.setPartImg(rs.getString("part_img"));
        part.setPartStock(rs.getInt("part_stock"));
        part.setPartPrice(rs.getBigDecimal("part_price"));
        return part;
    }

    private void setPartParams(PreparedStatement stmt, Part part) throws SQLException {
        stmt.setString(1, part.getPartName());
        stmt.setString(2, part.getPartBrand());
        stmt.setString(3, part.getCarModel());
        stmt.setString(4, part.getDescription());
        stmt.setString(5, part.getPartImg());
        stmt.setInt(6, part.getPartStock());
        stmt.setBigDecimal(7, part.getPartPrice());
    }
}
