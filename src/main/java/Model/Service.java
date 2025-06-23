package Model;

import java.math.BigDecimal;
import java.time.LocalDateTime;

public class Service {
    private int serviceId;
    private String serviceName;
    private String serviceDescription;
    private BigDecimal servicePrice;
    private LocalDateTime estimateTime;
    private String serviceImg;
    private String serviceType;    // loại: luxury, new, used, sport…

    public Service() {}

    public Service(int serviceId, String serviceName, String serviceDescription,
                   BigDecimal servicePrice, LocalDateTime estimateTime,
                   String serviceImg, String serviceType) {
        this.serviceId = serviceId;
        this.serviceName = serviceName;
        this.serviceDescription = serviceDescription;
        this.servicePrice = servicePrice;
        this.estimateTime = estimateTime;
        this.serviceImg = serviceImg;
        this.serviceType = serviceType;
    }

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

    public String getServiceType() {
        return serviceType;
    }
    public void setServiceType(String serviceType) {
        this.serviceType = serviceType;
    }
}
