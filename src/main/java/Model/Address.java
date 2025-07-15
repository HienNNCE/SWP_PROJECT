/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

public class Address {
    private int addressId;
    private int userId;
    private String addressName;
    private String addressDetails;
    private String phone;
    private boolean isDefault;

    // Constructor
    public Address() {}

    public Address(int addressId, int userId, String addressName, String addressDetails, String phone, boolean isDefault) {
        this.addressId = addressId;
        this.userId = userId;
        this.addressName = addressName;
        this.addressDetails = addressDetails;
        this.phone = phone;
        this.isDefault = isDefault;
    }

    // Getters and Setters
    public int getAddressId() { return addressId; }
    public void setAddressId(int addressId) { this.addressId = addressId; }
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    public String getAddressName() { return addressName; }
    public void setAddressName(String addressName) { this.addressName = addressName; }
    public String getAddressDetails() { return addressDetails; }
    public void setAddressDetails(String addressDetails) { this.addressDetails = addressDetails; }
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    public boolean isDefault() { return isDefault; }
    public void setDefault(boolean isDefault) { this.isDefault = isDefault; }

   public boolean getIsDefault() { // Add getter
        return isDefault;
    }

    @Override
    public String toString() {
        return "Address{" +
                "addressId=" + addressId +
                ", userId=" + userId +
                ", addressName='" + addressName + '\'' +
                ", addressDetails='" + addressDetails + '\'' +
                ", phone='" + phone + '\'' +
                ", isDefault=" + isDefault +
                '}';
    }
}
