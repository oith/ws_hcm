package oith.ws.dom.acad;

import javax.validation.constraints.NotNull;

public class PaymentMobileBased extends Payment {

    @NotNull
    private String serviceName;//bikash
    @NotNull
    private String cellNo;
    private String status;

    public String getServiceName() {
        return serviceName;
    }

    public void setServiceName(String serviceName) {
        this.serviceName = serviceName;
    }

    public String getCellNo() {
        return cellNo;
    }

    public void setCellNo(String cellNo) {
        this.cellNo = cellNo;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

}
