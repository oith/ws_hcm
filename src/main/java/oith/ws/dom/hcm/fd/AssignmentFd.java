package oith.ws.dom.hcm.fd;

import oith.ws.dom.hcm.core.AbstEmpAttach;
import java.util.Date;
import javax.validation.constraints.NotNull;
import oith.ws.dom.core.IPeriodical;
import org.springframework.data.mongodb.core.mapping.DBRef;
import org.springframework.data.mongodb.core.mapping.Document;

@Document(collection = "AssignmentFd")
public class AssignmentFd extends AbstEmpAttach implements IPeriodical {

    @NotNull
    @DBRef
    private Mess mess;
    @NotNull
    private Date startDate;
    private Date endDate;

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

    public Mess getMess() {
        return mess;
    }

    public void setMess(Mess mess) {
        this.mess = mess;
    }

}
