package oith.ws.dom.hcm.prl;

import oith.ws.dom.hcm.pmis.Grade;
import oith.ws.dom.hcm.core.AbstEmpAttach;
import java.util.Date;
import javax.validation.constraints.NotNull;
import oith.ws.dom.core.IPeriodical;
import org.springframework.data.mongodb.core.mapping.Document;

@Document(collection = "AssignmentPrl")
public class AssignmentPrl extends AbstEmpAttach implements IPeriodical{

    public Grade getGrade() {
        return grade;
    }

    public void setGrade(Grade grade) {
        this.grade = grade;
    }

    public enum PayStatus {

        HOLD,
        HALF_SAL,
        FULL
    }
    
    
    private Grade grade;
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

    public Double getGross() {
        return gross;
    }

    public void setGross(Double gross) {
        this.gross = gross;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

  
}
