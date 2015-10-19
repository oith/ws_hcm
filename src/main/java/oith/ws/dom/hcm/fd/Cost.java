package oith.ws.dom.hcm.fd;

import javax.validation.constraints.NotNull;
import oith.ws.dom.core.AbstDocAudit;
import oith.ws.dom.core.User;
import oith.ws.dom.hcm.core.Period;
import org.springframework.data.mongodb.core.mapping.DBRef;
import org.springframework.data.mongodb.core.mapping.Document;

@Document(collection = "Cost")
public class Cost extends AbstDocAudit {

    @NotNull
    @DBRef
    private Mess mess;
    @NotNull
    @DBRef
    private Period period;
    @NotNull
    private Double cost;

    public Cost(User user) {
        super(user);
    }

    public Mess getMess() {
        return mess;
    }

    public void setMess(Mess mess) {
        this.mess = mess;
    }

    public Period getPeriod() {
        return period;
    }

    public void setPeriod(Period period) {
        this.period = period;
    }

    public Double getCost() {
        return cost;
    }

    public void setCost(Double cost) {
        this.cost = cost;
    }

}
