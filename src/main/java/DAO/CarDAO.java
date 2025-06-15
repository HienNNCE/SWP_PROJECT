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
import java.math.BigDecimal;
import java.sql.Date;

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
        // Phương thức này sẽ được triển khai sau khi có cấu trúc lưu trữ hình ảnh
        throw new UnsupportedOperationException("Not supported yet.");
    }

    public Car getCarById(int carId) {
        String query = "SELECT * FROM Car WHERE car_id = ?";
        try {
            PreparedStatement ps = this.getConnection().prepareStatement(query);
            ps.setInt(1, carId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Car(
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
                );
            }
        } catch (SQLException ex) {
            Logger.getLogger(CarDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public int getTotalCarCount() {
        String query = "SELECT COUNT(*) FROM Car";
        try {
            PreparedStatement ps = this.getConnection().prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(CarDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }
    
    public boolean addCar(Car car) {
        String query = "INSERT INTO Car (car_name, car_brand, model, car_price, car_year, car_img, car_stock, car_odo, fuel_type, displacement, category_id) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement ps = this.getConnection().prepareStatement(query);
            ps.setString(1, car.getCarName());
            ps.setString(2, car.getCarBrand());
            ps.setString(3, car.getModel());
            ps.setBigDecimal(4, car.getCarPrice());
            ps.setDate(5, car.getCarYear());
            ps.setString(6, car.getCarImg());
            ps.setInt(7, car.getCarStock());
            ps.setBigDecimal(8, car.getCarOdo());
            ps.setString(9, car.getFuelType());
            ps.setBigDecimal(10, car.getDisplacement());
            ps.setInt(11, car.getCategoryId());
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException ex) {
            Logger.getLogger(CarDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }
    
    public boolean updateCar(Car car) {
        String query = "UPDATE Car SET car_name = ?, car_brand = ?, model = ?, car_price = ?, car_year = ?, "
                + "car_img = ?, car_stock = ?, car_odo = ?, fuel_type = ?, displacement = ?, category_id = ? "
                + "WHERE car_id = ?";
        try {
            PreparedStatement ps = this.getConnection().prepareStatement(query);
            ps.setString(1, car.getCarName());
            ps.setString(2, car.getCarBrand());
            ps.setString(3, car.getModel());
            ps.setBigDecimal(4, car.getCarPrice());
            ps.setDate(5, car.getCarYear());
            ps.setString(6, car.getCarImg());
            ps.setInt(7, car.getCarStock());
            ps.setBigDecimal(8, car.getCarOdo());
            ps.setString(9, car.getFuelType());
            ps.setBigDecimal(10, car.getDisplacement());
            ps.setInt(11, car.getCategoryId());
            ps.setInt(12, car.getCarId());
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException ex) {
            Logger.getLogger(CarDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }
    
    public boolean deleteCar(int carId) {
        String query = "DELETE FROM Car WHERE car_id = ?";
        try {
            PreparedStatement ps = this.getConnection().prepareStatement(query);
            ps.setInt(1, carId);
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException ex) {
            Logger.getLogger(CarDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }
    
    public ArrayList<String> getAllBrands() {
        ArrayList<String> brands = new ArrayList<>();
        String query = "SELECT DISTINCT car_brand FROM Car ORDER BY car_brand";
        try {
            PreparedStatement ps = this.getConnection().prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                brands.add(rs.getString("car_brand"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(CarDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return brands;
    }
}
