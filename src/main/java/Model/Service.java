/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.time.LocalDateTime;

/**
 *
 * @author thien
 */
public class Service {
    private int serviceId;
    private String serviceName;
    private String serviceDescription;
    private BigDecimal servicePrice;
    private LocalDateTime estimateTime;
    private String serviceImg;

    // Constructor, getters, setters

    public int getServiceId() {
        return serviceId;
    }

    public void setServiceId(int serviceId) {
        this.serviceId = serviceId;
    }

    public String getServiceName() {
        return serviceName;
    }

    public void setServiceName(String serviceName) {
        this.serviceName = serviceName;
    }

    public String getServiceDescription() {
        return serviceDescription;
    }

    public void setServiceDescription(String serviceDescription) {
        this.serviceDescription = serviceDescription;
    }

    public BigDecimal getServicePrice() {
        return servicePrice;
    }

    public void setServicePrice(BigDecimal servicePrice) {
        this.servicePrice = servicePrice;
    }

    public LocalDateTime getEstimateTime() {
        return estimateTime;
    }

    public void setEstimateTime(LocalDateTime estimateTime) {
        this.estimateTime = estimateTime;
    }

    public String getServiceImg() {
        return serviceImg;
    }

    public void setServiceImg(String serviceImg) {
        this.serviceImg = serviceImg;
    }
    
}
