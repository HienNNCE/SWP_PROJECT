/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import Model.Car;
import DB.DBContext;

/**
 *
 * @author thien
 */
public class CarDAO extends DBContext {

    public static void main(String[] a) {
        CarDAO cDAO = new CarDAO();
        ArrayList<Car> cars = cDAO.getAllCars();
        for (Car car : cars) {
            System.out.println(car.getCarId() + car.getCarName() + car.getCarBrand());
        }
    }

    public ArrayList<Car> getAllCars() {
        ArrayList<Car> cars = new ArrayList<>();
        String query = "SELECT * FROM Car";
        try {
             PreparedStatement ps = this.getConnection().prepareStatement(query); 
             ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                cars.add(new Car(
                        rs.getInt("car_id"),
                        rs.getString("car_name"),
                        rs.getString("car_brand"),
                        rs.getString("model"),
                        rs.getBigDecimal("car_price"),
                        rs.getDate("car_year"),
                        rs.getString("car_img"),
                        rs.getInt("car_stock"),
                        rs.getBigDecimal("car_odo"),
                        rs.getString("fuel_type"),
                        rs.getBigDecimal("displacement"),
                        rs.getInt("category_id")
                ));
            }
        } catch (SQLException ex) {
            Logger.getLogger(CarDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return cars;
    }
    
    public ArrayList<Car> getRandomCars(int limit) {
        ArrayList<Car> cars = new ArrayList<>();
        String query = "SELECT TOP (?) * FROM Car ORDER BY NEWID()";
        try {
            PreparedStatement ps = this.getConnection().prepareStatement(query);
            ps.setInt(1, limit);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                cars.add(new Car(
                        rs.getInt("car_id"),
                        rs.getString("car_name"),
                        rs.getString("car_brand"),
                        rs.getString("model"),
                        rs.getBigDecimal("car_price"),
                        rs.getDate("car_year"),
                        rs.getString("car_img"),
                        rs.getInt("car_stock"),
                        rs.getBigDecimal("car_odo"),
                        rs.getString("fuel_type"),
                        rs.getBigDecimal("displacement"),
                        rs.getInt("category_id")
                ));
            }
        } catch (SQLException ex) {
            Logger.getLogger(CarDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return cars;
    }

    public byte[] getCarImageById(int carId) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    public Car getCarById(int carId) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    public int getTotalCarCount() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
}
