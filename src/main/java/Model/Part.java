/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.math.BigDecimal;

public class Part {
    private int partId;
    private String partName;
    private String partBrand;
    private String carModel;
    private String description;
    private String partImg;
    private int partStock;
    private BigDecimal partPrice;
    private Part part;
    // Thêm cho giỏ hàng
    private int quantityInCart;                       
    private BigDecimal totalPrice;

    // Constructors
    public Part() {
    }

    public Part(int partId, String partName, String partBrand, String carModel, String description, String partImg,
            int partStock, BigDecimal partPrice) {
        this.partId = partId;
        this.partName = partName;
        this.partBrand = partBrand;
        this.carModel = carModel;
        this.description = description;
        this.partImg = partImg;
        this.partStock = partStock;
        this.partPrice = partPrice;
    }

    // Getter & Setter cho các trường cũ

    public void setPartId(int partId) {
        this.partId = partId;
    }

    public int getPartId() {
        return partId;
    }

    public Part getPart() {
        return part;
    }

    public void setPart(Part part) {
        this.part = part;
    }

    public String getPartName() {
        return partName;
    }

    public void setPartName(String partName) {
        this.partName = partName;
    }

    public String getPartBrand() {
        return partBrand;
    }

    public void setPartBrand(String partBrand) {
        this.partBrand = partBrand;
    }

    public String getCarModel() {
        return carModel;
    }

    public void setCarModel(String carModel) {
        this.carModel = carModel;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getPartImg() {
        return partImg;
    }

    public void setPartImg(String partImg) {
        this.partImg = partImg;
    }

    public int getPartStock() {
        return partStock;
    }

    public void setPartStock(int partStock) {
        this.partStock = partStock;
    }

    public BigDecimal getPartPrice() {
        return partPrice;
    }

    public void setPartPrice(BigDecimal partPrice) {
        this.partPrice = partPrice;
    }

    // Getter & Setter cho quantityInCart và totalPrice
    public int getQuantityInCart() {
        return quantityInCart;
    }

    public void setQuantityInCart(int quantityInCart) {
        this.quantityInCart = quantityInCart;
    }

    public BigDecimal getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(BigDecimal totalPrice) {
        this.totalPrice = totalPrice;
    }
}
