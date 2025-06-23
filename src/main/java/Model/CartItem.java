package Model;

import java.math.BigDecimal;

public class CartItem {
    private int id;
    private Car car;
    private int quantity;
    private BigDecimal price;
    
    public CartItem() {
    }
    
    public CartItem(int id, Car car, int quantity, BigDecimal price) {
        this.id = id;
        this.car = car;
        this.quantity = quantity;
        this.price = price;
    }
    
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public Car getCar() {
        return car;
    }
    
    public void setCar(Car car) {
        this.car = car;
    }
    
    public int getQuantity() {
        return quantity;
    }
    
    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
    
    public BigDecimal getPrice() {
        return price;
    }
    
    public void setPrice(BigDecimal price) {
        this.price = price;
    }
    
    public BigDecimal getTotalPrice() {
        return price.multiply(new BigDecimal(quantity));
    }
} 