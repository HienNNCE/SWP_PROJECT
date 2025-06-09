/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DB.DBContext;
import Model.Service;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author thien
 */
public class ServiceDAO extends DBContext {

    public List<Service> getAllRepairService() {
        List<Service> list = new ArrayList<>();
        String sql = "SELECT * FROM RepairService";

        try (PreparedStatement ps = this.getConnection().prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Service rsObj = new Service();
                // set fields...
                list.add(rsObj);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }
}
