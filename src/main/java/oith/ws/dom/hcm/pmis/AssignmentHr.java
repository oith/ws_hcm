package oith.ws.dom.hcm.pmis;

import oith.ws.dom.hcm.core.AbstEmpAttach;
import java.util.Date;
import javax.validation.constraints.NotNull;
import oith.ws.dom.core.IPeriodical;
import org.springframework.data.mongodb.core.mapping.DBRef;
import org.springframework.data.mongodb.core.mapping.Document;

@Document(collection = "AssignmentHr")
public class AssignmentHr extends AbstEmpAttach implements IPeriodical{

    public static enum EmpCat {

        CASUAL,
        CONTRACTUAL,
        DEPUTATIONIST,
        PERMANENT,
        PROBATIONARY,
        SUBSTITUTE,
        TEMPORARY,
        TRAINEE_APPRENTICE
    }

    
    @NotNull
    @DBRef
    private Position position;
    @NotNull
    private Date startDate;
    private Date endDate;
    @NotNull
    private EmpCat empCat;

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

    public EmpCat getEmpCat() {
        return empCat;
    }

    public void setEmpCat(EmpCat empCat) {
        this.empCat = empCat;
    }

}