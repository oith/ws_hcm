package oith.ws.dom.hcm.prl;

import oith.ws.dom.hcm.core.AbstEmpAttach;
import java.util.Date;
import javax.validation.constraints.NotNull;
import oith.ws.dom.core.IPeriodical;
import oith.ws.dom.core.User;
import oith.ws.dom.core.hrm.msl.Grade;
import oith.ws.dom.core.hrm.om.Emp;
import org.springframework.data.mongodb.core.mapping.Document;

@Document(collection = "AssignmentPrl")
public class AssignmentPrl extends AbstEmpAttach implements IPeriodical {

    public AssignmentPrl(User user, Emp emp) {
        super(user, emp);
    }

    public static enum Payroll {

        CORPORATE,
        WORKER
    }

    public static enum PayStatus {

        HOLD,
        HALF_SAL,
        FULL
    }

    private Payroll payroll;
   // private Grade grade;
    private Double basic;
    private Double gross;
    @NotNull
    private Date startDate;
    private Date endDate;

    public Double getBasic() {
        return basic;
    }

    public void setBasic(Double basic) {
        this.basic = basic;
    }

    public Payroll getPayroll() {
        return payroll;
    }

    public void setPayroll(Payroll payroll) {
        this.payroll = payroll;
    }

    public Double getGross() {
        return gross;
    }

    public void setGross(Double gross) {
        this.gross = gross;
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
