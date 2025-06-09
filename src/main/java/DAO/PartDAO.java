/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;
import DB.DBContext;
import Model.Part;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class PartDAO extends DBContext {
    
    public static void main(String[] a) {
        PartDAO cDAO = new PartDAO();
        ArrayList<Part> parts = cDAO.getAllPart();
        for (Part part : parts) {
            System.out.println(part.getPartId()+" "+ part.getPartName());
        }
    }

    public ArrayList<Part> getAllPart() {
        ArrayList<Part> parts = new ArrayList<>();
        String sql = "SELECT part_id, part_name, part_brand, car_model, description, part_img, part_stock, part_price FROM Part";

        try {
            Connection conn = getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Part p = new Part(
                    rs.getInt("part_id"),
                    rs.getString("part_name"),
                    rs.getString("part_brand"),
                    rs.getString("car_model"),
                    rs.getString("description"),
                    rs.getString("part_img"),
                    rs.getInt("part_stock"),
                    rs.getBigDecimal("part_price")
                );
                parts.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return parts;
    }
}
