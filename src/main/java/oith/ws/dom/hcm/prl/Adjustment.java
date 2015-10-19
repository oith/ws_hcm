package oith.ws.dom.hcm.prl;

import oith.ws.dom.hcm.core.AbstEmpAttach;
import java.util.Date;
import javax.validation.constraints.NotNull;
import oith.ws.dom.core.IPeriodical;
import oith.ws.dom.core.User;
import oith.ws.dom.hcm.pmis.Emp;
import org.springframework.data.mongodb.core.mapping.DBRef;
import org.springframework.data.mongodb.core.mapping.Document;

@Document(collection = "Adjustment")
public class Adjustment extends AbstEmpAttach implements IPeriodical {

    @NotNull
    @DBRef
    Element element;
    @NotNull
    private Double amount;
    @NotNull
    private Date startDate;
    private Date endDate;
    private String remarks;

    public Adjustment(User user, Emp emp) {
        super(user, emp);
    }

    @Override
    public Date getStartDate() {
        return startDate;
    }

    @Override
    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    @Override
    public Date getEndDate() {
        return endDate;
    }

    @Override
    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

}
