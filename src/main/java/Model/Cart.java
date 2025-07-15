package Model;

import java.math.BigDecimal;
import java.util.List;

public class Cart {
    private int cartId;
    private int userId;
    private int countItem;
    private BigDecimal cartPrice;
    private int partId;
    private List<Part> partList;
    private int partStock;
    public jakarta.mail.Part[] getPartList;

    // Constructors
    public Cart() {
    }

    public Cart(int cartId, int userId, int countItem, BigDecimal cartPrice, List<Part> partList, int partStock) {
        this.cartId = cartId;
        this.userId = userId;
        this.countItem = countItem;
        this.cartPrice = cartPrice;
        this.partList = partList;
        this.partStock = partStock;
    }

    public int getPartId() {
        return partId;
    }

    public void setPartId(int partId) {
        this.partId = partId;
    }

    public int getPartStock() {
        return partStock;
    }

    public void setPartStock(int partStock) {
        this.partStock = partStock;
    }

    public Cart(int cartId, int userId, int countItem, BigDecimal cartPrice, int partId) {
        this.cartId = cartId;
        this.userId = userId;
        this.countItem = countItem;
        this.cartPrice = cartPrice;
        this.partId = partId;
    }

    public Cart(int cartId, int userId, int countItem, BigDecimal cartPrice) {
        this.cartId = cartId;
        this.userId = userId;
        this.countItem = countItem;
        this.cartPrice = cartPrice;
    }

    // Getters and Setters
    public int getCartId() {
        return cartId;
    }

    public void setCartId(int cartId) {
        this.cartId = cartId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getCountItem() {
        return countItem;
    }

    public void setCountItem(int countItem) {
        this.countItem = countItem;
    }

    public BigDecimal getCartPrice() {
        return cartPrice;
    }

    public void setCartPrice(BigDecimal cartPrice) {
        this.cartPrice = cartPrice;
    }

    public List<Part> getPartList() {
        return partList;
    }

    public void setPartList(List<Part> partList) {
        this.partList = partList;
    }

    @Override
    public String toString() {
        return "Cart{" +
                "cartId=" + cartId +
                ", userId=" + userId +
                ", countItem=" + countItem +
                ", cartPrice=" + cartPrice +
                ", partList=" + partList +
                '}';
    }
}
