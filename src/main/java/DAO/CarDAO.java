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
 * @author 
 */
public class CarDAO extends DBContext {
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
        return null; 
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
        String query = "INSERT INTO Car (car_id, car_name, car_brand, model, car_price, car_year, car_img, car_stock, car_odo, fuel_type, displacement, category_id) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement ps = this.getConnection().prepareStatement(query);
            ps.setInt(1, car.getCarId());
            ps.setString(2, car.getCarName());
            ps.setString(3, car.getCarBrand());
            ps.setString(4, car.getModel());
            ps.setBigDecimal(5, car.getCarPrice());
            ps.setDate(6, car.getCarYear());
            ps.setString(7, car.getCarImg());
            ps.setInt(8, car.getCarStock());
            ps.setBigDecimal(9, car.getCarOdo());
            ps.setString(10, car.getFuelType());
            ps.setBigDecimal(11, car.getDisplacement());
            ps.setInt(12, car.getCategoryId());
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
            
            if (brands.isEmpty()) {
                brands.add("Toyota");
                brands.add("Honda");
                brands.add("BMW");
                brands.add("Mercedes-Benz");
                brands.add("Audi");
                brands.add("Ford");
                brands.add("Hyundai");
            }
        } catch (SQLException ex) {
            Logger.getLogger(CarDAO.class.getName()).log(Level.SEVERE, null, ex);
            brands.add("Toyota");
            brands.add("Honda");
            brands.add("BMW");
            brands.add("Mercedes-Benz");
            brands.add("Audi");
        }
        return brands;
    }

    public ArrayList<Car> getCarsByCategory(String category) {
        ArrayList<Car> cars = new ArrayList<>();
        String query = "SELECT * FROM Car WHERE category_id = (SELECT category_id FROM Category WHERE category_name = ?)";
        try {
            PreparedStatement ps = this.getConnection().prepareStatement(query);
            ps.setString(1, category);
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
    
    public ArrayList<Car> getCarsByBrand(String brand) {
        ArrayList<Car> cars = new ArrayList<>();
        String query = "SELECT * FROM Car WHERE car_brand = ?";
        try {
            PreparedStatement ps = this.getConnection().prepareStatement(query);
            ps.setString(1, brand);
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
    
    public ArrayList<Car> getCarsByFuelType(String fuelType) {
        ArrayList<Car> cars = new ArrayList<>();
        String query = "SELECT * FROM Car WHERE fuel_type = ?";
        try {
            PreparedStatement ps = this.getConnection().prepareStatement(query);
            ps.setString(1, fuelType);
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
    
    public ArrayList<String> getAllCategories() {
        ArrayList<String> categories = new ArrayList<>();
        String query = "SELECT category_name FROM Category ORDER BY category_name";
        try {
            PreparedStatement ps = this.getConnection().prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                categories.add(rs.getString("category_name"));
            }
            
            if (categories.isEmpty()) {
                categories.add("Sedan");
                categories.add("SUV");
                categories.add("Hatchback");
                categories.add("Truck");
                categories.add("Luxury");
            }
        } catch (SQLException ex) {
            Logger.getLogger(CarDAO.class.getName()).log(Level.SEVERE, null, ex);
            categories.add("Sedan");
            categories.add("SUV");
            categories.add("Hatchback");
            categories.add("Sports Car");
        }
        return categories;
    }

    public ArrayList<Car> getPaginatedCars(int page, int itemsPerPage) {
        ArrayList<Car> cars = new ArrayList<>();
        int offset = (page - 1) * itemsPerPage;
        String query = "SELECT * FROM Car ORDER BY car_id OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try {
            PreparedStatement ps = this.getConnection().prepareStatement(query);
            ps.setInt(1, offset);
            ps.setInt(2, itemsPerPage);
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

    public ArrayList<Car> getCarsByYearRange(int startYear, int endYear) {
        ArrayList<Car> cars = new ArrayList<>();
        String query = "SELECT * FROM Car WHERE YEAR(car_year) BETWEEN ? AND ?";
        try {
            PreparedStatement ps = this.getConnection().prepareStatement(query);
            ps.setInt(1, startYear);
            ps.setInt(2, endYear);
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

    public ArrayList<Car> getCarsByPriceRange(double minPrice, double maxPrice) {
        ArrayList<Car> cars = new ArrayList<>();
        String query = "SELECT * FROM Car WHERE car_price BETWEEN ? AND ?";
        try {
            PreparedStatement ps = this.getConnection().prepareStatement(query);
            ps.setDouble(1, minPrice);
            ps.setDouble(2, maxPrice);
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

    /**
     * Tìm kiếm xe theo từ khóa
     * @param keyword Từ khóa tìm kiếm
     * @return Danh sách xe phù hợp với từ khóa
     */
    public ArrayList<Car> searchCars(String keyword) {
        ArrayList<Car> cars = new ArrayList<>();
        String query = "SELECT * FROM Car WHERE car_name LIKE ? OR car_brand LIKE ? OR model LIKE ?";
        
        try {
            PreparedStatement ps = this.getConnection().prepareStatement(query);
            String searchPattern = "%" + keyword + "%";
            ps.setString(1, searchPattern);
            ps.setString(2, searchPattern);
            ps.setString(3, searchPattern);
            
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
            rs.close();
            ps.close();
        } catch (SQLException ex) {
            Logger.getLogger(CarDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return cars;
    }
    
    /**
     * @param carId ID của xe
     * @param categoryName Tên category
     * @return true nếu xe thuộc category, false nếu không
     */
    public boolean isCarInCategory(int carId, String categoryName) {
        String query = "SELECT COUNT(*) FROM Car c JOIN Category cat ON c.category_id = cat.category_id " +
                      "WHERE c.car_id = ? AND cat.category_name = ?";
        try {
            PreparedStatement ps = this.getConnection().prepareStatement(query);
            ps.setInt(1, carId);
            ps.setString(2, categoryName);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int count = rs.getInt(1);
                rs.close();
                ps.close();
                return count > 0;
            }
            rs.close();
            ps.close();
        } catch (SQLException ex) {
            Logger.getLogger(CarDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    // Lấy danh sách xe ngẫu nhiên, loại trừ 1 xe theo id
    public ArrayList<Car> getRandomCarsExcept(int limit, int excludeCarId) {
        ArrayList<Car> cars = new ArrayList<>();
        String query = "SELECT TOP (?) * FROM Car WHERE car_id <> ? ORDER BY NEWID()";
        try {
            PreparedStatement ps = this.getConnection().prepareStatement(query);
            ps.setInt(1, limit);
            ps.setInt(2, excludeCarId);
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

    public int getMaxCarId() {
        int maxId = 0;
        String query = "SELECT ISNULL(MAX(car_id), 0) FROM Car";
        try {
            PreparedStatement ps = this.getConnection().prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                maxId = rs.getInt(1);
            }
            rs.close();
            ps.close();
        } catch (SQLException ex) {
            Logger.getLogger(CarDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return maxId;
    }
}
