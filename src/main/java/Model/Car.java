/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.math.BigDecimal;
import java.sql.Date;

public class Car {

    private int carId;
    private String carName;
    private String carBrand;
    private String model;
    private BigDecimal carPrice;
    private Date carYear;
    private String carImg;
    private int carStock;
    private BigDecimal carOdo;
    private String fuelType;
    private BigDecimal displacement;
    private String carType;
    private int categoryId;

    // Constructors
    public Car() {
    }

    public Car(int carId, String carName, String carBrand, String model, BigDecimal carPrice, Date carYear,
            String carImg, int carStock, BigDecimal carOdo, String fuelType, BigDecimal displacement, int categoryId) {
        this.carId = carId;
        this.carName = carName;
        this.carBrand = carBrand;
        this.model = model;
        this.carPrice = carPrice;
        this.carYear = carYear;
        this.carImg = carImg;
        this.carStock = carStock;
        this.carOdo = carOdo;
        this.fuelType = fuelType;
        this.displacement = displacement;
        this.categoryId = categoryId;
    }

    public int getCarId() {
        return carId;
    }

    public void setCarId(int carId) {
        this.carId = carId;
    }

    public String getCarName() {
        return carName;
    }

    public void setCarName(String carName) {
        this.carName = carName;
    }

    public String getCarBrand() {
        return carBrand;
    }

    public void setCarBrand(String carBrand) {
        this.carBrand = carBrand;
    }

    public String getModel() {
        return model;
    }

    public void setModel(String model) {
        this.model = model;
    }

    public BigDecimal getCarPrice() {
        return carPrice;
    }

    public void setCarPrice(BigDecimal carPrice) {
        this.carPrice = carPrice;
    }

    public Date getCarYear() {
        return carYear;
    }

    public void setCarYear(Date carYear) {
        this.carYear = carYear;
    }

    public String getCarImg() {
        return carImg;
    }

    public void setCarImg(String carImg) {
        this.carImg = carImg;
    }

    public int getCarStock() {
        return carStock;
    }

    public void setCarStock(int carStock) {
        this.carStock = carStock;
    }

    public BigDecimal getCarOdo() {
        return carOdo;
    }

    public void setCarOdo(BigDecimal carOdo) {
        this.carOdo = carOdo;
    }

    public String getFuelType() {
        return fuelType;
    }

    public void setFuelType(String fuelType) {
        this.fuelType = fuelType;
    }

    public BigDecimal getDisplacement() {
        return displacement;
    }

    public void setDisplacement(BigDecimal displacement) {
        this.displacement = displacement;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    
}
