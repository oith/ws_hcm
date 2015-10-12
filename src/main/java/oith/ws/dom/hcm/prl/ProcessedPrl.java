package oith.ws.dom.hcm.prl;

import oith.ws.dom.hcm.core.Period;
import javax.validation.constraints.NotNull;
import org.springframework.data.mongodb.core.mapping.Document;
import oith.ws.dom.core.AbstDocProcessAudit;
import oith.ws.dom.hcm.pmis.Emp;
import org.springframework.data.mongodb.core.mapping.DBRef;

@Document(collection = "ProcessedPrl")
public class ProcessedPrl extends AbstDocProcessAudit {

    @NotNull
    @DBRef
    private Emp emp;

    @NotNull
    @DBRef
    private Period period;

    private Double netPay;

    public Double getNetPay() {
        return netPay;
    }

    public void setNetPay(Double netPay) {
        this.netPay = netPay;
    }

    public Emp getEmp() {
        return emp;
    }

    public void setEmp(Emp emp) {
        this.emp = emp;
    }

    public Period getPeriod() {
        return period;
    }

    public void setPeriod(Period period) {
        this.period = period;
    }

}
