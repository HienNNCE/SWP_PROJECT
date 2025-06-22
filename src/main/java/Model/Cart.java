package Model;

import java.math.BigDecimal;

public class Cart {
    private int cartId;
    private int userId;
    private int countItem;
    private BigDecimal cartPrice;

    // Bổ sung nếu muốn hiển thị chi tiết part trong cart
    private Integer partId; // Optional, nếu cần trong DAO (không nên nằm trong bản chất Cart, nhưng OK nếu tiện xử lý dữ liệu)

    // Constructors
    public Cart() {}

    public Cart(int cartId, int userId, int countItem, BigDecimal cartPrice) {
        this.cartId = cartId;
        this.userId = userId;
        this.countItem = countItem;
        this.cartPrice = cartPrice;
    }

    public Cart(int cartId, int userId, int countItem, BigDecimal cartPrice, int partId) {
        this.cartId = cartId;
        this.userId = userId;
        this.countItem = countItem;
        this.cartPrice = cartPrice;
        this.partId = partId;
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

    public Integer getPartId() {
        return partId;
    }

    public void setPartId(Integer partId) {
        this.partId = partId;
    }

    @Override
    public String toString() {
        return "Cart{" +
                "cartId=" + cartId +
                ", userId=" + userId +
                ", countItem=" + countItem +
                ", cartPrice=" + cartPrice +
                ", partId=" + partId +
                '}';
    }
}
